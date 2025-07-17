Return-Path: <linux-fsdevel+bounces-55203-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 912CCB0834D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 05:18:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 829FC4A62D1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 03:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6750D1EF389;
	Thu, 17 Jul 2025 03:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="X92YK68j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0BA7E9;
	Thu, 17 Jul 2025 03:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752722312; cv=none; b=InRa2PYkMaW0PidW30PEyIrbJ1YDqPygugVIoUUd1porHtTe3T37xsgnykXDxjM8I7oumWWtkFf822483bPhP9mqxTGxMFPArpqwM87lpY21Pl014KzBWCcHteJYvTfbLamXRocfE0eV5/oPgq9+xXtCM7sh47pbB4J6tGr0Epg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752722312; c=relaxed/simple;
	bh=7Aw2cRMv/h7kGSk8iIlN78MnpE9Mt/7y9nLg/a91z2I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WTBJ9s1YtsTmx2dKTV50jGa14d3AGQqwH06tpwC0yBW5GAJ2dmSiJlEPA/xCWL3BJKafN939BPJwd2W4r4/3zZUY4/PVgdhrmETbdcs5fG9E9J0VXeqF2CvjQbKlELN1HHao/4tJvZAdvZGNozhOqMSXvRqMkvW1wh82LH6jxrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=X92YK68j; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1752722302; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=4gUaF7R4/EBDJfRjJRTdp0icwbrWb7f2nyKt3jMgey4=;
	b=X92YK68jtvdYunHTr7lIxmXTsR/Wm8YdAzx6PuAmbBPOkG1SWS4NxizO6dYhKWNLI4ih4NQjX0TE9j+/HtD9TYvJ694FmwAOq8jv8FSHl4SbK54zInn0pIZHAyBmvySAgaR1E9yPTUl00mPG06b/77lukpCLuadCiSVJnvUEY4M=
Received: from 30.221.131.143(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wj6YBs9_1752722299 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 17 Jul 2025 11:18:20 +0800
Message-ID: <51c92913-6176-4516-8b14-bd12e2a85697@linux.alibaba.com>
Date: Thu, 17 Jul 2025 11:18:18 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Compressed files & the page cache
To: Eric Biggers <ebiggers@kernel.org>,
 Phillip Lougher <phillip@squashfs.org.uk>
Cc: Matthew Wilcox <willy@infradead.org>, Chris Mason <clm@fb.com>,
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
 linux-btrfs@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>,
 Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
 linux-erofs@lists.ozlabs.org, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net, Jan Kara <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>,
 Richard Weinberger <richard@nod.at>, linux-mtd@lists.infradead.org,
 David Howells <dhowells@redhat.com>, netfs@lists.linux.dev,
 Paulo Alcantara <pc@manguebit.org>,
 Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
 ntfs3@lists.linux.dev, Steve French <sfrench@samba.org>,
 linux-cifs@vger.kernel.org
References: <aHa8ylTh0DGEQklt@casper.infradead.org>
 <f4b9faf9-8efd-4396-b080-e712025825ab@squashfs.org.uk>
 <20250717024903.GA1288@sol>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20250717024903.GA1288@sol>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/7/17 10:49, Eric Biggers wrote:
> On Wed, Jul 16, 2025 at 11:37:28PM +0100, Phillip Lougher wrote:

...

> buffer.  I suspect that vmap() (or vm_map_ram() which is what f2fs uses)
> is actually more efficient than these streaming APIs, since it avoids
> the internal copy.  But it would need to be measured.

Of course vm_map_ram() (that is what erofs relies on first for
decompression in tree since 2018, then the f2fs one) will be
efficient for decompression and avoid polluting unnecessary
caching (considering typical PIPT or VIPT.)

Especially for large compressed extents such as 1MiB, another
memcpy() will cause much extra overhead over lz4.

But as for gzip, xz and zstd, they just implement internal lz77
dictionaries then memcpy for streaming APIs.  Since those
algorithms are relatively slow (for example Zstd still relies
on Huffman and FSE), I don't think it causes much difference
to avoid memcpy() in the whole I/O path (because Huffman tree
and FSE table are already slow), but lz4 matters.

Thanks,
Gao Xiang

