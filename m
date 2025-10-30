Return-Path: <linux-fsdevel+bounces-66484-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B608BC20A76
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 15:40:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 759B5422469
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 14:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E043227B343;
	Thu, 30 Oct 2025 14:35:57 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A04278753;
	Thu, 30 Oct 2025 14:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761834957; cv=none; b=SJYSYDUiG3vCmkGg1+oPYwrGRUG4i4xln/QEbyF8rcj0hYozvrp6v0wkFaV+APOr2GsYLGovomy/O6t2bFZsydPYgnIWyO5c48wgvJpwbxwJ1eu+DREA/7H2xotaHurOGazFP0bL+eshNS11O+wnpkQmXUDF2i8oQWMqY60YPVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761834957; c=relaxed/simple;
	bh=8eyfAvSRipMEp2JX7NAR77Qoz5T5m7hr12qeI65XIFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oxNhWkw7DywYHbHWCrTBUunF/UX7e8i3nJcaLPuAvAF+lNVXzHXzHy7sxkk3qKJ7Of4k6lkUIwHhVMOF0gEKqYWu+uO9ZvNnN6H6nAMCpP3PCeJDDUJ2uLtLzePGi7VpY9M3RapqTYnmtRD+V3YfYyV9qbqkNjBTYWxoIbkwFsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 83BBC227A88; Thu, 30 Oct 2025 15:35:50 +0100 (CET)
Date: Thu, 30 Oct 2025 15:35:50 +0100
From: Christoph Hellwig <hch@lst.de>
To: Geoff Back <geoff@demonlair.co.uk>
Cc: Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@lst.de>,
	Carlos Maiolino <cem@kernel.org>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-raid@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: Re: fall back from direct to buffered I/O when stable writes are
 required
Message-ID: <20251030143550.GB31550@lst.de>
References: <20251029071537.1127397-1-hch@lst.de> <aQNJ4iQ8vOiBQEW2@dread.disaster.area> <5ac7fb86-07a2-4fc6-959e-524ff54afebf@demonlair.co.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5ac7fb86-07a2-4fc6-959e-524ff54afebf@demonlair.co.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Oct 30, 2025 at 12:00:26PM +0000, Geoff Back wrote:
> I don't claim to have deep knowledge of what's going on here, but if I
> understand correctly the problem occurs only if the process submitting
> the direct I/O is breaking the semantic "contract" by modifying the page
> after submitting the I/O but before it completes.

Except that there never has been any such "contract", written or
unwritten.  Modifying in-flight I/O is perfectly fine IFF the data
is sampled once as in the usual non-checksum non-RAID mode, and nothing
ever told applications not to do it.

>   Since the page
> referenced by the I/O is supposed to be immutable until the I/O
> completes, what about marking the page read only at time of submission
> and restoring the original page permissions after the I/O completes? 
> Then if the process writes to the page (triggering a fault) make a copy
> of the page that can be mapped back as writeable for the process - i.e.
> normal copy-on-write behaviour - and write a once-per-process dmesg
> warning that the process broke the direct I/O "contract".

That would be nice, but also pretty hard.  See various previous
discussions on this topic.  Also at least for small I/O it probably
is more expensive than bounce buffering while for large enough I/O,
especially using PMD mappings or similar avoiding the copy will be
very beneficial.


