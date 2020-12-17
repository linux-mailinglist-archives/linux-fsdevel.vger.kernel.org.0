Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B10CD2DD50A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Dec 2020 17:20:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728127AbgLQQT5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Dec 2020 11:19:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728109AbgLQQT5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Dec 2020 11:19:57 -0500
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 020CEC061794
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Dec 2020 08:19:17 -0800 (PST)
Received: by mail-il1-x135.google.com with SMTP id p5so26326916iln.8
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Dec 2020 08:19:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3c5SMF0zYxqErtpvh8FlH8ydKXXNNubW5X+nlQlmPOI=;
        b=aPap6Sg9frPxwaW2CDuf1o40kUThwidW6Kw5SAcV9fwNuB1bdjvnSPP6l5SCx2m+WR
         9s7Klp+zIGww85tBzGCdbYzIM7RY2tzG5e3NI+FcZeg7K3T7IzYWWe8ogApp+OmT9OVt
         Vy2cyiRprsn+peczc48dCdwYvLxLN+QuxSLasDuRoiY0NnYF3fbKLPZjyShGwHKKgJJa
         O/Io3pyMrGJKH2yXAuOlQKNBoJ33BjxgZ4LAhD54G+bxlzamXoxseAe7281DW3DaMjUF
         IvzB2ysnaY5AktH9KratVAU54ZL2uax/5M0++iSpfjG/nunm9FXUWqfA+ZnTvoKiKvKx
         K6BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3c5SMF0zYxqErtpvh8FlH8ydKXXNNubW5X+nlQlmPOI=;
        b=gyfrxQzneVqnmQQEY/soOKYO+nGmJuJxvAaPAZ/S62fYUp9L7S7QehAIqRaq3quMFV
         8/gOyL5eVyjQXAQQ+UC9ZFZYWjUfSU21sAa1ET8o3N914Ue4jPaPiSZjbxCedU0NWug5
         c4pbB606C/6tLPhP+AJ4JfVutzoUl0/KGKp/UUE2uHE8RAfnUr+1poGQV0HreuWatKSC
         N7YFus4VsgKxHwDRt14PAyZJII1vo9B4jwPKC+0yX8fTbmmd1i483T4M+E+8I9VM0/TL
         /cAW1HX/dY5Qv1NiIP9zViIT3On+mR7a7tMw4KjcrhCPQiPZApyPnMANdSfctU79mgTJ
         2OIQ==
X-Gm-Message-State: AOAM531kdKBhhO5j0mlo+UjtXdZxcAMvEo+6k7lANfPrdvsB4DRx/q7b
        NlPQ9T2xTwwiDl03/rIGEaKT8N8FrTWj+g==
X-Google-Smtp-Source: ABdhPJzr/4lHGz1kIZoO4e7W/cADj0qVNn5r0gsR62h3UuPtq70FPP8M+z7kfzKSY8Dtngf7ZCBG8A==
X-Received: by 2002:a92:dc4a:: with SMTP id x10mr31075996ilq.153.1608221955797;
        Thu, 17 Dec 2020 08:19:15 -0800 (PST)
Received: from p1.localdomain ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id k76sm3849957ilk.36.2020.12.17.08.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Dec 2020 08:19:15 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, viro@zeniv.linux.org.uk
Subject: [PATCHSET 0/4] fs: Support for LOOKUP_CACHED / RESOLVE_CACHED
Date:   Thu, 17 Dec 2020 09:19:07 -0700
Message-Id: <20201217161911.743222-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

Here's v3 of the LOOKUP_CACHED change. It's exposed as both a flag for
openat2(), and it's used internally by io_uring to speed up (and make more
efficient) the openat/openat2 support there. As posted in the v3 thread,
performance numbers for various levels of the filename lookup already
being cached:

Cached		5.10-git	5.10-git+LOOKUP_CACHED	Speedup
---------------------------------------------------------------
33%		1,014,975	900,474			1.1x
89%		 545,466	292,937			1.9x
100%		 435,636	151,475			2.9x

The more cache hot we are, the faster the inline LOOKUP_CACHED
optimization helps. This is unsurprising and expected, as a thread
offload becomes a more dominant part of the total overhead. If we look
at io_uring tracing, doing an IORING_OP_OPENAT on a file that isn't in
the dentry cache will yield:

275.550481: io_uring_create: ring 00000000ddda6278, fd 3 sq size 8, cq size 16, flags 0
275.550491: io_uring_submit_sqe: ring 00000000ddda6278, op 18, data 0x0, non block 1, sq_thread 0
275.550498: io_uring_queue_async_work: ring 00000000ddda6278, request 00000000c0267d17, flags 69760, normal queue, work 000000003d683991
275.550502: io_uring_cqring_wait: ring 00000000ddda6278, min_events 1
275.550556: io_uring_complete: ring 00000000ddda6278, user_data 0x0, result 4

which shows a failed nonblock lookup, then punt to worker, and then we
complete with fd == 4. This takes 65 usec in total. Re-running the same
test case again:

281.253956: io_uring_create: ring 0000000008207252, fd 3 sq size 8, cq size 16, flags 0
281.253967: io_uring_submit_sqe: ring 0000000008207252, op 18, data 0x0, non block 1, sq_thread 0
281.253973: io_uring_complete: ring 0000000008207252, user_data 0x0, result 4

shows the same request completing inline, also returning fd == 4. This
takes 6 usec.

Using openat2, we see that an attempted RESOLVE_CACHED open of an uncached
file will fail with -EAGAIN, and a subsequent attempt will too as it's
still not cached. ls the file and retry, and we successfully open it
with RESOLVE_CACHED:

[test@archlinux ~]$ ./openat2-cached /etc/nanorc
open: -1
openat2: Resource temporarily unavailable
[test@archlinux ~]$ ./openat2-cached /etc/nanorc
open: -1
openat2: Resource temporarily unavailable
[test@archlinux ~]$ ls -al /etc/nanorc
-rw-r--r-- 1 root root 10066 Dec 17 16:15 /etc/nanorc
[test@archlinux ~]$ ./openat2-cached /etc/nanorc
open: 3

Minor polish since v3:

- Rename LOOKUP_NONBLOCK -> LOOKUP_CACHED, and ditto for the RESOLVE_
  flag. This better explains what the feature does, making it more self
  explanatory in terms of both code readability and for the user visible
  part.

- Remove dead LOOKUP_NONBLOCK check after we've dropped LOOKUP_RCU
  already, spotted by Al.

- Add O_TMPFILE to the checks upfront, so we can drop the checking in
  do_tmpfile().

-- 
Jens Axboe



