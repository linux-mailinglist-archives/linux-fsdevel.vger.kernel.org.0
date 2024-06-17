Return-Path: <linux-fsdevel+bounces-21852-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D86490BC44
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jun 2024 22:38:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A9B8282AE6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jun 2024 20:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5496198845;
	Mon, 17 Jun 2024 20:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Th/prkL2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6D416A94F;
	Mon, 17 Jun 2024 20:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718656704; cv=none; b=cUeHOkodVdEDHd0f9tMkGmY9HmcxzYcvTxuevVJqd2pX/WVhio7vErHKv3gI9lw53SWhX/zSXihoz74ufyeENXE2/pQ/udmax3lgF7mczTajRPAWzgtRT6LZAQ42tTy+lOKx0bVceQOdbN44/KNkt+I5KZ+gpInw3N4mGc7neUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718656704; c=relaxed/simple;
	bh=g6r4tu5O++2Gkj+NhWSyl517YR+jO0b0k72/RLDUIFI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=L8b7qKdrp/NQpP7/C7/JNru330InwKzLjAxk4r+Wnz23f/jDic4Gk7VMqhY5FQutU2lOxL1vTrLPpQnPgHp9u9YbQxIhTgPsje0EFTVH1rvCOWilDkpPU9AYC1l4IjY5hNBt74WI4cU3DeE26E0/AbIbIVuQYQERNEmEIy3F3/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Th/prkL2; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2c70c372755so20371a91.1;
        Mon, 17 Jun 2024 13:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718656702; x=1719261502; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wWKtaKnmvywmEIjC97Wx0A/LSKQpHW9eCV1f5V8v23A=;
        b=Th/prkL2p2yU5FwK9S2yLO9vAZX2YSXVTcFu7m50H9X/B6OG4etqTZ6QOKxbdy8v/g
         BOE82aFKSjVRX2hSCTo2FyQzF/nWkhBUXVFpPHuKPS+PfsE+ZtLa1HZwNiI72cnU8jdx
         nHtb9h3ww9aSZyLTR3jYruFiqhBXS4cYlCLbz/70JFSOJkxcL3JfVvvN5vEfcyvEKgqU
         SMC3iIHxd87VX+vB3xwH6vmXVfhaoUtLp3dprqyW9YHFFLpUHqGsGZ915PEkNU85JVHs
         swThBJeycDZYa2Kuh3TX70aHgPzB6MaNgDiUawYLhDuYUHK/2E2uCoEhRKfBk6TcdoEg
         RVEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718656702; x=1719261502;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wWKtaKnmvywmEIjC97Wx0A/LSKQpHW9eCV1f5V8v23A=;
        b=pRgrh6H+5nNcvqyD7wce3hJGZ6BlHsCoJUlUaLoVNRONvwc+2MZub6dPoPDI2b/yNY
         5yZGFz53h2tEp8y+X88/+CCetBWCu+FZb0Is6LAuaB9YM7kRF5dvQAUn6vY+fyJp/7g3
         PEdkhx55ryshH05677Zoqm1Eg89EEDqp9K/7VAKWtSBuhzxjUGkkD16xoNEMcauc8FVH
         9IxwaN/lY6pyb/cQF9svTHVfd3+949ub/Dg8s3HcbW2LSaFYKETxTQMKC4mDsYBVxGkP
         1ey6to1acGmHL4GC8GmguSyCfYkOER8x4qnLTj9FaIqTpLHTs3dAPIjyIli1zf0znVwe
         cQiw==
X-Forwarded-Encrypted: i=1; AJvYcCVFj0MlMiPDYe0FkFWuRolskibXxdTp3c9VX7TBJMcMluZQCs8BJMzAjOP8KLB29AubYDwWBLeKvXse8M5VJsuehFwPW1LE/SUQQty9rZbV4be5x9BK+fGZdo8+RfvGovQNnVrhCeF4dB+5RLLlPK0lBGz378giNbWSel/UsIp+pw==
X-Gm-Message-State: AOJu0YzIBx7uT8OMtRZv6c6amlIewdMfk4lb+aYfsWHDND1J46fw9gxC
	fonPBPcxxJF8mdb7Ji3OrRDtlShuR/t96j3K4U+zOoc5/8s/qy1guQOLdZN0PkMOhVVG88b9zrC
	kMlVdU8geosUosGVgazyPSBg6OD4=
X-Google-Smtp-Source: AGHT+IHsVSmW9ATxtdmSI+tE9L87wx8WVFIdF5YxHYndtJYHztnhDuuQsyxM5VE2Kkq4gSl+0bDQan0sDRLRS68xATY=
X-Received: by 2002:a17:90b:611:b0:2c7:869:4370 with SMTP id
 98e67ed59e1d1-2c708694475mr89731a91.7.1718656702174; Mon, 17 Jun 2024
 13:38:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240611110058.3444968-1-andrii@kernel.org> <20240611110058.3444968-4-andrii@kernel.org>
 <uofb56lk6isrwqf42ilky7r3wa4tetaaze2m2ususzqpbnftkw@hwskh5quvlfm>
In-Reply-To: <uofb56lk6isrwqf42ilky7r3wa4tetaaze2m2ususzqpbnftkw@hwskh5quvlfm>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 17 Jun 2024 13:38:09 -0700
Message-ID: <CAEf4BzbWzcnNu-mTHfKu20TYN75Z-3wp6BcrypeQu9h+Mtp6RQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/7] fs/procfs: add build ID fetching to PROCMAP_QUERY API
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Andrii Nakryiko <andrii@kernel.org>, 
	linux-fsdevel@vger.kernel.org, brauner@kernel.org, viro@zeniv.linux.org.uk, 
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	gregkh@linuxfoundation.org, linux-mm@kvack.org, surenb@google.com, 
	rppt@kernel.org, gerd.rausch@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 12, 2024 at 11:28=E2=80=AFAM Liam R. Howlett
<Liam.Howlett@oracle.com> wrote:
>
> * Andrii Nakryiko <andrii@kernel.org> [240611 07:01]:
> > The need to get ELF build ID reliably is an important aspect when
> > dealing with profiling and stack trace symbolization, and
> > /proc/<pid>/maps textual representation doesn't help with this.
> >
> > To get backing file's ELF build ID, application has to first resolve
> > VMA, then use it's start/end address range to follow a special
> > /proc/<pid>/map_files/<start>-<end> symlink to open the ELF file (this
> > is necessary because backing file might have been removed from the disk
> > or was already replaced with another binary in the same file path.
>
> Can we please also add the vma_kernel_pagesize() to this interface?  We
> have a user who parses the entire smaps file specifically for
> KernelPageSize, which could be included for a low cost here.
>
> The only way to get this information today seems to be from the
> /proc/<pid>/smaps file and it is necessary for certain hugepage calls
> for alignment reasons (otherwise the calls fail with -EINVAL).  Adding
> this extra information would allow for another text-parsing user to
> switch to this API.
>

Yep, it totally makes sense and is effectively free to add. Will add
in the next revision.

(and sorry for the late reply, been travelling and generally on
unusual schedule for the last week)


> Thanks,
> Liam

