Return-Path: <linux-fsdevel+bounces-12647-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D075862281
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Feb 2024 04:27:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE2B91C22A9B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Feb 2024 03:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5C36134D9;
	Sat, 24 Feb 2024 03:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="W9fJ6Bc+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D51D2E0;
	Sat, 24 Feb 2024 03:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708745253; cv=none; b=LhoT2K42OZwjbtI8w6etIi/QhdRHGSWxBqStI1hxjYjh75czsgvqHc0AsGxfa+J6ccqUU2hFxGe7jz+pSYRgoewWcrzpbpQdcgdrlmsPt55K+95XN9s7jVq0ho3Q1FfcFNgeXMa6oPvXvxuqNWp2wFsx5+USwIirEOO6UbykyPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708745253; c=relaxed/simple;
	bh=qhDNlIMq5CO7aNNTqnWBMffCMqCKzQlbjb1J1+ZjR6s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SmEHb1MmpH1KPQpHrZyky9LmVzAzLk4i7kmftceIuDS2d+h1GdKZGZB96dsDOhEGoSB3sigy6RpOGH3DfKYuCZDKtD+F/N4x0UG+GURmJPsJt3o9siqA5gHcgy40C9KqosawKUdLqkC6jz9ai4ydiOATGuOhl433wtNMYqnJpeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=W9fJ6Bc+; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=0VCkszg+LKLjIPkU+C6CKrRV3Fp8J43nYtNQiylBN10=; b=W9fJ6Bc+K8wkC50wnuBCuysytl
	BtgBPCcY1O3Zj0LxNhyI1VpNJ1aPrnobfR/MYuEuS8SX8J2NFq81W7iICYNaGNEs00/WbO/rf3Rpl
	rXu1GmA/7Gv2iMXWOaFGY+healOF8T0q2ZlWiH5L6FIJsYejY1YG42QfvtkQJ12Blv4ZzgnuBoq7L
	Vhx6QIp93YVyxtoBXrwJ2IAZ40MU8IDO5S2zvkpfyGPDdZw81LNF9Y7Aog++JYbWJ+nhsuhifiM6M
	hayGF+PsoqHCrNH1RA3CDbSj9XVaAnz4Q1Ro76/XJ0YinBM/q+PTpLNC9FSWWnYntvPFgLw4zdLIj
	JHt0flNw==;
Received: from [50.53.50.0] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rdih9-0000000Bwos-10f0;
	Sat, 24 Feb 2024 03:27:23 +0000
Message-ID: <97cde8f6-21ed-45b9-9618-568933102f05@infradead.org>
Date: Fri, 23 Feb 2024 19:27:22 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 07/20] famfs: Add include/linux/famfs_ioctl.h
Content-Language: en-US
To: John Groves <John@groves.net>
Cc: John Groves <jgroves@micron.com>, Jonathan Corbet <corbet@lwn.net>,
 Dan Williams <dan.j.williams@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Matthew Wilcox <willy@infradead.org>, linux-cxl@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev, john@jagalactic.com,
 Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@infradead.org>,
 dave.hansen@linux.intel.com, gregory.price@memverge.com
References: <cover.1708709155.git.john@groves.net>
 <b40ca30e4bf689249a8c237909d9a7aaca9861e4.1708709155.git.john@groves.net>
 <8f62b688-6c14-4eab-b039-7d9a112893f8@infradead.org>
 <7onhdq4spd7mnkr5c443sbvnr7l4n34amtterg4soiey2qubyl@r2ppa6fsohnk>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <7onhdq4spd7mnkr5c443sbvnr7l4n34amtterg4soiey2qubyl@r2ppa6fsohnk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi John,

On 2/23/24 18:23, John Groves wrote:
>>> +
>>> +#define FAMFSIOC_MAGIC 'u'
>> This 'u' value should be documented in
>> Documentation/userspace-api/ioctl/ioctl-number.rst.
>>
>> and if possible, you might want to use values like 0x5x or 0x8x
>> that don't conflict with the ioctl numbers that are already used
>> in the 'u' space.
> Will do. I was trying to be too clever there, invoking "mu" for
> micron. 

I might have been unclear about this one.
It's OK to use 'u' but the values 1-4 below conflict in the 'u' space:

'u'   00-1F  linux/smb_fs.h                                          gone
'u'   20-3F  linux/uvcvideo.h                                        USB video class host driver
'u'   40-4f  linux/udmabuf.h

so if you could use
'u'   50-5f
or
'u'   80-8f

then those conflicts wouldn't be there.
HTH.

>>> +
>>> +/* famfs file ioctl opcodes */
>>> +#define FAMFSIOC_MAP_CREATE    _IOW(FAMFSIOC_MAGIC, 1, struct famfs_ioc_map)
>>> +#define FAMFSIOC_MAP_GET       _IOR(FAMFSIOC_MAGIC, 2, struct famfs_ioc_map)
>>> +#define FAMFSIOC_MAP_GETEXT    _IOR(FAMFSIOC_MAGIC, 3, struct famfs_extent)
>>> +#define FAMFSIOC_NOP           _IO(FAMFSIOC_MAGIC,  4)

-- 
#Randy

