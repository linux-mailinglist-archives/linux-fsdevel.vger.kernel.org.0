Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB2682CC4F6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Dec 2020 19:24:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730899AbgLBSXm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Dec 2020 13:23:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:24746 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728996AbgLBSXm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Dec 2020 13:23:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606933334;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XPEQG9ZMsupvlCOjfIXKVCM+10SfC6r3XKFkI7oXLFI=;
        b=HVQQ75rp8X7vtzVOafGURoMKIrTMI/RAEkqzGYlpho18tpqILVJgmrWZmcYdbqYafmhfrG
        q+HWV0TAE/uGpag4gd4dFWmouqjs+FSvKccRp12QiU9JFpbcKyyuRWbPDKre1kuNnO+5Kq
        N+tRDm+r2xeB7qnuV9b4OfeUw5GT2U4=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-210-DlEp1ryrOyeO4DHLXtuyJw-1; Wed, 02 Dec 2020 13:22:13 -0500
X-MC-Unique: DlEp1ryrOyeO4DHLXtuyJw-1
Received: by mail-qt1-f199.google.com with SMTP id y5so2071234qtb.13
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Dec 2020 10:22:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=XPEQG9ZMsupvlCOjfIXKVCM+10SfC6r3XKFkI7oXLFI=;
        b=n9Wix8lVEjgTTddk8l5vse8j5O7773mWl43M8Dz7zxrZvXE0FX30yd6v4nzbWQPgQF
         zxQZjpu/eyEk0zDb4DlmbOmOG3AIl4xcA0IjwMBxYo2BdBxowuu5/U1AFaga+IFllEAS
         yvYnqFI9VZKEQ2oOqrikw1iqLPL5AoXD3E7s40yW/T8KgY+AOJp/14WtOGYI04b9UggG
         bIc/rcXWp+8M5zUTc1N5JS79N32NnIIf0c/6ASmpNM1y40KG+nV7361dBBsvAnD3sdCu
         qiNs4YUYyWEs/bl4TKZCu+WVIat7yVNrLWE3Kxkh1QmCc9RGrycqqiRETl3mMoVSO2jJ
         TUXQ==
X-Gm-Message-State: AOAM531fW4prBstftDnqkritwjxJYRe356j8UhP/x0subvnWf4GjsY6f
        j/nuyo1xVAmglAHsm/P/aX9684cSMqVmjE0myNIAHk/wtuqGScYZFwP6wsXEv6nGwTbHJbckguq
        x4pGpbl+rEacYcNJ4JiT4+i+Syg==
X-Received: by 2002:ac8:5901:: with SMTP id 1mr3972350qty.350.1606933333034;
        Wed, 02 Dec 2020 10:22:13 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxfoWOXx4dGEGMr9stBfgRmyfDDQPAeN1SMyYagYDQ3sVw/63gnmuR1XJ8CfaJE/fzMxriQfQ==
X-Received: by 2002:ac8:5901:: with SMTP id 1mr3972335qty.350.1606933332758;
        Wed, 02 Dec 2020 10:22:12 -0800 (PST)
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net. [68.20.15.154])
        by smtp.gmail.com with ESMTPSA id p27sm2525516qkp.70.2020.12.02.10.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 10:22:10 -0800 (PST)
Message-ID: <59de2220a85e858a4c397969e2a0d03f1d653a6a.camel@redhat.com>
Subject: Re: [PATCH] overlay: Implement volatile-specific fsync error
 behaviour
From:   Jeff Layton <jlayton@redhat.com>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Sargun Dhillon <sargun@sargun.me>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 02 Dec 2020 13:22:09 -0500
In-Reply-To: <20201202172906.GE147783@redhat.com>
References: <20201202092720.41522-1-sargun@sargun.me>
         <20201202150747.GB147783@redhat.com>
         <f2fc7d688417a1da3d94e819afed6bab404da51f.camel@redhat.com>
         <20201202172906.GE147783@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.1 (3.38.1-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2020-12-02 at 12:29 -0500, Vivek Goyal wrote:
> On Wed, Dec 02, 2020 at 12:02:43PM -0500, Jeff Layton wrote:
> 
> [..]
> > > > diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> > > > index 290983bcfbb3..82a096a05bce 100644
> > > > --- a/fs/overlayfs/super.c
> > > > +++ b/fs/overlayfs/super.c
> > > > @@ -261,11 +261,18 @@ static int ovl_sync_fs(struct super_block *sb, int wait)
> > > > Â 	struct super_block *upper_sb;
> > > > Â 	int ret;
> > > > Â 
> > > > 
> > > > 
> > > > 
> > > > -	if (!ovl_upper_mnt(ofs))
> > > > -		return 0;
> > > > +	ret = ovl_check_sync(ofs);
> > > > +	/*
> > > > +	 * We have to always set the err, because the return value isn't
> > > > +	 * checked, and instead VFS looks at the writeback errseq after
> > > > +	 * this call.
> > > > +	 */
> > > > +	if (ret < 0)
> > > > +		errseq_set(&sb->s_wb_err, ret);
> > > 
> > > I was wondering that why errseq_set() will result in returning error
> > > all the time. Then realized that last syncfs() call must have set
> > > ERRSEQ_SEEN flag and that will mean errseq_set() will increment
> > > counter and that means this syncfs() will will return error too. Cool.
> > > 
> > > > +
> > > > +	if (!ret)
> > > > +		return ret;
> > > > Â 
> > > > 
> > > > 
> > > > 
> > > > -	if (!ovl_should_sync(ofs))
> > > > -		return 0;
> > > > Â 	/*
> > > > Â 	 * Not called for sync(2) call or an emergency sync (SB_I_SKIP_SYNC).
> > > > Â 	 * All the super blocks will be iterated, including upper_sb.
> > > > @@ -1927,6 +1934,8 @@ static int ovl_fill_super(struct super_block *sb, void *data, int silent)
> > > > Â 	sb->s_op = &ovl_super_operations;
> > > > Â 
> > > > 
> > > > 
> > > > 
> > > > Â 	if (ofs->config.upperdir) {
> > > > +		struct super_block *upper_mnt_sb;
> > > > +
> > > > Â 		if (!ofs->config.workdir) {
> > > > Â 			pr_err("missing 'workdir'\n");
> > > > Â 			goto out_err;
> > > > @@ -1943,9 +1952,10 @@ static int ovl_fill_super(struct super_block *sb, void *data, int silent)
> > > > Â 		if (!ofs->workdir)
> > > > Â 			sb->s_flags |= SB_RDONLY;
> > > > Â 
> > > > 
> > > > 
> > > > 
> > > > -		sb->s_stack_depth = ovl_upper_mnt(ofs)->mnt_sb->s_stack_depth;
> > > > -		sb->s_time_gran = ovl_upper_mnt(ofs)->mnt_sb->s_time_gran;
> > > > -
> > > > +		upper_mnt_sb = ovl_upper_mnt(ofs)->mnt_sb;
> > > > +		sb->s_stack_depth = upper_mnt_sb->s_stack_depth;
> > > > +		sb->s_time_gran = upper_mnt_sb->s_time_gran;
> > > > +		ofs->upper_errseq = errseq_sample(&upper_mnt_sb->s_wb_err);
> > > 
> > > I asked this question in last email as well. errseq_sample() will return
> > > 0 if current error has not been seen yet. That means next time a sync
> > > call comes for volatile mount, it will return an error. But that's
> > > not what we want. When we mounted a volatile overlay, if there is an
> > > existing error (seen/unseen), we don't care. We only care if there
> > > is a new error after the volatile mount, right?
> > > 
> > > I guess we will need another helper similar to errseq_smaple() which
> > > just returns existing value of errseq. And then we will have to
> > > do something about errseq_check() to not return an error if "since"
> > > and "eseq" differ only by "seen" bit.
> > > 
> > > Otherwise in current form, volatile mount will always return error
> > > if upperdir has error and it has not been seen by anybody.
> > > 
> > > How did you finally end up testing the error case. Want to simualate
> > > error aritificially and test it.
> > > 
> > 
> > If you don't want to see errors that occurred before you did the mount,
> > then you probably can just resurrect and rename the original version of
> > errseq_sample. Something like this, but with a different name:
> > 
> > +errseq_t errseq_sample(errseq_t *eseq)
> > +{
> > +       errseq_t old = READ_ONCE(*eseq);
> > +       errseq_t new = old;
> > +
> > +       /*
> > +        * For the common case of no errors ever having been set, we can skip
> > +        * marking the SEEN bit. Once an error has been set, the value will
> > +        * never go back to zero.
> > +        */
> > +       if (old != 0) {
> > +               new |= ERRSEQ_SEEN;
> > +               if (old != new)
> > +                       cmpxchg(eseq, old, new);
> > +       }
> > +       return new;
> > +}
> 
> Yes, a helper like this should solve the issue at hand. We are not
> interested in previous errors. This also sets the ERRSEQ_SEEN on 
> sample and it will also solve the other issue when after sampling
> if error gets seen, we don't want errseq_check() to return error.
> 
> Thinking of some possible names for new function.
> 
> errseq_sample_seen()
> errseq_sample_set_seen()
> errseq_sample_consume_unseen()
> errseq_sample_current()
> 

errseq_sample_consume_unseen() sounds good, though maybe it should be
"ignore_unseen"? IDK, naming this stuff is the hardest part.

If you don't want to add a new helper, I think you'd probably also be
able to do something like this in fill_super:

    errseq_sample()
    errseq_check_and_advance()


...and just ignore the error returned by the check and advance. At that
point, the cursor should be caught up and any subsequent syncfs call
should return 0 until you record another error. It's a little less
efficient, but only slightly so.
-- 
Jeff Layton <jlayton@redhat.com>

