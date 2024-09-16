Return-Path: <linux-fsdevel+bounces-29527-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D7E97A775
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 20:51:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 215BE1C215B9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 18:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E32315DBB2;
	Mon, 16 Sep 2024 18:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="S6yD6dTj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBECF15CD64;
	Mon, 16 Sep 2024 18:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726512659; cv=none; b=tocnDyyFa/WhfAZ7LjElmOxjB0IxTjHaE+JgPsDYHdc4cuyDm5DTNGQOKIt+WkUppRHmrB2qDu91MFxayFXpESL0tFfDpkgb2ZTn/jQGyPfoHB1PK9y5c4BZKag8h/HL7Rqko/oj/CLr2zXwPEhODQE4U2pgqiVieF2vaQH9sa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726512659; c=relaxed/simple;
	bh=UIh1dpfLpZcsRwWvhy2J3nv47RD0JA14+2b7Tr05Khw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N93X28ik1Bn4zT8k0coHKNRMTBwxI3oifx0cD/K1jcIMZ4rMG4yQmJQxKprIr4J7jQ3JyilDHm/V0tsE0h3X7uagc6/qDtfpY08QeVZ8g46WxtjRq4oY5ix7/ZGvDXP2dMMfEj113J3NuqXde3XEFtgPrZgTbaCdiKNh3x8bpDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=S6yD6dTj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DBDDC4CEC4;
	Mon, 16 Sep 2024 18:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1726512658;
	bh=UIh1dpfLpZcsRwWvhy2J3nv47RD0JA14+2b7Tr05Khw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S6yD6dTjgIAue8lwjRCRxC2lsU1jDpa630eA+sYkenHs5MViz8+wv1R/FgEZkEIn2
	 ffRp79MrTCImoaNu/rRbRY8G9v8GZ3B+e5jpdN0DsuEJm00Xwcbd/cfpoysa3rlV1E
	 Ke0x6NlsJNOtiShGQ/BdvUd/ZrQgrxefxeiU/f0I=
Date: Mon, 16 Sep 2024 19:51:40 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Yiyang Wu <toolmanp@tlmp.cc>
Cc: linux-erofs@lists.ozlabs.org, rust-for-linux@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 03/24] erofs: add Errno in Rust
Message-ID: <2024091602-bannister-giddy-0d6e@gregkh>
References: <20240916135634.98554-1-toolmanp@tlmp.cc>
 <20240916135634.98554-4-toolmanp@tlmp.cc>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240916135634.98554-4-toolmanp@tlmp.cc>

On Mon, Sep 16, 2024 at 09:56:13PM +0800, Yiyang Wu wrote:
> Introduce Errno to Rust side code. Note that in current Rust For Linux,
> Errnos are implemented as core::ffi::c_uint unit structs.
> However, EUCLEAN, a.k.a EFSCORRUPTED is missing from error crate.
> 
> Since the errno_base hasn't changed for over 13 years,
> This patch merely serves as a temporary workaround for the missing
> errno in the Rust For Linux.

Why not just add the missing errno to the core rust code instead?  No
need to define a whole new one for this.

thanks,

greg k-h

