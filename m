Return-Path: <linux-fsdevel+bounces-58186-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F81AB2ACA6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 17:24:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F5F52065E8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 15:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89E6D255F27;
	Mon, 18 Aug 2025 15:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JycF+HWn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE4A2550D5;
	Mon, 18 Aug 2025 15:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755530489; cv=none; b=W9612T0OgyXQhkc2PvVfdDtEujw00QmR9vAQvy4SFrQ8M8YVgHbZwo6atrHaNu2HGEfUXOFSdZnu0O6i80FTidx5eBEAfpBM8CLxmNyKyb2/sJVWudC3vLx8uofWD0ZTegVx1K3zJY/LVUkqp4xK/j5tOsmG4lp9yhVYKZj5ChA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755530489; c=relaxed/simple;
	bh=ybT3elApIajWSCKl67U2LxsXVp/ZqEfe0e1Txum4w9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qC0T/CYpIbbBGDmtoiW+qo9inkhgCrmKXQ5GYnUTSf9DjXGZOKM8/4AEv95gut6UbdKHiyJE9hRq8W4BlOa4j9NiSPw0/ODeehTHTk2jdBCUSoNB8Gc/EjrVba4nG4U5iXU7HAF46OZB/n+4KAEv8wQaVEwoKYq7KC3Xw63M3nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JycF+HWn; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=vr/RdZMhiaGI1ngCH3UQz2IFmEHsSacQUq/ySyRWpEI=; b=JycF+HWnFn1+yHSfiepZrxbO7r
	nZWN2G9IiimTFw/8K9O7ddLHqtpmzBElB6Q5QnEMe2rPx+cakd39zSuJck2MjUpobrSTfR9Cnpi22
	QTHquBYRuuqe+zmn95Im5MJCKJoQn7q9+dcw3lg6roHCm1uzxm90ScwCMDZGXho5fxL7Sz7BfwZA1
	GxuB0IvuVYFBrGZ0xjvJU0a5a2KNJds5ZbUzBF4VpJXp1NeXOobx4xUO1vQz5bpdFgpiZa8GoBkKs
	OwEfSci8t6xjXjcgvDXIN/YAPeP0l7G1pYRFwaCZjY9NZo8/u5MkXvbDhYsGhGHBV7ov7HFIlFFsY
	rtIuygEA==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uo1fp-00000007kTX-1i95;
	Mon, 18 Aug 2025 15:21:25 +0000
Date: Mon, 18 Aug 2025 16:21:25 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Trond Myklebust <trondmy@kernel.org>
Cc: Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Mike Snitzer <snitzer@kernel.org>
Subject: Re: [PATCH v3 2/2] NFS: Enable the RWF_DONTCACHE flag for the NFS
 client
Message-ID: <aKNE9UnyBoaE_UzJ@casper.infradead.org>
References: <cover.1755527537.git.trond.myklebust@hammerspace.com>
 <001e5575d7ddbcdb925626151a7dcc7353445543.1755527537.git.trond.myklebust@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001e5575d7ddbcdb925626151a7dcc7353445543.1755527537.git.trond.myklebust@hammerspace.com>

On Mon, Aug 18, 2025 at 07:39:50AM -0700, Trond Myklebust wrote:
> @@ -349,8 +349,12 @@ static void nfs_folio_end_writeback(struct folio *folio)
>  static void nfs_page_end_writeback(struct nfs_page *req)
>  {
>  	if (nfs_page_group_sync_on_bit(req, PG_WB_END)) {
> +		struct folio *folio = nfs_page_to_folio(req);
> +
> +		if (folio_test_clear_dropbehind(folio))
> +			set_bit(PG_DROPBEHIND, &req->wb_head->wb_flags);
>  		nfs_unlock_request(req);
> @@ -787,8 +791,15 @@ static void nfs_inode_remove_request(struct nfs_page *req)
>  			clear_bit(PG_MAPPED, &req->wb_head->wb_flags);
>  		}
>  		spin_unlock(&mapping->i_private_lock);
> -	}
> -	nfs_page_group_unlock(req);
> +		nfs_page_group_unlock(req);
> +
> +		if (test_and_clear_bit(PG_DROPBEHIND,
> +				       &req->wb_head->wb_flags)) {
> +			folio_set_dropbehind(folio);
> +			folio_end_dropbehind(folio);
> +		}

I don't think this technique is "safe".  By clearing the flag early,
the page cache can't see that a folio that was created by dropbehind
has now been reused and should have its dropbehind flag cleared.  So we
might see pages dropped from the cache that really should not be.

