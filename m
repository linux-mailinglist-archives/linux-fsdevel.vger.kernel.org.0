Return-Path: <linux-fsdevel+bounces-53797-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F58EAF7482
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 14:46:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0126C1C8045B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 12:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B31274FCB;
	Thu,  3 Jul 2025 12:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Uh/tp8cE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6152F29;
	Thu,  3 Jul 2025 12:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751546804; cv=none; b=sq1MCZWPmtkYorDUAwYLQsSbjD9irWBsMwsWpMCjFHrm0lRVh3Yk31+ao3JOVWP3zjZPVhDvldnMOBNHWWn5GCCu3YwCskPifAcxHGdvGj58J+xVIPlRbS5rgbBMqwsnCsKN5f0nF1jWbwXiRrMkIMFXqZy1Isu0j/EqYRGd7wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751546804; c=relaxed/simple;
	bh=mp40cjvepCQgKtZQVLT1Hw4inCVI29fLBN8FjgZ0QI8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iJ4JDybZc3ySq6rcmsBksQzwtJb/OXZ6ckQ9SqKAtpZ2kzvdr5mceGXNfLn9y1zFq73ItKL7OdLgxrkFwrBosqvtZ0zWSRwtE8D/b+4ct9YYk9A349Q1xpKmGgCKjp+gMLzyuDuo6i80WxXgvo0VT3aXzmPe9CS8bvz+LlCYSso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=Uh/tp8cE; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=HdJz+59RreHrgcp30WhqNIopahdkIoDA5pLVohUNIiI=; b=Uh/tp8cE95qFHsZb26LT+2R16g
	XodkKFjokPkArTYxf0hfAqx28Rt7F53GqSftOcRdq+GQ+BBpPAnskXVRnrBOgECpIZXqxb4+Sx5ip
	qIInEgsdgoTokD26dEoHigoD63YJQ8LZq55uTm/GQjWuhdOjN3TvLocsOJLzAbitG12MwvwxZhn36
	d/GSUZBXLKIhtibv82gCXgvBLyP7ZveLnwIWhkEbLTZ99gdzcHk77adedrdEdMe9XQJb2ZD+a/a1Z
	mPIKdjAT/oGwzTdiz+GE+gAFOAes1wK2wd5/QgTWbxsrFLgiD/FRsH9ElCDF7rXTT2wrIKsSXSbTM
	VFEWGGwA==;
Received: from bl23-10-177.dsl.telepac.pt ([144.64.10.177] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1uXJKi-00Bu9u-8x; Thu, 03 Jul 2025 14:46:32 +0200
From: Luis Henriques <luis@igalia.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Bernd Schubert <bernd@bsbernd.com>,  Laura Promberger
 <laura.promberger@cern.ch>,  Dave Chinner <david@fromorbit.com>,  Matt
 Harvey <mharvey@jumptrading.com>,  linux-fsdevel@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] fuse: new workqueue to periodically invalidate
 expired dentries
In-Reply-To: <87bjq2k0tm.fsf@igalia.com> (Luis Henriques's message of "Wed, 02
	Jul 2025 17:35:33 +0100")
References: <20250520154203.31359-1-luis@igalia.com>
	<CAJfpegue3szRGZs+ogvYjiVt0YUo-=e+hrj-r=8ZDy11Zgrt9w@mail.gmail.com>
	<87bjq2k0tm.fsf@igalia.com>
Date: Thu, 03 Jul 2025 13:46:26 +0100
Message-ID: <87ldp5e925.fsf@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 02 2025, Luis Henriques wrote:

> On Wed, Jul 02 2025, Miklos Szeredi wrote:
>
>> On Tue, 20 May 2025 at 17:42, Luis Henriques <luis@igalia.com> wrote:
>>>
>>> This patch adds a new module parameter 'inval_wq' which is used to star=
t a
>>> workqueue to periodically invalidate expired dentries.  The value of th=
is
>>> new parameter is the period, in seconds, of the workqueue.  When it is =
set,
>>> every new dentry will be added to an rbtree, sorted by the dentry's exp=
iry
>>> time.
>>>
>>> When the workqueue is executed, it will check the dentries in this tree=
 and
>>> invalidate them if:
>>>
>>>   - The dentry has timed-out, or if
>>>   - The connection epoch has been incremented.
>>
>> I wonder, why not make the whole infrastructure global?  There's no
>> reason to have separate rb-trees and workqueues for each fuse
>> instance.
>
> Hmm... true.  My initial approach was to use a mount parameter to enabled
> it for each connection.  When you suggested replacing that by a module
> parameter, I should have done that too.

While starting working on this, I realised there's an additional
complication with this approach.  Having a dentries tree per connection
allows the workqueue to stop walking through the tree once we find a
non-expired dentry: it has a valid timestamp *and* it's epoch is equal to
the connection epoch.

Moving to a global tree, I'll need to _always_ walk through all the
dentries, because the epoch for a specific connection may have been
incremented.

So, I can see two options to solve this:

1) keep the design as is (i.e. a tree/workqueue per connection), or

2) add another flag indicating whether there has been an epoch increment
   in any connection, and only keep walking through all the dentries in
   that case.

A third option could be to change dentries timestamps and re-order the
tree when there's an epoch increment.  But this would probably be messy,
and very hacky I believe.

Any thoughts?

Cheers,
--=20
Lu=C3=ADs


>> Contention on the lock would be worse, but it's bad as it
>> is, so need some solution, e.g. hashed lock, which is better done with
>> a single instance.
>
> Right, I'll think how to fix it (or at least reduce contention).
>
>>> The workqueue will run for, at most, 5 seconds each time.  It will
>>> reschedule itself if the dentries tree isn't empty.
>>
>> It should check need_resched() instead.
>
> OK.
>
>>> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
>>> index 1fb0b15a6088..257ca2b36b94 100644
>>> --- a/fs/fuse/dir.c
>>> +++ b/fs/fuse/dir.c
>>> @@ -34,33 +34,153 @@ static void fuse_advise_use_readdirplus(struct ino=
de *dir)
>>>         set_bit(FUSE_I_ADVISE_RDPLUS, &fi->state);
>>>  }
>>>
>>> -#if BITS_PER_LONG >=3D 64
>>> -static inline void __fuse_dentry_settime(struct dentry *entry, u64 tim=
e)
>>> +struct fuse_dentry {
>>> +       u64 time;
>>> +       struct rcu_head rcu;
>>> +       struct rb_node node;
>>> +       struct dentry *dentry;
>>> +};
>>> +
>>
>> You lost the union with rcu_head.   Any other field is okay, none of
>> them matter in rcu protected code.  E.g.
>>
>> struct fuse_dentry {
>>         u64 time;
>>         union {
>>                 struct rcu_head rcu;
>>                 struct rb_node node;
>>         };
>>         struct dentry *dentry;
>> };
>
> Oops.  I'll fix that.
>
> Thanks a lot for your feedback, Miklos.  Much appreciated.  I'll re-work
> this patch and send a new revision shortly.
>
> Cheers,
> --=20
> Lu=C3=ADs


