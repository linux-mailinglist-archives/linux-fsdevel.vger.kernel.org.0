Return-Path: <linux-fsdevel+bounces-73884-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C965D2294C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 07:37:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 33E653090B71
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 06:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77C092D060E;
	Thu, 15 Jan 2026 06:36:39 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7BCC26CE3B;
	Thu, 15 Jan 2026 06:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768458999; cv=none; b=BGLKtGEnlceq4+cEJORV4zXS+ExLR0BDLrL+sGG0/K04NcsdfcyPrDebU3U80gYOTNLsD+rD7sNQ/Fp12CFTSbpHWBlr1A4pXeq05o0oTGKiqy8AfaKocCoGb6j4eDbtgV5wm31QJ7hoJxR6djlpdlPv3r/I4OT81jejUcIinnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768458999; c=relaxed/simple;
	bh=N1m2wSx3Lb1vPqYeh+HC4pA2nMcwsyDWuA72n1N2w+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H5dMFiVV1soN2BrfT+oL3pi/1I7wnYQTUet+Iod3MmGskDKuO65jF18ts4vabEqJmvOIpf9AeSY4cOdtx8IEPcaxs0siOit0LsvuME/yeJpWK1e7WlsSX6IJ5hbDLBJMFUYQ24SamcFiZ5tLh+Qpcc7CFs6pfmgYqig/v7jg3aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 830E5227AAD; Thu, 15 Jan 2026 07:36:31 +0100 (CET)
Date: Thu, 15 Jan 2026 07:36:30 +0100
From: Christoph Hellwig <hch@lst.de>
To: Amir Goldstein <amir73il@gmail.com>
Cc: =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	Christoph Hellwig <hch@lst.de>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	Carlos Maiolino <cem@kernel.org>, Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>, Miklos Szeredi <miklos@szeredi.hu>,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-unionfs@vger.kernel.org,
	kernel-dev@igalia.com
Subject: Re: [PATCH 3/3] ovl: Use real disk UUID for origin file handles
Message-ID: <20260115063630.GA9671@lst.de>
References: <20260114-tonyk-get_disk_uuid-v1-0-e6a319e25d57@igalia.com> <20260114-tonyk-get_disk_uuid-v1-3-e6a319e25d57@igalia.com> <CAOQ4uxjAQu9sQt3qOOVWS5cz5B51Hg0m4RAjsreBkmPhg-2cyw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjAQu9sQt3qOOVWS5cz5B51Hg0m4RAjsreBkmPhg-2cyw@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Jan 14, 2026 at 06:54:37PM +0100, Amir Goldstein wrote:
> Perhaps this is the wrong way to abstract what overlayfs needs from real fs.
> Maybe better to extend ->encode_fh() to take a flags argument (see similar
> suggested patch at [1]) and let overlayfs do something like:

Encoding the uuid into the file handle in the kernel is the right thing
for NFS as well.  Hacking in the uuids in userspace instead of the kernel
was done initially because there was no good kernel uuid infrastructure.
So doing this in general and have NFS use it when available would be
beneficial for everyone.

