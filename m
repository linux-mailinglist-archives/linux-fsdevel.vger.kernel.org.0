Return-Path: <linux-fsdevel+bounces-68526-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 884A3C5E6EB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 18:06:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id ACF71360E7C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 15:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73532335BD5;
	Fri, 14 Nov 2025 15:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="U4Q1tVN+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="E6YpF0oV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C7C3358D5;
	Fri, 14 Nov 2025 15:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763134177; cv=none; b=pkUspIqaQb4+4VRIKdTNJA5ekuGJmr4qcnuPKN2mo763KGw96C+BUn79B788q32o2l0XoldwPZ264dlbux8VAjS4knuKdeiEdV31jP9apU5522xqIiXQLcbxS9FnQKoW8wkja8jYC5LP2fNdaUFlrexlC8Fk2qt8vy/UhO7RlU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763134177; c=relaxed/simple;
	bh=Ppn1MoXtxHXmJpRdIAEUmUVlmJXDEOiIUfyU2xQQuiY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fEJC9XTs8XX0QlCVU5AHcXSkXPB4VYr7vMLRLIzacAPoBC3MhIyEidZiLK5fhL8hYSPxCXDoBD+8KGC9/HKk84iWwHoVGS7tRALiXWVU7mV9hEo9Ofs+A5cKGNZq2EKUSUGsv1yTUjH3Oulq3mC+rso/lLSmz1EkXzv+ua5UE18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=U4Q1tVN+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=E6YpF0oV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763134174;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aCFThorvRMmcaxjbBvY4SkqTfDyKCosULHbydV+TM3Q=;
	b=U4Q1tVN+GPpFVuSG9ZiwQX2nmhFEnoqL2AUr38KqD+kXAR+5QsfFpx3TnHyK4FnlGZQaVe
	c8cNaRfa/BVwVF/wgRwIOu7QaNwoBrcB9c0ZY+Nk7QbIriWJWDWSO9JaGeTcbkrp3JvDpc
	gmd03xihjYvZS0zF7rQDwOopcwvmMJJ4v92R4GAKU77E518wa5OWNbeNKO1DH06oXGTlH/
	DdJnNi1eszdb3w0yhKh8UrTae1tzHs3iAGUshiAJ8Qc/iAzMLWJPcs2mHNdaoyU2AYierh
	OiWBTeZQ9HQo8jY6Nb/6hPi9t3l5N6o5OZO5MEjTN60y/0/bW5r+s4cWSSOlug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763134174;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aCFThorvRMmcaxjbBvY4SkqTfDyKCosULHbydV+TM3Q=;
	b=E6YpF0oVyPlh8suzN701oq+c5X2FSTvYpNPjvHY8fAhILMdEnEUjV9YT1AnosJEK8Ww0GY
	GQO2qqRM5QDXztDQ==
To: Christian Brauner <brauner@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>
Cc: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Alexander Viro
 <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Ingo Molnar
 <mingo@redhat.com>, Darren Hart <dvhart@infradead.org>, Davidlohr Bueso
 <dave@stgolabs.net>, =?utf-8?Q?Andr=C3=A9?= Almeida
 <andrealmeid@igalia.com>, Anna-Maria
 Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker
 <frederic@kernel.org>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] restart_block: simplify expiration timestamps
In-Reply-To: <20251111-formel-seufzen-bdf2c97c735a@brauner>
References: <20251110-restart-block-expiration-v1-0-5d39cc93df4f@linutronix.de>
 <20251111-formel-seufzen-bdf2c97c735a@brauner>
Date: Fri, 14 Nov 2025 16:29:33 +0100
Message-ID: <87wm3sbpk2.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 11 2025 at 10:48, Christian Brauner wrote:
> On Mon, Nov 10, 2025 at 10:38:50AM +0100, Thomas Wei=C3=9Fschuh wrote:
>> Various expiration timestamps are stored in the restart block as
>> different types than their respective subsystem is using.
>>=20
>> Align the types.
>>=20
>> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
>> ---
>
> @Thomas, @Peter, do the timer/futex changes look fine to you?

I take them through tip as they are not conflicting with the poll part.

Thanks,

        tglx

