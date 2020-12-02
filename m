Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC7582CC5DD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Dec 2020 19:50:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730992AbgLBSu0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Dec 2020 13:50:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbgLBSu0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Dec 2020 13:50:26 -0500
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89019C0613D6
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Dec 2020 10:49:40 -0800 (PST)
Received: by mail-il1-x141.google.com with SMTP id v3so2499333ilo.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Dec 2020 10:49:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=UrmLYg1nm4UuLYbX3QQ5mMgswwZLDr8PnKvoX6zOcVI=;
        b=P1aVJhSiK5qnaQYj96HlM8YOWMMNFjiyUNQMVLJ8AyUqgRe9BHTmWqUEuOLsXEqmT6
         F/sGvj5xtPH36YxGikv8J3YAj9MEcKjfg3d4sjStEvK7edTXFcGljrXr1RMvGZjvcOnP
         CvKNJwLmiHjuct1xBBtTay2hlig87cnu6dem0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=UrmLYg1nm4UuLYbX3QQ5mMgswwZLDr8PnKvoX6zOcVI=;
        b=hnimQ31q7Wi8kIg5g2fqMMCAy1uCAV+8iR0X7D7fpcEQwJwUkex9mjxhBIj1wbReS4
         IuGJtDua0f/UnEVvFAWkYYeFIXEeStawgLkYrHF7jpCnB2J4VVej2I0Pz4f85oU3WGS1
         tdQRuW12Pw+Wfjt8bZOu2lxUN8n67DsGqqfwDyJT3zXVsuA8oQOlrSUvUcYKAPPLxx9S
         dxe+heVD9A9ZRSkVJ2nSO9do4pGEo9n+CNBgFEJA7rPbRtSYPJm3KXniOcsUv+Fn/8rO
         p3y4rjnW1vhBOjvFShSLNBuZqiuCGI1QBd+P+utUaOgLRkJhZQEGbxSAZpb8YdkxUKP1
         xnOQ==
X-Gm-Message-State: AOAM532rKDhRcjEHGS7JOqlkMPZdT5g9DRkYsuc9qlbxr8QNvVA8FAds
        XQx34TR0kghZZoI4+nsCo6PNMQ==
X-Google-Smtp-Source: ABdhPJyhfEHfnzelbjFRL3+xub/Gq3eyKDLJ/aCH9abKRhpxfAgOD2sn6dXJWUeWudLa+36tFXzV+g==
X-Received: by 2002:a92:6e05:: with SMTP id j5mr3526223ilc.136.1606934979738;
        Wed, 02 Dec 2020 10:49:39 -0800 (PST)
Received: from ircssh-2.c.rugged-nimbus-611.internal (80.60.198.104.bc.googleusercontent.com. [104.198.60.80])
        by smtp.gmail.com with ESMTPSA id l78sm1606601ild.30.2020.12.02.10.49.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 02 Dec 2020 10:49:39 -0800 (PST)
Date:   Wed, 2 Dec 2020 18:49:37 +0000
From:   Sargun Dhillon <sargun@sargun.me>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Jeff Layton <jlayton@redhat.com>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [PATCH] overlay: Implement volatile-specific fsync error
 behaviour
Message-ID: <20201202184936.GA17139@ircssh-2.c.rugged-nimbus-611.internal>
References: <20201202092720.41522-1-sargun@sargun.me>
 <20201202150747.GB147783@redhat.com>
 <f2fc7d688417a1da3d94e819afed6bab404da51f.camel@redhat.com>
 <20201202172906.GE147783@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201202172906.GE147783@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 02, 2020 at 12:29:06PM -0500, Vivek Goyal wrote:
> On Wed, Dec 02, 2020 at 12:02:43PM -0500, Jeff Layton wrote:
> 
> [..]
> > > > diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> > > > index 290983bcfbb3..82a096a05bce 100644
> > > > --- a/fs/overlayfs/super.c
> > > > +++ b/fs/overlayfs/super.c
> > > > @@ -261,11 +261,18 @@ static int ovl_sync_fs(struct super_block *sb, int wait)
> > > >  	struct super_block *upper_sb;
> > > >  	int ret;
> > > >  
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
> > > >  
> > > > 
> > > > 
> > > > 
> > > > -	if (!ovl_should_sync(ofs))
> > > > -		return 0;
> > > >  	/*
> > > >  	 * Not called for sync(2) call or an emergency sync (SB_I_SKIP_SYNC).
> > > >  	 * All the super blocks will be iterated, including upper_sb.
> > > > @@ -1927,6 +1934,8 @@ static int ovl_fill_super(struct super_block *sb, void *data, int silent)
> > > >  	sb->s_op = &ovl_super_operations;
> > > >  
> > > > 
> > > > 
> > > > 
> > > >  	if (ofs->config.upperdir) {
> > > > +		struct super_block *upper_mnt_sb;
> > > > +
> > > >  		if (!ofs->config.workdir) {
> > > >  			pr_err("missing 'workdir'\n");
> > > >  			goto out_err;
> > > > @@ -1943,9 +1952,10 @@ static int ovl_fill_super(struct super_block *sb, void *data, int silent)
> > > >  		if (!ofs->workdir)
> > > >  			sb->s_flags |= SB_RDONLY;
> > > >  
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

I used the blockdev error injection layer. It only works with ext2, because
ext4 (and other filesystems) will error and go into readonly.

dd if=/dev/zero of=/tmp/loop bs=1M count=100
losetup /dev/loop8 /tmp/loop 
mkfs.ext2 /dev/loop8
mount -o errors=continue /dev/loop8 /mnt/loop/
mkdir -p /mnt/loop/{upperdir,workdir}
mount -t overlay -o volatile,index=off,lowerdir=/root/lowerdir,upperdir=/mnt/loop/upperdir,workdir=/mnt/loop/workdir none /mnt/foo/
echo 1 > /sys/block/loop8/make-it-fail
echo 100 > /sys/kernel/debug/fail_make_request/probability
echo 1 > /sys/kernel/debug/fail_make_request/times
dd if=/dev/zero of=/mnt/foo/zero bs=1M count=1
sync

I tried to get XFS tests working, but I was unable to get a simpler repro than 
above. This is also easy enough to do with a simple kernel module. Maybe it'd be 
neat to be able to inject in errseq increments via the fault injection API one 
day? I have no idea what the VFS's approach here is.

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
> Thanks
> Vivek
> 

I think we can just replace the code in super.c with:
ofs->upper_errseq = READ_ONCE(&upper_mnt_sb->s_wb_err);

And then add an errseq helper which checks:
int errseq_check_ignore_seen(errseq_t *eseq, errseq_t since)
{
	errseq_t cur = READ_ONCE(*eseq);

	if ((cur == since) || (cur == since | ERRSEQ_SEEN))
		return 0;

	return -(cur & MAX_ERRNO);
}

--- 

This extra (cur == since | ERRSEQ_SEEN) ignores the situation where cur has 
"been seen". We do not want to do the cmpxchg I think because that would hide 
the situation from the user where if they do a syncfs we hide the error from
the user. 

If the since had seen already set, but cur does not have seen set, it means
we've wrapped.
