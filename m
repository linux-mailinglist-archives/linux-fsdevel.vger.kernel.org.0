Return-Path: <linux-fsdevel+bounces-46827-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D630A954FC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 19:03:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16F487A20FB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 17:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6FB01E0DB0;
	Mon, 21 Apr 2025 17:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="hxIMaa9n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4221DE3AD
	for <linux-fsdevel@vger.kernel.org>; Mon, 21 Apr 2025 17:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745255004; cv=none; b=VyRT7VYO8rw83IwCcdPmtaq3+Y8lAAer28CmYxOtlMem1Beb6DXmqPA8XWvDCMrNfbVOW4VInImT8Col4uagBjXKbGXcPPpneLfnPh6NaSTfjpZ6TsX3lty1mpBG9+WjOa1bXZBc5RtTjFmb77ig1e4UV3X/y5jkQNuS0XvtMN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745255004; c=relaxed/simple;
	bh=3QYspGXBmmyaUOG4eu0HHc9aeDNaLW4XduG+oH986y4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lSO7STI8xUVT33OabRXDoSrCyB/q1yhfd/1pp7PNJOl7dgAIcMEtnnTHKSIqFVDoqI53AfR4sTpPI6X6ydsYcaQb4y0yPkUbdZ19bxvs2VXrvC65UeHdeeV8lMyF2sXdvFblZ9C6wi+IU/67IA2p6bB+Kb8Y3yP8LxeZKf22tfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=hxIMaa9n; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=2zzWQYTCIBIJIPd0IvxiUfG491WUnFAm1V/bflucTUA=; b=hxIMaa9nXOEPzGy3iWqKbmjcju
	DWgZZcs/UccJ90IuLuRyWpk/4UyRTHS7ELLwStXn1j6HI5PD1uQE8JrSsaPTbQIKMNLRa26H9Mp31
	3dXqKzw0iwhh5PZKsyMnv5LXNxwiOUCBwh/ePQjXIziaaklE4UsqoWHE5VMXX6Ei7CkMO4xG32nCy
	qBppAUQ/Mk97j3x6YU+HsSYto5/rq8czgofb9dS1I2RtwTQ+W26zgsLKbV+6fitL2et9WQLRfRWuS
	p8hQto25KN7w+7gJuZv/R46VrPUxHHr6h6D0XVfW+NF29+0KQMhxZDqrjT1r+aqOg931bqGTWu2JZ
	4Ix0+gWA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u6uYB-00000002OSC-2ejG;
	Mon, 21 Apr 2025 17:03:19 +0000
Date: Mon, 21 Apr 2025 18:03:19 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH][RFC] ->mnt_devname is never NULL
Message-ID: <20250421170319.GX2023217@ZenIV>
References: <20250421033509.GV2023217@ZenIV>
 <20250421-annehmbar-fotoband-eb32f31f6124@brauner>
 <20250421162947.GW2023217@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250421162947.GW2023217@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Apr 21, 2025 at 05:29:47PM +0100, Al Viro wrote:

> What's to prevent the 'beneath' case from getting mnt mount --move'd
> away *AND* the ex-parent from getting unmounted while we are blocked
> in inode_lock?  At this point we are not holding any locks whatsoever
> (and all mount-related locks nest inside inode_lock(), so we couldn't
> hold them there anyway).
> 
> Hit that race and watch a very unhappy umount...

While we are at it, in normal case inode_unlock() in unlock_mount()
is safe since we have dentry (and associated mount) pinned by
struct path we'd fed to matching lock_mount().  No longer true for
the 'beneath' case, AFAICS...

