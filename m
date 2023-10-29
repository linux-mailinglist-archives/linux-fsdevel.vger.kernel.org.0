Return-Path: <linux-fsdevel+bounces-1509-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E6BC7DAE44
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Oct 2023 21:43:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A2A9B20D94
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Oct 2023 20:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB264DDD7;
	Sun, 29 Oct 2023 20:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eV0FtAq/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BECD36AAB
	for <linux-fsdevel@vger.kernel.org>; Sun, 29 Oct 2023 20:43:22 +0000 (UTC)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D17AB6;
	Sun, 29 Oct 2023 13:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=7IIpjoWOpsvtx4X/Q+GqaCU4Rq449hxXA8ErAipodcg=; b=eV0FtAq/bYAwmv32+sCx0b0Qiu
	Ay6BIxPf1z5E6idphu0sY1nuio8giUHa3H/opfGCvsLGJOsj/gvJ+nA0kqZRgNHcZDi92icJd3GsY
	cClHrXRHbCZ7+DIhdWp3b7yoqkhZBCe+TylofpysGKeSrvd4WK0P9b5L9al9cqCcJqX17XKjUqNKV
	52FT5IBxDzd04eCedUpFV52D/7H16J3ygHTQ+y1hCiQgEIRUwvz1KvLVAdd6nwvE3aadKpIp9l8B8
	9gHZIoBlcOAkWyj+Je+d85H9WRmgJMGCShEOXnV+inmRLdLQOcy8MGO1m633fBIMEnzxr9seyButt
	XwBEDBFA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1qxCcr-00Hb5n-SL; Sun, 29 Oct 2023 20:43:13 +0000
Date: Sun, 29 Oct 2023 20:43:13 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Daniel Gomez <da.gomez@samsung.com>
Cc: "minchan@kernel.org" <minchan@kernel.org>,
	"senozhatsky@chromium.org" <senozhatsky@chromium.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"djwong@kernel.org" <djwong@kernel.org>,
	"hughd@google.com" <hughd@google.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"mcgrof@kernel.org" <mcgrof@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"gost.dev@samsung.com" <gost.dev@samsung.com>,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [RFC PATCH 00/11] shmem: high order folios support in write path
Message-ID: <ZT7D4bOTBWnaqAkN@casper.infradead.org>
References: <20230919135536.2165715-1-da.gomez@samsung.com>
 <CGME20231028211535eucas1p250e19444b8c973221b7cb9e8ab957da7@eucas1p2.samsung.com>
 <20231028211518.3424020-1-da.gomez@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231028211518.3424020-1-da.gomez@samsung.com>

On Sat, Oct 28, 2023 at 09:15:34PM +0000, Daniel Gomez wrote:
> This series try to add support for high order folios in shmem write and
> fallocate paths when swap is disabled (noswap option). This is part of the
> Large Block Size (LBS) effort [1][2] and a continuation of the shmem work from
> Luis here [3] following Matthew Wilcox's suggestion [4] regarding the path to
> take for the folio allocation order calculation.

I don't see how this is part of the LBS effort.  shmem doesn't use a
block device.  swap might, but that's a separate problem, as you've
pointed out.

