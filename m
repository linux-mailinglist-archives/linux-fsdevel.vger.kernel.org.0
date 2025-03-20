Return-Path: <linux-fsdevel+bounces-44566-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2328A6A613
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 13:15:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80A18188E07D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 12:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E6E221578;
	Thu, 20 Mar 2025 12:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CYrG33lH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14B613C695;
	Thu, 20 Mar 2025 12:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742472717; cv=none; b=ZeZpKxfxVOqMSI3HrMJfREts5Czfw9t+QVtGlh8r1bNvTbOUAuNzX77dkiJi7zmwnNHW47JveGaDdgTgM5LScHMsAh+5eEt/VZ56HmSBMZHvJVchonEqbCGYduviHFvPsxoVmJenDBdW3+uKz05zwoh5H3bqyFd2k0onmx1LwtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742472717; c=relaxed/simple;
	bh=K3hg1bCjJiCU739YdKYncHOb2k8F152AweW3t/yo/+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fYPiQlnb6jcwyOtpOzn9kwpKi2Awhm3kd8WBENiEjesdghWgmd6dvaqpj1YBBElLtHFIzLW1SoNlJyjlX/mZ7d0FLu0W9DSPbzhkYSbFLTxrIUgrXOQPzovyUnNKz05ri+DkmWEYhcFIcdZ2ueoyTVIgA7HvC+JFXYOTLXr8wA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=CYrG33lH; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=6GdYJvaUyHN33OWPLsIOGOvCIvn/uOWWV0lLG312V8w=; b=CYrG33lHZUSnxCeeDL6buuQ3Gd
	ZXncxZYgvDt1AhMNMoxH0NNgwN2Vl/F9DMX+klnY+ql1Nb+wF/bNYyP/5zrijkmvfvPDldi/G/EXp
	KZ1Q1NnN3Rr8W5nTujHbkt3VZiKIH9ixxUui/KKTA3xtFqsZfx5lXXPq5W6wTx/2lpL8sWXxZKC4J
	TOdTSyTLt3BwtjJhMpAK7cx44jaEMtN5u4ZeVbRBcNzwzpAjKmCKA3scFSbMAUkwwPWRaK1TbSfTT
	ixPtmOV+j6xVtlwvDjX1uEPVjP7nTjGExNuYoIeZyhvmcGgOTeQaTXbjfMIkvYPuLHAk9OrzT0L5s
	orBbgBbA==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tvEkV-0000000A7g4-2x1Q;
	Thu, 20 Mar 2025 12:11:47 +0000
Date: Thu, 20 Mar 2025 12:11:47 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-block@vger.kernel.org, lsf-pc@lists.linux-foundation.org,
	david@fromorbit.com, leon@kernel.org, hch@lst.de, kbusch@kernel.org,
	sagi@grimberg.me, axboe@kernel.dk, joro@8bytes.org,
	brauner@kernel.org, hare@suse.de, djwong@kernel.org,
	john.g.garry@oracle.com, ritesh.list@gmail.com,
	p.raghav@samsung.com, gost.dev@samsung.com, da.gomez@samsung.com
Subject: Re: [LSF/MM/BPF TOPIC] breaking the 512 KiB IO boundary on x86_64
Message-ID: <Z9wGA9z_cVn6Mfa1@casper.infradead.org>
References: <Z9v-1xjl7dD7Tr-H@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9v-1xjl7dD7Tr-H@bombadil.infradead.org>

On Thu, Mar 20, 2025 at 04:41:11AM -0700, Luis Chamberlain wrote:
> We've been constrained to a max single 512 KiB IO for a while now on x86_64.
...
> It does beg a few questions:
> 
>  - How are we computing the new max single IO anyway? Are we really
>    bounded only by what devices support?
>  - Do we believe this is the step in the right direction?
>  - Is 2 MiB a sensible max block sector size limit for the next few years?
>  - What other considerations should we have?
>  - Do we want something more deterministic for large folios for direct IO?

Is the 512KiB limit one that real programs actually hit?  Would we
see any benefit from increasing it?  A high end NVMe device has a
bandwidth limit around 10GB/s, so that's reached around 20k IOPS,
which is almost laughably low.

