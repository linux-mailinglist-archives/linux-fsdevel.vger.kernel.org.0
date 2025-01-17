Return-Path: <linux-fsdevel+bounces-39458-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D12A147A8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2025 02:41:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CA15188E07D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2025 01:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E5E12AE68;
	Fri, 17 Jan 2025 01:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="U1gQSG/J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA1E9443
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jan 2025 01:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737078069; cv=none; b=iUzep+opl0UlYJVYmhwDKfvqbdB1O6+yOxUzL4fMJgdxch9o0hRp/z6eqKvQ4SzgR5LXRsE3gdASmHOSPHeJW5EOL7Cfr/9a9IYVXW73rMRCert0nuc6GGbhIoYdx37wlUFq7SZ8dLitkCtXo5UL50wCOpes1WjKLn/WV7h21fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737078069; c=relaxed/simple;
	bh=EBflKdN3O80LCk6ZA56ceOfEEtWOk1DSKmZ4XTOKNhw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ow/iEcxwss81hjAZEwNwVELdmYbY16o0bSc+sD1yi8KqX/bF4XLezBlSC2V3vxmmdkfQJ9oGmlCXU5G63Hg7KgI/500hQNg/TMdIGX8Dh0bNeqlz5ujfioffBu87RR2OMFk6bpE35GMX64ZS+mYH2N894d8FNauXeA8fQlAAodA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=U1gQSG/J; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1737078063; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=hWBT9uXle6g8wdcoKxsaVYoFiBcIQQpW6iPD4exFtPY=;
	b=U1gQSG/JbzugL5CNYRxOZTmfnQ74QjRP0hRB/ipxBo4kwN5RNa8k5HKZ08h0YU0U2+QvDrgsPZDccCWbmlqvUSH0Dy4QBI/wfSktwXfROBp7IL2MFTghvC4V+so30319YNYNCDkQ/nYdZtjEP2MyVNcrEVYP3pJib658OfOFhTg=
Received: from 30.221.145.14(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0WNmus3M_1737078061 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 17 Jan 2025 09:41:02 +0800
Message-ID: <1dfcf698-2c85-458c-820a-ca9ec4d26de3@linux.alibaba.com>
Date: Fri, 17 Jan 2025 09:40:59 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 0/2] fuse: add kernel-enforced request timeout option
To: Miklos Szeredi <miklos@szeredi.hu>, Joanne Koong <joannelkoong@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, josef@toxicpanda.com,
 bernd.schubert@fastmail.fm, laoar.shao@gmail.com, jlayton@kernel.org,
 senozhatsky@chromium.org, tfiga@chromium.org, bgeffon@google.com,
 etmartin4313@gmail.com, kernel-team@meta.com
References: <20241218222630.99920-1-joannelkoong@gmail.com>
 <CAJnrk1YNtqrzxxEQZuQokMBU42owXGGKStfgZ-3jarm3gEjWQw@mail.gmail.com>
 <CAJfpegus1xAEABGnCgJN2CUF6L6=k1zHZ6eEAf8JqbwRdAJAMw@mail.gmail.com>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <CAJfpegus1xAEABGnCgJN2CUF6L6=k1zHZ6eEAf8JqbwRdAJAMw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/16/25 8:11 PM, Miklos Szeredi wrote:
> On Wed, 15 Jan 2025 at 20:41, Joanne Koong <joannelkoong@gmail.com> wrote:
> 
>> Miklos, is this patchset acceptable for your tree?
> 
> Looks good generally.
> 
> I wonder why you chose to use a mount option instead of an FUSE_INIT param?

IMO this timeout mechanism has no dependence on the implementation on
the server side, and it's self-contained by the kernel side.  Thus it's
adequate to negotiate through the mount option instead of the INIT
feature negotiation.  Although the FUSE mount instance is generally
mounted by the fuse server itself in the libfuse implementation.  IOW
INIT feature negotiation is required only when the server side shall opt in.

-- 
Thanks,
Jingbo

