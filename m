Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2A7773600A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jun 2023 01:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbjFSXQR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Jun 2023 19:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjFSXQQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Jun 2023 19:16:16 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49FCB94
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Jun 2023 16:16:15 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-666683eb028so2203623b3a.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Jun 2023 16:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1687216575; x=1689808575;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tbfdgcMQgaa+shhWje7TjwApo+GmjE+HesfMlB2Sp0g=;
        b=M2kenUWwkGR77vLexJkknbcRBuBG9LskppAsCPsj22aofpp9FiOF+ygqO+AC89cT8s
         SWdv7yRnrLrldC4YnsLH9HCKOxN8a3wSamD4dFePgL4f/QulEfzpn1nu3gDbKua1Fhng
         8t7QUJ4wxLxbicIn3rA0V2ZZpxLHT9JU6vgL+Rq3FD82NLhwvLVnF8QZVZ+n+ihorZmd
         5GDU4nvOek5NvCoWtM54DkRr0yPHunJXpC8PIII2zOmC5Lwd4m+wmwbvXZAF05qBRv7X
         bKIrV3oAvs3P/UzJdZ1B6jomq7i2H5P1gjIuYYx/s7JT3DNs8tl/UzO9PdS0neZRIPqS
         7gnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687216575; x=1689808575;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tbfdgcMQgaa+shhWje7TjwApo+GmjE+HesfMlB2Sp0g=;
        b=NMzaJTeTqbqbtoJpm8Q7DG4Q4njyUxnG/I/DDBZKPqLyO5MLjzHmmik/OwVGFZQjAo
         5TJftmVykM9hX5wE9OIOuYSrk0Zb9PnE61t4UBUWV/7NevYvdTev/M8uiNpoAGgK9ZOG
         x3li043umPumCnDVHx+a9uqSdcNjB6V/Kbc6oRuoUky+8ittageyt0jEGNNzVLu/0UNG
         oWlP+Ca/7J7eCxPQ42pdL3Ucn7pH0gTe+hHns/mOefhPxgyt6SWE4+D+hQGe7r3UY5FS
         c80ZghppoIBdkHYtsg2nTY5AtqEkkYno74zy0cf9BwiwPbH57sFHxbtZgohn7M/DHyKi
         VPOA==
X-Gm-Message-State: AC+VfDwhaBOB0x3k4Fq4i4E0LgRSwaD4+cvt63b9AKSvFDLiGl86hBYe
        Kz7wViwT0LUdtU2w01ka0aQkPQ==
X-Google-Smtp-Source: ACHHUZ6/W98A68buI07zN7IWbQSiXGWsuVTMSd4ten8CMTDmZ4fwI06mwX6R7g0DmZCjoyvRfUQVDQ==
X-Received: by 2002:a05:6a20:12d3:b0:122:8096:7012 with SMTP id v19-20020a056a2012d300b0012280967012mr608934pzg.3.1687216574663;
        Mon, 19 Jun 2023 16:16:14 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-13-202.pa.nsw.optusnet.com.au. [49.180.13.202])
        by smtp.gmail.com with ESMTPSA id v26-20020aa7809a000000b006636c4f57a6sm171992pff.27.2023.06.19.16.16.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 16:16:13 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1qBO6U-00DpcK-2Q;
        Tue, 20 Jun 2023 09:16:10 +1000
Date:   Tue, 20 Jun 2023 09:16:10 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH] fs: Provide helpers for manipulating
 sb->s_readonly_remount
Message-ID: <ZJDhuldMQRvYGRSh@dread.disaster.area>
References: <20230616163827.19377-1-jack@suse.cz>
 <ZIzxVvLgukjBOBBW@dread.disaster.area>
 <20230619110526.3tothvlcww6cgfup@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230619110526.3tothvlcww6cgfup@quack3>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 19, 2023 at 01:05:26PM +0200, Jan Kara wrote:
> On Sat 17-06-23 09:33:42, Dave Chinner wrote:
> > On Fri, Jun 16, 2023 at 06:38:27PM +0200, Jan Kara wrote:
> > > Provide helpers to set and clear sb->s_readonly_remount including
> > > appropriate memory barriers. Also use this opportunity to document what
> > > the barriers pair with and why they are needed.
> > > 
> > > Suggested-by: Dave Chinner <david@fromorbit.com>
> > > Signed-off-by: Jan Kara <jack@suse.cz>
> > 
> > The helper conversion looks fine so from that perspective the patch
> > looks good.
> > 
> > However, I'm not sure the use of memory barriers is correct, though.
> 
> AFAICS, the barriers are correct but my documentation was not ;)
> Christian's reply has all the details but maybe let me attempt a bit more
> targetted reply here.

*nod*

> 
> > IIUC, we want mnt_is_readonly() to return true when ever
> > s_readonly_remount is set. Is that the behaviour we are trying to
> > acheive for both ro->rw and rw->ro transactions?
> 
> Yes. But what matters is the ordering of s_readonly_remount checking wrt
> other flags. See below.
> 
> > > ---
> > >  fs/internal.h      | 26 ++++++++++++++++++++++++++
> > >  fs/namespace.c     | 10 ++++------
> > >  fs/super.c         | 17 ++++++-----------
> > >  include/linux/fs.h |  2 +-
> > >  4 files changed, 37 insertions(+), 18 deletions(-)
> > > 
> > > diff --git a/fs/internal.h b/fs/internal.h
> > > index bd3b2810a36b..01bff3f6db79 100644
> > > --- a/fs/internal.h
> > > +++ b/fs/internal.h
> > > @@ -120,6 +120,32 @@ void put_super(struct super_block *sb);
> > >  extern bool mount_capable(struct fs_context *);
> > >  int sb_init_dio_done_wq(struct super_block *sb);
> > >  
> > > +/*
> > > + * Prepare superblock for changing its read-only state (i.e., either remount
> > > + * read-write superblock read-only or vice versa). After this function returns
> > > + * mnt_is_readonly() will return true for any mount of the superblock if its
> > > + * caller is able to observe any changes done by the remount. This holds until
> > > + * sb_end_ro_state_change() is called.
> > > + */
> > > +static inline void sb_start_ro_state_change(struct super_block *sb)
> > > +{
> > > +	WRITE_ONCE(sb->s_readonly_remount, 1);
> > > +	/* The barrier pairs with the barrier in mnt_is_readonly() */
> > > +	smp_wmb();
> > > +}
> > 
> > I'm not sure how this wmb pairs with the memory barrier in
> > mnt_is_readonly() to provide the correct behavior. The barrier in
> > mnt_is_readonly() happens after it checks s_readonly_remount, so
> > the s_readonly_remount in mnt_is_readonly is not ordered in any way
> > against this barrier.
> > 
> > The barrier in mnt_is_readonly() ensures that the loads of SB_RDONLY
> > and MNT_READONLY are ordered after s_readonly_remount(), but we
> > don't change those flags until a long way after s_readonly_remount
> > is set.
> 
> You are correct. I've reread the code and the ordering that matters is
> __mnt_want_write() on the read side and reconfigure_super() on the write
> side. In particular for RW->RO transition we must make sure that: If
> __mnt_want_write() does not see MNT_WRITE_HOLD set, it will see
> s_readonly_remount set. There is another set of barriers in those functions
> that makes sure sb_prepare_remount_readonly() sees incremented mnt_writers
> if __mnt_want_write() did not see MNT_WRITE_HOLD set, but that's a
> different story.

Yup, as I said to Christian, there is nothing in the old or new code
that even hints at an interaction with MNT_WRITE_HOLD or
__mnt_want_write() here. I couldn't make that jump from reading the
code, and so the memory barrier placement made no sense at all.

> Hence the barrier in sb_start_ro_state_change() pairs with
> smp_rmb() barrier in __mnt_want_write() before the
> mnt_is_readonly() check at the end of the function. I'll fix my
> patch, thanks for correction.

Please also update the mnt_[un]hold_writers() and __mnt_want_write()
documentation to also point at the new sb_start/end_ro_state_change
helpers, as all the memory barriers in this code are tightly
coupled.

Thanks!

-Dave.
-- 
Dave Chinner
david@fromorbit.com
