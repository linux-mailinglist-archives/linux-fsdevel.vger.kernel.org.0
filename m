Return-Path: <linux-fsdevel+bounces-47553-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0FE3AA01AB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 07:11:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46E801A835B8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 05:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 977BB14D2A0;
	Tue, 29 Apr 2025 05:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="LL7JQbe9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47064270EAB
	for <linux-fsdevel@vger.kernel.org>; Tue, 29 Apr 2025 05:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745903460; cv=none; b=AkGFckza3lTCORP58mjJe+KbVeAeLDhohRxh2EXL2oH4D+KdPW1Kb5AwbD2e1HclKNq+ntl6sr5CiWNUDTu8ll5AG3lnvDGYYBFij0q3R+pfsdj7fxq2LuH0jVjV1tWM4qhvGiwqcMxfjPKv3uNfH8awHu/NqoPSN5bOc8Ad2TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745903460; c=relaxed/simple;
	bh=cCnkL7DPOuVnDioQTr4HebwXmLx1GskZhFryLJnjO4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TNOOf6Y+PLPmokhBvqm3NDa2I/3BoKXiQqWrWV2pIKUsqTivVobbNweWGxYSBkzDw5PiSv1crw0VTVp5AU/Y/18Y9wSaL90Og0f5/sepxmg3OxfZEMeN+jMNSaBCMNChEAGthiMJnRnqOByuuCzK5z3FVD89xxQ7za8NnYrl7e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=LL7JQbe9; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=guuJRDAujWO7VTprcBb49BtCnE22RAb1SVWO2dOTUe0=; b=LL7JQbe9fnJfzWm/87XGDgj8SQ
	ZljNFsfxUn6uhC09t1Xq0soOlVy9KW1zGGZ6ZszjjxjoMQILeP7Xt8vRZK1P8DZ0OMfLlfqEkl0VL
	W18UPc16Ejq8R6T4whP6aWPJVNyYDP1pTd4yNyPWSCx3pVqXbn1xHyp5lxWFiUriithYeTnbzzsnc
	hVx0ZjKMd2Qmk3pJXZXtJmhn7FkV4LsKQJEaqMA/VNeLZX7+2gH1I5fveotXRBMf7BGjNpP5ZfgVR
	z1BzEU+R7i1y1vfF/rlhjvDJE7xR1mxPdPj+5qgUZ5QkJuIg7BK4BucN/mxgIg9MAKCUCETx6IroX
	7L4LZNQw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9dF8-0000000D584-36Ln;
	Tue, 29 Apr 2025 05:10:54 +0000
Date: Tue, 29 Apr 2025 06:10:54 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC] move_mount(2): still breakage around new mount detection
Message-ID: <20250429051054.GP2023217@ZenIV>
References: <20250428063056.GL2023217@ZenIV>
 <20250428070353.GM2023217@ZenIV>
 <20250428-wortkarg-krabben-8692c5782475@brauner>
 <20250428185318.GN2023217@ZenIV>
 <20250429040358.GO2023217@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250429040358.GO2023217@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Apr 29, 2025 at 05:03:58AM +0100, Al Viro wrote:
> On Mon, Apr 28, 2025 at 07:53:18PM +0100, Al Viro wrote:
> 
> > FWIW, I've a series of cleanups falling out of audit of struct mount
> > handling; it's still growing, but I'll post the stable parts for review
> > tonight or tomorrow...
> 
> _Another_ fun one, this time around do_umount().

... and more, from 620c266f3949 "fhandle: relax open_by_handle_at()
permission checks" - just what is protecting has_locked_children()
use there?  We are, after all, iterating through ->mnt_mounts -
with no locks whatsoever.  Not to mention the fun question regarding
the result (including the bits sensitive to is_mounted()) remaining
valid by the time you get through exportfs_decode_fh_raw() (and no,
you can't hold any namespace_sem over it - no IO allowed under
that, so we'll need to recheck after that point)...

