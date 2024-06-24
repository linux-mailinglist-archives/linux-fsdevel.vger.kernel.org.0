Return-Path: <linux-fsdevel+bounces-22236-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD24914AE9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2024 14:44:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F355A1C232FE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2024 12:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE2B13D2B5;
	Mon, 24 Jun 2024 12:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S+Xb7Eqj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E322913C8E8;
	Mon, 24 Jun 2024 12:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719233031; cv=none; b=fSrH3m3zS/3Ry4MZWrV1pJ+r3kWPLY3Sl6ZgmfvgRrc7l1BW0Sth3rC3pIRR9vgqoLKYu+qNefy5xQCdeJzDRaWwpzHBiqKoanX7Ww0COpWys+L6w6ra5e6PPyLcXHnB2gtgI4Da/cs57n8RGSETDDxySXWr2EIDmZqFm2Jyfok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719233031; c=relaxed/simple;
	bh=jApaBCYVztKacSl0tD+xU7VMd3kepWna98tjFc2atXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k/2ukfNJGOWddPgioz9TXmcSatVsjnWR+a8oKS9zRtxgy3i13r/TRes5bqBmvS9Go/nDBvOwPp+BDEw5Hw77GwRbrPFq2EMKLdhWG7MNGJuPFDfLyWCI/141gJSweoGoOv+uof1LW4RD50yNR2yuDu3vGEoaQqJb+mu3OCBp7a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S+Xb7Eqj; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-70024655285so2526972a34.0;
        Mon, 24 Jun 2024 05:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719233029; x=1719837829; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bBWUBcLCVdqut0FXaHBFebSPJlfehSuxQfvsdHPCuNs=;
        b=S+Xb7EqjVxc3j3OoCJTYc54j11b3C4cb6lIr7QTpudNbDtnEdEj+s9NLS3LlxrUYii
         hBSUQtIGshHm6GjQBRlFsCBISGB69EMt0F5UYANMw5q5Ug/4dd2gDXu4y3khnEmNxxa+
         sP1xjDu/4MEn5Sc3lAncEzeYDFC2zhIpMNi3WJrqiZaj/X+USMn68RD5NpRVJxEOPH9J
         2WM47z8CzwO+E8cMAEHga8wMUFz87dXrs74MCZb0zHpF4/X/3LDgFZpN1t3/FWxZKo0J
         +2LahXjsIcrS6eEqbaZlVsgUWvzIfTAduQnB28XNqsf04BlEYJQ92sbjAucxMgpsZdiV
         luyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719233029; x=1719837829;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bBWUBcLCVdqut0FXaHBFebSPJlfehSuxQfvsdHPCuNs=;
        b=S18PyGBUQch1qXLh0W7dBBdChUqPm/WFjlbnfMBxdCUhO8ctw4EqmckyNZFYKvCULT
         YhvzNX49nzhwWQNY5vE4zPDO6GhgQclnnhcx8XX7brvCfrnSP/7CCa3PP+XiETFba+ka
         p1ycRUGV8gIL58J12CtgPM8jAkeEJoeBN6vw41UjAXYh0STneDzKhZ1Mp1K5egQILG7O
         MiYPv9xNkbtIxI9de0Zz6hP9mhZoEN/YbJ2/QL6B6AvBz/Azigcp3luKhreBnAvD1Web
         wQ9GCktUtJEy1WGyFt48l8YeJgQN06GfLR4e+1xz6d2/wG+AbWwwWQJqq3DT0jzdC9ft
         shBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGuaG6ff2V6feO4rT4/mvHI3GqRxnHn5meNZpLUYEhUY+BD0sYfZzp9VH6DiBrnqn1fuCewqC1ADi45RFhu4/721ozL4iUwg8df/5DSA8B99t7Bci7PFqkEKzckq3ck3nAPwxQfn6TFwpqPA==
X-Gm-Message-State: AOJu0YyZYN0pvVBki/2UnSac0XhiV7GyRx9WY79/8sVuW6M1aPVikVel
	QdUniOXPkdLFDjT3j1UUMS6LYE8mRSLD12KWrd9g2SPSMf1xghBukMzl1Q==
X-Google-Smtp-Source: AGHT+IHPKGaTZmBW+rU8cmPJFtr0bAvrNnbe4mzzl1KvoXfv+a11ztewBoNJxWmG2lMzzhvIIdBv+w==
X-Received: by 2002:a9d:7385:0:b0:6f9:6065:5253 with SMTP id 46e09a7af769-700b1301e32mr4701499a34.38.1719233028841;
        Mon, 24 Jun 2024 05:43:48 -0700 (PDT)
Received: from Borg-110.local (syn-070-114-203-196.res.spectrum.com. [70.114.203.196])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7009c658d2fsm1166374a34.56.2024.06.24.05.43.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 05:43:48 -0700 (PDT)
Sender: John Groves <grovesaustin@gmail.com>
Date: Mon, 24 Jun 2024 07:43:47 -0500
From: John Groves <John@groves.net>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev
Subject: Re: [RFC PATCH 00/20] Introduce the famfs shared-memory file system
Message-ID: <w47upqsgruckx6i43gaqkdr7lhgacggonr2uwodapfb7n2byqr@yeiiri5wluob>
References: <cover.1708709155.git.john@groves.net>
 <CAOQ4uxiPc5ciD_zm3jp5sVQaP4ndb40mApw5hx2DL+8BZNd==A@mail.gmail.com>
 <CAJfpegv8XzFvty_x00UehUQxw9ai8BytvGNXE8SL03zfsTN6ag@mail.gmail.com>
 <CAOQ4uxg9WyQ_Ayh7Za_PJ2u_h-ncVUafm5NZqT_dt4oHBMkFQg@mail.gmail.com>
 <kejfka5wyedm76eofoziluzl7pq3prys2utvespsiqzs3uxgom@66z2vs4pe22v>
 <CAJfpegvQefgKOKMWC8qGTDAY=qRmxPvWkg2QKzNUiag1+q5L+Q@mail.gmail.com>
 <l2zbsuyxzwcozrozzk2ywem7beafmidzp545knnrnkxlqxd73u@itmqyy4ao43i>
 <CAJfpegsr-5MU-S4obTsu89=SazuG8zXmO6ymrjn5_BLofSRXdg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegsr-5MU-S4obTsu89=SazuG8zXmO6ymrjn5_BLofSRXdg@mail.gmail.com>

On 24/05/23 03:57PM, Miklos Szeredi wrote:
> [trimming CC list]
> 
> On Thu, 23 May 2024 at 04:49, John Groves <John@groves.net> wrote:
> 
> > - memmap=<size>!<hpa_offset> will reserve a pretend pmem device at <hpa_offset>
> > - memmap=<size>$<hpa_offset> will reserve a pretend dax device at <hpa_offset>
> 
> Doesn't get me a /dev/dax or /dev/pmem
> 
> Complete qemu command line:
> 
> qemu-kvm -s -serial none -parallel none -kernel
> /home/mszeredi/git/linux/arch/x86/boot/bzImage -drive
> format=raw,file=/home/mszeredi/root_fs,index=0,if=virtio -drive
> format=raw,file=/home/mszeredi/images/ubd1,index=1,if=virtio -chardev
> stdio,id=virtiocon0,signal=off -device virtio-serial -device
> virtconsole,chardev=virtiocon0 -cpu host -m 8G -net user -net
> nic,model=virtio -fsdev local,security_model=none,id=fsdev0,path=/home
> -device virtio-9p-pci,fsdev=fsdev0,mount_tag=hostshare -device
> virtio-rng-pci -smp 4 -append 'root=/dev/vda console=hvc0
> memmap=4G$4G'
> 
> root@kvm:~/famfs# scripts/chk_efi.sh
> This system is neither Ubuntu nor Fedora. It is identified as debian.
> /sys/firmware/efi not found; probably not efi
>  not found; probably nof efi
> /boot/efi/EFI not found; probably not efi
> /boot/efi/EFI/BOOT not found; probably not efi
> /boot/efi/EFI/ not found; probably not efi
> /boot/efi/EFI//grub.cfg not found; probably nof efi
> Probably not efi; errs=6
> 
> Thanks,
> Miklos

I'm baffled as to why the memmap thing is not working for you. I don't see
anything amiss in your config file, but the actual plumbing of that kernel 
option isn't anything I've worked on. Out of curiosity, are you running on x86?

Have you tried the 's/$/!/' method with memmap? That should give you a pmem
device instead, which you will see with 'ndctl list', and can convert to
devdax with ndctl (recipe above in this thread). Note that 4GiB is the minimum
size that famfs supports.

A quick status on where I am with famfs: I've made progress on my substantial
learning curve with fuse, and have come up with a strategy for the famfs fuse 
daemon to access metadata in a way that leverages the current famfs user space 
without excessive re-writing (which is encouraging). 

I haven't started test-hacking dax_iomap_* enabled files into the fuse
kmod yet; initial RFCs in that area are probably a few weeks out, but 
definitely coming - undoubtedly with a lot of questions.

Regards,
John



