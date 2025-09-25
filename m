Return-Path: <linux-fsdevel+bounces-62681-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 02072B9CD22
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 02:08:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DD0E7B6BCD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 00:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F1834A00;
	Thu, 25 Sep 2025 00:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mR+s0zJZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701AB524F
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Sep 2025 00:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758758898; cv=none; b=B/s8iToXv8ejOVLwe32dr583cNj8xfGknVAvzDbOwu5ZoBOGg/gOD7iDjgLacKLbUwAfL1qQsI0v7lRqIgUy4vtoH82+KFyKQVfvn008rFKbWWqOumUZf0fBRjyUt7i9TTUy58le10fHATPYy40/72IFNqAokONNUqIz+xG5ppg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758758898; c=relaxed/simple;
	bh=1j0WLj1QF4gS669f14k180su/X7X1j6huC+rxtu6YYE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=otLkam1vhdA7IpNG+ujR3iCOZpH66wet0hFecWowpoLcmiaywf9UIQsgNNA38AH4tuThM6/3/bmfBmKoK74gEwORhGUa0XbtZBk6QUWGLx08pBwwFNEcfiJz0zkfJqwMN9B2Ko9O9vCSHTaAtwvMw5aikUFVYxKfxvITPiu5+m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mR+s0zJZ; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-71d603a9cfaso3935317b3.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Sep 2025 17:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758758896; x=1759363696; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RDdXAgTmaSeAT4Oi3BmR6CFI1klm1bLgue8UYADMbgM=;
        b=mR+s0zJZfQwq5KcDAkwUfIutVZRxe5mAD56xbd0sxG4PKh238tzVx+06Ra8aAN4otc
         k1nESGE/RuJNnADRRY+e/BcA0Qf2bVCZli/SRNw6RTH7Qgq6Yfd7tTP4KyD8Pj/iTukp
         6xE8DPTZR8FvedIQvpFYB2jrOII39giVXbRt/gDYs/TS3O7VNMdbiwCQKhYgBQemkLQD
         tFxN+y7AIUAzDvR9rJBbRaHv01dW2Sqmrms/i1hSDjIMjXVEwp531SP/m/7HkK3r7jEN
         DrgphYT83C0jo95RXNkxDiAr6LLatnJVGl4C/W2cbx0zKrNnzi29hukoTlnNHXyPjzcB
         4ADA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758758896; x=1759363696;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RDdXAgTmaSeAT4Oi3BmR6CFI1klm1bLgue8UYADMbgM=;
        b=XqIOW8c2npHmjP8AncnXyp/2RkmmuTn2GO32/5/K9A6OXVCP0L/U5LtKHWIKcIsrU8
         NHUvSbMxrFPQt20OtC97usIVV9YYN7KICQbYja2vWCLDnufmBKshIzDd7YmGk72ATfPH
         lPBg+rY/PyEj3St4pNFfs3aJ+ndSa9YQQ0rw3zy/c/0JOc3io3ZFZn5r30Y5b+yfcpfm
         D/ndDPi7ddfbVxUm1OArveb8VRZRAlHNwLfET3tT6vfzcU3+r4vnMkDmn+csHJzrhhh6
         gd/FhsGvkvdUq5ToZ1g02oRNV9muvXZFAjTO+wVZzr4YpvqEo4YkFsbOP/YsJts+M1Ez
         bFfA==
X-Forwarded-Encrypted: i=1; AJvYcCUGFdmhYN4wOL6iMZLIOLbWAmoNoWymw3u5nNS7IzPvmqEi9TMWc0bU9GrAzdfaWCUHyW/kcQ9vEhTf2ILg@vger.kernel.org
X-Gm-Message-State: AOJu0YziJ6MePJM0NXaD8fVex5VzLLIIprtaifuUTTwgPpRSibhiDgsz
	50kYHp9MglyTW4QMQgD3Ghkgt9Ge7k3PpYnBL1us5tKe4ut2sdz3LDXDIysQ0jTSkO2FgWrAM11
	3sZNCkgL4rDuiFxnoKN7h5a2yOTcLHw8=
X-Gm-Gg: ASbGnctrorQAB86d0z3fOf/DVsI58U4ALZdy/K2wk6JKW6r9aoSQMISmThp/t+XdGAA
	zqkNyjmsFDppZwjNidjWGShoHU8zFtb9KA/7otWhdXDzdzDJrrFT28KkvJjDmNNrj3aU+UsHAt+
	e7U7FSYNDjx2rBQmJ2YbvHrIs4ryMR4UwpHV4YPJ+grIwhj2xEIuM+T7ey81yx3oC7e15Dbsqg8
	x7j6q78FY+IaheieuVXrTZKz5rZKfFh6NPRS4Y5
X-Google-Smtp-Source: AGHT+IH7u4UlUoQrCzp0iX/ZF2Xq7nDnA0PLfR7inNQ02Jb9AIa4sgs0pY86RONSHUEq03BTVpK3eA0hK7vOUzDcBhU=
X-Received: by 2002:a05:690c:8685:10b0:749:d874:e684 with SMTP id
 00721157ae682-763fddbf52fmr14878007b3.17.1758758895995; Wed, 24 Sep 2025
 17:08:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250924232434.74761-1-dwindsor@gmail.com> <20250924232434.74761-2-dwindsor@gmail.com>
 <20250924235518.GW39973@ZenIV>
In-Reply-To: <20250924235518.GW39973@ZenIV>
From: David Windsor <dwindsor@gmail.com>
Date: Wed, 24 Sep 2025 20:08:03 -0400
X-Gm-Features: AS18NWDpfeDX-uhYUa0rY5ZCQgxR8-I5TzkwtQoSoouaV71K4oxhB3DbDVwhUqE
Message-ID: <CAEXv5_jveHxe9sT3BcQAuXEVjrXqiRpMvi6qyRv32oHXOq4M7g@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Add dentry kfuncs for BPF LSM programs
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, kpsingh@kernel.org, 
	john.fastabend@gmail.com, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 24, 2025 at 7:55=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
>
> On Wed, Sep 24, 2025 at 07:24:33PM -0400, David Windsor wrote:
> > Add six new BPF kfuncs that enable BPF LSM programs to safely interact
> > with dentry objects:
> >
> > - bpf_dget(): Acquire reference on dentry
> > - bpf_dput(): Release reference on dentry
> > - bpf_dget_parent(): Get referenced parent dentry
> > - bpf_d_find_alias(): Find referenced alias dentry for inode
> > - bpf_file_dentry(): Get dentry from file
> > - bpf_file_vfsmount(): Get vfsmount from file
> >
> > All kfuncs are currently restricted to BPF_PROG_TYPE_LSM programs.
>
> You have an interesting definition of safety.
>
> We are *NOT* letting random out-of-tree code play around with the
> lifetime rules for core objects.
>

File references are already exposed to bpf (bpf_get_task_exe_file,
bpf_put_file) with the same KF_ACQUIRE|KF_RELEASE semantics. These
follow the same pattern and are also LSM-only.

> Not happening, whatever usecase you might have in mind.  This is
> far too low-level to be exposed.
>
> NAKed-by: Al Viro <viro@zeniv.linux.org.uk>

