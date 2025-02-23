Return-Path: <linux-fsdevel+bounces-42370-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ACDB0A41268
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 00:58:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93C76168F88
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Feb 2025 23:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FBDA2080E1;
	Sun, 23 Feb 2025 23:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=scylladb.com header.i=@scylladb.com header.b="kFiCdBbx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A511519BB
	for <linux-fsdevel@vger.kernel.org>; Sun, 23 Feb 2025 23:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740355075; cv=none; b=gvqEwwaT4BWOVEIcBGfBXkHaZcOVLQrlnzWIZ8XQUQOn5Zbt4qN8ak5+qJoTFnuXdjgahgOzRodyt/ZGQ1xa9RT6DVsH7Jfmcb7KubCEQSLkwuvlr30Ce7CiTglO5xyvEjSQaX6rIR9zOHrxFc/mVTfje/i9dRXihHnRmhQsc1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740355075; c=relaxed/simple;
	bh=7nLZmznjt4Y25tiSorvW7p+/KnVD0t69i2xjc2UpgZo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kqCQO3LHK8FZe1iaCly6+WY7DOePoHSfSMljBmCdOs7alpGf5nDVv57+eee91Yy8gQ1gP9iZ2vJzTvtfwISl62+uc8NBsBToemB2XUfG2bzQfzjtcbOO5/2Fr6cORYU3FKzdfqgRENvZnt40cDZeC5jq8vlmCDZiczc+0z05kN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=scylladb.com; spf=pass smtp.mailfrom=scylladb.com; dkim=pass (2048-bit key) header.d=scylladb.com header.i=@scylladb.com header.b=kFiCdBbx; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=scylladb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scylladb.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-220f048c038so71424575ad.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 23 Feb 2025 15:57:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=scylladb.com; s=google; t=1740355073; x=1740959873; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sE2GEpXJe9EB8mr89rPCKxGhWxzC9G93uMNlCaajPCo=;
        b=kFiCdBbxg5jTIKB24iP8bf2B1LHChl/xrzmeuaQK1abm05yKLqrPAZ7d2xerpbXG15
         AfpkFg5QehNlGv4V2Ojn0uFJnKtloIC31Puz730XVj1tdQXdc595mD6ZAVFEcsgiggn4
         DgxfDuXKLIXsWffnGfkxH1iWTcI0ZjUaP8R+nc47PKUcx3/EZ5zaNPnQDDtYgBUm1ehh
         S4qclwl2aUA7ghnyEdyaEuQEiL/RGSdQm/ijDLYIdgUs8RHLKLG4tQDE7ttjBCpJTBdn
         ek4DaoytnEtp1m84pvj+rbkVhNtnD6l49IcdiiMfR2BAeAhhkwVfazTxpXEb9Ei5Q5dV
         lp2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740355073; x=1740959873;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sE2GEpXJe9EB8mr89rPCKxGhWxzC9G93uMNlCaajPCo=;
        b=LGLDS+2TXga41C8lgJd6NSxr9JUOG7ZUN0Sy8Kste+XS4llx22E1oPEEzMIPvYM97Y
         wLDoiHXqxtawWRd/5pSDSdjFteZa2lwkB/mJBfyxd/xTQkxih6FxodwBsZsB6YLchVTL
         taspkgLQ3RwbkEMUI2k9gjX6WA2wI6toV36VKnhUMkk2TLEdZh1qOpBA2BkkIsPFaor1
         g/KvjrGLX+NNOHo2dzns+STNvCz2M7NUCJbmrsviZLDLAPdZJwcuHMa78lfTiiLQOu2R
         N7At6QJOEoMUsRSy/r59rMTUllLYbe9YpobWjhClbc1UKliW5wgi5VUHunHLOgsi2kQD
         CTMQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8gM9N4t5EocKLYDh8koTOE8IVUsnYSom92O/O6TQL8d1Rwi7HYslaDFo3wUDI/bZw8QiWT2b7IflbSl1h@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn97suFg8zQ8RPwW5JOJBmnAyGU1/2VZNu1gPR7DfdF6wPfDfr
	+56Y5WBLIBlDm9XxJyFbB+STMpRHSngvy2ORyhZS0qIiS/5Kvnc+9xWePT6N2prf3KnD0nAnvLb
	m3lH4N3eZ8tq229LiTNXfISq60DODbp9+fBKl7Obq9nILUY2xA5dz4FE6n+8p1G+/Zu2Cck9fb1
	ZDWuEmcbsLzj9ucL8LbLynSI3BzQjs6L6llHkmRqJLU7WeXU25P8Kl50N4UbE8CcR5mIwrP4024
	o5aO0Fu/qbToYFyjFli2oaa12RsmRnDxVL1yT0FZ5wl9h8T78pVm0ANk625Uhe909F/XL85ExMo
	2hOMnMfdfuUppMBkJYULuXKKi9H1abEfsm43rftdNje4p/5Uwg==
X-Gm-Gg: ASbGnct44zMOeqbTv7eKy1QYJdJwMMc8ssw92i8RmqQmCPGyw8DdehqunngPgul3FCo
	Q6+i0tyMkpOfce+jFEJgfzrM8KRcNrafIP8vvMS8OFqXLBHghsPiBkN4IDcj/HxFr2J+jwYwc6+
	D0J7ZfP30LyZge7LCPNH15yrO9yuzP4YZOqrhL0AABP7xJgqeIxnY7y3nBclAsX0g0yGSRiezv0
	LGqiaxlJA7U6nvdyRYY18GLg5zQ6BAjqBJxtKzIYoiW27hZ9ddL8izvz6DwitMv4YQ0ZxoSa4mQ
	wlrXvFa/1FS2I/TjlaPSODrFAHXbRQ==
X-Google-Smtp-Source: AGHT+IHw7//riiQsuVb5lGlLqWGLYjjfKu88D1cSIxhylJZNIWrjx2825KOCcROlA96N4e6VRrJx6A==
X-Received: by 2002:a05:6a21:6004:b0:1ee:c6bf:7c59 with SMTP id adf61e73a8af0-1eef3cdcb24mr19667494637.23.1740355072878;
        Sun, 23 Feb 2025 15:57:52 -0800 (PST)
Received: from localhost.localdomain ([2a09:bac5:7a2:24be::3a9:14])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ae0950ecb95sm9641091a12.41.2025.02.23.15.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2025 15:57:52 -0800 (PST)
From: "Raphael S. Carvalho" <raphaelsc@scylladb.com>
To: linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Cc: djwong@kernel.org,
	Dave Chinner <david@fromorbit.com>,
	hch@lst.de,
	willy@infradead.org,
	"Raphael S. Carvalho" <raphaelsc@scylladb.com>
Subject: [PATCH] mm: Fix error handling in __filemap_get_folio() with FGP_NOWAIT
Date: Sun, 23 Feb 2025 20:57:19 -0300
Message-ID: <20250223235719.66576-1-raphaelsc@scylladb.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CLOUD-SEC-AV-Sent: true
X-CLOUD-SEC-AV-Info: scylladb,google_mail,monitor
X-Gm-Spam: 0
X-Gm-Phishy: 0
X-CLOUD-SEC-AV-Sent: true
X-CLOUD-SEC-AV-Info: scylla,google_mail,monitor
X-Gm-Spam: 0
X-Gm-Phishy: 0

original report:
https://lore.kernel.org/all/CAKhLTr1UL3ePTpYjXOx2AJfNk8Ku2EdcEfu+CH1sf3Asr=B-Dw@mail.gmail.com/T/

When doing buffered writes with FGP_NOWAIT, under memory pressure, the system
returned ENOMEM despite there was plenty of available memory. The user space
used io_uring interface, which in turn submits I/O with FGP_NOWAIT (the fast
path).

retsnoop pointed to iomap_get_folio:

00:34:16.180612 -> 00:34:16.180651 TID/PID 253786/253721
(reactor-1/combined_tests):

                    entry_SYSCALL_64_after_hwframe+0x76
                    do_syscall_64+0x82
                    __do_sys_io_uring_enter+0x265
                    io_submit_sqes+0x209
                    io_issue_sqe+0x5b
                    io_write+0xdd
                    xfs_file_buffered_write+0x84
                    iomap_file_buffered_write+0x1a6
    32us [-ENOMEM]  iomap_write_begin+0x408
iter=&{.inode=0xffff8c67aa031138,.len=4096,.flags=33,.iomap={.addr=0xffffffffffffffff,.length=4096,.type=1,.flags=3,.bdev=0x…
pos=0 len=4096 foliop=0xffffb32c296b7b80
!    4us [-ENOMEM]  iomap_get_folio
iter=&{.inode=0xffff8c67aa031138,.len=4096,.flags=33,.iomap={.addr=0xffffffffffffffff,.length=4096,.type=1,.flags=3,.bdev=0x…
pos=0 len=4096

This is likely a regression caused by 66dabbb65d67 ("mm: return an ERR_PTR
from __filemap_get_folio"), which performed the following changes:
    --- a/fs/iomap/buffered-io.c
    +++ b/fs/iomap/buffered-io.c
    @@ -468,19 +468,12 @@ EXPORT_SYMBOL_GPL(iomap_is_partially_uptodate);
    struct folio *iomap_get_folio(struct iomap_iter *iter, loff_t pos)
    {
            unsigned fgp = FGP_LOCK | FGP_WRITE | FGP_CREAT | FGP_STABLE | FGP_NOFS;
    -       struct folio *folio;

            if (iter->flags & IOMAP_NOWAIT)
                    fgp |= FGP_NOWAIT;

    -       folio = __filemap_get_folio(iter->inode->i_mapping, pos >> PAGE_SHIFT,
    +       return __filemap_get_folio(iter->inode->i_mapping, pos >> PAGE_SHIFT,
                            fgp, mapping_gfp_mask(iter->inode->i_mapping));
    -       if (folio)
    -               return folio;
    -
    -       if (iter->flags & IOMAP_NOWAIT)
    -               return ERR_PTR(-EAGAIN);
    -       return ERR_PTR(-ENOMEM);
    }

Essentially, that patch is moving error picking decision to
__filemap_get_folio, but it missed proper FGP_NOWAIT handling, so ENOMEM
is being escaped to user space. Had it correctly returned -EAGAIN with NOWAIT,
either io_uring or user space itself would be able to retry the request.
It's not enough to patch io_uring since the iomap interface is the one
responsible for it, and pwritev2(RWF_NOWAIT) and AIO interfaces must return
the proper error too.

The patch was tested with scylladb test suite (its original reproducer), and
the tests all pass now when memory is pressured.

Signed-off-by: Raphael S. Carvalho <raphaelsc@scylladb.com>
---
 mm/filemap.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 804d7365680c..b06bd6eedaf7 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1986,8 +1986,15 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
 
 		if (err == -EEXIST)
 			goto repeat;
-		if (err)
+		if (err) {
+			/*
+			 * Presumably ENOMEM, either from when allocating or
+			 * adding folio (this one for xarray node)
+			 */
+			if (fgp_flags & FGP_NOWAIT)
+				err = -EAGAIN;
 			return ERR_PTR(err);
+		}
 		/*
 		 * filemap_add_folio locks the page, and for mmap
 		 * we expect an unlocked page.
-- 
2.48.1


