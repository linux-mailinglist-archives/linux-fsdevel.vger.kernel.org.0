Return-Path: <linux-fsdevel+bounces-25212-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 747D1949DBA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 04:24:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E1E01C22137
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 02:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E49F617BB1D;
	Wed,  7 Aug 2024 02:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AMycbZv7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1CF3C39;
	Wed,  7 Aug 2024 02:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722997474; cv=none; b=iOYWA0N6vtzW3ivxMOAQIEldwDIa41fVrV7Cm+Eq8A0++7SmSDcOK46dUPCthn2IyjAXQxEsnA8MSvwtEk2mM/XoR0ceojEfhomCeoX3/88Ut77DFBt/jeg3kL6w4Guep5Ey+6Dxuk9BY/l6ZaLLsOXxpvyx3j5S5gym7kmdLw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722997474; c=relaxed/simple;
	bh=v0kBmE43YlyqgpNzaA7PTbgDjoysRsbIXFDpJihmBDk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pa1j1wfTYmPSp9LzJPT4Njn85w2oFTgbdW6ssJLN29xC/4h/wLGV8MTXz+uBNavp++I5OWf5Eqi1mDeTmubju97hqfeU1MIijzSjaTP66JCXhtIFJVe5cOzxXxGVH/Wzoq/ZMCGD8U4WlxwklIulJWLa/ekENqUWf7j9iveRlnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AMycbZv7; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a7abe5aa9d5so160124266b.1;
        Tue, 06 Aug 2024 19:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722997471; x=1723602271; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JJVW4JUs6tIGlHuX7z/ZpxScapue3IbzYQ89DLUH3K4=;
        b=AMycbZv7jPwkkItTWQtMdhcCTI1c4DFABSD8IFoQBaYBPDOtzVC7uChqrS1BMXAt8k
         VXYfv1cPB9NPmnmVoE1LugAJA8O9WM70GCR1ULdkDMxyhU/IjdkC5/vbfV1dQ/eKPRIl
         80udKwhovsA0V2giWIxKZ9nV3UH8BoJDU8uqp4HiU1k0i8c7ToHDHu5b6AyrDGPFBdcv
         houodCpMnFRE6hCVbTs8MqQ9WfhcSUonKZWoHPkt8jOKIm4D99SuPxZg6mxIEFfXu/zY
         rOibTGJk/sZG9GMYnt9EsQRYC6VckKXw4j/tq2+isV+lb3fQUAeK1nPHG4JvIx1vewCm
         5cFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722997471; x=1723602271;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JJVW4JUs6tIGlHuX7z/ZpxScapue3IbzYQ89DLUH3K4=;
        b=nW/m4oJU7XABSKeba+6kk7IkIut6tC+rt8GEzQfoHQt/OF4W8fbH+nEFAfOnSzpCJA
         rE56c2yEGoHqiV7uA8pcLe74kEbBGry9r1OCOuwdRiWxLTHBVzptPI8T7AePtnqvKpxc
         QLDEJQlAvCLT7OmBpG9kPPz2FTZOc9YK5DD92M2dH7YlFz90+nS1VT83MdC2mgfH+ihJ
         CfI4EtOQCnw6zEcN1XchF0SpOrCq8UNtGhKGbRc3CNkU5XteisT5S5a2W1C/BLGsNf1s
         78OQhMWRrGg0wqIOgzUq7cS+2J7UbrL93atsc8DGwc9HdV1b7+CF2aYKshubQs1i8/7x
         uACg==
X-Forwarded-Encrypted: i=1; AJvYcCVLK0+bAzZJEJQO6QQutZ3LBhytrSRRG4EJfVlxnGxWFQ135GasLJ1uY3YZYv/FhzwupUiPOHA1JOFuGxFuvuIvUTXDwfKZ013kSlhrca47+PR58oKnhySQ5joqQ+/Oh1vA4RWo610EBzU/Sg==
X-Gm-Message-State: AOJu0Yx2338t1yYKQglfH+0erf+P4CuuG327b/dNbcF6J5fXY9LmJuqn
	g5Gtpo6KxyRNA4SNMF7381HkcHG+9MWEgwHCuFUuGWBudXYQya8Wcmb0mlrrFcz7Q+kXWQnJxb/
	j61FUGqZa3K5c9lrhsBwAGwMXakx+lG3a
X-Google-Smtp-Source: AGHT+IHvKOW8fLDHaNjGabpCgZZGfLyCLUdEUF4DS9eMzC4sB/BjG1WaPIZaoz2rNA8u3dRK+cDawyLg5WIOlDNErN4=
X-Received: by 2002:a17:907:72c5:b0:a77:e2e3:354d with SMTP id
 a640c23a62f3a-a7dc4fae1a6mr1362886766b.23.1722997470548; Tue, 06 Aug 2024
 19:24:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240805100109.14367-1-rgbi3307@gmail.com> <2024080635-neglector-isotope-ea98@gregkh>
 <CAHOvCC4-298oO9qmBCyrCdD_NZYK5e+gh+SSLQWuMRFiJxYetA@mail.gmail.com>
 <2024080615-ointment-undertone-9a8e@gregkh> <CAHOvCC7OLfXSN-dExxSFrPACj3sd09TAgrjT1eC96idKirrVJw@mail.gmail.com>
 <000001dae86b$04955090$0dbff1b0$@wewakecorp.com>
In-Reply-To: <000001dae86b$04955090$0dbff1b0$@wewakecorp.com>
From: JaeJoon Jung <rgbi3307@gmail.com>
Date: Wed, 7 Aug 2024 11:24:18 +0900
Message-ID: <CAHOvCC6Cwh=x_TJ3COgtOc9fkrdWQDn9fd3jEkZtN8QGaCpMZQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] lib/htree: Add locking interface to new Hash Tree
To: lsahn@wewakecorp.com
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Sasha Levin <levinsasha928@gmail.com>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Matthew Wilcox <willy@infradead.org>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	maple-tree@lists.infradead.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello, Pedro Falcato
----------------------------
Thank you for your advice.
Hash Tree is a new implementation and does not have any users yet.
And it will likely take some time for many people to recognize and
demonstrate its superiority.

Hello, Darrick J. Wong
------------------------------
rhashtable was coded using the structure below,
struct rhash_head
struct rhashtable
It doesn't seem to be a Linux Kernel standard API.

And, as for the Rosebush you mentioned, I checked the related
information in the link below.
https://lore.kernel.org/lkml/20240222203726.1101861-1-willy@infradead.org/

I think "Matthew Wilcox" who developed this would be well aware of this.
Since he developed XArray which is currently running in the kernel, I
would appreciate his advice.


Hello, lsahn@wewakecorp.com
------------------------------------------
The Hash Tree I implemented uses HTREE_HASH_KEY to keep the tree balanced.
You can check the macro below in include/linux/htree.h.

#define HTREE_HASH_KEY(idx, d, bits)    ( sizeof(idx) <= 4 ?    \
        (((u32)idx + d) * htgr32[d]) >> (32 - bits) :           \
        (((u64)idx + d) * htgr64[d]) >> (64 - bits) )

The hash keys are distributed using each GOLDEN RATIO value at each
depth of the tree.
The standard deviation of the hash key is less than 4.
The function that tests and computes this is _htree_hash_dev() in the
lib/htree-test.c

Thanks.
From JaeJoon Jung

On Wed, 7 Aug 2024 at 10:42, <lsahn@wewakecorp.com> wrote:
>
>
>
> > -----Original Message-----
> > From: owner-linux-mm@kvack.org <owner-linux-mm@kvack.org> On Behalf Of
> > JaeJoon Jung
> > Sent: Wednesday, August 7, 2024 9:22 AM
> > To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Linus Torvalds <torvalds@linux-foundation.org>; Sasha Levin
> > <levinsasha928@gmail.com>; Liam R . Howlett <Liam.Howlett@oracle.com>;
> > Matthew Wilcox <willy@infradead.org>; linux-kernel@vger.kernel.org; linux-
> > mm@kvack.org; maple-tree@lists.infradead.org; linux-
> > fsdevel@vger.kernel.org
> > Subject: Re: [PATCH v2 1/2] lib/htree: Add locking interface to new Hash
> > Tree
>
> ...
>
> > The Hash Tree I implemented manages the Tree with the characteristic
> > of a hash that is accessed in O(1).
> > Even if the tree gets deeper, the search time does not increase.
> > There is no rotation cost because the tree is kept balanced by hash key.
>
> How does it keep balancing?
>

