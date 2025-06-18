Return-Path: <linux-fsdevel+bounces-52001-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 491D5ADE2B6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 06:44:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9D957A2EB1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 04:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A68D1F12FB;
	Wed, 18 Jun 2025 04:43:49 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE9B1E832A;
	Wed, 18 Jun 2025 04:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750221829; cv=none; b=EfO/IA1BmUocGCFl7tJ0gyV/HWSrd2+5aaqXBunO+XHuhguRY/EQkljWc+Rttk6PNraX3wEgPeZ60SbOlecwTdnT8A46UxT6VNbQNUvMV0qdYceRJSeeviuxd5C0cWOFiFIbhPcE1JIH2789p7e9hiEQggGTgDkQoz7L6fZywEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750221829; c=relaxed/simple;
	bh=AOQ86z9+nFnTXf57Z8R4fmoJUJmagNG7yIggknqNc0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F34mPAJeYsfbRnSPFPdEpAL+eprd0raEhL46q8TKdxlXalDIpmihjmYFS4ahfyz9E9sA1jVEyQ+hyBTd25qTYgdVIYsSHE8IDwTrZfCIhd8xCJSUjSNLuEh8riOU2TfkRv6CI5ZNqlMRMtIC+WkP6kaGZRap+uhxp7ekN+NbFPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 68E6E68D15; Wed, 18 Jun 2025 06:43:44 +0200 (CEST)
Date: Wed, 18 Jun 2025 06:43:44 +0200
From: Christoph Hellwig <hch@lst.de>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-block@vger.kernel.org, gfs2@lists.linux.dev
Subject: Re: [PATCH 10/11] iomap: replace iomap_folio_ops with
 iomap_write_ops
Message-ID: <20250618044344.GE28041@lst.de>
References: <20250617105514.3393938-1-hch@lst.de> <20250617105514.3393938-11-hch@lst.de> <CAJnrk1YOtCnAD2R5G1sYipG=aTkWBdYfm-F0iioV55sE5A_HYQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJnrk1YOtCnAD2R5G1sYipG=aTkWBdYfm-F0iioV55sE5A_HYQ@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Jun 17, 2025 at 03:25:43PM -0700, Joanne Koong wrote:
> >  vm_fault_t iomap_page_mkwrite(struct vm_fault *vmf, const struct iomap_ops *ops,
> >                 void *private);
> 
> Maybe you'll hate this idea but what about just embedding struct
> iomap_ops inside iomap_write_ops?
> 
> eg
>  struct iomap_write_ops {
>         struct iomap_ops iomap_ops;
>         struct folio *(*get_folio)(struct iomap_iter *iter, loff_t pos,
>                         unsigned len);
>        ...
> }
> 
> and then only having to pass in iomap_write_ops?

That would only help use with the first layer of calls, as that already
"consumes" the iomap_ops.  So I'm not sure if that's really all that
useful.

