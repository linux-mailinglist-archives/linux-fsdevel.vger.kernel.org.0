Return-Path: <linux-fsdevel+bounces-44424-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4747A686F4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 09:35:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDD03178CD0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 08:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D2362512E8;
	Wed, 19 Mar 2025 08:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="n2HfXWU8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA942116F4;
	Wed, 19 Mar 2025 08:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742373295; cv=none; b=Aam6bvRU7rRmQKYl0n1CWUQokvAzhMWOOsbleyrFVQ2xOXKLKyeyk7P5l6oR+ut1APdwkkNtZRFJ3hx2WBvulybPYisQGGWVH9sCLmBeedGfrTxUYmK4hAzFcbncC7zOcqAlTekBStTlpUNmUI2KloKpuwFkSU+iVgfECHzu5GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742373295; c=relaxed/simple;
	bh=1xM1DrpT09p1mW48MEX1ARim+lLQ9QVmz8MWA2/egyw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N8fKgRyJyYqUbkh/NEZ2GLkCcdTi8W6XUwAvhRxwmIS/UqvgEtGGZv+Y+qq4qDcqThFE9eIgNre2oovLnYd57dNCKx7R2spLj+YAfaiGfIb32Cm9yspB1vPS48v6cON8QMoEsB1FcRXHpsWgZPr0jN0CzfvyIlELCPSE315IgDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=n2HfXWU8; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1742373289; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=RR5YqJVptrlygILdNOhzAjC7cpOvrMCLJY+Szj5Ekn4=;
	b=n2HfXWU8jABWW4Gn+Y9zTGp9oyYsvbXB0g174lm0qpls+uyMqSekiQpq18SABv6m3O/+xyv26+3uhLMgTRdoo0GaKcDIVZWaO4DrLMTlDzWVuAtbWfyhVpKrho6pmMwfg88Z/C7beGWXJcuOjqXpkoWB9bglFmm7ZXKjAmDsSGA=
Received: from 30.74.128.211(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WS1efwN_1742373287 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 19 Mar 2025 16:34:48 +0800
Message-ID: <d6643b61-1411-4858-b75e-76bcbb75071c@linux.alibaba.com>
Date: Wed, 19 Mar 2025 16:34:47 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] iomap: fix inline data on buffered read
To: Christoph Hellwig <hch@lst.de>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
 linux-erofs@lists.ozlabs.org, linux-xfs@vger.kernel.org,
 Bo Liu <liubo03@inspur.com>, "Darrick J. Wong" <djwong@kernel.org>,
 Brian Foster <bfoster@redhat.com>
References: <20250319025953.3559299-1-hsiangkao@linux.alibaba.com>
 <20250319081730.GB26281@lst.de> <20250319082323.GA26665@lst.de>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20250319082323.GA26665@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Christoph,

On 2025/3/19 16:23, Christoph Hellwig wrote:
> On Wed, Mar 19, 2025 at 09:17:30AM +0100, Christoph Hellwig wrote:
>> I'd move the iomap_iter_advance into iomap_read_inline_data, just like
>> we've pushed it down as far as possible elsewhere, e.g. something like
>> the patch below.  Although with that having size and length puzzles
>> me a bit, so maybe someone more familar with the code could figure
>> out why we need both, how they can be different and either document
>> or eliminate that.
> 
> ... and this doesn't even compile because it breaks write_begin.
> So we'll need to keep it in the caller, but maybe without the
> goto and just do the plain advance on length?

Yeah, I was just writing an email to your previous reply:

I think iomap_write_begin_inline() will break if
iomap_iter_advance() is in iomap_read_inline_data().

Because:
   iomap_write_iter
      iomap_write_begin
        iomap_write_begin_inline
          iomap_read_inline_data
             iomap_iter_advance		# 1
      copy_folio_from_iter_atomic
      iomap_write_end
      ...
      iomap_iter_advance			# 1

I will do a plain advance as your suggested instead, but commit
"iomap: advance the iter directly on buffered read" makes EROFS
unusable, and I think gfs2 too.  It needs be fixed now.

Thanks,
Gao Xiang

Thanks,
Gao Xiang


