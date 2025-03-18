Return-Path: <linux-fsdevel+bounces-44249-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30E97A6696E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 06:32:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4499F3B488D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 05:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FF6D1DB37B;
	Tue, 18 Mar 2025 05:32:24 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5D32B9A4;
	Tue, 18 Mar 2025 05:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742275944; cv=none; b=DY6hV1E4cU5qrY5P7YFN0KWWg3wBVPSP1zoIxTixQHERhBERr/KUOsNNdq6oIx4pWcFsuL99J6uYBAgwMWfO8SiaQ8/B0/nnLgLTGUwoYyLJmePb2qy1RUuThlHQURK1e4Bh5NxhP98Lt04LM+G84f/o1bB58i2ZNM34AZ7tMLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742275944; c=relaxed/simple;
	bh=6l+9IrKq4dwxEBrNt17jjEPqyp2nvJ5QfK5S4nlyBLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oOUPwMDbvDiETRewZZ17OmKTRJTWcv9fMbrQUDkuU5XqQoLvsXar/YPa/5TqgMkTZdre0DPCSHSqCmJQ8Avg8xs6sZV1BbY1XRgEltdS20aNNjXSXHwXai7qd29Z9sqkkaKxwyjyqycV8tsBQI29JSymkPnLseax/KFN0Pfgh3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id CB39B68AA6; Tue, 18 Mar 2025 06:32:14 +0100 (CET)
Date: Tue, 18 Mar 2025 06:32:14 +0100
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, brauner@kernel.org, djwong@kernel.org,
	cem@kernel.org, dchinner@redhat.com, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	ojaswin@linux.ibm.com, ritesh.list@gmail.com,
	martin.petersen@oracle.com, tytso@mit.edu,
	linux-ext4@vger.kernel.org
Subject: Re: [PATCH v6 03/13] iomap: rework IOMAP atomic flags
Message-ID: <20250318053214.GA14470@lst.de>
References: <20250313171310.1886394-1-john.g.garry@oracle.com> <20250313171310.1886394-4-john.g.garry@oracle.com> <20250317061116.GC27019@lst.de> <87cf27a2-6bbb-4073-b150-c4d07e382032@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87cf27a2-6bbb-4073-b150-c4d07e382032@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Mar 17, 2025 at 09:05:39AM +0000, John Garry wrote:
>> Same here (at least for now until it is changed later).
>
> Please note that Christian plans on sending the earlier iomap changes 
> related to this work for 6.15. Those changes are also in the xfs queue. We 
> are kinda reverting those changes here, so I think that it would still make 
> sense for the iomap changes in this series to make 6.15
>
> The xfs changes in this series are unlikely to make 6.15
>
> As such, if we say that ext4 always uses hardware atomics, then we should 
> mention that xfs does also (until it doesn't).

That's what I meant.

> So, in the end, I'd rather not add those comments at all - ok?

If I read through this code it would be kinda nice to figure out why
we're instructing the iomap code to do it.  If you look at
xfs_direct_write_iomap_begin it also generally comments on why we
set specific flags.


