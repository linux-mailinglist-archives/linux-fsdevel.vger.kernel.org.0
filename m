Return-Path: <linux-fsdevel+bounces-21508-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A769904C2A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2024 08:59:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2CDF28193E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2024 06:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 571B8168C3C;
	Wed, 12 Jun 2024 06:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M5ALtACs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6760F12D1FE;
	Wed, 12 Jun 2024 06:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718175541; cv=none; b=AhCJxzADbFpboMmp6xcwwJ6ZCXTbOeDxzwjHwJTDDl2QVX6fKxH9oljV65fA7A6+rXL0G5IAgsCqBcL9QaSCyVPrymDbH5QWIDkzVOCnm9IKRXgLEKyR/Bvml59dMuGE+nRsLmHFglvnSP6TN4WhHzz7qCqbYm8LKW2oZ6kZ8Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718175541; c=relaxed/simple;
	bh=P5/SKE5g4jbMVwxP3MuDPs2UW0aj74nxG9qED+xOExs=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=m0C2Ng1ewSsNJfuAwlpRIzgdXBJRgSL+m2tTR5bwCQzMR7dNZsUpAjaFo4DY7caD3UY9eLUhy5e4sE900rUFbcc/Ssb0Acdv8BeJFyqUjjJDWRLtzfbwlfkMzOOjoKvyzddUiBQkS6OO5/NfUpLVrol1Wd5wphzS1G8Qkyz2BAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M5ALtACs; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1f480624d0dso16652505ad.1;
        Tue, 11 Jun 2024 23:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718175540; x=1718780340; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tm/u9Q34O3UXQ3CActc83zLA5cchBEk8RtLpOuISpos=;
        b=M5ALtACs+bB+9S8QUnmtTpTk+DRWG/lNP/mocCFn608ktPS9o2+xx6FJ3oNu3xTBcw
         qc4Qq/Eyb7wdj+McfV3SHpL6QWYmCQ+tprD4nNqK1mVDi3iFTOosT4cGaVLZUJ0JCHJx
         34JrpbgX0S8PmfZvvTn21WtOHp6+mFP2GjRa0RRXrpOBuydh7317YPMZzn+FFDlkqcPX
         A9/pI4G+ckpK1bnfc1B/RORMbg7PIYK3czq/gdiE8kb5zhwMoz1vSX7chIWA+0aDvkdJ
         6x3NEd5dG64WMW6r3GJCeCfgDOBBU9B/vetBB/bYs/Y+J9jwPDhOYBPFxlVXvH5dUxHS
         bXXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718175540; x=1718780340;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tm/u9Q34O3UXQ3CActc83zLA5cchBEk8RtLpOuISpos=;
        b=JzrlED0YUljCYBY+U5Gi92rO9wdAYSsT8+j9by1fT35NpMHJcdODb3KppOfi22kUTR
         zc16xzqk363OriSEcfqx+BK7+OZ5b3vSTCOoEMBE6cN5rKkjVeei3j9QF8KJzeVUm9yL
         UBjvgvRajNNE+JcizgT1IBtUFXdR6+LyKpc3ZlDKM5tPOyfOsUSoxorW7D6yxq76qprv
         UC7q4/2BjPS+6IuQz7wHoOTb82qlI0XMuD0hm/RT//Ls76UtUMsdnQGt9owXbDsT8GEh
         CV8c+LjVPPJjOnEdyhxITzVmsv2IMhxe0gjNwv/wDf46ID1+ImIHaDXF2fI1/r/fvN+I
         racA==
X-Forwarded-Encrypted: i=1; AJvYcCXa70J+Erx5oluzCHygjPQ7h117hGqkogxnewQ5Go43pUdqsm134IQtg884s4On5uWKOwc/OA8T5tpSaU1dQNo4HdoXCJ0lfBF6n98Bi2BKy/3d59htpMgublMF34vaQfogI/vaLx8aKQ==
X-Gm-Message-State: AOJu0YzVG600eKpFaFYFGwqhkKtA34JdVvKanTzi7AOcIiKQOrd4qmgN
	W+Hyr5bIfevTQHb/drRFPIuFXvXaO1XOhCVXJdl8X3ktdsdlWMs7
X-Google-Smtp-Source: AGHT+IGx6YGnpv1ijukiEX0Tkav2XBXoUlNs7fmZVpCEI7PogfG5/bjtdarvzsnVczvIJEo7O24HoA==
X-Received: by 2002:a17:902:d4d2:b0:1f6:3750:527f with SMTP id d9443c01a7336-1f83b61329fmr11823495ad.31.1718175539674;
        Tue, 11 Jun 2024 23:58:59 -0700 (PDT)
Received: from dw-tp ([171.76.84.72])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f71b9dec2bsm44576245ad.186.2024.06.11.23.58.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 23:58:59 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, Dave Chinner <david@fromorbit.com>, Matthew Wilcox <willy@infradead.org>, Christoph Hellwig <hch@infradead.org>, Christian Brauner <brauner@kernel.org>, Ojaswin Mujoo <ojaswin@linux.ibm.com>, Jan Kara <jack@suse.cz>, Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH] Documentation: document the design of iomap and how to port
In-Reply-To: <20240611215049.GC52987@frogsfrogsfrogs>
Date: Wed, 12 Jun 2024 12:25:47 +0530
Message-ID: <871q52abv0.fsf@gmail.com>
References: <20240608001707.GD52973@frogsfrogsfrogs> <874ja118g7.fsf@gmail.com> <20240610231111.GW52987@frogsfrogsfrogs> <875xug9dyt.fsf@gmail.com> <20240611215049.GC52987@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

"Darrick J. Wong" <djwong@kernel.org> writes:

> On Tue, Jun 11, 2024 at 12:13:22PM +0530, Ritesh Harjani wrote:
>> "Darrick J. Wong" <djwong@kernel.org> writes:
>> 

<snip>
>> >> > + * ``addr`` describes the device address, in bytes.
>> >> > +
>> >> > + * ``bdev`` describes the block device for this mapping.
>> >> > +   This only needs to be set for mapped or unwritten operations.
>> >> > +
>> >> > + * ``dax_dev`` describes the DAX device for this mapping.
>> >> > +   This only needs to be set for mapped or unwritten operations, and
>> >> > +   only for a fsdax operation.
>> >> 
>> >> Looks like we can make this union (bdev and dax_dev). Since depending
>> >> upon IOMAP_DAX or not we only set either dax_dev or bdev.
>> >
>> > Separate patch. ;)
>> >
>> 
>> Yes, in a way I was trying to get an opinion from you and others on
>> whether it make sense to make bdev and dax_dev as union :)
>> 
>> Looks like this series [1] could be the reason for that. 
>> 
>> [1]: https://lore.kernel.org/all/20211129102203.2243509-1-hch@lst.de/#t
>> 
>> I also don't see any reference to dax code from fs/iomap/buffered-io.c
>> So maybe we don't need this dax.h header in this file.
>> 
>> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
>> index c5802a459334..e1a6cca3cec2 100644
>> --- a/fs/iomap/buffered-io.c
>> +++ b/fs/iomap/buffered-io.c
>> @@ -10,7 +10,6 @@
>>  #include <linux/pagemap.h>
>>  #include <linux/uio.h>
>>  #include <linux/buffer_head.h>
>> -#include <linux/dax.h>
>>  #include <linux/writeback.h>
>>  #include <linux/list_sort.h>
>>  #include <linux/swap.h>
>
> Yes, given that both you and hch have mentioned it, could one of you
> send a cleanup series for that?
>

Sure, Thanks Darrick and Christoph.
I can queue this with my other work where I am improving iomap for
indirect-block mapping, so that it will be easier to get testing done on
all of this together.

-ritesh

