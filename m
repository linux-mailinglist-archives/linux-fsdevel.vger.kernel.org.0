Return-Path: <linux-fsdevel+bounces-5706-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0380680F05A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 16:26:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34A6C1C20C79
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 15:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B50076DAD;
	Tue, 12 Dec 2023 15:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="kTiAXFhk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DE4C111
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Dec 2023 07:25:59 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-a1e2f34467aso542558866b.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Dec 2023 07:25:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1702394758; x=1702999558; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4YOmXjtg+QYQBxHin0XEuIjM6hmU4vypdWtWff89pKM=;
        b=kTiAXFhk8YYfBF/HFNdhcEdoas4IzBswWaUcnN1HmUym58HjLtkM+GL4Vx0z8JKl0Y
         G0aPsbtZULKzImVwXuUnhKMXjrwhPMtYJPE+78+rUXjvW3r88a+uZnQl7YIzQO9Sdi6L
         pLGWGQDDjTLiIsnUZhNPH31UR1tmelbGLdHJA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702394758; x=1702999558;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4YOmXjtg+QYQBxHin0XEuIjM6hmU4vypdWtWff89pKM=;
        b=fSamrRGuTVZh0IpYV/z46dA2PV8RxYtn0vr/9Kmh6S3DcROMsgRBZq+oHn1W3sbmHb
         TVEp7/i5vcvXmrlAd78sHjlzCZdY2CntuhK+gMwaAyniPnvx4P0hzjC3bubjTL4bK9DC
         D/q//OpQZFMSdnzT39Z48vvCtGSHXbF1siQ6x1kxESt3TOtvLChLj4FA1D5aXPp746oq
         24mWk1apTEb1xoNOwTD4vZuWI06lT9RE9hq47SROlehRE9yRrP2Q1UfFhlyjqfznRi+k
         bnXwTnNXj7h6qE0lxuAq1C5MyO5qo73BmaNBKqTbiqERqwT8F/OwbFyQkvc5O4skUqsi
         T64w==
X-Gm-Message-State: AOJu0YzzclzJs9wccI0vv7g2UVg2CWa9nPV6uPQJPi/XkE0NOlP5FVQ7
	q/eehlZZoFQ3j+drq4cTlQkrLJCkmG92XOiUTszYG3bXLdImNRVStWU=
X-Google-Smtp-Source: AGHT+IF5sjc1HAoOLU2FF2xH9fnOYW204DNorurP5oUNffj+6I9JQIztVYTl+Vgw2FfqUmhaGwIJVpkjIzo7Uq4KxHc=
X-Received: by 2002:a17:907:a0c6:b0:a17:ab92:3d55 with SMTP id
 hw6-20020a170907a0c600b00a17ab923d55mr4045465ejc.19.1702394757949; Tue, 12
 Dec 2023 07:25:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 12 Dec 2023 16:25:46 +0100
Message-ID: <CAJfpeguzG6EGi2FXspV-sQDrFkyf5umF6jHg3G=9XpWN95Bsug@mail.gmail.com>
Subject: [GIT PULL] fuse fixes for 6.7-rc6
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git
tags/fuse-fixes-6.7-rc6

 - Fix a couple of potential crashes, one introduced in 6.6 and one in 5.10

 - Fix misbehavior of virtiofs submounts on memory pressure

 - Clarify naming in the uAPI for a recent feature

Thanks,
Miklos

----------------------------------------------------------------
Amir Goldstein (1):
      fuse: disable FOPEN_PARALLEL_DIRECT_WRITES with FUSE_DIRECT_IO_ALLOW_MMAP

Hangyu Hua (1):
      fuse: dax: set fc->dax to NULL in fuse_dax_conn_free()

Krister Johansen (1):
      fuse: share lookup state between submount and its parent

Tyler Fanelli (2):
      fuse: Rename DIRECT_IO_RELAX to DIRECT_IO_ALLOW_MMAP
      docs/fuse-io: Document the usage of DIRECT_IO_ALLOW_MMAP

---
 Documentation/filesystems/fuse-io.rst |  3 +-
 fs/fuse/dax.c                         |  1 +
 fs/fuse/file.c                        |  8 ++--
 fs/fuse/fuse_i.h                      | 19 +++++++-
 fs/fuse/inode.c                       | 81 ++++++++++++++++++++++++++++++++---
 include/uapi/linux/fuse.h             | 10 +++--
 6 files changed, 106 insertions(+), 16 deletions(-)

