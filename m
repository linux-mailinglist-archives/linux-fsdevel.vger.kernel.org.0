Return-Path: <linux-fsdevel+bounces-65390-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id EDBC3C0381B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 23:15:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A08FE357544
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 21:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B1F7292B2E;
	Thu, 23 Oct 2025 21:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BGn5yOI5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52132285C9F
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Oct 2025 21:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761254097; cv=none; b=bHyeYExdR3hpQ34D6O90njdU5q85nhvc4Q+6yQKaVF+DQ5q+dozLu/ySsRUeyN+JUXHcfSng3AkpKlYqNskkEYC0pq/MxCZm5YohbVrEP1VdbNo6j6UPYzo+aejuAEyrmoL/WPvTI5FmwM5tp8ecy8dOw7lEA0X9WLBnTOhDChA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761254097; c=relaxed/simple;
	bh=gr//hXY2CACNJmuey8RcSt/nzmsO2m0/uxqUGfrhxmo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QrjvbwzLmcWBh2XyTIn7ZSVg1/KFC0jEAcbQP5fnqLVdj81AIxxJ+K+j9jUHVxANj7G5PSqDXJ3UQ+3TwYi7WkMBCFa1Bz4OXF0d9Q+U5WfmA6C4+sDQUYRv91KuI1PLyqTsp2p1r/1QNfAIrRSE64GD526y2581RAeccgEzaEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BGn5yOI5; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-470ffbf2150so16010105e9.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Oct 2025 14:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761254094; x=1761858894; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z6sEiHIDuaPc1r9BapkeRLwxlBj8uKP+Q15MeH29iBY=;
        b=BGn5yOI5RXHea3sF8BccWSHPW8j7rODuY2BUtXT1QmMiGHMk1Bp8sE8Jtj3CCw7q4H
         hM/bCptjbMolusyQtBOtpDlVs+HcjxUZL+tYRWJD9MzKa6NnTohpwZt8wKhZe8C3FzCR
         P1cOxrWPGnSMLfJPNh+TJp8iUZn2H333ucwR/yKvrk3exmWVuSS44eeHRRjqAf39w45l
         M4qWil4qa5N6uR73qO0Gq2//kYWwUXv7JKLYQGKapznfWSekAe1FbzLtqTMOIAlwOM+g
         Z4VUhuQFTPE20KoDDAtP0sRGGgEXnXVb3Gch5o1H3Y2gkkt8jITEkWsPXHW9hwibFtN/
         agLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761254094; x=1761858894;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z6sEiHIDuaPc1r9BapkeRLwxlBj8uKP+Q15MeH29iBY=;
        b=CU51JY18e7Jh2FCJwmomS8Z6n1yOaMoVxC4GFuCgIn6bZzLkN4IjZMjt0ZyvI1rpzx
         ZR90N7UQuets+m8SFlJ1x3qQHdlct69ynK70cEgKGhB+i94fXtDWf9Zp3aHHbR7ZeGwz
         aaSaltQJwqGkYF9vcJ+Og8LkRZcwOfYSLy4Y/+oT66JEGY3lWd3Th4+hl8QClDMHmpX1
         f+aj84vVRsTPiDNQTkbF6r8PGBejVWPLzhQxxs3MuJD/eJPKz+r7EkG1zuC7Gl5MSVnu
         cwL5BtXPpIiK5wibirJbi0okWdWgpWOeJCHWdsj/MdToey9SWxrpsw+6l7v3x7u/L3zY
         Q9KQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCyNHrVzX8IXlplp0ZyVuUjmaELPbley0UTlCWj0Gyt3xoJ+27AXol4XWGjvtb2bat5/9+PHG+5OGDMqPw@vger.kernel.org
X-Gm-Message-State: AOJu0YzSmCd6qJ0ypF4TbbYfO5Z+2BmUnJLib16/qJCBJJ8VNLp8nB76
	JnGteK6GbIZuBPuZi/oPiJz5j3XAG/99UxPg60qT8MAj5y1V0b2DiVt2
X-Gm-Gg: ASbGncvB0wujC2GDyhnkarD+0trapG0feKZxACk3GyqMmN+u0J0Szz9d3/aoX1jqNba
	kcc+5qIXowxmffVTi4mKG5Oei/V3Imsp/10J2mCeX61Lx5XZpOqmuZ1shj8zW+mUA4NW46eIu7f
	NbV7nLBJ7fMDl9xHLmrYa5HwsYUY7xqN8Dghtxvm90Ih/rF7Ya4DQ9IhMTLDK5M/XB6N1g+wYoR
	07Wr5e8glfhvba2YAclMomPsSvbFmXE1IEft04xy1aWsuT+AgLUQrIYMuRFnjS9+6HF6ZVacyf+
	e70xJQ7uD4M4A2C6v7CS4K26kZIfxW+jJjSAhMPnxR4MCkxMc29R2oRNZGJuhLr0Kfg0VaIrjBT
	AHqwzi9YZ69+c9mPazXStHyWPKJKqM41KBsFrqHQfU254N4rfo4q12zIiow8ocMVUmJiNkI+cKe
	UuDKi8T4FBkD3TGT09T4m+yO4RSJV9XijyBqudMTQzbg==
X-Google-Smtp-Source: AGHT+IGk8eEDWy3Lb1qhGeYZ8N0urG/YCIu8xY7+WZCUmyVKdYxjr9Zc6A6l5BFcgm2g7Vw9SfAVXA==
X-Received: by 2002:a05:6000:1446:b0:427:374:d91e with SMTP id ffacd0b85a97d-4298f545550mr248975f8f.11.1761254093423;
        Thu, 23 Oct 2025 14:14:53 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429897ff3f5sm5951290f8f.22.2025.10.23.14.14.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 14:14:53 -0700 (PDT)
Date: Thu, 23 Oct 2025 22:14:50 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, LKML
 <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>,
 =?UTF-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>, kernel test robot
 <lkp@intel.com>, Russell King <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org, x86@kernel.org, Madhavan Srinivasan
 <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas
 Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>,
 linuxppc-dev@lists.ozlabs.org, Paul Walmsley <pjw@kernel.org>, Palmer
 Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org, Heiko
 Carstens <hca@linux.ibm.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>,
 linux-s390@vger.kernel.org, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Cooper
 <andrew.cooper3@citrix.com>, Julia Lawall <Julia.Lawall@inria.fr>, Nicolas
 Palix <nicolas.palix@imag.fr>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org
Subject: Re: [patch V4 10/12] futex: Convert to scoped user access
Message-ID: <20251023221450.1303003d@pumpkin>
In-Reply-To: <CAHk-=wjoQvKpfB4X0ftqM0P0kzaZxor7C1JBC5PrLPY-ca=fnA@mail.gmail.com>
References: <20251022102427.400699796@linutronix.de>
	<20251022103112.478876605@linutronix.de>
	<CAHk-=wgLAJuJ8SP8NiSGbXJQMdxiPkBN32EvAy9R8kCnva4dfg@mail.gmail.com>
	<873479xxtu.ffs@tglx>
	<CAHk-=wjoQvKpfB4X0ftqM0P0kzaZxor7C1JBC5PrLPY-ca=fnA@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 23 Oct 2025 09:26:12 -1000
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Thu, 23 Oct 2025 at 08:44, Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> > But as you said out-of-line function call it occured to me that these
> > helpers might be just named get/put_user_inline(). Hmm?  
> 
> Yeah, with a comment that clearly says "you need to have actual
> performance numbers for why this needs to be inlined" for people to
> use it.

Avoiding an extra clac/stac pair for two accesses might be enough.
But for a single access it might be hard to justify.

(Even if 'return' instructions are horribly painful.
Although anyone chasing performance is probably using a local system
and just disables all that 'stuff'.)

> 
>            Linus


