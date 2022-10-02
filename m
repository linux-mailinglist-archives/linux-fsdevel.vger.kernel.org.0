Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A2A65F2105
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Oct 2022 04:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbiJBCV3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 1 Oct 2022 22:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbiJBCV1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 1 Oct 2022 22:21:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A778C402DB;
        Sat,  1 Oct 2022 19:21:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 70D34B80C83;
        Sun,  2 Oct 2022 02:21:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0321AC433D7;
        Sun,  2 Oct 2022 02:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664677284;
        bh=YH0ShThQ4+0N594gN4ajzeEXXyGCGIdiAzO873H+QA8=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=Dh6klk44xR4BYWWWS6o15pJixIJOlYkgGubL/cSt48C71xhduL89Iw79+8ieSICj+
         WAQEoUgaanfiim0Jbs1w3CrsUgiqI+Mye/BrHo3YY4JbHtNDm95quZut0cPpMbHevk
         7UofM+mFyABhNGyze5BHKAQzgqA3T5DIAXC1rq4KnxAd84tNPDpyMa9L+M7ymTzGmB
         ntREPmYnKIeltTQRo07VDaExP5tIhQhERN4AL7xdNU+9xlJMHBzv/ltL9aYllinXDw
         1sQByeD5nS6i3Gh0Zhb1LIz5mNN7wpI/NC0tYH995dF+pmcsXI9lgh0uWRctuL/CtG
         ToFqDF4hExoKg==
Received: by mail-oo1-f43.google.com with SMTP id c22-20020a4a4f16000000b00474a44441c8so4761778oob.7;
        Sat, 01 Oct 2022 19:21:23 -0700 (PDT)
X-Gm-Message-State: ACrzQf20aeqgyTLkMxkq8FxPlG2A4UNdeYhqdkaK/T3RG52N8mmlVgy0
        9acusUUCSnARVKGMdBuEv8EpnLYWxV+OWmNFkVc=
X-Google-Smtp-Source: AMsMyM7BFsRH8BKKXcnHa8OYkoeqdw8ulx1IQ3sX/yDYdwJSfd536nBXrZdXv6lw7p2pbH7sRoYJ10AOLnmijvbJLvw=
X-Received: by 2002:a9d:5603:0:b0:639:683b:82c7 with SMTP id
 e3-20020a9d5603000000b00639683b82c7mr5852061oti.187.1664677283112; Sat, 01
 Oct 2022 19:21:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6838:27c7:0:0:0:0 with HTTP; Sat, 1 Oct 2022 19:21:22
 -0700 (PDT)
In-Reply-To: <Yzjdxr64MUoCASTH@ZenIV>
References: <20220920224338.22217-1-linkinjeon@kernel.org> <20220920224338.22217-4-linkinjeon@kernel.org>
 <Yzjdxr64MUoCASTH@ZenIV>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Sun, 2 Oct 2022 11:21:22 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8iSiot5Dh19kK_7av9Vqc-TpoPMgJzBHvWF9bsgU-9rg@mail.gmail.com>
Message-ID: <CAKYAXd8iSiot5Dh19kK_7av9Vqc-TpoPMgJzBHvWF9bsgU-9rg@mail.gmail.com>
Subject: Re: [PATCH v7 3/3] ksmbd: fix racy issue from using ->d_parent and ->d_name
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-cifs@vger.kernel.org,
        smfrench@gmail.com, senozhatsky@chromium.org, tom@talpey.com,
        atteh.mailbox@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

2022-10-02 9:39 GMT+09:00, Al Viro <viro@zeniv.linux.org.uk>:
> On Wed, Sep 21, 2022 at 07:43:38AM +0900, Namjae Jeon wrote:
>
>
>> -int ksmbd_vfs_kern_path(struct ksmbd_work *work, char *name,
>> -			unsigned int flags, struct path *path, bool caseless)
>> +int ksmbd_vfs_kern_path_locked(struct ksmbd_work *work, char *name,
>> +			       unsigned int flags, struct path *path,
>> +			       bool caseless)
>>  {
>>  	struct ksmbd_share_config *share_conf = work->tcon->share_conf;
>>  	int err;
>> +	struct path parent_path;
>>
>> +	err = ksmbd_vfs_path_parent_lookup(share_conf, name, flags,
>> +					   &parent_path);
>>  	flags |= LOOKUP_BENEATH;
>> -	err = vfs_path_lookup(share_conf->vfs_path.dentry,
>> -			      share_conf->vfs_path.mnt,
>> -			      name,
>> -			      flags,
>> -			      path);
>> -	if (!err)
>> -		return 0;
>> +	if (!err) {
>> +		err = vfs_path_lookup(share_conf->vfs_path.dentry,
>> +				      share_conf->vfs_path.mnt,
>> +				      name,
>> +				      flags,
>> +				      path);
>> +		if (!err)
>> +			goto lock_parent;
>> +		path_put(&parent_path);
>
> This is wrong.  You have already resolved the sucker to parent
> + last component.  Now you ask vfs_path_lookup() to
> 	* redo the same thing, hopefully arriving to the same
> 	  spot.
> 	* look the last component up in wherever it has arrived.
> then you
> 	* lock the place you'd originally arrived at
> 	* check if the result of last lookup is its child (i.e.
> it hadn't moved since we looked it up and lookup hopefully
> arrived to the same spot for parent.
>
> That's far too convoluted...
Right. Need to avoid repeat lookup.
I have called vfs_path_lookup() again to avoid accessing out of share
and get struct path of child. I may try to change vfs_path_lookup()(or
create new vfs function) to return struct path of parent as well
struct path of child... ?

Thanks for your review!
>
