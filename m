Return-Path: <linux-fsdevel+bounces-61349-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8CC0B579E6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 14:06:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 349FA3A70CA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 12:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEF7C305973;
	Mon, 15 Sep 2025 12:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RN3MaEPT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA281F4169
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Sep 2025 12:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757937977; cv=none; b=G1A17mKDC7dNKuR+sdqCbWgmgmzoCG1w5KwSjlitOq9jRfHNCHBr1wqRq1UE82qNvpYCEhdSeUxTNq1E+6n3aKRJtSs7AZqaAXxE4v8tMRyQRHkB0kh7NwRLMvbKRLDdOg1G/ZanYTb05tGMpkbHeeU+r96dz9VEgwIEO5GxkzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757937977; c=relaxed/simple;
	bh=ZcIByHCdTlub92al+QxSs80yH3FodY0v5DxuM1XY91U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C9pIp/Y1gyoLciu6cBH35pEzaGTus6GKV/UXcDVrxdnWambUzHBwEKdB6OSa5VL5ClmkSLR6zUvP8OcUSrShvC2677yJqWbyk26D3t6qg9YKYcYdbiGMkApAjaRtnYboxUU2BlQcRiyNrPobZePaV+mxoK7FYAjVEP+Bdv/xytA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RN3MaEPT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C4DCC4CEF5;
	Mon, 15 Sep 2025 12:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757937977;
	bh=ZcIByHCdTlub92al+QxSs80yH3FodY0v5DxuM1XY91U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RN3MaEPTGGtuj8Mwpa+dtewUsjqIRCAt8JSkJ49XysqKCk0cfCrRUG1CRbwgvK4hr
	 qVKQGZS2cznqpXvr9FP5jbzUmKuTPdQ4v2CBwtW9wuKGD4z34M/15FDCjLq9ObzrQz
	 6BTgQcRQRiIJe0QIrsBuEnSSKSs78iUnmGIQ9Bn+96F86mCbTSPsvcO12HlC0wo+xL
	 Ju0vGCnihTF1hdFg8wnkV5B9C4D1ImknSwIHvV3CiUtgJKGVW9maIKS5nUJ1ZBvNR7
	 vckV+2YM6uaz/X3Qoiu0k9bCGCpWf73epwq3rpVJ4EUQphyR1PsxklokjqMb2gYCkV
	 X/v5XGgKmZgPw==
Date: Mon, 15 Sep 2025 14:06:13 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	torvalds@linux-foundation.org, amir73il@gmail.com, chuck.lever@oracle.com, 
	linkinjeon@kernel.org, john@apparmor.net
Subject: Re: [PATCH 19/21] ovl_is_real_file: constify realpath argument
Message-ID: <20250915-aromen-hinzog-5fc38479bae9@brauner>
References: <20250906090738.GA31600@ZenIV>
 <20250906091137.95554-1-viro@zeniv.linux.org.uk>
 <20250906091137.95554-19-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250906091137.95554-19-viro@zeniv.linux.org.uk>

On Sat, Sep 06, 2025 at 10:11:35AM +0100, Al Viro wrote:
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

