Return-Path: <linux-fsdevel+bounces-65937-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D3C06C15A87
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 17:03:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F01375425F9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 15:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9374C27F171;
	Tue, 28 Oct 2025 15:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OzfJrQma";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+BHGZAi3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7014B2D5924;
	Tue, 28 Oct 2025 15:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761666969; cv=none; b=EOHdNrEN1Y7ID6khCASOCjri2A19BrAv/gW0350P9PbgpKZcJZomaeM6raRzl1kulIEE5vcIqfntDbxxnm5npsG1OJSPVZpIFhT4JVxaZLFtnSIQ9lrlzS8wtdkYEFFzetsZoGW3Ihe7XsuR9M8uaeP6l+vOGWj1SZfX+uGzpPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761666969; c=relaxed/simple;
	bh=admzwBoCYAT8mRQuQPQRTGEf4Z/ylGdqAKtHgRboJys=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mW0zn5Bz+Mi8B3wzqF4t7MmeoKdlKsU5nI08KAEJ6hxf9K/wGrhXuBbLC9BN+69kDUm2epmwV4AUMd+mlErNDeqgIWMmrJDN7UZzz4YdNAhSK+qQ73qqAH1+hNiAqvtGmp6hnmVVhaTGYW0fdhKfsbj/QhOGVe18qzSDwyXcZ8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OzfJrQma; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+BHGZAi3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761666964;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UuJ043THRvtCeNNEXMyo9HE4WCxrom2sWKd3gBR4LJU=;
	b=OzfJrQmaGSYN7SjKtIVGt8XfMPuNg4JidCQ8tWQK7AVcOCmFMWTyt7m3oaUqsJxpyM0pab
	+9VYgPLRugbHDX88KcBOysbJ/aq1qSI58eSdNkEqVOW7qjKTKIUy5Dlk/fxAOLwId5eUGL
	MMCc/R6qmw7qog3LmZOpn1hDbjFJ/yfaXhgNJR3gCLTsi/v5MgAafS4ZxWm/T3HYbhDBYz
	7c21YHT0Nu/Sjny5kfjGTXYYbNGtZT06Axwaf1pQQ7shqgfmdljAo2APs5uuRC3KZQDlgK
	uYX1vd7MjyQwAwEqJ1sI+OyJphVkD9lM3WBrKG1nbnqWkrsRgH5c5NF/n8hOYw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761666964;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UuJ043THRvtCeNNEXMyo9HE4WCxrom2sWKd3gBR4LJU=;
	b=+BHGZAi3yNFrAvpwe9vwol5p0lVACxAmOqomEwb4Pm2KqtlBgDYqoGb8xyRWB/0XxRQyXl
	VePkBymJj4BQJSAg==
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, LKML
 <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Darren Hart
 <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>, =?utf-8?Q?An?=
 =?utf-8?Q?dr=C3=A9?= Almeida
 <andrealmeid@igalia.com>, kernel test robot <lkp@intel.com>, Russell King
 <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, Linus
 Torvalds <torvalds@linux-foundation.org>, x86@kernel.org, Madhavan
 Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, linuxppc-dev@lists.ozlabs.org, Paul
 Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 linux-riscv@lists.infradead.org, Heiko Carstens <hca@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle
 <svens@linux.ibm.com>, linux-s390@vger.kernel.org, Andrew Cooper
 <andrew.cooper3@citrix.com>, David Laight <david.laight.linux@gmail.com>,
 Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix
 <nicolas.palix@imag.fr>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org
Subject: Re: [patch V5 10/12] futex: Convert to get/put_user_inline()
In-Reply-To: <0c979fe0-ee55-48be-bd0f-9bff71b88a1d@efficios.com>
References: <20251027083700.573016505@linutronix.de>
 <20251027083745.736737934@linutronix.de>
 <0c979fe0-ee55-48be-bd0f-9bff71b88a1d@efficios.com>
Date: Tue, 28 Oct 2025 16:56:03 +0100
Message-ID: <87frb3uijw.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Oct 28 2025 at 10:24, Mathieu Desnoyers wrote:
> On 2025-10-27 04:44, Thomas Gleixner wrote:
>> From: Thomas Gleixner <tglx@linutronix.de>
>> 
>> Replace the open coded implementation with the new get/put_user_inline()
>> helpers. This might be replaced by a regular get/put_user(), but that needs
>> a proper performance evaluation.
>
> I understand that this is aiming to keep the same underlying code,
> but I find it surprising that the first user of the "inline" get/put
> user puts the burden of the proof on moving this to regular
> get/put_user() rather than on using the inlined version.
>
> The comment above the inline API clearly states that performance
> numbers are needed to justify the use of inline, not the opposite.
>
> I am concerned that this creates a precedent that may be used by future
> users of the inline API to use it without performance numbers
> justification.

There was not justification for the open coded inline either and
converting it to get/put must be a completely seperate change.

