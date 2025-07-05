Return-Path: <linux-fsdevel+bounces-54020-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E071DAFA1E8
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Jul 2025 23:05:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FC5A3BA74C
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Jul 2025 21:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2DD723A995;
	Sat,  5 Jul 2025 21:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aY9KVcjv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5649515B0EC;
	Sat,  5 Jul 2025 21:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751749545; cv=none; b=uZ45BwDyP8Bt6Mt78O9Cj/8wfjTGyAsS7nx8hJ3AWjTYRBBgBQBewSC1HK2IXBTMmjvWpsuaa5lyDm/Tn50Dj8obdBc5PlZcSyTdL3ptxMGwPVqvCcS/AtgWn7dh4tuszazjE0/+mBRBLG27WnYeraVuj5TgxaV92r64ZVV7lzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751749545; c=relaxed/simple;
	bh=peN5O8/+zxqKwHMxPe3ijoC6Jukz9chNcUZaevGq3Vs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JC6auvW4bPpi2rMxi/J7hfIFzwQKVDJYx7LJ9jQs3HMBcx/haGp/gcgqziS9hnKV3WxwtjQmASxZtNu/CCUi3X+RkaJS1pYmvgYQYi3xY7z8CQxVKG+kCzc3PaEr/5Ja+Koj76+pMwJjZtYxzmYY5i/82izwRDa11GPgW083cq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aY9KVcjv; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4537deebb01so10781325e9.0;
        Sat, 05 Jul 2025 14:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751749541; x=1752354341; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QNrGEXREXb+VRaOAxlii9StjIrHTh79zxrBn0vyAHzE=;
        b=aY9KVcjv+0j0HuYJ878ZkBh6pa7jl4yXXeyhugvxMnACXmkx7JgvV89jMgZ86Hb+1A
         Qm0bq8tmkH1WmED8ojTNKlnad6vCeyqx6VGsc1OIdPY6EaCLBWxHp+QdBagaToWejm/o
         F99YsiX7v+SbMUco/bi1RzIvIA1Uz7Nck/gvJHYpfAgHe9qnRNU7N2+b69rzvBAt+oQo
         fTCfYp8APdzg3WBQ5/86/4fZd+dhKXv/mbMUgSuu+mq7UQDjzNKJz4WomOLcBbN9uvQA
         OjupvD/CPTo/qYvllY6m8xXVbKVyybbCAdUcVkpFkpo7FjRdjcENu+MaLTlWOK6VES2q
         EWaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751749541; x=1752354341;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QNrGEXREXb+VRaOAxlii9StjIrHTh79zxrBn0vyAHzE=;
        b=t0aUhVuUcc2B8iFJZYAsvFfd+1IeyZ25UW+SLR+NUm4mQYu3vjbHvRtm6/+3wupnmM
         1om2SD7/cDRG7S212WxazMhPufxqlVnEksL0171PenER/Wvjta800oLpkb7+Df3EL26d
         0HePLTYkgr4qK7Kq6XFWa1bLp0hrLvTvtmRVMxivGzrvipOrWpzknZVJiLrMWfO+yW/u
         QEO8EMIflI+xj7VCcXOnMS0TwCkd/fmECXWIbNgCptgUpUzA7dbDirRPdYBSp5ig1s5b
         iLxHTPz7VZUdLkRq4V3PIS2h35+rxAnzOuLGLDEl+NjfaXoMuWNWhztdhS7iqtrRVXoO
         w5LQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKhmJQz39+ixXkt7L8DZFWR+p4G6WL8/hEULdRsFBtJHI5ldMGQ34BzIl9BelETGEru0sAp5c2hjlxmMvJ@vger.kernel.org, AJvYcCVrGp72hTW1YIgag1y3/qiMJcgQyZfwqNf1ij1sUyHiwPx7z1GnsIKD7gq+9KYtpQQbLJ9ID8284yhWe0qE@vger.kernel.org
X-Gm-Message-State: AOJu0YzivHlw4/vUdZgePJESmhojK6z06Sr4EMIQ7B2qmqDMuUQL4EqH
	VOVQdg3pFvfDhM/67Fk5FhASqxKfKxbRYEQSBss5c0Ykte+mOhcSJA76
X-Gm-Gg: ASbGncvGfHPVXwJCXlo87vfQfbv2uDHhX0IuxFEvMGLwt0AVQzsu3UNcRiF+YWHhz2m
	C/4AKFqkWsL6OsNJqtWVI4OZ3+FBCrUvJ/UtjgzkutWEw2NjK5wj/lmw6vCa20STEF9xd0MbpXl
	WC2ujM3nKiU4hYhBlqrGrdNUXEeWCUKTSCDAi30zj/+jhrn17Z9/0d5meQh9lvQsYcWPXqaoSj2
	aPBVFUJV3rupyZC746Ho8dUbcCwVRy5drq+yvMRHQZCHCqssW0drGqcPOyfK7TcHTq1latN9Jrx
	D9Yvn3xEiuMGGmU5uGV6TvJpfXR/pa44VXHnR6cgkSM6nhRXyDPiwS7h1McpD2c0rM/eDswU0lL
	IhDqdbV6h0acZ3RX3D5vvvCeMFjL6
X-Google-Smtp-Source: AGHT+IGT+GFP2/eh/DyGC1nE94xXBDFJpNvsPv3x+Wo4Su4HQLV99sMh/vey3UY2hxRw+Q3uWfEPyA==
X-Received: by 2002:a05:600c:3153:b0:43c:f70a:2af0 with SMTP id 5b1f17b1804b1-454b4ea5f53mr76967405e9.16.1751749541160;
        Sat, 05 Jul 2025 14:05:41 -0700 (PDT)
Received: from pumpkin (host-92-21-58-28.as13285.net. [92.21.58.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454a1705ed5sm66250775e9.2.2025.07.05.14.05.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Jul 2025 14:05:40 -0700 (PDT)
Date: Sat, 5 Jul 2025 22:05:38 +0100
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
Message-ID: <20250705220538.1bbe5195@pumpkin>
In-Reply-To: <aGmH_Y4248gRRpoq@gate>
References: <cover.1750585239.git.christophe.leroy@csgroup.eu>
	<20250622172043.3fb0e54c@pumpkin>
	<ff2662ca-3b86-425b-97f8-3883f1018e83@csgroup.eu>
	<20250624131714.GG17294@gate.crashing.org>
	<20250624175001.148a768f@pumpkin>
	<20250624182505.GH17294@gate.crashing.org>
	<20250624220816.078f960d@pumpkin>
	<83fb5685-a206-477c-bff3-03e0ebf4c40c@csgroup.eu>
	<20250626220148.GR17294@gate.crashing.org>
	<20250705193332.251e0b1f@pumpkin>
	<aGmH_Y4248gRRpoq@gate>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 5 Jul 2025 15:15:57 -0500
Segher Boessenkool <segher@kernel.crashing.org> wrote:

...
> The isel machine instruction is super expensive on p8: it is marked as
> first in an instruction group, and has latency 5 for the GPR sources,
> and 8 for the CR field source.
> 
> On p7 it wasn't great either, it was actually converted to a branch
> sequence internally!

Ugg...

You'd think they'd add instructions that can be implemented.
It isn't as though isel is any harder than 'add with carry'.

Not that uncommon, IIRC amd added adox/adcx (add carry using the
overflow/carry flag and without changing any other flags) as very
slow instructions. Intel invented them without making jcxz (dec %cx
and jump non-zero) fast - so you can't (easily) put them in a loop.
Not to mention all the AVX512 fubars. 

Conditional move is more of a problem with a mips-like cpu where
alu ops read two registers and write a third.
You don't want to do a conditional write because it messes up
the decision of whether to forward the alu result to the following
instruction.
So I think you might need to do 'cmov odd/even' and read the LSB
from a third copy (or third read port) of the registers indexed
by what would normally be the 'output' register number.
Then tweak the register numbers early in the pipeline so that the
result goes to one of the 'input' registers rather than the normal
'output' one.
Not really that hard - could add to the cpu I did in 1/2 a day :-)

	David

