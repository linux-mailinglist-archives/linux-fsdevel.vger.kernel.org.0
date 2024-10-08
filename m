Return-Path: <linux-fsdevel+bounces-31331-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 34AA7994A85
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 14:34:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4A8FB20ADB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 12:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACC9A1DF24D;
	Tue,  8 Oct 2024 12:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="IPOujE1I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0769E1DE8A3;
	Tue,  8 Oct 2024 12:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728390817; cv=none; b=gGFNZovmGQGzunTHXLAjB7MICnqmgS1k1XvXCFjaUNJiSnJobcszuPeyr7o75svqSngoldiYcUp4NJOXwkq7HO1WPGUmj6nwHtrkjTMQK+CwNrdt3BzoHblYUpaJN2cS2Xzwh3pOASYqrTadQnFWudvgGhman/arTFjxuspI2jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728390817; c=relaxed/simple;
	bh=4hnBzjQYx7DH6KnKxLlkYYm+mNIzaICFykJwj1YFlhA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GqlHSdW+I0Lhh16u6VnRb5rPfGjMFZlQdu2UTIeuIb42NZoKsRfJikDtcNzs4TuS7m60vyWCp4LW5IIZ+wfDeOLtlXNfTYNmOjKkyvjIyeqgrAIdL1OYerF9S4B+oJcST6UNxUTDPX7HtuAHtcuGEAjRrNJdn9AeKO4N2tdRDXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=IPOujE1I; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728390810; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=+7CVaWdRPLDuhY1NRAeUcBP6A0gvCm63US2OSGofAi8=;
	b=IPOujE1IZytMJGJUWaUgjhjlx606VP6Bm6CJ7L6PpMIxbr8qHEpK4OO5jIYch3+GXsvyyIVJLLjtWKwzoc3932JRlkedm0Nx+WzyrudY+8yyycNm9sRVJX8MsFoZwmMeDKRtYeFrub0XnCr9Ml172l99Ygo8nSHux9BfSb6ikU4=
Received: from 172.20.10.8(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WGfRGHx_1728390808)
          by smtp.aliyun-inc.com;
          Tue, 08 Oct 2024 20:33:29 +0800
Message-ID: <ca887ba4-baa6-4d7d-8433-1467f449e1e1@linux.alibaba.com>
Date: Tue, 8 Oct 2024 20:33:27 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] fs/super.c: introduce get_tree_bdev_by_dev()
To: Christoph Hellwig <hch@infradead.org>
Cc: Christian Brauner <brauner@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
 Allison Karlitskaya <allison.karlitskaya@redhat.com>,
 Chao Yu <chao@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org
References: <20241008095606.990466-1-hsiangkao@linux.alibaba.com>
 <ZwUcT0qUp2DKOCS3@infradead.org>
 <34cbdb0b-28f4-4408-83b1-198f55427b5c@linux.alibaba.com>
 <ZwUkJEtwIpUA4qMz@infradead.org>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <ZwUkJEtwIpUA4qMz@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/10/8 20:23, Christoph Hellwig wrote:
> On Tue, Oct 08, 2024 at 08:10:45PM +0800, Gao Xiang wrote:
>> But the error message out of get_tree_bdev() is inflexible and
>> IMHO it's too coupled to `fc->source`.
>>
>>> Otherwise just passing a quiet flag of some form feels like a much
>>> saner interface.
>>
>> I'm fine with this way, but that will be a treewide change, I
>> will send out a version with a flag later.
> 
> I'd probably just add a get_tree_bdev_flags and pass 0 flags from
> get_tree_bdev.

how about
int get_tree_bdev_flags(struct fs_context *fc,
		int (*fill_super)(struct super_block *,
				  struct fs_context *), bool quiet)

for now? it can be turned into `int flags` if other needs
are shown later (and I don't need to define an enum.)

Does it look good to you? if okay, I will follow this way.

Thanks,
Gao Xiang


