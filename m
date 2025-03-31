Return-Path: <linux-fsdevel+bounces-45374-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C827A76BAB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Mar 2025 18:12:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AEF937A4092
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Mar 2025 16:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 341502144CF;
	Mon, 31 Mar 2025 16:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W2zaazU2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262761FF1B3
	for <linux-fsdevel@vger.kernel.org>; Mon, 31 Mar 2025 16:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743437547; cv=none; b=jF3eLmFXrIt6C8D7g0PoDrsL0unYdNOR9uHbOD5bcG/KYIj9xl/nHORAY+EtYdnXo6rBx6JPZvPIedlJUJrYQZAZtPVO49K3ErkLiO+EjGEnJTrFAPIh9CSVklglP7v+e6z21lLhZx8HL7C7K9iXMBkIbK8guO5ys5DZpF0xNkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743437547; c=relaxed/simple;
	bh=an1+g/h3bnaPeIBepE6aMJ/6ukgx++5dzCS3i3DiqDU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pEt0VRoM2HnLay6ZHJ0Vn0T9uSjwKO/rSADKCFRZ08MTnlpGReU9VUwQPhOIGkr4IiU3SfVJa/bIJmzF4nKhI1jxqQr1vtXCdjqh8pWnsobmCuVQ0PhEXKxnl1ELG8rG3ivS2Ks2fHDXm5n40+5Mgiy7r18FWLH7980rrKKIQ0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W2zaazU2; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3d43b3b4c32so522055ab.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Mar 2025 09:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743437545; x=1744042345; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=an1+g/h3bnaPeIBepE6aMJ/6ukgx++5dzCS3i3DiqDU=;
        b=W2zaazU2qTKxCwXisZL/xY9mDKvOZ+06dsud+XxJ0GnPr8G0EscyngW6xMOeLe3EM7
         B2aBKbl0VdZo7ZIM4JiLlycGF13qgpEXsbRrdQh1rYCAKgA9NvPKp5v9VeqPP1hLJgaQ
         j5env/gxeZXe4U4J0AL6cPB5r7I2tZWZpKuKr4y5/qVSnIsr6y0ndHplEHUZ2tcPojMw
         3IkvN3w37MouiYFz0nn1lOT8LiENQlaWe8MUr7zguBCNGybf77WqWc2XdZ6R6tzN8Min
         YV/EPI3oXVKi2+qImQDMkbG2hrdNzTBrlTFSymtGaZWZmYy2AYNofeH13D/FUNQ7kfgG
         0g1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743437545; x=1744042345;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=an1+g/h3bnaPeIBepE6aMJ/6ukgx++5dzCS3i3DiqDU=;
        b=qgXRLw6u+RbO9F3AV+IFvEBYqzvVYWoPrF1QfpIEYMJniwCwViNe6ZPbrWRoH7ApbU
         hy65RzXks1otnZWQxHTpThK/AuCTwm6r6SbTwo/0085RHSZGdfg1Pksd55rM/K2gX1u/
         ndn17nWeLurRBh9kJ0ZyDibMfcS0YB7voWehtQq4rgdWFuMtIbKDis+wmrP43NqSvUj9
         P8oT9G4Zr5rLApgq8dethUVlRZjmzGHAtPK8qn9l6Fad3/2HYi63PYE+txu1MYh3rGsV
         98+O+nuKPZECMwIL/px8/9SXkMHgJbbonHKy5N6vMzdp0lTN3x00jsqX2q46b3bbO/Cg
         /xhQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXdc/2ywskPFhLp5XHL9ocOKTgk8cfiDmD77xd/z+uE2ZdwUvOIZHZ47Iw02EjJsCQC6fjNOP5fVOpx2pm@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0aQJrCUUfvxAQP2JNqzfK+tqTi5S4IVGV8B9I27v8PtjUw5ks
	vgDQ74MkoFoTIatlB3/g/ZTbOUujRfFP8AFKlPcaAHqSvqqeDyv2UIOlzkbXpDlO6enhvXognC7
	b7zrsnkgrDV8xVFzFjb4EglLgZsffcF9lQcRL
X-Gm-Gg: ASbGncvYR0yyLZxX8j3uY2E2fIdPPS8P9oksPCAIt39UdhFEvOnVDD3jh4SR9xY2HXM
	5B6MsDK9G/yq3zSZOw4ktLZcULDVveyP5fWynCrzybHoYQFxJu2QGN2trdy605A64whY2Cq9+4t
	IEMCEHBB+B8hlxOPmuvGKl9GT64Kg=
X-Google-Smtp-Source: AGHT+IHkkrnJidXNy1ORXW0y5wmiSeC6Z+atM6xwCyKPc4zUkW9tuui2BDyeFn4t44wEgufSUXTW6I8SJc78PrrsIxo=
X-Received: by 2002:a05:6e02:2386:b0:3d3:cd81:e7c5 with SMTP id
 e9e14a558f8ab-3d5e0f479a7mr7942495ab.8.1743437545077; Mon, 31 Mar 2025
 09:12:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250324065328.107678-1-avagin@google.com> <7263e869-d733-44f4-bd2b-9c6f89202909@lucifer.local>
In-Reply-To: <7263e869-d733-44f4-bd2b-9c6f89202909@lucifer.local>
From: Andrei Vagin <avagin@google.com>
Date: Mon, 31 Mar 2025 09:12:14 -0700
X-Gm-Features: AQ5f1JpNhLVBHOZ1scUgN574PAKvq55Nm3GTeM5MgiHWALnnJEtPRQSdKckpLU8
Message-ID: <CAEWA0a6KdODW2hD3G0PO+yUFC4rZCaTGU_orC3CAuHXRXoqREQ@mail.gmail.com>
Subject: Re: [PATCH 0/3 v2] fs/proc: extend the PAGEMAP_SCAN ioctl to report
 guard regions
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, 
	David Hildenbrand <david@redhat.com>, Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	criu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 31, 2025 at 4:26=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Mon, Mar 24, 2025 at 06:53:25AM +0000, Andrei Vagin wrote:
> > Introduce the PAGE_IS_GUARD flag in the PAGEMAP_SCAN ioctl to expose
> > information about guard regions. This allows userspace tools, such as
> > CRIU, to detect and handle guard regions.
> >
> > Currently, CRIU utilizes PAGEMAP_SCAN as a more efficient alternative t=
o
> > parsing /proc/pid/pagemap. Without this change, guard regions are
> > incorrectly reported as swap-anon regions, leading CRIU to attempt
> > dumping them and subsequently failing.
> >
> > This series should be applied on top of "[PATCH 0/2] fs/proc/task_mmu:
> > add guard region bit to pagemap":
> > https://lore.kernel.org/all/2025031926-engraved-footer-3e9b@gregkh/T/
> >
> > The series includes updates to the documentation and selftests to
> > reflect the new functionality.
> >
> > v2:
> > - sync linux/fs.h with the kernel sources
> > - address comments from Lorenzo and David.
>
> Thanks, sorry for delay, LSF/MM/BPF is why :)

Yep, I know. I hope it was productive. You mentioned in another thread that
you are going to handle compatibility for the older kernel. Let me know if =
I can
help with anything.

Thanks for your cooperation.

