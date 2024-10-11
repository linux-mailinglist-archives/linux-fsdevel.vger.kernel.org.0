Return-Path: <linux-fsdevel+bounces-31711-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 841E699A4E8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 15:23:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E20A1F24735
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 13:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FBBA21B445;
	Fri, 11 Oct 2024 13:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="E9+1MEB8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-1908.mail.infomaniak.ch (smtp-1908.mail.infomaniak.ch [185.125.25.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94FEC21B429
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Oct 2024 13:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728652844; cv=none; b=p1C3pm1IC8Hc7pvbFPpyxSXmbL3qoilZhxOc/D6uM9W9hTPuYtPfDaHmnG0E8ZMzhVjl5lvAK6KDQA7KE/TFzPyp8c0YKPSAp5Q/dLJAa018y7pvp4I5J6HUMnHIBUyoHgCULouELPO5nMqKx4LK4fUJQr2ZHP8vFi/GeygtKJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728652844; c=relaxed/simple;
	bh=ZXF83piWzI3Zr1ZbvAwOoHydCarQmxoJOvM0bNPBoQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RFKhnCzbFBuSY7GChouyPTmCaRGxJYUlYHsWeWLzsBn+nZJTkGIVElm2AurkfdGaZxT9PPE/+w8xVstn41y97UhHJmgIQJIm04AmxG+KiZKj2iEFmuDwC/1mVendh3tZSwJoWV+8z3PLbP+O42SEfCUi+k/N1vYtasNxXne5hWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=E9+1MEB8; arc=none smtp.client-ip=185.125.25.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246c])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4XQ6gk1wpTz1bb;
	Fri, 11 Oct 2024 15:20:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1728652834;
	bh=t6ZV+Aef3oPv3lyEENojOAVZ16/VitLu0VzEYiYccvU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E9+1MEB8gIvfq69xVhtuLunwoxi8XY6JouvIgYwzQr8dxGYAT/pg8XE3hjMK1v44X
	 YECUDqbUYgrRKVY3rtpl8SB7jCklNWUWxzQaHoHIOZKPmm/tOXHQcSh7hbds6pKOnT
	 QOezwOMY5Pei4iq+1PSR/02UNXI2NHErgpd8Swe8=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4XQ6gj3zvGz7HN;
	Fri, 11 Oct 2024 15:20:33 +0200 (CEST)
Date: Fri, 11 Oct 2024 15:20:30 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Christoph Hellwig <hch@infradead.org>
Cc: Christian Brauner <brauner@kernel.org>, 
	Paul Moore <paul@paul-moore.com>, linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-security-module@vger.kernel.org, audit@vger.kernel.org, Trond Myklebust <trondmy@kernel.org>, 
	Anna Schumaker <anna@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>
Subject: Re: [RFC PATCH v1 1/7] fs: Add inode_get_ino() and implement
 get_ino() for NFS
Message-ID: <20241011.yai6KiDa7ieg@digikod.net>
References: <20241010152649.849254-1-mic@digikod.net>
 <ZwkaVLOFElypvSDX@infradead.org>
 <20241011.ieghie3Aiye4@digikod.net>
 <ZwkgDd1JO2kZBobc@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZwkgDd1JO2kZBobc@infradead.org>
X-Infomaniak-Routing: alpha

On Fri, Oct 11, 2024 at 05:54:37AM -0700, Christoph Hellwig wrote:
> On Fri, Oct 11, 2024 at 02:47:14PM +0200, Mickaël Salaün wrote:
> > How to get the inode number with ->getattr and only a struct inode?
> 
> You get a struct kstat and extract it from that.

Yes, but how do you call getattr() without a path?

