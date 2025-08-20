Return-Path: <linux-fsdevel+bounces-58418-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE624B2E904
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 01:48:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 937CB7B87D3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Aug 2025 23:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C57F92DCF56;
	Wed, 20 Aug 2025 23:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="RodaoD32"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ADF6277C96;
	Wed, 20 Aug 2025 23:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755733703; cv=none; b=BmQVJv3zrX71uVMTERutJsS/cHsr7aYwr7BnaL2RRW90ZxVoKXYeHPx5+e2biOqxcmM12sVJC6kjgyYH8Yrgw1LcCsCqGOthdl8Gc0jhZAn23qgD70p4kOLvSO3AV830Q1zRwyJKQCDgQd02B7yGFbNbp74V+45KqQfpMz49UB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755733703; c=relaxed/simple;
	bh=TBIUh3v0aC3WaehxkLqVs1qoFwUO6clBDRYkpK3wpHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mgE+znOs0Kv7+RjbFIPdZP6iZYOv4VIeaRfvd6txIxS86SqCP5ZuJzEBPEcjNWvYli7Zom4BB0CclFt/TDgDb0hA0UvaDo3QsLxRQg8s4T3hjx429o/gUi4LTpReg1RErM8UqDhOzindQBGcYEmnaU8iFSXBq5J1uhPr7HweELA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=RodaoD32; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=W2KYp9Ckcfqj597p33Lwk5ZySswdeUnAtCa067zilzc=; b=RodaoD32I1/AtcsipP0yTMLiah
	ogbQDVtg5U7sqAsoe0D62Rqa2nRFaSioDLt+xkSSboPWWiTGy0cLyhmt6x5XQBZmPV1anSuEoBT9f
	EwdgUfta4h2nSGeIKJEo5iNOb7QuSTtW72v+bMQQX9usToa+LLzn7YWFian57NirX7fI1lOxH2k8K
	0G0Rai4qBNAY3j209LF1mlmeBoP0wijRoCb7dcCZ3fHLl2Zo/2hYwv1Hjr/Lk/BPsUfpuifHpCeos
	afcpGPh+qn/JGKNndSv3apzjeOl6aKpA1kuyQvKi6WWqRpD2UK2E0J0J4VZjhsHlyi062TqsdGErW
	rx2KL1PA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uosXP-00000003zKx-1MlO;
	Wed, 20 Aug 2025 23:48:15 +0000
Date: Thu, 21 Aug 2025 00:48:15 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Laight <david.laight.linux@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	x86@kernel.org, Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [patch 0/4] uaccess: Provide and use helpers for user masked
 access
Message-ID: <20250820234815.GA656679@ZenIV>
References: <20250813150610.521355442@linutronix.de>
 <20250817144943.76b9ee62@pumpkin>
 <20250818222106.714629ee@pumpkin>
 <CAHk-=wibAE=yDhWdY7jQ7xvCtbmW5Tjtt_zMJcEzey3xfL=ViA@mail.gmail.com>
 <20250818222111.GE222315@ZenIV>
 <CAHk-=whvSAi1+fr=YSXU=Ax204V1TP-1c_3Y3p2TjznxSo=_3Q@mail.gmail.com>
 <20250819003908.GF222315@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819003908.GF222315@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Aug 19, 2025 at 01:39:09AM +0100, Al Viro wrote:
> I'm still trying to come up with something edible for lock_mount() -
> the best approximation I've got so far is
> 
> 	CLASS(lock_mount, mp)(path);
> 	if (IS_ERR(mp.mp))
> 		bugger off

... and that does not work, since DEFINE_CLASS() has constructor return
a value that gets copied into the local variable in question.

Which is unusable for situations when a part of what constructor is
doing is insertion of that local variable into a list.

__cleanup() per se is still usable, but... no DEFINE_CLASS for that kind
of data structures ;-/

