Return-Path: <linux-fsdevel+bounces-73613-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 529B9D1CAB9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 07:26:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4D6A930B97CA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 06:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B72AB36CDF5;
	Wed, 14 Jan 2026 06:26:29 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4077F36921F;
	Wed, 14 Jan 2026 06:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768371985; cv=none; b=OcItQ/Pmff4y5ek5LA4o9VRim21+qsUcQx61kkWvbi0FRz1c28++uZcNPyMKjDL02rSHf6mVrFMsnCoPPHYFmmVjx4yL5LPFPBOp6Jxg92M8uzKfVd6hAt+1U7eVBydMolE4ocuIfuiW93EMXM1If284GarbCIocg4HpmEl74sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768371985; c=relaxed/simple;
	bh=6EnF4tUaG1VaMKSTZrmuQ4yYsptmXi6Pql0FfVi/aAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qulIBrCru7yruNDythcGY6MrzjObUKGGlLkBJWaLVEcpEnc+1sCTCL3ntO+jbaFZVLar7rgrPjlF0gVS69a3gOxFqCRXvmlDTjMY3J6dsmnI8xzZIGHMlJBI9cLXzZZtZ/WhB1l1J0RIByDA0A07gBhRwTY3DV0kD2qHOxQQjaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8D87E227A8E; Wed, 14 Jan 2026 07:26:08 +0100 (CET)
Date: Wed, 14 Jan 2026 07:26:08 +0100
From: Christoph Hellwig <hch@lst.de>
To: =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>
Cc: Christoph Hellwig <hch@lst.de>, Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	Carlos Maiolino <cem@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>, Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>, Miklos Szeredi <miklos@szeredi.hu>,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-unionfs@vger.kernel.org,
	kernel-dev@igalia.com
Subject: Re: [PATCH 3/3] ovl: Use real disk UUID for origin file handles
Message-ID: <20260114062608.GB10805@lst.de>
References: <20260114-tonyk-get_disk_uuid-v1-0-e6a319e25d57@igalia.com> <20260114-tonyk-get_disk_uuid-v1-3-e6a319e25d57@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260114-tonyk-get_disk_uuid-v1-3-e6a319e25d57@igalia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Jan 14, 2026 at 01:31:43AM -0300, André Almeida wrote:
> Some filesystem, like btrfs, supports mounting cloned images, but assign
> random UUIDs for them to avoid conflicts. This breaks overlayfs "index"
> check, given that every time the same image is mounted, it get's
> assigned a new UUID.

... and the fix is to not assign random uuid, but to assign a new uuid
to the cloned image that is persisted.  That might need a new field
to distintguish the stamped into the format uuid from the visible
uuid like the xfs metauuid, but not hacks like this.


