Return-Path: <linux-fsdevel+bounces-38147-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E90D49FCE0A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Dec 2024 22:33:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A0087A1B05
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Dec 2024 21:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEEC7148857;
	Thu, 26 Dec 2024 21:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="USutcJPD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21BF413BAD5;
	Thu, 26 Dec 2024 21:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735248688; cv=none; b=qlf++Uz8EcA3IHeMjZ4YQplUBC7EHHSzapyceKvfqFSGPTA/OPv5MwYo4sC1XZMjvRQLvHui32YHMafI5Dy4ENcYjWfE+ULnJRdmCxQsnTbVaCdZWsYt8ONR9tSR4owLAfF7JkfZWxkmQqsjnu1ynRrZXxCzda59P5izr/QuAHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735248688; c=relaxed/simple;
	bh=dGc5teikiejFVCZQoxYI9GVgFhIRviNZq46Lp+ChjLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S4SbPHDvzXbu8ZtzgoEQ0quuBwtDY0UIgkuYCwyhPQIlsCH8Venk+ddHsxjY+vL1NApiOmmIou23yKQYQVvFlRd+HzxPB9LAnmca1HukmqKJ02gZxBXKCI7xUE6C4FWldICAbgUdAD3UeOx6YhDOCWxyaFZnhN1sf4SRytSd/Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=USutcJPD; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=3iU0ybcCVeWhCUb3BTgPLJhPZepJWvreGx+7mpZyeHA=; b=USutcJPDOueSPP7eSXPrfIy/rc
	jOFbsJO1VVzr4wsQ186gl1N+VGGLXMYqKFUnLcyRPYlvVJY4l66ddIOYerNVQ1yz8OQ2jWt5MFpnw
	wfMJYn+V18RvDVPgcFliAeU7a58zaktC02DoEgMzafyRYdgAr3yzRbQmAh+lxEB2anw4D6d9Suaqf
	Zk/SdqcAXI6+LCWLbFPj7o+80GvmUBeBo1GEQkhERNcKOB18WNchaO9CSwGikEBGbV3bDk/tzEx5P
	1sQ4wrz+mX9eVlfF63ki3nzZ6d9kHYEaIM0gwkxqb/YWKYwrxFPe7C/ay8E5W4ODfS/h73zsFBn5u
	kVC1vzOg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tQvRy-0000000CcUR-2GwE;
	Thu, 26 Dec 2024 21:31:22 +0000
Date: Thu, 26 Dec 2024 21:31:22 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Jaroslav Kysela <perex@perex.cz>
Cc: linux-fsdevel@vger.kernel.org,
	Amadeusz =?utf-8?B?U8WCYXdpxYRza2k=?= <amadeuszx.slawinski@linux.intel.com>,
	Takashi Iwai <tiwai@suse.de>, linux-sound@vger.kernel.org,
	Vinod Koul <vkoul@kernel.org>
Subject: Re: [CFT][PATCH] fix descriptor uses in sound/core/compress_offload.c
Message-ID: <20241226213122.GV1977892@ZenIV>
References: <20241226182959.GU1977892@ZenIV>
 <d01e06bf-9cbc-4c0e-bcce-2b10b1d04971@perex.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d01e06bf-9cbc-4c0e-bcce-2b10b1d04971@perex.cz>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Dec 26, 2024 at 08:00:18PM +0100, Jaroslav Kysela wrote:

>   I already made almost similar patch:
> 
> https://lore.kernel.org/linux-sound/20241217100726.732863-1-perex@perex.cz/

Umm...  The only problem with your variant is that dma_buf_get()
is wrong here - it should be get_dma_buf() on actual objects,
and it should be done before fd_install().

