Return-Path: <linux-fsdevel+bounces-47785-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D9E1AA5775
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 23:34:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0E993B77EE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 21:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8714A2D3A9E;
	Wed, 30 Apr 2025 21:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MHfV39OS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB8B270ED2
	for <linux-fsdevel@vger.kernel.org>; Wed, 30 Apr 2025 21:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746048627; cv=none; b=KG08e3DAv7IU0q5ja04EeOtNUjcl5T1cBOL6yZnsbQjQiXTQ+8/vjBliFOfjl0V87IYi0G63mvVSJMi5ASDYVLIqQeEX1vfnHpUNnTMbHj/DFrt7cSFZk9VRbBPEYHiG8dxukv1sqL9qq9MmpZA7HvBbs64ntDgo0iXfIfTHeg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746048627; c=relaxed/simple;
	bh=5CjcEDdUNisdYTC682ZR/akMXUXBiC2pK72vAthCoDc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pXALttVVGUKWPWRUk9s/6ucR3FiTXVkcxTHr/eZbIsJeuV+IrLGVjPncB42X2iR/ee1VB/gEu9Zmy7Fg0xsLqHUeq0jrRXU+NWGHTNdxm+NFPkaeXNiDXjFQ9HKpWXe0RHgV1kfYL3toUX8NtDu/c0msJ5h6UjN0XX2pobHRS1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MHfV39OS; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5f88f236167so1095a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Apr 2025 14:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746048623; x=1746653423; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5CjcEDdUNisdYTC682ZR/akMXUXBiC2pK72vAthCoDc=;
        b=MHfV39OSU69giSeBLqB2iB9KQQMfphzttb5gGwv/ENW+m4RnMUoRL+a0xwmwna2DGr
         4ukW2lxYflh92ubpDOI/7Cq/nWLlqBEJxnXAurQJr6Dz5UFy97FvcTml5t/U/qfry3tQ
         9UdalvjtMVT1/g+QC68sMfdY9yorzLAngMTZnzVEa0YmDu+MWq+LAZaXfYMCXQi1JHnj
         7MQAMO/S22gSo8JP86K0JKiBbc7CbuN37k9OxXYXXTYNp7rRFaFIzFDIAbmjf22tRBju
         cRmQKdaPmqU5xr9xwxEFH8KJRs5ZrJrqAIKRPGkgr1dC7tnMzs1hAUZ2otX1NrhfLqsS
         uFSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746048623; x=1746653423;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5CjcEDdUNisdYTC682ZR/akMXUXBiC2pK72vAthCoDc=;
        b=XRdY7RFHr4uUefBsz/XcLku0bgDl/XgOo4ViQkKbuBWFB0AvL9s1vNtfSFEr2Ozrct
         84JPONY4zsJYdHjCqXvZgPIlj4v9viwy7nnjBkAepEQcoagGKyP0uP6TOPkvZU/sjEMg
         V0C/Bh166iZ6+fXEaGTZv03/cjUXu52khQEV/0AnnhZp/KTMMqwfc0flH4hb+uHMjg/K
         BNUIOKORXlSCZTgUPuTyhStKex0uEFtg9mQfsXHUNP5HIjTFfNH+n4tSJn4Bp9RelZS2
         E8hgw1TlP2o0ZGJ44bMwEFv0SF8mJZwfKvI7PMiVTTga9R2H3ADabJovfyxmoEaGeIIT
         OP0g==
X-Forwarded-Encrypted: i=1; AJvYcCVu5jzFvdqHuF6rg4qZfKjY8wO81FBwFgH9ZrXYxABk/NoTd2P9Y6r76EwRoo81ULf4+KPwcVbfM2gzQY12@vger.kernel.org
X-Gm-Message-State: AOJu0YxnWnlPKFnhx69RW7lLQFtqIYz0fti2xt02uRNGhfwa05Qh0VQN
	AXPJn0fNJtSG6yuODVcjbA79zZu0pDPmxSygefDlJRwf/kFonGPPif/Yuiz/LfaEz4/iDaL2kNY
	+6FqIoEirNIZa7WmPen7pe2yY7nidEtV9Qde4
X-Gm-Gg: ASbGncuTp4hCmDtReCYGpmJJNIoCQUvZCWherJVtkF8lxrk5neTibrqVbEGGwG9yZ6A
	vk+oXm5FwVUtxY0KYDgMbVWT+j7DyfwCvtUNAdGIf462UmHeymZ02rGIqJNUG6KUhrAMQmiwuZK
	4LGYi5fS9fqwTHe4nHeXjna9/EbsOsnSQTgr3Ksjpo1EBtnWbbDOA=
X-Google-Smtp-Source: AGHT+IGDMMmX4eA2v6ulzCpeHnUuea9wQ5svOGFjkGvBWCiP8rCQm1GlFwWDt1zkKtNVQSBWCW/5nQN3fWwXJdYqdrY=
X-Received: by 2002:aa7:dd04:0:b0:5e5:7c1:43bd with SMTP id
 4fb4d7f45d1cf-5f918c081b3mr6342a12.1.1746048623266; Wed, 30 Apr 2025 14:30:23
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1746040540.git.lorenzo.stoakes@oracle.com>
In-Reply-To: <cover.1746040540.git.lorenzo.stoakes@oracle.com>
From: Jann Horn <jannh@google.com>
Date: Wed, 30 Apr 2025 23:29:46 +0200
X-Gm-Features: ATxdqUHQ2RqenZm9cv6clle4zPp-U0u0sqdqaHqJJXCLMmXCWvll4M0PNqaIFOM
Message-ID: <CAG48ez25mXEgWSLZipUO2d7iX-ZjF630pMCgD95D9OuKGX1MfQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] eliminate mmap() retry merge, add .mmap_proto hook
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Pedro Falcato <pfalcato@suse.de>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 30, 2025 at 9:59=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
> A driver can specify either .mmap_proto(), .mmap() or both. This provides
> maximum flexibility.

Just to check I understand the intent correctly: The idea here is that
.mmap_proto() is, at least for now, only for drivers who want to
trigger merging, right? If a driver doesn't need merging, the normal
.mmap() handler can still do all the things it was able to do before
(like changing the ->vm_file pointer through vma_set_file(), or
changing VMA flags in allowed ways)?

