Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98F185F20C5
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Oct 2022 02:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbiJBAjk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 1 Oct 2022 20:39:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiJBAjj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 1 Oct 2022 20:39:39 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EA22B54;
        Sat,  1 Oct 2022 17:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DWqnEgEeKqBMpxSdW4DJ9r0DsI8KX/ZBJYht6Apdh5Q=; b=WjUAn4cNLaJ4x4Z0t1U4hg1/6z
        c8bd/8lr907LXhwJ37N5EsSAjmeK7luMyuRYZcqtCIFCcVkRTCYZex+xAy7kqX14BeBdWi5WzBwxm
        fF2nG5l1fIjmX6E7lbIOxGEVqzicBm4o3lc8W60Do+81VHZmrldeU9fuVKN1dF88JZPFm2Kmk2PrY
        tx5+Sd8XoHeSybGbMLcRgM/Kaly7itXB7A46+R56I6NnKvo3Kr2zDRURkEoPOqUDZTfYmVbt/WYms
        DAErxo5XqAL2gB01THHmOzePOF/aQR53DnB0AR3YqfnxNsAsVJ7HgQtKPTkDnPqTGrkuxZvNSrtAi
        1FWyJBfw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1oen14-005olm-22;
        Sun, 02 Oct 2022 00:39:34 +0000
Date:   Sun, 2 Oct 2022 01:39:34 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Namjae Jeon <linkinjeon@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-cifs@vger.kernel.org,
        smfrench@gmail.com, senozhatsky@chromium.org, tom@talpey.com,
        atteh.mailbox@gmail.com
Subject: Re: [PATCH v7 3/3] ksmbd: fix racy issue from using ->d_parent and
 ->d_name
Message-ID: <Yzjdxr64MUoCASTH@ZenIV>
References: <20220920224338.22217-1-linkinjeon@kernel.org>
 <20220920224338.22217-4-linkinjeon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220920224338.22217-4-linkinjeon@kernel.org>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 21, 2022 at 07:43:38AM +0900, Namjae Jeon wrote:


> -int ksmbd_vfs_kern_path(struct ksmbd_work *work, char *name,
> -			unsigned int flags, struct path *path, bool caseless)
> +int ksmbd_vfs_kern_path_locked(struct ksmbd_work *work, char *name,
> +			       unsigned int flags, struct path *path,
> +			       bool caseless)
>  {
>  	struct ksmbd_share_config *share_conf = work->tcon->share_conf;
>  	int err;
> +	struct path parent_path;
>  
> +	err = ksmbd_vfs_path_parent_lookup(share_conf, name, flags,
> +					   &parent_path);
>  	flags |= LOOKUP_BENEATH;
> -	err = vfs_path_lookup(share_conf->vfs_path.dentry,
> -			      share_conf->vfs_path.mnt,
> -			      name,
> -			      flags,
> -			      path);
> -	if (!err)
> -		return 0;
> +	if (!err) {
> +		err = vfs_path_lookup(share_conf->vfs_path.dentry,
> +				      share_conf->vfs_path.mnt,
> +				      name,
> +				      flags,
> +				      path);
> +		if (!err)
> +			goto lock_parent;
> +		path_put(&parent_path);

This is wrong.  You have already resolved the sucker to parent
+ last component.  Now you ask vfs_path_lookup() to
	* redo the same thing, hopefully arriving to the same
	  spot.
	* look the last component up in wherever it has arrived.
then you
	* lock the place you'd originally arrived at
	* check if the result of last lookup is its child (i.e.
it hadn't moved since we looked it up and lookup hopefully
arrived to the same spot for parent.

That's far too convoluted...
