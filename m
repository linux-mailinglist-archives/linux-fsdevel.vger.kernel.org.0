Return-Path: <linux-fsdevel+bounces-63518-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B54ABBFDB5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 07 Oct 2025 02:37:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77C41189B9F6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Oct 2025 00:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 307621C2DB2;
	Tue,  7 Oct 2025 00:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dyx3/wOb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E826418C02E
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Oct 2025 00:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759797467; cv=none; b=g4p7rJwWOFDPGxOTjugheZz8zUAP5PSZuB5DPfHkyqmoXBM2ppsBjPhg5ZQSsLJBr6+Ydgwa/ZnnQ+MNcNp5YQSfNMzYGQOCZzVH8lM4yg4NvhAoUy/TcLjjzwDaEED9+dMA3xoaFGa2W9JSFKvNsencYXHM/vay0TJ0PnB6C24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759797467; c=relaxed/simple;
	bh=LeW4oEoC0jVXMI/53SUIole/wRaIUb53z3v+GVNtlWQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VSjynF2mTRoKseNh4vdEkhoEbcVSZ6ulJLIqzb9MNHXaq5sFvJxwYZqnko36wbBVK9bkpKT6yYXVsaSb1FNmRLnNEx/oYb99ohguPm+LoCDk6UjWADfrDbEbSyhaq/eBMNQalIZ0OW2XriUWj7Vwl7ZFGs1/26vUNw8+Y648vdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dyx3/wOb; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4da7a3d0402so61167521cf.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Oct 2025 17:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759797465; x=1760402265; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LeW4oEoC0jVXMI/53SUIole/wRaIUb53z3v+GVNtlWQ=;
        b=dyx3/wOb/IbpYrWE37LEqbueYzOggy6m11/Yyj2gOFmykA3zn61JIuWuN5Q9/v5lUi
         KP8HPgxRPmEobkP+PflyPstDySdfwqaowZ/vEtYx/cd/y96s0QG9ou2zy1McKW8lI+lS
         PeuzWe3i+K+Szz3SSTDfSqAvJG6HGQqS+bul1TgK7OZz+Dg6zLVOcCK134Dy+ZfN3rDa
         HKIxZsLkylrE0QZlKBn2HdxuiV61SoqWUAiHjrPh82NqsM2bbqqjxFmPYisT8+HBgzeB
         0f4VPIEDCfXh/wh88q4UcLFhBUORN0QiJCpKWuMUhNY5Agc2+mb4yfic/CdHOl5fcGLS
         Q1Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759797465; x=1760402265;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LeW4oEoC0jVXMI/53SUIole/wRaIUb53z3v+GVNtlWQ=;
        b=O+qTAi70FbWhBEupUz7kp4N3UdLRSAHHmevL2B6Wq+dmB06OwLjFJap9ALgGboL+p0
         60UxELcjc4O7TobBHS1PypjziYHrnza8RP4g7Q+lGimhneYzUg+zurdlWDAeaBg/CxKX
         XXzuPUdrPYa7r59Ml7eQ39A0MOt/nrm0GrzV0+80lj4gtafU/4VkssaOysSJeVT5wt/b
         6j5sOSLs9q/mMayfoGi0baxGhqDJfATeymxkdOpxh+CSjbypwhs//rPj9JEP1QIa/d22
         OBOWTeAEPcpPPhOUaFf7I20/R5d53trMTRBZ+NgJl8K1kgAkcbwZdtZ1+ekHYZCm6c5M
         mHAg==
X-Forwarded-Encrypted: i=1; AJvYcCUs3iu+dgRsRXSwYBCkd+g943RqhLu2NZhZlUjrP2Y5/2EsbG+JrErpwSeOXUZRWtnEPUer/3JE7GPEbZhe@vger.kernel.org
X-Gm-Message-State: AOJu0YxRZoTsjbjYBaE+XswRZOg7+6qCXIBg61ECUbTo/jDZRl5XrAB8
	3Xs6zfBkOFkKKwnGJC4HFytRkH5dCPyNeWyNJXolcQCNNk0Fr5m5jciBta5TC1EelZZka5H0x2A
	rYCG7Tlj/4vlrFS02Yr4R0lbpQVnXsoc=
X-Gm-Gg: ASbGncuQnDHtPrYz3VpxHxwzXgbw2txBui8+y0Ak2qy8McKa28yLO6YhVh4LMYg7F2X
	LyKsBfDZbzknGs8D98L64jD81YmcxDU9AHkv56KD43UAe5jZyxjWUBybY19HAMeNQf+UdxNe0d3
	Yb2usVUkyAaUtS9Up4O1F9z1Q+VMbjF0qD2H8FMKyY8VZbEoFVJ80PUxQlTO0gZYOikIXZxGtxZ
	uHJczxiYSh1rwkOP9dVwaUjaZwatJjNeKYB6A1nHsu3W51x3VC6p8y1v1P+sfIXujEFZP7KYDaw
	D4A=
X-Google-Smtp-Source: AGHT+IHaCIZUliZH1//byHGOprpPytJURWYDJxUiIVSByfFPJ5EYmFpct0rCriqOh3MCBOdNx9F8q7TiyTMjQpvg0XU=
X-Received: by 2002:a05:622a:5518:b0:4b3:4077:6875 with SMTP id
 d75a77b69052e-4e6de8846d6mr27241941cf.25.1759797464729; Mon, 06 Oct 2025
 17:37:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925224404.2058035-1-joannelkoong@gmail.com>
 <dc3fbd15-1234-485e-a11d-4e468db635cd@linux.alibaba.com> <9e9d5912-db2f-4945-918a-9c133b6aff81@linux.alibaba.com>
 <CAJnrk1b=0ug8RMZEggVQpcQzG=Q=msZimjeoEPwwp260dbZ1eg@mail.gmail.com>
 <a517168d-840f-483b-b9a1-4b9c417df217@linux.alibaba.com> <CAJfpeguSW1mSjdDZg2AnTGmRqe7F9+WhCHd3Byt2J7v4vscrsA@mail.gmail.com>
In-Reply-To: <CAJfpeguSW1mSjdDZg2AnTGmRqe7F9+WhCHd3Byt2J7v4vscrsA@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 6 Oct 2025 17:37:33 -0700
X-Gm-Features: AS18NWDJddRZqCH2EKzAOY9ZqcxMLD_msxCi2RZFDorAjtaFBI3DLD5S3yX9ElM
Message-ID: <CAJnrk1b04DmBZsiNi+AY-Q3M2tF+0HFzBHVMbD-arTObcFqvyw@mail.gmail.com>
Subject: Re: [PATCH] fuse: fix readahead reclaim deadlock
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-fsdevel@vger.kernel.org, 
	osandov@fb.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 30, 2025 at 3:09=E2=80=AFAM Miklos Szeredi <miklos@szeredi.hu> =
wrote:
>
> On Tue, 30 Sept 2025 at 04:21, Gao Xiang <hsiangkao@linux.alibaba.com> wr=
ote:
>
> > In principle, typical the kernel filesystem holds a valid `file`
> > during the entire buffered read (file)/mmap (vma->vm_file)
>
> Actually, fuse does hold a ref to fuse_file, which should make sure
> that the inode is not released while the readahead is ongoing.
>
> See igrab() in fuse_prepare_release() and iput() in fuse_release_end().
>
> So I don't understand what's going on.
>
> Joanne, do you have a reproducer?

Omar figured out that the servers where we ran into this had fc->no_open se=
t.

The igrab() in fuse_prepare_release() you mentioned above happens only
when fc->no_open is not set. commit e26ee4efbc79 "fuse: allocate
ff->release_args only if release is needed" is what changed this
behavior.

If we revert this commit, I think this fixes the issue. Unless you
prefer another solution?

Thanks,
Joanne

>
> Thanks,
> Miklos

