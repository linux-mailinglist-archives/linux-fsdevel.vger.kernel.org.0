Return-Path: <linux-fsdevel+bounces-26840-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E94395C023
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 23:24:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 725961C20BA2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 21:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EF9A1D1724;
	Thu, 22 Aug 2024 21:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="3ekiuWiF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455C2171A7;
	Thu, 22 Aug 2024 21:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724361832; cv=none; b=G5VBo4PUFP6e9XPguWDTkvStNCnVUWVytFESe3cpR7TxL9z30ac5vNqJYbByFNiW2f8W4WEJ3rtrfDh82LTk2vUBEZEQ09eA8B+RCqc+NwHkW/emH9GqFkovU6CUaAHOE3xTkGFEwIqH1hLvgJASsdO8VaZ+shUpiNDkPSFjCpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724361832; c=relaxed/simple;
	bh=HN1xBVZLE3f1sAjk8xE5JEoHDgbt0F1gZsiaf4ullkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=usIdeL+TlesZGmmBW5e9+bHlR2uPPYs5XXfDQjZDCawMSzcTLDZ3NLFI0DaZE734UO1cS38WYtWnQBr1Rv8UyNR2dyjarJ97fV0pWQFgPNRY9hr0y9AR8Zb0nHp2vgtxiN6riMb5yw/nbO9qUb2CW7pTjdCW+ZIUybQIsnkesdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=3ekiuWiF; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=OvL0cDQRRZcsjqitDDNhwyuFsI+775ltV1T5OI53uko=; b=3ekiuWiFd1cyQXu09+aZB8desx
	MdgicvngIggXnCHUlmvJWT44SmXVmzDwNgo3KErf8cBlbVctfEy4ZR0623bvubOgNTKh3wrHrjS+A
	Dm5P8OEbvCp7nd8tbvqjungtvDzhVMbQ9Ubmun5qws+oeLX5eAG68mHwxf6eKvb2ed7Q4dQbyTG2Y
	lLxkXQNwbhiabt++fmczf+PZ6b/++ZGdVRdYz3RJZo57iAwpR913ThIENwQ8gK11ajbeHLafcsUk8
	+iKNgkQh4D+p1baO2PW8AXkNsgy2FVWHxBOrxWjc7MSdZXojzKCdWbM03duSoRcEbj6FHKLap8wYS
	i4ulvt6A==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shFHW-0000000ELWk-1g5D;
	Thu, 22 Aug 2024 21:23:46 +0000
Date: Thu, 22 Aug 2024 14:23:46 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chandan Babu R <chandan.babu@oracle.com>,
	"Darrick J. Wong" <djwong@kernel.org>
Cc: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,
	linux-fsdevel@vger.kernel.org, hare@suse.de, gost.dev@samsung.com,
	linux-xfs@vger.kernel.org, hch@lst.de, david@fromorbit.com,
	Zi Yan <ziy@nvidia.com>, yang@os.amperecomputing.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	willy@infradead.org, john.g.garry@oracle.com,
	cl@os.amperecomputing.com, p.raghav@samsung.com,
	ryan.roberts@arm.com, mcgrof@kernel.org
Subject: Re: [PATCH v13 00/10] enable bs > ps in XFS
Message-ID: <ZsesYqVivEAToPUI@bombadil.infradead.org>
References: <20240822135018.1931258-1-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822135018.1931258-1-kernel@pankajraghav.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Thu, Aug 22, 2024 at 03:50:08PM +0200, Pankaj Raghav (Samsung) wrote:
> From: Pankaj Raghav <p.raghav@samsung.com>
> 
> This is the 13th version of the series that enables block size > page size
> (Large Block Size) experimental support in XFS. Please consider this for
> the inclusion in 6.12.

Christian, Andrew,

we believe this is ready for integration, and at the last XFS BoF we
were wondering what tree this should go through. I see fs-next is
actually just a branch on linux-next with the merge of a few select
trees [0], but this touches mm, so its not clear what tree would be be
most appropriate to consider.

Please let us know what you think, it would be great to get this into
fs-next somehow to get more exposure / testing.

[0] https://lore.kernel.org/all/20240528091629.3b8de7e0@canb.auug.org.au/

  Luis

