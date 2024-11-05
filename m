Return-Path: <linux-fsdevel+bounces-33672-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 292599BCFFA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Nov 2024 16:02:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CDB9B23816
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Nov 2024 15:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 139F21D86F1;
	Tue,  5 Nov 2024 15:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Pe06JN3h"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B4B3D0D5;
	Tue,  5 Nov 2024 15:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730818912; cv=none; b=XysdQuBiMRJ2EgdFnejz1ezEK7LTMvUQwUVAb00MFrFg3Re4QUwbZmBYCTn3GQsSRU+28Q25K/cMHbblHmcmiCdsIwpdPIU+OOGVmVRggRUInvz4QssB1/2iXzcJ8Fthes1vk19TCJrYQ+DTq1UA/0SsYgRR94+c2/Mdm+XgoDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730818912; c=relaxed/simple;
	bh=iqPtQ/8FRJp9Op2zNHjveO5FtHExl1EzCsWTDkJLlWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tnExCDeo1cgpsa+tnv0MeRKu/qOdvEbv6I1OBci/8yXbSoGrJUuEdVHjTcu6QdFPRMNYtXh3gm64cwrqnLAq41GYTfc3Fwe0mOL74o6cl4xX3Zi1bvt7bLT2Pg5P1KcfQ31qSixD5SBe3JeiLrr7xN+505g7VNwQLXCGg2oy4qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Pe06JN3h; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=DQmZCBFbelk87o5P8AB8lWKTkBUIRjecPy4u4jgi/Fo=; b=Pe06JN3hkMGKZKWryFIfrVEBn9
	kltFsidXEzoCRF0KUAshkv0bD+RBv7mdMGmiXVbecA/O5zxefPhDC85b93XAFdNsPi5o9QCU0dtl1
	Yvdl2va5IH7Nw2rkrCvWN1X1TZbBqU3jdMZjwj1eYcdmopUiVWysazciDAK2fESyeULJYUZhtNZ2J
	ULjvz97+KV8HaOc+4KFRBMquiRzOk+zOuU1UC/p3Op+5e6wM+G3wKexUTAKxhn3FI0qf+z930pTN2
	9K0nP1iUYAPVzx8rQXNDTbueB3u5v+gLuBjETtBDXjU9KwyaOiHj+tsKwGOebAN2rX9xLV/WjVCSh
	psYBIfeg==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t8L41-00000003A1G-1JkC;
	Tue, 05 Nov 2024 15:01:49 +0000
Date: Tue, 5 Nov 2024 15:01:49 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: ecryptfs@vger.kernel.org, Tyler Hicks <code@tyhicks.com>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 00/10] Convert ecryptfs to use folios
Message-ID: <ZyozXQq1B4DIu-1q@casper.infradead.org>
References: <20241025190822.1319162-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025190822.1319162-1-willy@infradead.org>

On Fri, Oct 25, 2024 at 08:08:10PM +0100, Matthew Wilcox (Oracle) wrote:
> The next step in the folio project is to remove page->index.  This
> patchset does that for ecryptfs.  As an unloved filesystem, I haven't
> made any effort to support large folios; this is just "keep it working".
> I have only compile tested this, but since it's a straightforward
> conversion I'm not expecting any problems beyond my fat fingers.
> 
> v2:
>  - Switch from 'rc' to 'err' in ecryptfs_read_folio
>  - Use folio_end_read() in ecryptfs_read_folio
>  - Remove kernel-doc warnings that 0day warned about
>  - R-b tags from Pankaj

Christian, can you take this patch series through the vfs tree?
There's been no movement on it in two weeks, and i fear it will miss the
next merge window.

