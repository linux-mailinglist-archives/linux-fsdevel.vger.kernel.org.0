Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E70B02CC60A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Dec 2020 19:58:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389718AbgLBS5m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Dec 2020 13:57:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51679 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389632AbgLBS5m (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Dec 2020 13:57:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606935374;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lIhh5qZVYrNrusAm0qQD4XyO5uXeytbfYUudMa5kNTc=;
        b=TR6Z+oR/rhq/kGVCffIsZ/d7aCcG/RPmD0IN29v2gt47XhcxyfNptIehVuLbXztghMrSQA
        JQO1Wf/oETSMWuiAzLCrKfB/yioH2l3LVqx3Xcph5LK5w4sE6Y27gtY9mvhQ4q2bKG0hof
        fhTTlarJSBI0OH8FSPhpCLuPLUNn7+E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-557-JIqnz6OINy268P5wpZ5x4g-1; Wed, 02 Dec 2020 13:56:04 -0500
X-MC-Unique: JIqnz6OINy268P5wpZ5x4g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BB34C100E321;
        Wed,  2 Dec 2020 18:56:02 +0000 (UTC)
Received: from horse.redhat.com (ovpn-117-99.rdu2.redhat.com [10.10.117.99])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6BA81189B6;
        Wed,  2 Dec 2020 18:56:02 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id E76CD22054F; Wed,  2 Dec 2020 13:56:01 -0500 (EST)
Date:   Wed, 2 Dec 2020 13:56:01 -0500
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Jeff Layton <jlayton@redhat.com>
Cc:     Sargun Dhillon <sargun@sargun.me>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [PATCH] overlay: Implement volatile-specific fsync error
 behaviour
Message-ID: <20201202185601.GF147783@redhat.com>
References: <20201202092720.41522-1-sargun@sargun.me>
 <20201202150747.GB147783@redhat.com>
 <f2fc7d688417a1da3d94e819afed6bab404da51f.camel@redhat.com>
 <20201202172906.GE147783@redhat.com>
 <59de2220a85e858a4c397969e2a0d03f1d653a6a.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <59de2220a85e858a4c397969e2a0d03f1d653a6a.camel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 02, 2020 at 01:22:09PM -0500, Jeff Layton wrote:
> On Wed, 2020-12-02 at 12:29 -0500, Vivek Goyal wrote:
> > On Wed, Dec 02, 2020 at 12:02:43PM -0500, Jeff Layton wrote:
> > 
> > [..]
> > > > > diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> > > > > index 290983bcfbb3..82a096a05bce 100644
> > > > > --- a/fs/overlayfs/super.c
> > > > > +++ b/fs/overlayfs/super.c
> > > > > @@ -261,11 +261,18 @@ static int ovl_sync_fs(struct super_block *sb, int wait)
> > > > >  	struct super_block *upper_sb;
> > > > >  	int ret;
> > > > >  
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
> > > > >  
> > > > > 
> > > > > 
> > > > > 
> > > > > -	if (!ovl_should_sync(ofs))
> > > > > -		return 0;
> > > > >  	/*
> > > > >  	 * Not called for sync(2) call or an emergency sync (SB_I_SKIP_SYNC).
> > > > >  	 * All the super blocks will be iterated, including upper_sb.
> > > > > @@ -1927,6 +1934,8 @@ static int ovl_fill_super(struct super_block *sb, void *data, int silent)
> > > > >  	sb->s_op = &ovl_super_operations;
> > > > >  
> > > > > 
> > > > > 
> > > > > 
> > > > >  	if (ofs->config.upperdir) {
> > > > > +		struct super_block *upper_mnt_sb;
> > > > > +
> > > > >  		if (!ofs->config.workdir) {
> > > > >  			pr_err("missing 'workdir'\n");
> > > > >  			goto out_err;
> > > > > @@ -1943,9 +1952,10 @@ static int ovl_fill_super(struct super_block *sb, void *data, int silent)
> > > > >  		if (!ofs->workdir)
> > > > >  			sb->s_flags |= SB_RDONLY;
> > > > >  
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
> 
> errseq_sample_consume_unseen() sounds good, though maybe it should be
> "ignore_unseen"? IDK, naming this stuff is the hardest part.
> 
> If you don't want to add a new helper, I think you'd probably also be
> able to do something like this in fill_super:
> 
>     errseq_sample()
>     errseq_check_and_advance()
> 
> 
> ...and just ignore the error returned by the check and advance. At that
> point, the cursor should be caught up and any subsequent syncfs call
> should return 0 until you record another error. It's a little less
> efficient, but only slightly so.

This seems even better.

Thinking little bit more. I am now concerned about setting ERRSEQ_SEEN on
sample. In our case, that would mean that we consumed an unseen error but
never reported it back to user space. And then somebody might complain.

This kind of reminds me posgresql's fsync issues where they did
writes using one fd and another thread opened another fd and
did sync and they expected any errors to be reported.

Similary what if an unseen error is present on superblock on upper
and if we mount volatile overlay and mark the error SEEN, then
if another process opens a file on upper and did syncfs(), it will
complain that exisiting error was not reported to it.

Overlay use case seems to be that we just want to check if an error
has happened on upper superblock since we sampled it and don't
want to consume that error as such. Will it make sense to introduce
two helpers for error sampling and error checking which mask the
SEEN bit and don't do anything with it. For example, following compile
tested only patch.

Now we will not touch SEEN bit at all. And even if SEEN gets set
since we sampled, errseq_check_mask_seen() will not flag it as
error.

Thanks
Vivek

---
 lib/errseq.c |   17 +++++++++++++++++
 1 file changed, 17 insertions(+)

Index: redhat-linux/lib/errseq.c
===================================================================
--- redhat-linux.orig/lib/errseq.c	2020-06-09 08:59:29.712836019 -0400
+++ redhat-linux/lib/errseq.c	2020-12-02 13:40:08.085775647 -0500
@@ -130,6 +130,12 @@ errseq_t errseq_sample(errseq_t *eseq)
 }
 EXPORT_SYMBOL(errseq_sample);
 
+errseq_t errseq_sample_mask_seen(errseq_t *eseq)
+{
+	return READ_ONCE(*eseq) & (~ERRSEQ_SEEN);
+}
+EXPORT_SYMBOL(errseq_sample_mask_seen);
+
 /**
  * errseq_check() - Has an error occurred since a particular sample point?
  * @eseq: Pointer to errseq_t value to be checked.
@@ -151,6 +157,17 @@ int errseq_check(errseq_t *eseq, errseq_
 }
 EXPORT_SYMBOL(errseq_check);
 
+int errseq_check_mask_seen(errseq_t *eseq, errseq_t since)
+{
+	errseq_t cur = READ_ONCE(*eseq) & (~ERRSEQ_SEEN);
+
+	since &= ~ERRSEQ_SEEN;
+	if (likely(cur == since))
+		return 0;
+	return -(cur & MAX_ERRNO);
+}
+EXPORT_SYMBOL(errseq_check_mask_seen);
+
 /**
  * errseq_check_and_advance() - Check an errseq_t and advance to current value.
  * @eseq: Pointer to value being checked and reported.

