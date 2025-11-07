Return-Path: <linux-fsdevel+bounces-67467-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51CD4C4138C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 07 Nov 2025 19:05:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8475F3B8F32
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Nov 2025 18:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5461339B2D;
	Fri,  7 Nov 2025 18:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rGxN54F9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49DF532B98A;
	Fri,  7 Nov 2025 18:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762538708; cv=none; b=h3SkCkNrLBtM5gURw6ieO5JBIQZEDYmL8+E8H1hXAfplqXi7S9mAirGrFrPhm5CUa4P3QsP5+gfFGoVRO5kbDrY1AotWoaWATyKzcaqfRya7QXvb2CipxRn+qlRwUzcs0tVt/aGIy2d60AsYObzGEd23vXhD9N22sIHYJP9UZuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762538708; c=relaxed/simple;
	bh=qZhFxT3182pC+zutIqqRWTKzSg3eQcXF2h1KCoW8yag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=il5ob7Tmumuv6YKAoSFu4Q9Lds0Jr35nAZttei4S6dtJWQdTVlFkDiEr/meVWyVvA47XsJxc+4IrAwNGCR/nvrZjyZekPN50b5Wr6q7MBBMhF6luWVNtZtjn6XQfY7ryUBhclLwEjZEXlF/kPbYtKhocrYTu4XrRZYfQ0NoaUrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rGxN54F9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFBE4C4CEF5;
	Fri,  7 Nov 2025 18:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762538707;
	bh=qZhFxT3182pC+zutIqqRWTKzSg3eQcXF2h1KCoW8yag=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rGxN54F9LFU8FWExNQ5GylwqZ6dkzfQguCZJDQRJ91vO+dXgWebH2lf4F5SqXxZEh
	 qIjv6K8qBDbzGupmgGqY58sHnoTfzuCkYfLkDC0kWbqE+fgb2dfjQs3tZvToW1Qltv
	 cJSIMxhENcFqi2otN9ty2VWZG8R6NvUnq3uv8r3cNpZWgMFNVCMdQemgmZuvzJv9xS
	 Xe8bD5xBDN/s/w3q6cuVpJfaUNscFWE24LT4h+S1eEk/R3Nq3tYCjJnzGleC6teqXB
	 4VL9812DhAJgo7mPs6NJDu9P5crOn097I1e4W5Kx6axecCLuuTxxwpuQaGfZL3C9VL
	 X6QwJB4ERWOCQ==
Date: Fri, 7 Nov 2025 10:05:07 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Jan Engelhardt <ej@inai.de>
Cc: Christoph Hellwig <hch@lst.de>, miklos@szeredi.hu, brauner@kernel.org,
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/1] iomap: allow NULL swap info bdev when activating
 swapfile
Message-ID: <20251107180507.GW196362@frogsfrogsfrogs>
References: <176169809564.1424591.2699278742364464313.stgit@frogsfrogsfrogs>
 <176169809588.1424591.6275994842604794287.stgit@frogsfrogsfrogs>
 <20251029084048.GA32095@lst.de>
 <20251029143823.GL6174@frogsfrogsfrogs>
 <20251030060008.GB12727@lst.de>
 <q43nr1rs-3o58-96pq-111s-r58s9q5nnq21@vanv.qr>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <q43nr1rs-3o58-96pq-111s-r58s9q5nnq21@vanv.qr>

On Fri, Nov 07, 2025 at 10:23:23AM +0100, Jan Engelhardt wrote:
> 
> On Thursday 2025-10-30 07:00, Christoph Hellwig wrote:
> >
> >> "Already does" in the sense that fuse already supports swapfiles(!) if
> >> your filesystem implements FUSE_BMAP and attaches via fuseblk (aka
> >> ntfs3g).
> >
> >Yikes.  This is just such an amazingly bad idea.
> 
> And even if a fuse does not support swapfiles, "problems in computer
> science can be solved by another level of indirection". Not that they
> should - but this sequence succeeds already:
> 
> mount -t sshfs root@localhost:/ /mnt
> losetup /dev/loop7 /mnt/swapfile
> swapon /dev/loop7

Amazing.

--D

