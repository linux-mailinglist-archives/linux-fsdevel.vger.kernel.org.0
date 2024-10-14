Return-Path: <linux-fsdevel+bounces-31835-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD45299BFCE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 08:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76B7F284244
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 06:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FC4513D893;
	Mon, 14 Oct 2024 06:10:25 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696C42D600;
	Mon, 14 Oct 2024 06:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728886224; cv=none; b=kmbj2HAajPb8aD4sHTvvpkjDBGEQf19OcuJd3kafojM6s49YUX3Nf1NYcAv2ZizuJhk3sNn+CQMBuyO/28lZqAb82NC2fkIXNMLaLY7R267kHKyNJHqlA5DgsVRY8n3HvsEEkllnoAwaVDmyYPFEzJe1/F9SrOPiSd+dQATk8hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728886224; c=relaxed/simple;
	bh=GpQFIiBqe63XJeYE1y6uc75KtkEhwgax+gTxtBh9Kl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rFa1ofksQzYUuCf013IGdGtYjVRVS9Ij6Z/oxzjjIsTqvalgGIh8JeeTaOdhZv9gLYwodvq9ARwFS+POyUXBdgmCUk/huSAVFDKrIzLbHIr3/AVpcXNJtooAXnDmIrNDd4yecKwE8Ys23xblbL8sX+PHup9PIPs9muXnA0jy7uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5ED12227AA8; Mon, 14 Oct 2024 08:10:19 +0200 (CEST)
Date: Mon, 14 Oct 2024 08:10:19 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] bcachefs: Fix sysfs warning in fstests generic/730,731
Message-ID: <20241014061019.GA20775@lst.de>
References: <20241012184239.3785089-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241012184239.3785089-1-kent.overstreet@linux.dev>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Sat, Oct 12, 2024 at 02:42:39PM -0400, Kent Overstreet wrote:
> sysfs warns if we're removing a symlink from a directory that's no
> longer in sysfs; this is triggered by fstests generic/730, which
> simulates hot removal of a block device.
> 
> This patch is however not a correct fix, since checking
> kobj->state_in_sysfs on a kobj owned by another subsystem is racy.
> 
> A better fix would be to add the appropriate check to
> sysfs_remove_link() - and sysfs_create_link() as well.

The proper fix is to not link to random other subsystems with
object lifetimes you can't know.  I'm not sure why you think adding
this link was ever allowed.


