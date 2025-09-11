Return-Path: <linux-fsdevel+bounces-60947-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B10B2B5323C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Sep 2025 14:30:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83CE05A2805
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Sep 2025 12:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAD303277BA;
	Thu, 11 Sep 2025 12:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="GPMutLoP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F0E321F5A;
	Thu, 11 Sep 2025 12:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757593773; cv=none; b=YHftBgFNfIgdfH86dZVOohMiap1YTpaprK5V7oS/dbrzdVFOh6YeQgsjfBCE58xb04Ee0YHpSpPiQullJFKU67sjaPVUaZtlA6mZ+D3VAzMDKOfYmh2mak9Q1driKHT5hSkcnn2EV6JhBOSOaaQIrlpF57CPtGbQnzeznfxN+/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757593773; c=relaxed/simple;
	bh=bN322DPwaOeYhQjptNnHiEdxrT5VPto/SbVF/Os+afs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZNazPkrgKda5E6WfzhnF7UPB/Z4YyPX/hjIam+ErJoHlq212AlMevkdOyYrFodlmChzQmSdW39Yk7jsoR/cScM7A9lSQzbjZRScPdEW64kjjNk2klYywm7gCa8w5/Wk4yH/hfyAVnpnEzb4qXOQqPmfgF0WIw4rzbQu/7okFftA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=GPMutLoP; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1757593761; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=CQwEV9u7fDKUXrr0f6do4Mzfl1lSNw8kMkmnJlwx09s=;
	b=GPMutLoP0V8tblYsE03jCw4ib6QRGmLOWZISzM6zq9DlCVPvqv7zuO8hFtF/ObPnU2FlXKqyO349GF8eWMwOeu7HpOJe5IE4jcEiOck85fPX0YrcXzJKY+t4f11f8KMxNJOz3JszdF/Hc2s3nECQ4kWSnPKZT93Iqphp0JzB/9I=
Received: from 30.180.0.242(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WnmHWCN_1757593759 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 11 Sep 2025 20:29:21 +0800
Message-ID: <9c104881-f09e-4594-9e41-0b6f75a5308c@linux.alibaba.com>
Date: Thu, 11 Sep 2025 20:29:17 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/16] iomap: move read/readahead logic out of
 CONFIG_BLOCK guard
To: Christoph Hellwig <hch@infradead.org>
Cc: Joanne Koong <joannelkoong@gmail.com>, brauner@kernel.org,
 miklos@szeredi.hu, djwong@kernel.org, linux-block@vger.kernel.org,
 gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org, kernel-team@meta.com,
 linux-xfs@vger.kernel.org, linux-doc@vger.kernel.org
References: <20250908185122.3199171-1-joannelkoong@gmail.com>
 <20250908185122.3199171-14-joannelkoong@gmail.com>
 <a1529c0f-1f1a-477a-aeeb-a4f108aab26b@linux.alibaba.com>
 <CAJnrk1aCCqoOAgcPUpr+Z09DhJ5BAYoSho5dveGQKB9zincYSQ@mail.gmail.com>
 <0b33ab17-2fc0-438f-95aa-56a1d20edb38@linux.alibaba.com>
 <aMK0lC5iwM0GWKHq@infradead.org>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <aMK0lC5iwM0GWKHq@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Christoph,

On 2025/9/11 19:37, Christoph Hellwig wrote:
> On Wed, Sep 10, 2025 at 12:59:41PM +0800, Gao Xiang wrote:
>> At least it sounds better on my side, but anyway it's just
>> my own overall thought.  If other folks have different idea,
>> I don't have strong opinion, I just need something for my own
>> as previous said.
> 
> I already dropped my two suggestions on the earlier patch.  Not totally
> happy about either my suggestions or data, but in full agreement that
> it should be something else than private.

To just quote your previous comment and try to discuss here:

```
On Wed, Sep 10, 2025 at 01:41:25PM -0400, Joanne Koong wrote:
> In my mind, the big question is whether or not the data the
> filesystems pass in is logically shared by both iomap_begin/end and
> buffered reads/writes/dio callbacks, or whether the data needed by
> both are basically separate entities

They are separate entities.
```

I try to push this again because I'm still not quite sure it's
a good idea, let's take this FUSE iomap-read proposal (but sorry
honestly I not fully look into the whole series.)

```
  struct fuse_fill_read_data {
  	struct file *file;
+
+	/*
+	 * Fields below are used if sending the read request
+	 * asynchronously.
+	 */
+	struct fuse_conn *fc;
+	struct fuse_io_args *ia;
+	unsigned int nr_bytes;
  };
```

which is just a new FUSE-only-specific context for
`struct iomap_read_folio_ctx`, it's not used by .iomap_{begin,end}
is that basically FUSE _currently_ doesn't have logical-to-physical
mapping requirement (except for another fuse_iomap_begin in dax.c):
```
static int fuse_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
                             unsigned int flags, struct iomap *iomap,
                             struct iomap *srcmap)
{
         iomap->type = IOMAP_MAPPED;
         iomap->length = length;
         iomap->offset = offset;
         return 0;
}
```

But if FUSE or some other fs later needs to request L2P information
in their .iomap_begin() and need to send L2P requests to userspace
daemon to confirm where to get the physical data (maybe somewhat
like Darrick's work but I don't have extra time to dig into that
either) rather than just something totally bypass iomap-L2P logic
as above, then I'm not sure the current `iomap_iter->private` is
quite seperate to `struct iomap_read_folio_ctx->private`, it seems
both needs fs-specific extra contexts for the same I/O flow.

I think the reason why `struct iomap_read_folio_ctx->private` is
introduced is basically previous iomap filesystems are all
bio-based, and they shares `bio` concept in common but
`iter->private` was not designed for this usage.

But fuse `struct iomap_read_folio_ctx` and
`struct fuse_fill_read_data` are too FUSE-specific, I cannot
see it could be shared by other filesystems in the near future,
which is much like a single-filesystem specific concept, and
unlike to `bio` at all.

I've already racked my brains on this but I have no better
idea on the current callback-hook model (so I don't want to argue
more). Anyway, I really think it should be carefully designed
(because the current FUSE .iomap_{begin,end} are just like no-op
but that is just fuse-specific).  If folks really think Joanne's
work is already best or we can live with that, I'm totally fine.

Thanks,
Gao Xiang


