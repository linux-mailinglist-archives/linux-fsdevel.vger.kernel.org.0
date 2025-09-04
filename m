Return-Path: <linux-fsdevel+bounces-60276-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DDD0B43E4B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 16:13:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 067415807C8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 14:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78C0C306D54;
	Thu,  4 Sep 2025 14:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="erLmGv29"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44638305E0A;
	Thu,  4 Sep 2025 14:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756995118; cv=none; b=IuQMxC2GQemrVCxC6sxCOnia3QASsyoyk2ziVxspF2SLSc5OYpjEnx79kJ5Bp6FHSEWM2xDjuylC0Rf6QxBai1ncQkfzN2xs58y+oKnHlDUBCcYtzGyHsdKAFx87xP63AXAcrojsCvcBBvhfAAU0zOnqt7l+Tk9gtCUrG/H+WNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756995118; c=relaxed/simple;
	bh=utL/hvyvlUQpYol5f6J0fFo6dlTgPmA4bPjXAidhQKQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kELrVVkcw4I4KZyKTzcY+97cRoMXUoJ7eIdidoIG1Ap9smz8aJ0NGHJgTP5wDViWsUee56ARpCrxS47w3HeqWwrbCZBdf+vqzE6wkHFN8zTBnWP88nV5DZq7F/eyK2w1l0oMiZIseZiNSq/O1+absrLWcowQ/2ptfbcKhkBi92M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=erLmGv29; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=mRBP1CRRV1Du0h4tEFXFsQMRTI1HtxH3w5mPmb2Zc/o=; b=erLmGv29uMcJgIovhlZuQRHz/7
	LmjiD0N15xO4SssgVtlyzdKCQdMTQ273OuNwmOFTxr2ZUYM+wXjxyrx0GRqFVHj0CAyPwp/hzx0v/
	gCYp9y+aAJdBmek5+sDskbFO/R/eXP0Ykq6hl9S5M2YzdZ+lp144TDZdbk/x3e7HFhosBQdOHgo/2
	fZAqA+BHK1Z5FUCcoDTgCLUR5Z2QqzIQbyfMRewFbL5UmbcvqF8PuEHx6p9XStG1WIoYyPLOULMZS
	FSIug1wYhUfYK9zV7R3DsGEh7tk8IK5hs551igIdUBKt0KPPuz8CnYq/bzh7tUpChmXVtpYYH2Y7k
	S5UEbxBg==;
Received: from bl17-145-117.dsl.telepac.pt ([188.82.145.117] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1uuAgn-006p0S-7T; Thu, 04 Sep 2025 16:11:49 +0200
From: Luis Henriques <luis@igalia.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Bernd Schubert <bernd@bsbernd.com>,  Laura Promberger
 <laura.promberger@cern.ch>,  Dave Chinner <david@fromorbit.com>,  Matt
 Harvey <mharvey@jumptrading.com>,  linux-fsdevel@vger.kernel.org,
  kernel-dev@igalia.com,  linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v5 2/2] fuse: new work queue to invalidate dentries
 from old epochs
In-Reply-To: <CAJfpegtmmxNozcevgP335nyZui3OAYBkvt-OqA7ei+WTNopbrg@mail.gmail.com>
	(Miklos Szeredi's message of "Thu, 4 Sep 2025 12:35:25 +0200")
References: <20250828162951.60437-1-luis@igalia.com>
	<20250828162951.60437-3-luis@igalia.com>
	<CAJfpegtmmxNozcevgP335nyZui3OAYBkvt-OqA7ei+WTNopbrg@mail.gmail.com>
Date: Thu, 04 Sep 2025 15:11:43 +0100
Message-ID: <87tt1il334.fsf@wotan.olymp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 04 2025, Miklos Szeredi wrote:

> On Thu, 28 Aug 2025 at 18:30, Luis Henriques <luis@igalia.com> wrote:
>>
>> With the infrastructure introduced to periodically invalidate expired
>> dentries, it is now possible to add an extra work queue to invalidate
>> dentries when an epoch is incremented.  This work queue will only be
>> triggered when the 'inval_wq' parameter is set.
>>
>> Signed-off-by: Luis Henriques <luis@igalia.com>
>> ---
>>  fs/fuse/dev.c    |  7 ++++---
>>  fs/fuse/dir.c    | 34 ++++++++++++++++++++++++++++++++++
>>  fs/fuse/fuse_i.h |  4 ++++
>>  fs/fuse/inode.c  | 41 ++++++++++++++++++++++-------------------
>>  4 files changed, 64 insertions(+), 22 deletions(-)
>>
>> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
>> index e80cd8f2c049..48c5c01c3e5b 100644
>> --- a/fs/fuse/dev.c
>> +++ b/fs/fuse/dev.c
>> @@ -2033,13 +2033,14 @@ static int fuse_notify_resend(struct fuse_conn *=
fc)
>>
>>  /*
>>   * Increments the fuse connection epoch.  This will result of dentries =
from
>> - * previous epochs to be invalidated.
>> - *
>> - * XXX optimization: add call to shrink_dcache_sb()?
>
> I guess it wouldn't hurt.   Definitely simpler, so I'd opt for this.

So, your suggesting to have the work queue simply calling this instead of
walking through the dentries?  (Or even *not* having a work queue at all?)

>>  void fuse_conn_put(struct fuse_conn *fc)
>>  {
>> -       if (refcount_dec_and_test(&fc->count)) {
>> -               struct fuse_iqueue *fiq =3D &fc->iq;
>> -               struct fuse_sync_bucket *bucket;
>> -
>> -               if (IS_ENABLED(CONFIG_FUSE_DAX))
>> -                       fuse_dax_conn_free(fc);
>> -               if (fc->timeout.req_timeout)
>> -                       cancel_delayed_work_sync(&fc->timeout.work);
>> -               if (fiq->ops->release)
>> -                       fiq->ops->release(fiq);
>> -               put_pid_ns(fc->pid_ns);
>> -               bucket =3D rcu_dereference_protected(fc->curr_bucket, 1);
>> -               if (bucket) {
>> -                       WARN_ON(atomic_read(&bucket->count) !=3D 1);
>> -                       kfree(bucket);
>> -               }
>> -               if (IS_ENABLED(CONFIG_FUSE_PASSTHROUGH))
>> -                       fuse_backing_files_free(fc);
>> -               call_rcu(&fc->rcu, delayed_release);
>> +       struct fuse_iqueue *fiq =3D &fc->iq;
>> +       struct fuse_sync_bucket *bucket;
>> +
>> +       if (!refcount_dec_and_test(&fc->count))
>> +               return;
>
> Please don't do this.  It's difficult to see what actually changed this w=
ay.

Right, that didn't occur to me.  Sorry.  I'll probably add a separate
patch to re-indent this function, which makes it easier to read in my
opinion.  Not sure that's acceptable, so feel free to drop it silently :-)

Cheers,
--=20
Lu=C3=ADs

