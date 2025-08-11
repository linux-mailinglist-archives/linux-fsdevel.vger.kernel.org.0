Return-Path: <linux-fsdevel+bounces-57332-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C6B5B20855
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 14:06:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEC4E424B87
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 12:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6176F2D3751;
	Mon, 11 Aug 2025 12:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E3LwUshb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B6B1DE8BE;
	Mon, 11 Aug 2025 12:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754913985; cv=none; b=J13tdZcltaCmSAovvJ18nROlkDeAWyg1DE44awDFKJRnSEHlYyDKVlo9QuNEXyUkAO3XpE60n7MdO9uw1Id8HXQEkj16hG7V9o8x8C3sX2N31QRYJC1cRVdYF03hXCYrr8N5rOiLCLoN2MChCdYP1kt+WBY38nSXbNc6q67xjCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754913985; c=relaxed/simple;
	bh=o2YJG+MeGWtvu1qgNMDBrtl/83Z8YV0DO1VakB5ngI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hszTvHI5iSugosEWVlWHDDHdNYnfeWnh8zztmU4TzISTNHfp7gWwhNZ+LSps04r0JmGleSfl5JLxj4S7tHu/FiltdxDn9l3fArwfcoWcjSpw0XhsmiAqf8TmSwgWT51XpUYDfn8EKqN0Nxy5yvAEqN1E/VUs7Kj8FM1qCwxfkg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E3LwUshb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57797C4CEED;
	Mon, 11 Aug 2025 12:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754913985;
	bh=o2YJG+MeGWtvu1qgNMDBrtl/83Z8YV0DO1VakB5ngI0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E3LwUshbwWZotC1ig6EK0DIsBqHCyP7qRBuW0JrW3nfiIPb0uodDgMl6I5AEVQ4Fc
	 X8AuzuftlqADwU3aG6ESsnTVCGqlRTcOt4y7ZOtVRiZd7zvon/E9vB5iiJveUfZequ
	 8ljZarxt3phIlvW6P4J637tOJAbZGWF6v2pjxO46oCEbTAy+cB7i+AhBmTv3aZ3Yk1
	 kCrmTQ4XCfs07gD9DqNazsoWPEvwFL0iE+vMOnLeIziB6MfY7MUMHGMuq5M5VLhtCE
	 3T+90WkKj9hWNbE2jpYI6riW/N3cYBwn7s9XiIqsU5eD4NmQ+Yw/lZXLgO3/KBUeGE
	 HUq5Jj4IbdSWA==
Date: Mon, 11 Aug 2025 14:06:19 +0200
From: Carlos Maiolino <cem@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: djwong@kernel.org, hch@lst.de, dan.j.williams@intel.com, 
	willy@infradead.org, jack@suse.cz, brauner@kernel.org, viro@zeniv.linux.org.uk, 
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] xfs and DAX atomic writes changes
Message-ID: <rnils56yqukku5j5t22ac5zru7esi35beo25nhz2ybhxqks5nf@u2xt7j4biinr>
References: <20250724081215.3943871-1-john.g.garry@oracle.com>
 <IjNvoQKwdHYKQEFJpk3MZtLta5TfTNXqa5VwODhIR7CCUFwuBNcKIXLDbHTYUlXgFiBE24MFzi8WAeK6AletEA==@protonmail.internalid>
 <32397cf6-6c6a-4091-9100-d7395450ae02@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32397cf6-6c6a-4091-9100-d7395450ae02@oracle.com>

On Wed, Aug 06, 2025 at 10:15:10AM +0100, John Garry wrote:
> On 24/07/2025 09:12, John Garry wrote:
> 
> Hi Carlos,
> 
> I was expecting you to pick these up.

I did, for -rc1.

> 
> Shall I resend next week after v6.17-rc1 is released?

No, I already have them queued up for -rc1, no need to send them again

Carlos

> 
> Thanks,
> John
> 
> > This series contains an atomic writes fix for DAX support on xfs and
> > an improvement to WARN against using IOCB_ATOMIC on the DAX write path.
> >
> > Also included is an xfs atomic writes mount option fix.
> >
> > Based on xfs -next at ("b0494366bd5b Merge branch 'xfs-6.17-merge' into
> > for-next")
> >
> > John Garry (3):
> >    fs/dax: Reject IOCB_ATOMIC in dax_iomap_rw()
> >    xfs: disallow atomic writes on DAX
> >    xfs: reject max_atomic_write mount option for no reflink
> >
> >   fs/dax.c           |  3 +++
> >   fs/xfs/xfs_file.c  |  6 +++---
> >   fs/xfs/xfs_inode.h | 11 +++++++++++
> >   fs/xfs/xfs_iops.c  |  5 +++--
> >   fs/xfs/xfs_mount.c | 19 +++++++++++++++++++
> >   5 files changed, 39 insertions(+), 5 deletions(-)
> >
> 
> 

