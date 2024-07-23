Return-Path: <linux-fsdevel+bounces-24140-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB7EB93A300
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jul 2024 16:42:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 967D61F23333
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jul 2024 14:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51B19155A24;
	Tue, 23 Jul 2024 14:42:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3317B155751;
	Tue, 23 Jul 2024 14:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721745725; cv=none; b=VCExgZ5ae4tBBfMMZ6gdnrKWxRgDvR7YqQmP5O030c7qi/wLITwA1zGRZ6lyQIWZgtZ/3J9iJBT4psYnNk6awFCCx4WhBrxbQjWca3/pygjZbDSOZN6Ad/KdVny7srXBuESThEUGlYXIT8VoLYG1CnfMReBnARIGV6NuvKcKwVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721745725; c=relaxed/simple;
	bh=YIGe83xUWoYQ+eBNbS2084u5LKbTAKdKECMqEm1BAd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eqTCdUnYGBSklDg4yHPhCV3zyW70THLxlX6Dkr6fApI9vxfv8o6S5DyPYFC7Dkmdzt2sK9EfjbbCVGGx0SYDRRiFmCYPvoLf2ryHfYQ2dnSdlDpnkXgxH/FAlfE0Dq5IHch66npUHZ//gqWEoj/SMFS4LOejsAtntvsuCUNvi30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2E40F68AA6; Tue, 23 Jul 2024 16:42:00 +0200 (CEST)
Date: Tue, 23 Jul 2024 16:42:00 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: Dave Chinner <david@fromorbit.com>,
	"Darrick J. Wong" <djwong@kernel.org>, chandan.babu@oracle.com,
	dchinner@redhat.com, hch@lst.de, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	catherine.hoang@oracle.com, martin.petersen@oracle.com
Subject: Re: [PATCH v2 07/13] xfs: Introduce FORCEALIGN inode flag
Message-ID: <20240723144159.GB20891@lst.de>
References: <20240705162450.3481169-1-john.g.garry@oracle.com> <20240705162450.3481169-8-john.g.garry@oracle.com> <20240711025958.GJ612460@frogsfrogsfrogs> <ZpBouoiUpMgZtqMk@dread.disaster.area> <0c502dd9-7108-4d5f-9337-16b3c0952c04@oracle.com> <bdad6bae-3baf-41de-9359-39024dba3268@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bdad6bae-3baf-41de-9359-39024dba3268@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Jul 23, 2024 at 11:11:28AM +0100, John Garry wrote:
> I am looking at something like this to implement read-only for those inodes:

Yikes.  Treating individual inodes in a file systems as read-only
is about the most confusing and harmful behavior we could do.

Just treat it as any other rocompat feature please an mount the entire
file system read-only if not supported.

Or even better let this wait a little, and work with Darrick to work
on the rextsize > 1 reflіnk patches and just make the thing work.

>> So what about forcealign and RT?
>
> Any opinion on this?

What about forcealign and RT? 


