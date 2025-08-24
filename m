Return-Path: <linux-fsdevel+bounces-58894-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45940B33112
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Aug 2025 17:09:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FFF72083C3
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Aug 2025 15:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A18FD2DC334;
	Sun, 24 Aug 2025 15:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FAalNz8n";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cB54om5a"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0D319CCF5;
	Sun, 24 Aug 2025 15:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756048102; cv=none; b=mdytUqSjeniSbhJ/wy0Y6aAtm7U/KPvMlufaeh3TJPt3IkFMcZuWTd0Z0/3LnEYtmiRFk1AbmSWV9a6MjzrJYhsyO7tCNZ/1pr/5oS4YZCs30t6yg+jS3F1jch0xlt+CnreEDmz6V8M8kG2kW1TEPMsHOc5+VDQnXNyv8DMzphk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756048102; c=relaxed/simple;
	bh=Dq1qy+YsZuSC9Eurnh5XV529yl3EMbTPy6RJtwpAa+c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gXHi/jvhLBlRt8zKLRsYKAOCEs++rUAVfRLwDSgSdz2KG1lPndU+UoXb37DJc6UD/XIjwr758EmplJCN8chOuye3BPvrFRrQqBl2N3N+IcSUgNc9ghVRsaICxh7hrriDSi1zrfhmGlhhRsO5SWLakdR9yUHiWAhy0F5YQeCOdBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FAalNz8n; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cB54om5a; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756048097;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3ik/NRqYHSG8hmITK6G3KaWPdzyg/qMeKl48YWWYUqc=;
	b=FAalNz8n80tXbjLu1YEIFUu9UhX73vltRahVCO39qSG0lfGoaJew0vQszt0dphBAjPSnLe
	7C/FD4/TKQG67Y1B/y0dsYTwbjJzp8XI+uPmsYWLSRhFSL8psTth1rBNfiHP7Pwxv8lCkS
	TDI4rdGp9S0oezXRjJ36bL2EAtg+sygQdbSF6fTVdqYLjKZ7jo4U5NfPpkFOr2o9HOuWTj
	/6PuKr1BAXjl0+x4heqkOUOddzMYeBWs8AGL29P6pJnHTVKAF8UGAby6xTND2ABPKNgVED
	AOj44YWy7naeuHasGmrTDOFaMXE/8Txy4Eo3Krw9/b2ZNN1pdjjL+l+L00m6aQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756048097;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3ik/NRqYHSG8hmITK6G3KaWPdzyg/qMeKl48YWWYUqc=;
	b=cB54om5a1WjZnAiZL0WpPY1A+vjsjucby/u6/KzywEDaNIPuqTKO2+T5qzphZpMpszCuEW
	b3lofR6L1VonsTDQ==
To: Christophe Leroy <christophe.leroy@csgroup.eu>, Michael Ellerman
 <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Madhavan
 Srinivasan <maddy@linux.ibm.com>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan
 Kara <jack@suse.cz>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra
 <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>, Davidlohr
 Bueso <dave@stgolabs.net>, Andre Almeida <andrealmeid@igalia.com>, Andrew
 Morton <akpm@linux-foundation.org>, David Laight
 <david.laight.linux@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, Daniel Borkmann
 <daniel@iogearbox.net>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-block@vger.kernel.org
Subject: Re: [PATCH v2 03/10] uaccess: Add
 masked_user_{read/write}_access_begin
In-Reply-To: <7b570e237f7099d564d7b1a270169428ac1f3099.1755854833.git.christophe.leroy@csgroup.eu>
References: <cover.1755854833.git.christophe.leroy@csgroup.eu>
 <7b570e237f7099d564d7b1a270169428ac1f3099.1755854833.git.christophe.leroy@csgroup.eu>
Date: Sun, 24 Aug 2025 17:08:15 +0200
Message-ID: <87h5xw3ggw.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Aug 22 2025 at 11:57, Christophe Leroy wrote:

> Allthough masked_user_access_begin() is to only be used when reading
> data from user at the moment, introduce masked_user_read_access_begin()
> and masked_user_write_access_begin() in order to match
> user_read_access_begin() and user_write_access_begin().
>
> That means masked_user_read_access_begin() is used when user memory is
> exclusively read during the window, masked_user_write_access_begin()
> is used when user memory is exclusively writen during the window,
> masked_user_access_begin() remains and is used when both reads and
> writes are performed during the open window. Each of them is expected
> to be terminated by the matching user_read_access_end(),
> user_write_access_end() and user_access_end().
>
> Have them default to masked_user_access_begin() when they are
> not defined.

Have you seen:

    https://lore.kernel.org/all/20250813151939.601040635@linutronix.de


