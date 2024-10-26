Return-Path: <linux-fsdevel+bounces-33015-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99F079B168F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Oct 2024 11:36:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4537F1F225E5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Oct 2024 09:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C3AD1D095C;
	Sat, 26 Oct 2024 09:36:26 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA73913B294;
	Sat, 26 Oct 2024 09:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.189.157.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729935385; cv=none; b=q3em2m3Gh43G3JCN62PubzevuAfuERrOXMyneLDp25tD/LEBdzv5YhXOXqrr+POIvN2TgTA+fmKuvSvXGdfz8YeKsg7fsZzQ0sfqnpGwms4NIPkxl2WT+msWkambVFo5kGTUuBcJtQV4xgTb93GH5Q00Jr7KVDMoxDOHPZlwfIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729935385; c=relaxed/simple;
	bh=dcVjBam2fHs2lKOgcenKcOJLmrq3Cvq3zkWUfikon2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hex2aelnTD6C2ig+CN+28vgoZyUAh7E5kZPBAdurtrFuStxQn1YktgUuSzcrpbiJ37dCKTfPUf+bu29C3VjiEF/D+4EeMRlXMH7XScAMZD7qga9qHm+zzBE4Mv74I3Uxa9x1ee04yD1SFuJ5AzJpTk9zC2BlxMyphTBIeJzsunQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com; spf=pass smtp.mailfrom=crudebyte.com; arc=none smtp.client-ip=5.189.157.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crudebyte.com
From: Christian Schoenebeck <linux_oss@crudebyte.com>
To: Guan Xin <guanx.bac@gmail.com>,
 Dominique Martinet <asmadeus@codewreck.org>
Cc: v9fs@lists.linux.dev,
 Linux Kernel Network Developers <netdev@vger.kernel.org>,
 linux-fsdevel@vger.kernel.org, Eric Van Hensbergen <ericvh@kernel.org>
Subject:
 Re: Calculate VIRTQUEUE_NUM in "net/9p/trans_virtio.c" from stack size
Date: Sat, 26 Oct 2024 11:36:13 +0200
Message-ID: <1921500.ue69UQ14vC@silver>
In-Reply-To: <ZxwTOB5ENi66C_kq@codewreck.org>
References:
 <CANeMGR6CBxC8HtqbGamgpLGM+M1Ndng_WJ-RxFXXJnc9O3cVwQ@mail.gmail.com>
 <ZxwTOB5ENi66C_kq@codewreck.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday, October 25, 2024 11:52:56 PM CEST Dominique Martinet wrote:
> Christian,
> 
> this is more up your alley, letting you comment as well as you weren't
> even sent a copy in Ccs
[...]
> > Signed-off-by: GUAN Xin <guanx.bac@gmail.com>
> > cc: Eric Van Hensbergen <ericvh@kernel.org>
> > cc: v9fs@lists.linux.dev
> > cc: netdev@vger.kernel.org
> > cc: linux-fsdevel@vger.kernel.org
> > 
> > --- net/9p/trans_virtio.c.orig  2024-10-25 10:25:09.390922517 +0800
> > +++ net/9p/trans_virtio.c       2024-10-25 16:48:40.451680192 +0800
> > @@ -31,11 +31,12 @@
> > #include <net/9p/transport.h>
> > #include <linux/scatterlist.h>
> > #include <linux/swap.h>
> > +#include <linux/thread_info.h>
> > #include <linux/virtio.h>
> > #include <linux/virtio_9p.h>
> > #include "trans_common.h"
> > 
> > -#define VIRTQUEUE_NUM  128
> > +#define VIRTQUEUE_NUM  (1 << (THREAD_SIZE_ORDER + PAGE_SHIFT - 6))
> 
> (FWIW that turned out to be 256 on my system)

Guan,

it took me a bit to understand why you would change this constant depending on
maximum stack size, as it is not obvious. Looks like you made this because of
this comment (net/9p/trans_virtio.c):

struct virtio_chan {
    ...
	/* Scatterlist: can be too big for stack. */
	struct scatterlist sg[VIRTQUEUE_NUM];
    ...
};

However the stack size is not the limiting factor. It's a bit more complicated
than that:

I have also been working on increasing performance by allowing larger 9p
message size and made it user-configurable at runtime. Here is the latest
version of my patch set:

https://lore.kernel.org/all/cover.1657636554.git.linux_oss@crudebyte.com/

Patches 8..11 have already been merged. Patches 1..7 are still to be merged.

/Christian



