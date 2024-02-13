Return-Path: <linux-fsdevel+bounces-11315-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 596F7852973
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 07:55:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 115D61F2520F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 06:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F6711775F;
	Tue, 13 Feb 2024 06:55:26 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6CD17738;
	Tue, 13 Feb 2024 06:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707807325; cv=none; b=s33hCAGYB1UVA4N+SZkoRAp5pK9DhYCubsY4wzT5Kn4/UdX++dvex43xmTYT3qOLWq1vJNIEOhdmoZz0mMUT11MrcCi6LMliKWzUjZZbLBxGBdw1K1CBQSIuH2/OPahB54ysAX+C41+dW8h3v0koDJN5OkNB0ShBP7VZLRasbYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707807325; c=relaxed/simple;
	bh=sJndHr+QR3Sb0xFn88/CCsJXnbajrdSNA3G1r0JM6JE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=daPIBOkTGZHXGEI5rfWRaDoP9IpgviX3tlvJ8PvX5+2p3nhr5MM1mv70aZKn8jHFYPNGwnCGiZK1nnYocGParP+8o3Ye7MvuoCjUHrZiluJCP35ZMeOBO0JiNE0BxzOdg+1fI/kUUtWwrODcpperLLCG0PgiSuLjPov7ouWVBuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 498E9227A87; Tue, 13 Feb 2024 07:55:19 +0100 (CET)
Date: Tue, 13 Feb 2024 07:55:18 +0100
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>, hch@lst.de,
	viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com,
	jack@suse.cz, chandan.babu@oracle.com, martin.petersen@oracle.com,
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
	ojaswin@linux.ibm.com
Subject: Re: [PATCH 1/6] fs: iomap: Atomic write support
Message-ID: <20240213065518.GA23539@lst.de>
References: <20240124142645.9334-1-john.g.garry@oracle.com> <20240124142645.9334-2-john.g.garry@oracle.com> <20240202172513.GZ6226@frogsfrogsfrogs> <2f91a71e-413b-47b6-8bc9-a60c86ed6f6b@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f91a71e-413b-47b6-8bc9-a60c86ed6f6b@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Feb 05, 2024 at 11:29:57AM +0000, John Garry wrote:
>>
>> Also, what's the meaning of REQ_OP_READ | REQ_ATOMIC? 
>
> REQ_ATOMIC will be ignored for REQ_OP_READ. I'm following the same policy 
> as something like RWF_SYNC for a read.

We've been rather sloppy with these flags in the past, which isn't
a good thing.  Let's add proper checking for new interfaces.


