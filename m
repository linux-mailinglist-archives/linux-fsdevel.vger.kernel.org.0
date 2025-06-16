Return-Path: <linux-fsdevel+bounces-51750-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 554BAADB0A6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 14:52:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55B697A7D37
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 12:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 615D429CB4F;
	Mon, 16 Jun 2025 12:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nQMBhnpU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975CA292B26;
	Mon, 16 Jun 2025 12:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750078340; cv=none; b=BZ7aQkWsLKop/jWfODnvnJd66CjlPNhOCnQ6g7+MAJ8hGyRP8z21CzbFSgFM8Alz4Ny5z3rKL6xkbjBdkyCQ9AEA6KXkbDGrjDxccbwQYcvyLmFf8LHli1s2nlIeTVV5onJOsNP0ljMPK2HgKKm6StUD4OsoHeBC9YtxbH7ZBoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750078340; c=relaxed/simple;
	bh=h9Eb2pzHynyOIBldwKVvr3JRKj3vwT089n+zFPTBwp8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k6aiQtkezUKc7Xz5KfaT+Avjo8L1RB+b06lz6d1vSNwsb/Q5ugu42dsYsLVDq4yjiodzMhbF+kVq/Jy9cZOL5MUHu7FUQzTzVHbNKMxOzuMS1dpfNg9d8rWRFE1DGiq/du1ujDrl6RJttcAx95BSbznYJ4Ev7nQAjlTTg5lGy7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nQMBhnpU; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=TUc0YzGRB1iWMJOEh90SUzGIYgts0I6EnWxUSaAdF64=; b=nQMBhnpU41yGBBE1oynYsy9Pnz
	8RFLt8X8SDk8SxuaI8G1Z5HKb5hxytrPDUrJPTsoP+EXNQf7BSCJIxVdhTWY6bTN4TGMN0iE9d4RM
	umxUZFZwcgbobb5Kub3WxKQLn4Ujq2XgKNo1bZqBBRxLUejBIIqQs0LmcQjwbSXW+XsOLHl85dVPn
	SzNnyc//NcQ3RSmpL6tIccRvXU/MrAbx2JE6NcdWv/5LGfjgMDUjiGsZ5vjQEwWVuEfmnu4e7TemG
	7f8WpfEPG20Jt/btxKqOQBoykjWKs1+l+wWg9SxY8FYIOHm5KtesOHfrQfV2HOIWE1+7N4/6NU8jI
	bsFzV0dw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uR9Jz-00000004RBJ-0png;
	Mon, 16 Jun 2025 12:52:19 +0000
Date: Mon, 16 Jun 2025 05:52:19 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, hch@infradead.org, djwong@kernel.org,
	anuj1072538@gmail.com, miklos@szeredi.hu, brauner@kernel.org,
	linux-xfs@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v2 09/16] iomap: change 'count' to 'async_writeback'
Message-ID: <aFATg58omJ2405xC@infradead.org>
References: <20250613214642.2903225-1-joannelkoong@gmail.com>
 <20250613214642.2903225-10-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250613214642.2903225-10-joannelkoong@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Jun 13, 2025 at 02:46:34PM -0700, Joanne Koong wrote:
> Rename "count" to "async_writeback" to better reflect its function and
> since it is used as a boolean, change its type from unsigned to bool.

Not sure async_writeback is really the right name here, the way it is
used is just that there is any writeback going on.  Which generally
is asynchronous as otherwise performance would suck, but the important
bit is that the responsibility for finishing the folio writeback shifted
to the caller. 

