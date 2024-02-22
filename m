Return-Path: <linux-fsdevel+bounces-12429-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3541585F37A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 09:51:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E16B828471E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 08:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 080942C870;
	Thu, 22 Feb 2024 08:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cKfyJXhp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613A3101E2;
	Thu, 22 Feb 2024 08:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708591905; cv=none; b=psBViqXCg9SAB/RYI0KTJknWFc+SShyqR3FMzVS9Y0OsLIn5jLTFH5/FiK+DoGY1VdoEXr+85dBEzbgt6Wq8Vff6GBNGA4FRJ9XNELJsnyCXKnjva+EjVI4Tdwpd+1Jk+x6afiTAbg0KHpl0Gxv16Q7FKm/qSF9eqXF5JbTct1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708591905; c=relaxed/simple;
	bh=JoxFkXKK1G2eYE+0iXjJP6VvOtWDkSC6kFkAL0Sn46s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DlXm8VtT7c85PnjWwqKs/WjklcOZ0A3vTWuM+6uzZzSEcTWUs2my5r73oa20rWvWOVKO/T5s8+SF3Wpd1oxt14tco6pQG8NM6MjZ+ydHMr8X2z4ZB87so6O2e4Z885a2IWQT08FWzhBqkVu07vX0PcKPhE/5KY4ehE07qZbEC9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cKfyJXhp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F35CBC433F1;
	Thu, 22 Feb 2024 08:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708591904;
	bh=JoxFkXKK1G2eYE+0iXjJP6VvOtWDkSC6kFkAL0Sn46s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cKfyJXhpwlkE/PHdOyJPjp9icGsKUDkLJ9wNQRmoUxvLz84Q6NqdwerTU4GToBvED
	 J6JSfqp8e8+hMpo3bilBSHMsc68Wjd6q9x4iPK70hlZMkQXTwnaSkRL3X5+8SLlreX
	 bGComPLy1GC9YDOX220c3e8HmAA4EIF8U4jwJL6nES9+GKfzoTvi4P4T7ElManM2Oo
	 AUTYqkU9lpAg/A4Q+WpDUg6Os7qQU8mAHPyDEbyT7gAMBKhFEsRtHA9mioQZJSx2R1
	 S8vAwbGEJGt/7tpY8rzxuCTM+v/dhVNl6XGKwR6YDSJCodXl7TtCX6fG6jzDl7gxHt
	 I0+PIx7lHy34w==
Date: Thu, 22 Feb 2024 09:51:39 +0100
From: Christian Brauner <brauner@kernel.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>, 
	linux-scsi@vger.kernel.org, linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
	Daejun Park <daejun7.park@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>, 
	Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
	Stephen Rothwell <sfr@canb.auug.org.au>, Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v9 01/19] fs: Fix rw_hint validation
Message-ID: <20240222-hamster-rosafarben-fe5b5766613f@brauner>
References: <20240130214911.1863909-1-bvanassche@acm.org>
 <20240130214911.1863909-2-bvanassche@acm.org>
 <20240131-skilift-decken-cf3d638ce40c@brauner>
 <fafab67c-f87d-4684-98d5-6d9f82804bba@acm.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fafab67c-f87d-4684-98d5-6d9f82804bba@acm.org>

On Wed, Feb 21, 2024 at 06:46:51PM -0800, Bart Van Assche wrote:
> On 1/31/24 05:56, Christian Brauner wrote:
> > The fs parts of this should go through a vfs tree as this is vfs infra.
> > I can then give you a stable tag that you can merge and base the big
> > block and scsci bits on. It'll minimize merge conflicts and makes it
> > easier to coordinate imho.
> 
> Hi Christian,
> 
> It would be appreciated if such a stable tag could be created on the vfs.rw
> branch.

Isn't the stable branch enough I gave you weeks ago?
It's usually what I do with Jens.
But fwiw, see I've added the vfs-6.9.rw_hint tag. Pushed.

