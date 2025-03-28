Return-Path: <linux-fsdevel+bounces-45188-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E510A74470
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Mar 2025 08:43:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0F54189FFA4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Mar 2025 07:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11517211A21;
	Fri, 28 Mar 2025 07:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JViAqne8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4708118871F;
	Fri, 28 Mar 2025 07:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743147811; cv=none; b=mA1ogNCb41WVMZIWpkKsxLNHpQo1mTjJ11gZ4Tq/OZ3XtXJLwK882I/s5qvl0d2uWg/WNnkEfY37ERd/xr2FBSJvLQTiswL3hoM4xRTT39L0+hcL0J7V7ikMe1KNq/ph5davXHFtgo2HjC/NNUP/TLiCvht7KkxoPn+6gud1Ph4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743147811; c=relaxed/simple;
	bh=HqrgN/kiCOdnp2YxSRvS8lrUEYa7kvy1aqPS8ARDJsI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qbltrQgi47BPs41zbTL6VbUgwF/koWxkIAaq9lMR22MoyPe39kY8uVZri7JaweMe/270T07X9NdDzJaheORtDm8PiwQt4lZUrIYQZhhWuEGLOIbK4xO2zMgp5BoxJlvBrYna4n/eSy2BqzHunqe8FKQIurVEj9e6mfrP9RTLTCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JViAqne8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34AFBC4CEE4;
	Fri, 28 Mar 2025 07:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1743147810;
	bh=HqrgN/kiCOdnp2YxSRvS8lrUEYa7kvy1aqPS8ARDJsI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JViAqne8L+4nVh7OSTX0X75X9EVXn84ibLHcRNOrFC8jtC3o0Ww+TAfYfqgL6F+lJ
	 pOGB/4nxFBi0kcsN4DWPLjNgARnOxyv+b1Y9FS4/uEu3vjKcsi5sYlAHC8s0s105Sz
	 50mFLJii71PPViU5fGssQim/tJ1c9ZgweUhv861M=
Date: Fri, 28 Mar 2025 08:42:06 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Leah Rumancik <leah.rumancik@gmail.com>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>, stable@vger.kernel.org,
	patches@lists.linux.dev, linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, broonie@kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Dave Chinner <dchinner@redhat.com>,
	Christoph Hellwig <hch@lst.de>,
	Anders Roxell <anders.roxell@linaro.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 6.1 000/197] 6.1.132-rc2 review
Message-ID: <2025032853-property-riches-0166@gregkh>
References: <20250326154349.272647840@linuxfoundation.org>
 <CA+G9fYsRQub2qq0ePDs6aBAc+0qHRGwH_WPsTfhcwkviD1eH1w@mail.gmail.com>
 <CACzhbgQ=TU-C=MvU=fNRwZuFKBRgnrXzQZw15HVci_vT5w8O7Q@mail.gmail.com>
 <CACzhbgTQCuig6eqOJFshthQfT5-7cVkemY9VtO_vu4d+aTcU=Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACzhbgTQCuig6eqOJFshthQfT5-7cVkemY9VtO_vu4d+aTcU=Q@mail.gmail.com>

On Thu, Mar 27, 2025 at 04:19:16PM -0700, Leah Rumancik wrote:
> sent to stable:
> https://lore.kernel.org/stable/20250327215925.3423507-1-leah.rumancik@gmail.com/

Now queued up, thanks.

greg k-h

