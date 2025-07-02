Return-Path: <linux-fsdevel+bounces-53679-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FE76AF5ED6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 18:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EAA21C457A0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 16:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA8923C4E9;
	Wed,  2 Jul 2025 16:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="I1fUlzcv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A902F50B5;
	Wed,  2 Jul 2025 16:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751474159; cv=none; b=b2VFx4RObZjBELrCDMkE4jyPoDFj7A1eOfX8KrXK12OXb2grOtzXIPgfgaDBLv8tHB2thOV7/pGalkgW9sH7qZ4GSFJuIuumVkz/bSHKuh/d5wydDaWvaDOnYdpzLyiLRlrJPYnX6RgE0Dp7v9MKrW5GzCd9TYjleJrhs8A6u7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751474159; c=relaxed/simple;
	bh=yZEjONrzcZENuzKEaQuvgIhNN+3lLCSPSnVgEE+2jDU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZnRODVM/MH9qx+mlQU96dwFz5r4/jgQ3qAh/eOhH6qpub541pAwiF6p58726/re+3H+1oVC6q79sN7WsI2FTUaDr+KyWjSLi/ZWpnwnEqvcPvEenRVoFFSeeZkPJNFy+PvwYkgPaKohUJ20l9hBCV9P+WfO5OAmPoElK/3fb2Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=I1fUlzcv; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=YqPYHUWKBExHrHxxYieGS7K3EpkIcdpaIqcCODsjLkc=; b=I1fUlzcvPF2opKVyBCNm08K86A
	Y1C8R3Po8WVGkTpbJHk82BQsaOS1cJEUDbPNf2lYAuRstG1SGP8pnLx29MLPcAGtagjG1fwADP9fW
	DUfmbl3uBGNOJMLyPkyja0I5O5dc9e5AhNEIrHtK4d2XXFY8YddSHTZMwo+MoYRCZk9HpH8A2bAOg
	MOty2462a0RODzVdmOZ/CrM30C9hWUh8WdfixpPU1V6dQ/5qKkToBaALP1re/h7sIRYS6fk9k2te9
	+tLFTHLTdxOLZj+fNu2I9bxBuwdio3P4LvAhh4bkF41c/HKF9B8WXxWonYZAYO2Wie8wHLxai8xfS
	D4dFiuUw==;
Received: from bl23-10-177.dsl.telepac.pt ([144.64.10.177] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1uX0Qt-00BXYj-OS; Wed, 02 Jul 2025 18:35:39 +0200
From: Luis Henriques <luis@igalia.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Bernd Schubert <bernd@bsbernd.com>,  Laura Promberger
 <laura.promberger@cern.ch>,  Dave Chinner <david@fromorbit.com>,  Matt
 Harvey <mharvey@jumptrading.com>,  linux-fsdevel@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] fuse: new workqueue to periodically invalidate
 expired dentries
In-Reply-To: <CAJfpegue3szRGZs+ogvYjiVt0YUo-=e+hrj-r=8ZDy11Zgrt9w@mail.gmail.com>
	(Miklos Szeredi's message of "Wed, 2 Jul 2025 17:39:58 +0200")
References: <20250520154203.31359-1-luis@igalia.com>
	<CAJfpegue3szRGZs+ogvYjiVt0YUo-=e+hrj-r=8ZDy11Zgrt9w@mail.gmail.com>
Date: Wed, 02 Jul 2025 17:35:33 +0100
Message-ID: <87bjq2k0tm.fsf@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 02 2025, Miklos Szeredi wrote:

> On Tue, 20 May 2025 at 17:42, Luis Henriques <luis@igalia.com> wrote:
>>
>> This patch adds a new module parameter 'inval_wq' which is used to start=
 a
>> workqueue to periodically invalidate expired dentries.  The value of this
>> new parameter is the period, in seconds, of the workqueue.  When it is s=
et,
>> every new dentry will be added to an rbtree, sorted by the dentry's expi=
ry
>> time.
>>
>> When the workqueue is executed, it will check the dentries in this tree =
and
>> invalidate them if:
>>
>>   - The dentry has timed-out, or if
>>   - The connection epoch has been incremented.
>
> I wonder, why not make the whole infrastructure global?  There's no
> reason to have separate rb-trees and workqueues for each fuse
> instance.

Hmm... true.  My initial approach was to use a mount parameter to enabled
it for each connection.  When you suggested replacing that by a module
parameter, I should have done that too.

> Contention on the lock would be worse, but it's bad as it
> is, so need some solution, e.g. hashed lock, which is better done with
> a single instance.

Right, I'll think how to fix it (or at least reduce contention).

>> The workqueue will run for, at most, 5 seconds each time.  It will
>> reschedule itself if the dentries tree isn't empty.
>
> It should check need_resched() instead.

OK.

>> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
>> index 1fb0b15a6088..257ca2b36b94 100644
>> --- a/fs/fuse/dir.c
>> +++ b/fs/fuse/dir.c
>> @@ -34,33 +34,153 @@ static void fuse_advise_use_readdirplus(struct inod=
e *dir)
>>         set_bit(FUSE_I_ADVISE_RDPLUS, &fi->state);
>>  }
>>
>> -#if BITS_PER_LONG >=3D 64
>> -static inline void __fuse_dentry_settime(struct dentry *entry, u64 time)
>> +struct fuse_dentry {
>> +       u64 time;
>> +       struct rcu_head rcu;
>> +       struct rb_node node;
>> +       struct dentry *dentry;
>> +};
>> +
>
> You lost the union with rcu_head.   Any other field is okay, none of
> them matter in rcu protected code.  E.g.
>
> struct fuse_dentry {
>         u64 time;
>         union {
>                 struct rcu_head rcu;
>                 struct rb_node node;
>         };
>         struct dentry *dentry;
> };

Oops.  I'll fix that.

Thanks a lot for your feedback, Miklos.  Much appreciated.  I'll re-work
this patch and send a new revision shortly.

Cheers,
--=20
Lu=C3=ADs

