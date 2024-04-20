Return-Path: <linux-fsdevel+bounces-17355-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE39A8AB922
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Apr 2024 05:04:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7472B281D31
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Apr 2024 03:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75CEF883D;
	Sat, 20 Apr 2024 03:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nz24+NzA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397E0749F
	for <linux-fsdevel@vger.kernel.org>; Sat, 20 Apr 2024 03:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713582256; cv=none; b=ll9MeBUPc5KVV2HsVo0CJxf95oXailaebciLRQkcnqLCbc2Tr+ZdmLmGFGYOEtP+IOomm3+Xw1nen4ZUGCsLQKJI/XWO3g4Q2oM4pbrHigKU6uzHyRSg5Lx16ohIyBMf2MB01+sSvsnFY1KMHBVeCp9uimyYBeWV9M7RDSgO5r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713582256; c=relaxed/simple;
	bh=WwYoZoJd1BRy9sS4coZ5uu1WFlGXO9/NrJfzl029N90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MB6yg00qv+xdsLOI61FsoPLJdc1SxVbAT/nTVUpV7gbIiLiYBK+jw5uj0w4U0kDr3NP/hhz41CqcNMjQFQAwKlY8CW8b08EeWdGjaf/de8FWznNbIBQF7DZI8sj7SqvK9Wj8I84Z3ugf/N/DMHNM4tTAXsi4627V/BFGS30GS2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nz24+NzA; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 19 Apr 2024 23:04:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1713582251;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k0HmzjL+lE24FXiE+j7IGhFf9AYZYrfM6qxjfiUMu70=;
	b=nz24+NzA7mN+E9X1Fyt8FwcCQ5j/uafETIfe3hSnCH1EISxCLrVlhYs1hFxfBWrUkFcbnR
	dquAShDp5VatZugZ5MIGEr5ipJ73ETShnbyiKWvfSZGUbFiYmEw4uaTAXcKk1KzssBcIhs
	RHpCfpVi3WvVMPw46vZUrXf5wySB3CU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, Brian Foster <bfoster@redhat.com>, 
	linux-bcachefs@vger.kernel.org
Subject: Re: [PATCH 06/30] bcachefs: Remove calls to folio_set_error
Message-ID: <cauccmcr2jh2obrt3f7t47jnk77ygpki6ihxtqsw5pfol24zhf@wd5rnfc7ougu>
References: <20240420025029.2166544-1-willy@infradead.org>
 <20240420025029.2166544-7-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240420025029.2166544-7-willy@infradead.org>
X-Migadu-Flow: FLOW_OUT

On Sat, Apr 20, 2024 at 03:50:01AM +0100, Matthew Wilcox (Oracle) wrote:
> Common code doesn't test the error flag, so we don't need to set it in
> bcachefs.  We can use folio_end_read() to combine the setting (or not)
> of the uptodate flag and clearing the lock flag.
> 
> Cc: Kent Overstreet <kent.overstreet@linux.dev>
> Cc: Brian Foster <bfoster@redhat.com>
> Cc: linux-bcachefs@vger.kernel.org
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

applied

