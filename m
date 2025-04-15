Return-Path: <linux-fsdevel+bounces-46499-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9338A8A44E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 18:39:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1727018970D2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 16:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5853029AB0A;
	Tue, 15 Apr 2025 16:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lQmzoTJz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A130B1E1DE9;
	Tue, 15 Apr 2025 16:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744735160; cv=none; b=Jtg87fjadDyqK6Ol/xa607UPTvHq2yNjTOzyb1/5k8Nk4/kvVC4XRgcVmX5OfNuMIwWNW+VMCbWm0cwL/5hZqRE5MsAlbqQLMxHzeM1oikutFw1TxFcOi0vhZ3ZDagwo8rxjSUFFtLZqIu7OQiYEgVdL+RkGBOoRxF2HEOvnEWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744735160; c=relaxed/simple;
	bh=sFCEEeX9mUQ+/BX7N45J5U02t5WrqbewBoTHt1QyE+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=roVQZKH7cSlc7WzREH2e7oWrMRE6li3Z9+PqHakz9PJ1uW2D2Z7GFV8pSJ5Jn9m0VdyoKO8/Krhi9VAnPiiRzFkuCEleRbnOG0GYA4aFlKsaI3auaLkGG6tIaexlF/POBX5lTOHdg9i2BGuvWRaTHVdsBDmHk82+VT5Y2FncD/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lQmzoTJz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB7DBC4CEEB;
	Tue, 15 Apr 2025 16:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744735158;
	bh=sFCEEeX9mUQ+/BX7N45J5U02t5WrqbewBoTHt1QyE+4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lQmzoTJzJw+j7cwtS+VLJuhtg36Vw1o5q5CUGv+4SxjzCogayUiWRcDWwcLO44SmS
	 D9pz/WibvPuJxi0v3uISM5i2VEroXoe2qO3iX5ihKIRHWOfAo6Bl4pAzfgUoHaLjp9
	 JMT/p82zljzkzuAxxqt+RSx6J7iniKu+GovKSu+58DpOgDItBjuSyhBWw0joz9fIyI
	 0X8e88Cxz/Lu3Bx9s/GKDgZ+cuHn/cMo+i6nBQdmEareEJyuTkAAUpKw0azUgRGjfz
	 lKL+LgjEFomRNtrYaY0bxZJW86jduxieQWRayNF+Ti9nh/CPqqWaBTIJOnD4ubkXoB
	 Wo5R7rQ4mVfoA==
Date: Tue, 15 Apr 2025 09:39:17 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: brauner@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk, jack@suse.cz,
	cem@kernel.org, linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	ojaswin@linux.ibm.com, ritesh.list@gmail.com,
	martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
	linux-block@vger.kernel.org, catherine.hoang@oracle.com,
	linux-api@vger.kernel.org
Subject: Re: [PATCH v7 12/14] xfs: add xfs_compute_atomic_write_unit_max()
Message-ID: <20250415163917.GR25675@frogsfrogsfrogs>
References: <20250415121425.4146847-1-john.g.garry@oracle.com>
 <20250415121425.4146847-13-john.g.garry@oracle.com>
 <20250415162501.GP25675@frogsfrogsfrogs>
 <2a34fd18-7975-4c6c-a220-9a5279f8d58a@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a34fd18-7975-4c6c-a220-9a5279f8d58a@oracle.com>

On Tue, Apr 15, 2025 at 05:35:33PM +0100, John Garry wrote:
> On 15/04/2025 17:25, Darrick J. Wong wrote:
> > > Signed-off-by: John Garry<john.g.garry@oracle.com>
> > > [djwong: use a new reservation type for atomic write ioends]
> > There should be a
> > Signed-off-by: "Darrick J. Wong"<djwong@kernel.org>
> > underneath this line.
> 
> Fine, but then I think that I need to add my SoB tag again after that, since
> we have this history: I sent, you sent, I sent.

There's no need to duplicate trailers.  This is perfectly fine:

Signed-off-by: John Garry<john.g.garry@oracle.com>
[djwong: use a new reservation type for atomic write ioends]
Signed-off-by: "Darrick J. Wong"<djwong@kernel.org>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

Remember, these tags only exist so that bughunters and lawyers can
figure out who to point their fingers at.

--D



> Maybe Co-developed may be better, but some don't like that tag...
> 
> thanks,
> John
> 

