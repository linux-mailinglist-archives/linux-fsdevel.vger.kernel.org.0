Return-Path: <linux-fsdevel+bounces-51796-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F02B8ADB961
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 21:15:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F56217336C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 19:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39ABB289E12;
	Mon, 16 Jun 2025 19:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="rp9bBVFk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6C01C7017
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Jun 2025 19:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750101304; cv=none; b=jhjFwNTHPNm13yoodb1CYVSXKEUI2rmtgtA3+NV3IZcXPIsvsj+w8coQxXHXDvxOs+7zkewuL9kN0Yhv50Q16Cf3uyrRczRquRUokDrCQ+Nh4fSPI0Eoizkvb7P/kp8uEZ8OjJfFJWtzrmCB6Qpe/V1uXwWcRfDiQL/vaFwCWU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750101304; c=relaxed/simple;
	bh=WGaSf2nSrw2JHNRfZ2KrHoixp/DRMjDKUkm9YVBGvzM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NIRQZ/rZh37XcXgg+QQz3ifIb20sxmqYCipl1OpDAfXKwIRUoylyWa9M7Vx4XonGFswHB5jnaASxgSWPVrFFTAx8uST5XBG2mf8u32TWVUJg2DfBrEkUDwxThJMegiaAOi7YeZ8yIpV587aiKywwVOuaLLOTgBLtERSkWcSU+m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=rp9bBVFk; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=WXIrt0q0/ERiWgghth1Qv5tLYw5nS/oaLb8Ql2r9BuQ=; b=rp9bBVFk+O3w5m2/OhMY9/SHLi
	2S5q+Z1XkfF8xuoMaeAsu5JgE5aFX2x6ImghgMSKLLxub2E4SbGBm+ny4WOqoyt9QTQ3Fap+c95Sy
	E5QJ1EHYOVXJWvoYUu/QFmvP3EABhKZUMBAhczc6gP6nEpfcnHSTNq1Cg00YxJYxp0jkRWf71ewSY
	EGB/SFGe1rm0Bj4wjk82WtAyRmTL87LzoHXiRZMU56tJT53ZcwU90pPWoGrjcxd8RGrwNU+y2ZzZv
	rwFI1+q7g7Pq8O4DNN5AqnKX36+/VqqqTpu9BUYg8c+dUCj/baX/6WtVzSgCyxWg0W5bGIhV7HmOx
	HCaRB4jA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uRFII-00000001aGm-2PKo;
	Mon, 16 Jun 2025 19:14:58 +0000
Date: Mon, 16 Jun 2025 20:14:58 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, neil@brown.name,
	torvalds@linux-foundation.org
Subject: Re: [PATCH 3/8] spufs: switch to locked_recursive_removal()
Message-ID: <20250616191458.GH1880847@ZenIV>
References: <20250614060050.GB1880847@ZenIV>
 <20250614060230.487463-1-viro@zeniv.linux.org.uk>
 <20250614060230.487463-3-viro@zeniv.linux.org.uk>
 <20250616-unsanft-gegolten-725b6c12e6c8@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250616-unsanft-gegolten-725b6c12e6c8@brauner>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Jun 16, 2025 at 04:40:14PM +0200, Christian Brauner wrote:
> On Sat, Jun 14, 2025 at 07:02:25AM +0100, Al Viro wrote:
> > ... and fix an old deadlock on spufs_mkdir() failures to populate
> > subdirectory - spufs_rmdir() had always been taking lock on the
> > victim, so doing it while the victim is locked is a bad idea.
> > 
> > Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> > ---
> 
> Fwiw, I think simple_recursive_removal_locked() might be better.
> It's longer and arguably uglier but it clearer communicates that its the
> same helper as simple_recursive_removal() just with the assumption that
> the caller already holds the lock.

Not sure...  TBH, I'm somewhat tempted to rename simple_recursive_removal()
to simple_remove()...

