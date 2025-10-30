Return-Path: <linux-fsdevel+bounces-66419-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31C69C1E7AD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 06:59:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B82818917F1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 05:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B064F31A049;
	Thu, 30 Oct 2025 05:58:58 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE4317736;
	Thu, 30 Oct 2025 05:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761803938; cv=none; b=bYbc3C83/9j1LqIMD6knIxNo6dcZU5LKi5K8D+9mGQhnsu55PT/1FSj8wctMbrukK/LqAl6AOlGAycljn+UJ0hsqgi72Cn8hr7WWNhy3Mq6S5HLWfULbn1E99Y0yPz3Tgra0O3RIaJgkl0SI7VQSz0p/vcuotcr5jLgRbQB9Xpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761803938; c=relaxed/simple;
	bh=GBlgjLNeJz65AJOmnVZrgtZCqCiQlYkuYzXXuncYbGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bzcVOaZ2AsmTF6V4ApmCE47ldFVlgiWB2WEwhL997duCDni7OW2eYRDiFZnR5XzxyqtUD/UNXqBPmd9EQNf1ppnWR40QBk9K9m/6COZLMvW1RRpjK+HlL4TmAWPe7I+x+qmerynIb2AymCdqlGJqU1nPykpqEyuBKcADQVOQsF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 83FC2227AAA; Thu, 30 Oct 2025 06:58:51 +0100 (CET)
Date: Thu, 30 Oct 2025 06:58:51 +0100
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
Message-ID: <20251030055851.GA12703@lst.de>
References: <20251029071537.1127397-1-hch@lst.de> <20251029071537.1127397-5-hch@lst.de> <20251029155306.GC3356773@frogsfrogsfrogs> <20251029163555.GB26985@lst.de> <8f384c85-e432-445e-afbf-0d9953584b05@suse.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f384c85-e432-445e-afbf-0d9953584b05@suse.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Oct 30, 2025 at 07:53:30AM +1030, Qu Wenruo wrote:
> Yep, a common helper will help, or even integrate the check into 
> __iomap_dio_rw().

Having the check in __iomap_dio_rw would be a last resort, because at
the point we've already done direct I/O specific locking we'd need to
unwind from, making the fallback slower than we'd have to.

> However I'm not sure if a warning will be that useful.
>
> If the warning is only outputted once like here, it doesn't show the ino 
> number to tell which file is affected.
> If the warning is shown every time, it will flood the dmesg.

While the flag is set on the address_space it is global (or semi global
for separate storage pools like the XFS RT device), so the inode number
doesn't really matter too much.

> It will be much straightforward if there is some flag allowing us to return 
> error directly if true zero-copy direct IO can not be executed.

I don't really understand this part.


