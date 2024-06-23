Return-Path: <linux-fsdevel+bounces-22216-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D058913EE5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2024 00:14:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5F901C21744
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Jun 2024 22:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3415F1862A8;
	Sun, 23 Jun 2024 22:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZBDHxZq4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gMWDS26G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0568003F;
	Sun, 23 Jun 2024 22:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719180826; cv=none; b=RxSjneifrSvrToMUe0w5KY8Mpv93e7sP0rNTQEdOsW6HXsyIoxfLx5a1Bf2SkDobCyWSVEl4nTYd96idXDe/CmsEpV8uFA+ReDgXf/uNlXUUH8LqmfsgAzIRmSvcfN/8zzDwYBTS1Cfu1xfqw4b4DOl7JmgXP8/W+w0SJYdgp2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719180826; c=relaxed/simple;
	bh=f8kaUBagZFtEFyq+MBnPMyRaOguqqaVyC/qP5EvdTuQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=esxBtE6QXB2CpaBa3ZyHlglTbNoJZcdQVIMtIpDGbb5j05zKujlDcThfMKyi2BwKwt6EWBmbVHEjJMoC1PizLSC/gE2MU63DRCb6oQGgZ2/nuZJPsEwl5LzE32dGuhXj/qIIV42SgMGRSPJlJN9At7jyQ+Q88c0hhY/86tSay78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZBDHxZq4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gMWDS26G; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719180817;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oCZy9PHIwaJxdVUqA4bjRvSlHrCD3VPWXgi6d8HRy84=;
	b=ZBDHxZq4UWJwAkXHVqYoOKe5RdE5P6K0bCr7EQS7yi6AlS6JqkdxIU1lyguem5kCZfdGTO
	otYJiUly1G8RkaoybczWigqswVuWnh/xlSoX9w9sUT6EHzEsChdCjFxgpFRMz4Fl4L7ko9
	IghkuICUQ3YNtMRi3/8DnkveEU7gVK2y/RKDQ6Q+Akmzgb+6okIj+DBqhL37ydwMharZha
	KE3qVwrOUaaqVPmAVQzC+O8Zdf34yz5OcM0BGz2bJDlRRdnuY4aUsWelQTCqEKRbK94KWd
	axtbHKQBWyrivhna9NI2u933vL5pcmTs6h6/+3tEoOQ21lZxJFEfEMqbX9Q+iQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719180817;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oCZy9PHIwaJxdVUqA4bjRvSlHrCD3VPWXgi6d8HRy84=;
	b=gMWDS26G3xyhqDiLmYwVGq9nj/4yQpFI7Mvc0wCBa2aDhbUlPGq6X/77X64enm26GAnpka
	Qc9sJ+0YzwoG0PBQ==
To: Kent Overstreet <kent.overstreet@linux.dev>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>, Kent Overstreet
 <kent.overstreet@linux.dev>, brauner@kernel.org, viro@zeniv.linux.org.uk,
 Bernd Schubert <bernd.schubert@fastmail.fm>, linux-mm@kvack.org, Josef
 Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH 3/5] fs: sys_ringbuffer
In-Reply-To: <20240603003306.2030491-4-kent.overstreet@linux.dev>
References: <20240603003306.2030491-1-kent.overstreet@linux.dev>
 <20240603003306.2030491-4-kent.overstreet@linux.dev>
Date: Mon, 24 Jun 2024 00:13:36 +0200
Message-ID: <87frt39ujz.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kent!

On Sun, Jun 02 2024 at 20:33, Kent Overstreet wrote:
> +/*
> + * ringbuffer_ptrs - head and tail pointers for a ringbuffer, mappped to
> + * userspace:
> + */
> +struct ringbuffer_ptrs {

The naming is confusing. ringbuffer_ctrl or something like that would be
more clear because it's more than just the pointers, which are in fact
positions. You have size, mask ... too, no?

> +	/*
> +	 * We use u32s because this type is shared between the kernel and
> +	 * userspace - ulong/size_t won't work here, we might be 32bit userland
> +	 * and 64 bit kernel, and u64 would be preferable (reduced probability
> +	 * of ABA) but not all architectures can atomically read/write to a u64;
> +	 * we need to avoid torn reads/writes.

union rbmagic {
	u64	__val64;
        struct {
                // TOOTIRED: Add big/little endian voodoo
	        u32	__val32;
                u32	__unused;
        };
};

Plus a bunch of accessors which depend on BITS_PER_LONG, no?

Thanks,

        tglx






