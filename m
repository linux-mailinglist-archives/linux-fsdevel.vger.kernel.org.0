Return-Path: <linux-fsdevel+bounces-47006-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E1597A97ABD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 00:54:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6982B7AC3A8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 22:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 411442C2AB4;
	Tue, 22 Apr 2025 22:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iUAOqGvR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8071E8847;
	Tue, 22 Apr 2025 22:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745362487; cv=none; b=L7nVuPWVWtHVBmTyqgenGuDFScV7/Rh/GvQGNPFjPXXa1DtzLQvX4Hvnh+67hGb9k0a4I8LkTwvqxPSAjlpETmGoKKqZqcSRv26Y9U+kBDsYdN9tUtNa6tzPdp7zc1OddboUIBiy16otzPaSg93PdIFzEPDbzbmWqNuGXDlGcIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745362487; c=relaxed/simple;
	bh=1vS36F8s1bsOVKwjeh6skWo0k4UqNnubrCGwaxc9Y74=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iuinaU3eH9/oYB02ca4lmX6tYQ3Kg9+RCc4VbeWNZjYHYTfsiAIQriPEdNmFxRHtAy5ojmyHJQoIn1RcBFEdPh6AWaQzdJTJa2vDZoOgiRlbV56QUES/2J2oDyxwDYaBbgkTsFWAYrbua2uyiblbKzjKY7ZuJffi8QpbGFs6jAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iUAOqGvR; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-301c4850194so4340781a91.2;
        Tue, 22 Apr 2025 15:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745362485; x=1745967285; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=va7rv/YB9o98QrEUQSIKnbaS0ErDhKRmFDBMSbqCA5s=;
        b=iUAOqGvR9JqtiiMs1+3YYWteKXi6RrdJ6UXPNJbDOCVA2DnniYgAfXakdagjx3yRPt
         5mZP0bNXlLVpS7NrFoMsXClfHmxV5ZdG2Ave9pu3w19Pv+MqX/eo/zoIi29b1f0Z6vZ4
         cZROLSnDylBV/4zQuEQS08sC+WKYR/hHjceFZiRXfrpmBlvUNNyIZPEm8lU+A4QHmThh
         AGg0AJCkES/lamlg8vy6U3FHiffspW1OeshnbZkcnrHOFtyVMJDcjNGMYDYEKknxFs+G
         fpcrLe6F6qD1mw/nTfaSaywqAK7e+KEnFTwPeN5jnFZddoMsmDgSZTbSKV5szjP8Ps5Y
         NGzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745362485; x=1745967285;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=va7rv/YB9o98QrEUQSIKnbaS0ErDhKRmFDBMSbqCA5s=;
        b=b7btqNXM9QSSkrNCimbKzYZTRmC5nXhstrQrkvWcl1RCTN0YALZLAr4pwdcSviLwwr
         qxAYcSwpcXATo3PBkbKcQhdIhsNOnAtSCcjzebvfdxCLfzF2u+jBkLXoJsfwbwujV9W+
         5/mZOf973+IfZYEpwqtarR/joh9Ze9EKRcW4a17IqXWo86Xp9JvGoKgZsZABLp5pyv0b
         MY2v/J01VoVV9AvUwcUEoLSa3Lg1HZvTbRwdcKLj4sm9JcWzmKb2wYB2Dc8ZM+pq5NzN
         R5FAnRLnMhmdMUqMXGmiDsIuvCWA0fSOEXMQzNUPeIlDdKrOS5bbu7O/zphxjQJhUJN9
         tkQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEOMXpOnBJpbWg1cvnGyUR1n32flRj6ffsEEGH/ik8wtjAvHaWAVa6jYvC1W/BhWsjRpnK5A+0SwwN3eAOExOE@vger.kernel.org, AJvYcCVD2S97gVIdkkbS6Q43P4/vln4J6zcDSa3/Sdedn7/P3l5D/J+XP7Wl21QMdPI5OJGhbhtIYbApk4rlUvzT@vger.kernel.org, AJvYcCVZMXfAK6xhgYPqDlLIbP9MRVvYHrdY3OEY0LxnPn+tcZ9sB5DC7J0LotMDY49YgQl+k063POiuYSH1B9PN@vger.kernel.org
X-Gm-Message-State: AOJu0Yx98p1zAsQx7cZjlR2JwYYCvdVTXs+MMngzJpF9avtuVMxZq8av
	J4mup2SehIMKffZYlkqX/EW2pZGD+eX3M9W/GJ2krvUbcyz6154LR9aLnPL9M1wQ1a4X5e9rleq
	pGsAN+UoFPEJ8ZNRTmBdbEVPRIBY=
X-Gm-Gg: ASbGncuAoXxAXCd1of2FGnYfGcRGLLeQMfrGbN8BJjp1YWZJ4IHEiF4ljjZL3ziH4ua
	YsMfhebRcASMhsEv+kLCMr49w2D0QSRCVDknxnVt2THGyXSLerLVxH5wVWlInPym3ZT83gkpZBG
	MH9t1unBO96n9me9QI5T6JTu9D/NhNbyG58LcvmIoohXIORyPW
X-Google-Smtp-Source: AGHT+IETSG5/UWEu1Au6ZJP1tumDHJssb0nzJI+R/63RTT9r6RWwr2jpaTisqXWgIO+NT0mOGqFrbExkdqDuKO9oosM=
X-Received: by 2002:a17:90a:dfc5:b0:2fa:1a23:c01d with SMTP id
 98e67ed59e1d1-3087bb6bcaamr24335482a91.21.1745362485527; Tue, 22 Apr 2025
 15:54:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250418174959.1431962-1-surenb@google.com> <20250418174959.1431962-9-surenb@google.com>
In-Reply-To: <20250418174959.1431962-9-surenb@google.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 22 Apr 2025 15:54:33 -0700
X-Gm-Features: ATxdqUEvpJh0hlMQ-EDLD5Ec0LhTBj5XlTwZPc8jms5BGKO3PDMIjH7Os5YMtuo
Message-ID: <CAEf4BzabPLJTy1U=aBrGZqKpskNYvj5MYuhPHSh_=hjmVJMvrg@mail.gmail.com>
Subject: Re: [PATCH v3 8/8] mm/maps: execute PROCMAP_QUERY ioctl under RCU
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, Liam.Howlett@oracle.com, 
	lorenzo.stoakes@oracle.com, david@redhat.com, vbabka@suse.cz, 
	peterx@redhat.com, jannh@google.com, hannes@cmpxchg.org, mhocko@kernel.org, 
	paulmck@kernel.org, shuah@kernel.org, adobriyan@gmail.com, brauner@kernel.org, 
	josef@toxicpanda.com, yebin10@huawei.com, linux@weissschuh.net, 
	willy@infradead.org, osalvador@suse.de, andrii@kernel.org, 
	ryan.roberts@arm.com, christophe.leroy@csgroup.eu, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 18, 2025 at 10:50=E2=80=AFAM Suren Baghdasaryan <surenb@google.=
com> wrote:
>
> Utilize speculative vma lookup to find and snapshot a vma without
> taking mmap_lock during PROCMAP_QUERY ioctl execution. Concurrent
> address space modifications are detected and the lookup is retried.
> While we take the mmap_lock for reading during such contention, we
> do that momentarily only to record new mm_wr_seq counter.

PROCMAP_QUERY is an even more obvious candidate for fully lockless
speculation, IMO (because it's more obvious that vma's use is
localized to do_procmap_query(), instead of being spread across
m_start/m_next and m_show as with seq_file approach). We do
rcu_read_lock(), mmap_lock_speculate_try_begin(), query for VMA (no
mmap_read_lock), use that VMA to produce (speculative) output, and
then validate that VMA or mm_struct didn't change with
mmap_lock_speculate_retry(). If it did - retry, if not - we are done.
No need for vma_copy and any gets/puts, no?

> This change is designed to reduce mmap_lock contention and prevent
> PROCMAP_QUERY ioctl calls (often a low priority task, such as
> monitoring/data collection services) from blocking address space
> updates.
>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> ---
>  fs/proc/task_mmu.c | 63 ++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 55 insertions(+), 8 deletions(-)
>

[...]

