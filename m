Return-Path: <linux-fsdevel+bounces-24452-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A8CD93F84E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 16:38:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1FD6282617
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 14:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C7CD15ADBC;
	Mon, 29 Jul 2024 14:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XzuBPrZS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE2315AD9B
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jul 2024 14:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722263661; cv=none; b=aNdeHVmo6HGJf+H4O84cRt4yRCH/Jfgp/8MEAPbHOZ65VZCQG+H0s9VUap68nUtI/ftAthXVltMGelZltAMPBJaAAn6oWnBzCzr5ftairxE+Wwio3VKn0pwe7e/Qwzve2QSdvcP/WtBGinpIVD0eeOLjWNXUYrajfs36yMec3EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722263661; c=relaxed/simple;
	bh=w5XqgsQI3VLPJ5/5j++f8Jc0bKEckkpeLFFDG7iiQFc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=JMocKY9i6L0q1E+uvZS3qZRzEAjBn1lBh+K9oLJqcTjmDOX/X0y0FXL2l9e48p7bC4fqUJiRUgtxV6zml4xHaAcYTI35caF/8eH+uiKtbigwcUTm9iq/fLX8/oyf5iM4FUwDxE4OJlO6cy2NPJZo8xLL0D+fw0Dt7xecFAmED+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XzuBPrZS; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5d5cbe88f70so1644777eaf.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jul 2024 07:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722263659; x=1722868459; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9OqArYKkUlj9N7xmjjT9UT1+jheSUOj0qJQmcibXC3o=;
        b=XzuBPrZScVD+m+q6NVrOQEsF2/60dOjlvsC72IpM8YDA0J/KgfL27y9Yl1uufJmvwY
         SVkWAmiJ1BFP/HLy5+tCY6vc7LT5wMwpgIQu7Dk5uFbrT2GydqvO1rrb+73VCy0zscHf
         C+fuLZIuWMXgnocDgNdJ97nQgVfeIaFoknVzkcRWRV6ybskYR9qAkyIBD/Tp1BRd6Jjy
         aionMJYXCYbjWpcsd8KCiZANM6z1S51VXNYPwcoQ5FjU/NLZrZuGUu/TIebmhq4fX0NX
         /1cqY8K19x7MHaTs0dxEZufnO82eIQqMhXU/ls0WQiPFQGqkwdsG94QxRA2KJ6SHCvz/
         L97Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722263659; x=1722868459;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9OqArYKkUlj9N7xmjjT9UT1+jheSUOj0qJQmcibXC3o=;
        b=OFerQtMnR68Am1IXpDPyHbY06du6sWaziDsM7bHOcoebLKueE2YJ2diwFD+lo8Bbvz
         j3cGEPQFue8uQ6wM4v5DXs23LO6sjUyrozHEFbpe+9MWEXGHlGPocptn4QdpR6cEX4ah
         mQbGXrRY0jaGHV+cM7X6qLdThNTd3wBAMynhlarLDQsWaY0aYs+hsfwVtdGbmymRF1sI
         jOZCFFNv1Evfs+JxIukYQtF85h9iz7qletQDz3kKO5Kctq0Y6tgmKcPE9IhlQp7FfPoh
         RqzbfNl1/k390vIRUwsqvEczMQ4wc/LAP5rmRD8T3MBxOo2mC4bqL6UoNh990eKfHiMo
         ft4A==
X-Gm-Message-State: AOJu0YyW6nhJAsRFxgQMHAmd1cXLcr4eIi+SQrbsM+OGfu7pW2N/wI6d
	pb6KMQll70h0aypR4BnQSlv4MXpObCcs9gK8zdsQQC8cWIe/4Ex1yUBMGGW9H3HoiL6QOPKh32v
	mVsQ+DjlSui7KBawBf8IrMwdsRYG3YFUa
X-Google-Smtp-Source: AGHT+IF0Q3Xhj4B+HxTKT3Smn5aLJTWMPkA7qSwhwkqxrtZ9Zf5VP2RA6iKHnATGoPAvPeCOrH4tNUVVmM1IaOmu0Ho=
X-Received: by 2002:a05:6820:160a:b0:5d5:a931:e8d3 with SMTP id
 006d021491bc7-5d5d0e98d85mr7151168eaf.4.1722263658600; Mon, 29 Jul 2024
 07:34:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Vincent <laivcf@gmail.com>
Date: Mon, 29 Jul 2024 15:33:42 +0100
Message-ID: <CAEqW9OxJtbqvLHBKygW918tk=hS+ThqR79DmO-2qYp+V1FfqPQ@mail.gmail.com>
Subject: exfat: slow write performance
To: linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

I've found that write performance of exFAT is a lot lower than other
filesystems on our setup with a fast NVMe SSD:

- Kernel: 6.10.0-364.vanilla.fc40.x86_64
- Test cmd: fio -name=fioWr -ioengine=libaio -directory=<mount point>
-blocksize=1M -readwrite=write -filesize=10G -end_fsync=1 -numjobs=8
-direct=1 -group_reporting
- Benchmarks:
    - exFAT: Direct I/O: ~1370 MiB/s (Buffered: ~1250 MiB/s)
(mkfs.exfat -c 1M -b 1M <device>)
    - ext4: Direct I/O: ~2230 MiB/s (Buffered: ~2150 MiB/s)
    - xfs: Direct I/O: ~2220 MiB/s (Buffered: ~2200 MiB/s)

I found that direct I/O is disabled for most of these writes in exFAT,
code responsible is "exfat_direct_IO()" in "fs/exfat/inode.c". As the
written file is being expanded it is falling back to normal buffered
write. The relevant code also has the following FIXME comment
(inherited from the fat driver):

/*
* FIXME: blockdev_direct_IO() doesn't use ->write_begin(),
* so we need to update the ->i_size_aligned to block boundary.
*
* But we must fill the remaining area or hole by nul for
* updating ->i_size_aligned
*
* Return 0, and fallback to normal buffered write.
*/

I have tried working around this problem by preallocating the file. I
see good write speeds in the direct I/O case (matching ext4 ~2200
MiB/s, Buffered: ~1700 MiB/s), the problem is that preallocation is
slow since native fallocate is not supported.

What would the maintainers recommend as the best course of action for
us here? I have noticed [1] that FALLOC_FL_KEEP_SIZE was implemented
in fat, so perhaps that would be simple to work on first?

Does anyone with more experience in the exFAT driver know the full
reasons behind the direct I/O disabling, and what it would take to
support direct I/O during file extension? Perhaps recent changes may
have made fixing this simpler?

Thanks.

1: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/fs/fat?id=b13bb33eacb7266d66a3adf03adaa0886d091789

