Return-Path: <linux-fsdevel+bounces-47787-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15FDAAA57A3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 23:45:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F2081884EDF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 21:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A023283FD9;
	Wed, 30 Apr 2025 21:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UC3w/M3i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E562609D1
	for <linux-fsdevel@vger.kernel.org>; Wed, 30 Apr 2025 21:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746049494; cv=none; b=YHPcEpSX6+C1Ekcx30qD162BamsAMq2JEGXjOfHDYwX8wT/0RGKlOykDnT+71Vxh3iWrZmQuWDbdXdHyPdDRJNy9RS4+va7ryrw1KdiA39Qo+s50p+TvWg5JxVuD9SIbXQZr23Y1S2VOMq6VU//5si2UhjUIFXn85VixPzYBSGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746049494; c=relaxed/simple;
	bh=q4h9txxyVkNdC6jvewm0aNetCP9eOddzybErf3K9z8I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sdJU8Dnu/DLFY+QBPlzVaL6DDjhqJC29jZrEUIcyHnxCO8z7pk12RHzAOTp0JgFdEXu484yBhEUvYjP+Tp35gGLyv7SHyNjBvjsz3GIOIxUmHBGPMvbUvBbxF0sjzpmUonYOwIyrn3SuswAt2xF3apby5D1Ede0p0iPnnWHzTfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UC3w/M3i; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5f632bada3bso1047a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Apr 2025 14:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746049491; x=1746654291; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q4h9txxyVkNdC6jvewm0aNetCP9eOddzybErf3K9z8I=;
        b=UC3w/M3itmy+QyrLNFj98ZzxR/WzXrfHaLwmix5e106T0Fx/u/h2J1Y6DwMlk3f63Y
         xdzFZQ76dkNE/9XoJR9kQqrorOe1rtv46K41/aosyizexZhS7cGuzxroRTNtvLrh2Hz+
         TIwDUv1xbatyA6nYhl6Mng9sNtEtYEWV5/Z2rkiS2+Tnxi+i3/THuvdxBGXGXAVj7wDL
         F+obEzSH0dFumwpaYam5zo1Iqe7xECVxtGmW+zYebeyqc8jJP777FEc/gMiqhfyyuBzC
         JCqN/p1Q/KigbCGlH9wUO0vSvdKglxe+ewwxneaMm7pGX7SSV3xP+PCajBlhC3rOpX3r
         L2ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746049491; x=1746654291;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q4h9txxyVkNdC6jvewm0aNetCP9eOddzybErf3K9z8I=;
        b=DGDmpp5gW8pCxWUtN6FAoACNLo7FbNw4bKdoL8UDxEdoIw87JHHcDrnZ5vRejVAip3
         50HAFOyjjPpaDQJiQz+67MiUg3//7YP8sWvn3PH1HGYLXQUjRNnUprrTHXHFv5yQeAG8
         +XKFS+V32qWYV/x+m4ub1Oir92+QG/VBKlFEtpTinxypvg5P/rLH4GV7J1yGn2CkCGNf
         Ee/y7k6woEqoyhyY6y7TTQNSH0/W1TSkw9kcz5mOZyLz8N/qXAdXP9hJAFRqK2APQLWe
         PLG1jK379TpqkNS/1wkgdDGDJO+v5rhJ/A3cvCc6vngZfBcbfdbJCk2ncyYHfmy3k20F
         OSwQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5Wr/KnD3Qs5i/jibONn/VEsF17K9uiC1F2ETeG8zWyAfGp+O/2uFfoYKoEvV6SmqBK3YnU2BHLMdYYNPJ@vger.kernel.org
X-Gm-Message-State: AOJu0YxTezAm4xNO9V18fmh/4/f3yYULRjzAsoOPVR/RQAz5SQWJIdOV
	ORZiib1xRcGUD51+ZCQAxsf38Db7CCIp4CBkURzdtWwAZsx7sfmEMRWfzy/6aGAY6edxpbOO9RB
	i8vNgMJpvwQms5oQWViTbAyJkWqoUci+X5zbr
X-Gm-Gg: ASbGncsczwPJW47xJE3zCRlHBZeNxmky8vbPq4YpOEKdPNpc2mkJxe7CQZLekO+HdZT
	Pkokc4mQUcdkXn6ofuZAL394IJrAVMQ9ug8ToX/urBFeOca/Ol0+vTVjw0GZGwjB5rqejKkuRJF
	zSpeO4aqFgtMSmUGk2lX1NgvHoSjZnmsQi6viPpemzPW9ZDB+9jdU=
X-Google-Smtp-Source: AGHT+IHa+YOIrnKiFDXDrrt4yu+9fdIONVUCemFPAqVKkKRm3U9fwx/l3LrvAFu7aPljtxYzM7ACp9bkPJ/XkR4pYL0=
X-Received: by 2002:a50:d556:0:b0:5e6:15d3:ffe7 with SMTP id
 4fb4d7f45d1cf-5f918c2a177mr8356a12.7.1746049491126; Wed, 30 Apr 2025 14:44:51
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1746040540.git.lorenzo.stoakes@oracle.com> <f1bf4b452cc10281ef831c5e38ce16f09923f8c5.1746040540.git.lorenzo.stoakes@oracle.com>
In-Reply-To: <f1bf4b452cc10281ef831c5e38ce16f09923f8c5.1746040540.git.lorenzo.stoakes@oracle.com>
From: Jann Horn <jannh@google.com>
Date: Wed, 30 Apr 2025 23:44:15 +0200
X-Gm-Features: ATxdqUHF1o6EwfzKPJMttuEXJySFho1Hj_S7BrlihxHfp-SM2NszLl-GiZD1uH0
Message-ID: <CAG48ez04yOEVx1ekzOChARDDBZzAKwet8PEoPM4Ln3_rk91AzQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] mm: introduce new .mmap_proto() f_op callback
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Mike Rapoport <rppt@kernel.org>, Pedro Falcato <pfalcato@suse.de>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 30, 2025 at 9:54=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
> Provide a means by which drivers can specify which fields of those
> permitted to be changed should be altered to prior to mmap()'ing a
> range (which may either result from a merge or from mapping an entirely n=
ew
> VMA).
>
> Doing so is substantially safer than the existing .mmap() calback which
> provides unrestricted access to the part-constructed VMA and permits
> drivers and file systems to do 'creative' things which makes it hard to
> reason about the state of the VMA after the function returns.
>
> The existing .mmap() callback's freedom has caused a great deal of issues=
,
> especially in error handling, as unwinding the mmap() state has proven to
> be non-trivial and caused significant issues in the past, for instance
> those addressed in commit 5de195060b2e ("mm: resolve faulty mmap_region()
> error path behaviour").
>
> It also necessitates a second attempt at merge once the .mmap() callback
> has completed, which has caused issues in the past, is awkward, adds
> overhead and is difficult to reason about.
>
> The .mmap_proto() callback eliminates this requirement, as we can update
> fields prior to even attempting the first merge. It is safer, as we heavi=
ly
> restrict what can actually be modified, and being invoked very early in t=
he
> mmap() process, error handling can be performed safely with very little
> unwinding of state required.

I wonder if this requires adjustments to the existing users of
call_mmap() that use call_mmap() for forwarding mmap operations to
some kind of backing file. In particular fuse_passthrough_mmap(),
which I think can operate on fairly arbitrary user-supplied backing
files (for context, I think fuse_backing_open() allows root to just
provide an fd to be used as backing file).

I guess the easiest approach would be to add bailouts to those if an
->mmap_proto handler exists for now, and revisit this if we ever want
to use ->mmap_proto for more normal types of files?

