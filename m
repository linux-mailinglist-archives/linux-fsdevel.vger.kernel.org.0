Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 713902CC650
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Dec 2020 20:13:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388081AbgLBTMW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Dec 2020 14:12:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47151 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387672AbgLBTMW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Dec 2020 14:12:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606936254;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b8DorC6umPMJFrIGoN8itO5vqnDvmxWw/KvtvGRHdr4=;
        b=QFU7diPBSvc5KkUd+PuwAmIELr5zeLZFDdiXBjB9+oIrVDdDcXKK0FSsEcQxdolSQJuF2D
        jc/oG4WXOnlAoycAT1B57QDg1ZyWf/atDph0iKPBQVmfANZaKcJGfkZPBFTQUPvPnkWx3n
        G7rBnMPtii07bjWMSn8xGbSFbPu62lk=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-522-plzbjk-fOpuGADmcl3PhaA-1; Wed, 02 Dec 2020 14:10:53 -0500
X-MC-Unique: plzbjk-fOpuGADmcl3PhaA-1
Received: by mail-qt1-f199.google.com with SMTP id i20so2199562qtr.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Dec 2020 11:10:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=b8DorC6umPMJFrIGoN8itO5vqnDvmxWw/KvtvGRHdr4=;
        b=bF3AYKjPBC5PjzrygApJm2aTzBmYe3vuwmiEpi86tJ6TkxJMpYqiNTDaqcn85LRb9c
         AwejPpUhVhRqJYKESDj5iqQaacy1MHvi9KOhuPw6KM8ymtZtnAEv2WvWlyQ032zrgX7q
         awF7OHDQVhLzC0QUgHay3TKeobs7+wrfCLqd+qUVAvRK2uMqauHQ1EXp96vPTGX9VIS+
         P0GH97tJODUO4nQES+PN1lVIqV4i3HtPza2qBw4wif+dQ8yUEt3XQQyxqmiwzD5eNr1n
         cBayVfwxL9v4DwFfpzSrQunYxXXaWOJKMk2cIwxkER3wA9pjT118BTn+R+MhWJaOsgwI
         gSiA==
X-Gm-Message-State: AOAM532HTnCJ8KK3liRq5LAPz75983BAFxdxHHpNG5uckFJGijLY/Wuz
        yyHqHvTLPHbGU5G1Fp5+MlPdBNYrfFRRhMRX9M220/8T1FjdjSOgqxZNzAepqMetdfUi/d9jiaJ
        ele1+L/e2fySrJPhe8HoRv0B+lw==
X-Received: by 2002:a37:af06:: with SMTP id y6mr4146234qke.305.1606936252454;
        Wed, 02 Dec 2020 11:10:52 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzcN17Ssxqw0y3xxNxksflzEejOxhokcbXzCoyUGSaDP9uS2+YMNR63IQJKcO8oh2iXJCAUiQ==
X-Received: by 2002:a37:af06:: with SMTP id y6mr4146210qke.305.1606936252095;
        Wed, 02 Dec 2020 11:10:52 -0800 (PST)
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net. [68.20.15.154])
        by smtp.gmail.com with ESMTPSA id 9sm2471319qty.30.2020.12.02.11.10.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 11:10:51 -0800 (PST)
Message-ID: <7ec71bbf7f055cabb7b90be41108812f4b878828.camel@redhat.com>
Subject: Re: [PATCH] overlay: Implement volatile-specific fsync error
 behaviour
From:   Jeff Layton <jlayton@redhat.com>
To:     Sargun Dhillon <sargun@sargun.me>, Vivek Goyal <vgoyal@redhat.com>
Cc:     Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org,
        linux-unionfs@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 02 Dec 2020 14:10:50 -0500
In-Reply-To: <20201202184936.GA17139@ircssh-2.c.rugged-nimbus-611.internal>
References: <20201202092720.41522-1-sargun@sargun.me>
         <20201202150747.GB147783@redhat.com>
         <f2fc7d688417a1da3d94e819afed6bab404da51f.camel@redhat.com>
         <20201202172906.GE147783@redhat.com>
         <20201202184936.GA17139@ircssh-2.c.rugged-nimbus-611.internal>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.1 (3.38.1-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2020-12-02 at 18:49 +0000, Sargun Dhillon wrote:
> On Wed, Dec 02, 2020 at 12:29:06PM -0500, Vivek Goyal wrote:
> > On Wed, Dec 02, 2020 at 12:02:43PM -0500, Jeff Layton wrote:
> > 
> > [..]
> > > > > diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> > > > > index 290983bcfbb3..82a096a05bce 100644
> > > > > --- a/fs/overlayfs/super.c
> > > > > +++ b/fs/overlayfs/super.c
> > > > > @@ -261,11 +261,18 @@ static int ovl_sync_fs(struct super_block *sb, int wait)
> > > > > Ã‚Â 	struct super_block *upper_sb;
> > > > > Ã‚Â 	int ret;
> > > > > Ã‚Â 
> > > > > 
> > > > > 
> > > > > 
> > > > > -	if (!ovl_upper_mnt(ofs))
> > > > > -		return 0;
> > > > > +	ret = ovl_check_sync(ofs);
> > > > > +	/*
> > > > > +	 * We have to always set the err, because the return value isn't
> > > > > +	 * checked, and instead VFS looks at the writeback errseq after
> > > > > +	 * this call.
> > > > > +	 */
> > > > > +	if (ret < 0)
> > > > > +		errseq_set(&sb->s_wb_err, ret);
> > > > 
> > > > I was wondering that why errseq_set() will result in returning error
> > > > all the time. Then realized that last syncfs() call must have set
> > > > ERRSEQ_SEEN flag and that will mean errseq_set() will increment
> > > > counter and that means this syncfs() will will return error too. Cool.
> > > > 
> > > > > +
> > > > > +	if (!ret)
> > > > > +		return ret;
> > > > > Ã‚Â 
> > > > > 
> > > > > 
> > > > > 
> > > > > -	if (!ovl_should_sync(ofs))
> > > > > -		return 0;
> > > > > Ã‚Â 	/*
> > > > > Ã‚Â 	 * Not called for sync(2) call or an emergency sync (SB_I_SKIP_SYNC).
> > > > > Ã‚Â 	 * All the super blocks will be iterated, including upper_sb.
> > > > > @@ -1927,6 +1934,8 @@ static int ovl_fill_super(struct super_block *sb, void *data, int silent)
> > > > > Ã‚Â 	sb->s_op = &ovl_super_operations;
> > > > > Ã‚Â 
> > > > > 
> > > > > 
> > > > > 
> > > > > Ã‚Â 	if (ofs->config.upperdir) {
> > > > > +		struct super_block *upper_mnt_sb;
> > > > > +
> > > > > Ã‚Â 		if (!ofs->config.workdir) {
> > > > > Ã‚Â 			pr_err("missing 'workdir'\n");
> > > > > Ã‚Â 			goto out_err;
> > > > > @@ -1943,9 +1952,10 @@ static int ovl_fill_super(struct super_block *sb, void *data, int silent)
> > > > > Ã‚Â 		if (!ofs->workdir)
> > > > > Ã‚Â 			sb->s_flags |= SB_RDONLY;
> > > > > Ã‚Â 
> > > > > 
> > > > > 
> > > > > 
> > > > > -		sb->s_stack_depth = ovl_upper_mnt(ofs)->mnt_sb->s_stack_depth;
> > > > > -		sb->s_time_gran = ovl_upper_mnt(ofs)->mnt_sb->s_time_gran;
> > > > > -
> > > > > +		upper_mnt_sb = ovl_upper_mnt(ofs)->mnt_sb;
> > > > > +		sb->s_stack_depth = upper_mnt_sb->s_stack_depth;
> > > > > +		sb->s_time_gran = upper_mnt_sb->s_time_gran;
> > > > > +		ofs->upper_errseq = errseq_sample(&upper_mnt_sb->s_wb_err);
> > > > 
> > > > I asked this question in last email as well. errseq_sample() will return
> > > > 0 if current error has not been seen yet. That means next time a sync
> > > > call comes for volatile mount, it will return an error. But that's
> > > > not what we want. When we mounted a volatile overlay, if there is an
> > > > existing error (seen/unseen), we don't care. We only care if there
> > > > is a new error after the volatile mount, right?
> > > > 
> > > > I guess we will need another helper similar to errseq_smaple() which
> > > > just returns existing value of errseq. And then we will have to
> > > > do something about errseq_check() to not return an error if "since"
> > > > and "eseq" differ only by "seen" bit.
> > > > 
> > > > Otherwise in current form, volatile mount will always return error
> > > > if upperdir has error and it has not been seen by anybody.
> > > > 
> > > > How did you finally end up testing the error case. Want to simualate
> > > > error aritificially and test it.
> > > > 
> 
> I used the blockdev error injection layer. It only works with ext2, because
> ext4 (and other filesystems) will error and go into readonly.
> 
> dd if=/dev/zero of=/tmp/loop bs=1M count=100
> losetup /dev/loop8 /tmp/loop 
> mkfs.ext2 /dev/loop8
> mount -o errors=continue /dev/loop8 /mnt/loop/
> mkdir -p /mnt/loop/{upperdir,workdir}
> mount -t overlay -o volatile,index=off,lowerdir=/root/lowerdir,upperdir=/mnt/loop/upperdir,workdir=/mnt/loop/workdir none /mnt/foo/
> echo 1 > /sys/block/loop8/make-it-fail
> echo 100 > /sys/kernel/debug/fail_make_request/probability
> echo 1 > /sys/kernel/debug/fail_make_request/times
> dd if=/dev/zero of=/mnt/foo/zero bs=1M count=1
> sync
> 
> I tried to get XFS tests working, but I was unable to get a simpler repro than 
> above. This is also easy enough to do with a simple kernel module. Maybe it'd be 
> neat to be able to inject in errseq increments via the fault injection API one 
> day? I have no idea what the VFS's approach here is.
> 
> > > 
> > > If you don't want to see errors that occurred before you did the mount,
> > > then you probably can just resurrect and rename the original version of
> > > errseq_sample. Something like this, but with a different name:
> > > 
> > > +errseq_t errseq_sample(errseq_t *eseq)
> > > +{
> > > +       errseq_t old = READ_ONCE(*eseq);
> > > +       errseq_t new = old;
> > > +
> > > +       /*
> > > +        * For the common case of no errors ever having been set, we can skip
> > > +        * marking the SEEN bit. Once an error has been set, the value will
> > > +        * never go back to zero.
> > > +        */
> > > +       if (old != 0) {
> > > +               new |= ERRSEQ_SEEN;
> > > +               if (old != new)
> > > +                       cmpxchg(eseq, old, new);
> > > +       }
> > > +       return new;
> > > +}
> > 
> > Yes, a helper like this should solve the issue at hand. We are not
> > interested in previous errors. This also sets the ERRSEQ_SEEN on 
> > sample and it will also solve the other issue when after sampling
> > if error gets seen, we don't want errseq_check() to return error.
> > 
> > Thinking of some possible names for new function.
> > 
> > errseq_sample_seen()
> > errseq_sample_set_seen()
> > errseq_sample_consume_unseen()
> > errseq_sample_current()
> > 
> > Thanks
> > Vivek
> > 
> 
> I think we can just replace the code in super.c with:
> ofs->upper_errseq = READ_ONCE(&upper_mnt_sb->s_wb_err);
> 
> And then add an errseq helper which checks:
> int errseq_check_ignore_seen(errseq_t *eseq, errseq_t since)
> {
> 	errseq_t cur = READ_ONCE(*eseq);
> 
> 	if ((cur == since) || (cur == since | ERRSEQ_SEEN))
> 		return 0;
> 
> 	return -(cur & MAX_ERRNO);
> }
> 
> --- 
> 
> This extra (cur == since | ERRSEQ_SEEN) ignores the situation where cur has 
> "been seen". We do not want to do the cmpxchg I think because that would hide 
> the situation from the user where if they do a syncfs we hide the error from
> the user. 
> 

> If the since had seen already set, but cur does not have seen set, it
> means we've wrapped.
> 

That looks wrong to me. If you don't mark the SEEN bit when sampling you
can't be sure that you'll see errors that occur after your sample.
Nothing will change if nothing has seen it and the error is the same as
the last one. You can't really hold an unseen error "in reserve" in the
hopes that someone will scrape it later.

Also, you'd only be hiding the error from syncfs callers that did not
have the file open prior to the error occurring. See commit
b4678df184b314 (errseq: Always report a writeback error once) for the
rationale. I'm not inclined to be too sympathetic here about reporting
these errors anyway, given that they were only visible very recently
anyway.


-- 
Jeff Layton <jlayton@redhat.com>

