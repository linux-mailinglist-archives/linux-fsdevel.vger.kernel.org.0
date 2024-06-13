Return-Path: <linux-fsdevel+bounces-21637-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD9A6906AE1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 13:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1A591C2433D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 11:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E93143868;
	Thu, 13 Jun 2024 11:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AN/6ZfkC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA686143866;
	Thu, 13 Jun 2024 11:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718277625; cv=none; b=P6bVv80wjo2sXFgUCtAyYQw7EBQShaoBwYzfqENt2Yhu6HL/C8AgiOkAg0VPYW4Z0cVhSHo12mrV6lTHuYPGBWl2I2iY4Pt4EHPP7VjQTr2GQo9NsaSU2QZGFH+123oWc+3oXoWBvzR3cuBIakhTRfe4fd6u+TxzNtZyVzesXiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718277625; c=relaxed/simple;
	bh=/+wUmVOzKP/j+v1/sXD3IPDuor9FJIaPIUgsfmlKGdw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hh+2HLyc1WqSbyxkEOgVzy+vUdnN7S56WLA2At8oldMtc+q+SXTtre3ojrlf3paKrOZkbA/FuG+JHu0qReH+EAffukoRYFDiFATdxOXjWGw3zZfQ76zOMZnIvo+oJV0jHW01eBnvqpS3FjV/t4q8yhGkq8YqMWXilbCiMixn1Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=AN/6ZfkC; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=2zcgRHuJsYat9muUyNpQ60Hc1jyeeQvzQsEJC6t++hQ=; b=AN/6ZfkCyyY/9mMdGB9ZFNhW3m
	ewYsckEUvP0jDxWTKpGPvQTD1lYUVnASLXrJVsSvJyt+Xn5LkqEtSdje492yzPuiMQsIWbZ3qn3qE
	7/0XhgcF06wd8qcBlLuXXjJSR08jOLtN4rJfdotBDFDymuF1Dauocq9HeRkp12ty9SOYFyFy+jjjV
	La25/7p7gHC2Ktom2wdct3WSQAoH5stHnR9FGH8qa4Qh8p/W/9Lnkz4Q1pn/4mY9rIvvb0R3FPQXw
	8ki53dyrg+cT8R75592KGLuRPj/0rhk3F8HrFSQV84Jtp+ClOKsBbQMSET88lstZEmCv/dVnbbWup
	OXc+HVGQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHiVC-0000000GI2B-1SjS;
	Thu, 13 Jun 2024 11:20:22 +0000
Date: Thu, 13 Jun 2024 04:20:22 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-mtd@lists.infradead.org, willy@infradead.org,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-m68k@lists.linux-m68k.org
Subject: Re: Issue with JFFS2 and a_ops->dirty_folio
Message-ID: <ZmrV9vLwj0uFj5Dn@infradead.org>
References: <0b657056-3a7f-46ba-8e99-a8fe2203901f@yoseli.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b657056-3a7f-46ba-8e99-a8fe2203901f@yoseli.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Jun 13, 2024 at 09:05:17AM +0200, Jean-Michel Hautbois wrote:
> Hi everyone !
> 
> I am currently working on a Coldfire (MPC54418) and quite everything goes
> well, except that I can only execute one command from user space before
> getting a segmentation fault on the do_exit() syscall.

Looks like jffs2 is simply missing a dirty_folio implementation.  The
simple filemap_dirty_folio should do the job, please try the patch
below:


diff --git a/fs/jffs2/file.c b/fs/jffs2/file.c
index 62ea76da7fdf23..7124cbad6c35ae 100644
--- a/fs/jffs2/file.c
+++ b/fs/jffs2/file.c
@@ -19,6 +19,7 @@
 #include <linux/highmem.h>
 #include <linux/crc32.h>
 #include <linux/jffs2.h>
+#include <linux/writeback.h>
 #include "nodelist.h"
 
 static int jffs2_write_end(struct file *filp, struct address_space *mapping,
@@ -75,6 +76,7 @@ const struct address_space_operations jffs2_file_address_operations =
 	.read_folio =	jffs2_read_folio,
 	.write_begin =	jffs2_write_begin,
 	.write_end =	jffs2_write_end,
+	.dirty_folio =	filemap_dirty_folio,
 };
 
 static int jffs2_do_readpage_nolock (struct inode *inode, struct page *pg)

