Return-Path: <linux-fsdevel+bounces-25262-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49BCD94A55C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 12:25:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0741A2837BB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 10:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D191DE85B;
	Wed,  7 Aug 2024 10:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VVDdgBDP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094B71D2F75;
	Wed,  7 Aug 2024 10:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723026323; cv=none; b=kOTvzPlaWVjq1a0ncw9XGz4f1bZ0T+4lIiOkNE9QWD0hWEDm1SJHhmp0z1EP2jLhqP1QlToDi0asI5BTH52v3Qk4OcL4D9hi7N0Wy4SDErSOFI+ote4K7d2Ns+53voqZRVvolc1qaPbcqnpwftdNZFjUjc+mRYun6iwmgaqFMp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723026323; c=relaxed/simple;
	bh=yWxozFs53SpvBVuFgmlaGbWhzssixvIFFxs5MNVwVs4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WEnBHCgTNZksP/iHcItkO0B6M3ofrsbmCdxKBQK/9T1NQBP0hltsf0LAGGqHK5c9zyhSlERJ7y0Fn1KoHighsOPCRIHuTlwgRtdfT4P9MdfOQrKB/n9dtYHl/fT1YoiAa+YiA8cSxi/i5kHeA8Zfpw5IlXrcEKncWAPF1Owwieo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VVDdgBDP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CA30C32782;
	Wed,  7 Aug 2024 10:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723026322;
	bh=yWxozFs53SpvBVuFgmlaGbWhzssixvIFFxs5MNVwVs4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VVDdgBDPRceGLa3BFy3luXdRvbhsMr9fzDxb9mb3/3y8rPEDQyIM84i+rr0ZqyANz
	 RlnFgo2NZCex5rmaG4kA51G+wdNssHRTbi7/yirF0gcUL4oK9SZ4/A3JvJAMiNN59U
	 4bA1A243dFqFeRvAdTD6H6xBMVbW5VUWL7XFCLmt0miHgKdGcrrLwrpky4BaQKMkd7
	 C70cquPkERoidL1FE0MCO/rSNfauD6koCSW6raUOd1TB+xZJTrIVmVwIfXjJ0NyRzV
	 LkKGduI2eiuI3MUA+6a9d8hD/Y+RH/F3korTUx2dfxIaOA6Rpui193GT3qXFxsubpm
	 ZpdEj3kuSypDA==
Date: Wed, 7 Aug 2024 12:25:18 +0200
From: Christian Brauner <brauner@kernel.org>
To: viro@kernel.org
Cc: linux-fsdevel@vger.kernel.org, amir73il@gmail.com, bpf@vger.kernel.org, 
	cgroups@vger.kernel.org, kvm@vger.kernel.org, netdev@vger.kernel.org, 
	torvalds@linux-foundation.org
Subject: Re: [PATCH 10/39] get rid of perf_fget_light(), convert
 kernel/events/core.c to CLASS(fd)
Message-ID: <20240807-bejahen-lehrling-d010a78e1f39@brauner>
References: <20240730050927.GC5334@ZenIV>
 <20240730051625.14349-1-viro@kernel.org>
 <20240730051625.14349-10-viro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240730051625.14349-10-viro@kernel.org>

On Tue, Jul 30, 2024 at 01:15:56AM GMT, viro@kernel.org wrote:
> From: Al Viro <viro@zeniv.linux.org.uk>
> 
> Lift fdget() and fdput() out of perf_fget_light(), turning it into
> is_perf_file(struct fd f).  The life gets easier in both callers
> if we do fdget() unconditionally, including the case when we are
> given -1 instead of a descriptor - that avoids a reassignment in
> perf_event_open(2) and it avoids a nasty temptation in _perf_ioctl()
> where we must *not* lift output_event out of scope for output.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

