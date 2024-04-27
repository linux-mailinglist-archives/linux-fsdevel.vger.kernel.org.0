Return-Path: <linux-fsdevel+bounces-17958-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 124C68B441C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Apr 2024 06:42:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E05B1C21592
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Apr 2024 04:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C5A83F8DE;
	Sat, 27 Apr 2024 04:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QAeTVr7d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4E5358A7;
	Sat, 27 Apr 2024 04:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714192967; cv=none; b=tBMcdV/RdXpr2bp6FepwcR7lD3JYVaZonV4731vewnDYGRQshGQ8hLrZpRHiZgCTChG16QVvmkpyZcDGum1N/H+X70VPM89FIanwbzMkhlGYGZCW9Yh6fEGInevP4znrpzOlYIuWsrQJCx3yWmv8nHvPKgWNcgYV7B1RaE750gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714192967; c=relaxed/simple;
	bh=f2UtlilTB+NWyGbHhjTaQ6uvlSI5Rz24uqxBJIbjLRk=;
	h=Date:Message-Id:From:To:Cc:Subject:In-Reply-To; b=re33LZMmGPkSvYJgy+j5nns4TvOmyii3PjYVdZoq2eMeo3TbVvZLOBCbE2/DuHbnlgaay2UyKWqHYsgXpvvQMn8l2yEkYiLKR2zwTfpHuwG4vxsJDVc/LfnmhTzoJXehKZ5kGKtKsbmGSBydivByZwnCUWnEY8JuQAQytrjuvYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QAeTVr7d; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5f7a42bf0adso1991273a12.1;
        Fri, 26 Apr 2024 21:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714192965; x=1714797765; darn=vger.kernel.org;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gX6Kv0ZDlAZrNyQOc7s3myIf0ml0ww5XWHco4OKS8vQ=;
        b=QAeTVr7dzQ/2h52QKnpa9Tkoat/O69lFnZ8VSabg3MgUjc4CjrClS08sXWv9z57KQf
         bE+E0cKFSccJ4B2XMydILLI2aukMoXyt0/4jGn/BB2cvE/mypE/ZBs+CdM1GviHgxcc6
         9ddrcZ5iaMvaPotoxJ9TcrjdOTD2uVjHbWA6nyc+yXWQsokiqd/1QWS3YnGHhjoiRd3I
         iWt54EiLZB/XmeI4DtaeAvIBF3mgjSLUY0nSZ2gSkpS5moWLeu2Kfye/KuSOh+0u3Sh3
         9FyQvlaSKZKoIwRP+idPZ4/TL0lVKxvrTmP9Zoqe/dnXG8uQTOZC2CUnLrzOdUbg4+Js
         oloQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714192965; x=1714797765;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gX6Kv0ZDlAZrNyQOc7s3myIf0ml0ww5XWHco4OKS8vQ=;
        b=J4qgAVmajQgycXQfkn2W/sRNVrFfjEB5ndgJmvlFYilMa7g7HTq39Ac7gqtmTGyh1G
         aE7gtWpG9qMTeDhCauuEzT2uNs+/N7+RtDK2CkfI6o93C62IhRr2aescI3vszOIMfzq7
         4HhUOG5eDs8Yz4mTMOU92LUEbjh4haCxC2eZ8CuIAnPL2Ze9QUL/1rHwWhU1UF87VhVe
         Gl/OeDWH+b7sxM1O8wuasinEL2r0w3nr9prr4QUwzU1KTIJ8S/ZF9dKHCYNXWosrV+Sf
         7sE5fBiT38EMgNIGqjex7QNnycLsWq2NGe7QAf76TJ1Znbep36E+qa89MGUqAlhPVyGx
         gk8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWAFCDNinWZn82GIiJXk7B522pDagYYdM2jr7kw2rTw4eYxOjX6MGD7Fge8z3BE2prTvBVZcFFv+QgtUqKVQ+1vjnHU+qS1GK45uM1dceb2KlaSp1hmN2hVLReNtMP5Vivp0qEPajEO
X-Gm-Message-State: AOJu0YyPYcrM3r6vn7X6uakvF2q0hRb48alwP80A1NCcPE4MoMb2Bf8E
	2z3IJlV0BPseslewZlL4/lqkhirITv7PLhcI6Wd9TaXLSNwk7yOa
X-Google-Smtp-Source: AGHT+IHJtHsLXGRqm0eJDKNU85qy0IoSvysDeb3jyTEI6Ojtr7nyYbNnCsraRc6ufwySyfAYE2ornA==
X-Received: by 2002:a17:902:ea0f:b0:1eb:52fd:fe3b with SMTP id s15-20020a170902ea0f00b001eb52fdfe3bmr980397plg.8.1714192965288;
        Fri, 26 Apr 2024 21:42:45 -0700 (PDT)
Received: from dw-tp ([171.76.87.172])
        by smtp.gmail.com with ESMTPSA id j12-20020a17090276cc00b001e41f1dda43sm16258349plt.75.2024.04.26.21.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 21:42:44 -0700 (PDT)
Date: Sat, 27 Apr 2024 10:12:38 +0530
Message-Id: <87y18zxvpd.fsf@gmail.com>
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>, willy@infradead.org, djwong@kernel.org, brauner@kernel.org, david@fromorbit.com, chandan.babu@oracle.com, akpm@linux-foundation.org
Cc: linux-fsdevel@vger.kernel.org, hare@suse.de, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-xfs@vger.kernel.org, mcgrof@kernel.org, gost.dev@samsung.com, p.raghav@samsung.com
Subject: Re: [PATCH v4 00/11] enable bs > ps in XFS
In-Reply-To: <20240425113746.335530-1-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

"Pankaj Raghav (Samsung)" <kernel@pankajraghav.com> writes:

> From: Pankaj Raghav <p.raghav@samsung.com>
>
> This is the fourth version of the series that enables block size > page size
> (Large Block Size) in XFS. The context and motivation can be seen in cover
> letter of the RFC v1[1]. We also recorded a talk about this effort at LPC [3],
> if someone would like more context on this effort.
>
> This series does not split a folio during truncation even though we have
> an API to do so due to some issues with writeback. While it is not a
> blocker, this feature can be added as a future improvement once we
> get the base patches upstream (See patch 7).
>
> A lot of emphasis has been put on testing using kdevops. The testing has
> been split into regression and progression.
>
> Regression testing:
> In regression testing, we ran the whole test suite to check for
> *regression on existing profiles due to the page cache changes.
>
> No regression was found with the patches added on top.
>
> Progression testing:
> For progression testing, we tested for 8k, 16k, 32k and 64k block sizes.
> To compare it with existing support, an ARM VM with 64k base page system
> (without our patches) was used as a reference to check for actual failures
> due to LBS support in a 4k base page size system.
>
> There are some tests that assumes block size < page size that needs to
> be fixed. I have a tree with fixes for xfstests here [6], which I will be
> sending soon to the list. Already a part of this has been upstreamed to
> fstest.
>
> No new failures were found with the LBS support.

I just did portability testing by creating XFS with 16k bs on x86 VM (4k
pagesize), created some files + checksums. I then moved the disk to
Power VM with 64k pagesize and mounted this. I was able to mount and
all the file checksums passed.

Then I did the vice versa, created a filesystem on Power VM with 64k
blocksize and created 10 files with random data of 10MB each. I then
hotplugged this device out from Power and plugged it into x86 VM and
mounted it.

<Logs of the 2nd operation>
~# mount /dev/vdk /mnt1/
[   35.145350] XFS (vdk): EXPERIMENTAL: Filesystem with Large Block Size (65536 bytes) enabled.
[   35.149858] XFS (vdk): Mounting V5 Filesystem 91933a8b-1370-4931-97d1-c21213f31f8f
[   35.227459] XFS (vdk): Ending clean mount
[   35.235090] xfs filesystem being mounted at /mnt1 supports timestamps until 2038-01-19 (0x7fffffff)
~# cd /mnt1/
~# sha256sum -c checksums 
file-1.img: OK
file-2.img: OK
file-3.img: OK
file-4.img: OK
file-5.img: OK
file-6.img: OK
file-7.img: OK
file-8.img: OK
file-9.img: OK
file-10.img: OK

So thanks for this nice portability which this series offers :) 

-ritesh


