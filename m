Return-Path: <linux-fsdevel+bounces-55686-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C40B0DAD8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 15:30:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76F2C3B537A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 13:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FDA019E967;
	Tue, 22 Jul 2025 13:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="npAITqdG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02CA288CA7;
	Tue, 22 Jul 2025 13:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753191035; cv=none; b=q3gzqakeqvS7WEnDIHRnkz05HSQzJ86xzi5DznWxEStwZBnzc3QovMuWoXFYubcrMkaAtD2qfdeHCs4+Qkfe7OjF/6mivM/9uUNh+q50Xnzzc2hGjz5lR3UXe32MOoAytQHhwGm+c2D8yBOlChiyKpPKlq6ZLs3HxjwYHyKAVfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753191035; c=relaxed/simple;
	bh=Z0WKhsn/dBmJkM1aGYYF7IagVVskZ5lMSNndaqsXydo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rv2DxhSEyvnyBEvQXmFTRxSkPQG48FkpnIV6evMjX2T1JrGz8+CNqYu0m4BNC9jXFWaUgMu/PVsHw1oAny+K6uK7Vs7TUfENlBySDaPjJWWK56TzNrNvKtu2Y4oGblJOHSNhO8a1zcMb72CF47GVp5PcaxiS1WEbJqSK5yJgxqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=npAITqdG; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=y+vocGkDX75pUYduv+8lBAlBf5hV2X3Gj5TE7w+NhGY=; b=npAITqdGIWbDIcPkRexfOCQwZE
	dgxXDEFR0o7k143FhNVmvEQ9O8oKNLeX4inrmqnhuwOcehv3HWWFujxjombDgRvOw36zZ3WLIAWnc
	C9L8YJqbgLvqjPKU02/ZX/cT3+NYgRk1Jytn3Ru9F+s8mBxqZQPUH8RkKFvTvC90m1Eg1zbUldsCk
	FC2SE9+QHOgOi1CovwWbIiwdUL5uQr3Z5diOk7V0iPAMDwh6XNaTb6QLMzoOr7dmIldUnpD/BmKQG
	rcV+Om3TRXdL+2vzDXA25zsPVLsZcBXcZDFV2cRBHjstu0NX6t38VAU2XuWxd1OMZ1cDIsGDh+qoK
	6MJmJWEw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ueD4X-0000000AkB9-3WTO;
	Tue, 22 Jul 2025 13:30:21 +0000
Date: Tue, 22 Jul 2025 14:30:21 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
	"glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
	"frank.li@vivo.com" <frank.li@vivo.com>,
	"slava@dubeyko.com" <slava@dubeyko.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: Re: [PATCH v3] hfs: remove BUG() from
 hfs_release_folio()/hfs_test_inode()/hfs_write_inode()
Message-ID: <aH-SbYUKE1Ydb-tJ@casper.infradead.org>
References: <24e72990-2c48-4084-b229-21161cc27851@I-love.SAKURA.ne.jp>
 <db6a106e-e048-49a8-8945-b10b3bf46c47@I-love.SAKURA.ne.jp>
 <4c1eb34018cabe33f81b1aa13d5eb0adc44661e7.camel@dubeyko.com>
 <175a5ded-518a-4002-8650-cffc7f94aec4@I-love.SAKURA.ne.jp>
 <954d2bfa-f70b-426b-9d3d-f709c6b229c0@I-love.SAKURA.ne.jp>
 <aHlQkTHYxnZ1wrhF@casper.infradead.org>
 <5684510c160d08680f4c35b2f70881edc53e83aa.camel@ibm.com>
 <93338c04-75d4-474e-b2d9-c3ae6057db96@I-love.SAKURA.ne.jp>
 <b601d17a38a335afbe1398fc7248e4ec878cc1c6.camel@ibm.com>
 <38d8f48e-47c3-4d67-9caa-498f3b47004f@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38d8f48e-47c3-4d67-9caa-498f3b47004f@I-love.SAKURA.ne.jp>

On Tue, Jul 22, 2025 at 07:42:35PM +0900, Tetsuo Handa wrote:
> I can update patch description if you have one, but I don't plan to try something like below.

Why not?  Papering over the underlying problem is what I rejected in v1,
and here we are months later with you trying a v4.

> @@ -393,20 +393,30 @@ struct inode *hfs_iget(struct super_block *sb, struct hfs_cat_key *key, hfs_cat_
>         switch (rec->type) {
>         case HFS_CDR_DIR:
>                 cnid = be32_to_cpu(rec->dir.DirID);
>                 break;
>         case HFS_CDR_FIL:
>                 cnid = be32_to_cpu(rec->file.FlNum);
>                 break;
>         default:
>                 return NULL;
>         }
> +       if (cnid < HFS_FIRSTUSER_CNID) {
> +               switch (cnid) {
> +               case HFS_ROOT_CNID:
> +               case HFS_EXT_CNID:
> +               case HFS_CAT_CNID:
> +                       break;
> +               default:
> +                       return NULL;
> +               }
> +       }
>         inode = iget5_locked(sb, cnid, hfs_test_inode, hfs_read_inode, &data);
>         if (inode && (inode->i_state & I_NEW))
>                 unlock_new_inode(inode);
>         return inode;
>  }
> 

