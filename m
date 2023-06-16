Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD535733CEE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Jun 2023 01:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234028AbjFPXds (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Jun 2023 19:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345621AbjFPXdq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Jun 2023 19:33:46 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D57C23599
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jun 2023 16:33:45 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1b5422163f4so2262095ad.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jun 2023 16:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1686958425; x=1689550425;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U/w1QRwSSUJhMK/ng7sY3jpzNT0SsOCXjC+qwGniCZk=;
        b=HeL6ByUbaMwV3X3W6Kh9d8Q2wC6VmHDFNqrhQCZLdYTiZsbboGCbmnntw2izK5UjoL
         O2oa+PF/R14M03no0dRmrGGqADwDySRSTZwbZl37+w3Je5SZkQ1lqMMQRYgFGBHCoOjk
         5KJYJqFhZsCbye/4DfI+po25I2Lp9fQAM9oAb6z5pW8KYCNm5ma0Ifo/rf39VRwhIJY6
         rfUw8t+GKYhn6tQaAGx2Q8fue2xTH0PIHkqZZ47LR0nJrglDgCmuhywsDnoBosF9wcHO
         auzvLaRCyptZe+izNOE3ecYUuQEtt7igFkesu5XcN4ut0K2clhIW543mBrH7UPrFcadx
         942Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686958425; x=1689550425;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U/w1QRwSSUJhMK/ng7sY3jpzNT0SsOCXjC+qwGniCZk=;
        b=ch8l+m2G7o7cJcqV32wIvl4uN5oftc/MkVjxbjBD1n1+lSpEKTXD46EI0+ezwf3f5A
         ZmBshi7PDL12LE6CnsTBQR4nctUf/4qvpZrsZ8o3qYgilOKCoqqEK6rawyxTI50QOfLP
         dvcxb0R7WGzXZIi6tM8c8gW7UWhQ/mTN7hrL20ALXyPRWs3QZO3AoxHvDgkWpYn0Xo4O
         Fq7DDOxBoZhpK3L+mS+RPuJSVZIK3J/bVzFSfvm7aS6dS+MtnuNRKhyQ1RQitQnbDHvH
         ww85Bcm5rVUPdPqOJoOMA/prtiQ2VjztETS31w8tn4Z+crchtTV7lB6PKLXcCgUuPM13
         ds1A==
X-Gm-Message-State: AC+VfDxhfjrDPz1qtAXb3AumfnTY4qnM7WaJCxGVIHChofEXv0qV6D7D
        v1AuPDLNyITkD97GpRsPW2UgyQ==
X-Google-Smtp-Source: ACHHUZ6KSdmlpKG1GcMU8tEeKQ8EGT5taa49TcmtqzTP4SLo5F68n6Q16/baaz4mjVWu0g9737mmFQ==
X-Received: by 2002:a17:902:8bcc:b0:1af:feff:5a70 with SMTP id r12-20020a1709028bcc00b001affeff5a70mr3007089plo.11.1686958425074;
        Fri, 16 Jun 2023 16:33:45 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-13-202.pa.nsw.optusnet.com.au. [49.180.13.202])
        by smtp.gmail.com with ESMTPSA id h12-20020a170902f54c00b001a1a82fc6d3sm16252293plf.268.2023.06.16.16.33.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jun 2023 16:33:44 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1qAIwo-00CebE-0D;
        Sat, 17 Jun 2023 09:33:42 +1000
Date:   Sat, 17 Jun 2023 09:33:42 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH] fs: Provide helpers for manipulating
 sb->s_readonly_remount
Message-ID: <ZIzxVvLgukjBOBBW@dread.disaster.area>
References: <20230616163827.19377-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230616163827.19377-1-jack@suse.cz>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 16, 2023 at 06:38:27PM +0200, Jan Kara wrote:
> Provide helpers to set and clear sb->s_readonly_remount including
> appropriate memory barriers. Also use this opportunity to document what
> the barriers pair with and why they are needed.
> 
> Suggested-by: Dave Chinner <david@fromorbit.com>
> Signed-off-by: Jan Kara <jack@suse.cz>

The helper conversion looks fine so from that perspective the patch
looks good.

However, I'm not sure the use of memory barriers is correct, though.

IIUC, we want mnt_is_readonly() to return true when ever
s_readonly_remount is set. Is that the behaviour we are trying to
acheive for both ro->rw and rw->ro transactions?

> ---
>  fs/internal.h      | 26 ++++++++++++++++++++++++++
>  fs/namespace.c     | 10 ++++------
>  fs/super.c         | 17 ++++++-----------
>  include/linux/fs.h |  2 +-
>  4 files changed, 37 insertions(+), 18 deletions(-)
> 
> diff --git a/fs/internal.h b/fs/internal.h
> index bd3b2810a36b..01bff3f6db79 100644
> --- a/fs/internal.h
> +++ b/fs/internal.h
> @@ -120,6 +120,32 @@ void put_super(struct super_block *sb);
>  extern bool mount_capable(struct fs_context *);
>  int sb_init_dio_done_wq(struct super_block *sb);
>  
> +/*
> + * Prepare superblock for changing its read-only state (i.e., either remount
> + * read-write superblock read-only or vice versa). After this function returns
> + * mnt_is_readonly() will return true for any mount of the superblock if its
> + * caller is able to observe any changes done by the remount. This holds until
> + * sb_end_ro_state_change() is called.
> + */
> +static inline void sb_start_ro_state_change(struct super_block *sb)
> +{
> +	WRITE_ONCE(sb->s_readonly_remount, 1);
> +	/* The barrier pairs with the barrier in mnt_is_readonly() */
> +	smp_wmb();
> +}

I'm not sure how this wmb pairs with the memory barrier in
mnt_is_readonly() to provide the correct behavior. The barrier in
mnt_is_readonly() happens after it checks s_readonly_remount, so
the s_readonly_remount in mnt_is_readonly is not ordered in any way
against this barrier.

The barrier in mnt_is_readonly() ensures that the loads of SB_RDONLY
and MNT_READONLY are ordered after s_readonly_remount(), but we
don't change those flags until a long way after s_readonly_remount
is set.

Hence if this is a ro->rw transistion, then I can see that racing on
s_readonly_remount being isn't an issue, because the mount/sb
flags will have SB_RDONLY/MNT_READONLY set and the correct thing
will be done (i.e. consider code between sb_start_ro_state_change()
and sb_end_ro_state_change() is RO).

However, it's not obvious (to me, anyway) how this works at all for
a rw->ro transition - if we race on s_readonly_remount being set
then we'll consider the fs to still be read-write regardless of the
smp_rmb() in mnt_is_readonly() because neither SB_RDONLY or
MNT_READONLY are set at this point.

So I can't see what the memory barrier is actually doing for
us here...

What am I missing?

> +/*
> + * Ends section changing read-only state of the superblock. After this function
> + * returns if mnt_is_readonly() returns false, the caller will be able to
> + * observe all the changes remount did to the superblock.
> + */
> +static inline void sb_end_ro_state_change(struct super_block *sb)
> +{
> +	/* The barrier pairs with the barrier in mnt_is_readonly() */
> +	smp_wmb();
> +	WRITE_ONCE(sb->s_readonly_remount, 0);
> +}

This one looks fine - it is providing release semantics,
ensuring that if s_readonly_remount is seen as zero, then the prior
sb/mnt flag changes will be seen by __mnt_is_readonly(mnt). i.e the
smp_rmb() in mnt_is_readonly() is providing acquire side
semantics on the s_readonly_remount access if it returns 0....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
