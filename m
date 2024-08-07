Return-Path: <linux-fsdevel+bounces-25269-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B2E94A5B6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 12:38:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31C0DB29A1E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 10:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C6FD1DE863;
	Wed,  7 Aug 2024 10:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VqOJ+vvZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2B31CCB57;
	Wed,  7 Aug 2024 10:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723026955; cv=none; b=R27882shEDQX6SR7PnNc+aRFuiDIHbEBn68FSbKIONVye6dY1u29PXKC6g0mMG8cG6gbV5TXr7y27SVGiuN7+ppnkxHiT8tgxunkXe6SpLupEhU5feyE+7axXPQazqWAd0lBl5Sn4znbH/Su17fGQvHg+60k4U8mD5Oy7jzZesI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723026955; c=relaxed/simple;
	bh=DBQnHNz1pPrWejpohHbPX5AOCjYCHt3fHEfXpIq0zzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L5XtmFTDi7w1V62mcngbHE9tvMeoNtq3bX3KXoZm/OjpL8ZJbSKyRpeelgDfyMltG3mo7K+6fxQpMmfOhRpfYfr/XQZVUic/pMT3SvbNy59LIExzRvoFcgdbb2JNxblSedvwWKLvFm3DmqJXX5Is//s4aI2UwHoCtuB4LM7MbaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VqOJ+vvZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8919C32782;
	Wed,  7 Aug 2024 10:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723026955;
	bh=DBQnHNz1pPrWejpohHbPX5AOCjYCHt3fHEfXpIq0zzs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VqOJ+vvZEpr7C4RcfvW6/AOToDxnWpAa1jN3FM3Iedvd2ImdvmD6z8vaHbpnMzccS
	 IZk8TMpRklRy8psEBJg38vlNQM0A8uMOr3fsK2pjo9NXEbvCzX0+rSaf/TPIhKpvEp
	 /Ne2ZppwI20HsJ7T11+sPvE5BEECGC5S2x8yofXL6AAmD/I1HYt8ONerAmNDhwNWGB
	 faBSp08noQicyctoi6JHFIeIRz/RQBcj+ajtRGlG6+Pg5Rh7aH10kV87nDp8TCLl/0
	 N1P8DMgYL/2FvoljeQr0Iv0Xc0wzed/seD68sM+KjpuDDjN8qJrI+WcUDwhDcEsb2b
	 Rz5VZ2FH1PN6w==
Date: Wed, 7 Aug 2024 12:35:50 +0200
From: Christian Brauner <brauner@kernel.org>
To: viro@kernel.org
Cc: linux-fsdevel@vger.kernel.org, amir73il@gmail.com, bpf@vger.kernel.org, 
	cgroups@vger.kernel.org, kvm@vger.kernel.org, netdev@vger.kernel.org, 
	torvalds@linux-foundation.org
Subject: Re: [PATCH 19/39] fdget_raw() users: switch to CLASS(fd_raw, ...)
Message-ID: <20240807-jetzt-angeordnet-efb27b7e7fe7@brauner>
References: <20240730050927.GC5334@ZenIV>
 <20240730051625.14349-1-viro@kernel.org>
 <20240730051625.14349-19-viro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240730051625.14349-19-viro@kernel.org>

On Tue, Jul 30, 2024 at 01:16:05AM GMT, viro@kernel.org wrote:
> From: Al Viro <viro@zeniv.linux.org.uk>
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

