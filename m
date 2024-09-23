Return-Path: <linux-fsdevel+bounces-29889-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B224A97F0B2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2024 20:35:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EC621F22D25
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2024 18:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A4821A0AFB;
	Mon, 23 Sep 2024 18:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BAT6pvFF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239AC13A869;
	Mon, 23 Sep 2024 18:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727116503; cv=none; b=hAwZb0b2GuIcHJij38I7xDuLflmhvC0aaomomcmv8qakV/S0yAFgzp/yby020znAiwVT8laGTebtNfUF5afmmIUN8g2NQPyPIZS5eU2r8e6rasUkKHmnD89l211vQyHpqOZznnhhThzyLWFTKcXavjRAGauiYTDXD/8tvse69O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727116503; c=relaxed/simple;
	bh=RKX5fFXoGLb5zuDBXhdYVsPbUnLmox4g9PwyHy+lMJg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k6ta/qSZVzaMlGqDDx87Z0A8en1m+rqX22klUyAOzDdwcVrUy5q0Z0zewJE0Ci5Vhl2XziHduLAB/9cMFRBFqlNfeW1IjVedVof5IT1eUaX2tjoCEbJJpCCtXthij+5p9sU6hfXL68cGog49cfb/rVF9m/+7qFJ0KSpIRKM4VPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BAT6pvFF; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-710d9b33303so3495137a34.3;
        Mon, 23 Sep 2024 11:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727116501; x=1727721301; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IU1aoQ8nAToYML3G712UX67gK+ebjEKMmSqhwWIOXRU=;
        b=BAT6pvFFyXKgWQy9Xe5OXG8+VGN4priUQBeLxrCXBU7et00nFwjtQGRKDaECO5YD3m
         V6NMl7s9uQNMkIX96D6h5AB7bsWTNXT1tclPqHYhAIikiXSgyeUhS8iYQKVGA1m0ofMG
         77vBOz4bgetr/GKYkldYJeSqaJKAjmaT60W9vyfjbGl+vZfyWigskeKtDgnKMrSXo5ck
         d3L+VBi/SXYItm730PhEZRIl7i7PrszjePrYH+oWKEkZSVw07eRFQj9G7RCuxbNgt671
         YvYrXtsqpG+z8nnSDqZUh51uQiqSvRh22okVt7qvkbbXBu1UgitC3bDRjMgpOaL+GJqj
         feZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727116501; x=1727721301;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IU1aoQ8nAToYML3G712UX67gK+ebjEKMmSqhwWIOXRU=;
        b=RSWE+ZhoigLQSu1dgXCzK8o2adkDg2Becb7gOy9lYE3tugymRJrdnRgsbrt+y1KtRo
         hRet0NRge++3/Hc1BrAazsMgoOjRKxPNEd+hDc2w2cADoR0Z2KMOSpG32O4bREaLc4eE
         HJiAptlgzvXrrkR4OMG8pHlfShrG9XIkpVZz0Nd4YYTPY8t3C5HT5dsBKpoe1a84K4Q/
         FKYmdNBYETUWZLwFJu7VkwLvgK4pW0S626xcEPa530iDZmDJZRWFwxh4tWgRakQ8z3oY
         2FJ1THwOhkJqaehsa8nQIbbjPbnPxsCrma3okUNweoe8DWjKaSs8ZO6PEVoC9UHG/j/V
         jOVA==
X-Forwarded-Encrypted: i=1; AJvYcCU8LP2JIJZx6Ne5TRqfxmHimFiRnVtJAP1/Jw683X/LrIlmozpF/LRZxkr95g9kt+43FazLhBX8a55zJg==@vger.kernel.org, AJvYcCV0AIJkf45sbJrZyAyzQuo80Oas9z5299XT16Idjvf+s1PzcWuRhyr0deCTrbW4/ecgKn09ZBD+ML7y@vger.kernel.org, AJvYcCVXEVK7rEMwWD9LiJcPs6NRRHC8ZvNhEiHP4iFltxCuUS8WMPdf4G1c+eS3gr4Buv+hoPNdRm8hlDvq@vger.kernel.org, AJvYcCVtaLmtJdJwXFCl372oKIhIZYHFsMvCgd1NC96XwrkpTMU90hvvB1oOHpxQ8YlJsLSQhtfnqp7c047ndNapCA==@vger.kernel.org, AJvYcCWrGMe/mraGMdTadtHdsBisJYdZ79luIAPHF0/MsHEUsrjCUmV5/hpxZpxsMfoIw1mK15tYgSTk@vger.kernel.org, AJvYcCX4uSFCb2qURiaAK73TVW0aJo4DJEyY9yrBGCYyN8KH8Ns8Fbudqm/GowJ4pBsAxrqcZwFZmNSdlzd71Kth@vger.kernel.org
X-Gm-Message-State: AOJu0YxldV5W7wldMsSVy7RWoCvqYc3pHuG9YAux9aNu7TqfN5rq0CZW
	S4thsqlO5uptPwYa1XHjLekH3OSUXvw5lFRvDPAVR0/jRzrM3bOx
X-Google-Smtp-Source: AGHT+IFvgEYijirg/eXLBYiD5dxcd0Zmc+d70nalPrLG/FqXhYvz1aSQ8Ig7QbHNJjxjsN+QDuXf8g==
X-Received: by 2002:a05:6830:3891:b0:703:6076:a47 with SMTP id 46e09a7af769-71393533f16mr8751528a34.23.1727116501003;
        Mon, 23 Sep 2024 11:35:01 -0700 (PDT)
Received: from localhost (fwdproxy-vll-115.fbsv.net. [2a03:2880:12ff:73::face:b00c])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5e3b0d94409sm3611397eaf.18.2024.09.23.11.34.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 11:34:59 -0700 (PDT)
From: Manu Bretelle <chantr4@gmail.com>
To: dhowells@redhat.com
Cc: asmadeus@codewreck.org,
	ceph-devel@vger.kernel.org,
	christian@brauner.io,
	ericvh@kernel.org,
	hsiangkao@linux.alibaba.com,
	idryomov@gmail.com,
	jlayton@kernel.org,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-nfs@vger.kernel.org,
	marc.dionne@auristor.com,
	netdev@vger.kernel.org,
	netfs@lists.linux.dev,
	pc@manguebit.com,
	smfrench@gmail.com,
	sprasad@microsoft.com,
	tom@talpey.com,
	v9fs@lists.linux.dev,
	willy@infradead.org,
	eddyz87@gmail.com
Subject: [PATCH v2 19/25] netfs: Speed up buffered reading
Date: Mon, 23 Sep 2024 11:34:32 -0700
Message-ID: <20240923183432.1876750-1-chantr4@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240814203850.2240469-20-dhowells@redhat.com>
References: <20240814203850.2240469-20-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi David,


It seems this commit (ee4cdf7ba857: "netfs: Speed up buffered reading") broke
booting vms using qemu. It still reproduces on top of linux-master.

BPF CI has failed to boot kernels with the following trace [0]. Bisect narrowed
it down to this commit.
Reverting ee4cdf7ba857 on to of current bpf-next master with [1] (basically
ee4cdf7ba857 where I had to manually edit some conflict to the best of my
uneducated knowledge) gets qemu boot back on track.

This can be reproed by following the build steps in [2]. Assuming danobi/vmtest
[3] is already installed, here is the script used during bisect.

  #!/bin/bash
  cat tools/testing/selftests/bpf/config{,.$(uname -m),.vm} > .config
  make olddefconfig
  make -j$((4* $(nproc))) || exit 125
  timeout 10 vmtest -k $(make -s image_name) "echo yeah"
  exit $?

The qemu command invoked by vmtest is:

qemu-system-x86_64 "-nodefaults" "-display" "none" "-serial" "mon:stdio" \
  "-enable-kvm" "-cpu" "host" "-qmp" "unix:/tmp/qmp-971717.sock,server=on,wait=off" \
  "-chardev" "socket,path=/tmp/qga-888301.sock,server=on,wait=off,id=qga0" \
  "-device" "virtio-serial" \
  "-device" "virtserialport,chardev=qga0,name=org.qemu.guest_agent.0" \
  "--device" "virtio-serial" \
  "-chardev" "socket,path=/tmp/cmdout-508724.sock,server=on,wait=off,id=cmdout" \
  "--device" "virtserialport,chardev=cmdout,name=org.qemu.virtio_serial.0" \
  "-virtfs" "local,id=root,path=/,mount_tag=/dev/root,security_model=none,multidevs=remap" \
  "-kernel" "/data/users/chantra/linux/arch/x86/boot/bzImage" \
  "-no-reboot" "-append" "rootfstype=9p rootflags=trans=virtio,cache=mmap,msize=1048576 rw earlyprintk=serial,0,115200 printk.devkmsg=on console=0,115200 loglevel=7 raid=noautodetect init=/tmp/vmtest-init4PdCA.sh panic=-1" \
  "-virtfs" "local,id=shared,path=/data/users/chantra/linux,mount_tag=vmtest-shared,security_model=none,multidevs=remap" \
  "-smp" "2" "-m" "4G"


[0] https://gist.github.com/chantra/683d9d085c28b7971bbc6f76652c22f3
[1] https://gist.github.com/chantra/642868407d10626fd44febdfed0a4fce
[2] https://chantra.github.io/bpfcitools/bpf-local-development.html#building-a-vm-friendly-kernel-for-bpf
[3] https://github.com/danobi/vmtest

