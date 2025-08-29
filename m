Return-Path: <linux-fsdevel+bounces-59654-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD470B3BFA8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 17:44:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B3DD1895B6D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 15:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84FA7322A1B;
	Fri, 29 Aug 2025 15:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d3FMsLZv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBEC8322750
	for <linux-fsdevel@vger.kernel.org>; Fri, 29 Aug 2025 15:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756481979; cv=none; b=QsuO6LriSq/shWNexeE+eHA6nsVAGlOzh3FYi2FrclyaR5mfcq2KEqfKlAXjmJZtpUkeOM4GrFCMEPuBjrMByl4s+23VRCik+J5o+OlW5X54sclGehj85O6DKvlnK3BUD+BZe6Cf29nWAubRTMngNNonoEzyo+unnYNsyMzYDKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756481979; c=relaxed/simple;
	bh=A/aWaVH/XZy/4rra/L9Fqyqs8W0UruetIzzSGJ/mGMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kKjyeajybuirbEBVJ/U1DLvuZTbMkXNMwmZq+bwP3bbA5FQ5C0T0NiKlYg3elBRO/gTunwG5tN+R/IVQuZAGXweb4S7uNej/sDORc/WBbTJnEn5su6owxZeQ+8agPbJXsLSgZQVu+A6co3rUmq4eAass2zBdjIawoNZzjIV2g2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d3FMsLZv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41B07C4CEF5;
	Fri, 29 Aug 2025 15:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756481979;
	bh=A/aWaVH/XZy/4rra/L9Fqyqs8W0UruetIzzSGJ/mGMQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d3FMsLZvfzeJoFItFo1kLNTxVFHBsjyGq/i9DOEZ4OvPav8kG8xuy3qdtM8Lanyz/
	 R0dv/hEukOMLpeim5m4Z6/Ir7HLNpNZpoH9ZDJzUaSLFZ509OFG+DRczJIUwjC6Z09
	 RUACjJlvD5/BVmFCC8/rQPXPdf/YiThoVT8vibViUAYHlPgtokyn9OmlhwihzB4cg6
	 Gs+y/PYLb606qNApnizleSP6vu9zm5QNiTlILlolDBE246/ZCxItb2GHnJvKxCat3y
	 8pCo/d8Z0ytTDP5yC24RzjbstR/+EfH022mtKShwt/C4hTtkxGbblOWyHbrxWyYUK0
	 4a7yeqMLnYTkg==
Date: Fri, 29 Aug 2025 08:39:38 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: bernd@bsbernd.com, neal@gompa.dev, John@groves.net,
	linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com
Subject: Re: [PATCH 4/7] fuse: implement file attributes mask for statx
Message-ID: <20250829153938.GA8088@frogsfrogsfrogs>
References: <175573708506.15537.385109193523731230.stgit@frogsfrogsfrogs>
 <175573708630.15537.1057407663556817922.stgit@frogsfrogsfrogs>
 <CAJfpegsp=6A7jMxSpQce6Xx72POGddWqtJFTWauM53u7_125vQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegsp=6A7jMxSpQce6Xx72POGddWqtJFTWauM53u7_125vQ@mail.gmail.com>

On Fri, Aug 29, 2025 at 08:24:42AM +0200, Miklos Szeredi wrote:
> On Thu, 21 Aug 2025 at 02:51, Darrick J. Wong <djwong@kernel.org> wrote:
> >
> > From: Darrick J. Wong <djwong@kernel.org>
> >
> > Actually copy the attributes/attributes_mask from userspace.
> 
> Some attributes should definitely not be copied (like MOUNT_ROOT,
> AUTOMOUNT).  This should probably be VFS responsibility to prevent
> messing with these.
> 
> I guess the others are okay, they can already be queried through one
> of the fileattr intefaces.  But think we should still have an explicit
> mask to prevent the server setting anything other than the currently
> defined attributes.

Ok, will do.  Thanks for the feedback!

Though unfortunately there isn't a pre-existing mask for "flags the vfs
will set for you" other than grepping:

fs/stat.c:121: * Fill in the STATX_ATTR_* flags in the kstat structure for properties of the
fs/stat.c:127:          stat->attributes |= STATX_ATTR_IMMUTABLE;
fs/stat.c:129:          stat->attributes |= STATX_ATTR_APPEND;
fs/stat.c:153:  stat->attributes_mask |= STATX_ATTR_WRITE_ATOMIC;
fs/stat.c:163:          stat->attributes |= STATX_ATTR_WRITE_ATOMIC;
fs/stat.c:201:          stat->attributes |= STATX_ATTR_AUTOMOUNT;
fs/stat.c:204:          stat->attributes |= STATX_ATTR_DAX;
fs/stat.c:206:  stat->attributes_mask |= (STATX_ATTR_AUTOMOUNT |
fs/stat.c:207:                            STATX_ATTR_DAX);
fs/stat.c:312:          stat->attributes |= STATX_ATTR_MOUNT_ROOT;
fs/stat.c:313:  stat->attributes_mask |= STATX_ATTR_MOUNT_ROOT;

So I guess that's (IMMUTABLE | APPEND | AUTOMOUNT | DAX | MOUNT_ROOT) ?

IMMUTABLE | APPEND seem to be captured in KSTAT_ATTR_VFS_FLAGS, so maybe
that just needs to include the last three, and then we can use it to
clear those bits from the fuse server's reply.

--D

> Thanks,
> Miklos
> 

