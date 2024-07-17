Return-Path: <linux-fsdevel+bounces-23865-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34CAE9340AC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 18:42:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65BA91C212D3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 16:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEAD81822C0;
	Wed, 17 Jul 2024 16:42:15 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4175D566A;
	Wed, 17 Jul 2024 16:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721234535; cv=none; b=Q4tAnsFrV/9LyRXGL6/Sm0LUe3O5rlQBOLGbU2bRsIb6u6d9YnI5vgcSW6T2b22I7ngOvvH1nb6YeCmCWAA0BkOSvF9rJlUcR0/Opd5Jz3/+FVTUMZvENE887Hrjd8+tNYCCFy3IeLCPxQ/AEJC+BuS+dLEgefueltUpFCGXmSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721234535; c=relaxed/simple;
	bh=ThJkMHF8E9fg8CiLfg11arTbFnN8zJ1I4emM39gMcCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tk44xIhyQtv1W3GZmPw2GC4VgW+ijh4GuSAXb2oa7UB9leK6jEgiX+5FkthEHCdNED8o3lqmWh04czSXVdOpqqLqGRRakqdob332JJ1OvxiV8UEBR+tGIwNR+6L5WpK6Liymbx65VLESQRDAwi+qwfAhO1NTHh96Xw/6LaLtMk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id CE73E68B05; Wed, 17 Jul 2024 18:42:04 +0200 (CEST)
Date: Wed, 17 Jul 2024 18:42:03 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, chandan.babu@oracle.com,
	djwong@kernel.org, dchinner@redhat.com, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	catherine.hoang@oracle.com, martin.petersen@oracle.com
Subject: Re: [PATCH v2 10/13] xfs: Unmap blocks according to forcealign
Message-ID: <20240717164203.GA21307@lst.de>
References: <20240705162450.3481169-1-john.g.garry@oracle.com> <20240705162450.3481169-11-john.g.garry@oracle.com> <20240706075858.GC15212@lst.de> <5e4ec78f-42e3-47cb-bf92-eddc36078edf@oracle.com> <20240709074623.GB21491@lst.de> <9c34cf12-711e-4f36-8f65-873eaabf7283@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c34cf12-711e-4f36-8f65-873eaabf7283@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Jul 17, 2024 at 04:24:28PM +0100, John Garry wrote:
>>>> new logic to it this might indeed be a good time.
>>> ok, I'll see if can come up with something
>> I can take a look too. 
>
> I was wondering what you plans are for any clean-up/refactoring here, as 
> mentioned?

Try to split all the convert left over of large rtextent / allocation
size logic out of __xfs_bunmapi and into a separate helper or two.
I started on it after writing that previous mail, but it has been
preempted by more urgent work for now.

> I was starting to look at the whole "if (forcealign) else if (big rt)" flow 
> refactoring in this series to use xfs_inode_alloc_unitsize(); however, I 
> figure that you have plans wider in scope, which affects this.

It will create a bit of conflict, but nothing out of ordinary.

