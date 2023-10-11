Return-Path: <linux-fsdevel+bounces-34-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 262167C498A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 08:00:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14E251C20D62
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 06:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93C5BEAFA;
	Wed, 11 Oct 2023 06:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mnrb6hzV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8583CC8D2
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Oct 2023 06:00:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB108E;
	Tue, 10 Oct 2023 22:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=GET8ZhrTYl5TQ5W/uohHOuZFq1oFNF3XGk5OnQ/7puI=; b=mnrb6hzVzIp/WZZib0NAq5mVGe
	6XVenHEA6rDOCyd+n5PmWNyyio69CHDyfQ19t3ZM6n/lEZBjyOACBbrl8strboMQoVicWpTvZNBnm
	s3/G2RLn6HIDhAbGCXqLKfL1ueboJOTjZw+d4aiDTjwgH1DLb6PFmf5TxinChgP/up5hEa6VrK7R/
	aAFAxgHIrzhvSmAiqXBl0eKPQJkLtkmsgftKrKWMtId5iYdHF+XEgY5Qvnpl15CZ2JlPmXsdQD+Ye
	T6pa4vPuR9KpsqqiQ2cxoIm9c5NbmCZ5Ey5sl1olCTyzCyuEI/FGZvZF9KvVgQ+GgaLcUj93XYEA9
	NqgJjjYg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1qqSGB-00EsqK-13;
	Wed, 11 Oct 2023 05:59:55 +0000
Date: Tue, 10 Oct 2023 22:59:55 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Sarthak Kukreti <sarthakkukreti@chromium.org>
Cc: dm-devel@redhat.com, linux-block@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	Brian Foster <bfoster@redhat.com>, Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Bart Van Assche <bvanassche@google.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Dave Chinner <david@fromorbit.com>, stable@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v8 1/5] block: Don't invalidate pagecache for invalid
 falloc modes
Message-ID: <ZSY526AePuS4jZX8@infradead.org>
References: <20231007012817.3052558-1-sarthakkukreti@chromium.org>
 <20231007012817.3052558-2-sarthakkukreti@chromium.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231007012817.3052558-2-sarthakkukreti@chromium.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Can yu please send this as a separate fix?


