Return-Path: <linux-fsdevel+bounces-35656-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F889D6BCF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Nov 2024 23:32:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 596D2B216E5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Nov 2024 22:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF64019E970;
	Sat, 23 Nov 2024 22:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BYC6/wFe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60674137C37;
	Sat, 23 Nov 2024 22:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732401170; cv=none; b=ra+dNqughUUPRW+FH5+UHdbV99wSYrjZWqgIofoFc6Lw7TJZ2T55A77OYv84uq8RldNieHWoIQNdQxM7dgd+Sgz3iy5ZMm+hF2xUiqxzxAbG0iEPB3liT+lkueTTDw6rJskTbP9c/sJ0DHS3Pd7cHAIJMPP6X8OingTJtyG/tXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732401170; c=relaxed/simple;
	bh=Nk4VKU+4UkZZl7xiP/BV0EFMMFVeUg9V2zY8tgSiJcE=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=A6vJSahTeqFICYhz+DpGwQJ/eMWudNu5g7sKAoAkaq2lURWw1z3BO68VGV4Rde3Uk1VuOY8IzDHXOg0lK9O8YuSk86hGyR1n6cBtvkl5/KbVeUtUTs/xeUKkrk9OTMW1TudAN4mtulqVtGsGtubD76Wt/9SXNCTNMW4A2iDqEqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BYC6/wFe; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-539ee1acb86so3744302e87.0;
        Sat, 23 Nov 2024 14:32:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732401166; x=1733005966; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nk4VKU+4UkZZl7xiP/BV0EFMMFVeUg9V2zY8tgSiJcE=;
        b=BYC6/wFeTvHn2BVEfp96GlV68wHq47r2S5oLE4MZhLVRB/Y+dq8VFgYfavPBOT80UX
         Exnn2ilcfDuykw57IFrN4A/EPoO2P2xhqtHN8DYczb5qyrYVBQQQ7Kazepb84LxmVfJE
         xkM/TTGwWzsQx8zrnMAw0Gby0tLO3sTgUSi1HvpDQ+tjhlh8cg7fAGmnd/L2b5yiijDb
         1d4+lmBm61DFq5lIZJESDVNNb6x35ruNS5PPw0N1KZaMj/PSFR3hsm9CNr8Kr6bagZIO
         hPYzkf0Wrp4zBkoxT1LJkmNc1DjhMvvuPCUSKWfY3uspbNF8wP97aQ+FQd/3WffWB8eH
         25fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732401166; x=1733005966;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Nk4VKU+4UkZZl7xiP/BV0EFMMFVeUg9V2zY8tgSiJcE=;
        b=atY4nfUIWbTSWiH8/kZl1morHJdp0IAkspNWHibCSUc4bswyDqnrSwVNWT0ZZ1HEI6
         32sLF/JPk8IdsvFuiBrnotTrbSeNTunjwSNHz4tzPUBrDyTh8v8MJTlHQBwi6TNl3gAs
         y7+Hrge6FK3PyO8tvPkdyf1djpDtdRKLbpWDR6seyBbXaYLRJp63g3eL1TrElxXDjYZ2
         bfRdZAv552s4EOB7i3Lcvss1TCFA+q3WZGoMJqzdtmyR3hC4JWKkkselEIz7GKaMwizN
         jVwoCp9zUVKbhezPHWOSjgSPbhV0EfgjXvncYHc/a2bPVyq0ypraoI0ft4ezIuGDNKm5
         7STw==
X-Forwarded-Encrypted: i=1; AJvYcCVIac4pVN5mhgL9LlXU7mcQLMFZdnaMdb7FIbjYVmRCS1L0BPMkkkwfW199UQn0RPBZ5tIhW+8JVjqsiM1D@vger.kernel.org, AJvYcCWdez6fzXlYX23ueciuoRXPVDuWHijF45ohSjIk5bOmAiujqmHALwhCR7T2ib5lZps/y5dH0o6AlPaHt3cp@vger.kernel.org
X-Gm-Message-State: AOJu0YxJVAMejh7m+rPJHqxDcSEXXCJZ5mlF8hWBK2+8N4kHwXhcpQ58
	xNyYC3Z8KxE/AqA+b55q94TVDTC4PDbZRpevfwSBkSHv93X5/mxY
X-Gm-Gg: ASbGncuiD2LO4om0XdSgU5gkBUpDK6q/6YoVREVtztNV3jkCuBuK5zsa8m1UKVe/mza
	iRedZXZ4U+Tfbwc5NPtJZYLpL5NxrVXoIbeppiToJRH/chsPSv6+0SWV7VeFWe+9GxGY4zhSTF/
	vLr0NLlVPSgg5xsBf+sZ8SCV9BWarg8X7QCEcUg524XkBRikwf/CbwZ8/S1b1sZ/pAcatQzBT6L
	yMDxEt4f5/8Xc7gk7mfWsJ4USf+Pj6BAN9+QvKBP/w91r3iFNxaFHG6OG09oE0YyPeFQmOLDL6t
	BD7WoyXN5XMnpzaf7j0LFw==
X-Google-Smtp-Source: AGHT+IGTZX1caXgox/FS6gjjWk+Y9HI77Uft+ZNVRiPY45h1eXn0pFbaPstf2x2zy2pf6Tod7cKVwQ==
X-Received: by 2002:a05:6512:282b:b0:53d:c2f6:8399 with SMTP id 2adb3069b0e04-53dd39b5533mr3975249e87.53.1732401166140;
        Sat, 23 Nov 2024 14:32:46 -0800 (PST)
Received: from [192.168.68.111] (c83-253-44-175.bredband.tele2.se. [83.253.44.175])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53dd244571dsm1090310e87.46.2024.11.23.14.32.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Nov 2024 14:32:45 -0800 (PST)
Message-ID: <49648605-d800-4859-be49-624bbe60519d@gmail.com>
Date: Sat, 23 Nov 2024 23:32:41 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Jan Kara <jack@suse.cz>, "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
From: Anders Blomdell <anders.blomdell@gmail.com>
Subject: Regression in NFS probably due to very large amounts of readahead
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

When we (re)started one of our servers with 6.11.3-200.fc40.x86_64,
we got terrible performance (lots of nfs: server x.x.x.x not responding).
What triggered this problem was virtual machines with NFS-mounted qcow2 disks
that often triggered large readaheads that generates long streaks of disk I/O
of 150-600 MB/s (4 ordinary HDD's) that filled up the buffer/cache area of the
machine.

A git bisect gave the following suspect:

git bisect start
# status: waiting for both good and bad commits
# bad: [8e24a758d14c0b1cd42ab0aea980a1030eea811f] Linux 6.11.3
git bisect bad 8e24a758d14c0b1cd42ab0aea980a1030eea811f
# status: waiting for good commit(s), bad commit known
# good: [8a886bee7aa574611df83a028ab435aeee071e00] Linux 6.10.11
git bisect good 8a886bee7aa574611df83a028ab435aeee071e00
# good: [0c3836482481200ead7b416ca80c68a29cfdaabd] Linux 6.10
git bisect good 0c3836482481200ead7b416ca80c68a29cfdaabd
# good: [f669aac34c5f76b58e6cad1fef0643e5ae16d413] Merge tag 'trace-v6.11-2' of git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace
git bisect good f669aac34c5f76b58e6cad1fef0643e5ae16d413
# bad: [78eb4ea25cd5fdbdae7eb9fdf87b99195ff67508] sysctl: treewide: constify the ctl_table argument of proc_handlers
git bisect bad 78eb4ea25cd5fdbdae7eb9fdf87b99195ff67508
# good: [acc5965b9ff8a1889f5b51466562896d59c6e1b9] Merge tag 'char-misc-6.11-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc
git bisect good acc5965b9ff8a1889f5b51466562896d59c6e1b9
# good: [8e313211f7d46d42b6aa7601b972fe89dcc4a076] Merge tag 'pinctrl-v6.11-1' of git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl
git bisect good 8e313211f7d46d42b6aa7601b972fe89dcc4a076
# bad: [fbc90c042cd1dc7258ebfebe6d226017e5b5ac8c] Merge tag 'mm-stable-2024-07-21-14-50' of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
git bisect bad fbc90c042cd1dc7258ebfebe6d226017e5b5ac8c
# good: [f416817197e102b9bc6118101c3be652dac01a44] kmsan: support SLAB_POISON
git bisect good f416817197e102b9bc6118101c3be652dac01a44
# bad: [f6a6de245fdb1dfb4307b0a80ce7fa35ba2c35a6] Docs/mm/damon/index: add links to admin-guide doc
git bisect bad f6a6de245fdb1dfb4307b0a80ce7fa35ba2c35a6
# bad: [a0b856b617c585b86a077aae5176c946e1462b7d] mm/ksm: optimize the chain()/chain_prune() interfaces
git bisect bad a0b856b617c585b86a077aae5176c946e1462b7d
# good: [b1a80f4be7691a1ea007e24ebb3c8ca2e4a20f00] kmsan: do not pass NULL pointers as 0
git bisect good b1a80f4be7691a1ea007e24ebb3c8ca2e4a20f00
# bad: [58540f5cde404f512c80fb7b868b12005f0e2747] readahead: simplify gotos in page_cache_sync_ra()
git bisect bad 58540f5cde404f512c80fb7b868b12005f0e2747
# bad: [7c877586da3178974a8a94577b6045a48377ff25] readahead: properly shorten readahead when falling back to do_page_cache_ra()
git bisect bad 7c877586da3178974a8a94577b6045a48377ff25
# good: [ee86814b0562f18255b55c5e6a01a022895994cf] mm/migrate: move NUMA hinting fault folio isolation + checks under PTL
git bisect good ee86814b0562f18255b55c5e6a01a022895994cf
# good: [901a269ff3d59c9ee0e6be35c6044dc4bf2c0fdf] filemap: fix page_cache_next_miss() when no hole found
git bisect good 901a269ff3d59c9ee0e6be35c6044dc4bf2c0fdf
# first bad commit: [7c877586da3178974a8a94577b6045a48377ff25] readahead: properly shorten readahead when falling back to do_page_cache_ra()

I would much appreciate some guidance on how to proceed to track down what goes wrong.

Best regards

Anders Blomdell


