Return-Path: <linux-fsdevel+bounces-44579-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 084EAA6A749
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 14:37:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 379B8188C754
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 13:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EBD821CA0E;
	Thu, 20 Mar 2025 13:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="USWFXwAL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7A94690;
	Thu, 20 Mar 2025 13:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742477399; cv=none; b=E3YwAaelP59UjQdRDUtxJZy52c4Ploi7zpo+TUz4imbFLuas02h36gmcdJQwI8e4fq/Sa8mRMGMC1OSKfHHkhRfxaM0kMQ340xc2JuCAkNrIrUrG3/UQkdWo08MohyQ3LV39T2ahgxCSUezftA1i3L7D70QxWLz+EQVwcOkUAhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742477399; c=relaxed/simple;
	bh=blquli6rY0AiE+Vj/Xq3yIzJvhxk3Y2KmzfSno2Oyg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rc6+LT+W5IJuTnm/peepf6J/QcqpofX6NDznWlymbUMERrXP8TrkEFZh2TLcLME30/tLrQp1g6MpE68sgJkEsXhfPsx2L36U8Iv194V5pLvraNbnLuBg0sxUaWmTf3oxgmKac3XUp8TuN6TPRQQkVSDkfy5p6vT1Xbd59pNI1GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=USWFXwAL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 839EDC4CEDD;
	Thu, 20 Mar 2025 13:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742477399;
	bh=blquli6rY0AiE+Vj/Xq3yIzJvhxk3Y2KmzfSno2Oyg0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=USWFXwAL+jliQWyJALPWV+ylDzrxzMujgditOImK1xKbtXiUIcwCtpIc4LyI9ZBj/
	 AgBFdz2LaQw8FUtN1hlNsp3+eHp0ULFiyhWf+Vvk0ERkJBKTQaQ4xmBTGyIhbWEuBE
	 5mh8X1/dr9Um1qBjygk1k+Herayh57umOk1vVQHs2jLSUDJRgSMl/7MkcwchxUgSFA
	 InulU32kl6HjWdlPHQO2nmx6IoubsdEcTiVTQZjIjQGvznluAXSqGYQRDQi1aHZe1i
	 zUz63ZqXhcwtcrGYGTumvTuEcXRZU0UBUF3uEQP2j+iGQd46EdquJEaTArfESnHzdG
	 zLETVi+x5UQtA==
Date: Thu, 20 Mar 2025 14:29:56 +0100
From: Daniel Gomez <da.gomez@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-block@vger.kernel.org, lsf-pc@lists.linux-foundation.org, 
	david@fromorbit.com, leon@kernel.org, hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, 
	axboe@kernel.dk, joro@8bytes.org, brauner@kernel.org, hare@suse.de, 
	djwong@kernel.org, john.g.garry@oracle.com, ritesh.list@gmail.com, 
	p.raghav@samsung.com, gost.dev@samsung.com, da.gomez@samsung.com
Subject: Re: [LSF/MM/BPF TOPIC] breaking the 512 KiB IO boundary on x86_64
Message-ID: <t5zqyoxwjkl2su6ypfo6p4toliwq6opktufhibd4wwhfrjs26r@k56hbgmr2hwz>
References: <Z9v-1xjl7dD7Tr-H@bombadil.infradead.org>
 <Z9wGA9z_cVn6Mfa1@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9wGA9z_cVn6Mfa1@casper.infradead.org>

On Thu, Mar 20, 2025 at 12:11:47PM +0100, Matthew Wilcox wrote:
> On Thu, Mar 20, 2025 at 04:41:11AM -0700, Luis Chamberlain wrote:
> > We've been constrained to a max single 512 KiB IO for a while now on x86_64.
> ...
> > It does beg a few questions:
> > 
> >  - How are we computing the new max single IO anyway? Are we really
> >    bounded only by what devices support?
> >  - Do we believe this is the step in the right direction?
> >  - Is 2 MiB a sensible max block sector size limit for the next few years?
> >  - What other considerations should we have?
> >  - Do we want something more deterministic for large folios for direct IO?
> 
> Is the 512KiB limit one that real programs actually hit?  Would we
> see any benefit from increasing it?  A high end NVMe device has a
> bandwidth limit around 10GB/s, so that's reached around 20k IOPS,
> which is almost laughably low.

Current devices do more than that. A quick search gives me 14GB/s and 2.5M IOPS
for gen5 devices:

https://semiconductor.samsung.com/ssd/enterprise-ssd/pm1743/

An gen6 goes even further.

Daniel

