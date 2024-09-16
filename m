Return-Path: <linux-fsdevel+bounces-29528-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0052697A777
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 20:51:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B691B2865EF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 18:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B6016131A;
	Mon, 16 Sep 2024 18:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VZub7Ckf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8B915FA72;
	Mon, 16 Sep 2024 18:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726512662; cv=none; b=aP1CBUqgheQa8S/0hADUzyk9J8yhQQ4lsX3nyAtqSfJypwIuDZjuh6lkXXY1Uq7Ve6XwxcADPh6jwWD1++ZlmpTvE33AADOxNw3ovfHRBIJ8mgttLNrOcBHrf0ptAo0H2uACcVOHoOs8idAf/o5YEL2XKPRoEI52IHVGSlbiwHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726512662; c=relaxed/simple;
	bh=kmvv0I4Ktqu9r1ximFiGLBL2DIIDeLyJoXWdA9l9kAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dk9g/BTvHZKFZfpKQWiLjp0uB0Sw0c9ihMvu/b3UG+WnaQwkemZ4JafCgplrpdWw8MBvaEh4t26/9mJYhuJNjUkwjpfL+Ls/ad7olbvqzQJinhxpaiSymvrbwOjhFqb2sgQ/dj4z5ZHHuVNvZVUInyyTAyK2bM4qbxs6z2AJ9i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VZub7Ckf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C5A3C4CEC4;
	Mon, 16 Sep 2024 18:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1726512661;
	bh=kmvv0I4Ktqu9r1ximFiGLBL2DIIDeLyJoXWdA9l9kAs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VZub7CkfnbGEVyQuEiC5+fKJkjCjtcPNanvKH5G9tdavMr+MyMgnhMoA6PmrH2O+5
	 fhV4BJDeKKXX8Qv0A95z0lnbLHzZWjdr2y8MBHiDFamcySYILeqhiTUwbVCn5W3T7H
	 P/GlkdG/6KNCN+/qTQy7KWU5LMlN7S4130oqvanw=
Date: Mon, 16 Sep 2024 19:55:43 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Yiyang Wu <toolmanp@tlmp.cc>
Cc: linux-erofs@lists.ozlabs.org, rust-for-linux@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 02/24] erofs: add superblock data structure in Rust
Message-ID: <2024091655-sneeze-pacify-cf28@gregkh>
References: <20240916135634.98554-1-toolmanp@tlmp.cc>
 <20240916135634.98554-3-toolmanp@tlmp.cc>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240916135634.98554-3-toolmanp@tlmp.cc>

On Mon, Sep 16, 2024 at 09:56:12PM +0800, Yiyang Wu wrote:
> diff --git a/fs/erofs/rust/erofs_sys.rs b/fs/erofs/rust/erofs_sys.rs
> new file mode 100644
> index 000000000000..0f1400175fc2
> --- /dev/null
> +++ b/fs/erofs/rust/erofs_sys.rs
> @@ -0,0 +1,22 @@
> +#![allow(dead_code)]
> +// Copyright 2024 Yiyang Wu
> +// SPDX-License-Identifier: MIT or GPL-2.0-or-later

Sorry, but I have to ask, why a dual license here?  You are only linking
to GPL-2.0-only code, so why the different license?  Especially if you
used the GPL-2.0-only code to "translate" from.

If you REALLY REALLY want to use a dual license, please get your
lawyers to document why this is needed and put it in the changelog for
the next time you submit this series when adding files with dual
licenses so I don't have to ask again :)

thanks,

greg k-h

