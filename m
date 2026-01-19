Return-Path: <linux-fsdevel+bounces-74407-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F3DBCD3A1B0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 09:34:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E7C18303AE89
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 08:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D73533F394;
	Mon, 19 Jan 2026 08:32:59 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37A233CEA2;
	Mon, 19 Jan 2026 08:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768811578; cv=none; b=YDA+hUZmqZWoIEkRDi822UxgdRtgCNnppihlrRtae8806ZeYNitJSRzED8OQDbmzwyXIE7rKw2JWxPwe0HNGRadkDm1F1AqPkzSMlIWDrVBokJNoX1miBKzMlZ3vQrCnfzXkaq44hVD4ZiktOZ6VNsoQJp9II+l+tIzgfgireSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768811578; c=relaxed/simple;
	bh=blKTkVXbfR4T3/PtCN0leNvZZa9/BJgRBGhK2T6VzFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bMb+KpTk1z9vy10qkyiYqH+1rDQgiu6EOxIX5bFOybdlv2PS4NM9Cy5UFGCe2EIVx/vDidJotMf9gKTZKH6q6A1uVRfXexai8xLjbDCro3WKVA1h14ohsFk17+2whieOiv2S79RBJzcAqnEuwcDerTILSdVGkqtRkvkw/9/OU3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id F41E4227A88; Mon, 19 Jan 2026 09:32:51 +0100 (CET)
Date: Mon, 19 Jan 2026 09:32:51 +0100
From: Christoph Hellwig <hch@lst.de>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Christoph Hellwig <hch@lst.de>, Hongbo Li <lihongbo22@huawei.com>,
	chao@kernel.org, brauner@kernel.org, djwong@kernel.org,
	amir73il@gmail.com, linux-fsdevel@vger.kernel.org,
	linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v15 5/9] erofs: introduce the page cache share feature
Message-ID: <20260119083251.GA5257@lst.de>
References: <20260116095550.627082-1-lihongbo22@huawei.com> <20260116095550.627082-6-lihongbo22@huawei.com> <20260116154623.GC21174@lst.de> <af1f3ff6-a163-4515-92bf-44c9cf6c92f3@linux.alibaba.com> <20260119072932.GB2562@lst.de> <8e30bc4b-c97f-4ab2-a7ce-27f399ae7462@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e30bc4b-c97f-4ab2-a7ce-27f399ae7462@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Jan 19, 2026 at 03:53:21PM +0800, Gao Xiang wrote:
> I just tried to say EROFS doesn't limit what's
> the real meaning of `fingerprint` (they can be serialized
> integer numbers for example defined by a specific image
> publisher, or a specific secure hash.  Currently,
> "mkfs.erofs" will generate sha256 for each files), but
> left them to the image builders:

To me this sounds pretty scary, as we have code in the kernel's trust
domain that heavily depends on arbitrary userspace policy decisions.

Similarly the sharing of blocks between different file system
instances opens a lot of questions about trust boundaries and life
time rules.  I don't really have good answers, but writing up the
lifetime and threat models would really help.

