Return-Path: <linux-fsdevel+bounces-62009-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4EB4B81BED
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 22:20:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14CF37B8D65
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 20:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BA182C1786;
	Wed, 17 Sep 2025 20:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="k1y4C/2k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3748F27E040;
	Wed, 17 Sep 2025 20:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758140439; cv=none; b=aZ1h1O/FGDAfiGLx9bidvO4gGPqSvvVb3wibRMpbJjJVF2yT+ftRVEsYMWcl/4Al238nukkqPg8Kqiu1JCWg1ytUVn6weHfmYYZybhJ9siF6Ex64ZGjcqhaHMxjHFpoupyFESXnC2pU8TpCKNeWmSwuaYCndcjIyCM+JRMZUKj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758140439; c=relaxed/simple;
	bh=glhqlOnfKMnauJ8Fygiqi0Dw8+zleynbR5MdeN9v1kU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NyxVuab4NGlSq7ghSghiJzRgIQ0W8Oz3mZR18yuLN1pP0HzFQTzSFoqdYrAWm/9hfPKqWgSaAZKZhfuKRI9Cw5kUng6ISUnWEpVstTiEVX4McmCag/Jox997QjZT+ewh9i5YC0MHuLgCEAemgO8GZPS3oY5rmkGgNg+42Vn7MII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=k1y4C/2k; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=O7lufThkntzMoSvlQD132Nedr3MEU/c4BaRfi31q/AM=; b=k1y4C/2kTJ1GFD8XbaylSvuocS
	T91Ow2UGAym3pQz7E2dxhlmTWZlkqOgeIkv4N5zis8BbTvXlCMzlWx6OBqv1xmnLEzyWtTIWFUOC5
	hsO3h3CMGyOAQer635CaY4Z7UHViJNMk79nMVQoMj8A4qrMJH5EkZ5xU180GVBtkO7jwfKah+G0+4
	KMWCqmBMl6Ywn+e+Rt2kZ4ZwfjdRwSc4NMB4RMpcuLDikYa1vlZc/11gBh2Kd0gFeUehApFVMdEEL
	Rrjw91LfAMOba8IbOBnr3Cwq/hItSnHUMtcoFs8O7YuxXeHYqyIDzApo0QySCgDfHmmKqKe9IE14E
	Q4fnMoOg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyydl-00000007gRK-1k57;
	Wed, 17 Sep 2025 20:20:33 +0000
Date: Wed, 17 Sep 2025 21:20:33 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: slava.dubeyko@ibm.com, xiubli@redhat.com, idryomov@gmail.com,
	amarkuze@redhat.com, ceph-devel@vger.kernel.org,
	netfs@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Mateusz Guzik <mjguzik@gmail.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] ceph: fix deadlock bugs by making iput() calls
 asynchronous
Message-ID: <20250917202033.GY39973@ZenIV>
References: <20250917135907.2218073-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917135907.2218073-1-max.kellermann@ionos.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Sep 17, 2025 at 03:59:07PM +0200, Max Kellermann wrote:

> After advice from Mateusz Guzik, I decided to do the latter.  The
> implementation is simple because it piggybacks on the existing
> work_struct for ceph_queue_inode_work() - ceph_inode_work() calls
> iput() at the end which means we can donate the last reference to it.
> 
> This patch adds ceph_iput_async() and converts lots of iput() calls to
> it - at least those that may come through writeback and the messenger.

What would force those delayed calls through at fs shutdown time?

