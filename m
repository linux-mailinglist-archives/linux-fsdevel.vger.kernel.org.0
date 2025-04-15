Return-Path: <linux-fsdevel+bounces-46457-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62D87A89B32
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 12:55:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15DCE17851C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 10:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BF6328DEF0;
	Tue, 15 Apr 2025 10:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="NLrVg/EP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ECCA142E86;
	Tue, 15 Apr 2025 10:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744714213; cv=none; b=iCh3LzzVQu/suMMpevvdwpbXrq+gf48LQqCs0DgBnq2G1XVCnvVf1IvA3bAkXB/AKvGN6segjI00L7UJ+9mlxIgRY+R2taOP1LTl1zfnC76YTkam0sfivI3BPrsWZu1OW3I/R98K8o9+wR3WxRwa6GIv8FLKY5UUnLZmcI8uKdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744714213; c=relaxed/simple;
	bh=p+ghg0mGnX6/WXjLsCM9dHbnAKJOL5jmZb5HqDoFwDc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kFd/shjJhI4F+8bHxmR8k6VC97XkVgrLZgpB0ovhH8LEJymFq7bClA2bHb1dK7k2f+QpickohxVImAfmkABf1at5kA3xKJUEeO+9wsM2cQf/xIKaYOPoUbcR59lClvs0dhudr3Mpyrdk+51JIOn5A0gniIxBBhhHhC2wtyztzZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=NLrVg/EP; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=tLiyVJjlMxJiVbJ5LPtuPyytkXo0xWM6xLD7i8YBp/g=; b=NLrVg/EPAd0QGZ00vPjIQaIfr1
	1ZgJ31J7V5kZvhL/X9A0LoIxP8bvZyEgFh7IQtnn7kaRMBVYab4GD+JmbW39pNAvxRGonlrFZMTr0
	mhSNSsB0JQNmE0tCsj4Hvbk8dWIUUvdR2OxOyfsw93fiSjpB/7QJAXmdGRZEGLWqKbCIsyKYbQ/0j
	AcLIeuo2XHxHfONOAnXocGzPu1stkW/7040/Dmu7tgpKz8WWPXJ7WJogZjkZh66wO+zJwfXOutcMi
	ClprXfu6uplRDAHSFN1kVC0F8JxPv/ntWRuRTbBGr/r+7TvhJ5ByuMp3mC0oQQ+J1vfgOF/URJkW6
	hOoZHMJQ==;
Received: from bl23-10-177.dsl.telepac.pt ([144.64.10.177] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1u4drb-00Gu6S-Le; Tue, 15 Apr 2025 12:49:59 +0200
From: Luis Henriques <luis@igalia.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Laura Promberger <laura.promberger@cern.ch>,  Bernd Schubert
 <bschubert@ddn.com>,  Dave Chinner <david@fromorbit.com>,  Matt Harvey
 <mharvey@jumptrading.com>,  "linux-fsdevel@vger.kernel.org"
 <linux-fsdevel@vger.kernel.org>,  "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8] fuse: add more control over cache invalidation
 behaviour
In-Reply-To: <CAJfpegu-x88d+DGa=x_EfvWWCjnkZYjO8MwjAc4bGQky8kBi3g@mail.gmail.com>
	(Miklos Szeredi's message of "Tue, 15 Apr 2025 12:41:40 +0200")
References: <20250226091451.11899-1-luis@igalia.com>
	<87msdwrh72.fsf@igalia.com>
	<CAJfpegvcEgJtmRkvHm+WuPQgdyeCQZggyExayc5J9bdxWwOm4w@mail.gmail.com>
	<875xk7zyjm.fsf@igalia.com>
	<GV0P278MB07182F4A1BDFD2506E2F58AC85B62@GV0P278MB0718.CHEP278.PROD.OUTLOOK.COM>
	<87r01tn269.fsf@igalia.com>
	<CAJfpegu-x88d+DGa=x_EfvWWCjnkZYjO8MwjAc4bGQky8kBi3g@mail.gmail.com>
Date: Tue, 15 Apr 2025 11:49:54 +0100
Message-ID: <87mschn1gt.fsf@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 15 2025, Miklos Szeredi wrote:

> On Tue, 15 Apr 2025 at 12:34, Luis Henriques <luis@igalia.com> wrote:
>>
>> Hi Laura,
>>
>> On Fri, Apr 11 2025, Laura Promberger wrote:
>>
>> > Hello Miklos, Luis,
>> >
>> > I tested Luis NOTIFY_INC_EPOCH patch (kernel, libfuse, cvmfs) on RHEL9=
 and can
>> > confirm that in combination with your fix to the symlink truncate it s=
olves all
>> > the problem we had with cvmfs when applying a new revision and at the =
same time
>> > hammering a symlink with readlink() that would change its target. (
>> > https://github.com/cvmfs/cvmfs/issues/3626 )
>> >
>> > With those two patches we no longer end up with corrupted symlinks or =
get stuck on an old revision.
>> > (old revision was possible because the kernel started caching the old =
one again during the update due to the high access rate and the asynchronou=
s evict of inodes)
>> >
>> > As such we would be very happy if this patch could be accepted.
>>
>> Even though this patch and the one that fixed the symlinks corruption [1]
>> aren't really related, it's always good to have extra testing.  Thanks a
>> lot for your help, Laura.
>>
>> In the meantime, I hope to send a refreshed v9 of this patch soon (maybe
>> today) as it doesn't apply cleanly to current master anymore.  And I also
>> plan to send v2 of the (RFC) patch that adds the workqueue to clean-up
>> expired cache entries.
>
> Don't bother, I just applied the patch with the conflicts fixed up.

Oh, awesome!  Thanks a lot, Miklos.  I'll focus on the other patch and try
to send v2 later today.

Cheers,
--=20
Lu=C3=ADs

