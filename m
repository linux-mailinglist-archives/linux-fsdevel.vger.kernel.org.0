Return-Path: <linux-fsdevel+bounces-45200-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC630A748AB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Mar 2025 11:49:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67BCA7A8029
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Mar 2025 10:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88763212FAB;
	Fri, 28 Mar 2025 10:48:53 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A674A35;
	Fri, 28 Mar 2025 10:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743158933; cv=none; b=LXeHYoidACCzWZ9HJMGHCSRDh3bj+LyACszODAY4ZGJXTnPjD24h5XxURGE/JvHmXZCJpIouSpMPcfNUJoLEFWjC8FP1tegZWUss7YvcTmkEA2l7UK3uzZaAeHTC2CxLEfF3R1qBFkuOFcrqfQC/J6b6q5jiv6ZMmFoJ5eGLtjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743158933; c=relaxed/simple;
	bh=QgKdoBWk7QD3E5WTAmGmmymcekklr+ZQjra68hLljTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gztxHTB34GbfgeREKcX+4ZrKHOEbkfFlaDD48TukCDUCkZ9ipEnCppCsAhxRvBrqNZKvL0COL8vFooS2xW6m7nNNrV/PgVCpVcVjp+lo4uEOCmKNpqyofMrOLZjMwooljUuMKYtdn5HNoUcfmXnMapalEdEHRUQhX9IAuT0/I14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1504D68AA6; Fri, 28 Mar 2025 11:48:47 +0100 (CET)
Date: Fri, 28 Mar 2025 11:48:46 +0100
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, brauner@kernel.org,
	djwong@kernel.org, dchinner@redhat.com,
	linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
	linux-ext4@vger.kernel.org
Subject: Re: [PATCH] iomap: Fix conflicting values of iomap flags
Message-ID: <20250328104846.GB19460@lst.de>
References: <20250327170119.61045-1-ritesh.list@gmail.com> <8f1fc565-9bbb-4bbb-ab53-3c47808ef257@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f1fc565-9bbb-4bbb-ab53-3c47808ef257@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Mar 27, 2025 at 10:04:14PM +0000, John Garry wrote:
> Just my opinion - and others will prob disagree - but I think that the 
> reason this was missed (my fault, though) was because we have separate 
> grouping of flags within the same struct member. Maybe having separate 
> flags altogether would help avoid this.

Yes.  But going down to less than 16 bit fields also has downsides, as
does growing the struture.


