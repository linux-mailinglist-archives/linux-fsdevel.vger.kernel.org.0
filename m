Return-Path: <linux-fsdevel+bounces-45900-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A8F1A7E5EA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 18:16:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E84B01885DC5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 16:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB3A12054EB;
	Mon,  7 Apr 2025 16:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="eYHHf1b0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE3120A5D2;
	Mon,  7 Apr 2025 16:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744041949; cv=none; b=Cw8A7qJN+MBSX0NMFH10Q+Owjzr/7Eh2ezsrBMOt2uLjCc+npqLQHG95zrZHcxRsi4eFhOChZjKcGBsMeLyQwpRs+efROYUGz3y9GItlNYiPyzIc1Qv592ju2lH+RzcPJTjj4wOATq1Eu7FGqmP8j9l3axs946nNckPguO/MErs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744041949; c=relaxed/simple;
	bh=7UNpN+buRIsFH+fFOA4zaauXv0v58qO3QlVbSdSDFW4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p6QxrgnYPixFvZk7TnCslopejOnHaqh5MDfJElId8J9uKgkjsGNRnFMBAqqtQRgRCGpsx1nM5oqmZHHOQrnyzwjRvRdth0BFP9S2Ms31iQfpp2TmHPGJfk24Y72BFWpXY1Mz0tWNIxHNqlnX6D7i8cOIzusQzTXNGp5vUi+0r9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=eYHHf1b0; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1744041940; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=gkWh1scaRO0RL55ZarqwIub4AzbqKXHMEdNFKMKBTRo=;
	b=eYHHf1b0drvdbpke3eC/KVvZ1Cm+5IbhF1p3mOxx6z5myaybMJTXWnhc+XtgV4eRpbaaTOyrUUiJWKEhl51xgmBvF6vweJouVTNXAU1q+UJV/l8mNpZa8S4WFZ93/xJpMAXYPpayH0cZhc4lUtY5dRE547/+s4PYAx9II/u56e0=
Received: from 30.134.66.95(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WW1M99X_1744041939 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 08 Apr 2025 00:05:40 +0800
Message-ID: <d7866b45-099f-40de-b192-45b647a90458@linux.alibaba.com>
Date: Tue, 8 Apr 2025 00:05:39 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] initrd: support erofs as initrd
To: "hch@lst.de" <hch@lst.de>,
 Julian Stecklina <julian.stecklina@cyberus-technology.de>
Cc: "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "rafael@kernel.org" <rafael@kernel.org>,
 "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <20250320-initrd-erofs-v1-1-35bbb293468a@cyberus-technology.de>
 <20250321050114.GC1831@lst.de>
 <582bc002-f0c8-4dbb-8fa5-4c10a479b518@linux.alibaba.com>
 <933797c385f2e222ade076b3e8fc5810fa47f5bd.camel@cyberus-technology.de>
 <20250407085751.GA27074@lst.de>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20250407085751.GA27074@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Christoph,

On 2025/4/7 16:57, hch@lst.de wrote:
> On Fri, Mar 21, 2025 at 01:17:54PM +0000, Julian Stecklina wrote:
>> Of course there are some solutions to using erofs images at boot now:
>> https://github.com/containers/initoverlayfs
>>
>> But this adds yet another step in the already complex boot process and feels
>> like a hack. It would be nice to just use erofs images as initrd. The other
>> building block to this is automatically sizing /dev/ram0:
>>
>> https://lkml.org/lkml/2025/3/20/1296
>>
>> I didn't pack both patches into one series, because I thought enabling erofs
>> itself would be less controversial and is already useful on its own. The
>> autosizing of /dev/ram is probably more involved than my RFC patch. I'm hoping
>> for some input on how to do it right. :)
> 
> Booting from erofs seems perfectly fine to me.  Booting from erofs on
> an initrd is not.  There is no reason to fake up a block device, just
> have a version of erofs that directly points to pre-loaded kernel
> memory instead.  This is a bit more work, but a lot more efficient
> in that it removes the block path from the I/O stack, removes the boot
> time copy and allows for much more flexible memory management.

For unencoded (uncompressed) images, especially data is page-aligned,
FSDAX can be used directly to replace page cache, which is absolutely
fine now.

But for encoded I/Os, since it needs for somewhat data transformation,
currently BIOs (actually mainly bio_vecs, but bio_vecs are lack of
useful interfaces) is needed to get the on-disk (or original memory)
encoded data in a flexible way.

I hope BIO (or some other-like interfaces) can be eventually decoupled
from block devices, and instead form generic block-based interfaces
anyway, so that eveutually yes, we don't need to fake a block device
(like FSDAX support for brd) like the old initrd.  But I suspect if
any folk puts more development resource to work on this (I don't
have more resource from my current employer), so personally I guess
initrd could be workable for the first step for people to leverage
this feature in some way.

Thanks,
Gao Xiang

