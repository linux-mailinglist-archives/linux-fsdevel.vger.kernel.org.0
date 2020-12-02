Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFDE52CC8FF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Dec 2020 22:36:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbgLBVgF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Dec 2020 16:36:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48151 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726744AbgLBVgF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Dec 2020 16:36:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606944877;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zCz+HO5kXh+Vp6H/zXfh2vvr1CrFy8yc2RXQsOGr9nQ=;
        b=YszzA2CGu9khTUSug/kPcMXcVKtgfpFrZIXcwVYGxCwyc4arTCe+XN1uZ3FR44TFfMA9F4
        hLm+CVIFsdBrqN+pWvoT18yoRinK84V/9Jvz9Z0KmJPbPl0z8MFbkQKL6F51xEqffd8zqJ
        F6PsYl5DpnGgX2dur19srjGmb8Nmazc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-402-77YDsSONNliv4dLPlv59Fw-1; Wed, 02 Dec 2020 16:34:36 -0500
X-MC-Unique: 77YDsSONNliv4dLPlv59Fw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1778B800050;
        Wed,  2 Dec 2020 21:34:35 +0000 (UTC)
Received: from horse.redhat.com (ovpn-116-109.rdu2.redhat.com [10.10.116.109])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D009219D9C;
        Wed,  2 Dec 2020 21:34:34 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 6DDDA220BCF; Wed,  2 Dec 2020 16:34:34 -0500 (EST)
Date:   Wed, 2 Dec 2020 16:34:34 -0500
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Jeff Layton <jlayton@redhat.com>
Cc:     Sargun Dhillon <sargun@sargun.me>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [PATCH] overlay: Implement volatile-specific fsync error
 behaviour
Message-ID: <20201202213434.GA4070@redhat.com>
References: <20201202092720.41522-1-sargun@sargun.me>
 <20201202150747.GB147783@redhat.com>
 <f2fc7d688417a1da3d94e819afed6bab404da51f.camel@redhat.com>
 <20201202172906.GE147783@redhat.com>
 <59de2220a85e858a4c397969e2a0d03f1d653a6a.camel@redhat.com>
 <20201202185601.GF147783@redhat.com>
 <0a3979479ffbf080fa1cd492923a7fa8984078b9.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0a3979479ffbf080fa1cd492923a7fa8984078b9.camel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 02, 2020 at 02:26:23PM -0500, Jeff Layton wrote:
[..]
> > > > > > > +		upper_mnt_sb = ovl_upper_mnt(ofs)->mnt_sb;
> > > > > > > +		sb->s_stack_depth = upper_mnt_sb->s_stack_depth;
> > > > > > > +		sb->s_time_gran = upper_mnt_sb->s_time_gran;
> > > > > > > +		ofs->upper_errseq = errseq_sample(&upper_mnt_sb->s_wb_err);
> > > > > > 
> > > > > > I asked this question in last email as well. errseq_sample() will return
> > > > > > 0 if current error has not been seen yet. That means next time a sync
> > > > > > call comes for volatile mount, it will return an error. But that's
> > > > > > not what we want. When we mounted a volatile overlay, if there is an
> > > > > > existing error (seen/unseen), we don't care. We only care if there
> > > > > > is a new error after the volatile mount, right?
> > > > > > 
> > > > > > I guess we will need another helper similar to errseq_smaple() which
> > > > > > just returns existing value of errseq. And then we will have to
> > > > > > do something about errseq_check() to not return an error if "since"
> > > > > > and "eseq" differ only by "seen" bit.
> > > > > > 
> > > > > > Otherwise in current form, volatile mount will always return error
> > > > > > if upperdir has error and it has not been seen by anybody.
> > > > > > 
> > > > > > How did you finally end up testing the error case. Want to simualate
> > > > > > error aritificially and test it.
> > > > > > 
> > > > > 
> > > > > If you don't want to see errors that occurred before you did the mount,
> > > > > then you probably can just resurrect and rename the original version of
> > > > > errseq_sample. Something like this, but with a different name:
> > > > > 
> > > > > +errseq_t errseq_sample(errseq_t *eseq)
> > > > > +{
> > > > > +       errseq_t old = READ_ONCE(*eseq);
> > > > > +       errseq_t new = old;
> > > > > +
> > > > > +       /*
> > > > > +        * For the common case of no errors ever having been set, we can skip
> > > > > +        * marking the SEEN bit. Once an error has been set, the value will
> > > > > +        * never go back to zero.
> > > > > +        */
> > > > > +       if (old != 0) {
> > > > > +               new |= ERRSEQ_SEEN;
> > > > > +               if (old != new)
> > > > > +                       cmpxchg(eseq, old, new);
> > > > > +       }
> > > > > +       return new;
> > > > > +}
> > > > 
> > > > Yes, a helper like this should solve the issue at hand. We are not
> > > > interested in previous errors. This also sets the ERRSEQ_SEEN on 
> > > > sample and it will also solve the other issue when after sampling
> > > > if error gets seen, we don't want errseq_check() to return error.
> > > > 
> > > > Thinking of some possible names for new function.
> > > > 
> > > > errseq_sample_seen()
> > > > errseq_sample_set_seen()
> > > > errseq_sample_consume_unseen()
> > > > errseq_sample_current()
> > > > 
> > > 
> > > errseq_sample_consume_unseen() sounds good, though maybe it should be
> > > "ignore_unseen"? IDK, naming this stuff is the hardest part.
> > > 
> > > If you don't want to add a new helper, I think you'd probably also be
> > > able to do something like this in fill_super:
> > > 
> > >     errseq_sample()
> > >     errseq_check_and_advance()
> > > 
> > > 
> > > ...and just ignore the error returned by the check and advance. At that
> > > point, the cursor should be caught up and any subsequent syncfs call
> > > should return 0 until you record another error. It's a little less
> > > efficient, but only slightly so.
> > 
> > This seems even better.
> > 
> > Thinking little bit more. I am now concerned about setting ERRSEQ_SEEN on
> > sample. In our case, that would mean that we consumed an unseen error but
> > never reported it back to user space. And then somebody might complain.
> > 
> > This kind of reminds me posgresql's fsync issues where they did
> > writes using one fd and another thread opened another fd and
> > did sync and they expected any errors to be reported.
> > 
> 
> > Similary what if an unseen error is present on superblock on upper
> > and if we mount volatile overlay and mark the error SEEN, then
> > if another process opens a file on upper and did syncfs(), it will
> > complain that exisiting error was not reported to it.
> > 
> > Overlay use case seems to be that we just want to check if an error
> > has happened on upper superblock since we sampled it and don't
> > want to consume that error as such. Will it make sense to introduce
> > two helpers for error sampling and error checking which mask the
> > SEEN bit and don't do anything with it. For example, following compile
> > tested only patch.
> > 
> > Now we will not touch SEEN bit at all. And even if SEEN gets set
> > since we sampled, errseq_check_mask_seen() will not flag it as
> > error.
> > 
> > Thanks
> > Vivek
> > 
> 
> Again, you're not really hiding this from anyone doing something _sane_.
> You're only hiding an error from someone who opens the file after an
> error occurs and expects to see an error.
> 
> That was the behavior for fsync before we switched to errseq_t, and we
> had to change errseq_sample for applications that relied on that. syncfs
> reporting these errors is pretty new however. I don't think we
> necessarily need to make the same guarantees there.
> 
> The solution to all of these problems is to ensure that you open the
> files early you're issuing syncfs on and keep them open. Then you'll
> always see any subsequent errors.

Ok. I guess we will have to set SEEN bit during error_sample otherwise,
we miss errors. I had missed this point.

So mounting a volatile overlay instance will become somewhat
equivalent of as if somebody did a syncfs on upper, consumed
error and did not do anything about it.

If a user cares about not losing such errors, they need to keep an
fd open on upper. 

/me hopes that this does not become an issue for somebody. Even
if it does, one workaround can be don't do volatile overlay or
don't share overlay upper with other conflicting workload.

Thanks
Vivek

