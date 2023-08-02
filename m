Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE0A676D489
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Aug 2023 19:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231978AbjHBRCO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Aug 2023 13:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231823AbjHBRCM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Aug 2023 13:02:12 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74A521712
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Aug 2023 10:01:58 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 998101F388;
        Wed,  2 Aug 2023 17:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1690995716; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pyfH9ll175SR0yiyUdnPW7Bh6PtjGN9gyWyojGBWqm0=;
        b=lP2OofVCmIiKMh+DlvruzBxras6i95J6X/tXSyySpY0iw2CxRiNAKx38JUzaC+mCALmsao
        ZOXfP74h8uS2r0norlwZAWZQ5aDZ9m/yyjqnKPy+u0J0TFtgAnnvOyEHFKHCH687nr17D6
        5YDbqGQor/0oUCCYAE5WvUuFsj+zx7Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1690995716;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pyfH9ll175SR0yiyUdnPW7Bh6PtjGN9gyWyojGBWqm0=;
        b=Z/Oik3KmJ6Ctu2Af5rC9HTfauI6WTok3jOriwUTa68Mg6AxnXWcHo3k3xPio918CHUCM9b
        1KpWxlBhFFauPACA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8917913919;
        Wed,  2 Aug 2023 17:01:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ln10IQSMymScWgAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 02 Aug 2023 17:01:56 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 0080BA076B; Wed,  2 Aug 2023 19:01:55 +0200 (CEST)
Date:   Wed, 2 Aug 2023 19:01:55 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>, Karel Zak <kzak@redhat.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC 2/3] fs: add vfs_cmd_create()
Message-ID: <20230802170155.l7sru3projdgsna5@quack3>
References: <20230801-vfs-super-exclusive-v1-0-1a587e56c9f3@kernel.org>
 <20230801-vfs-super-exclusive-v1-2-1a587e56c9f3@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801-vfs-super-exclusive-v1-2-1a587e56c9f3@kernel.org>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 01-08-23 15:09:01, Christian Brauner wrote:
> Split the steps to create a superblock into a tiny helper. This will
> make the next patch easier to follow.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

I agree with Christoph that the error handling in vfs_fsconfig_locked() is
confusing - in particular the fact that if you 'break' out of the switch
statement it causes the fs context to be marked as failed is probably handy
but too subtle to my taste.

Also I think this patch does cause a behavioral change because before if we
bailed e.g. due to:

if (fc->phase != FS_CONTEXT_CREATE_PARAMS)

we returned -EBUSY but didn't set fc->phase = FS_CONTEXT_FAILED. After your
patch we 'break' on any error and thus fc->phase is set on any error...

								Honza

> ---
>  fs/fsopen.c | 45 +++++++++++++++++++++++++++++++--------------
>  1 file changed, 31 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/fsopen.c b/fs/fsopen.c
> index fc9d2d9fd234..af2ff05dcee5 100644
> --- a/fs/fsopen.c
> +++ b/fs/fsopen.c
> @@ -209,6 +209,36 @@ SYSCALL_DEFINE3(fspick, int, dfd, const char __user *, path, unsigned int, flags
>  	return ret;
>  }
>  
> +static int vfs_cmd_create(struct fs_context *fc)
> +{
> +	struct super_block *sb;
> +	int ret;
> +
> +	if (fc->phase != FS_CONTEXT_CREATE_PARAMS)
> +		return -EBUSY;
> +
> +	if (!mount_capable(fc))
> +		return -EPERM;
> +
> +	fc->phase = FS_CONTEXT_CREATING;
> +
> +	ret = vfs_get_tree(fc);
> +	if (ret)
> +		return ret;
> +
> +	sb = fc->root->d_sb;
> +	ret = security_sb_kern_mount(sb);
> +	if (unlikely(ret)) {
> +		fc_drop_locked(fc);
> +		return ret;
> +	}
> +
> +	/* vfs_get_tree() callchains will have grabbed @s_umount */
> +	up_write(&sb->s_umount);
> +	fc->phase = FS_CONTEXT_AWAITING_MOUNT;
> +	return 0;
> +}
> +
>  /*
>   * Check the state and apply the configuration.  Note that this function is
>   * allowed to 'steal' the value by setting param->xxx to NULL before returning.
> @@ -224,22 +254,9 @@ static int vfs_fsconfig_locked(struct fs_context *fc, int cmd,
>  		return ret;
>  	switch (cmd) {
>  	case FSCONFIG_CMD_CREATE:
> -		if (fc->phase != FS_CONTEXT_CREATE_PARAMS)
> -			return -EBUSY;
> -		if (!mount_capable(fc))
> -			return -EPERM;
> -		fc->phase = FS_CONTEXT_CREATING;
> -		ret = vfs_get_tree(fc);
> +		ret = vfs_cmd_create(fc);
>  		if (ret)
>  			break;
> -		sb = fc->root->d_sb;
> -		ret = security_sb_kern_mount(sb);
> -		if (unlikely(ret)) {
> -			fc_drop_locked(fc);
> -			break;
> -		}
> -		up_write(&sb->s_umount);
> -		fc->phase = FS_CONTEXT_AWAITING_MOUNT;
>  		return 0;
>  	case FSCONFIG_CMD_RECONFIGURE:
>  		if (fc->phase != FS_CONTEXT_RECONF_PARAMS)
> 
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
