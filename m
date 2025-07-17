Return-Path: <linux-fsdevel+bounces-55289-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA17CB09509
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 21:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF65B5A21FC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 19:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA8C52FA64D;
	Thu, 17 Jul 2025 19:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WyvVyJgD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4191A314E;
	Thu, 17 Jul 2025 19:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752780953; cv=none; b=WxooLqWCc4DxH9ZPBl+i1c5uGEg0GxTeBjVcdOKEJKlmAal35OUhQ0CXR1uBtp0NBZTDAeJWmfNGnN611OheM47td/rNgU6Dmj6DWQ8AvGvyKBNwHvdCaDNlTQRmqWc8JAwRYWFKiWSHH9G/aywqciTFQK/5Z7pQLsBViv/K3zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752780953; c=relaxed/simple;
	bh=YmSNLwmq7WSzOts3BNEEy1Pqy9x+YU6wlwLtxU7jXMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=APhpyQ3s5o436jxPUwZN0VUso6aeUzQApDYgFM+NkvqvSdbwh6h52ri0mgx36dNmNMtE8wZALj9Q8TNBzL/YPJ2c5PlUbJT8lrcxx1TY8yzHfSk5wZbCzYvPpAVgSJXA/DDouFnBvIOZmG9j0j54r/wfKX9w3G7fgQDroZNX6kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WyvVyJgD; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ghsBi7HjlL65WY63Ep2Azpddt/us/qOy51EbMcRtrKk=; b=WyvVyJgDUzAj2MirlsxTVymBAA
	NxC9dOOWooJEtlkMUtUB2AjoZV14d3CVuPKlmPtVGMFhpi2ApVixDrgyx7Fj2k5VNg/1RrcnX4Mwl
	nsh/y4QKRcPISw5iMAfpu3zMHef4uZZdpRuFSfpxXuEISvni0VK0xnh78aaNIiw8JSk4DzLxjPTW+
	VwKYMqBe8LRt0czdhGxHxiPgIhgUJnaJbifmQmzxHZA2JCrzHGqFh/BhV1Ba0QVfZTVd3hBvgnd58
	5en7fsnaaOEILbjZIORw5IcxIuzyi6xsrJHHRXSVgxmW5pqXh6pKX7hZ6s/Iqc3PdQapooTJR+0P2
	m7gEpwag==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ucUOP-00000004GoJ-2GzM;
	Thu, 17 Jul 2025 19:35:45 +0000
Date: Thu, 17 Jul 2025 20:35:45 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Viacheslav Dubeyko <slava@dubeyko.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Yangtao Li <frank.li@vivo.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] hfs: remove BUG() from
 hfs_release_folio()/hfs_test_inode()/hfs_write_inode()
Message-ID: <aHlQkTHYxnZ1wrhF@casper.infradead.org>
References: <ddee2787-dcd9-489d-928b-55a4a95eed6c@I-love.SAKURA.ne.jp>
 <b6e39a3e-f7ce-4f7e-aa77-f6b146bd7c92@I-love.SAKURA.ne.jp>
 <Z1GxzKmR-oA3Fmmv@casper.infradead.org>
 <b992789a-84f5-4f57-88f6-76efedd7d00e@I-love.SAKURA.ne.jp>
 <24e72990-2c48-4084-b229-21161cc27851@I-love.SAKURA.ne.jp>
 <db6a106e-e048-49a8-8945-b10b3bf46c47@I-love.SAKURA.ne.jp>
 <4c1eb34018cabe33f81b1aa13d5eb0adc44661e7.camel@dubeyko.com>
 <175a5ded-518a-4002-8650-cffc7f94aec4@I-love.SAKURA.ne.jp>
 <954d2bfa-f70b-426b-9d3d-f709c6b229c0@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <954d2bfa-f70b-426b-9d3d-f709c6b229c0@I-love.SAKURA.ne.jp>

On Fri, Jul 18, 2025 at 12:32:46AM +0900, Tetsuo Handa wrote:
> +++ b/fs/hfs/inode.c
> @@ -81,7 +81,8 @@ static bool hfs_release_folio(struct folio *folio, gfp_t mask)
>  		tree = HFS_SB(sb)->cat_tree;
>  		break;
>  	default:
> -		BUG();
> +		pr_err("detected unknown inode %lu, running fsck.hfs is recommended.\n",
> +		       inode->i_ino);

As I asked the first time, how can we get here?  In order to release a
folio, we have to first populate the pagecache of the inode with folios.
How did we manage to do that for an inode with a bogus i_ino?

> @@ -441,7 +442,8 @@ int hfs_write_inode(struct inode *inode, struct writeback_control *wbc)
>  			hfs_btree_write(HFS_SB(inode->i_sb)->cat_tree);
>  			return 0;
>  		default:
> -			BUG();
> +			pr_err("detected unknown inode %lu, running fsck.hfs is recommended.\n",
> +			       inode->i_ino);

Similarly here, how did we manage to mark a bad inode as dirty?

