Return-Path: <linux-fsdevel+bounces-44121-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE5CA62DF4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Mar 2025 15:12:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8637018943BC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Mar 2025 14:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBECD202C3B;
	Sat, 15 Mar 2025 14:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ethancedwards.com header.i=@ethancedwards.com header.b="BPToWSaz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0214C183CA6;
	Sat, 15 Mar 2025 14:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742047968; cv=none; b=BXy8Tbnrn3PehaGHwU+Lr6SD5cDLKf51hyl+KfSWjD5xjSb8QwjOyLOoEQT3zC6oQonN8cSOxRRIx/RO6/5W66rzYqv8I+JIl7ZXD47pjvF+zrA5gpegImoDwTv3c+664G19F24GwYGUayBltFOGHvtQf0zQwV1oudcMvK2kroM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742047968; c=relaxed/simple;
	bh=rT0K3DWxEliazf9RoSbsQSeNMDFTNkIk5dPScjVcmME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ycasdnhu6BoXqmFsnZE88Jg4a78Av/uugP0o1zi7t+pVXTGdXlp/0sEG8ZkSwnGH+mKAPQkAjlUHWho+r4glslQzV9gP3ao1DbR8RQS8FapPEHrOrqb67wDOQfWDhBohe54hwC6axlXRP71QMhsr36kLht0FEoRbL4z/sPGb3/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com; spf=pass smtp.mailfrom=ethancedwards.com; dkim=pass (2048-bit key) header.d=ethancedwards.com header.i=@ethancedwards.com header.b=BPToWSaz; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ethancedwards.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4ZFNVL1Gg2z9sd5;
	Sat, 15 Mar 2025 15:12:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ethancedwards.com;
	s=MBO0001; t=1742047962;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l0jjcpciDxOvfFJDIGamWqvvkaq34AD37DScmuZNW2s=;
	b=BPToWSazF3X0vjLrWUUsKZ55TxFQmmfF0yOjfREhyFKhweRuExW11MKwfWt3J/6IME5jVK
	uGvDV0ZnIG9T8SZTn8arobAuswEbAY/57LN1mVeMsO+FcYTkLn1fq8FTCrCIBcrKI7rKNw
	lXfT3oNb8e1AOQPzjtqompMtmgt5th78Lsug69oUMD6QPVNzzwZoZjWaolQyRR99y629dT
	pk64eer1zRCrhFFh01Ih138RtGAMDt7Ejul7AksZ8AlSSbItdqtT1V53qhz0i+y9WIBY6V
	I2+H8f07S4ZYRWmdkuXXlghMvBQE7pZNI2syFv8QIhqvHuDQxeYhxKboSnR3NQ==
Date: Sat, 15 Mar 2025 10:12:38 -0400
From: Ethan Carter Edwards <ethan@ethancedwards.com>
To: Aditya Garg <gargaditya08@live.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"tytso@mit.edu" <tytso@mit.edu>, 
	"ernesto.mnd.fernandez@gmail.com" <ernesto.mnd.fernandez@gmail.com>, "dan.carpenter@linaro.org" <dan.carpenter@linaro.org>, 
	"sven@svenpeter.dev" <sven@svenpeter.dev>, "ernesto@corellium.com" <ernesto@corellium.com>, 
	"willy@infradead.org" <willy@infradead.org>, "asahi@lists.linux.dev" <asahi@lists.linux.dev>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>
Subject: Re: [RFC PATCH 0/8] staging: apfs: init APFS module
Message-ID: <uzqxio7wadfe4pb7ehawqmlarxog6w2ljqtgmk7lvxyzefrfko@k327zeywozr3>
References: <20250314-apfs-v1-0-ddfaa6836b5c@ethancedwards.com>
 <881481D8-AB70-4286-A5FB-731E5C957137@live.com>
 <D4E1167D-9AF8-4B1D-90FB-20F7507B595C@live.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D4E1167D-9AF8-4B1D-90FB-20F7507B595C@live.com>
X-Rspamd-Queue-Id: 4ZFNVL1Gg2z9sd5

On 25/03/15 07:21AM, Aditya Garg wrote:
> 
> 
> > On 15 Mar 2025, at 12:39 PM, Aditya Garg <gargaditya08@live.com> wrote:
> > 
> > 
> > 
> >> On 15 Mar 2025, at 3:27 AM, Ethan Carter Edwards <ethan@ethancedwards.com> wrote:
> >> 
> >> Hello everyone,
> >> 
> >> This is a follow up patchset to the driver I sent an email about a few
> >> weeks ago [0]. I understand this patchset will probably get rejected, 
> >> but I wanted to report on what I have done thus far. I have got the 
> >> upstream module imported and building, and it passes some basic tests 
> >> so far (I have not tried getting XFS/FStests running yet). 
> >> 
> >> Like mentioned earlier, some of the files have been moved to folios, but
> >> a large majority of them still use bufferheads. I would like to have
> >> them completely removed before moved from staging/ into fs/.
> >> 
> >> I have split everything up into separate commits as best as I could.
> >> Most of the C files rely in functions from other C files, so I included
> >> them all in one patch/commit.
> >> 
> >> I am curious to hear everyone's thoughts on this and to start getting
> >> the ball rolling for the code-review process. Please feel free to
> >> include/CC anyone who may be interested in this driver/the review
> >> process. I have included a few people, but have certainly missed others.
> >> 
> >> [0]: https://lore.kernel.org/lkml/20250307165054.GA9774@eaf/
> >> 
> >> Signed-off-by: Ethan Carter Edwards <ethan@ethancedwards.com>
> > 
> > Why hasn’t Ernesto signed-off here, or in any patch? AFAIK, he is the author of the driver.
> 
> I can also see your Copyright at some places, which I didn't find in the upstream repo. Did you add some code change?

Yes, there were some slight refactors in some files to get the code
compiling. I only added my copyright in files where I changed things. I
can remove them. I was not sure what to do.

> 
> IMO, if you are just maintaining it, doesn't mean you add your copyright. Eg: I maintain the appletbdrm driver, but I didn't write or add anything special in it, so it doesn’t have my copyright.

Sure. That is logical. I'll remove them in the next series.

> 
> Also, did you ask Ernesto whether he wants to be a co maintainer?
> 

Kinda? https://github.com/linux-apfs/linux-apfs-rw/issues/68#issuecomment-2608400271
See that link. I did not really get an answer, so I decided to start the
process anyways. If he does not want to co-maintain, I completely
understand. I don't want to assume he is willing to. Ultimately, it is
up to him.

Thanks,
Ethan

> >> ---
> >> Ethan Carter Edwards (8):
> >>    staging: apfs: init lzfse compression library for APFS
> >>    staging: apfs: init unicode.{c,h}
> >>    staging: apfs: init apfs_raw.h to handle on-disk structures
> >>    staging: apfs: init libzbitmap.{c,h} for decompression
> >>    staging: apfs: init APFS
> >>    staging: apfs: init build support for APFS
> >>    staging: apfs: init TODO and README.rst
> >>    MAINTAINERS: apfs: add entry and relevant information
> >> 
> >> MAINTAINERS                                      |    6 +
> >> drivers/staging/Kconfig                          |    2 +
> >> drivers/staging/apfs/Kconfig                     |   13 +
> >> drivers/staging/apfs/Makefile                    |   10 +
> >> drivers/staging/apfs/README.rst                  |   87 +
> >> drivers/staging/apfs/TODO                        |    7 +
> >> drivers/staging/apfs/apfs.h                      | 1193 ++++++++
> >> drivers/staging/apfs/apfs_raw.h                  | 1567 +++++++++++
> >> drivers/staging/apfs/btree.c                     | 1174 ++++++++
> >> drivers/staging/apfs/compress.c                  |  442 +++
> >> drivers/staging/apfs/dir.c                       | 1440 ++++++++++
> >> drivers/staging/apfs/extents.c                   | 2371 ++++++++++++++++
> >> drivers/staging/apfs/file.c                      |  164 ++
> >> drivers/staging/apfs/inode.c                     | 2235 +++++++++++++++
> >> drivers/staging/apfs/key.c                       |  337 +++
> >> drivers/staging/apfs/libzbitmap.c                |  442 +++
> >> drivers/staging/apfs/libzbitmap.h                |   31 +
> >> drivers/staging/apfs/lzfse/lzfse.h               |  136 +
> >> drivers/staging/apfs/lzfse/lzfse_decode.c        |   74 +
> >> drivers/staging/apfs/lzfse/lzfse_decode_base.c   |  652 +++++
> >> drivers/staging/apfs/lzfse/lzfse_encode.c        |  163 ++
> >> drivers/staging/apfs/lzfse/lzfse_encode_base.c   |  826 ++++++
> >> drivers/staging/apfs/lzfse/lzfse_encode_tables.h |  218 ++
> >> drivers/staging/apfs/lzfse/lzfse_fse.c           |  217 ++
> >> drivers/staging/apfs/lzfse/lzfse_fse.h           |  606 +++++
> >> drivers/staging/apfs/lzfse/lzfse_internal.h      |  612 +++++
> >> drivers/staging/apfs/lzfse/lzfse_main.c          |  336 +++
> >> drivers/staging/apfs/lzfse/lzfse_tunables.h      |   60 +
> >> drivers/staging/apfs/lzfse/lzvn_decode_base.c    |  721 +++++
> >> drivers/staging/apfs/lzfse/lzvn_decode_base.h    |   68 +
> >> drivers/staging/apfs/lzfse/lzvn_encode_base.c    |  593 ++++
> >> drivers/staging/apfs/lzfse/lzvn_encode_base.h    |  116 +
> >> drivers/staging/apfs/message.c                   |   29 +
> >> drivers/staging/apfs/namei.c                     |  133 +
> >> drivers/staging/apfs/node.c                      | 2069 ++++++++++++++
> >> drivers/staging/apfs/object.c                    |  315 +++
> >> drivers/staging/apfs/snapshot.c                  |  684 +++++
> >> drivers/staging/apfs/spaceman.c                  | 1433 ++++++++++
> >> drivers/staging/apfs/super.c                     | 2099 ++++++++++++++
> >> drivers/staging/apfs/symlink.c                   |   78 +
> >> drivers/staging/apfs/transaction.c               |  959 +++++++
> >> drivers/staging/apfs/unicode.c                   | 3156 ++++++++++++++++++++++
> >> drivers/staging/apfs/unicode.h                   |   27 +
> >> drivers/staging/apfs/xattr.c                     |  912 +++++++
> >> drivers/staging/apfs/xfield.c                    |  171 ++
> >> 45 files changed, 28984 insertions(+)
> >> ---
> >> base-commit: 695caca9345a160ecd9645abab8e70cfe849e9ff
> >> change-id: 20250210-apfs-9d4478785f80
> >> 
> >> Best regards,
> >> -- 
> >> Ethan Carter Edwards <ethan@ethancedwards.com>
> 
> 

