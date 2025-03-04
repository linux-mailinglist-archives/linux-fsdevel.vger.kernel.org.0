Return-Path: <linux-fsdevel+bounces-43152-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E1AA4EC2A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 19:44:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFF6E169D50
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 18:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96C5A251788;
	Tue,  4 Mar 2025 18:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TZhTxO7W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419C424EA85;
	Tue,  4 Mar 2025 18:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741113322; cv=none; b=lwjxRsQcVEXJhMXvlKMZuT0AD3hZ7DJ7dZaYTMrqIME7r8YYBlKmyUr2lR1gepvcrAK/DWMtUVf/ZNfAQaAIBBvm5ZDWMldRwdKll5hg0aA3hqtJS4CmR7WhwY+mheOoE8ySvrBKrBNRiZXlUFqTgnjZCy2UfEr/m6VbD1Rcl0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741113322; c=relaxed/simple;
	bh=bdqLolqLrNOQTG0xL25LOQlvD9pbCT1gykmvKt6j8ik=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aLAwr6vd1olIckfN0t9Op3CdHqNUUo/+rKiLDWgRuR/eb73V+W6qsUk84cg0xAjGOSgMSQzRNzRyAIInC2W5avYC4NtbnwfEpP0OdaRg7uGWjCdB6l5z90MAJV05PkjtffcskGx51C4tm954g5+aB6IkLZjZdb0wUb0MNZgoWik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TZhTxO7W; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5dccaaca646so177740a12.0;
        Tue, 04 Mar 2025 10:35:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741113317; x=1741718117; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z+J95x80BXx1IFj8d9HujegeeTJ5w2Jkd/IoDuq5DfM=;
        b=TZhTxO7Wipwuw5+6lF5hxw2Oe4HcRhEa+gh4tTH7YsxoJ9wDoPP0ctZietwcgpID+Z
         jsAbbdq6QRgK8P5XOMGLO91faybS/espjGMVJnMNe9Fchcy3dctVUxn/vAV5M76UgH2b
         cQ4ZTcAqCmH1jBe0yORDMPjMpmrXDpNj6Fngefqqh5tUDhS0P9c93V9DltHxAIDW7GhG
         024QXJepMsxtWARCG2HLPIpTz2jDPkBpmTQW527Xwa6l9aibQWoRg3/EXKKz+pYCBri0
         gAWRe9SckpJKos7q7U//ovDBD5Uq2MYJjiz65xrGgRTS3dAOmQ16ljiW4CW3QWx50N/3
         krsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741113317; x=1741718117;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z+J95x80BXx1IFj8d9HujegeeTJ5w2Jkd/IoDuq5DfM=;
        b=Asbdle/CK8EM1Rqdu6JdTgnQq/cZDGW6zJZLf0h4j4HWJbcED7JsLal5Gmvi6b8UlH
         fZE1DeU0j9/2iXFjLbXeAN89ZbBMiWdMg3IAz6s7/bKYMbj4XLKypA399sorGyM7S6ge
         0S4THvNukmuPoAsMlh6Wvn1ESVUyDW0fUYWuBva+QrPKRNK/JuN4sH6ljEDH4zYhvvvf
         mt9EnXPPgs60b/8KxgMmrHm5bWbj/jXHJ/7aTArOX1ilpFIV8Gr+6/GQgp0MSGVIVe1+
         lfutKaPTqw32EGGHn6jFTpAcjhc2T7jLZ3FIE6W8LsWVY36JlKpQUyeqO+sur1TBevmj
         Ep9A==
X-Forwarded-Encrypted: i=1; AJvYcCWOSkPnxgMH8Z0D5FtHtnyoUjCiadpRqmkpAEvnIMfRJcxgEez0plA3s+1qKOV6VFcm70sapglVv1+WhtIU@vger.kernel.org, AJvYcCXDmWohKX912s0MJBgtTp5P1Mf9VmsqcHo8x2l7O12NeoMELNNFq55jJzpPcY78ru0oqlfijQHair7m6oCP@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+Zl3iCKzu6/PWE/SlITQ02KhEruHlpw+ixX7Aya2GorZ/VMCO
	J5IMl5TypaosH3gPAj19XiSvVh9HFFfLH8yPvvk4OeOne0c/MjTa
X-Gm-Gg: ASbGncsHrUF94LMdYbO8NRkGtx6hSqn/R18j1Tt2coJHM1e0fvuP5m0zMbFg98ABnNY
	3m7VOP6PKT0ek/9GeWBNnUZqMANVmuulSG80TMgmu7lMFZ0EJ5zY64ZDKOou/t11SRfoVdRcNn9
	5tdKibDDsH8kBwLmmZOZaYDRD1gGV4r5fmXvZG4bJt3vGWtipl/wCX2ntp6v2tJbFdwHTX0+Bmo
	Flb0m5au/ZLYtVm021c6KQ1dxLaOKpH1ymzeymVMy0YgD5t/5CVKacURKsYEYjSvUmAS3n2aizy
	8ylkQN24h8jG2F82Kxl+uTBmFM21BsXBKNU+t5bhwXpqb9gkIaZlL7egcGFs
X-Google-Smtp-Source: AGHT+IE353GjHnf067W0Q1HIOLcONPZR0+KcWOC+XbHXYYPpsuBWbo4eCRqyUsKiRMpEYhT+JdgZsA==
X-Received: by 2002:a05:6402:2742:b0:5dc:eb2:570d with SMTP id 4fb4d7f45d1cf-5e59f0dc9d3mr215888a12.2.1741113317028;
        Tue, 04 Mar 2025 10:35:17 -0800 (PST)
Received: from f.. (cst-prg-71-44.cust.vodafone.cz. [46.135.71.44])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c3bb747csm8691328a12.42.2025.03.04.10.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 10:35:16 -0800 (PST)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org,
	viro@zeniv.linux.org.uk
Cc: jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [RFC PATCH v v2 0/4] avoid the extra atomic on a ref when closing a fd
Date: Tue,  4 Mar 2025 19:35:02 +0100
Message-ID: <20250304183506.498724-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The stock kernel transitioning the file to no refs held penalizes the
caller with an extra atomic to block any increments.

For cases where the file is highly likely to be going away this is
easily avoidable.

In the open+close case the win is very modest because of the following
problems:
- kmem and memcg having terrible performance
- putname using an atomic (I have a wip to whack that)
- open performing an extra ref/unref on the dentry (there are patches to
  do it, including by Al. I mailed about them in [1])
- creds using atomics (I have a wip to whack that)
- apparmor using atomics (ditto, same mechanism)

On top of that I have a WIP patch to dodge some of the work at lookup
itself.

All in all there is several % avoidably lost here.

stats colected during a kernel build with:
bpftrace -e 'kprobe:filp_close,kprobe:fput,kprobe:fput_close* { @[probe] = hist(((struct file *)arg0)->f_ref.refcnt.counter > 0); }'

@[kprobe:filp_close]:
[0]                32195 |@@@@@@@@@@                                          |
[1]               164567 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|

@[kprobe:fput]:
[0]               339240 |@@@@@@                                              |
[1]              2888064 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|

@[kprobe:fput_close]:
[0]              5116767 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
[1]               164544 |@                                                   |

@[kprobe:fput_close_sync]:
[0]              5340660 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
[1]               358943 |@@@                                                 |


0 indicates the last reference, 1 that there is more.

filp_close is largely skewed because of close_on_exec.

vast majority of last fputs are from remove_vma. I think that code wants
to be patched to batch them (as in something like fput_many should be
added -- something for later).

[1] https://lore.kernel.org/linux-fsdevel/20250304165728.491785-1-mjguzik@gmail.com/T/#u

v2:
- patch filp_close
- patch failing open

Mateusz Guzik (4):
  file: add fput and file_ref_put routines optimized for use when
    closing a fd
  fs: use fput_close_sync() in close()
  fs: use fput_close() in filp_close()
  fs: use fput_close() in path_openat()

 fs/file.c                | 75 ++++++++++++++++++++++++++++++----------
 fs/file_table.c          | 72 +++++++++++++++++++++++++++-----------
 fs/namei.c               |  2 +-
 fs/open.c                |  4 +--
 include/linux/file.h     |  2 ++
 include/linux/file_ref.h |  1 +
 6 files changed, 114 insertions(+), 42 deletions(-)

-- 
2.43.0


