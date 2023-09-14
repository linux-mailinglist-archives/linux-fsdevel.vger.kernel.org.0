Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 492F779FF6D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Sep 2023 11:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236862AbjINJDV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Sep 2023 05:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236753AbjINJDT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Sep 2023 05:03:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 304AC1FCC;
        Thu, 14 Sep 2023 02:03:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC4E9C433C7;
        Thu, 14 Sep 2023 09:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694682190;
        bh=N3L2pkXgh4YQ+q9kocn04dm6+vzax3CnSl5k5mqxMJc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F1JpLd35kG+k5w2HwrVTXcTYX+6Ji/1OxwtWdQonj2MmciwX9HejiNUqcgcdBlqVc
         7g/ld06TBJyz1O+7tDuQFAIqIbU2cHcENfi5QvVFd8BkJdSEKG5CYBYh6OLSAA3h6b
         woewGTeJ2wdl9ZKnPxb/3RIv9Z71x29qG+gVKhNJwgX6p0o+8PpMtQMh1YP/+5Ps4q
         xdnxukjG1qxW4WxEm9wiuugAbODwIrOF9gnV908DeR7K4rdQhbr6R8M9o2p8uzotvF
         EAHpim4dHU5Up9AAzkLMsMppquUALKM7aa/sLZGaUuBdNzJ7jQdL1+vK4jtDkQQIv8
         4OtoWrDiP/OCw==
Date:   Thu, 14 Sep 2023 11:03:05 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Miklos Szeredi <mszeredi@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-man@vger.kernel.org,
        linux-security-module@vger.kernel.org, Karel Zak <kzak@redhat.com>,
        Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Amir Goldstein <amir73il@gmail.com>
Subject: Re: [RFC PATCH 1/3] add unique mount ID
Message-ID: <20230914-himmel-imposant-546bd73250a8@brauner>
References: <20230913152238.905247-1-mszeredi@redhat.com>
 <20230913152238.905247-2-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230913152238.905247-2-mszeredi@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 13, 2023 at 05:22:34PM +0200, Miklos Szeredi wrote:
> If a mount is released then it's mnt_id can immediately be reused.  This is
> bad news for user interfaces that want to uniquely identify a mount.
> 
> Implementing a unique mount ID is trivial (use a 64bit counter).
> Unfortunately userspace assumes 32bit size and would overflow after the
> counter reaches 2^32.
> 
> Introduce a new 64bit ID alongside the old one.  Allow new interfaces to
> work on both the old and new IDs by starting the counter from 2^32.
> 
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> ---
>  fs/mount.h                | 3 ++-
>  fs/namespace.c            | 4 ++++
>  fs/stat.c                 | 9 +++++++--
>  include/uapi/linux/stat.h | 1 +
>  4 files changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/mount.h b/fs/mount.h
> index 130c07c2f8d2..a14f762b3f29 100644
> --- a/fs/mount.h
> +++ b/fs/mount.h
> @@ -72,7 +72,8 @@ struct mount {
>  	struct fsnotify_mark_connector __rcu *mnt_fsnotify_marks;
>  	__u32 mnt_fsnotify_mask;
>  #endif
> -	int mnt_id;			/* mount identifier */
> +	int mnt_id;			/* mount identifier, reused */
> +	u64 mnt_id_unique;		/* mount ID unique until reboot */
>  	int mnt_group_id;		/* peer group identifier */
>  	int mnt_expiry_mark;		/* true if marked for expiry */
>  	struct hlist_head mnt_pins;
> diff --git a/fs/namespace.c b/fs/namespace.c
> index e157efc54023..de47c5f66e17 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -68,6 +68,9 @@ static u64 event;
>  static DEFINE_IDA(mnt_id_ida);
>  static DEFINE_IDA(mnt_group_ida);
>  
> +/* Don't allow confusion with mount ID allocated wit IDA */
> +static atomic64_t mnt_id_ctr = ATOMIC64_INIT(1ULL << 32);

Hm, is your concern that userspace confuses these two values? If so, I
think we shouldn't worry about this.

If a userspace program retrieves a mntid and then confuses itself about
what mnt id they're talking about something's very wrong anyway. So I'd
rather not see us waste 32 bits just for that. Other than that this
seems to implement what we agreed on at LSFMM so my hope is that this is
fairly uncontroversial.
