Return-Path: <linux-fsdevel+bounces-36665-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4794F9E77B2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 18:49:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B99016C5F6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 17:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C36C41F3D2F;
	Fri,  6 Dec 2024 17:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0x5eRo9w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31EF2206A9
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Dec 2024 17:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733507389; cv=none; b=JxuQJqMmYWGvR3jnF7KqtGVUZUkax0QWKveK3sE8yCuNhHNQPFkdXQjZ4dvgaRcqrFeZbv/XdgXtsH2AT6V88yV3r7wTuTmjV4erTKdq9qxZy8gPxrcuDfP013Z4VYvyjY7tOJGdz7bfKmid1Pnn7w2a65zoyAQkJHhI8xafh1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733507389; c=relaxed/simple;
	bh=Bre9gwXQ48//F2EbV9TQT2zjeWJlPa61yL1jM0ZFrbA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nW2+EV0z9YJTV1satxOvkMAgbhplRSMmfpDKLVEubbwbcPhj+KVWkw2s6VtLdc9Z9Q+We9Ag85h/kLK3jD78nVaGPAZA4e1BKhkq+2Ef1Vm4WOqUHbGN2BMkR/XVavuAOK8XU0pZS+fxEYeJ0XUWGQpwpjeW3Pmhra1j8GzqgvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0x5eRo9w; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-21625b4f978so56555ad.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Dec 2024 09:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733507387; x=1734112187; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xJX3AeNdAYoSbc5Ua6KEly/YydBSYF1iDHSbiQeKmAI=;
        b=0x5eRo9wARZXefoUy/1xdN1iZ0f4zI8Rp+rCPD/WyE+qgj9b4npJwrdJ6ym+Aa+Xc6
         jnxbLyos66o4XBJbOcwjlrxaHJmoy9GN/qqB0KwVAObF8l1tK1D07Ack5xDtSjgYmvXV
         Le2CTWYV+6C2oojw5TtMn9JPznkTxGIrv/E7Mt/vCSkO6s+YWlYHjgvslJezzY6GqeWV
         kpuLu6qWx1wOXlwvooha0bA23z3oNgjhs54FIuli8nhP+SQnGQ5ce9D6Wv5FJXqGzesh
         /Ey3xUlQ1Zj0OuaghhH6n6QdgbW5TBdCFepddx5ZJG93bff0KN97SaXAuN3kIWNg8CEw
         csiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733507387; x=1734112187;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xJX3AeNdAYoSbc5Ua6KEly/YydBSYF1iDHSbiQeKmAI=;
        b=aPlLUtT4mwd7MIgVIDqzQcaBvU9F4/xHuJcR5Ma+OSMcINpd8xPzWY8VKqpamXWXQ5
         ZaPXClDY/w5EnKE5rhxVSGwIKKT+9ZySShv+nivzGhCP45Q0ob0rvt/Jw3ojbPm+Zxmw
         /kjdMGciyRaSV2KX85jNPC077LckJf3R43nANvorf9pYYHnuj1BIqNTK8kBMsq5/pQ8a
         lkpuLCr38VQfI3UMo+cmmictz+8POqXkZBAftVefInWWZIuJXfFPvOIaYpjKVV77RcnY
         tA9KiPeC6GYr9tFkRgGQ2fPTwKUPi1TKO4rOB3/ZaF2U6wM48MJuB3Tjqrc4ljIEBAFO
         Aezg==
X-Forwarded-Encrypted: i=1; AJvYcCUxiTJ7PMclh5iXbLG3v/W5USpWVKPOSw8Y8je+QzyfaescbfeHeVpLya2d2zDL6BXIHVYP0pl40asEZH2J@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5fClbrfesEBjXpHGRuV1xVNMJnvf8gfB98uziJAwrBcj81i18
	yPhyoDVH3lAFWUchgtX0IDjQdrruE0dRJ2+tvfjP1Eal856nWByRN/IKlkNX6veMI3P4ToyD9FZ
	yyj2quqYUM2rlHsX4t8fJziOLZ+aLXuk3LyjJ
X-Gm-Gg: ASbGnctFqflCBZSrm0B1qV/AOkrvaL8h1IpEBhok914RzYWYGzrQFh2rFtoYBDF2V5o
	wT9aViZLqLi1bQneANwlNqcsi2xjCHia67ObTywKJBXbh/tssp543jy305Rkb2B/j
X-Google-Smtp-Source: AGHT+IGfFI/XAFWRnvadh9nU2CwBaiNbo2MVGQ6VycR/E364RCB3UsSrcfvM50twmVKO1ZLiV5wWhjjpMpQg9cmBCTM=
X-Received: by 2002:a17:902:ce10:b0:20b:81bb:4a81 with SMTP id
 d9443c01a7336-216172772f2mr2385875ad.7.1733507386833; Fri, 06 Dec 2024
 09:49:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241206010930.3871336-1-isaacmanjarres@google.com> <20241206010930.3871336-2-isaacmanjarres@google.com>
In-Reply-To: <20241206010930.3871336-2-isaacmanjarres@google.com>
From: Kalesh Singh <kaleshsingh@google.com>
Date: Fri, 6 Dec 2024 09:49:35 -0800
Message-ID: <CAC_TJvdVhGW+4y0JHqRVTdqAWpQRDOgWW8b1TAK3V9zdnmw0ow@mail.gmail.com>
Subject: Re: [RFC PATCH v1 1/2] mm/memfd: Add support for F_SEAL_FUTURE_EXEC
 to memfd
To: "Isaac J. Manjarres" <isaacmanjarres@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jeff Layton <jlayton@kernel.org>, 
	Chuck Lever <chuck.lever@oracle.com>, Alexander Aring <alex.aring@gmail.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, Shuah Khan <shuah@kernel.org>, 
	kernel-team@android.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Suren Baghdasaryan <surenb@google.com>, John Stultz <jstultz@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 5, 2024 at 5:09=E2=80=AFPM Isaac J. Manjarres
<isaacmanjarres@google.com> wrote:
>
> Android currently uses the ashmem driver [1] for creating shared memory
> regions between processes. Ashmem buffers can initially be mapped with
> PROT_READ, PROT_WRITE, and PROT_EXEC. Processes can then use the
> ASHMEM_SET_PROT_MASK ioctl command to restrict--never add--the
> permissions that the buffer can be mapped with.
>
> Processes can remove the ability to map ashmem buffers as executable to
> ensure that those buffers cannot be exploited to run unintended code.
> We are currently trying to replace ashmem with memfd. However, memfd
> does not have a provision to permanently remove the ability to map a
> buffer as executable. Although, this should be something that can be
> achieved via a new file seal.
>
> There are known usecases (e.g. CursorWindow [2]) where a process
> maps a buffer with read/write permissions before restricting the buffer
> to being mapped as read-only for future mappings.
>
> The resulting VMA from the writable mapping has VM_MAYEXEC set, meaning
> that mprotect() can change the mapping to be executable. Therefore,
> implementing the seal similar to F_SEAL_WRITE would not be appropriate,
> since it would not work with the CursorWindow usecase. This is because
> the CursorWindow process restricts the mapping permissions to read-only
> after the writable mapping is created. So, adding a file seal for
> executable mappings that operates like F_SEAL_WRITE would fail.
>
> Therefore, add support for F_SEAL_FUTURE_EXEC, which is handled
> similarly to F_SEAL_FUTURE_WRITE. This ensures that CursorWindow can
> continue to create a writable mapping initially, and then restrict the
> permissions on the buffer to be mappable as read-only by using both
> F_SEAL_FUTURE_WRITE and F_SEAL_FUTURE_EXEC. After the seal is
> applied, any calls to mmap() with PROT_EXEC will fail.
>
> [1] https://cs.android.com/android/kernel/superproject/+/common-android-m=
ainline:common/drivers/staging/android/ashmem.c
> [2] https://developer.android.com/reference/android/database/CursorWindow
>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Cc: Kalesh Singh <kaleshsingh@google.com>
> Cc: John Stultz <jstultz@google.com>
> Signed-off-by: Isaac J. Manjarres <isaacmanjarres@google.com>
> ---
>  include/linux/mm.h         |  5 +++++
>  include/uapi/linux/fcntl.h |  1 +
>  mm/memfd.c                 |  1 +
>  mm/mmap.c                  | 11 +++++++++++
>  4 files changed, 18 insertions(+)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 4eb8e62d5c67..40c03a491e45 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -4096,6 +4096,11 @@ static inline bool is_write_sealed(int seals)
>         return seals & (F_SEAL_WRITE | F_SEAL_FUTURE_WRITE);
>  }
>
> +static inline bool is_exec_sealed(int seals)
> +{
> +       return seals & F_SEAL_FUTURE_EXEC;
> +}
> +
>  /**
>   * is_readonly_sealed - Checks whether write-sealed but mapped read-only=
,
>   *                      in which case writes should be disallowing movin=
g
> diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
> index 6e6907e63bfc..ef066e524777 100644
> --- a/include/uapi/linux/fcntl.h
> +++ b/include/uapi/linux/fcntl.h
> @@ -49,6 +49,7 @@
>  #define F_SEAL_WRITE   0x0008  /* prevent writes */
>  #define F_SEAL_FUTURE_WRITE    0x0010  /* prevent future writes while ma=
pped */
>  #define F_SEAL_EXEC    0x0020  /* prevent chmod modifying exec bits */
> +#define F_SEAL_FUTURE_EXEC     0x0040 /* prevent future executable mappi=
ngs */
>  /* (1U << 31) is reserved for signed error codes */
>
>  /*
> diff --git a/mm/memfd.c b/mm/memfd.c
> index 35a370d75c9a..77b49995a044 100644
> --- a/mm/memfd.c
> +++ b/mm/memfd.c
> @@ -184,6 +184,7 @@ unsigned int *memfd_file_seals_ptr(struct file *file)
>  }
>
>  #define F_ALL_SEALS (F_SEAL_SEAL | \
> +                    F_SEAL_FUTURE_EXEC |\
>                      F_SEAL_EXEC | \
>                      F_SEAL_SHRINK | \
>                      F_SEAL_GROW | \
> diff --git a/mm/mmap.c b/mm/mmap.c
> index b1b2a24ef82e..c7b96b057fda 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -375,6 +375,17 @@ unsigned long do_mmap(struct file *file, unsigned lo=
ng addr,
>                 if (!file_mmap_ok(file, inode, pgoff, len))
>                         return -EOVERFLOW;
>
> +               if (is_exec_sealed(seals)) {
> +                       /* No new executable mappings if the file is exec=
 sealed. */
> +                       if (prot & PROT_EXEC)
> +                               return -EACCES;

I think this should be -EPERM to be consistent with seal_check_write()
and mmap(2) man page:

" EPERM The operation was prevented by a file seal; see fcntl(2)."

Thanks,
Kalesh

> +                       /*
> +                        * Prevent an initially non-executable mapping fr=
om
> +                        * later becoming executable via mprotect().
> +                        */
> +                       vm_flags &=3D ~VM_MAYEXEC;
> +               }
> +
>                 flags_mask =3D LEGACY_MAP_MASK;
>                 if (file->f_op->fop_flags & FOP_MMAP_SYNC)
>                         flags_mask |=3D MAP_SYNC;
> --
> 2.47.0.338.g60cca15819-goog
>

