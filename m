Return-Path: <linux-fsdevel+bounces-47011-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7016EA97C0B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 03:16:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D22BF3BF8E5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 01:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C1ED257ACF;
	Wed, 23 Apr 2025 01:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KBhF7lv6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1454125743A
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Apr 2025 01:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745370965; cv=none; b=pvP1eUa8XOcntFI9gFiwJpSBf7joGsyRR/k8w3PE9hI0nsUrX3c8sfkOWbSZD7lkfKWThjhBvda8JOEvkmtwT4GI9xvDhW4XQFpov+Yj9iXjdOIpo2BIs6HPxHqjus0E6Mm7Ept3IrAvX0M8qwAdVTC2AzVwEqcvIsRzkG8wjJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745370965; c=relaxed/simple;
	bh=BXEvwpncN5O7EkLN13AdUk98rvfh4Ju4eZYY2vVAM1I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=koOcSz8jU6jzvMOFB8lZj5avJtecDGBYbpLBAuOq3wgoHgWzAWtmDBF+VsC1NtX/ObUiGGPT98qteFk+t4Be2boMZc72ySAcW4N5Pi6nbNMNfiT1XRvzRr1aWF5Y2ENJKVqMYBSAggfbP6QSGopCHzAdOPnJRXlH5gdY+7W78HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KBhF7lv6; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4769e30af66so114491cf.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Apr 2025 18:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745370963; x=1745975763; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zhRaiFa49yEjS7XMAEA0pqmJ6/VdWziZXZon8TG+B0I=;
        b=KBhF7lv6PcVEJJE25TaDKoXU5nvQYnMgaWVOFsmGIj08jJiXsxN4gw1ITY2Uc3oNle
         XriSIWM8lfnUInhOZgegHdrAhEQzVzroNB3IhvnOERy+pznEegsOYf/0dhnDdXXNTn0l
         e9hBqNvJH5FcAf9tilSr555Go0J5zqBgz73qtwkS332++H9ya5ij+f6WcvJf8vAldg4R
         11j5UzKMfiFAXMepwCW0qKHRbywt0MgJYwpsMMCLrBZ97Hvr1375zkRkblUPadfMCzNJ
         8mCoRIepu8dKFiHaUTwqzsMe2inRjjEIdp334NRLWoYvuArvPLIWRPWSuYnNoV7aPaau
         h0JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745370963; x=1745975763;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zhRaiFa49yEjS7XMAEA0pqmJ6/VdWziZXZon8TG+B0I=;
        b=tcD/x7cwqDwKiecsxxrys84RLVXglQDQfZ9GKLwZYYNkYr6ZCK4K3ub/Len9uHb+B1
         D44l98QVdM7JpcNUPY1ryjM5oKs4sM1D09FVVbJMgNsYnS9dfngqZfoKoCdlTLIkqJPt
         QpoJv7NL3E1FPsThIAAPjLSfehEHl3qjQDCh/InN/Wp2biEhBhPtIsEDN+PFRNDQqIhG
         p/d+bdzDlDYjT6ENPIC5lX6qwCs0jus5CsSw8D7sTEDDhCL5vadETTpC/Kf4fE+utIf6
         fDuN/Nf2BZ7cICZ192PQEAQzs3c6/Ch+R8F/72JGZDeszDb47Xva692AoRoaG8ku1vHR
         JGrQ==
X-Forwarded-Encrypted: i=1; AJvYcCXtlcZ1ZjzV2fAgV3+J/oXJ1zH+8IDHTSONQ9ARoGBaSy6TDAndIPhhiunkpHbNUHKiWj3noLm4Fq96V+5f@vger.kernel.org
X-Gm-Message-State: AOJu0YxuHqLwj8CElZkl0kRc3Nco82CN2UfRjt5ta1AWhP+Gvva9zO1q
	GE5HqQddN1f8hkf5V2nb6hSul5+9WVxHLZQDIsRCwubcU0mKf7k/mYR9RYYRki5DMFfdMTjbmhQ
	4w4InQ+tVPKFKud09w0kp2T/vaT8AssoFdJ38
X-Gm-Gg: ASbGncuDl52z/qAaAiOaXcqspK3Uxvw4tU7EqRqjLxy29pHxe3wXZO8pt+qOO5ZrK7l
	ucijv5WnpWLdXSwLVR6vpifBc5/VCbjIB+wePV14AsCUUbaU8AoKWnVfk0R2gzc8glJUKKNnfge
	tgo09mNezk2wPy/pwr/jy57Mxbmrm5tR0CX3j5bWm8JGAkwm8omopzySMKWk7L5DU=
X-Google-Smtp-Source: AGHT+IEUXBruOYK9xJLY5TxjTNRmIkg5ccc2dUsC7FO2joRBTQXoTvy35paTIjKrhKWBSAk6EgOGJ3DQQXksC84x6AE=
X-Received: by 2002:a05:622a:2290:b0:476:d668:fd1c with SMTP id
 d75a77b69052e-47d11ce1d9bmr2253491cf.2.1745370962631; Tue, 22 Apr 2025
 18:16:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231206103702.3873743-1-surenb@google.com> <20231206103702.3873743-3-surenb@google.com>
 <8bcb7e5f-3c05-4d92-98f7-b62afa17e2fb@lucifer.local> <rns3bplwlxhdkueowpehtrej6avjbmh6mauwl33pfvr4qptmlg@swctg52xpyya>
 <CAJuCfpFjx2NB8X8zVSGyrcaOfwMApZRfGfuia3ERBKj0XaPgaw@mail.gmail.com>
 <CAJuCfpHpdAn6yNVq1HXqO0qspj6DLb4qa_QufT+Z9RLTTa-N9Q@mail.gmail.com> <cbppxyb7pe3yhmru226db5zt3v67sxsvfzjvg4jn62gzltutbl@vipuebrhjgpj>
In-Reply-To: <cbppxyb7pe3yhmru226db5zt3v67sxsvfzjvg4jn62gzltutbl@vipuebrhjgpj>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 22 Apr 2025 18:15:51 -0700
X-Gm-Features: ATxdqUF4NmV98WtGDJWZ4I3RN7_zTDrRsHxHJXV0LiqF1O2h8MZ7XjyQt8_P6zE
Message-ID: <CAJuCfpHD1N+xn6ZMnvLM5g7NLBd6AHSDhnrDqdR+ceZRM+=qUg@mail.gmail.com>
Subject: Re: [PATCH v6 2/5] userfaultfd: UFFDIO_MOVE uABI
To: Alejandro Colomar <alx@kernel.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, aarcange@redhat.com, 
	linux-man@vger.kernel.org, akpm@linux-foundation.org, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, shuah@kernel.org, lokeshgidra@google.com, 
	peterx@redhat.com, david@redhat.com, ryan.roberts@arm.com, hughd@google.com, 
	mhocko@suse.com, axelrasmussen@google.com, rppt@kernel.org, 
	willy@infradead.org, Liam.Howlett@oracle.com, jannh@google.com, 
	zhangpeng362@huawei.com, bgeffon@google.com, kaleshsingh@google.com, 
	ngeoffray@google.com, jdduke@google.com, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 22, 2025 at 12:20=E2=80=AFAM Alejandro Colomar <alx@kernel.org>=
 wrote:
>
> Hi Suren,
>
> On Mon, Apr 21, 2025 at 08:58:22PM -0700, Suren Baghdasaryan wrote:
> > > > Please re-send including linux-man@ in CC, as specified in
> > > > <https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git/tree/C=
ONTRIBUTING>
> > >
> > > Thanks for the reference. Will post the documentation update later to=
day.
> >
> > Was planning to post today but I'm a bit rusty with the syntax.
> > Will try to send it out tomorrow
>
> No problem.
>
> > after verifying the results.
>
> For verifying, you might want to try diffman-git(1).  It's provided in
> the man-pages repo.  If the version of the man-pages package provided by
> your distro is >=3D6.10, you may already have it in your system, and if
> not, you can find it as <src/bin/diffman-git> in the repo.
> It's documented in a manual page in the same repo, of course.
>
> I don't know if you know about the build system, which also checks a few
> common issues in the pages.  You can check <CONTRIBUTING.d/lint>.
> TL;DR:
>
>         $ make -R -j8 -k lint-man build-all check;
>
> (You can ignore anything that's not about the page you're modifying.  At
>  the moment, I see a few issues that I'll need to investigate in a few
>  pages.  For seeing a clean list of what's failing, you can ignore
>  stderr; see below.)
>
>         $ make -R -j24 -k lint-man build-all check 2>/dev/null
>         TROFF           .tmp/man/man2/statx.2.cat.set
>         TROFF           .tmp/man/man2const/KEYCTL_SETPERM.2const.html.set
>         TROFF           .tmp/man/man2const/KEYCTL_SETPERM.2const.pdf.set
>         TROFF           .tmp/man/man2const/KEYCTL_SETPERM.2const.ps.set
>         GREP            .tmp/man/man2/pipe.2.check-catman.touch
>         GREP            .tmp/man/man3/ctime.3.check-catman.touch
>         GREP            .tmp/man/man7/landlock.7.check-catman.touch
>         GREP            .tmp/man/man7/rtnetlink.7.check-catman.touch
>

Thanks for the detailed instructions, Alex!
Posted the patch at
https://lore.kernel.org/all/20250423011203.2559210-1-surenb@google.com/
and hopefully I did not miss something important.
Cheers,
Suren.


>
> Have a lovely day!
> Alex
>
> --
> <https://www.alejandro-colomar.es/>

