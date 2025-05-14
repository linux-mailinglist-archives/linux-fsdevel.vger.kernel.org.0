Return-Path: <linux-fsdevel+bounces-48966-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E175DAB6CDF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 15:38:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8066319E8071
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 13:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D351027AC25;
	Wed, 14 May 2025 13:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="j+nwTLnG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7886D15AF6;
	Wed, 14 May 2025 13:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747229891; cv=none; b=uHusC6Eh3+thwNELmXuWG5D9PMVFYjpbrv5LkDptRoI7oqZnAHaFnvfRyiD0wwpcyR6MUzdWYpBT8zmbEpy54Yd0otrGkCfai8ck7VoAl6V/bIbnjfeI1fmOGvuSgnU9jHCh4uRTcebFjPBs/i7GR6zj4bP9ii76OZvSiZwVX/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747229891; c=relaxed/simple;
	bh=5ClBZipevonGNISJ//0KQlN0xd1O5NtCKf+GMqisDl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=npcfrR+zh+EX6FP4L3Abc1YXCHxt/vDd/zzjncY6yWROZn6ITNc/W+8rVvflUS1TIjx4szMhEHCHRhSMyNHzDrDi7rW5LiQO4Bq/xUZFOd1k7I1rTLLVA6ZXSAb2IiZ3fwkv5LdO+v9X2UhzVauayINjhUBKFGpBkcD38anRNIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=j+nwTLnG; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=TCbxG0sR6k0ek2FO7HVhODHhtN5gSAWTcsnndt8bAnY=; b=j+nwTLnGp++/pDuVRXV/5puhu4
	kVt4UzOFXLKNMXzkbfTiLtkrR0d25rVC0U0VTpYJfSdtPfJWVBYfodTcI1hnN6xnnTt6RxAYe6evJ
	zmklAigZcqE/tcQtJmMdp+9yn32HRSoFeocohZPjWmNFyZq24AQ1bHw701u9aPB19Gkg5FCLEYKAF
	q6GWrWMUAqs4e2cDRduVkTalMj0E4DXS8IpzgTwT4zU87eZ4hjj1gff+qZrCfJCon0nGXEZnQu7ti
	Ac3rdd0IvOpfKjoMB27XqiZiAsA/778wpMIb0LYXd+UjP1zvUzAsgRmbJfBJo1aVZMi2tKiVoX9NQ
	lepIj0EA==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uFCJC-0000000CM7W-0D7K;
	Wed, 14 May 2025 13:38:06 +0000
Date: Wed, 14 May 2025 14:38:05 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Theodore Ts'o <tytso@mit.edu>
Cc: =?utf-8?B?6ZmI5rab5rab?= Taotao Chen <chentaotao@didiglobal.com>,
	"adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH 1/3] mm/filemap: initialize fsdata with iocb->ki_flags
Message-ID: <aCScvepl2qxyU40P@casper.infradead.org>
References: <20250421105026.19577-1-chentaotao@didiglobal.com>
 <20250421105026.19577-2-chentaotao@didiglobal.com>
 <20250514035125.GB178093@mit.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250514035125.GB178093@mit.edu>

On Tue, May 13, 2025 at 11:51:25PM -0400, Theodore Ts'o wrote:
> I understand that it would be a lot more inconvenient change the
> function signature of write_begin() to pass through iocb->ki_fags via
> a new parameter.  But I think that probably is the best way to go.

I'd suggest that passing in iocb rather than file is the way to go.
Most callers of ->write_begin already pass NULL as the first argument so
would not need to change.  i915/gem passes a non-NULL file, but it only
operates on shmem and shmem does not use the file argument, so they can
pass NULL instead.  fs/buffer.c simply passes through the file passed
to write_begin and can be changed to pass through the iocb passed in.
exfat_extend_valid_size() has an iocb in its caller and can pass in the
iocb instead.  generic_perform_write() has an iocb.

