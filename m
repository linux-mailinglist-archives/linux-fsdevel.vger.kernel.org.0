Return-Path: <linux-fsdevel+bounces-35312-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 251E69D396F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 12:23:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87E02B27EA8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 11:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B6E319F40B;
	Wed, 20 Nov 2024 11:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XsrvA50q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E996719D89E;
	Wed, 20 Nov 2024 11:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732101648; cv=none; b=Cqum4NCw+kmD/MxCV1MufOsitthKqabClIwFcKxAzZk4Wsy6r4s7ktmXo2DsmoWlPRVHEi8lUNKjqtGMnlmGo0SyXAOaw90HM2pDJWEDfvhnqOL9x1fC9TZKRfdY7U+1dkTbJuOK02OQtqSzBf++FzrZxNcdc63qUfe38INbLxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732101648; c=relaxed/simple;
	bh=Ovv2AE6JnxiYf/AkqY/0pRDpFrK0OSb9PlwyaTGoC3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=llqy2fq7EEGeGp1xwoKqlJLi6PqlU6c16t5KsKjzNm+5it7vMZRXjK2BMXGdOADcdSLViTk2WejS8PVH4mZvw7CTnlAtkMRMiDhMzMxEehLApeVCiJqHBqUTdODjyEvZcukOo7bragrZqDGg1kF/0zutLyzKN57Z4BJab6cEtcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XsrvA50q; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aa1f73966a5so840972966b.2;
        Wed, 20 Nov 2024 03:20:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732101645; x=1732706445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FYRyH5MT4xu/Wg26DSYNU5aXupUqtlQUxs1/p8n5l1U=;
        b=XsrvA50q5D8hRw/X4pHERzILfB2iLpNwfmAyqDJNauplmXfLaPjSEPd9Ot5pWiV0F5
         VBHIUsMf00I6nof+UJe6z47Qh56HRprChULPHscX65KbnZoTyUH5pDuvfXa+ziaVlmes
         pwxgJaqWiKZ1mQ7Zlx7v5TRxe+manJnKS+YLGUNgUuU52R1B7310jX003iWnhkxMtQ3S
         Hn+Xzg9cRAU+U+w9wMqKytTm7kx7i+swZr2R751+NmYR3z/jjEW0fSVDh2fUnfj2FHSI
         zHruoSpf7fLOjoqfzR5+WvrT+/49d8/zRha7iLpqX2xW2Ur3cPYR2l4QoEnwPC54433K
         pU8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732101645; x=1732706445;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FYRyH5MT4xu/Wg26DSYNU5aXupUqtlQUxs1/p8n5l1U=;
        b=Lw0v+avqI2K/SWM3Skap9cB6Va/ZURK2bdWso0uKR3InLvxyYo5fOcjQ72GGrH73aU
         IJP6Lld4GzpiyzIl9sBaiPKQUVzj9ZpoMQBD4InDYhZPuZDphXdBIX1T/drv1KQXqOVy
         iNWXZ8LIuSWDxhlM+Xc66RFsa/2izt4wq0LzS9p9YXHD2Ym43JP27ntX13N3poDIAZJb
         QTN+9vJda70Cn6hHGmGHPxMR0Fir6MpopyVLXHNOZ4UvwwDIUesezV0dKs0LuyDiPYwS
         5q7YpWRscfeA7pMTVUKfthF6WaYWFSvpSfPwYBGaPDzKo0mW/Wlgd6RusJsDEPxM6l6B
         1Iug==
X-Forwarded-Encrypted: i=1; AJvYcCVuDPdF7FibvJ2AOQonDsymmbSzeyoF766DyXb4IV7PlWOpfHrlnQYunMazQ5PDNyfbA+dSWgu3/ngX@vger.kernel.org, AJvYcCX+hY4aLWXMQUnGZF+jsN8NhnAXWUlULfkVUglfuINi8/ynzLsRd9XBEW4Qm8FEvTAotfQ72mdTT+Dxjsca3Q==@vger.kernel.org, AJvYcCXYePbkC9ZNXkpyLU5XWbxSkVqoTtClD2SlR7hhVKVNx6F/dd+ty/KwrHZRi5cRZ7xP2Q2rGejdXbWsIAAN@vger.kernel.org
X-Gm-Message-State: AOJu0YwCvl++jigv6Z6mrOsJxgfrIsDg4sUv95RvgAjC22ml5de/yebk
	70qo8CCdmcIpwB9ZnLAITROPAl6Sleb8o/GkAEHOGr07koCns58N
X-Google-Smtp-Source: AGHT+IH+iUZ6CBxj/W2mkhYIPGH2AjoPmpb+wYYabsGQvnI969biIAPnC64kWETIGK4aBBpvLPzzDw==
X-Received: by 2002:a17:907:2d08:b0:a87:31c:c6c4 with SMTP id a640c23a62f3a-aa4dd56adebmr216895866b.24.1732101644892;
        Wed, 20 Nov 2024 03:20:44 -0800 (PST)
Received: from f.. (cst-prg-93-87.cust.vodafone.cz. [46.135.93.87])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20df5690csm758559566b.75.2024.11.20.03.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 03:20:44 -0800 (PST)
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
Subject: [PATCH v3 0/3] symlink length caching
Date: Wed, 20 Nov 2024 12:20:33 +0100
Message-ID: <20241120112037.822078-1-mjguzik@gmail.com>
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

The size is stored in a union with i_devices, which is never looked at
unless the inode is for a device.

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

v3:
- use a union instead of a dedicated field, used up with i_devices

v2:
- add a dedicated field, flag and a helper instead of using i_size
https://lore.kernel.org/linux-fsdevel/20241119094555.660666-1-mjguzik@gmail.com/

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
 include/linux/fs.h             | 15 +++++++++++++--
 mm/shmem.c                     |  6 ++++--
 security/apparmor/apparmorfs.c |  2 +-
 7 files changed, 43 insertions(+), 23 deletions(-)

-- 
2.43.0


