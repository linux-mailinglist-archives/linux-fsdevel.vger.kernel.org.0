Return-Path: <linux-fsdevel+bounces-47807-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06257AA5A51
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 06:31:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EFBF4E2778
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 04:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29D0A231836;
	Thu,  1 May 2025 04:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OEMM4ItZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6512D4C85;
	Thu,  1 May 2025 04:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746073855; cv=none; b=Svwt27nnqWC1qMAXR09rppivrOJuUhgSMlE7M0xT3QrLAxYyOgFZ3ZlHnluQgyhaEkr50dhpmGWjO2tuqHHHOkfY87wDfR9rGWl/Q4n4havpxwqNQw0P8lBZTdlZgB/fJfbIapKbMMPmPTeg1kIclqEmTEwASd5luHLWow6j/ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746073855; c=relaxed/simple;
	bh=lXs90SKBYnw4vhtrdlv7Pt+u57vH2VVBsnX6vGGu2bs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=awyMqot5JaiTvacsegZRXL7xIGEySrSalPgKE5mD1d6HsVJ4sLLnjArOI4CDcgrmg8IJ70CP6tGLjE3Fcvf/qHfncgdo8AD2LOOPf4OGFAuW2CpiN77D52H67Ci/r0S3vRAktJoKPbQ8WDE5Z8oxhGff/ieic82yyN8QJzqUfbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OEMM4ItZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7730C4CEE3;
	Thu,  1 May 2025 04:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746073853;
	bh=lXs90SKBYnw4vhtrdlv7Pt+u57vH2VVBsnX6vGGu2bs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OEMM4ItZdopdosiaSYbCa9zn9FLKsXaYLkuZ9/1DDoB9pKGOzLyLblGmMTmoB2iON
	 l4eLBewZ/2mJwB9jjIEc8N38zYGvkw6IVNUJYzg6mKOz5B+7qEs32Zcf76ab76k8le
	 OrKNXfWO3i84eNC8c8JX+/6lNTdrhzag3dN3RI9bi7sB8CcP5ON2AVbOkt+kj9/V/W
	 Ao8foGYGxmfpc5Ln3wthIk9oN5kltiV43vKPl+3dVmwe/y9Go/pZMf6obzC7YHi2df
	 6vjz1SBE2N69O43eV8K3KdH/eq9+r/ZwcOt7x3GS7Z09wzh9XDSHCdfubdpI1s2WGc
	 UdwFriTArIAlw==
Date: Wed, 30 Apr 2025 21:30:53 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: brauner@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk, jack@suse.cz,
	cem@kernel.org, linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	ojaswin@linux.ibm.com, ritesh.list@gmail.com,
	martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
	linux-block@vger.kernel.org, catherine.hoang@oracle.com,
	linux-api@vger.kernel.org
Subject: Re: [PATCH v9 13/15] xfs: add xfs_compute_atomic_write_unit_max()
Message-ID: <20250501043053.GD1035866@frogsfrogsfrogs>
References: <20250425164504.3263637-1-john.g.garry@oracle.com>
 <20250425164504.3263637-14-john.g.garry@oracle.com>
 <a8ef548a-b83e-4910-9178-7b3fd35bca14@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a8ef548a-b83e-4910-9178-7b3fd35bca14@oracle.com>

On Wed, Apr 30, 2025 at 08:52:00AM +0100, John Garry wrote:
> On 25/04/2025 17:45, John Garry wrote:
> > +static inline xfs_extlen_t xfs_calc_perag_awu_max(struct xfs_mount *mp)
> > +{
> > +	if (mp->m_ddev_targp->bt_bdev_awu_min > 0)
> > +		return max_pow_of_two_factor(mp->m_sb.sb_agblocks);
> > +	return mp->m_ag_max_usable;
> 
> I think that this should be rounddown_pow_of_two(mp->m_ag_max_usable)
> 
> ditto for rt
> 
> I will fix (unless disagree).

I don't think this needs fixing.  If there's no hardware support on the
device, then we can do any size of atomic write that we want.

--D

