Return-Path: <linux-fsdevel+bounces-25591-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5246A94DC3A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Aug 2024 12:17:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 093E91F21E7B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Aug 2024 10:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3DB6157472;
	Sat, 10 Aug 2024 10:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YX1LFxoi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C03814D283;
	Sat, 10 Aug 2024 10:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723285033; cv=none; b=eVmH7WJ4y5Mut9bwYrTl/WibvsRQD2yl95Lzp+PHES8BbUlJXH9FH6oKJh4GVC8/FkhSEhwyLaHHei+rS6OH3JhN8A5/jdNydpgL+rJF/Pb2iZvpGAkRcqc8HwxhA8MV3LoI6sll/uL92pk9fA0wAFUKkOlnAnyF+JDN75c2YIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723285033; c=relaxed/simple;
	bh=0J4RB0A0mmNUZDMDMImrBJQYByqCZaDq6FuoBs5H1DU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=oJRrEJ97xmh1MfIsRuwO2Q/gFA5bA1R2uyuDpR4laf2DqXWSp5Ca/enZEwq6UG6dCklZBPTiAYI/cLi72cuIPghpUCVnN6zA/rB+tweLcdqIIMpYC8OZpzUUAnBQ2cSZEk/RbKrtY9JT4ww7/DeIBLR0Di2mHYjQHD/w1/OxQF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YX1LFxoi; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a7a8553db90so353002966b.2;
        Sat, 10 Aug 2024 03:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723285030; x=1723889830; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=l8nSCAz/QPE8Oq0QL5MoGe+UBHWDrszdnf2o7o2yT14=;
        b=YX1LFxoiD9V4BjXNCZAahBKm4XtaLwh6QqiTYpc0MS11rO0lBLDBTnQqSyJBQZwbrK
         BqK+gpUtcsQUBWqXaTuE1XO0uzSx31tKA0oGtxciIry317yszxTwLDFl0HE06CTSrgv3
         blWNIWwT3rjq8hQZsOo4a5P7VDDX2vnRQ9K8Ok5JFSuSx3YAI7UvRESJi+gP5qWVNo5B
         3jDZ4lmwoGUdsCj/EBNeJN2kJXJDPjNP+604PcCW33ipb+aH7wF8enNc0auXsV7gJc/q
         OByXi10uLxG9kZIcAMxEn9a/oXA2sI5Lg8t5oLIrGqhMsaElEKL6BuWUWhqhQ+mZebRL
         OY5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723285030; x=1723889830;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l8nSCAz/QPE8Oq0QL5MoGe+UBHWDrszdnf2o7o2yT14=;
        b=R6NqKrY+oe6DwX19U/UNoKxl3XopzK22KxC/kBc6H6p3QPbONctRj7ZBNwbdnTSP6G
         i6iyIL1bd20IN+J2d/ASwe+bJLbhp/YnPKCnsS0LDs977KsAbBjremQ1NcVKipRL4rBP
         RszY4kwIv3OrTde/LxjtXlMrKlQeDBZAa4UpHVw8x91rTgvhgIm1weeSHqti4E3CXy+o
         EVKHTNgnjBt96Fa7K8b8J94xkO2PiOlLSaS0LPX86IwgehMukwe2WLLeE+GfEVQow6bo
         3D9QW7pgpMgxKx1zmcGBMlNDbQaIL2rcASyKM1eOKpzGq/j/uRttwHr849iN3z42yZEQ
         nedA==
X-Forwarded-Encrypted: i=1; AJvYcCXSCn/WY2kmNDItxeeZyX026eebK5IufHj1owtHA5zCjBPKudF0XIGVWYqzQv+/YOoii87aQJEqw1upPu2dmy5wdcCQ8jPeM4ChNw==
X-Gm-Message-State: AOJu0YyIEYoyUojqcO7dFjQzYsEMdNuOHyRE+609Cd111Qd07CXxkZLU
	K1ghdBxnH1aRaV8Us70BhANXxJsUKmKGIzPlrm0fHdyHfiScRkaTEQ7DpTEDsXp1/rDcLtxCAc9
	GKm9OvUl5CsorDtUxnjFKGAoSk4o=
X-Google-Smtp-Source: AGHT+IHgaBqz1NZqp96W5r64buwgrcPXLs/FOkGIHsbhyMyHsQXns27Jh/tYYaQH2MfZplMaE6IgP3Aw2vGN3U43AO4=
X-Received: by 2002:a17:907:f718:b0:a7d:e956:ad51 with SMTP id
 a640c23a62f3a-a80aa5a490bmr339468466b.21.1723285029548; Sat, 10 Aug 2024
 03:17:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Sat, 10 Aug 2024 12:16:57 +0200
Message-ID: <CAGudoHFxuVQPLgrsWMoCA1NMFJxVJ7Hm+ymp_S1WM_0+iz7XPQ@mail.gmail.com>
Subject: ext4 avoidably stalls waiting on writeback when unlinking a truncated file
To: "Theodore Ts'o" <tytso@mit.edu>, adilger.kernel@dilger.ca
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

I'm messing around with an old microbenchmark which I massaged into
state pluggable into will-it-scale [pasted at the end]

I verified that with btrfs and xfs the bench stays on cpu the entire time.

In contrast, running in on top of ext4 gives me about 50% idle.

According to offcputime-bpfcc -K this is why:
   finish_task_switch.isra.0
    __schedule
    schedule
    io_schedule
    folio_wait_bit_common
    folio_wait_writeback
    truncate_inode_partial_folio
    truncate_inode_pages_range
    ext4_evict_inode
    evict
    do_unlinkat
    __x64_sys_unlink
    do_syscall_64
    entry_SYSCALL_64_after_hwframe
    -                vfsmix2_process (22793)
        3913285

The code reopens the file with O_TRUNC. Whacking the flag gets rid of
the off cpu time.

I have no interest in digging into it. I suspect this is an easy fix
for someone familiar with the fs.

git clone https://github.com/antonblanchard/will-it-scale.git

plug the code below into tests/vfsmix2.c && gmake && ./vfsmix2_processes

#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/mman.h>
#include <fcntl.h>
#include <assert.h>

/*
 * Repurposed code stolen from Ingo Molnar, see:
 * https://lkml.org/lkml/2015/5/19/1009
 */

char *testcase_description = "vfsmix";

void testcase(unsigned long long *iterations, unsigned long nr)
{
        char tmpfile[] = "/tmp/willitscale.XXXXXX";
        int fd = mkstemp(tmpfile);
        assert(fd >= 0);
        close(fd);
        unlink(tmpfile);

        while (1) {
                fd = open(tmpfile, O_RDWR | O_CREAT | O_EXCL, 0600);
                assert(fd >= 0);

                int ret;

                ret = lseek(fd, 4095, SEEK_SET);
                assert(ret == 4095);

                close(fd);

                fd = open(tmpfile, O_RDWR|O_CREAT|O_TRUNC);
                assert(fd >= 0);

                {
                        char c = 1;

                        ret = write(fd, &c, 1);
                        assert(ret == 1);
                }

                {
                        char *mmap_buf = (char *)mmap(0, 4096,
PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);

                        assert(mmap_buf != (void *)-1L);

                        mmap_buf[0] = 1;

                        ret = munmap(mmap_buf, 4096);
                        assert(ret == 0);
                }

                close(fd);

                ret = unlink(tmpfile);
                assert(ret == 0);

                (*iterations)++;
        }
}

-- 
Mateusz Guzik <mjguzik gmail.com>

