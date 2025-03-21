Return-Path: <linux-fsdevel+bounces-44716-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D0EAA6BC50
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Mar 2025 15:01:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BAA17A2C77
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Mar 2025 13:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4411E80C02;
	Fri, 21 Mar 2025 13:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="aI8KtvSF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0893742A94;
	Fri, 21 Mar 2025 13:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742565488; cv=none; b=Ra6DlZ/nU/RW5B5IPXt4M3ExZQpL9WNvZkrm3Wj50+WC+Q3+a3BkJT28Xqq8xe8i+fmlqIlhrk2NR/1dzIrRvir3uortquiNf0x6vcj49xpFC77BAiDy87//Z7JzswvCQv1u4Tg6vVsKmYIVjg923MtN/Tlfl3yjSTawYxjKYSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742565488; c=relaxed/simple;
	bh=DnU+Ee7KcE58TQf3t2cxWANpuCHzBrr69H7LZKjKk7E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ieLg2Ox8xGyDMDdxvr587a2ImbbTunKRnhIYaNABMzkaF0dpVhoch/bwl6com6sPyMYqeioJhyOzrNXgD7+t8HZmSiCd9Xt7P11jqmiXSFng7FHvAopN88ppiEXCucjRzLMDAGmou0Z7irizqqg0shUvYlspLTO/hIc4EQoERs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=aI8KtvSF; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1742565481; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=srvsovFblQPzignnqMr8Ftv/qEnbQ9WLUcuRCMO/obE=;
	b=aI8KtvSFDD8pS4VQo6R6dAilMbyc2Gcvh6/vZ/vdpp3jBHxN+JMOmrJV9CMF6vEaxi2p5C2YJf1RRNPzwNx4kRzP1d8JTXsTs2DkI7fD8ug4ayIJPdAfbeSoqp0veEBUJPZeTTTMXMqzd8S6Dt1sCs2LSpwfGuTY8x/g0EQT/Cw=
Received: from 30.134.66.95(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WSIqpiI_1742565479 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 21 Mar 2025 21:58:00 +0800
Message-ID: <934af3e3-3153-40c1-9a25-7a8d08fdb007@linux.alibaba.com>
Date: Fri, 21 Mar 2025 21:57:59 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] initrd: support erofs as initrd
To: Julian Stecklina <julian.stecklina@cyberus-technology.de>,
 "hch@lst.de" <hch@lst.de>
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
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <933797c385f2e222ade076b3e8fc5810fa47f5bd.camel@cyberus-technology.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Julian,

On 2025/3/21 21:17, Julian Stecklina wrote:
> On Fri, 2025-03-21 at 13:27 +0800, Gao Xiang wrote:
>> Hi Christoph,
>>
>> On 2025/3/21 13:01, Christoph Hellwig wrote:
>>> We've been trying to kill off initrd in favor of initramfs for about
>>> two decades.  I don't think adding new file system support to it is
>>> helpful.
>>>
>>
>> Disclaimer: I don't know the background of this effort so
>> more background might be helpful.
> 
> So erofs came up in an effort to improve the experience for users of NixOS on
> smaller systems. We use erofs a lot and some people in the community just
> consider it a "better" cpio at this point. A great property is that the contents
> stays compressed in memory and there is no need to unpack anything at boot.
> Others like that the rootfs is read-only by default. In short: erofs is a great
> fit.
> 
> Of course there are some solutions to using erofs images at boot now:
> https://github.com/containers/initoverlayfs
> 
> But this adds yet another step in the already complex boot process and feels
> like a hack. It would be nice to just use erofs images as initrd. The other
> building block to this is automatically sizing /dev/ram0:
> 
> https://lkml.org/lkml/2025/3/20/1296
> 
> I didn't pack both patches into one series, because I thought enabling erofs
> itself would be less controversial and is already useful on its own. The
> autosizing of /dev/ram is probably more involved than my RFC patch. I'm hoping
> for some input on how to do it right. :)

Ok, my own thought is that cpio format is somewhat inflexible.  It
seems that the main original reason for introducing initramfs and
cpio was to avoid double caching, but it can be resolved with FSDAX
now and initdax totally avoids unnecessary cpio parsing and unpacking.
cpio format is much like tar which lacks of basic features like
random access and xattrs which are useful for some use cases as
I mentioned before.

The initrd image can even compressed as a whole and decompress in
the current initramfs way.  If you really need on-demand
decompression, you could leave some file compresssed since EROFS
supports per-inode compression, but those files are still double
caching since FSDAX mode should be uncompressed to support mmap.
You could leave rare-used files compressed.

Thanks,
Gao Xiang

