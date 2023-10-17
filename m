Return-Path: <linux-fsdevel+bounces-546-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7A167CCB0A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Oct 2023 20:48:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DE461C20C97
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Oct 2023 18:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A0284446F;
	Tue, 17 Oct 2023 18:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="2qn8C3xx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F256B347B1
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Oct 2023 18:48:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36FE890;
	Tue, 17 Oct 2023 11:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=QmBB7UCJvM+8yHBnQ7IH5164AJuOIh1lyxiriNf+nz8=; b=2qn8C3xxVDrnY0ucy44K3DH+jf
	48imZX/ufyAIbXT7dgrG0eQyCM7FTXmhDA+lDs20K2qQrvJhKsdO3qBcBJTwOp9h41MXnNBxm/i95
	tXHgJduOPy4pxm+n/WegsDH0R6fzsabcjMx1nZHC0iFHuZZjHn+r3sPX7AS869zQYA0Qk20tYfYoC
	ip0xT3Ocn3+kZMbM5he0ZMNsgrwMXJmUmIh/gWWHOdzq7kmB3HuNCcYzhvT8KznuK2VOi0ZJktwis
	nEaJ5VvdFVL7oiLTc33SE1q5Aj+k3dsC0f5KLNcJLT/2IEYvuvQ+Vru1zgPNV6F2k3BNnJDqxqbLE
	SYLOfOUg==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1qsp7D-00D0K4-0x;
	Tue, 17 Oct 2023 18:48:27 +0000
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Jens Axboe <axboe@kernel.dk>
Cc: Jan Kara <jack@suse.cz>,
	Denis Efremov <efremov@linux.com>,
	linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: don't take s_umount under open_mutex
Date: Tue, 17 Oct 2023 20:48:18 +0200
Message-Id: <20231017184823.1383356-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi all,

Christian has been pestering Jan and me a bit about finally fixing
all the pre-existing mostly theoretical cases of s_umount taken under
open_mutex.  This series, which is mostly from him with some help from
me should get us to that goal by replacing bdev_mark_dead calls that
can't ever reach a file system holder to call into with simple bdev
page invalidation.

Expect future version to come from Christian again, I'm just helping
out while he is trouble shooting his mail setup.

Diffstat:
 block/disk-events.c     |   18 +++++++-----------
 block/genhd.c           |    7 +++++++
 block/partitions/core.c |   43 +++++++++++++++++++++++++++++--------------
 drivers/block/ataflop.c |    4 +++-
 drivers/block/floppy.c  |    4 +++-
 fs/super.c              |    2 ++
 6 files changed, 51 insertions(+), 27 deletions(-)

