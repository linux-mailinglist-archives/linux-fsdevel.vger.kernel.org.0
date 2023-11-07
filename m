Return-Path: <linux-fsdevel+bounces-2301-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4D037E495A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 20:42:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E4E0281395
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 19:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A79F636AFD;
	Tue,  7 Nov 2023 19:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VRGquDM0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7420A36B06
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Nov 2023 19:42:08 +0000 (UTC)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E51DC10C1
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Nov 2023 11:42:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=Db9hVyeEDHRYn+EHAVYt5dg4Ynb4AJv0NA9tFbxG5AE=; b=VRGquDM0WuR+odwba5BmTWCNEO
	Ld63G/gu614CKmNv5J8KTTkiqlrnanxxV03JKXqTG2WtwpShErNj6LqYOE1t8rjyQNwazN+Bx2yip
	grbcLNDlGFFsLNhWn3Z04OfuXnczOVqMKJDCSg2Xg7WRXP4rAdeK4rTcubhr0eVAT+IKe4vawvng7
	0Gegf19dNFhNfmnm0AoHxyZDfy+IQIRcChtJAXnQz9pbJ12vZ1Wz9cwYrSoLqW1yRZ3HWdKn7DywT
	yC0gk8S99WJ7FtbD6k+IINszUuQqZ8vCB7x+X7kAX9wBtXUM+9NRBraeBanLVaHzjCtw6RdTVOs5F
	ZuxD9O6g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1r0RxT-00E9kx-IP; Tue, 07 Nov 2023 19:41:55 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Hannes Reinecke <hare@suse.de>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Pankaj Raghav <p.raghav@samsung.com>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 0/5] More buffer_head cleanups
Date: Tue,  7 Nov 2023 19:41:47 +0000
Message-Id: <20231107194152.3374087-1-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The first patch is a left-over from last cycle.  The rest fix "obvious"
block size > PAGE_SIZE problems.  I haven't tested with a large block
size setup.

Matthew Wilcox (Oracle) (5):
  buffer: Return bool from grow_dev_folio()
  buffer: Calculate block number inside folio_init_buffers()
  buffer: Fix grow_buffers() for block size > PAGE_SIZE
  buffer: Cast block to loff_t before shifting it
  buffer: Fix various functions for block size > PAGE_SIZE

 fs/buffer.c | 86 +++++++++++++++++++++++++----------------------------
 1 file changed, 40 insertions(+), 46 deletions(-)

-- 
2.42.0

