Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B68675F20B7
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Oct 2022 02:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbiJBAVZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 1 Oct 2022 20:21:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiJBAVX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 1 Oct 2022 20:21:23 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1237553013;
        Sat,  1 Oct 2022 17:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MxJE/8q6fBKXt96GSOzonxeWGwMnsiBPptEg0mB78rU=; b=OORl8h8SNR9WvrWZHRb6tRcBka
        Yef2Ze4rOQarkUPazPiQf5kVxHJBBJln7mkeMkMibuSFD+V2Myb/0dnz/QkFRT5408x8dPbOkb244
        dP7stWp7DeYpW11m2iWouMNf0uVSC7Oxd4OpwYmcrRKqeYpoOn6lsyEs1ciEVjy0VbK2Ih9VlRVw7
        vKwjAyEzH16EvRRGCPVwVyx6NEdfRKPlInHgqVFb3J2xujyipvifBysUbFdSz6/RQpZL4WxX1rR4R
        GGEwuwINaqPh+On/WcpRuI2+fBTc16oRXMKAr0JgArRWidAirsSYrIXzWmEGyVYRvDKQsKgOnRdEF
        38ZJTTyQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1oemjQ-005oUQ-1l;
        Sun, 02 Oct 2022 00:21:20 +0000
Date:   Sun, 2 Oct 2022 01:21:20 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Namjae Jeon <linkinjeon@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-cifs@vger.kernel.org,
        smfrench@gmail.com, senozhatsky@chromium.org, tom@talpey.com,
        atteh.mailbox@gmail.com
Subject: Re: [PATCH v7 2/3] fs: introduce lock_rename_child() helper
Message-ID: <YzjZgB1VL69eGUfK@ZenIV>
References: <20220920224338.22217-1-linkinjeon@kernel.org>
 <20220920224338.22217-3-linkinjeon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220920224338.22217-3-linkinjeon@kernel.org>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 21, 2022 at 07:43:37AM +0900, Namjae Jeon wrote:


FWIW, it probably needs a few comments:

// c1 and p2 should be on the same fs
> +struct dentry *lock_rename_child(struct dentry *c1, struct dentry *p2)
> +{
> +	if (READ_ONCE(c1->d_parent) == p2) {
		// hopefully won't need to touch ->s_vfs_rename_mutex at all.
> +		inode_lock_nested(p2->d_inode, I_MUTEX_PARENT);
		// now that p2 is locked, nobody can move in or out of it,
		// so the test below is safe
> +		if (likely(c1->d_parent == p2))
> +			return NULL;
> +
		// c1 got moved out of p2 while we'd been taking locks;
		// unlock and fall back to slow case
> +		inode_unlock(p2->d_inode);
> +	}
> +
> +	mutex_lock(&c1->d_sb->s_vfs_rename_mutex);
	// nobody can move out of any directories on this fs
> +	if (likely(c1->d_parent != p2))
> +		return lock_two_directories(c1->d_parent, p2);
> +
	// c1 got moved into p2 while we were taking locks;
	// we need p2 locked and ->s_vfs_rename_mutex unlocked,
	// for consistency with lock_rename().
> +	inode_lock_nested(p2->d_inode, I_MUTEX_PARENT);
> +	mutex_unlock(&c1->d_sb->s_vfs_rename_mutex);
> +	return NULL;
> +}
> +EXPORT_SYMBOL(lock_rename_child);
