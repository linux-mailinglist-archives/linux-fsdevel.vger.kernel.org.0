Return-Path: <linux-fsdevel+bounces-18988-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 543ED8BF440
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 03:49:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F56A2838BD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 01:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1460E8F6A;
	Wed,  8 May 2024 01:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="RPktVsdW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05AD21A2C2C
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 May 2024 01:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715132941; cv=none; b=UguegxxiEFihFYWv0KOeFSyGaCwasYZjXcih4QDjWK45KTiRQLzmHD1YyrP/hExfqNUigMQr6mVql6K2cwt5nwOxczVfkPOlVDyfaVqOAUdof72wwx1PXPn+V4Dg1nDTtS6SmNsSZlOg/MFmvMcJaF5U0y8UWgXoLDfGxFuhCVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715132941; c=relaxed/simple;
	bh=vB4aAFbIqynhJfjHMP3jKbQOFhqxTGo5YH4GFVn1b5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iuqStbjcCLUZFnAP2DxqLmOk5xPPf19I+ZbVgQy2hJQfBSNxyfDQRrgLoJ+VeuEcv9Zkk6cX2sUvMmcKMt9ECHkGh3gH8n7Hl5LlfXzYYOogHe9yAMx25bDry7cz76FO7S8RSSKClxi4UWkZxErJBydoFVmIFZ2VNm02PocIkJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=RPktVsdW; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=tBTlk6OSvFg2fmOi1WySncbsOzcElRbYthnvoXpfERE=; b=RPktVsdWBDX4bGmJ6pLMNZSLfi
	3ANTVUE7RaDygCR7xWgFRvEfjDMDqhpzXz/Ob/p9Kd1iGgaxXpG9SEJcgIdO8F15atyw6U8KFwt4X
	zP1cbLiMkyQsJPEUFlOESzWrtPiRGs2UE56+OeCR0ZggiiLLk3LJXKfUJrVDM+FV6vlav7CNxvtW0
	0eDmp6X8h4MyJqlPJwS49YD8OuX0J7hH1ki/ISY2Gb6UNEIF51JV/3NVkkgDua0f1SzD9dD6ejfe8
	Fb9U/7E+OwyBnTLe0ymf9NPm6PCGpSxWWcHTGNlZfOw/yY8dK1HBgwtC3B/gz0Kgwcxjy6IJ4SnCF
	MJTDa5Qw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1s4WQR-00FfPH-0P;
	Wed, 08 May 2024 01:48:55 +0000
Date: Wed, 8 May 2024 02:48:55 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Dawid Osuchowski <linux@osuchow.ski>
Cc: linux-fsdevel@vger.kernel.org, brauner@kernel.org, jack@suse.cz
Subject: Re: [PATCH v3] fs: Create anon_inode_getfile_fmode()
Message-ID: <20240508014855.GN2118490@ZenIV>
References: <20240426075854.4723-1-linux@osuchow.ski>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240426075854.4723-1-linux@osuchow.ski>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Apr 26, 2024 at 09:58:54AM +0200, Dawid Osuchowski wrote:
> Creates an anon_inode_getfile_fmode() function that works similarly to
> anon_inode_getfile() with the addition of being able to set the fmode
> member.

One note (followup commit fodder, probably in series with conversions to
that interface):

> + * @f_mode:  [in]    fmode

> + * setup. Allows setting the fmode. Returns the newly created file* or an error

is ambiguous - with no further information it reads as if we passed the value
to store in ->f_mode, which is not what's going on.

Something along the lines of

'f_mode' argument allows to set additional bits, on top of the ones set by
anon_inode_getfile() (FMODE_{OPENED,READ,WRITE,LSEEK,CAN_READ,CAN_WRITE}).
The caller should not pass those in 'f_mode' - they will be set according to
'flags' and 'fops' in all cases.

