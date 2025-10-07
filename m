Return-Path: <linux-fsdevel+bounces-63540-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 11138BC1158
	for <lists+linux-fsdevel@lfdr.de>; Tue, 07 Oct 2025 13:08:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CFA454F4F18
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Oct 2025 11:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 448282D94BD;
	Tue,  7 Oct 2025 11:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qPI2eury"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB08165F16;
	Tue,  7 Oct 2025 11:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759835277; cv=none; b=oW+3NWw6VGlfqHFDwocwJoJCeuFYppOhRr8987sxFSAjUxErI3UHNEUaSwD/3ERxtZwc0PNU2oMFmFVY+oH6VOZa+3i+XKOA8FMKt/2YmU6kDLu9b5qZ1sVHSZgEY19dTkMjaenrgN6xVF1+IgAIffhZmDUsDRQqcsI1bJh2tPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759835277; c=relaxed/simple;
	bh=eC6s5Z4dbum2VX6t+mnZh8hkQrlFQpqrsujSHhwkOTc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mbaCO2qVxFBXUNqjcetnLnv7RPokQutGFbouZ1dkGZu9idfSUyNicbM0owyp5rIklKDtTHIOwq1kIbeb9QQQMff7m1K42gWn1auFpSFtE0sowlkqwTc5Vyd3u19SFXXNxiOzmTSt6MH8UegOIm/PYdfKvSrogMY7e+btpoc9Uhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qPI2eury; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1DF8C4CEF1;
	Tue,  7 Oct 2025 11:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759835276;
	bh=eC6s5Z4dbum2VX6t+mnZh8hkQrlFQpqrsujSHhwkOTc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qPI2euryOCDC/73P1JU2bmweSbpUlA/XB1kB7ZiI+jAn40y0iHOH1AOAXHz1alUBu
	 eV79zL6t2+Ea6eRP0P+b7QOGJkP6SwKm88EChzNXIcOnco+XbOyeE4RPu9IQOsaBKf
	 ASQfNsRW6UiXzKrvcoDfe3wk5+FpVMuRkxlSJiOb6u2ErNzjAtQjVaoWsJcaVw0HSx
	 iZrK2w8Ar13PM267BjS3NWkbUZfXhQbqZkLrtHEZTfMVZMcOILUlduWfMMRtuanPjZ
	 zw9g8tMfEqldOocIsNLSaHLxAwhsJQWBHpPCMVmvPEJEapU8jtwdIFtozxr4sjmgmc
	 FJK2XGGysXIGA==
Date: Tue, 7 Oct 2025 13:07:51 +0200
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, kernel-team@fb.com, amir73il@gmail.com, 
	linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, 
	ceph-devel@vger.kernel.org, linux-unionfs@vger.kernel.org
Subject: Re: [PATCH v6 0/4] hide ->i_state behind accessors
Message-ID: <20251007-warnt-abrutschen-7a6363ce6c54@brauner>
References: <20250923104710.2973493-1-mjguzik@gmail.com>
 <20250929-samstag-unkenntlich-623abeff6085@brauner>
 <CAGudoHFm9_-AuRh52-KRCADQ8suqUMmYUUsg126kmA+N8Ah+6g@mail.gmail.com>
 <20251006-kernlos-etablieren-25b07b5ea9b3@brauner>
 <CAGudoHGZreXKHGBvkEPOkf=tL69rJD0sTYAV0NJRVS2aA+B5_g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGudoHGZreXKHGBvkEPOkf=tL69rJD0sTYAV0NJRVS2aA+B5_g@mail.gmail.com>

> I rebased the patchset on top of vfs-6.19.inode and got a build failure:
> 
> fs/ocfs2/super.c:132:27: error: ‘inode_just_drop’ undeclared here (not
> in a function)
>   132 |         .drop_inode     = inode_just_drop,
>       |                           ^~~~~~~~~~~~~~~
> 
> and sure enough the commit renaming that helper is missing. Can you
> please rebase the branch?

Done. Thanks!

