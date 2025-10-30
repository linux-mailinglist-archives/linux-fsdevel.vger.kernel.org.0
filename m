Return-Path: <linux-fsdevel+bounces-66427-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA1F8C1EA06
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 07:49:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 401D319C1801
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 06:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F4B0327208;
	Thu, 30 Oct 2025 06:49:25 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0CAE2749E4;
	Thu, 30 Oct 2025 06:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761806964; cv=none; b=ixXtrNXmVs091OJaCKAi5zpk5F9UORzYW3efxRBQiIyYunvLDJWtbJppDLk6jSZE/RL1RV8FJ6Xue+mnULC9q1xveCzzTifunRfTMDm1d2bWMSESrDcGGmu1XUG7qAcByUyWDAS9S9u+rvRw9cwklEmuWVNamig58a+bz3+dJwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761806964; c=relaxed/simple;
	bh=6SZNa87ok9VyHmObe9a0C5xvbbYd+NW+LC5odyq19CU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a/Byj+ezKFffiVs8vEZFYoS9g1Ia54v330x6g8plnI25m6nRuM8py5fLM4m1kJYESzaHtPZuOc+hralW60+kBWROLbxQtmIN/FF3POuuKrMjLa7AgJZOhFsCO5HUZIc0cWKd5jeazmLvobSuGY3/iz5dJzkRtlkV2HQ/HwyBbeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1DAB0227AAA; Thu, 30 Oct 2025 07:49:18 +0100 (CET)
Date: Thu, 30 Oct 2025 07:49:17 +0100
From: Christoph Hellwig <hch@lst.de>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Christoph Hellwig <hch@lst.de>, Qu Wenruo <wqu@suse.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-raid@vger.kernel.org,
	linux-block@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 4/4] xfs: fallback to buffered I/O for direct I/O when
 stable writes are required
Message-ID: <20251030064917.GA13549@lst.de>
References: <20251029071537.1127397-1-hch@lst.de> <20251029071537.1127397-5-hch@lst.de> <20251029155306.GC3356773@frogsfrogsfrogs> <20251029163555.GB26985@lst.de> <8f384c85-e432-445e-afbf-0d9953584b05@suse.com> <20251030055851.GA12703@lst.de> <04db952d-2319-4ef9-8986-50e744b00b62@gmx.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04db952d-2319-4ef9-8986-50e744b00b62@gmx.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Oct 30, 2025 at 05:07:44PM +1030, Qu Wenruo wrote:
> I mean some open flag like O_DIRECT_NO_FALLBACK, then we can directly 
> reutrn -ENOBLK without falling back to buffered IO (and no need to bother 
> the warning of falling back).
>
> This will provide the most accurate, true zero-copy for those programs that 
> really require zero-copy.
>
> And we won't need to bother falling back to buffered IO, it will be 
> something for the user space to bother.

So what is your application going to do if the open fails?

>
> Thanks,
> Qu
---end quoted text---

