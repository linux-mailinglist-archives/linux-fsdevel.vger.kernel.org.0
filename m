Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05B5A2CC3DA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Dec 2020 18:31:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728873AbgLBRah (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Dec 2020 12:30:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55475 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728414AbgLBRah (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Dec 2020 12:30:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606930150;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d/jS4DIk2eFo5oEaYGUTxcJX+tztVkMUbhd9Mb6koUs=;
        b=BiGbBg+r6iDr1Zrk7tYXZlYT/jw2oDDyio4Tq9a/+TX4u4mEkcWJnbLBJu65k+wK8/uR0e
        4mmwe0a9oFa+qvFHUUV5NF4JRMmpMyAy1m7BGpEWBLCiRUzP/DSfRgM2Njoe9NC2AIg4s0
        6Bt99CVMUZDkjiRrAV+YgEVwQEiRDIY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-282-8FSyrVC-OKGbLzpy9VbMKQ-1; Wed, 02 Dec 2020 12:29:08 -0500
X-MC-Unique: 8FSyrVC-OKGbLzpy9VbMKQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AAAFE1009456;
        Wed,  2 Dec 2020 17:29:07 +0000 (UTC)
Received: from horse.redhat.com (ovpn-117-99.rdu2.redhat.com [10.10.117.99])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 681555C1B4;
        Wed,  2 Dec 2020 17:29:07 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id EFBDE22054F; Wed,  2 Dec 2020 12:29:06 -0500 (EST)
Date:   Wed, 2 Dec 2020 12:29:06 -0500
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Jeff Layton <jlayton@redhat.com>
Cc:     Sargun Dhillon <sargun@sargun.me>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [PATCH] overlay: Implement volatile-specific fsync error
 behaviour
Message-ID: <20201202172906.GE147783@redhat.com>
References: <20201202092720.41522-1-sargun@sargun.me>
 <20201202150747.GB147783@redhat.com>
 <f2fc7d688417a1da3d94e819afed6bab404da51f.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f2fc7d688417a1da3d94e819afed6bab404da51f.camel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 02, 2020 at 12:02:43PM -0500, Jeff Layton wrote:

[..]
> > > diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> > > index 290983bcfbb3..82a096a05bce 100644
> > > --- a/fs/overlayfs/super.c
> > > +++ b/fs/overlayfs/super.c
> > > @@ -261,11 +261,18 @@ static int ovl_sync_fs(struct super_block *sb, int wait)
> > >  	struct super_block *upper_sb;
> > >  	int ret;
> > >  
> > > 
> > > 
> > > 
> > > -	if (!ovl_upper_mnt(ofs))
> > > -		return 0;
> > > +	ret = ovl_check_sync(ofs);
> > > +	/*
> > > +	 * We have to always set the err, because the return value isn't
> > > +	 * checked, and instead VFS looks at the writeback errseq after
> > > +	 * this call.
> > > +	 */
> > > +	if (ret < 0)
> > > +		errseq_set(&sb->s_wb_err, ret);
> > 
> > I was wondering that why errseq_set() will result in returning error
> > all the time. Then realized that last syncfs() call must have set
> > ERRSEQ_SEEN flag and that will mean errseq_set() will increment
> > counter and that means this syncfs() will will return error too. Cool.
> > 
> > > +
> > > +	if (!ret)
> > > +		return ret;
> > >  
> > > 
> > > 
> > > 
> > > -	if (!ovl_should_sync(ofs))
> > > -		return 0;
> > >  	/*
> > >  	 * Not called for sync(2) call or an emergency sync (SB_I_SKIP_SYNC).
> > >  	 * All the super blocks will be iterated, including upper_sb.
> > > @@ -1927,6 +1934,8 @@ static int ovl_fill_super(struct super_block *sb, void *data, int silent)
> > >  	sb->s_op = &ovl_super_operations;
> > >  
> > > 
> > > 
> > > 
> > >  	if (ofs->config.upperdir) {
> > > +		struct super_block *upper_mnt_sb;
> > > +
> > >  		if (!ofs->config.workdir) {
> > >  			pr_err("missing 'workdir'\n");
> > >  			goto out_err;
> > > @@ -1943,9 +1952,10 @@ static int ovl_fill_super(struct super_block *sb, void *data, int silent)
> > >  		if (!ofs->workdir)
> > >  			sb->s_flags |= SB_RDONLY;
> > >  
> > > 
> > > 
> > > 
> > > -		sb->s_stack_depth = ovl_upper_mnt(ofs)->mnt_sb->s_stack_depth;
> > > -		sb->s_time_gran = ovl_upper_mnt(ofs)->mnt_sb->s_time_gran;
> > > -
> > > +		upper_mnt_sb = ovl_upper_mnt(ofs)->mnt_sb;
> > > +		sb->s_stack_depth = upper_mnt_sb->s_stack_depth;
> > > +		sb->s_time_gran = upper_mnt_sb->s_time_gran;
> > > +		ofs->upper_errseq = errseq_sample(&upper_mnt_sb->s_wb_err);
> > 
> > I asked this question in last email as well. errseq_sample() will return
> > 0 if current error has not been seen yet. That means next time a sync
> > call comes for volatile mount, it will return an error. But that's
> > not what we want. When we mounted a volatile overlay, if there is an
> > existing error (seen/unseen), we don't care. We only care if there
> > is a new error after the volatile mount, right?
> > 
> > I guess we will need another helper similar to errseq_smaple() which
> > just returns existing value of errseq. And then we will have to
> > do something about errseq_check() to not return an error if "since"
> > and "eseq" differ only by "seen" bit.
> > 
> > Otherwise in current form, volatile mount will always return error
> > if upperdir has error and it has not been seen by anybody.
> > 
> > How did you finally end up testing the error case. Want to simualate
> > error aritificially and test it.
> > 
> 
> If you don't want to see errors that occurred before you did the mount,
> then you probably can just resurrect and rename the original version of
> errseq_sample. Something like this, but with a different name:
> 
> +errseq_t errseq_sample(errseq_t *eseq)
> +{
> +       errseq_t old = READ_ONCE(*eseq);
> +       errseq_t new = old;
> +
> +       /*
> +        * For the common case of no errors ever having been set, we can skip
> +        * marking the SEEN bit. Once an error has been set, the value will
> +        * never go back to zero.
> +        */
> +       if (old != 0) {
> +               new |= ERRSEQ_SEEN;
> +               if (old != new)
> +                       cmpxchg(eseq, old, new);
> +       }
> +       return new;
> +}

Yes, a helper like this should solve the issue at hand. We are not
interested in previous errors. This also sets the ERRSEQ_SEEN on 
sample and it will also solve the other issue when after sampling
if error gets seen, we don't want errseq_check() to return error.

Thinking of some possible names for new function.

errseq_sample_seen()
errseq_sample_set_seen()
errseq_sample_consume_unseen()
errseq_sample_current()

Thanks
Vivek

