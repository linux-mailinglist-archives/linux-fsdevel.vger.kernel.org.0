Return-Path: <linux-fsdevel+bounces-29984-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33A8E9849B6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2024 18:34:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64D7E1C22FBC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2024 16:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FDCC1AC427;
	Tue, 24 Sep 2024 16:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CJaNTrDF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87331ABEAF;
	Tue, 24 Sep 2024 16:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727195670; cv=none; b=p5zR+CWn4f8t++ShtGZnRMG92KU/Ns8rPqT6xq47N3J9XX/Oe8SfDN0Vfn85jN0AXbFxPvMBo81WZZfENUu4szND2xls6i+E3Ke9ZpGEGG/sjT/yb25kwsS/QhVeIgZ1S4CEx3vIlYFbWgOZQziPtLikA1ZDY2iDWqdx/xu466Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727195670; c=relaxed/simple;
	bh=CKQYHaO7SFJI1SmPcWqAwBv8/BcIfWAEOxizwPvzJh0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ptsOyv8sNT3okzOzmBHztbZzWolIIGLHPe9Mhx1jla9y7k7zg4PQ7XZJBNgfn2kIVFAomBDRpfR2t5y1EnivtDifKRpUWy1zKOlm3vw+pZvVUM9GoKTMPavW30V5p0n8LOvCGujaB2aBXEP/DU5iHfm7c6ggdYLbb4BRhvSC66o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CJaNTrDF; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2f74b6e1810so47673471fa.2;
        Tue, 24 Sep 2024 09:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727195667; x=1727800467; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SohsbHCOgCyY9zRN0YDEWi0hquGgftBulLmPBuTfvhQ=;
        b=CJaNTrDF6z7Qu30bNRbYBcyXo5I5U9JGzQMijUqcj1FI5YeJT1FSZlOm19iDFJp1FX
         SZGRnfOJK+b+5hUWNHXJARcIE0amAi1k2QJ36KZYJuGwPR1KdIZKdqQTgdTzsXxefnI0
         SAINtTcGfHJovPl68efb2Nc4KZNKeGlnCEa4rmag9Z7bDRFmsy1PIpOhz7QGcN5/1kld
         1xfm9XdD6mRL+tLotpDVs1UKybLIFefsT0TSt+leEVmDNhaabkr54/HBGBouhpFLXBLy
         kJzG5r1u3lm3UM8ECwtrUEMqGbmEcwKH1WLsmHHSAzPS43+HPsIMYbtap45v4j8tDh2k
         sTbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727195667; x=1727800467;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SohsbHCOgCyY9zRN0YDEWi0hquGgftBulLmPBuTfvhQ=;
        b=a685BzpFzKlOxaiQqy7DRPh17RuTwz6Z1YndgAFn+jHdT/8Lq5vH5kCIGS1+zsGfOC
         8aDCEU6Eau1zziFqkbOlA+hOFIdx7+o7dIK04ns0kgoDPVUP6qbXIWrUWu6IS8dQuxXW
         5U1KO7F4nehDvcF2ufau/+QKnuIQy1EITRasjuyPwgs1IqCu6+mc+2r493hCPF4kXe5t
         kUcJrSj19zKssDu+FDD0+LwQVS39lhP/pcC+jWALwNyQkIM9fgoY4AxpDv6+y9DqQ52Q
         olMITZkJ+PgdlP/U5Zv/xNRfpTHyp/kEptKt/etlVbNR10bhdUsdBTBBlHKiTtg96QJd
         j00g==
X-Forwarded-Encrypted: i=1; AJvYcCULOC74jMFOCPTxZcPb4E4OPy9MzEI5wHxHE4De9lfZ5tQ9JVxsbZ6Q0V7GI83OLcAhVv4=@vger.kernel.org, AJvYcCV91G1rcQB+h/fzv+BBqwdv8zAuYroEkBJ5zy/lxvJEH7KNysW5YrvT2NhQhxP8Jy45oBxDliKZgAdK/UwrIA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxIjpEtHiyFDa2Hvlsk+VIurul81UxBqY0PRL7DVW+krY9U1Hoa
	HKkXJOC9DjG1BV9eO1I+6HkDchQcPY4vwieCwwJ6QAXJbNMwewM8
X-Google-Smtp-Source: AGHT+IGBXVJqK6H3iIWJYI6elOBG0YMyK86L4AC8vXtjYyAZyzXeR2mZuA/kfKXulqZnbV0IeDnNeQ==
X-Received: by 2002:a05:651c:1548:b0:2f7:acf5:7ddc with SMTP id 38308e7fff4ca-2f7cb324136mr69918591fa.26.1727195666517;
        Tue, 24 Sep 2024 09:34:26 -0700 (PDT)
Received: from ast-mac.fritz.box (046075014122.atmpu0009.highway.a1.net. [46.75.14.122])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c5cf4977d7sm923788a12.40.2024.09.24.09.34.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 24 Sep 2024 09:34:25 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: torvalds@linux-foundation.org
Cc: viro@zeniv.linux.org.uk,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	linux-fsdevel@vger.kernel.org,
	brauner@kernel.org,
	martin.lau@kernel.org
Subject: [GIT PULL] BPF struct_fd changes for 6.12
Date: Tue, 24 Sep 2024 18:34:23 +0200
Message-Id: <20240924163423.76635-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

The following changes since commit de12c3391bce10504c0e7bd767516c74110cfce1:

  add struct fd constructors, get rid of __to_fd() (2024-08-12 22:01:15 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git tags/bpf-next-6.12-struct-fd

for you to fetch changes up to 37d3dd663f7485bf3e444f40abee3c68f53158cb:

  bpf: convert bpf_token_create() to CLASS(fd, ...) (2024-09-12 18:58:02 -0700)

----------------------------------------------------------------
Since Al's first 3 patches for struct_fd landed in
https://lore.kernel.org/all/20240923034731.GF3413968@ZenIV/

This pull includes struct_fd BPF changes from Al and Andrii.

Note the pull includes Andrii's merge commit for Al's
vfs/stable-struct_fd branch with 3 already landed patches
that Andrii applied back in August when Al created
the stable branch. These 8 patches were developed on top.

The last minute rebases are frown upon, so we didn't rebase
and I don't see a way in git to avoid this extra commit.

fwiw the rebased commits are in bpf-next/struct_fd_latest
branch in unlikely case you prefer that.

The following diff stat is concatenated from two 'git request-pull'
commands, since I couldn't make it to generate both patch list
and diff stat correctly. Either patch list was ok or diff stat.
I hope that's ok, since doing
'git pull bpf-next.git tags/bpf-next-6.12-struct-fd'
gives me exactly this result.

There should be no conflicts.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
----------------------------------------------------------------
Al Viro (6):
      bpf: convert __bpf_prog_get() to CLASS(fd, ...)
      bpf: switch fdget_raw() uses to CLASS(fd_raw, ...)
      bpf: switch maps to CLASS(fd, ...)
      bpf: trivial conversions for fdget()
      bpf: more trivial fdget() conversions
      bpf: convert bpf_token_create() to CLASS(fd, ...)

Andrii Nakryiko (3):
      Merge remote-tracking branch 'vfs/stable-struct_fd'
      bpf: factor out fetching bpf_map from FD and adding it to used_maps list
      security,bpf: constify struct path in bpf_token_create() LSM hook

 include/linux/bpf.h            |  11 ++-
 include/linux/lsm_hook_defs.h  |   2 +-
 include/linux/security.h       |   4 +-
 kernel/bpf/bpf_inode_storage.c |  24 ++----
 kernel/bpf/btf.c               |  11 +--
 kernel/bpf/map_in_map.c        |  38 +++------
 kernel/bpf/syscall.c           | 181 +++++++++++------------------------------
 kernel/bpf/token.c             |  74 ++++++-----------
 kernel/bpf/verifier.c          | 110 ++++++++++++++-----------
 net/core/sock_map.c            |  23 ++----
 security/security.c            |   2 +-
 security/selinux/hooks.c       |   2 +-
 12 files changed, 179 insertions(+), 303 deletions(-)

