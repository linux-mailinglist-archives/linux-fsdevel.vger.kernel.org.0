Return-Path: <linux-fsdevel+bounces-51353-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F8DAD5E87
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 20:47:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E2613A9146
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 18:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAA1D22B8AB;
	Wed, 11 Jun 2025 18:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="rSnBo7gG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2209418787A
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Jun 2025 18:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749667625; cv=none; b=AdhUZye5YCFvaY78VZKbcseyxtfEk0lr1hlxyNjmyNWGOwiatcObusLvUwm85S67AW4QyJzTYln0CNmGHToxaZ0rFY/GgF+OptKbXUor/2W8TF3kGZ6q3lxHKVM9mx1Hvv990uAHgSqSnr2S9FSWt3sdIxVaAKumbclKp8JFZVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749667625; c=relaxed/simple;
	bh=mb7Yzgqbzqcbn/k4Pw0v41i6gIQqpr9fnHwTmgtkB+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AQKmW8GvOyVnXtrI1/8viFy3k2mckOO+vme4oMRW2rKojjauC0mUHojG86SlUN4ryGYL4X3E78pR+fmesRbpcRwv5mZQL24xb2Kcq6OjaOExnZx19GfJK84paBrctT5PmBDdLI++sF3IrCspQpWGAgMZzIooNRvmu4Phykr9oL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=rSnBo7gG; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=mb7Yzgqbzqcbn/k4Pw0v41i6gIQqpr9fnHwTmgtkB+g=; b=rSnBo7gGn30QRNO0Lwu2kewtNk
	QD89wLiT4U3SYVhaPOJHGeWRhvqFy7tPclvjVl2zJxN6hRKrsrc9jKBk1Yi//Jw4ury8loufqTFL4
	PP17MSiqUMOId16bhmAM3TyvaTmRB8wONbiWTfUtXXP9hVdW0e3d8DcMnzsdE4XF2vUg9AlKqcusS
	+nFHzF1gWedFHrkamM3fBujngKwv3cjkd3MYMRBQxxN6UVjbQ7Xe35gMNdcyWA07vcFh8aWDcYz73
	5+9VEpINmEcD/Qj85cogTTTDOo8cDC092TvfjR/SVLk4sU86+1zk02r+/RBUatQPrOQIVB+ncYP+J
	dn63Y7Aw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPQTU-000000058Tb-2tvA;
	Wed, 11 Jun 2025 18:47:00 +0000
Date: Wed, 11 Jun 2025 19:47:00 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, ebiederm@xmission.com, jack@suse.cz,
	torvalds@linux-foundation.org
Subject: Re: [PATCH 25/26] get rid of mountpoint->m_count
Message-ID: <20250611184700.GP299672@ZenIV>
References: <20250610081758.GE299672@ZenIV>
 <20250610082148.1127550-1-viro@zeniv.linux.org.uk>
 <20250610082148.1127550-25-viro@zeniv.linux.org.uk>
 <20250611-leidwesen-kundschaft-92abc4565458@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611-leidwesen-kundschaft-92abc4565458@brauner>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Jun 11, 2025 at 01:19:43PM +0200, Christian Brauner wrote:

> This feels well-suited for a DEFINE_FREE based annotation so that
> unpin_mountpoint() is called when the scope ends.

FWIW, I'd be more interested in having unlock_mount() treated that
way, but I'm not sure what syntax would make sense there.

scoped_cond_guard() is not a good fit, unfortunately...

