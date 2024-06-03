Return-Path: <linux-fsdevel+bounces-20782-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A12588D7B7C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 08:17:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D840B1C20BDD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 06:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22DA4381C4;
	Mon,  3 Jun 2024 06:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="xBzjubuY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8857A374D3;
	Mon,  3 Jun 2024 06:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717395468; cv=none; b=tg7xv3D7MTmn8ftzUurq6GRyPtZqX6hosa7Bg+qIV3ZZ6CBwmnuMP9HLjpXAbyBD5FGx0uCrFe0J9KagKwUodIJPbZMmLHeXSNFMpSzCF2ABgdKDI+gd2OZ2Te+Q3EF6kAP/ds2od7kyzGBQCyr6o8ONBXmUUx3y7QSgjpjM+LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717395468; c=relaxed/simple;
	bh=bqwooavz5h0SpmZqW29Anepz6kxXdC3/Q984SNlb9II=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=LvEVEoPbqObaXvLpKF/iQXCBlMq7PRPoKkWg8rdjahgpRIz1pxEQE4QH6n/hr4Gi4YToZJapC9io1q33pjWzCAtlJurWIp8DQkAzEeAlSCpw/BUMIcU8HVMbICcus+6Uc2fBFs5XKaGrUXl1OVZGMrKrw0Tcohw6YkiMXpbZ/WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=xBzjubuY; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1717395461; h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type;
	bh=U1l92gV1h3f4v8wWLEoiitFuPVp+n9cdp6+tTytlorw=;
	b=xBzjubuYgeoNu5ATdLTjjaM5sFFicVeGP1LPMCK8PvzihZoq/Ehn+xBPJfk6mDPYmfPxFHK1RMFrWcDraWKDysVPMDlOkJpfPFCfV9+wOJFmIGdYo2y+3wmQ8NcJT0S/PzD21KXCI5npg8wTlfxLuykmYNdoAs2GgT0jrXCmtT0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045046011;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0W7j3tcA_1717395460;
Received: from 30.221.146.1(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0W7j3tcA_1717395460)
          by smtp.aliyun-inc.com;
          Mon, 03 Jun 2024 14:17:41 +0800
Message-ID: <495d2400-1d96-4924-99d3-8b2952e05fc3@linux.alibaba.com>
Date: Mon, 3 Jun 2024 14:17:39 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Miklos Szeredi <miklos@szeredi.hu>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 lege.wang@jaguarmicro.com
From: Jingbo Xu <jefflexu@linux.alibaba.com>
Subject: [HELP] FUSE writeback performance bottleneck
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Miklos,

We spotted a performance bottleneck for FUSE writeback in which the
writeback kworker has consumed nearly 100% CPU, among which 40% CPU is
used for copy_page().

fuse_writepages_fill
  alloc tmp_page
  copy_highpage

This is because of FUSE writeback design (see commit 3be5a52b30aa
("fuse: support writable mmap")), which newly allocates a temp page for
each dirty page to be written back, copy content of dirty page to temp
page, and then write back the temp page instead.  This special design is
intentional to avoid potential deadlocked due to buggy or even malicious
fuse user daemon.

There was a proposal of removing this constraint for virtiofs [1], which
is reasonable as users of virtiofs and virtiofs daemon don't run on the
same OS, and virtiofs daemon is usually offered by cloud vendors that
shall not be malicious.  While for the normal /dev/fuse interface, I
don't think removing the constraint is acceptable.


Come back to the writeback performance bottleneck.  Another important
factor is that, (IIUC) only one kworker at the same time is allowed for
writeback for each filesystem instance (if cgroup writeback is not
enabled).  The kworker is scheduled upon sb->s_bdi->wb.dwork, and the
workqueue infrastructure guarantees that at most one *running* worker is
allowed for one specific work (sb->s_bdi->wb.dwork) at any time.  Thus
the writeback is constraint to one CPU for each filesystem instance.

I'm not sure if offloading the page copying and then FUSE requests
sending to another worker (if a bunch of dirty pages have been
collected) is a good idea or not, e.g.

```
fuse_writepages_fill
  if fuse_writepage_need_send:
    # schedule a work

# the worker
for each dirty page in ap->pages[]:
    copy_page
fuse_writepages_send
```

Any suggestion?



This issue can be reproduced by:

1 ./libfuse/build/example/passthrough_ll -o cache=always -o writeback -o
source=/run/ /mnt
("/run/" is a tmpfs mount)

2 fio --name=write_test --ioengine=psync --iodepth=1 --rw=write --bs=1M
--direct=0 --size=1G --numjobs=2 --group_reporting --directory=/mnt
(at least two threads are needed; fio shows ~1800MiB/s buffer write
bandwidth)


[1]
https://lore.kernel.org/all/20231228123528.705-1-lege.wang@jaguarmicro.com/


-- 
Thanks,
Jingbo

