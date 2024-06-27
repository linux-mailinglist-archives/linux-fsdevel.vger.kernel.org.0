Return-Path: <linux-fsdevel+bounces-22597-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A0A919EA5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 07:31:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F48F2849D3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 05:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB2E21CFB9;
	Thu, 27 Jun 2024 05:31:30 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74EC1C2AD;
	Thu, 27 Jun 2024 05:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719466290; cv=none; b=uR2cg4xcXKyEf/Dq1zAqMM5JmYQM9NmGCZ5jjSHIslWohUkrK1vJClQqjOkunLtC1jvpls6+s/CZ30Z2QR7MKYujGqOS1X+Asiw/HFV1nJl0cFEbHbzWVeSRD87OuoNl2ahqYlMnK6D58AKtM48vVuwNYgQFD+O4HNOJ4eZ8dtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719466290; c=relaxed/simple;
	bh=qZ4gmQ4nIh9FnNgshA1LoPWbk/REsI8O/Lisyf5tUn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vzsgpq6NhFT1/W2cfJIpNP937QxcLONWUe180vAvKClk+k21O3jmndFo4Gzf+FiPJwn3FYPAEwNOkH+ZkZBU2UojB5EU1eAX517dkLHroPK6Lt5+lovajre2uneYE1EEKvxyKalW25g+Kbukl4PPchc6zHOwoqbP5sy2B3Zy73E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id A5B7B68AFE; Thu, 27 Jun 2024 07:31:24 +0200 (CEST)
Date: Thu, 27 Jun 2024 07:31:24 +0200
From: Christoph Hellwig <hch@lst.de>
To: Alistair Popple <apopple@nvidia.com>
Cc: dan.j.williams@intel.com, vishal.l.verma@intel.com,
	dave.jiang@intel.com, logang@deltatee.com, bhelgaas@google.com,
	jack@suse.cz, jgg@ziepe.ca, catalin.marinas@arm.com,
	will@kernel.org, mpe@ellerman.id.au, npiggin@gmail.com,
	dave.hansen@linux.intel.com, ira.weiny@intel.com,
	willy@infradead.org, djwong@kernel.org, tytso@mit.edu,
	linmiaohe@huawei.com, david@redhat.com, peterx@redhat.com,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
	nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
	jhubbard@nvidia.com, hch@lst.de, david@fromorbit.com
Subject: Re: [PATCH 03/13] fs/dax: Refactor wait for dax idle page
Message-ID: <20240627053124.GC14837@lst.de>
References: <cover.66009f59a7fe77320d413011386c3ae5c2ee82eb.1719386613.git-series.apopple@nvidia.com> <cdbf5489af735e0ad95beab6b4b13d3a2f75745f.1719386613.git-series.apopple@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cdbf5489af735e0ad95beab6b4b13d3a2f75745f.1719386613.git-series.apopple@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Jun 27, 2024 at 10:54:18AM +1000, Alistair Popple wrote:
> A FS DAX page is considered idle when its refcount drops to one. This
> is currently open-coded in all file systems supporting FS DAX. Move
> the idle detection to a common function to make future changes easier.
> 
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> Reviewed-by: Jan Kara <jack@suse.cz>

I'm pretty sure I already review this ages ago, but:

Reviewed-by: Christoph Hellwig <hch@lst.de>


