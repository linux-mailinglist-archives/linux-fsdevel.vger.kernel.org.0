Return-Path: <linux-fsdevel+bounces-62948-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F8A2BA70EA
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Sep 2025 15:29:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 261F5179E1E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Sep 2025 13:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 133227260A;
	Sun, 28 Sep 2025 13:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R8dV3Lom"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF363C38
	for <linux-fsdevel@vger.kernel.org>; Sun, 28 Sep 2025 13:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759066186; cv=none; b=tkyEQNT6n0A7yzJtFhVyswaSUUz7ybK9y30Olx4YkXNQ6PDm7QmIg5qV6Q/G2m0mEgQrEEtc6VGzmVnL9bQvT8tVas3vSrkoX7W03MwOFvETTcM7H1/GnTzM2bEEsF08onEBZnwTZDUEG56IyHbHJXEor8YbUBn+j9Yk/MJYaXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759066186; c=relaxed/simple;
	bh=///aUcQy0v9442typo3axUep//i/bEYnLz4udP9IjM4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E4aWf7kjgHVcZxO9SMgBwrsiDcVJeZsMOQkkT9asoQFFf+olCn8J3O/3YvYevdzyYv3itl2BaiFSATdICLSaCH8UbU0GIiig+N+MkEqpplPAk1PxU+rljilT5ohSYNfdrgYwETvOYZobUbrO39IzldmIC5bZFRFPH74VsvGlqlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R8dV3Lom; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759066182;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=S+kukYCOkKsdLW+UC0jrCN+E3CIedC+GJBiA+P7BUCY=;
	b=R8dV3LomdGL3tTLnHww2+0PAKQE0dw8gOr95rip7OGKCUTN3AUU8D1CrK1+jA0eE9rGzGG
	LefbM5I/XJA8wMGz1Ev6FWZr/AOqrb2I3dTpVqrBcVdqATcSB4BAaHkxGf3dk4OJdL13Nl
	UIf5cHKhv1Tq+QsBgo3B5BO4+I3W4Og=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-294-Sz53dQEVN_atXDaj1SfKXg-1; Sun,
 28 Sep 2025 09:29:38 -0400
X-MC-Unique: Sz53dQEVN_atXDaj1SfKXg-1
X-Mimecast-MFC-AGG-ID: Sz53dQEVN_atXDaj1SfKXg_1759066177
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 03BAE197740B;
	Sun, 28 Sep 2025 13:29:37 +0000 (UTC)
Received: from localhost (unknown [10.72.120.3])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 596E330001A4;
	Sun, 28 Sep 2025 13:29:34 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Mikulas Patocka <mpatocka@redhat.com>,
	Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
	Dave Chinner <dchinner@redhat.com>,
	linux-fsdevel@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V4 0/6] loop: improve loop aio perf by IOCB_NOWAIT
Date: Sun, 28 Sep 2025 21:29:19 +0800
Message-ID: <20250928132927.3672537-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Hello Jens,

This patchset improves loop aio perf by using IOCB_NOWAIT for avoiding to queue aio
command to workqueue context, meantime refactor lo_rw_aio() a bit.

In my test VM, loop disk perf becomes very close to perf of the backing block
device(nvme/mq virtio-scsi).

And Mikulas verified that this way can improve 12jobs sequential rw io by
~5X, and basically solve the reported problem together with loop MQ change.

https://lore.kernel.org/linux-block/a8e5c76a-231f-07d1-a394-847de930f638@redhat.com/

Zhaoyang Huang also mentioned it may fix their performance issue on Android
use case.

The loop MQ change will be posted as standalone patch, because it needs
losetup change.

V4:
	- rebase
	- re-organize and make it more readable 

V3:
	- add reviewed-by tag
	- rename variable & improve commit log & comment on 5/5(Christoph)

V2:
	- patch style fix & cleanup (Christoph)
	- fix randwrite perf regression on sparse backing file
	- drop MQ change


Ming Lei (6):
  loop: add helper lo_cmd_nr_bvec()
  loop: add helper lo_rw_aio_prep()
  loop: add lo_submit_rw_aio()
  loop: move command blkcg/memcg initialization into loop_queue_work
  loop: try to handle loop aio command via NOWAIT IO first
  loop: add hint for handling aio via IOCB_NOWAIT

 drivers/block/loop.c | 227 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 188 insertions(+), 39 deletions(-)

-- 
2.47.0


