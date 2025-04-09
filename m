Return-Path: <linux-fsdevel+bounces-46069-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65A8DA822C4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 12:52:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2F464C19F5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 10:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 600ED25DB17;
	Wed,  9 Apr 2025 10:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fSJhimxH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B8825D8E7;
	Wed,  9 Apr 2025 10:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744195857; cv=none; b=WpokI2+0cv31016YyJkfIqNOZ96ZmzoZRewtF5GqCR5vGnov4Bn7IvRxMGy4zeAcaDdA70/aO/dF3aM1KYDevOQU1KGzi5wqSnIr9iamxtpdzPkzzhsfAbhPcTUkFL/PPcCo4uXwmrf8jmmFNC/3NfNU71KOnSCttu8M6CJK5c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744195857; c=relaxed/simple;
	bh=HlVtWoj3LWyiBcoZxrPmX0QXi/NYax4CcC6lrawTBbc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f4XjV6a1g9reVfh/imMpReTRufdjbKHpBxlRuyMn5HzDrpOsekC/6aKnrqRa8CqRe02Yv4BhKC1SgqF3DhUxQgwGcwfPst3JjqZfglTzETT92B1csHpPmBcUDB4a4OK9SVRxxOaEj4uXWXknqm2hcwGvSzZaQ4/dhlbA/D+bCxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fSJhimxH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92AD3C4CEE3;
	Wed,  9 Apr 2025 10:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744195857;
	bh=HlVtWoj3LWyiBcoZxrPmX0QXi/NYax4CcC6lrawTBbc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fSJhimxHin3y/ZB3Pleu3u8j+qCxOs5pQ/MD8yAXnWGAwLdK53UFp1b313UBRUubo
	 dL6+a1zQv8pgmZj8HjD2a1G+jcTbYICqmdN1rV9kVlwdEwoAfu+XD8HbiXXKHEYk+B
	 4386xVetZP27Cza1J3J/vATMiaisNlGll5kax3pkPKkd8gCed0PhzE/7ZfhKKZeJUQ
	 CFLn82aDMJg+Mlt9MnoiFh3Dtc79YiLEknPFI7TvLjmg6i9TGfX+UHYAPu/m0G4P90
	 Oma/Fv0wwv8+DxDOQqxtpBVaUGyOykCwkf55QGjoukB+JbQ+iKkPNJ5IxCldgWyW/6
	 PxmDAhNKr3RXg==
Date: Wed, 9 Apr 2025 12:50:49 +0200
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Zhang Yi <yi.zhang@huaweicloud.com>, linux-fsdevel@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-block@vger.kernel.org, dm-devel@lists.linux.dev, 
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org, linux-xfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, tytso@mit.edu, djwong@kernel.org, john.g.garry@oracle.com, 
	bmarzins@redhat.com, chaitanyak@nvidia.com, shinichiro.kawasaki@wdc.com, 
	yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com, 
	yangerkun@huawei.com
Subject: Re: [RFC PATCH -next v3 07/10] fs: introduce FALLOC_FL_WRITE_ZEROES
 to fallocate
Message-ID: <20250409-ausdauer-weingut-4025b274ee63@brauner>
References: <20250318073545.3518707-1-yi.zhang@huaweicloud.com>
 <20250318073545.3518707-8-yi.zhang@huaweicloud.com>
 <20250409103548.GC4950@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250409103548.GC4950@lst.de>

On Wed, Apr 09, 2025 at 12:35:48PM +0200, Christoph Hellwig wrote:
> On Tue, Mar 18, 2025 at 03:35:42PM +0800, Zhang Yi wrote:
> > Users can check the disk support of unmap write zeroes command by
> > querying:
> > 
> >     /sys/block/<disk>/queue/write_zeroes_unmap
> 
> No, that is not in any way a good user interface.  Users need to be
> able to query this on a per-file basis.

Agreed. This should get a statx attribute most likely.

