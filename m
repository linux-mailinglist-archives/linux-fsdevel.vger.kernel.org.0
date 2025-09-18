Return-Path: <linux-fsdevel+bounces-62140-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A1258B8566B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 16:59:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 90B334E0279
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 14:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD5C30CB36;
	Thu, 18 Sep 2025 14:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iQ+2jQI9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9426E34BA50;
	Thu, 18 Sep 2025 14:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758207544; cv=none; b=JlA5RbxHOvSC1qxCWHJi00373E/Vx1YFCUiXMNpUhXb9LwVO26CGbUtSH8+20bA9iWW9f4EfHukkMFp3eJb2CbW2Lnqa6rDeaGIiPFyXJtrUtltJVNkocO9QiBdKx11URF+Dvb7Axpu9noR4IQ6xgAqA0X9ymHtphQ6CuGtEtPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758207544; c=relaxed/simple;
	bh=NbnQHP/x9fdVA6Gmifgb4tIfPjGRsO8E5Ee/I/OjmWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CDbUsIphWpf+IOcodl/kiTTGtBGzf3aW6PAkWfDyhcPvPesrzKMdfrc4h8b1pmB3zFFDhX7VOKDd6PvhCK9Y05P64LZiCDJ7FtLWxsgSo3dfh/MHULMAKtU2ALkWTjRwPYXUb6+kk1MpdfhFsYUhs+bW5I3KfvxsEKiGlCjgPkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iQ+2jQI9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3038C4CEF7;
	Thu, 18 Sep 2025 14:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758207544;
	bh=NbnQHP/x9fdVA6Gmifgb4tIfPjGRsO8E5Ee/I/OjmWA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iQ+2jQI9RT0iC1DT1JhK4LS0FmK2czeJSxJM1ILa/pK/crf2cv9qG4Dg67x3iLfiJ
	 icVfo/RnTjqYq5QYbUPWVcUnnHQuxpNy2NuEm+Ypu1zee9Qb5vXOaQCG9zJ+9F8H92
	 dup6Ft09vEREUR9Q0ZupAyU6RYm3UL9GQRmWKX6g=
Date: Thu, 18 Sep 2025 16:59:01 +0200
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: ManeraKai <manerakai@protonmail.com>
Cc: "aliceryhl@google.com" <aliceryhl@google.com>,
	"arnd@arndb.de" <arnd@arndb.de>,
	"rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] rust: miscdevice: Implemented `read` and `write`
Message-ID: <2025091820-canine-tanning-3def@gregkh>
References: <20250918144356.28585-1-manerakai@protonmail.com>
 <20250918144356.28585-3-manerakai@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918144356.28585-3-manerakai@protonmail.com>

On Thu, Sep 18, 2025 at 02:45:36PM +0000, ManeraKai wrote:
> Added the general declaration in `FileOperations`. And implemented the
> safe wrapping for misc.

While read/write is "traditional", perhaps instead you should just
export read_iter and write_iter as that is the proper way forward for
drivers to be using.

thanks,

greg k-h

