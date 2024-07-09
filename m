Return-Path: <linux-fsdevel+bounces-23360-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F4D892B176
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 09:48:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFAF21F22D0A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 07:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAD9714D2AB;
	Tue,  9 Jul 2024 07:48:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC031494BD;
	Tue,  9 Jul 2024 07:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720511287; cv=none; b=OKnGSaAVBx4AIDgfOPwn49P+sHVT0v6GGBGOeaf37kEIqU4zWa6xFWXQZUOL9MbS9rDCuxLJGC1jwhhdFqvmnA6/h2N28nYw0/Kcx+BNm7EOLCxsgl2LRyEaIywqqj70ic9WYLKcEH+b5izIidICXFV7JHQVAqSXtvZGBpG1GWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720511287; c=relaxed/simple;
	bh=xPAWDlYUYZJPGTDkyiHYFgnRNYcbG4SiBEOBj+/VNSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dKwO8wJ+2U0S1DG07T6pWHJgBzVgZsnFWNriHvISKsHVvUw/54mNZhT/Wg7bUsD+JeljKHJXGmTEVUIDBIaHDNVPftZqgjxrzeKzipeMd6gScle+8sSuVS649gR49rwSvm3ZGR9WU1XzQyqjfwGrJ77SFsdzHcqwG+xdvl0A3tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id DDA6F68AFE; Tue,  9 Jul 2024 09:48:02 +0200 (CEST)
Date: Tue, 9 Jul 2024 09:48:02 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, chandan.babu@oracle.com,
	djwong@kernel.org, dchinner@redhat.com, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	catherine.hoang@oracle.com, martin.petersen@oracle.com
Subject: Re: [PATCH v2 00/13] forcealign for xfs
Message-ID: <20240709074802.GC21491@lst.de>
References: <20240705162450.3481169-1-john.g.garry@oracle.com> <20240706075353.GA15212@lst.de> <e2799d3e-734e-4909-ba90-931799ef486a@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2799d3e-734e-4909-ba90-931799ef486a@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Jul 08, 2024 at 08:48:19AM +0100, John Garry wrote:
> I am not sure what that pain is, but I guess it's the maintainability and 
> scalability of the scattered "if RT" checks for rounding up and down to 
> larger extent size, right?
>
> For forcealign, at least we can factor that stuff mostly into common 
> forcealign+RT helpers, to keep the checks common. That is apart from the 
> block allocator code.

Maybe its just me hating all the rtalloc larger than block size
allocation granularity mess and hoping it goes away.  With this we'll
make it certain that it is not going away, but that might just have
been a faint hope.  But if we add more of it we'll at least need to
ensure it is done using common helpers and clean the existing mess up
as much as we can.

