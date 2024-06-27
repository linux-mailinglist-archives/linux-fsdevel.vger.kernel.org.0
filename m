Return-Path: <linux-fsdevel+bounces-22689-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E793791B0E9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 22:51:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 267B8287EC9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 20:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 989721A0AF6;
	Thu, 27 Jun 2024 20:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="krmQgKKy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0EC94EB37;
	Thu, 27 Jun 2024 20:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719521437; cv=none; b=p+8O4m64zpjnuQLFXJfq97ijY4o3YkYEZWbYrTaZdKdcf41x/1LlfQiPThaG5szw/2j37fGL4HEpVHcy265PswJvH+yQkOQ8S3RwDzyUeHGxttVEeazfuy3cbbcJoiSO0BQ8IBINglhxntCBMTqKi1XHbUg+HSXcWAocckUCavU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719521437; c=relaxed/simple;
	bh=KC4szPB0fnb0qUuOHYRj4CsMOsYpONDRYlGswyk9WqU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JpoA9YaDqAQ5F/zMHRHghwryqushTmxquJqrU3xTm4hKzNC8MJpQTdTynIj8pSmzLk/aEjUA3osinovvanpRU/H/ppgaEjfDcRSCqZuc9mpZBpvx1IXsprqq5cnfkn3OqRwpaH13uasD/irIV91ZSjS/dXkWIF09upSrGRmD7CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=krmQgKKy; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7066c799382so5633553b3a.3;
        Thu, 27 Jun 2024 13:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719521435; x=1720126235; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MHz9DTPfilK+7WGBA9UwNn6uh6SMAGNR7YQEFRA1WZo=;
        b=krmQgKKyyUEAg4aY1dltFAoSeQQ3aQ3c80a9JTId3TAlb5EXeAnmiqflxPUwNQi9M7
         dzICTP1ZKiKJ3hYmmyOa3jbGS9KHr+f5NMLiW0pEk0Xv2TXHcGjHxyhqw0ynwltZsand
         X9CSUG+mBYB6m6ianwoceAo2k99iBwCWdtbfnLlU05aWGDIqUyBmceeTwnarN+6lTwXi
         buKqRp4AA6EjgWMa0KIKfUcLmsIsgjF47wSIDK4N1Hr/yylGhUf95xroXxnAN9Ap0Yl4
         Q+k47F3f6UhWkZAu1wAKVkY4rZf7k9V5LAyRe11oInxtJS1TazlsR7Q/wU04r/F/hF5s
         5SGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719521435; x=1720126235;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MHz9DTPfilK+7WGBA9UwNn6uh6SMAGNR7YQEFRA1WZo=;
        b=AE/k1qVFwsMkwPXKz1IOv/lJwg9I0HEhoJdB91DMqAGHuwgkGpgLnRufS/uYwSF1J/
         P4gESaCGSQ14iTn+hlC8xW5JNz22EQCDJ94ToVJMVFt/spq2Wn/amTaswu1Nolsdjkx5
         8/eyY3zR/U/IncvPSXSxZAk9q9mjUFy+PHG/TkyfyuZ8lWIvFJmvSGhnQfr8JP+zKTHP
         0DuXDXH8L7CBG6qzl1nD9scjQPWgZpeA+c3BWstODvLX9qQaY3T4Q+x/pVDSNHYtXFbl
         yoA844/OqhNGe4i/1kqrsnxPHXToc2hyz+Duosb1kEXknC+ATZj3oEZSiJx/jqFlIx2m
         fI5w==
X-Forwarded-Encrypted: i=1; AJvYcCW89JKZbK+m/Y41jMU4KnXODA4j4m6KcQVXz71bSpJdsu7LRvOj2iIr5I+rMBF9rme8T4MsKRrTUZCeiEN4BoVTZKwwOVEZG+q82r6e/rYvyBTvdBTu7d8cvctBEjWBlssNktqCf8lQOAxOKE+M0ywW50UxUVQE7tgyLECAdVBEcA==
X-Gm-Message-State: AOJu0YxWLKwJkC7PIuuzMuTV/e3jZy1S9bU+38+D79pnxCcw6Vbw/i7O
	JFre2/skPizop6oH1dx75Mt2JC/jCAvkGHWwvdPlCM3aYTeR/Cr+iSWDyRWnyg3oUaCNOhbf0ji
	Pi/NGoTAbk2Gas/m7aqcHEUXj7eA=
X-Google-Smtp-Source: AGHT+IGkOVmVNmOWwBaHCXLri82Ny30fL/zbqbahI9+MDgOiz1A3svsaJXsUNkAM7XRnziT3OAWkPmiXZDiRDy6UwKU=
X-Received: by 2002:a05:6a20:65a2:b0:1bd:2d53:35d8 with SMTP id
 adf61e73a8af0-1bd2d539644mr5541216637.49.1719521435007; Thu, 27 Jun 2024
 13:50:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240627170900.1672542-1-andrii@kernel.org> <20240627125938.da3541c6babfe046f955df7a@linux-foundation.org>
In-Reply-To: <20240627125938.da3541c6babfe046f955df7a@linux-foundation.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 27 Jun 2024 13:50:22 -0700
Message-ID: <CAEf4BzaNOrMWB=nimR-UD8-MrC37kHQi6fh1hBv+aPWvoiSm5A@mail.gmail.com>
Subject: Re: [PATCH v6 0/6] ioctl()-based API to query VMAs from /proc/<pid>/maps
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-fsdevel@vger.kernel.org, brauner@kernel.org, 
	viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	gregkh@linuxfoundation.org, linux-mm@kvack.org, liam.howlett@oracle.com, 
	surenb@google.com, rppt@kernel.org, adobriyan@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2024 at 12:59=E2=80=AFPM Andrew Morton
<akpm@linux-foundation.org> wrote:
>
> On Thu, 27 Jun 2024 10:08:52 -0700 Andrii Nakryiko <andrii@kernel.org> wr=
ote:
>
> > Implement binary ioctl()-based interface to /proc/<pid>/maps file to al=
low
> > applications to query VMA information more efficiently than reading *al=
l* VMAs
> > nonselectively through text-based interface of /proc/<pid>/maps file.
>
> I appreciate the usefulness for monitoring large fleets, so I'll add
> this version to mm-unstable.  As we're almost at -rc6 I'll await
> further review before deciding on the next steps.
>
> Is it possible/sensible to make this feature Kconfigurable so that people=
 who
> don't need it can omit it?

It's just a matter of #ifdef/#endif, so not hard, technically
speaking. But I'm wondering what's the concern? This is mostly newly
added code (except factoring out get_vma_name logic, which won't be
#ifdef'ed anyways), so if no one is using this new API, then it should
cause no issue.

Generally speaking, I'd say if we don't *have to* add the Kconfig
option, I'd prefer that. But if you feel strongly, it's not hard for
me to do, of course.

Or are you concerned with the vmlinux code size increase? It doesn't
seem to be large enough to warrant a Kconfig, IMO (from
bloat-o-meter):

do_procmap_query                               -    1308   +1308
get_vma_name                                   -     283    +283
procfs_procmap_ioctl                           -      47     +47
show_map_vma                                 444     274    -170

But again, do let me know if you insist.

