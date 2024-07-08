Return-Path: <linux-fsdevel+bounces-23333-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E17F592ABCC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 00:13:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E4781C214C1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jul 2024 22:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D007152160;
	Mon,  8 Jul 2024 22:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lKgeq+CP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6721509A5;
	Mon,  8 Jul 2024 22:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720476784; cv=none; b=XSemsbjky9lbmgeA+i1/pGxZhfL606sIUsbm/hc/T79pIWLchYw8XwFyNXf01v5woTd6DkB3ft4zcuoq1RfQYVIy9Jjoox7BwtKiWGKzESzaxtczbNjFoTTft648tq1dPnkXoFrTIahphn/4UoPU+V3B31/UMFMsTMiIEZPrj5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720476784; c=relaxed/simple;
	bh=0g9ZqQ34v/Y9q91tPXMcX2UQRI2ExeR/qOQkYnG0C3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CT7EVZeraYR/gHEBoPpVYyXTk3eDi7KtzsNsGLGj0CzdMFZNYnaolz90WR8TmyFFE0DGt57mtbvt5LduWbwGd5H6X44tPMgilV0XgT8kr3PiS16sl+vKmPsVYkyuW84fBv1Dp3OfeTV2m2QHRXwXW17jqbsvEr0NCuZr09RrDi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=lKgeq+CP; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=i/+aDu6z/bqon10/zj70vwV8SqER1DJmyZY2X7lDB68=; b=lKgeq+CPjQYMHzPZ6RgiJ7Ikxa
	a/hrFPtzxmA3G6vx48jk9nPqhwvMMs8r+iBOz8i8oWPpRw7Knq2MPr8n8GaYEcP1InItJWEpxiGWz
	3zRPM5j8ocquC2+NA82oaelN+s0jlB7h28yqq0PH+mY0SJt47bL1tGP6aoq+aPX8Ey4cd0bNqUnaE
	7ai5AaonGZdzqhMjKNa2JXvCQ5oQje6N8513q58Y3Zm9ej6RStMVmRZOhz5nCRMH/z6XDxUt9jRRe
	2R/757wEQYkborAz60Ip/EegeMsQRNrEOqeEbegMQeoJ1OexyLLbeNAYZN54VGuJwqgX2u2xQf5pk
	EOlujcCw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sQwbS-00000005Aya-1dK6;
	Mon, 08 Jul 2024 22:12:58 +0000
Date: Mon, 8 Jul 2024 15:12:58 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,
	Chandan Babu R <chandan.babu@oracle.com>, djwong@kernel.org,
	david@fromorbit.com, willy@infradead.org,
	Christian Brauner <brauner@kernel.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Cc: akpm@linux-foundation.org, yang@os.amperecomputing.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	john.g.garry@oracle.com, linux-fsdevel@vger.kernel.org,
	hare@suse.de, p.raghav@samsung.com, gost.dev@samsung.com,
	cl@os.amperecomputing.com, linux-xfs@vger.kernel.org, hch@lst.de,
	Zi Yan <ziy@nvidia.com>
Subject: Re: [PATCH v9 00/10] enable bs > ps in XFS
Message-ID: <Zoxkap1DtwZ-1tjI@bombadil.infradead.org>
References: <20240704112320.82104-1-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240704112320.82104-1-kernel@pankajraghav.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Thu, Jul 04, 2024 at 11:23:10AM +0000, Pankaj Raghav (Samsung) wrote:
> From: Pankaj Raghav <p.raghav@samsung.com>
> 
> This is the ninth version of the series that enables block size > page size
> (Large Block Size) in XFS.

It's too late to get this in for v6.11, but I'd like to get it more exposure
for testing. Anyone oppose getting this to start being merged now into
linux-next so we can start testing for *more* than a kernel release cycle?

  Luis

