Return-Path: <linux-fsdevel+bounces-51815-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 222F3ADBB48
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 22:38:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F099718906BC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 20:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5527D20B7FC;
	Mon, 16 Jun 2025 20:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="SPZXP/wP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E55136349
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Jun 2025 20:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750106322; cv=none; b=jZnMqpL/xP0BvMosKss+v49O9yoEyZDEvl2uJKyAkhuwfrYf/8l9yb9blna6T0obae0VSAISUZR2WZreJKWu8b9WYpWSfLWRDk1lyQkhmCl6m3WWh8L2/6LFMD/Gnc3tQsH3Vv0RKgE8VSAfF4QLjZQFmxgAbSrpNx8GiheDe/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750106322; c=relaxed/simple;
	bh=va9fi5446d5NJfKMY5GAQ49mIP93kHa9ezaWlyaN+RA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qqbg/t4kiGglXjlM97EyFuygJaPid8ckFZHhiynGAFu0l+7JdCqczP5UBiN50uh1sAWslrFUg2FGHszDAc3aH+Eqpyc2qyLmJMSyVBuhL86RO9NE5M7LzZ9zIbEYL4va6C+KlsmfsIMy9d2jOZ8EZng1Id2wSwzlusCwnDGEmvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=SPZXP/wP; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=p2p8FtHrkiXlvyjLtwUnvSNfiw1M1F5Li13a+y2qmak=; b=SPZXP/wPYVGCT7blvSl92lhImB
	utRbFDq5oBllsrG/x9f/0MM644Fs/0/bHEPPFI2P10iseZ6OXqA0euEXVdbygy3Vr0eRf186brXZ3
	zqQUzO0v4R/6v4/OQ4kloNzPFTDXYK3tFDLHFjuE1s3rbAL8+VNu0HtbbtWC4luX/QiClIjjjQbFn
	sgWsFEIprWCEH0qbnKvmx9wLa+htogYZkbOZVm47G7UX5GgYg3CNaQiViUB+1NR3bSNeydHtrbRjb
	0oQRZJnG+nhN5PxvCJaGAnIK5g7Kga+V1Wck3ub18N+HLdF6TYIFcsz7AUTYp2kGy3d8sCXqNmAQJ
	na4BRI4A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uRGbF-00000002Olo-1xmJ;
	Mon, 16 Jun 2025 20:38:37 +0000
Date: Mon, 16 Jun 2025 21:38:37 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, ebiederm@xmission.com, jack@suse.cz,
	torvalds@linux-foundation.org
Subject: Re: [PATCH 25/26] get rid of mountpoint->m_count
Message-ID: <20250616203837.GA438417@ZenIV>
References: <20250610081758.GE299672@ZenIV>
 <20250610082148.1127550-1-viro@zeniv.linux.org.uk>
 <20250610082148.1127550-25-viro@zeniv.linux.org.uk>
 <20250611-leidwesen-kundschaft-92abc4565458@brauner>
 <20250611184700.GP299672@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611184700.GP299672@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Jun 11, 2025 at 07:47:00PM +0100, Al Viro wrote:
> On Wed, Jun 11, 2025 at 01:19:43PM +0200, Christian Brauner wrote:
> 
> > This feels well-suited for a DEFINE_FREE based annotation so that
> > unpin_mountpoint() is called when the scope ends.
> 
> FWIW, I'd be more interested in having unlock_mount() treated that
> way, but I'm not sure what syntax would make sense there.
> 
> scoped_cond_guard() is not a good fit, unfortunately...

Folks, how much would you hate the following trick:

lock_mount(path, &m) returning void, and indicating error by storing
ERR_PTR(-E...) into m.path; unlock_mount(&m) doing nothing if IS_ERR(m.mp);
users turned into

	scoped_guard(lock_mount, mp)(path) {
		if (IS_ERR(mp.mp))
			return ERR_PTR(mp.mp);
		....
	}

