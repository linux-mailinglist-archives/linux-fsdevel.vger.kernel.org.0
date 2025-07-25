Return-Path: <linux-fsdevel+bounces-56048-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B5685B122C1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jul 2025 19:12:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFBA67A9286
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jul 2025 17:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E742EF9A4;
	Fri, 25 Jul 2025 17:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E9teVUjs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946AF23E320
	for <linux-fsdevel@vger.kernel.org>; Fri, 25 Jul 2025 17:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753463550; cv=none; b=mBzzYRnRNBMaszXaUqhOUSl59h7NqEdMc7Ewo3Cdpt6aNJMLA8NJVBZnIv1WH9BpbIn2KnpOtWXjQwp1wW9g2SaLEXxiZ9osZmrVqeMUY46gXmt835iOs62xFm6n0KuiwZIDxw3RWuLeC+6/iez/zn65ZGL9E87+CdCc3gchC2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753463550; c=relaxed/simple;
	bh=LR/1fr+927w5gHz+7V9YvJuD7wXmf2oW8T6mJhnxcas=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B/T8tDL3jDd0NKppd/bVznpF/iSAw8wHSHtstDcm3R6muzHdHRlznFfLuErqCAcmdxc6tmpObA+TGu33a7RnLd1EXem9juZsPfyZwTd0ohaurCtY5+sxR3VCT/ACV8XdPc4JVS+MoVFRSg+Zj/IjH7fC9DFsHu9AeTlvPpWd4pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E9teVUjs; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4562b2d98bcso1855e9.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Jul 2025 10:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753463547; x=1754068347; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LR/1fr+927w5gHz+7V9YvJuD7wXmf2oW8T6mJhnxcas=;
        b=E9teVUjspWShKsMgc1oLy+m9iwkIFL+C/fjG0YE/EIYK/XzXXxa23KCQz3naomeZi8
         Y8HxbHREoCTKbCdWMqpi2V+pL5yhNCwb3XjQOpjt6PtPOvZuTlPg7RcJAUwnhXriZhS/
         N99P2J2YKRZFR7pKAsOCoTwBmdLM5Jqj8qGv1XHcn5KjgQJYMYIbDlgWyHFUkRoYQF4y
         1j+lHWwY0JnAJesKI32cLe5FJ6iYckQpFND98nOQLNJL/+FOLyytMGPuyCrCj08wDxmy
         idRL64mD3bs2vITGHRXBzT4/FnvvsbQ94mIFPvde9MQ6j7mvhKRS8sEYdovkMvVIDRUV
         SbFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753463547; x=1754068347;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LR/1fr+927w5gHz+7V9YvJuD7wXmf2oW8T6mJhnxcas=;
        b=h36YUjoM3w8mCpvZL6kIY5vDDpX8bsCkyYyEBO/G0+iKsDaELTQF4rRcQFtdY8OK3D
         FAG+dE14uodXiN4Phw3dA2V37NA4pQSg9dE6YTiHsko8pt4zwPzOtVD/LCMAvoK4cGBV
         QFkGgxEN+I4wFUYx+38QYusCLmd107NdLcWUFWsKKepIuHg+6X5Njk7150hjKmp5LZFH
         UkRWPzIZ7JwWhliDKNzeeypqvLYM567+aJtVDsXYxlmBUX849aEk5R+KQjg3JuOOV1Nl
         KwUyuWUHYsHWV/X86Jces3q+tu2U3k2770KTCF6ylE3uViRCvFYOF9AIH30LTHDrH+u2
         JJpA==
X-Forwarded-Encrypted: i=1; AJvYcCUPImfEkzIN0B318sCOax0yyexnc9zkQyH7SQRtU65c8lUC0zWCRhJ2dC3wEa7dy2iFCiZQD+DD1EPEYmUC@vger.kernel.org
X-Gm-Message-State: AOJu0YxU7vf7HVOD99ynWmTEZqu8nN+PkmtkiRuePZIUg/AmnozRQP7W
	WQhQE/2Xi1PbRD4cER5EMLV+oTC9lHC8LZfmmg2773swLrUq1ArtW4LhlJifoj4z/0f3rEqnw3N
	bz+VG1nTseJOSPKJuKjb9iKMe99IGJUWKFHihCYsH
X-Gm-Gg: ASbGnctthhkOnettTfMi6Lhke44uzND72O1f2VnQ8zJSpGuq/ZRr8GictUUm6TBk6Oj
	/2BAlnMNUF/pv4nPnC46ODK1PtfkBNkOZj4WYwJtzhiR/l/gZUvL3cVdqh9UUBw1EhkFD38cg1n
	7s8o7VNT8NdUCVOG4cEKaCJJgDeyIuCHOh7mb26Ksh3nj+NSWWonW3LKIwNp9S3ZF8iE2a8gOK2
	+wGiUVt1g92GGzGHCgPAIt/2St7KLADNf4U1QnkDVGXVg==
X-Google-Smtp-Source: AGHT+IFhxhJzavWiG8TnAC5bSyEUCITgigk6eSOkbePzjanT6OdYE8Du+O+akeu9UoPZ+9VboPkoI9eK3HhR7G1bjjE=
X-Received: by 2002:a05:600c:1c86:b0:453:65f4:f4c8 with SMTP id
 5b1f17b1804b1-45874e2b93cmr1367085e9.3.1753463546532; Fri, 25 Jul 2025
 10:12:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1752232673.git.lorenzo.stoakes@oracle.com> <8f41e72b0543953d277e96d5e67a52f287cdbac3.1752232673.git.lorenzo.stoakes@oracle.com>
In-Reply-To: <8f41e72b0543953d277e96d5e67a52f287cdbac3.1752232673.git.lorenzo.stoakes@oracle.com>
From: Jann Horn <jannh@google.com>
Date: Fri, 25 Jul 2025 19:11:49 +0200
X-Gm-Features: Ac12FXz5v7hwHYZVZo-PcQftTdDT8-58CkHFg3QHIWJWk_i7JJUmY1B0j5KtsNs
Message-ID: <CAG48ez0KjHHAWsJo76GuuYYaFCH=3n7axN2ryxy7-Vabp5JA-Q@mail.gmail.com>
Subject: Re: [PATCH v3 09/10] mm/mremap: permit mremap() move of multiple VMAs
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Peter Xu <peterx@redhat.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Pedro Falcato <pfalcato@suse.de>, Rik van Riel <riel@surriel.com>, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 11, 2025 at 1:38=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
> Note that any failures encountered will result in a partial move. Since a=
n
> mremap() can fail at any time, this might result in only some of the VMAs
> being moved.
>
> Note that failures are very rare and typically require an out of a memory
> condition or a mapping limit condition to be hit, assuming the VMAs being
> moved are valid.

Hrm. So if userspace tries to move a series of VMAs with mremap(), and
the operation fails, and userspace assumes the old syscall semantics,
userspace could assume that its memory is still at the old address,
when that's actually not true; and if userspace tries to access it
there, userspace UAF happens?

If we were explicitly killing the userspace process on this error
path, that'd be fine; but since we're just returning an error, we're
kind of making userspace believe that the move hasn't happened? (You
might notice that I'm generally in favor of killing userspace
processes when userspace does sufficiently weird things.)

I guess it's not going to happen particularly often since mremap()
with MREMAP_FIXED is a weirdly specific operation in the first place;
normal users of mremap() (like libc's realloc()) wouldn't have a
reason to use it...

