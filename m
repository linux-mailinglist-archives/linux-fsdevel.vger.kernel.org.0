Return-Path: <linux-fsdevel+bounces-65379-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC04C032D0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 21:26:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DC013B132E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 19:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC4B234D4C2;
	Thu, 23 Oct 2025 19:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="RPeOJ2E6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5A92356C7
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Oct 2025 19:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761247595; cv=none; b=W4gWB9fxvgsCOZKb/tUO8WQ+GmQU8rdS6EoAqTxLlA1eAwxvL19LRx38rh3SCifBfZqXgkSSp90IRQHTVf9AoX98SnU8FwlUgRhvRjMjmnoP6/iVzW2lwmhmYaTADK7UUc/PBws5lP/j5rNbrPReE5hZdNlZvGhEQhh57zbR3ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761247595; c=relaxed/simple;
	bh=0g5PWwg2p6TKfCHzkJ+Dwpx0TfIIseEhNZqQ162TaLQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OWPVCa+ERwCc7QzfQFJwBUBe85gMm1F92IwY5dcHWk63HeR7fYSTfTjIKhZGWTlckG40JSi15FLEYxd8RdCL5DlitXW1Wi/3dDXFRVExlYoNNyh1OvXH6Q9PmZmT378a9tbspBJukA4NkCNZQTocDkXrFxpIchZs1b9AR3I1n3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=RPeOJ2E6; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-63c1413dbeeso1985472a12.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Oct 2025 12:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1761247591; x=1761852391; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=B+nka1o0UKTB6+YPro/AThdj4Pv3gE7VXwEkULP704E=;
        b=RPeOJ2E6kJ4XPGNOVECOHmrGC85CzhLN68Kgg1arqc9mUu+snqpmqUPjj82H4w8iFe
         xPIUh3JEE7XCrGVAbxl21ie/iQqBQs7+BANZd3ByHVSyO6dI4NGXMCCediR9ADYu4fYI
         ijN8pUX1keVNJwAZ5hI8+fwxstAVqFd3L+Fh8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761247591; x=1761852391;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B+nka1o0UKTB6+YPro/AThdj4Pv3gE7VXwEkULP704E=;
        b=OiQOIEH7k2qDub6x3AQm4d8bUYltmCo8roi0SlbVXqAVch1AIiX2GIa3jkGpvA08Qj
         +46TV26L6UlYYg9mDjjUCfxgGZjL2/2yvUP+pLGe44pktOYGn7lWqHivb6yNWng0soV3
         5wEHvHYPAzVcEz9PZysgl+cJZv3NfFK8yMS+voktge5u9GkzhvUwkmxHEh91ZuCwn7gQ
         2RkCjYP7bdD7tRVMi6zi5JqBk5s+c5XKxFSFR1vjIEnuFg1Le2VJUuoVZzfWSoiQPTIT
         krZQPiSHqlB8AO6MqljP4wBDFVN6RqFUmyEoVoOQPX91N0fviHWfY3kAV8cmZ80QY24g
         xMlg==
X-Forwarded-Encrypted: i=1; AJvYcCUuJmgr+nnZ0vix5rP/Y3pLtdO0Msa50WNYLD+KzHswJwMYqMFs0OP6f+lqvXDUyCKMV0NbAUBwbb19YFlz@vger.kernel.org
X-Gm-Message-State: AOJu0YzriselHjYpPvy4kB7UePpa3GXZ3LjrsCKLzkm+iHtiVhm519Cr
	vVC8tuWUcjv91jS6RekmSadEeQbs2AkfB4aK2WbIqnA22vAZhGUSqYTefX4+qGzZB6gJIgArFcV
	77UxXDnY5qw==
X-Gm-Gg: ASbGncuhCwfoYtXH02APs4q+aTW5CX9XEOUrP324SLyhqOFpIJuAjrPA8EKGNNFpmIP
	N/Ao2k50W8I8FU3YOi/rSurbs3Q1i5892ETVN85Wy88fHD13CG4W5Aw+/yjvtsJH8U0yOm4Gvkn
	V6cP72msDj9+nGOjnuXFho9GxNFKvV4/Rdi/Lz1M/2freHTkfiIPHhXfEjt3tjWKe2CiGEQM3U9
	TLfV7EB6KdXC/f6MsZpVn0ETpUIB0+5R6GMFhyAwCXvOHF5kKKnIQuxGG7x28xge7D3YfSAlqJ/
	l7rPS5H3wMN7OPH2EswXW3OzwL1MbGTSoLwX8Bm5gdtehaMzjr1WRgDfgc/NGU84Yeo4bgMiqCC
	dj00jNzaPia+70kEXq+J1RUylHtjP2Mqs4NVlD3P5xYf09cEs2e0TZsSBzWebZZiYkPg7hvFIDy
	RSobSUkfVplgVg0O70pD6VDrPo/2HImLvg2W2xPdJo4qmI5OIorA==
X-Google-Smtp-Source: AGHT+IFlF3nX3diHXX0d3uMoYRVex1e6iaJjavcBxf6LMwKHbTSEC0lza5BFlOUl6OUKqHfAqHsLpg==
X-Received: by 2002:a17:907:3f0f:b0:b6d:62e4:a63a with SMTP id a640c23a62f3a-b6d62e4a653mr153076966b.40.1761247591303;
        Thu, 23 Oct 2025 12:26:31 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d511d41a4sm298156166b.9.2025.10.23.12.26.29
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 12:26:30 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-63c3d7e2217so2404559a12.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Oct 2025 12:26:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWdpnkEp4Nc11NcChNA29TcM95BMRc2iu0dW/l7JrLudKlloBd8Mf43DAFK8vXRWsBGmr4IsKT376tIUMR4@vger.kernel.org
X-Received: by 2002:a05:6402:2681:b0:634:ba7e:f6c8 with SMTP id
 4fb4d7f45d1cf-63c1f6d5e1bmr24956720a12.34.1761247589536; Thu, 23 Oct 2025
 12:26:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022102427.400699796@linutronix.de> <20251022103112.478876605@linutronix.de>
 <CAHk-=wgLAJuJ8SP8NiSGbXJQMdxiPkBN32EvAy9R8kCnva4dfg@mail.gmail.com> <873479xxtu.ffs@tglx>
In-Reply-To: <873479xxtu.ffs@tglx>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 23 Oct 2025 09:26:12 -1000
X-Gmail-Original-Message-ID: <CAHk-=wjoQvKpfB4X0ftqM0P0kzaZxor7C1JBC5PrLPY-ca=fnA@mail.gmail.com>
X-Gm-Features: AWmQ_bmaCluDq9_Xyq5CJoakX9a-PwfYiYDMZ1KnC-jDJR9ceAw_ALWfx9Y5hW4
Message-ID: <CAHk-=wjoQvKpfB4X0ftqM0P0kzaZxor7C1JBC5PrLPY-ca=fnA@mail.gmail.com>
Subject: Re: [patch V4 10/12] futex: Convert to scoped user access
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>, 
	=?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, 
	kernel test robot <lkp@intel.com>, Russell King <linux@armlinux.org.uk>, 
	linux-arm-kernel@lists.infradead.org, x86@kernel.org, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	linuxppc-dev@lists.ozlabs.org, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org, 
	Heiko Carstens <hca@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Cooper <andrew.cooper3@citrix.com>, 
	David Laight <david.laight.linux@gmail.com>, Julia Lawall <Julia.Lawall@inria.fr>, 
	Nicolas Palix <nicolas.palix@imag.fr>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 23 Oct 2025 at 08:44, Thomas Gleixner <tglx@linutronix.de> wrote:
>
> But as you said out-of-line function call it occured to me that these
> helpers might be just named get/put_user_inline(). Hmm?

Yeah, with a comment that clearly says "you need to have actual
performance numbers for why this needs to be inlined" for people to
use it.

           Linus

