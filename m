Return-Path: <linux-fsdevel+bounces-22034-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBBD091134D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jun 2024 22:35:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27D9B1C21B24
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jun 2024 20:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 951C759168;
	Thu, 20 Jun 2024 20:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="h2seSato"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from submarine.notk.org (62-210-214-84.rev.poneytelecom.eu [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCD0555880;
	Thu, 20 Jun 2024 20:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718915727; cv=none; b=M7f3Jv67ZT1YigwqOkIqS/OmIUCZJSku/W7piXL2AAHi6qbl9nULQcoKgbaGyEWnwb/JSxbhLTxKhPdc1SPa2j/o2XI/wGWDE8KrF213pNc7jQABCQDfvb2hrj3oR1MQ3G1n5muz28WMX4rnfTU1dieJ9Ux50Dz9WRWXA430Rrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718915727; c=relaxed/simple;
	bh=rY6eGqJ75wEmGu1HgeNvbS4fJ9EDXfDA5wrtzZT6MjI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sN85Nz/t2T5VP9AGGPpC63OHtDlA+/IZYAaUevHidnT3AvOpC4Q08z7WjdoFLAzGyPyEtHoKq5GAERHAPakJu/T5OoMzHAgPNt1Br4JSz50VPlMlIEI0tHnOAKNg20BejX4QZ0CoSxiLaop++MreoPq98ezkCRK761D596v7rrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=h2seSato; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id CB8F014C2DD;
	Thu, 20 Jun 2024 22:35:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1718915715;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UaFyOqx3Wna3PHffZA3lbOwaWZobih6I6zyfeyta8vg=;
	b=h2seSatoOQGsC1oNd084UzbsoydUhd9vEuvTIVA67+KxCi+z8q0IS0pjF2KDpOyEXXn6xC
	V5F5tFKch54wcT/63BHhocLiZ4AACqT7Li3GdqjRb9Uoce/o9dTPxiHGE3wZwgzlrvpbcq
	r+1Z8DInjQu2mvVXoWl5Vtyzy4YtD5CUQZ+l8QQu5f6ZIOEm7+irf9TT9TglH+VFtK9Bf0
	bUxiZ+0w0EPSZyZ4qOyV46FOnADlcelQ9/eQBgzAH5dQg48/EYTHDT1P+dqnsewYmXODfm
	X8KMzeUD8xxj/M3UhmTOhPXsiVwITjND5inF4G6cZ4fpaCqg3uxxlbubVPnIGw==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 9c0e7542;
	Thu, 20 Jun 2024 20:35:04 +0000 (UTC)
Date: Fri, 21 Jun 2024 05:34:49 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <christian@brauner.io>,
	Steve French <smfrench@gmail.com>,
	Matthew Wilcox <willy@infradead.org>,
	Jeff Layton <jlayton@kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Ilya Dryomov <idryomov@gmail.com>, netfs@lists.linux.dev,
	linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev, linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>
Subject: Re: [PATCH 06/17] 9p: Enable multipage folios
Message-ID: <ZnSSaeLo8dY7cu3W@codewreck.org>
References: <20240620173137.610345-1-dhowells@redhat.com>
 <20240620173137.610345-7-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240620173137.610345-7-dhowells@redhat.com>

David Howells wrote on Thu, Jun 20, 2024 at 06:31:24PM +0100:
> Enable support for multipage folios on the 9P filesystem.  This is all
> handled through netfslib and is already enabled on AFS and CIFS also.

Since this is fairly unrelated to the other patches let's take this
through the 9p tree as well - I'll run some quick tests to verify writes
go from 4k to something larger and it doesn't blow up immediately and
push it out for 6.11

-- 
Dominique Martinet | Asmadeus

