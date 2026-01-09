Return-Path: <linux-fsdevel+bounces-73062-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E5C7D0B087
	for <lists+linux-fsdevel@lfdr.de>; Fri, 09 Jan 2026 16:49:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E5A24301FB68
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jan 2026 15:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE8242882A9;
	Fri,  9 Jan 2026 15:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="CXuuJCGv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6CA500946
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Jan 2026 15:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767973392; cv=none; b=PoZq3P2Y17ViRC/7QAKX/frWSz8/PVq9S07w+pPFTG70lrtwY10RB54iUyAEcy8jvOpH9RSjCZnYiuby4IjUM4zsyybCi0M4oIxq/vaTBno/AkZBVy5qp/HO8SfpAeD8D5+T0IC+MK3Mps6b3SDK8BbSxl+a7Hd8IVS1eK4ac7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767973392; c=relaxed/simple;
	bh=QNPOhk5Es1DDVi8HpjVAsH4iHy4P3eWp0+XjiS0I17w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p4Jd2yF5N9i4/ePqO0+w9fnlFBDn4IRuinTfd/tGShAUqf2QjTmOLVF5NEQ3FfwHBGWm4h5UryC33YgEO5adEnIH4FHQoXBtJ1mL1JA6hGg0c5RXwbg2hZ3E8cXz3CAVoNgA5i+ethTuigFRkUsA67CbLMhMeu4yB74xfx9aTws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=CXuuJCGv; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-11f42e971d6so2904949c88.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Jan 2026 07:43:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1767973390; x=1768578190; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YnOPVVAsjPQDWOaKaz9pR+f1JGQBc9UxTk4hwXiC1DQ=;
        b=CXuuJCGvqMsDUPT16eI8KMWvJm7kKWlFAgNJm9MgYzlDK0MUeRzpwvJJbKv7U4fXok
         oDSF4/Gsk9S3xqFVOC+QkuhCob7MC+DE9hV9IA09LeOUzsaZLmBLyfWGPuC99nk8TGoO
         djyxpmDQHGqW902fqVHBCmxYihkLlIXgztcPs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767973390; x=1768578190;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YnOPVVAsjPQDWOaKaz9pR+f1JGQBc9UxTk4hwXiC1DQ=;
        b=RBzBi5/vidtv4xyDNs2xXRdYh1CCiQBh/+dGWNLUxVULyl889kGq1v8SJJD7M8YgTr
         1kCd2gZdZ/GbAu8dDCZUoWfMqpsVGQOjj0/qaSIMbkBcEMJpCVzadBbGec/tdNT7PtSg
         4insOxksHddEkQpwZmmXqTd4gizO66H0vNYCcy1ubid4Fwf1fpC3iaaKT3Usum29Nihg
         +VnCFUXh2yuBUQHivUvMjcwsKbXD26xkHS1EYq49cuSY9SHssmOzLEm9PRKQHLkNqNwF
         9B0BDR5oEp/TsUgdXxKtffOao4hm8tHONzJ5riNwfF31pUXg6kgpen2RJipI+Br703x7
         CJPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUin4J0P8SNmW97osXqKkaBxNcRxoBpzIkQ0hnU5aQCLJ2o6ZkPdttVFwvgW8/moLD4M5gHLzrGx7MnNMT+@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3YM8imsdvIlEyrRTADCx7tyQ00IenkzvMWY1bbJtBWntBghw4
	/g/+3fyjrGPNMeugL6bPipTQC8aoeNuwfe5RH9EJclD5UHAPp1fQDWEnVXwDm287uUmbkNyqE2C
	kLFc3YtUqoUEePmtmrT8EyEVwa7nojm7KS37+Wc/qXNNYFigdPqh9
X-Gm-Gg: AY/fxX4zd0rgQluWG3xYd3ZgEjFAfcfa7E5XHR40/63BfePCzmCgWsjxfUHyTH6XEo5
	be8S2NEjwxge6ZRuTE/oFasIvJs8RLivBXC3FU5jUsZBdzcGOmzXDVAXqnw7HtQ3vCD4xEyAay7
	t1Wd3+RWNMg3ZjGAetNgyNQMnS6LNzMEkZjYTWXv94V40dDWtEAdVtvr9k8VM4ru0R5yuqycWfz
	K3O1sxOcI2Z6vRhFpWAuf4Fe3FXwsx8onUU937ArePoNB7yuUbIaw5h8NzywRl2yTpp
X-Google-Smtp-Source: AGHT+IGzUDL2kx53wRtM88vO/pFpYrhDOWVO1h4BnSpbjH3CvkBV25cTk22wta29mnlsLEkkg5pyW5N76x6e5a3YY1o=
X-Received: by 2002:ac8:7d47:0:b0:4ed:67bc:50de with SMTP id
 d75a77b69052e-4ffb4958b63mr148334791cf.24.1767973046585; Fri, 09 Jan 2026
 07:37:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251212181254.59365-1-luis@igalia.com> <20251212181254.59365-5-luis@igalia.com>
 <CAJfpegszP+2XA=vADK4r09KU30BQd-r9sNu2Dog88yLG8iV7WQ@mail.gmail.com>
 <87zf6nov6c.fsf@wotan.olymp> <CAJfpegst6oha7-M+8v9cYpk7MR-9k_PZofJ3uzG39DnVoVXMkA@mail.gmail.com>
 <CAOQ4uxjXN0BNZaFmgs3U7g5jPmBOVV4HenJYgdfO_-6oV94ACw@mail.gmail.com>
In-Reply-To: <CAOQ4uxjXN0BNZaFmgs3U7g5jPmBOVV4HenJYgdfO_-6oV94ACw@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 9 Jan 2026 16:37:14 +0100
X-Gm-Features: AQt7F2rJ8XmeMDm1w7IVauLrMMw8v9qKA44XIbz202N6LBff3QM8dCKnoUHMHZM
Message-ID: <CAJfpegsS1gijE=hoaQCiR+i7vmHHxxhkguGJvMf6aJ2Ez9r1dw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 4/6] fuse: implementation of the FUSE_LOOKUP_HANDLE operation
To: Amir Goldstein <amir73il@gmail.com>
Cc: Luis Henriques <luis@igalia.com>, "Darrick J. Wong" <djwong@kernel.org>, 
	Bernd Schubert <bschubert@ddn.com>, Kevin Chen <kchen@ddn.com>, 
	Horst Birthelmer <hbirthelmer@ddn.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Matt Harvey <mharvey@jumptrading.com>, 
	kernel-dev@igalia.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 9 Jan 2026 at 16:03, Amir Goldstein <amir73il@gmail.com> wrote:

> What about FUSE_CREATE? FUSE_TMPFILE?

FUSE_CREATE could be decomposed to FUSE_MKOBJ_H + FUSE_STATX + FUSE_OPEN.

FUSE_TMPFILE is special, the create and open needs to be atomic.   So
the best we can do is FUSE_TMPFILE_H + FUSE_STATX.

> and more importantly READDIRPLUS dirents?

I was never satisfied with FUSE_READDIRPLUS, I'd prefer something more
flexible, where policy is moved from the kernel to the fuse server.

How about a push style interface with FUSE_NOTIFY_ENTRY setting up the
dentry and the inode?

Thanks,
Miklos

