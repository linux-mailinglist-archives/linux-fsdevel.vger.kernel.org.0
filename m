Return-Path: <linux-fsdevel+bounces-66431-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11AEDC1EB85
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 08:17:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0E25188A12A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 07:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F311B336EE0;
	Thu, 30 Oct 2025 07:17:17 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109971F94A;
	Thu, 30 Oct 2025 07:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761808637; cv=none; b=gCTCYlkYS0Cpv1MH/cWBhXk0ykO7e4OzTXy3rClYORif3naUScd3JtREnlQUetM/eOGAnHt53wPg/Roquy1pSPZtLZh3/irr9JxMHoRXmBjYQ+HvbyIdrjmz9XS39S2n/DGyMLd4efqsOav4QPqck6CE1Oa8gUjfl1iReFBEquE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761808637; c=relaxed/simple;
	bh=8uRlq+SbspksWFkT1wMSIrwdVnN8DH0lxshYdD8Ei40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bIeuOAbnC+kMamT+KmLZsCfgWMYC7mR5N4q+ZINnjWb2lqOKCkTfGCyT8a5fbCKfXb7DVE7fWQ6e+skHZb77mI+OkR6dcrgJJBfsXhNp8qbLB12q7AHL50HPbEa4HGgxYy7qrBSXnqYsOkIzxndD+lpDxrTovdfwxi2VwLypSp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id D626D227AAA; Thu, 30 Oct 2025 08:17:04 +0100 (CET)
Date: Thu, 30 Oct 2025 08:17:04 +0100
From: Christoph Hellwig <hch@lst.de>
To: Qu Wenruo <wqu@suse.com>
Cc: Christoph Hellwig <hch@lst.de>, "Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-raid@vger.kernel.org,
	linux-block@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 4/4] xfs: fallback to buffered I/O for direct I/O when
 stable writes are required
Message-ID: <20251030071704.GA14027@lst.de>
References: <20251029071537.1127397-5-hch@lst.de> <20251029155306.GC3356773@frogsfrogsfrogs> <20251029163555.GB26985@lst.de> <8f384c85-e432-445e-afbf-0d9953584b05@suse.com> <20251030055851.GA12703@lst.de> <04db952d-2319-4ef9-8986-50e744b00b62@gmx.com> <20251030064917.GA13549@lst.de> <a44566d9-4fef-43cc-b53e-bd102724344a@suse.com> <20251030065504.GB13617@lst.de> <c3512f2a-f995-4642-8eb9-a227890ba856@suse.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3512f2a-f995-4642-8eb9-a227890ba856@suse.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Oct 30, 2025 at 05:44:22PM +1030, Qu Wenruo wrote:
> Because for whatever reasons, although the only reason I can come up with 
> is performance.
>
> I thought the old kernel principle is, providing the mechanism not the 
> policy.
> But the fallback-to-buffered looks more like a policy, and if that's the 
> case user space should be more suitable.

I don't think so.  O_DIRECT really is a hint.  We already do fallbacks
for various reasons (for XFS e.g. unaligned writes on COW files), and
btrfs in fact falls back for any alignment mismatch already.  And there's
really nothing an application can do when the most optimal way is not
available except for using a less optimal one.  So there's really no
value add for an option to fail.


