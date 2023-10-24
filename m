Return-Path: <linux-fsdevel+bounces-1109-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00A6E7D57BC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 18:14:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3212F1C20B87
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 16:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16C9339944;
	Tue, 24 Oct 2023 16:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9C9200CC
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Oct 2023 16:14:24 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1175083;
	Tue, 24 Oct 2023 09:14:23 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
	id D7FD668AA6; Tue, 24 Oct 2023 18:14:18 +0200 (CEST)
Date: Tue, 24 Oct 2023 18:14:18 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Matthew Wilcox <willy@infradead.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 1/3] filemap: add a per-mapping stable writes flag
Message-ID: <20231024161418.GA20546@lst.de>
References: <20231024064416.897956-1-hch@lst.de> <20231024064416.897956-2-hch@lst.de> <20231024150053.GY3195650@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231024150053.GY3195650@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Oct 24, 2023 at 08:00:53AM -0700, Darrick J. Wong wrote:
> For a hot second I wondered if we could get rid of SB_I_STABLE_WRITES
> too, but then had an AHA moment when I saw that NFS also sets it.

It's not just NFS, but still the general way of propagating the flag.
I don't really want to add bdev-specific code to new_inode.

