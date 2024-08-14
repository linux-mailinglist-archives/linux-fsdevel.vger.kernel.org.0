Return-Path: <linux-fsdevel+bounces-25876-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D4CBE9513E0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 07:24:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77437B24761
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 05:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E7396F2FE;
	Wed, 14 Aug 2024 05:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="LvThM5KO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081BA4D8BA;
	Wed, 14 Aug 2024 05:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723613065; cv=none; b=DjT+jU2ZNOiR46Woop+qxDDL1l8nds/Na3SdZT9P/qlvT9fEU7fsiOS9mxaT5NCntyUS/AMMxAyjDeho8B+X3Oz6qDPdttieYfiHUwLhdX6qEXYilI61h7/qyfYWFylZxCFk0YxnO+NxDhz6cWYFfEQawgsLiaYeAOHblWpPASM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723613065; c=relaxed/simple;
	bh=ZAxxOYNWehSCcsvm+tNpKLI6CNfyAHPQyJL2dWJ2xXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V6RWARSZpHcUqy4CFuimM38ZWrAyi0EhoFQY+MOQidUll8hkyWAVBJzHeQRMM/GKunYslKpFwpnI0Dlq2W4GMWVyylaYN/Is10HyUnjzUGd8M3g6598tbM8990Yo+acD7k0+AEnmzkcLQrmn95Dn13r3wNLOoH2LJHxmZKxEkn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=LvThM5KO; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=0XbH8lvWz6AYn1hoDnaXp0aSyYrZKSg2GPlTNlTDaw4=; b=LvThM5KOND2zbY450Yu4JNsE/c
	Yc4iYTfxaxspkUpDkFyfb9xqOad4Jq7rUeJ9q/f2Ynt+DLa4zdOQm4EhAKfKYzxooP9BHpId+yRAH
	ufLlImG1F+VKhucBj02+VaJZKDLF7zCG9m2p7O2OwljfOy69BlkbZI/qRFxeTbQbg0N3eb90rTn5T
	0CsrgS+lMsWcSq7t/VrcxEEYy2O/GjmxcI0+tePd2QsBfpJVpecNWfrqS/3q93Lha0BwMwEADMt75
	Yn4YnqNDeYKuMpminc9/JCZmMFCQyc+/X5Wp8Ni+MIxaI+MYMUOo/MuIweE1fmOPNoTIAs1/0AUyv
	lAksTCmA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1se6Uf-00000001WWr-06rn;
	Wed, 14 Aug 2024 05:24:21 +0000
Date: Wed, 14 Aug 2024 06:24:20 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, jack@suse.cz, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] close_files(): reimplement based on do_close_on_exec()
Message-ID: <20240814052420.GQ13701@ZenIV>
References: <20240812064427.240190-3-viro@zeniv.linux.org.uk>
 <20240812075659.1399447-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240812075659.1399447-1-mjguzik@gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Aug 12, 2024 at 09:56:58AM +0200, Mateusz Guzik wrote:
> While here take more advantage of the fact nobody should be messing with
> the table anymore and don't clear the fd slot.
> 
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> ---
> 
> how about this instead, I think it's a nicer clean up.

> It's literally do_close_on_exec except locking and put fd are deleted.

TBH, I don't see much benefit that way - if anything, you are doing
a bunch of extra READ_ONCE() of the same thing (files->fdt), for no
visible reason...

