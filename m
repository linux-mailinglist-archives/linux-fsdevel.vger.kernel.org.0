Return-Path: <linux-fsdevel+bounces-43880-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 542DDA5EE08
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 09:29:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A1653BCAD5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 08:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97012261392;
	Thu, 13 Mar 2025 08:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RGnqti/H"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B5226138C
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Mar 2025 08:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741854531; cv=none; b=IZ845y7iamX9fQfoUsqh+2btKENkWakGFMZXAewGe41i24gUXniK9Nhv+LDReAi+ZilFPFRyoup9oPrmAn9+ij76mEHu+H3dGnrnz3heNM7XCWd2UmFVdpvPF5tzfVlVzQRxaJAkK1z0iQGX2FthZK4xzdbWOUUXd54VBmIi8kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741854531; c=relaxed/simple;
	bh=WotYYtMMdfZ0VCxbi9UyDMVGioMw80hNCXYhhfpnPsI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EYT/eoeiXGpii9qpvdjp+nOapWYve3sjk622dCFV8+liSn9AgrLG29fF8wY8kclfi6q48WD1jfcTBytOeEgxQRCPmm8G72V1nVNQX43ctax0892ShJSCGgsM00ffeU/RM5Nxy1kX7RwXkdxDUCl1+DWkixevc7yqrkFYE6feADA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RGnqti/H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EECCEC4CEEE;
	Thu, 13 Mar 2025 08:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741854530;
	bh=WotYYtMMdfZ0VCxbi9UyDMVGioMw80hNCXYhhfpnPsI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RGnqti/HDfekk1i7pUnGdWG2m1Wg0E5GsHF2IRdsSbdfsO1z6yGIUyW4bSvJW9LZo
	 iQ1NVxOnzCtJ7eYNJZAjdzQHZhvV33fBLVyeV7VijMMS1mUPYjb5+10UVtnLkXj4s+
	 eX4QJUbFbMRBbrZvcK0ZASuWLXkmfrdza+pWLQ/To7ltMffGc6AicpKTPhrbVuPhqR
	 PLvW7AgECo89rjKC7QFBkMmC8G6s8FakUiYLKP3jj+jv/PqNQpRQqpYEA7FG8CzNpe
	 RyXBInMc+iHDGjG4AthivZZ7STuaZ4zScFVXStNjpyeHm1w/WidePAFgwT0FTnl+CY
	 inR/0khhVqp1Q==
Date: Thu, 13 Mar 2025 09:28:43 +0100
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 3/4] spufs: fix a leak in spufs_create_context()
Message-ID: <20250313-bonzen-glorreiche-47b46db84b86@brauner>
References: <20250313042702.GU2023217@ZenIV>
 <20250313042932.GC2123707@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250313042932.GC2123707@ZenIV>

On Thu, Mar 13, 2025 at 04:29:32AM +0000, Al Viro wrote:
> Leak fixes back in 2008 missed one case - if we are trying to set affinity
> and spufs_mkdir() fails, we need to drop the reference to neighbor.
> 
> Fixes: 58119068cb27 "[POWERPC] spufs: Fix memory leak on SPU affinity"
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

