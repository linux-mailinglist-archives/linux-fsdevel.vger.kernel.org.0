Return-Path: <linux-fsdevel+bounces-60274-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FE26B43DEE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 16:00:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94AE41BC6122
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 14:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C695830147F;
	Thu,  4 Sep 2025 14:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="AuGUuNxS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121EC22172D;
	Thu,  4 Sep 2025 14:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756994436; cv=none; b=KXE98Hv3+E+bDe9/XsK8JqxfL+TJmeGibNUEqdFHlG5opmhXFg3T8kODMV4zsKEkPvfuSez/Z+55+cLDZUIWj00SFWRrNZ1+CXfhTc4L3WhOTqJ5GcYMrF/4MwCNCx6PMxxCI3LqgJexQs5zzs8d9tsqEXrsElhlET/M26KLXWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756994436; c=relaxed/simple;
	bh=BKBOcbU8gLSyiJEZrgL6nEaRg/ajHC/VSrb++0xnuyk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=INcomYBPdgjh54z85Rr7dcVR9IzFEigy+bJmsiMsWC/cj4WBMru+7s1xXV3GCUD66uIc//VE85bVp7v49ETvjjO9Xy2ST7HQamsNmGTTgXq7OtWM4k6F/QC/TiOjL6ejl3ZPPsZ2svV+RYV2FePX/p8KedtlNHerzzG6LvTBEUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=AuGUuNxS; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=MW0Q1jd9adc0m6VL8nlpW0J6Gu0gI2JKZg94zm/mgTM=; b=AuGUuNxSrEK5m4O0mhW40Qvt+w
	MKhqITk8Fdj9vLwvIzYxwnEa4QeS65rV/VUbB7Z03fCdc568UD09m0eQd1Qm1fLflmvQs7YUhAZzD
	D/cWLPGAUuvOr6mGkpCbSyPAQB0O1yLR/lpxFZZIC73SP9k4l2rjjRAFnhxLBnjzB1GLVjxlK+SVJ
	xHQvJaM45nTFWSd9XaN4j28W10q6kuyOmj3PoDyL5X1xHgncVdgYiN+dph0jJEin9cD/zc17DnpTW
	9B7GyKK05pIcsgVhGajfj6JOCw7u72na+IGE89F9BJv7ds2+YYZ4dICP2on0aHkxHqWcGIGoiob73
	LpK1scHA==;
Received: from bl17-145-117.dsl.telepac.pt ([188.82.145.117] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1uuAVd-006oSh-Vp; Thu, 04 Sep 2025 16:00:18 +0200
From: Luis Henriques <luis@igalia.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Bernd Schubert <bernd@bsbernd.com>,  Laura Promberger
 <laura.promberger@cern.ch>,  Dave Chinner <david@fromorbit.com>,  Matt
 Harvey <mharvey@jumptrading.com>,  linux-fsdevel@vger.kernel.org,
  kernel-dev@igalia.com,  linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v5 1/2] fuse: new work queue to periodically
 invalidate expired dentries
In-Reply-To: <CAJfpegtfeCJgzSLOYABTaZ7Hec6JDMHpQtxDzg61jAPJcRZQZA@mail.gmail.com>
	(Miklos Szeredi's message of "Thu, 4 Sep 2025 12:20:46 +0200")
References: <20250828162951.60437-1-luis@igalia.com>
	<20250828162951.60437-2-luis@igalia.com>
	<CAJfpegtfeCJgzSLOYABTaZ7Hec6JDMHpQtxDzg61jAPJcRZQZA@mail.gmail.com>
Date: Thu, 04 Sep 2025 15:00:12 +0100
Message-ID: <87y0qul3mb.fsf@wotan.olymp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Miklos,

On Thu, Sep 04 2025, Miklos Szeredi wrote:

> On Thu, 28 Aug 2025 at 18:30, Luis Henriques <luis@igalia.com> wrote:
>
>> +#define HASH_BITS      12
>
> Definitely too large.  My gut feeling gives 5, but it obviously
> depends on a lot of factors.

Right, to be honest I didn't spent a lot of time thinking about the
correct value for this constant.  But sure, 5 seems to be much more
reasonable.

>> +               schedule_delayed_work(&dentry_tree_work,
>> +                                     secs_to_jiffies(num));
>
> secs_to_jiffues() doesn't check overflow.  Perhaps simplest fix would
> be to constrain parameter to unsigned short.

Sounds good, thanks.

>> +MODULE_PARM_DESC(inval_wq,
>> +                "Dentries invalidation work queue period in secs (>=3D =
5).");
>
> __stringify(FUSE_DENTRY_INVAL_FREQ_MIN)
>
>> +       if (!inval_wq && RB_EMPTY_NODE(&fd->node))
>> +               return;
>
> inval_wq can change to zero, which shouldn't prevent removing from the rb=
tree.

Maybe I didn't understood your comment, but isn't that what's happening
here?  If the 'fd' is in a tree, it will be removed, independently of the
'inval_wq' value.

>> +static void fuse_dentry_tree_work(struct work_struct *work)
>> +{
>> +       struct fuse_dentry *fd;
>> +       struct rb_node *node;
>> +       int i;
>> +
>> +       for (i =3D 0; i < HASH_SIZE; i++) {
>> +               spin_lock(&dentry_hash[i].lock);
>> +               node =3D rb_first(&dentry_hash[i].tree);
>> +               while (node && !need_resched()) {
>
> Wrong place.
>
>> +                       fd =3D rb_entry(node, struct fuse_dentry, node);
>> +                       if (time_after64(get_jiffies_64(), fd->time)) {
>> +                               rb_erase(&fd->node, &dentry_hash[i].tree=
);
>> +                               RB_CLEAR_NODE(&fd->node);
>> +                               spin_unlock(&dentry_hash[i].lock);
>
> cond_resched() here instead.

/me slaps himself.

>> +                               d_invalidate(fd->dentry);
>
> Okay, so I understand the reasoning: the validity timeout for the
> dentry expired, hence it's invalid.  The problem is, this is not quite
> right.  The validity timeout says "this dentry is assumed valid for
> this period", it doesn't say the dentry is invalid after the timeout.
>
> Doing d_invalidate() means we "know the dentry is invalid", which will
> get it off the hash tables, giving it a "(deleted)" tag in proc
> strings, etc.  This would be wrong.

Understood.  Thanks a lot for taking the time to explain it.  This makes
it clear that using d_invalidate() here is incorrect, of course.

> What we want here is just get rid of *unused* dentries, which don't
> have any reference.  Referenced ones will get revalidated with
> ->d_revalidate() and if one turns out to be actually invalid, it will
> then be invalidated with d_invalidate(), otherwise the timeout will
> just be reset.
>
> There doesn't seem to be a function that does this, so new
> infrastructure will need to be added to fs/dcache.c.  Exporting
> shrink_dentry_list() and to_shrink_list() would suffice, but I wonder
> if the helpers should be a little higher level.

OK, I see how the to_shrink_list() and shrink_dentry_list() pair could
easily be used here.  This would even remove the need to do the
unlock/lock in the loop.

(By the way, I considered using mutexes here instead.  Do you have any
thoughts on this?)

What I don't understand in your comment is where you suggest these helpers
could be in a higher level.  Could you elaborate on what exactly you have
in mind?

>> +void fuse_dentry_tree_cleanup(void)
>> +{
>> +       struct rb_node *n;
>> +       int i;
>> +
>> +       inval_wq =3D 0;
>> +       cancel_delayed_work_sync(&dentry_tree_work);
>> +
>> +       for (i =3D 0; i < HASH_SIZE; i++) {
>
> If we have anything in there at module remove, then something is
> horribly broken.  A WARN_ON definitely suffices here.
>
>> --- a/fs/fuse/fuse_i.h
>> +++ b/fs/fuse/fuse_i.h
>> @@ -54,6 +54,12 @@
>>  /** Frequency (in jiffies) of request timeout checks, if opted into */
>>  extern const unsigned long fuse_timeout_timer_freq;
>>
>> +/*
>> + * Dentries invalidation workqueue period, in seconds.  It shall be >=
=3D 5
>
> If we have a definition of this constant, please refer to that
> definition here too.
>
>> @@ -2045,6 +2045,10 @@ void fuse_conn_destroy(struct fuse_mount *fm)
>>
>>         fuse_abort_conn(fc);
>>         fuse_wait_aborted(fc);
>> +       /*
>> +        * XXX prune dentries:
>> +        * fuse_dentry_tree_prune(fc);
>> +        */
>
> No need.

Yeah, I wasn't totally sure this would really be required here.

And again, thanks a lot for your review, Miklos!

Cheers,
--=20
Lu=C3=ADs

