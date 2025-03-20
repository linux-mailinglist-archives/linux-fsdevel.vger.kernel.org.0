Return-Path: <linux-fsdevel+bounces-44516-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49959A6A00F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 08:01:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB29C4625CF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 07:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B38991EE01A;
	Thu, 20 Mar 2025 07:01:01 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898A3819;
	Thu, 20 Mar 2025 07:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742454061; cv=none; b=ajXBNQyYO+mP6FYAKgPHxBxbtO0cfa5pBwWKuBP9ERFTu6SQRazbVzOsLnl4k3RZJjw2f1AdFhC+8PBjtOHbMHWgiIm6wqicp+ua3GwvXx+VcInD2nNnxryWed8W3cLkeagw5kA0KtXTzttoE1DNmxGMQShJ1piR1kbrZVUC0bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742454061; c=relaxed/simple;
	bh=+z2wZPLFas1paqJW6IdM/iwi6AbcV2FdZfJRNwc5JKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N7Ch6/XVx3/02+a+1oQXefNwfjrq/WrAVEh+HVYiTgFAZvgUpp1/9DZTiveiGrUi0GYg0A+IfURDaLjmKRhHx0dLI4XuhZvK6QiGfHJRYe7gpxdaH0KoVisFZh6g2UAM+8x6uvbh3w5LdtUGzbdLUXAfUkPHEXZh2Mu0QxszSDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 527E168D12; Thu, 20 Mar 2025 08:00:50 +0100 (CET)
Date: Thu, 20 Mar 2025 08:00:48 +0100
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: alx@kernel.org, brauner@kernel.org, djwong@kernel.org,
	dchinner@redhat.com, hch@lst.de, linux-man@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
	ritesh.list@gmail.com, martin.petersen@oracle.com
Subject: Re: [PATCH RFC] statx.2: Add stx_atomic_write_unit_max_opt
Message-ID: <20250320070048.GA14099@lst.de>
References: <20250319114402.3757248-1-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319114402.3757248-1-john.g.garry@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Mar 19, 2025 at 11:44:02AM +0000, John Garry wrote:
> XFS supports atomic writes - or untorn writes - based on different methods:
> - HW offload in the disk
> - Software emulation
> 
> The value reported in stx_atomic_write_unit_max will be the max of the
> software emulation method.

I don't think emulation is a good word.  A file system implementing
file systems things is not emulation.

> We want STATX_WRITE_ATOMIC to get this new member in addition to the
> already-existing members, so mention that a value of 0 means that
> stx_atomic_write_unit_max holds this limit.

Does that actually work?  Can userspace assume all unknown statx
fields are padded to zero?  If so my dio read align change could have
done away with the extra flag.


