Return-Path: <linux-fsdevel+bounces-38658-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A84AAA05DD8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2025 15:01:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 287263A1026
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2025 13:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 175AC1FCFE7;
	Wed,  8 Jan 2025 13:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DsVdZeNw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D8F1FA8D7
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Jan 2025 13:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736344655; cv=none; b=MDZs7iZGnCHactwaDfbkgstjPnJuk9mWBc21QMRaze4EZArYO+xTXS0VeLzkOcQB2hojbQTq6d64hYLhAcRL6q53Up8QbKGri3bBIPpJMmxucpblB+ozebzRDdbjGOC6UJtHh5mf6Hgl0FbzRqdRUx+WFH1ro5JD394rrHP8u88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736344655; c=relaxed/simple;
	bh=cFO5i+D3M0hWuPqrUV7FpmXOACu7ogHJ3T1FwS4CN2s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AuRY940lLi1VqfVGNXuCWTA71ZHha9SWjBmu9TBg1iUbBbGZ7dzvZA+bg1R8UQ5tKKXPGLH+sgjms/pNUuONUKVIwnwnZG2b9PUIw/rBrKoEMJj5vZ/wQNlHJxmOhmXSOxlpLBD6iKrMFenTiakOSo3qExWUZqQSWTlrbenQU/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DsVdZeNw; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-385ef8b64b3so13025198f8f.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Jan 2025 05:57:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736344652; x=1736949452; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t5B1ydPn1hV3ArUDgLdqy3/MqqbLWzy4ewiJvBc3c68=;
        b=DsVdZeNwm9xVgSwcxbXYSM8KjKuqaNZRu1FNG1hdKLLK0qxWyUB1M7VAXEmK/Qs8dq
         roR1Uxme8EedWTOQt+qdT/aEqyKFVWx/DkPWWkI9cQ4G0015kWrTTaqwBnPoON8yuyJq
         yrIWHnfrR3ob4KwyhvIwOt6mRPaQXoOtyThj8ODIuMFWNcfT0uI6NQnz1UFXMgIHWrlO
         bX7wUnKCfcUv8c8eln7024ZPrQzU7AfkZ/1Wf/0JKoVroDpfU7BZx16EHk3RxR7uZBgm
         kL8RXDQWkUjQyYsR8K796QMoJpCctr/jkfKDCyS+EeFLAEdRihqFAnP/ZrihD3whnXjg
         89eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736344652; x=1736949452;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t5B1ydPn1hV3ArUDgLdqy3/MqqbLWzy4ewiJvBc3c68=;
        b=VMgmJ1CsqNzz2MWqe6JSRo84RAmvC9/ieHpptDkK+QSTQSZil6Q9RXM3PmHVWAGDpl
         IO2bu6yVgYCtJORniGO/egjFycVxKHPd+c3jpwh4TFv6vz7MKvmHXCCf/UgU9ToYS5U7
         jqYIAa3awoOOQzuXgBBfm6OFevzC+FoumBIwKvW2gn2DmQnyhw28zTGuKDL39KWkrV78
         TWtl0vLdcgncHML382WcFgD/aUyldewEZakw5WZjs+CKNAb5OBYmn4sNvEUKadt8RG3W
         7wzpoUcwY2W2f3pF4FpIFujbH9iqVlR1scOaVYe8hCBe/F47GaWq8zBP12pNKsoP8yJ4
         gHWA==
X-Forwarded-Encrypted: i=1; AJvYcCUL0wOZ7DGMuELAktbHE1BbUV2Hf0DVFgPv5wIfqMPmEYRAiMBMY/iM/QNMm1OcHc6+gMISUv/epNidnkF6@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9SNSvPqUvO3+4FRyDLDD3YjyAzbymhqu3odjjElzGO5fE6L7S
	eCbQRwOWv15VilBn9RbvzK4UqLi+ZnZQq2SJ9ryEJxYiMyn8w6sgiTz3pR5nCQMl6zUg/BW0ffu
	1SuEb0mbx2HwMueF+JgKBKbI6GYbjVKI8ho9i
X-Gm-Gg: ASbGncuguziz+jyzDoYWbjvwkjZgr/EKZ6CruXJ1jC2pM02HLSFKMWzT3zwpjaiQCps
	nodad2fr6cSRo5bbL06oIjPzT7O0fDtKNpuhJ0Uaapnm7EN/RuKHh8k1Kc9S5Yt4v+3Xy
X-Google-Smtp-Source: AGHT+IEbxWyWurE8CBh3IUVDWpET7t97VubFNt7QnZxqoAd00egoZstT/6eGB5ZCUYPhA9IrcxcejzbYE8OgtZydtHA=
X-Received: by 2002:a05:6000:1566:b0:385:faf5:eba6 with SMTP id
 ffacd0b85a97d-38a872d0036mr2333764f8f.1.1736344652169; Wed, 08 Jan 2025
 05:57:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250102233255.1180524-1-isaacmanjarres@google.com>
 <20250102233255.1180524-2-isaacmanjarres@google.com> <CAG48ez2q_V_cOu8O_mor8WCt7GaC47baYQgjisP=KDzkxkqR1Q@mail.gmail.com>
 <CABi2SkVmdxuETrgucYA2RucV3D4UoaPkDrXZKvLGjfEGp1-v2A@mail.gmail.com>
 <Z3yCzcpTHnW671WL@google.com> <CABi2SkUVZKjtGCJ+rvYbma4OGY_zQP2U3KtPjqVNMnAfoHxYDA@mail.gmail.com>
In-Reply-To: <CABi2SkUVZKjtGCJ+rvYbma4OGY_zQP2U3KtPjqVNMnAfoHxYDA@mail.gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 8 Jan 2025 14:57:20 +0100
X-Gm-Features: AbW1kvZK81B_6i49g17DQcxkAvGR13mzhcf-r8yMEkygG2O8r-hDv9HAwxfltY0
Message-ID: <CAH5fLgifNkTFTVHbsp7wXBgRQmXQ3+r3xD03bZq06gU7eOfDOw@mail.gmail.com>
Subject: Re: [RFC PATCH RESEND v2 1/2] mm/memfd: Add support for
 F_SEAL_FUTURE_EXEC to memfd
To: Jeff Xu <jeffxu@chromium.org>
Cc: Isaac Manjarres <isaacmanjarres@google.com>, Jann Horn <jannh@google.com>, 
	Kees Cook <keescook@chromium.org>, lorenzo.stoakes@oracle.com, 
	Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
	Alexander Aring <alex.aring@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>, surenb@google.com, kaleshsingh@google.com, 
	jstultz@google.com, jeffxu@google.com, kees@kernel.org, 
	kernel-team@android.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 7, 2025 at 6:21=E2=80=AFAM Jeff Xu <jeffxu@chromium.org> wrote:
> Do you know which code checks for VM_MAYEXEC flag in the mprotect code
> path ?  it isn't obvious to me, i.e. when I grep the VM_MAYEXEC inside
> mm path, it only shows one place in mprotect and that doesn't do the
> work.
>
> ~/mm/mm$ grep VM_MAYEXEC *
> mmap.c: mm->def_flags | VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC;
> mmap.c: vm_flags &=3D ~VM_MAYEXEC;
> mprotect.c: if (rier && (vma->vm_flags & VM_MAYEXEC))
> nommu.c: vm_flags |=3D VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC;
> nommu.c: vm_flags |=3D VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC;

The check happens here:

/* newflags >> 4 shift VM_MAY% in place of VM_% */
if ((newflags & ~(newflags >> 4)) & VM_ACCESS_FLAGS) {
    error =3D -EACCES;
    break;
}

Alice

