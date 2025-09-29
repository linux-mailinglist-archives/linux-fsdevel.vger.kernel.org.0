Return-Path: <linux-fsdevel+bounces-62988-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B3E0BA7BFB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 03:14:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD451189B072
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 01:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A1319EED3;
	Mon, 29 Sep 2025 01:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QEVqK/57"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB8F7082D
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Sep 2025 01:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759108436; cv=none; b=g0GL23Hgq5+QvX/m2nWNHNhOYsDUZjpgT/Mtn2hV8qEiIu+AnM2IRMwQp7VGedFP1P6LM5IbXNtRJSogTK+XAEtpNjDYElBy+AEVeEKNl1X25jePTj2Au6lhPJ8gBQ3svBOJtvsBLXEYjRt3WCkp6SR+LCuoJFGtCZV3PDBidqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759108436; c=relaxed/simple;
	bh=JHEuqYRjf1RRJ48dY59Weg1760fE7v+8BM+mJAyCO/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j7zUHnZqMZwjYbrOesZLGhsTQLXvv7hN9iInwfw5Zk16bSLaFQIw/OlTvHj9agI7Uc8IlPKwHwKbAo1Ucs/paJH9qYZmYylKQEVcrfI6o0k7oQULN26xlHeJ3/60k+e9V0HQdyyTHopOqI7PVBZk6EMRLU1UNSkNE8DwRVFNq3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QEVqK/57; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759108432;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=98UYUEll18IAUNdOSPwLWJ4Ut+5BsagdOfpfon2x9Lo=;
	b=QEVqK/57J0M2TCRen6qvcdBWRGT6wqq/ZaOWtOWDsa/sBcPHKCvGF6GuiR6V2ETjaD0QsD
	eSRRwJ19Osk4dUtOUlh+HmBT32aCIkImKxWfp0JtVv7rzOzP48K3Eg/6J2puIP8aWuFg6G
	f5+8UUdcxCIjHD2+E5tExDJ329p4Lq4=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-462-uXmKcoviPzyv_SelnV5isw-1; Sun,
 28 Sep 2025 21:13:49 -0400
X-MC-Unique: uXmKcoviPzyv_SelnV5isw-1
X-Mimecast-MFC-AGG-ID: uXmKcoviPzyv_SelnV5isw_1759108428
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F167F19560B1;
	Mon, 29 Sep 2025 01:13:46 +0000 (UTC)
Received: from fedora (unknown [10.72.120.21])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 30D1030001BD;
	Mon, 29 Sep 2025 01:13:39 +0000 (UTC)
Date: Mon, 29 Sep 2025 09:13:34 +0800
From: Ming Lei <ming.lei@redhat.com>
To: syzbot ci <syzbot+ci7622762f075d3fa0@syzkaller.appspotmail.com>
Cc: axboe@kernel.dk, dchinner@redhat.com, hch@lst.de,
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	mpatocka@redhat.com, zhaoyang.huang@unisoc.com,
	syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot ci] Re: loop: improve loop aio perf by IOCB_NOWAIT
Message-ID: <aNndPs6kom-n4HSs@fedora>
References: <20250928132927.3672537-1-ming.lei@redhat.com>
 <68d9818c.a00a0220.102ee.002d.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68d9818c.a00a0220.102ee.002d.GAE@google.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Sun, Sep 28, 2025 at 11:42:20AM -0700, syzbot ci wrote:
> syzbot ci has tested the following series
> 
> [v1] loop: improve loop aio perf by IOCB_NOWAIT
> https://lore.kernel.org/all/20250928132927.3672537-1-ming.lei@redhat.com
> * [PATCH V4 1/6] loop: add helper lo_cmd_nr_bvec()
> * [PATCH V4 2/6] loop: add helper lo_rw_aio_prep()
> * [PATCH V4 3/6] loop: add lo_submit_rw_aio()
> * [PATCH V4 4/6] loop: move command blkcg/memcg initialization into loop_queue_work
> * [PATCH V4 5/6] loop: try to handle loop aio command via NOWAIT IO first
> * [PATCH V4 6/6] loop: add hint for handling aio via IOCB_NOWAIT
> 
> and found the following issue:
> WARNING in lo_submit_rw_aio
> 
> Full report is available here:
> https://ci.syzbot.org/series/0ffdb6b4-a5fe-48da-9473-d2a926e780bd
> 
> ***
> 
> WARNING in lo_submit_rw_aio
> 
> tree:      torvalds
> URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux
> base:      07e27ad16399afcd693be20211b0dfae63e0615f
> arch:      amd64
> compiler:  Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
> config:    https://ci.syzbot.org/builds/3aba003b-2400-4e88-9a31-c09ab4e41a84/config
> C repro:   https://ci.syzbot.org/findings/dc97454c-d87b-41f5-a44a-7182e666cfd5/c_repro
> syz repro: https://ci.syzbot.org/findings/dc97454c-d87b-41f5-a44a-7182e666cfd5/syz_repro
> 
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 5958 at drivers/block/loop.c:907 loop_inc_blocking_writes drivers/block/loop.c:907 [inline]

Thanks for your report!

Looks wrong lock is asserted, and the following change can fix it:

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 911262b648ce..f3372bf35fd5 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -904,7 +904,7 @@ static inline int queue_on_root_worker(struct cgroup_subsys_state *css)
 static inline void loop_inc_blocking_writes(struct loop_device *lo,
                struct loop_cmd *cmd)
 {
-       lockdep_assert_held(&lo->lo_mutex);
+       lockdep_assert_held(&lo->lo_work_lock);

        if (req_op(blk_mq_rq_from_pdu(cmd)) == REQ_OP_WRITE)
                lo->lo_nr_blocking_writes += 1;
@@ -913,7 +913,7 @@ static inline void loop_inc_blocking_writes(struct loop_device *lo,
 static inline void loop_dec_blocking_writes(struct loop_device *lo,
                struct loop_cmd *cmd)
 {
-       lockdep_assert_held(&lo->lo_mutex);
+       lockdep_assert_held(&lo->lo_work_lock);

        if (req_op(blk_mq_rq_from_pdu(cmd)) == REQ_OP_WRITE)
                lo->lo_nr_blocking_writes -= 1;




Thanks,
Ming


