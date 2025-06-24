Return-Path: <linux-fsdevel+bounces-52812-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A3AFAE7146
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 23:08:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 657273A58C2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 21:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CEDD2550D2;
	Tue, 24 Jun 2025 21:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LkD5Fi5N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029203074B5;
	Tue, 24 Jun 2025 21:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750799303; cv=none; b=tKNZqzGSI6lok2LfKTw9ZXwMpfisCd8hvwU0feD/pNjg6X2Uk6GzXDYcoiX4i5Y23Sc8qDC9Ylp7J4imTnN5uTzLXa6rmIov+yAR7RUljvwPWbqhq4/IE6tc14Y3Yz72KDwkYaMFgyMAEwfgTLloCG+XUAvITwQSMqcg0WsaTz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750799303; c=relaxed/simple;
	bh=5EWUFc2b8nxJainkDW3BHcwce42b/kQEtho61D2dvWw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b8McoAq9RPL+cfLk+B2oH64HZldrG+YRsM5G6Z4jNiDXfxyuy/q5TD4PqaQzw3Hsv5v8ARRf5+yOMuzXC0J1SOQL7yAduVrMyQYYdDoi5xg/oc3NX2DRf6qrW8xyoHq6O2+Pk9DVTCm9m/7W/wxq/4Js5gY4L9VhHyj5Y/tdtJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LkD5Fi5N; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a582e09144so3572834f8f.1;
        Tue, 24 Jun 2025 14:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750799299; x=1751404099; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=itvx7IDSqd1Qu+kDl1q7+IKMKfpB6umE1igfQExJBWU=;
        b=LkD5Fi5N+I14ppWgWswjjpwtA5oG5HAhO32Vdh/aA2o0Sr4FpNavmD2RsI1GhTdnGE
         ixka0J5TPyufjqaHmmfVUpDjpKxwZEeZBDqm6IF6+VrSaUtN2Xqxunn+l6NWev1TkV3h
         /iwRacc373o3jBXNd4qRAG41+HvVxXGu0VVS/y8JhiL4PwAWmlu6+a0065NN5dc1HXn/
         dCQtzyxZGReLbxkJmaZqcRt3+RcQJL3KvPYoMgAdl4L19Zl2Xxd6Q5O5xL0hNhMnbbh0
         iRozIxb45YEDWAA89mqAoCl1io9DodacF9lwTm0VSnRj9BGoSCMGoaoqmOtBvOVdSao1
         9UMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750799299; x=1751404099;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=itvx7IDSqd1Qu+kDl1q7+IKMKfpB6umE1igfQExJBWU=;
        b=UUa8OiWUVnAWfgXbG2P8PFLaa9n8eIuYJR5A94fEmtypQCj7m2K97+Y9u2mQCZD+1j
         cfolXCuc+13SE6n7Hs7u++eNWRM0H3dj5Ck3FoinEIoPmIzNNREAFt1rvDwuvxlLK49L
         cjERYHAz4SqsgAyABPiebwBhfxUwK4MDegX8HScHgmDSL8kBe8/Kx0CWotlV/f4P1sGj
         UmbVy5/3pdMSXfUGwC/vYJ1fCQfOc8E+OmIjCIRuxP9l3jLIgNOpfcJ1y/w68U7STmJ+
         lPiEmu6vZ7OHJhvsY9kDAbgoqbIhTnU/HQmnJOYKZaMXvN0ugboR5oI1QW2nGN+tCON2
         J2Bg==
X-Forwarded-Encrypted: i=1; AJvYcCU90HInyE2KEjDiGctTIrcnWqNp/WNFY9w6vOgXU1lW10o2cU5uaxhZsVdWnn4dTjDwVCoUawdYplJ5kq3G@vger.kernel.org, AJvYcCXxD0+UlejHWtiKWG9ZErR7V3CrKXPD6bPudZKmzF+GaxvXDzJ1lF3X0gqh4e2LYC8n0pcGDnsHG62j8R0v@vger.kernel.org
X-Gm-Message-State: AOJu0YyecSXYJCPLfJLkptn9wOIjgarKGtZUdAwJppb9FKtguxRm5vyB
	X+3BtgQ3mtYSiNoUwpZCts3QdevGdu2jt2tQPRrhvYNp73Q+vTH5J+DZ
X-Gm-Gg: ASbGncvO321yC26SO2TCS/JRB8PSksHS+lKdTwdVGAfGnr8lKttlZyVplQD7QtPEIIy
	DIntDzS0S2TbWHtegvUvGIYFA3tK1ZJT5sB3IYh8utJIY9+DDkFI5gVWCzKeKJnsHuq+7BxU4z3
	ICEfENKA30JHIpC+cV2HFR3NKWaAcx8Ld1T9AgHXPGViRx5NBtD69d7Ysc3ijgfWpUQMc+kPT1u
	BqusSHqQrEnUepw7CE7FUxHeo0OY7YGHDkyEA1e5sY4X9BaKlYK9dxZBiy8QdEm2fdRgN0GsCAn
	GZ1yPQ481Y7YSRfDNCtST/ysBi1wFPeSdbbGe2FAvbJ7VRpih34YH6N1rL1QzaAAtug5I22Fet3
	jO97mmOBavQs/+OJg7SfgdOnO
X-Google-Smtp-Source: AGHT+IGwHH+3Fto7qgv3C8c/BdcTcAmM+Clmw2M+ojfy6KRjk/KACDvzw9BkPqhVjXarh8ndrQu0nQ==
X-Received: by 2002:a05:6000:2407:b0:3a4:ec23:dba7 with SMTP id ffacd0b85a97d-3a6ed66a42amr135573f8f.31.1750799299081;
        Tue, 24 Jun 2025 14:08:19 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453823ad186sm165755e9.21.2025.06.24.14.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 14:08:18 -0700 (PDT)
Date: Tue, 24 Jun 2025 22:08:16 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>, Michael Ellerman
 <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Naveen N Rao
 <naveen@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, Alexander
 Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan
 Kara <jack@suse.cz>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
 <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Darren Hart
 <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>, Andre Almeida
 <andrealmeid@igalia.com>, Andrew Morton <akpm@linux-foundation.org>, Dave
 Hansen <dave.hansen@linux.intel.com>, Linus Torvalds
 <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org
Subject: Re: [PATCH 0/5] powerpc: Implement masked user access
Message-ID: <20250624220816.078f960d@pumpkin>
In-Reply-To: <20250624182505.GH17294@gate.crashing.org>
References: <cover.1750585239.git.christophe.leroy@csgroup.eu>
	<20250622172043.3fb0e54c@pumpkin>
	<ff2662ca-3b86-425b-97f8-3883f1018e83@csgroup.eu>
	<20250624131714.GG17294@gate.crashing.org>
	<20250624175001.148a768f@pumpkin>
	<20250624182505.GH17294@gate.crashing.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 24 Jun 2025 13:25:05 -0500
Segher Boessenkool <segher@kernel.crashing.org> wrote:

> Hi!
> 
> On Tue, Jun 24, 2025 at 05:50:01PM +0100, David Laight wrote:
> > On Tue, 24 Jun 2025 08:17:14 -0500
> > Segher Boessenkool <segher@kernel.crashing.org> wrote:
> >   
> > > On Tue, Jun 24, 2025 at 07:27:47AM +0200, Christophe Leroy wrote:  
> > > > Ah ok, I overlooked that, I didn't know the cmove instruction, seem 
> > > > similar to the isel instruction on powerpc e500.    
> > > 
> > > cmove does a move (register or memory) when some condition is true.  
> > 
> > The destination of x86 'cmov' is always a register (only the source can be
> > memory - and is probably always read).  
> 
> Both source operands can be mem, right?  But probably not both at the
> same time.

It only has one 'real' source, but the implementation could easily
read the destination register and then decide which value to write
back - rather than doing a conditional write to the register file.
A conditional write would be a right PITA for the alu result
forwarding logic


> 
> > It is a also a computational instruction.  
> 
> Terminology...
> 
> x86 is not a RISC architecture, or more generally, a load/store
> architecture.

It sort of is these days.
The memory transfers are separate u-ops, so a 'reg += mem' instruction
is split into two be the decoder.
Although some u-ops get merged together and executed in one clock,
obvious example is some 'compare+branch' pairs.

> A computational instruction is one that doesn't touch memory or does a
> branch, or some system function, some supervisor or hypervisor
> instruction maybe.
> 
> x86 does not have many computational insns, most insns can touch
> memory :-)

Except that the memory 'bit' is executed separately from any alu 'stuff'.
So for a 'reg += mem' instruction the memory read can be started as soon
as the registers that contain the address are valid, the 'add' requires
the memory read have completed and the instruction that generated the
old value of 'reg' have completed - which could be waiting on all sorts
of things (like a divide). Once both values are ready the 'add' can be
executed (provided a suitable alu is available).

 
> (The important thing is that most computational insns do not ever cause
> exceptions, the only exceptions are if you divide by zero or
> similar :-) )
> 
> > It may well always do the register write - hard to detect.
> > 
> > There is a planned new instruction that would do a conditional write
> > to memory - but not on any cpu yet.  
> 
> Interesting!  Instructions like the atomic store insns we got for p9,
> maybe?  They can do minimum/maximum and various kinds of more generic
> reductions and similar.

I think they are only conditional stores.
But they do save a conditional branch.
A late disable of a memory write is far less problematic than a disabled
register file write. No one minds (too much) about slight delays between
writes and reads of the same location (reduced by a store to load forwarder)
but you don't want to lose clocks between adjacent simple alu instructions.

For my sins I re-implemented a soft cpu last year...
Which doesn't have a 'cmov' :-(

> 
> > > isel (which is base PowerPC, not something "e500" only) is a
> > > computational instruction, it copies one of two registers to a third,
> > > which of the two is decided by any bit in the condition register.  
> > 
> > Does that mean it could be used for all the ppc cpu variants?  
> 
> No, only things that implement architecture version of 2.03 or later.
> That is from 2006, so essentially everything that is still made
> implements it :-)
> 
> But ancient things do not.  Both 970 (Apple G5) and Cell BE do not yet
> have it (they are ISA 2.01 and 2.02 respectively).  And the older p5's
> do not have it yet either, but the newer ones do.
> 
> And all classic PowerPC is ISA 1.xx of course.  Medieval CPUs :-)

That make more sense than the list in patch 5/5.

> 
> > > But sure, seen from very far off both isel and cmove can be used to
> > > implement the ternary operator ("?:"), are similar in that way :-)  
> > 
> > Which is exactly what you want to avoid speculation.  
> 
> There are cheaper / simpler / more effective / better ways to get that,
> but sure, everything is better than a conditional branch, always :-)

Everything except a TLB miss :-)

And for access_ok() avoiding the conditional is a good enough reason
to use a 'conditional move' instruction.
Avoiding speculation is actually free.

> 
> 
> Segher


