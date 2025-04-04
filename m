Return-Path: <linux-fsdevel+bounces-45739-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 04835A7B995
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 11:06:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C16F77A8099
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 09:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99CBD611E;
	Fri,  4 Apr 2025 09:06:09 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DBF916132F;
	Fri,  4 Apr 2025 09:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743757569; cv=none; b=ZULCZim+55f5bxUPsl0FdXBt4LaCg7j/UTV/wvB9RtRVDGkms6ncvnJHcQCYmHrwjl7/ckZsfuOwTLvkQ2vRXozk554hyjMnRK40if1vF5DdhUC5IXupq2h8DbM+v5Ay86OZxaUXCaGIr+ICEgB/Z18hoECS6n5LJ3LncAHYOQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743757569; c=relaxed/simple;
	bh=3KuxW5QTAuQ13ScJFuxAKFZQrv/QjQev0J4mopx8Gnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sf2KK1WZ2KS2qrBxj5kM5uB7gFw82UHDL+QNiZ6l0Ocpe/VHTx2bi/TQ2lDXfgt44b10RgGP0uYgTjsxW+K4XccqKzTvuJFkr0NLAAMwTh9rfK1IqiFOndUsWeI691rBCltp3cMorRgMgA6ja00JFcl6T6pUms4pzTNlLXTsLuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id D978A68BEB; Fri,  4 Apr 2025 11:06:01 +0200 (CEST)
Date: Fri, 4 Apr 2025 11:06:01 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, alx@kernel.org, brauner@kernel.org,
	djwong@kernel.org, dchinner@redhat.com, linux-man@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
	ritesh.list@gmail.com, martin.petersen@oracle.com,
	linux-api@vger.kernel.org
Subject: Re: [PATCH RFC] statx.2: Add stx_atomic_write_unit_max_opt
Message-ID: <20250404090601.GA12163@lst.de>
References: <20250319114402.3757248-1-john.g.garry@oracle.com> <20250320070048.GA14099@lst.de> <c656fa4d-eb76-4caa-8a71-a8d8a2ba6206@oracle.com> <20250320141200.GC10939@lst.de> <7311545c-e169-4875-bc6c-97446eea2c45@oracle.com> <20250323064029.GA30848@lst.de> <5485c1ad-8a20-40bc-aa75-68b820de5e1c@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5485c1ad-8a20-40bc-aa75-68b820de5e1c@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Apr 03, 2025 at 04:07:04PM +0100, John Garry wrote:
> So I am thinking one of these:
> a. stx_atomic_write_unit_max_dev
> b. stx_atomic_write_unit_max_bdev
> c. stx_atomic_write_unit_max_align
> d. stx_atomic_write_unit_max_hw
>
> The terms dev (or device) and bdev are already used in the meaning of some 
> members in struct statx, so not too bad. However, when we support large 
> atomic writes for XFS rtvol, the bdev atomic write limit and rtextsize 
> would influence this value (so just bdev might be a bit misleading in the 
> name).

Don't.  Especially when you have a natively out of write file system
that optimized case will not involve the usual hardware offload.


