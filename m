Return-Path: <linux-fsdevel+bounces-59811-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F9D3B3E1DF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 13:41:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8467B1A8242D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 11:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91D0A320CA5;
	Mon,  1 Sep 2025 11:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q0AuxIFH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E964E31E0FE
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Sep 2025 11:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756726829; cv=none; b=CVcjkIr/sJZM/7dl94tIQjdLR4Lo60z04+7Vzc9zaAY3OPolNwua4PCAGyX8SkZm9xBFgi5P5ZtPv0eLcwo/lolvPlas6b6pT7JZlb3AqIwIfi/OAUMShq+9TJ7htTsW8R1nHR618Z1DlZz8KVgan7KLKBKEGG3Dg4ocQQMVTEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756726829; c=relaxed/simple;
	bh=Sgg10nOwPfubA2aneNeGl5D74nFAEOxNnZP40n0iEdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DMT+OG8RdczKunOm3OcDodf/G+JhbWIeAxHkaN1NgpfFkJa66Vov6qVaq5z5OZ/DJylMuSyjZi5/YsFB0BDWyAsW3M1Dfjwxuch3gJAblBFPVAabzr1UADghgo2TT2l3R1vscLQWybXFWam9bS9W9yzdI6fWJ1lLLdM03pvnQUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q0AuxIFH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D8C7C4CEF0;
	Mon,  1 Sep 2025 11:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756726828;
	bh=Sgg10nOwPfubA2aneNeGl5D74nFAEOxNnZP40n0iEdU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q0AuxIFHfq4xaqYjXof1ZO7ejEWzSFAozHfG2l0YBwFNCtYNn0NQC2Eyxg/UXVo37
	 Rma4HKpK7feEyTtoj/ba77gDcgj2CmbfZYIxS7ZKM2U1yWmhPo+hMAwpUG+XD8ybEN
	 v/yuvVLmnaHW2VjOHtOTkS8SxbIp6nzc9r0lo9CnJY9m6aSea0kqsX3SBSX6Rkd7X1
	 LEQmfScLbZ29CSmtnB/j7NkgfnCZtQbsXDeL+0yLGcnbC0GAmJdxnBq6dVWLzQvZjp
	 EV9CkKBMgf6+WAe8WyPQVn32R9CqLr11AewoYMMTtT9ay6bHLULaRjn1CJEGFi7vNL
	 TosVWC1AEdSDA==
Date: Mon, 1 Sep 2025 13:40:25 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	torvalds@linux-foundation.org
Subject: Re: [PATCH v2 30/63] do_add_mount(): switch to passing
 pinned_mountpoint instead of mountpoint + path
Message-ID: <20250901-hinzog-flugbereit-38ac4b58fb55@brauner>
References: <20250828230706.GA3340273@ZenIV>
 <20250828230806.3582485-1-viro@zeniv.linux.org.uk>
 <20250828230806.3582485-30-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250828230806.3582485-30-viro@zeniv.linux.org.uk>

On Fri, Aug 29, 2025 at 12:07:33AM +0100, Al Viro wrote:
> Both callers pass it a mountpoint reference picked from pinned_mountpoint
> and path it corresponds to.
> 
> First of all, path->dentry is equal to mp.mp->m_dentry.  Furthermore, path->mnt
> is &mp.parent->mnt, making struct path contents redundant.
> 
> Pass it the address of that pinned_mountpoint instead; what's more, if we
> teach it to treat ERR_PTR(error) in ->parent as "bail out with that error"
> we can simplify the callers even more - do_add_mount() will do the right
> thing even when called after lock_mount() failure.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

