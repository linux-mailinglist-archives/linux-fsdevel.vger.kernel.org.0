Return-Path: <linux-fsdevel+bounces-24528-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA2C94054D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 04:34:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A2D7B21D93
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 02:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B69B1474A7;
	Tue, 30 Jul 2024 02:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E21IJ4s6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA38138E
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jul 2024 02:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722306743; cv=none; b=CuxDK+99rRaJQuqgiZ5+6g6rGr6KkCYZSay00i/uGwfPuX+omKiUWlNQiMSBzycMIt9BNAdb1b261w+KriCZcKXydg92HNR2+BHkiP23NjVNOXRmJmxGVkO3zn9utADReooQuUAxocT9ypnlLPuIF5D1pWiX9Y8xJ0sOYdftqps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722306743; c=relaxed/simple;
	bh=Rm0owbYC8L0hEsuo0V03+RNUHXFw8fP5ApBGxuuZgNA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X8UhmKCMRIXkImIhfc+tX5up8IamFSc7JOVn6nfPrsB/ggHd+nQxlKBCgzOpkakojcUX1TKjnBYMDFYeswT5oByKM/ArpLknMScbFLSa45RYobF5HqRGaAmXhRqqeqkcMQ9NWWVrtMGQkOu+/wAHXZ+gqsiU5n9FMHEOb8GP4FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E21IJ4s6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F602C32786
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jul 2024 02:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722306743;
	bh=Rm0owbYC8L0hEsuo0V03+RNUHXFw8fP5ApBGxuuZgNA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=E21IJ4s6qT9br9fh4BkIlCH3uYbqKKRaL6lvDOe4gJdw//8d9n3/ejI/f1/rNRQXD
	 1jC16cBcHq1YTS4iqVzsLe7pS39dYlouBkd7yd7bo2YYZfVOcNshRMcI9a595P7HBy
	 pjCspum+i30gTPbp2g/xsK01BQ2VfsuDifkAveA53Jl0xCrZAH05yzCnE2PZ0OL325
	 +hWQz1u8uHZOy62zA9JPnUOmmQ2F2Pmgrj19cFN6IX3yf2Mbpmr8UnvxpEN7gHcBFp
	 qeI17TWGs8T5IxQsX5s8yvI/2CiUyl3xO4/LTRqsJWEUgVdNhMj1BE/oQYL7QuoztW
	 f7P2BRkw13WGw==
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5d5c8c1006eso2299646eaf.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jul 2024 19:32:23 -0700 (PDT)
X-Gm-Message-State: AOJu0YzKEfgdj0nsNJHIkh597pJ8NBiz9bPGqNi75pJTRz8V4jUlXVyS
	VXC3Wttnzl44ipOYkMVHx0AKAvpK+Th8Fr885L4AxnINaEvzKsElkEm0uNKehMagTsT99GqO7l7
	wgcnKK43s2KR4nhGjFs9JMDTHlWI=
X-Google-Smtp-Source: AGHT+IH+z+nB/wYbNtoUmxZ1+UVtjolc/e2gyg+T6NYLaCcidZgouED9RQfz0CNsD90MmvLaxLUBDPmj74Ik5DOxMgE=
X-Received: by 2002:a05:6820:270b:b0:5d5:c805:acae with SMTP id
 006d021491bc7-5d5d0ecc2a1mr9016201eaf.5.1722306742581; Mon, 29 Jul 2024
 19:32:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEqW9OxJtbqvLHBKygW918tk=hS+ThqR79DmO-2qYp+V1FfqPQ@mail.gmail.com>
In-Reply-To: <CAEqW9OxJtbqvLHBKygW918tk=hS+ThqR79DmO-2qYp+V1FfqPQ@mail.gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 30 Jul 2024 11:32:11 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-X-dVRwNQweye46OrGFq5Hj0_yZV-dnComOFtJYMvpGQ@mail.gmail.com>
Message-ID: <CAKYAXd-X-dVRwNQweye46OrGFq5Hj0_yZV-dnComOFtJYMvpGQ@mail.gmail.com>
Subject: Re: exfat: slow write performance
To: Vincent <laivcf@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, Sungjong Seo <sj1557.seo@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2024=EB=85=84 7=EC=9B=94 29=EC=9D=BC (=EC=9B=94) =EC=98=A4=ED=9B=84 11:47, =
Vincent <laivcf@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> I've found that write performance of exFAT is a lot lower than other
> filesystems on our setup with a fast NVMe SSD:
>
> - Kernel: 6.10.0-364.vanilla.fc40.x86_64
> - Test cmd: fio -name=3DfioWr -ioengine=3Dlibaio -directory=3D<mount poin=
t>
> -blocksize=3D1M -readwrite=3Dwrite -filesize=3D10G -end_fsync=3D1 -numjob=
s=3D8
> -direct=3D1 -group_reporting
> - Benchmarks:
>     - exFAT: Direct I/O: ~1370 MiB/s (Buffered: ~1250 MiB/s)
> (mkfs.exfat -c 1M -b 1M <device>)
>     - ext4: Direct I/O: ~2230 MiB/s (Buffered: ~2150 MiB/s)
>     - xfs: Direct I/O: ~2220 MiB/s (Buffered: ~2200 MiB/s)
>
> I found that direct I/O is disabled for most of these writes in exFAT,
> code responsible is "exfat_direct_IO()" in "fs/exfat/inode.c". As the
> written file is being expanded it is falling back to normal buffered
> write. The relevant code also has the following FIXME comment
> (inherited from the fat driver):
>
> /*
> * FIXME: blockdev_direct_IO() doesn't use ->write_begin(),
> * so we need to update the ->i_size_aligned to block boundary.
> *
> * But we must fill the remaining area or hole by nul for
> * updating ->i_size_aligned
> *
> * Return 0, and fallback to normal buffered write.
> */
>
> I have tried working around this problem by preallocating the file. I
> see good write speeds in the direct I/O case (matching ext4 ~2200
> MiB/s, Buffered: ~1700 MiB/s), the problem is that preallocation is
> slow since native fallocate is not supported.
>
> What would the maintainers recommend as the best course of action for
> us here? I have noticed [1] that FALLOC_FL_KEEP_SIZE was implemented
> in fat, so perhaps that would be simple to work on first?
It is difficult to implement due to exfat on-disk layout constraints.
>
> Does anyone with more experience in the exFAT driver know the full
> reasons behind the direct I/O disabling, and what it would take to
> support direct I/O during file extension? Perhaps recent changes may
> have made fixing this simpler?
I suggest you try direct IO write after extending the file size you
want with ftruncate.
>
> Thanks.
>
> 1: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/com=
mit/fs/fat?id=3Db13bb33eacb7266d66a3adf03adaa0886d091789
>

