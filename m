Return-Path: <linux-fsdevel+bounces-53766-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1894AAF69DA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 07:40:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C425B3AAC0D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 05:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D290328FFFB;
	Thu,  3 Jul 2025 05:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GFx2yi2I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F492DE716
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Jul 2025 05:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751521244; cv=none; b=CeZ/hOvru3Uf7hP4uLNyjhiExAal13CtM1UZS5Alfq+G9jnQOLUbHFz7R1JOxjVgkiyLpCatJuk2jeDaxY/apMUHBuMpZOg5o24e2C8GKD/DTJOONAHj+QyQ6n6Sk9/SuQWTKe1/NDMd95CVAo+DxgxZsoSScNqrNWgP1SDFzbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751521244; c=relaxed/simple;
	bh=pyKGg27WKelRSS1Dv6ToFFaybJlrkH4mQod3GWuSDj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RbaAZ7P7UQRwaCorXfepc0j1SaTzCZgP3BNNRVBhtpsBAuUg5pBjy6mKI+027UlJ5lRxtB7MIOPtLIo0SC73A07ih8TuykS0wyOYYXL4Fo0QbngePPTwu6hAuIPrBI91yKDSDeqtbsq/uE3o5wXwolrAm31aEGe8raOO1yEiFdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GFx2yi2I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ACCDC4CEE3;
	Thu,  3 Jul 2025 05:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751521243;
	bh=pyKGg27WKelRSS1Dv6ToFFaybJlrkH4mQod3GWuSDj0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GFx2yi2IeT2ywc0ZSxnnJvomREuayAU886PZcJhxAfIi+Tz6bl8iPo0vg+rRyBfb5
	 RueTmAYjAJzfLO9/EV+UjHCM+qQQ8vE1rlwPHdbSjY4jZB6s+SYDFtZvBGbgDU4fbk
	 vcQ3aMZpHlY1WstINRhxW7UBN8W+2iCzPel6m0fM=
Date: Thu, 3 Jul 2025 07:40:41 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Reinette Chatre <reinette.chatre@intel.com>,
	"Luck, Tony" <tony.luck@intel.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 04/11] resctrl: get rid of pointless
 debugfs_file_{get,put}()
Message-ID: <2025070323-siding-nearly-8a15@gregkh>
References: <20250702211305.GE1880847@ZenIV>
 <20250702211408.GA3406663@ZenIV>
 <20250702211650.GD3406663@ZenIV>
 <aGWjig2vNfmtl-FZ@agluck-desk3>
 <36094bb2-5982-472b-b379-76986e0c159c@intel.com>
 <20250703002419.GG1880847@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250703002419.GG1880847@ZenIV>

On Thu, Jul 03, 2025 at 01:24:19AM +0100, Al Viro wrote:
> On Wed, Jul 02, 2025 at 04:45:36PM -0700, Reinette Chatre wrote:
> 
> > Thank you very much for catching and fixing this Al.
> > 
> > Acked-by: Reinette Chatre <reinette.chatre@intel.com>
> > 
> > How are the patches from this series expected to flow upstream?
> > resctrl changes usually flow upstream via tip. Would you be ok if
> > I pick just this patch and route it via tip or would you prefer to
> > keep it with this series? At this time I do not anticipate
> > any conflicts if this patch goes upstream via other FS changes during
> > this cycle.
> 
> Up to Greg, really...

I'll take them all, give me a day or so to catch up with pending
reviews, thanks.

greg k-h

