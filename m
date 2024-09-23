Return-Path: <linux-fsdevel+bounces-29817-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 975C297E4FC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2024 05:33:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04B4428165E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2024 03:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B05ECA6F;
	Mon, 23 Sep 2024 03:33:15 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4DD79E1;
	Mon, 23 Sep 2024 03:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727062395; cv=none; b=AD4ao4/z6IWj6sBkcXadRtg9Zt17eiM1XZXyVV8N3+EzUMfaLTUxzNiz2qLI5lItHCY+6tfmgy1qMiU14PXnABeSQpOcSvRY7chskiKKO0ltT8OY+srB0IWOD/K/5GP96ai8L/4bf18h4Sdt4lq7r2b8RoRlfXasfaGaUVkIxe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727062395; c=relaxed/simple;
	bh=KIuSXjpzAJGxS/ob+rdaP1ri1Y42g4YaGiFmdFfD078=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jJOTADBV4TPSSPUvvatwdQCvrYXOosC8xs9dbtA1CAvUxStoWefQYavUybtch0PVefTdlMjf2MvMYI0ZOB7PkaqvaPvcxpp+jaqOGsUh49e9/zHDK4dxq3/hE5pNrBQGYbO8Uwf8tHLMf1rlvY72MzQlHznbp7sC6WronDWgRWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3FCF6227AAF; Mon, 23 Sep 2024 05:33:06 +0200 (CEST)
Date: Mon, 23 Sep 2024 05:33:05 +0200
From: Christoph Hellwig <hch@lst.de>
To: Dave Chinner <david@fromorbit.com>
Cc: John Garry <john.g.garry@oracle.com>,
	Ritesh Harjani <ritesh.list@gmail.com>, chandan.babu@oracle.com,
	djwong@kernel.org, dchinner@redhat.com, hch@lst.de,
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, catherine.hoang@oracle.com,
	martin.petersen@oracle.com
Subject: Re: [PATCH v4 00/14] forcealign for xfs
Message-ID: <20240923033305.GA30200@lst.de>
References: <87frqf2smy.fsf@gmail.com> <ZtjrUI+oqqABJL2j@dread.disaster.area> <877cbq3g9i.fsf@gmail.com> <ZtlQt/7VHbOtQ+gY@dread.disaster.area> <8734m7henr.fsf@gmail.com> <ZufYRolfyUqEOS1c@dread.disaster.area> <c8a9dba5-7d02-4aa2-a01f-dd7f53b24938@oracle.com> <Zun+yci6CeiuNS2o@dread.disaster.area> <8e13fa74-f8f7-49d3-b640-0daf50da5acb@oracle.com> <ZvDZHC1NJWlOR6Uf@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZvDZHC1NJWlOR6Uf@dread.disaster.area>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Sep 23, 2024 at 12:57:32PM +1000, Dave Chinner wrote:
> Ok, but that's not going to be widespread. Very little storage
> hardware out there supports atomic writes - the vast majority of
> deployments will be new hardware that will have mkfs run on it.

Just about every enterprise NVMe SSD supports atomic write size
larger than a single LBA, because it is completely natural fallout
from FTL deѕign.  That beeing said to support those SSDs a block
size of 16 or 32k would be a lot more natural than all the forcealign
madness.


