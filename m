Return-Path: <linux-fsdevel+bounces-35182-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC46A9D22AD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Nov 2024 10:46:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C8C5B23FD9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Nov 2024 09:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 838C31B86DC;
	Tue, 19 Nov 2024 09:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jcur4WEY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3341CA84;
	Tue, 19 Nov 2024 09:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732009572; cv=none; b=AM6YcJfKLsftnOAfd1Ne9x1FdbvCUEyq40FhDdYmUZ4XunFtga4X8HpGGWlhq3JaoO/amRTwoSVttDjuY/wTY4LYNOtrsrMggwWdsTEvtYVF7qZF/sb9Htpj4Qy+x6wYqRJAE+tPhLXWXExk8VKd5cVGfvZNOBGb67YxDdx2VNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732009572; c=relaxed/simple;
	bh=rVAnp/3RCoFRMM2o0GfhVYhfQcMFY3DxaZ1Nd4zwmaA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TtRylomNz3ux6f7vFMOqjxlprUOfKp56dA8Lb+2xRgg01y2jFieISBTRL/EBPf5U/dkWCk7M93QR1+CyPFSZ2YsVcKfO87o2R8NJPb6+vlpSvIg2iqPuJkzThGwNOC5eiT9jq0AfBxQ8+acUvaMdKQCzEMpk1NagRMpo2uddxlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jcur4WEY; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5c96b2a10e1so1144311a12.2;
        Tue, 19 Nov 2024 01:46:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732009568; x=1732614368; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+Hc3aUwdelvLacRTbdSCz+CvcimyCx26wmG+apt6ADc=;
        b=jcur4WEYv40UWWyR85L9pwVRYE9YEpFWoJOUdVE8LdAIW60WoICCkeDLe/kuufyyeG
         01XPQQP+O3Uoe8bkQZD/6ZQGl87rb0m41vq4n7P8/KTrK//52yQn15d++5FjZiy7NQg+
         Iy71aCMkq+NffJgCDlCtKY9nJdsDiFghQ3dUnFKkS/zjQoblXuzgz3bl4ojXHLN+ROOa
         Htb6BqMphLrZEmdIlSo3HhtaXfpeNrYlPQUebYZmvcC7F8FWiKSRc8Nq5GgV6IngeJc6
         uw+EQzPBUz3HYa943QXifc8RVITQuYx5atSBhPOSDjSrHTDWWMIKbk27DZzsoUD8xEcM
         auLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732009568; x=1732614368;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+Hc3aUwdelvLacRTbdSCz+CvcimyCx26wmG+apt6ADc=;
        b=GpzVsxFldwSBfiAonlYWDwyiEGYafhKQcXka7RCYP97LwOeLwePgQu2yxCEkXMkcf1
         XkPomKpV+hQfYXqb8Ie02Nzuk8MdMq2g5cK9B4FPJvVHdElTpqT32hArcjPRzVRDM2Js
         +NCtNArXtCqj58cvIS6FZ2vqjLTGtZFle6eZt+Jknud9C4tBpd4g4gIgb73FylN7OhHg
         CaB+cuyxiHI0rjzHAYcuK96/P5dANHRsPMxAVdVamgR3iMdEMapsDeIPBfwNkKrv2Qu1
         wSaFbib4zyh9WJzAhMZc2+IT0uPnEhW0rgJNmusftj7l2ra2dxguyIaIJh1UX/lOJMfm
         pH2w==
X-Forwarded-Encrypted: i=1; AJvYcCVN+Jd/ttnvvKJFzU+fbYl0hZ9pf2IpZ/sH0B2NbC2BL9LcJk9Wakb1qyQLV6l+Qn3VEtn96138kztTEQr8@vger.kernel.org, AJvYcCVzFz9CS2twIPAXkQXuau3rfjsRZGQAl2p3ACNwNFDFUNwKR3jZ7zaAniTbUywSzMzExCo5s3CqOZhQWF4Jbw==@vger.kernel.org, AJvYcCWqvajKuT/USNTHvc6a2yDwENb17FOxTDMXAsFCwU/ONxR6KkkP9xM8SaRNi3NCRqEnswmGOs/haBCO@vger.kernel.org
X-Gm-Message-State: AOJu0YyTxAyaZMd/JeFBHmeQRqRCwI2X0EO7fx8oYwAmiWTlP7yCC8Kj
	Z6POn3C96jTjQkL2tRsixs7BS20rllT5WH4qToA8eXMFG2+S+Xnb
X-Google-Smtp-Source: AGHT+IHqrKS0bZ4q6aqBkVlhpgYvXu06WffntfdniQvb1WE0B0SGLHtxSu2F+xMgqGgglqraP1bEUg==
X-Received: by 2002:a05:6402:1e94:b0:5ce:af48:c2cc with SMTP id 4fb4d7f45d1cf-5cf8fcdfb82mr12600726a12.27.1732009568023;
        Tue, 19 Nov 2024 01:46:08 -0800 (PST)
Received: from f.. (cst-prg-93-87.cust.vodafone.cz. [46.135.93.87])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cfcb3edce9sm1821154a12.35.2024.11.19.01.46.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 01:46:06 -0800 (PST)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	hughd@google.com,
	linux-ext4@vger.kernel.org,
	tytso@mit.edu,
	linux-mm@kvack.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v2 0/3] symlink length caching
Date: Tue, 19 Nov 2024 10:45:52 +0100
Message-ID: <20241119094555.660666-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

quote:
    When utilized it dodges strlen() in vfs_readlink(), giving about 1.5%
    speed up when issuing readlink on /initrd.img on ext4.

Benchmark code at the bottom.

ext4 and tmpfs are patched, other filesystems can also get there with
some more work.

Arguably the current get_link API should be patched to let the fs return
the size, but that's not a churn I'm interested into diving in.

On my v1 Jan remarked 1.5% is not a particularly high win questioning
whether doing this makes sense. I noted the value is only this small
because of other slowdowns.

To elaborate here are highlights while benching on Sapphire Rapids:
1. putname using atomics (over 3.5% on my profile)

sounds like Al has plans to do something here(?), I'm not touching it if
it can be helped. the atomic definitely does not have to be there in the
common case.

2. kmem_cache_alloc_noprof/kmem_cache_free (over 7% combined) 

They are both dog slow due to cmpxchg16b. A patchset was posted which
adds a different allocation/free fast path which should whack majority
of the problem, see: https://lore.kernel.org/linux-mm/20241112-slub-percpu-caches-v1-0-ddc0bdc27e05@suse.cz/

If this lands I'll definitely try to make the pathname allocs use it,
should drop about 5-6 percentage points on this sucker.

3. __legitimize_mnt issues a full fence (again over 3%)

As far as avoiding the fence is concerned waiting on rcu grace period on
unmount should do the trick. However, I found there is a bunch
complexity there to sort out before doing this will be feasible (notably
there are multiple mounts freed in one go, this needs to be batched).
There may be other issues which I missed and which make this not worth
it, but the fence is definitely avoidable in principle and I would be
surprised if there was no way to sensibly get there. No ETA, for now I'm
just pointing this out.

There is also the idea to speculatively elide lockref, but when I tried
that last time I ran into significant LSM-related trouble.

All that aside there is also quite a bit of branching and func calling
which does not need to be there (example: make vfsuid/vfsgid, could be
combined into one routine etc.).

Ultimately there is single-threaded perf left on the table in various
spots.

v2:
- add a dedicated field, flag and a helper instead of using i_size
- constify i_link

v1 can be found here:
https://lore.kernel.org/linux-fsdevel/20241118085357.494178-1-mjguzik@gmail.com/

benchmark:
plug into will-it-scale into tests/readlink1.c:

#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <assert.h>
#include <string.h>

char *testcase_description = "readlink /initrd.img";

void testcase(unsigned long long *iterations, unsigned long nr)
{
        char *tmplink = "/initrd.img";
        char buf[1024];

        while (1) {
                int error = readlink(tmplink, buf, sizeof(buf));
                assert(error > 0);

                (*iterations)++;
        }
}


Mateusz Guzik (3):
  vfs: support caching symlink lengths in inodes
  ext4: use inode_set_cached_link()
  tmpfs: use inode_set_cached_link()

 fs/ext4/inode.c                |  3 ++-
 fs/ext4/namei.c                |  4 +++-
 fs/namei.c                     | 34 +++++++++++++++++++---------------
 fs/proc/namespaces.c           |  2 +-
 include/linux/fs.h             | 12 ++++++++++--
 mm/shmem.c                     |  6 ++++--
 security/apparmor/apparmorfs.c |  2 +-
 7 files changed, 40 insertions(+), 23 deletions(-)

-- 
2.43.0


