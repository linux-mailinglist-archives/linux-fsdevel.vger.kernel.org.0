Return-Path: <linux-fsdevel+bounces-44254-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F10CA669C3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 06:47:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7983117BB8C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 05:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21FF01A7045;
	Tue, 18 Mar 2025 05:47:25 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5465046B8;
	Tue, 18 Mar 2025 05:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742276844; cv=none; b=dZisKRaWJHqSK2o2O7NvjKm8JyYyCb3IJud6+L7FAwZMvPPYsVlZYRqGYruEDo7I2SHmqR1D31IUrK4Q61f85sr0q1Xxuuw/EdvqlRvwyAo+Yvh0TyXdGv3aUz+fkOYTe/viKZXk9dzRA4EOHHrY8JdXXZpL/lU5+YNx+ul9H8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742276844; c=relaxed/simple;
	bh=zrI6UuHwmKiy6F5ujQ/ndIu6Y0yHbxRqunrh5r7VlB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CHNv/KwehJ2p1yX+MF+G39k1FpNt9iaF/nBi184qafjkcNnuU8GiyTs6Q3/ziCcPku5NviTgHShnzDhu6RXaOfEeq7gKUtywPzwlJ5GEGLmxUrYdoF9ItKoxWCbyVUEPvLXWHlEgbuOKo9XK4f5tFdwR71r3Uo5wKIXUDiprH8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 778EB68B05; Tue, 18 Mar 2025 06:47:18 +0100 (CET)
Date: Tue, 18 Mar 2025 06:47:18 +0100
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: brauner@kernel.org, djwong@kernel.org, cem@kernel.org,
	dchinner@redhat.com, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	ojaswin@linux.ibm.com, ritesh.list@gmail.com,
	martin.petersen@oracle.com, tytso@mit.edu,
	linux-ext4@vger.kernel.org, Carlos Maiolino <cmaiolino@redhat.com>
Subject: Re: [PATCH v6 13/13] xfs: update atomic write max size
Message-ID: <20250318054718.GA14895@lst.de>
References: <20250313171310.1886394-1-john.g.garry@oracle.com> <20250313171310.1886394-14-john.g.garry@oracle.com> <Z9fOcFB5dhpK4Lsw@infradead.org> <b85c1818-e5bf-470c-ae0c-6dd2e1525a2f@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b85c1818-e5bf-470c-ae0c-6dd2e1525a2f@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Mar 17, 2025 at 09:57:45AM +0000, John Garry wrote:
>> And handle the case where there
>> is no hardware support at all.
>
> So xfs_get_atomic_write_max_attr() -> xfs_inode_can_atomicwrite() covers no 
> HW support.
>
> The point of this function is just to calc atomic write limits according to 
> mount point geometry and features.
>
> Do you think that it is necessary to call xfs_inode_can_atomicwrite() here 
> also? [And remove the xfs_get_atomic_write_max_attr() -> 
> xfs_inode_can_atomicwrite()?]

At least document what it does..

>>> +static inline void
>>> +xfs_compute_awu_max(
>>
>> And use a more descriptive name than AWU, wich really just is a
>> nvme field name.
>
> I am just trying to be concise to limit spilling lines.
>
> Maybe atomicwrite_unit_max is preferred

I guess if we ant to stick to the unit encoded in awu and used by the
block layer, yes.

