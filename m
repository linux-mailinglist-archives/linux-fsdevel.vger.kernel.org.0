Return-Path: <linux-fsdevel+bounces-53749-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E05AF66C6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 02:25:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DD314E08E0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 00:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 686296EB79;
	Thu,  3 Jul 2025 00:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="sjEVK9p5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CED4AD2D
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Jul 2025 00:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751502263; cv=none; b=IJKXuTN3xV2Otxi+B+aQf1FxvjkWELpUIf8PKMSFsx+bu920sxs+fueRxHk7mvfJqLcafaoTXBm5X2Na31ecrSIvt29v3dzRQBy4pEd4aMLDbWe/OnYC8CHhzbgKCaMgWCnzfMlPDR8vvzAug4T+RitHftHxU5g4i/dubbxSK/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751502263; c=relaxed/simple;
	bh=MEe3SZezYRW+ZuP6A1hGdjrx3qmXcDGATiz6gihlTIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZK9pZ2yLZ46P3Njqw0zeroMf+M65S1NZsZo7N3OvyWaiKLGAUSd5+QLYLaCViHc3UMmKYCDYrRCeIBEX+K86UTDSHoZEJFTG9e6umofgb6k0nz3fpX7GEEhgK/MliPO+OkSLGfjqz7wAUGF9YEZobdRcBCltteuvJZv4DFan5YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=sjEVK9p5; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=AQL0Da0AwggEfC02l66LJEskGto59huTDAht7/y1ON8=; b=sjEVK9p5Z0xlMwWP/4mhAJOz1o
	hJjsnku9IxQkSmSGiE1nR8ChOdxDCAthf3Q/Fr/2R/cvcZkNHasmuMrzvcK8V2ycHEz21/YM3h+LO
	aIk2IROFGZWkZF88ZwtlFkwzM9II3slQ7NEWTw3cWn+Z5680qvhbsMCyi+SvCj0H4nlRj7ar9/Lzc
	cAROY48VuVpPbLSiUkKCbft8CzZVd1qLbDOMZTq5JxH+zdir98EJeiCVJ6e4Cyhkm6hvarlrPWXkf
	PNMKHGir9pgQAkB1l15UUYGL4mZqQWZyuD+6PANLAkZSkldvuKu/n/DVJVdWPtVmUZnyoLd16bSON
	0g9I6abg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uX7kR-0000000FcKy-1Yhg;
	Thu, 03 Jul 2025 00:24:19 +0000
Date: Thu, 3 Jul 2025 01:24:19 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Reinette Chatre <reinette.chatre@intel.com>
Cc: "Luck, Tony" <tony.luck@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 04/11] resctrl: get rid of pointless
 debugfs_file_{get,put}()
Message-ID: <20250703002419.GG1880847@ZenIV>
References: <20250702211305.GE1880847@ZenIV>
 <20250702211408.GA3406663@ZenIV>
 <20250702211650.GD3406663@ZenIV>
 <aGWjig2vNfmtl-FZ@agluck-desk3>
 <36094bb2-5982-472b-b379-76986e0c159c@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36094bb2-5982-472b-b379-76986e0c159c@intel.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Jul 02, 2025 at 04:45:36PM -0700, Reinette Chatre wrote:

> Thank you very much for catching and fixing this Al.
> 
> Acked-by: Reinette Chatre <reinette.chatre@intel.com>
> 
> How are the patches from this series expected to flow upstream?
> resctrl changes usually flow upstream via tip. Would you be ok if
> I pick just this patch and route it via tip or would you prefer to
> keep it with this series? At this time I do not anticipate
> any conflicts if this patch goes upstream via other FS changes during
> this cycle.

Up to Greg, really...

