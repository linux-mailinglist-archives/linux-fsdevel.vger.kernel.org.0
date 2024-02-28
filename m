Return-Path: <linux-fsdevel+bounces-13050-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72CA786A9AC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 09:17:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A51241C21E7F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 08:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D8772C693;
	Wed, 28 Feb 2024 08:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fTur8TIz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776932C1A2;
	Wed, 28 Feb 2024 08:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709108261; cv=none; b=az+K6NmqpMrsGLdRxTefLDPdaODtlHRIFQkOghkRJl5Z5yGdiSwaOAH9lZhaTKLclbzLzVI9JllRiJ/Ls4YxDLZ9iR/GgDRojfR5bPFB3uwK2S20dhzDrosc9IwH67vz8VQ0vajFRAaqqfC7giatk9FROvBPmHZoHPwqXxBg/a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709108261; c=relaxed/simple;
	bh=Y3EcQMURp+X/fj2G6gGGj+3xMPUNx7Rffbb+5/x/u6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pBxEl7HSc52dfY7NsIeeEwryQRNGoUxZaBJSIZAy1cL1g6yEM6UD7NG0Tc/Ro9GCV+MCR0YOkFtOq7c+SXWPJkl9bZkOtMbntVB2A7UCNMduL8YNyOOENwxLOrmAMtk5L+/mygUwXi0JuNGlRzvreSc6bqq+VlsGOXiYeGu+TxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fTur8TIz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 712A1C433C7;
	Wed, 28 Feb 2024 08:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709108261;
	bh=Y3EcQMURp+X/fj2G6gGGj+3xMPUNx7Rffbb+5/x/u6Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fTur8TIz9o5O3e+pi4c5d6cSY2wNj8UgCCY+1TrxDDRJDanWPGqDgTZh1Io7v6o5v
	 ERo0sFYH096847xlZ1nz046/omE5CqMKYulYmEavF7B3o77trkbsKRlgtLNVBeyrVe
	 GBMyDnvpjgjsSlgYInkD767ml9fCFa5qFqzqeYCLeBGvCT0ks9CCIoc+tHmruK/j79
	 gKUTSGSDsJUHN2ngaM/YLwUFBqgYSLganyf0IG3rsormb3nbvWM3xMrjg7+e/vClGN
	 q9G/IJHucJJ947Rv+41xcJAso6scPAyzDiD196ruln/tS6rtwvMOkvUelKHY01kuB8
	 lBaCD0DSoLcRg==
Date: Wed, 28 Feb 2024 09:17:33 +0100
From: Christian Brauner <brauner@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: John Groves <John@groves.net>, John Groves <jgroves@micron.com>, 
	Jonathan Corbet <corbet@lwn.net>, Dan Williams <dan.j.williams@intel.com>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>, 
	linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev, john@jagalactic.com, 
	Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@infradead.org>, 
	dave.hansen@linux.intel.com, gregory.price@memverge.com
Subject: Re: [RFC PATCH 11/20] famfs: Add fs_context_operations
Message-ID: <20240228-absaugen-lassen-220d7a3926d3@brauner>
References: <a645646f071e7baa30ef37ea46ea1330ac2eb63f.1708709155.git.john@groves.net>
 <20240227-mammut-tastatur-d791ca2f556b@brauner>
 <6jrtl2vc4dmi5b6db6tte2ckiyjmiwezbtlwrtmm464v65wkhj@znzv2mwjfgsk>
 <8bd01ff0-235f-4aa8-883d-4b71b505b74d@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8bd01ff0-235f-4aa8-883d-4b71b505b74d@infradead.org>

> plus David's userspace man page addition for it:
> https://lore.kernel.org/linux-fsdevel/159680897140.29015.15318866561972877762.stgit@warthog.procyon.org.uk/

Up to date manpages are
https://github.com/brauner/man-pages-md

