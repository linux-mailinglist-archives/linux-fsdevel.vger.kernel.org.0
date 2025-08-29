Return-Path: <linux-fsdevel+bounces-59635-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DBA5B3B7CB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 11:55:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9D73363F7C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 09:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B1663054E8;
	Fri, 29 Aug 2025 09:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HuMTNwWA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A373305065
	for <linux-fsdevel@vger.kernel.org>; Fri, 29 Aug 2025 09:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756461293; cv=none; b=o7aNH4Lupl4mct7e55Xq+e/Bf/0FHu/uDg521QCXPSHy5Jp6RKYa5v/7Wcr5vQyPIZ+WaqhBGxwsCGGnoHK2H3jjlsz5QKQ6YiHfYaEu31uvP6tqBBvHjgZGA91Pif9l0oXUBjX96Y/1s9mptVJFXRIc8xXZIPQVes1ziU7jwHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756461293; c=relaxed/simple;
	bh=lXYgbGU/rLTDfmETbk02GSZO+cUL2dbaozy7lje0Jrg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N21VytJTIPl28Fh691T5js0Y84amCFlNRWP87EYa6qr526kQX4NqCQY3snpbfb5cKv59tWcZ3LVdDYmZzOv/S/tVf3eSoeVI4uP5SKUlEyV7AaCmi9gJ+e8Zx0283AA/3ThaRt4HKiUDF2ev2i7lozmkkNHAnUrJFzTCrQsoA0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HuMTNwWA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFDA1C4CEF0;
	Fri, 29 Aug 2025 09:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756461293;
	bh=lXYgbGU/rLTDfmETbk02GSZO+cUL2dbaozy7lje0Jrg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HuMTNwWAMnYh7Q9tDPB0ZgpGY7In9vQOMR+TnevVs4I9PSZX6uZ1+02CxyBH+LF8y
	 JY8marj60wFVLVnpiYZjwTVKWl3rMSp0ELxGnSMypa7XVUMJmiKPczepl3G3W72kKP
	 Bi0MVMtRjQi119YDpSsL/7j6J+kr+5ICFeG+XdPxLYeI9IpsLcuJwGevt5xDm5O2VY
	 EH3KUdTVlpx4g3OCjBGK7jNUxR6VKqP0iec8OTc8TiLY+xql8Sq9y91XhstGmM3/do
	 xMBRtPdeqgHODgD++YL8K7AAlgJRXJYV5kHsVA7I1fnk/4WjIVpZZQl0e+3T330JwA
	 EPjhAV0UvR3LA==
Date: Fri, 29 Aug 2025 11:54:49 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	torvalds@linux-foundation.org
Subject: Re: [PATCH v2 55/63] open_detached_copy(): separate creation of
 namespace into helper
Message-ID: <20250829-annektieren-zeilen-604d89189fd7@brauner>
References: <20250828230706.GA3340273@ZenIV>
 <20250828230806.3582485-1-viro@zeniv.linux.org.uk>
 <20250828230806.3582485-55-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250828230806.3582485-55-viro@zeniv.linux.org.uk>

On Fri, Aug 29, 2025 at 12:07:58AM +0100, Al Viro wrote:
> ... and convert the helper to use of a guard(namespace_excl)
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

