Return-Path: <linux-fsdevel+bounces-48270-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B895BAACB3E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 18:43:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB6981C067B0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 16:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54906284667;
	Tue,  6 May 2025 16:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="sxooxhdr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E6C27FD52;
	Tue,  6 May 2025 16:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746549795; cv=none; b=eKj9hNWAUCBEValjvaiH4XiwKV7DTTxQVfxZt/F0SNaij7WxLVjg1WtxTLlVeW3RYqOyQMP1WLgmVP6zkO4kxj5GXPT5Ny+eUwevdeq4E/uu8kpI7l7NAosa4ZrwZFZ8vT1hxBHTmlGd1C2jWP1mfcNeF3VXdhmYJVdIVQwt1Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746549795; c=relaxed/simple;
	bh=Jh3rWhQ9pQIpNUSGw0L7Rz90Jnyxe1SsLvOCkSeCwQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KYXpW6gj4ZVDdJt3VTJxTwo6jmtCf7dg6//lKF51R6jN95YjuHoLheTRQAYJoKLZ0mzvzTLba3D+wxHLis+759EeiFZV9B59b8NckQYd7ka2ZWZ+jmbp3ccRFLRhGV53EG2dJb7A1qg9s+W8Ux3N77kAtCSqr53KbOrcB4kDS9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=sxooxhdr; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=8LuCH0xhKs0sBheYldxQy35hKwUJMVNdfKQhXZVJI64=; b=sxooxhdrKr2sE4I68IIbrIyyUJ
	BIBA1x50K7DrIkbJhAvaaupsZuTFtQ5631/CyjMrHOlFsXx00WthwF2JugZOuOl2z6fqjLy+mOvxD
	3jQeWQ9tPWZoqBTIacEGUU2Nc5qa8L5mYPaakTvfCYCUDl2X3/Yi6Y6ChTylJX6ZAaBcAs9RorgLx
	xiXQpYLbOWH0P7Ilg3Z9mthw5lfI4BtapEtdg1rkq/aFa8mANZey6ljq/AdzqVuW3AXIpg55gWdh3
	Q2ccyEZVNt9GTNgPV4wRdB2yxTtMur69wAjF9fw4U76HjwbxcaBw5D09fZbCBykUfdln8KwS5XTm6
	8yH8TrAg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCLNu-0000000Ba2X-250z;
	Tue, 06 May 2025 16:43:10 +0000
Date: Tue, 6 May 2025 17:43:10 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Klara Modin <klarasmodin@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [RFC][PATCH] btrfs_get_tree_subvol(): switch from fc_mount() to
 vfs_create_mount()
Message-ID: <20250506164310.GM2023217@ZenIV>
References: <20250505030345.GD2023217@ZenIV>
 <3qdz7ntes5ufac7ldgfsrnvotk4izalmtdf7opqox5mk3kpxus@gabtxt27uwah>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3qdz7ntes5ufac7ldgfsrnvotk4izalmtdf7opqox5mk3kpxus@gabtxt27uwah>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, May 06, 2025 at 03:36:03PM +0200, Klara Modin wrote:
> Hi,
> 
> On 2025-05-05 04:03:45 +0100, Al Viro wrote:
> > it's simpler to do btrfs_reconfigure_for_mount() right after vfs_get_tree() -
> > no need to mess with ->s_umount.
> > 
> > Objections?
> >     
> 
> I hit an oops on today's next-20250506 which seems to point here, and
> reverting makes it go away.
> 
> Let me know if there's anything else you need.

.config and toolchain information would be useful...

