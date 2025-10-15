Return-Path: <linux-fsdevel+bounces-64230-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F40BBDE37D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 13:11:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3013E3B3D53
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 11:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4791631C57F;
	Wed, 15 Oct 2025 11:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dbgrB6fJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5992C1590
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Oct 2025 11:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760526475; cv=none; b=ZW7u+GH2C0zo3tklrOpXAoHVhP2UEF75UvoFoG1e7SUADZrCf6k5zpJaBFtS/v5T77lFQ0oQlFej9eDRbzSqzDV1mM1kOg8/nFv/W4p9Bzqgyj689cOCVC6KRAZV2whfiG1tJz9Aon78GbhglYWmwGvo9L4KR7yYVaAyNi0PWE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760526475; c=relaxed/simple;
	bh=T+VNlnck5F7X5yaKW6OrUk2vghLT0TALE4TLmSh0Eu4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E35IDwjueLkJhmwacD9WmBDA/lQDMKuCYsAvpfk+PDCfVU2m/Zk84HQEswlLjPMusVu0Mg60fiPOJymBggsGfdBs1/Uk4XTY0AOLXSHnrsgNwlyfGM9tjTDRGjVmDQMVk0CszEAxUewitOIEx6WUZR3lOVYJ6N7edY5XpUJ2J0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dbgrB6fJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760526471;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=G7tb8jol5niMEwylV1QaVwlR13998kvgQeJ5R3Qpej4=;
	b=dbgrB6fJ5HT89uv3PfAu3OqJ59SJ6VZsUsrLGWapqkoQFbrVJlP0faReleJ2GSCa+RhIWB
	C8Lzoy51geEkTG7ItaRcKYEKaHRAjt8faf+5WyjrLGjLa6mKWeacro+65UUgjbmsD1vMbZ
	JxoliednYlteQPf1lfWGLNVkIcfEY6Y=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-44-twHOLN-EMmK_SFNEFcKG0w-1; Wed,
 15 Oct 2025 07:07:48 -0400
X-MC-Unique: twHOLN-EMmK_SFNEFcKG0w-1
X-Mimecast-MFC-AGG-ID: twHOLN-EMmK_SFNEFcKG0w_1760526466
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B4025180120B;
	Wed, 15 Oct 2025 11:07:45 +0000 (UTC)
Received: from localhost (unknown [10.72.120.29])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8717919560AD;
	Wed, 15 Oct 2025 11:07:43 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Mikulas Patocka <mpatocka@redhat.com>,
	Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
	Dave Chinner <dchinner@redhat.com>,
	linux-fsdevel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V5 0/6] loop: improve loop aio perf by IOCB_NOWAIT
Date: Wed, 15 Oct 2025 19:07:25 +0800
Message-ID: <20251015110735.1361261-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Hello Jens,

This patchset improves loop aio perf by using IOCB_NOWAIT for avoiding to queue aio
command to workqueue context, meantime refactor lo_rw_aio() a bit.

In my test VM, loop disk perf becomes very close to perf of the backing block
device(nvme/mq virtio-scsi).

And Mikulas verified that this way can improve 12jobs sequential readwrite io by
~5X, and basically solve the reported problem together with loop MQ change.

https://lore.kernel.org/linux-block/a8e5c76a-231f-07d1-a394-847de930f638@redhat.com/

Zhaoyang Huang also mentioned it may fix their performance issue on Android
use case.

The loop MQ change will be posted as standalone patch, because it needs
UAPI change.

V5:
	- only try nowait in case that backing file supports it (Yu Kuai)
	- fix one lockdep assert (syzbot) 
	- improve comment log (Christoph)

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

 drivers/block/loop.c | 233 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 194 insertions(+), 39 deletions(-)

-- 
2.47.0


