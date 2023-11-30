Return-Path: <linux-fsdevel+bounces-4326-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 287077FE92D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 07:33:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D71572821F8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 06:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FCA420DCF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 06:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fDLvhxS9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 632261A8;
	Wed, 29 Nov 2023 21:27:34 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-3b58d96a3bbso303264b6e.1;
        Wed, 29 Nov 2023 21:27:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701322053; x=1701926853; darn=vger.kernel.org;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IidPzN7+YRKzkATE+W2PQahD3S4vek9uP5XdTqFDrDo=;
        b=fDLvhxS9Z1Y/QUPqo3+yTce8sLfPp0ltICjnghL+4O0SlDjDSj2dApU/NJj6ZhoJ09
         FEPSgN45r34UVggT0p60bvkJ5KQYb8ri9ZdIPyHy9gs/wsD2gMbmNF3/3qwGRoxneTJH
         /nKfWB1GWcINWb7euneaneRQDfdBT0oOem1ic7d5QpSwOR29AO6vBLDTioo3idv/Y5kg
         ldcDq/oQIL5ilxxE+tHqonZLr0r9BW0MeHWWljrWLKPDpqWebYDXaWW+rhPESWsQu55N
         NQwKrowQ9d5fBaWBYq6X2JXSWfSTEhn+7Zv+cbPZhebFAZjmxDY9aD2fTMte6fkY5mHw
         I5Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701322053; x=1701926853;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IidPzN7+YRKzkATE+W2PQahD3S4vek9uP5XdTqFDrDo=;
        b=KyeUL0pBnzKXOr4ic7lfHTrf3YP6c+G8UtyfBjclfe7xVXeGHaxWCf7aaiKHslEjka
         Ox99Bgna6ly7Y021hXUgo4sa+D8g2HsxbK3vo0L4q36d2k0qCtOzIxQmJalS60mpVAgl
         DnwLXCNuElx9WTvL70jV6TLxkhOB4TAnfFvoXJzgWHJWcfhfKlKERGohIDgZ9D2p265u
         u0fxXZla3NxlmTgW372dXEdPmcqPXGJBcihj6Y94cfqu07l+8c6+78aXGdPE2WzpZG+3
         2g1j8VAf3GwBewjfwRyn6hGm1D9jt23+roUBQfOFDamiNizIQJLkcmo+QUW/tO3p2zx7
         U68g==
X-Gm-Message-State: AOJu0Yz8RDzxnOkxLcs9Da1v5uywS6lJUMnr2kbip9T2Qkm34sYR397/
	6zlAZGQ/uYHq+1x4dAMN8kJTus8Nylo=
X-Google-Smtp-Source: AGHT+IF/CNjVO+RqmIPkEehbBQJr1V92AefHbatormtRrvwCfpcy8A85GnlT4Tt/EVvzM4gzFcgeQA==
X-Received: by 2002:a05:6808:399a:b0:3b8:990b:752b with SMTP id gq26-20020a056808399a00b003b8990b752bmr4290032oib.3.1701322052633;
        Wed, 29 Nov 2023 21:27:32 -0800 (PST)
Received: from dw-tp ([49.205.218.89])
        by smtp.gmail.com with ESMTPSA id c20-20020aa78814000000b006bd26bdc909sm319275pfo.72.2023.11.29.21.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 21:27:31 -0800 (PST)
Date: Thu, 30 Nov 2023 10:57:28 +0530
Message-Id: <87wmtzhku7.fsf@doe.com>
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC 2/3] ext2: Convert ext2 regular file buffered I/O to use iomap
In-Reply-To: <ZWgPzfd8P+F/qQlh@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Christoph Hellwig <hch@infradead.org> writes:

> On Thu, Nov 30, 2023 at 08:54:31AM +0530, Ritesh Harjani wrote:
>> So I took a look at this. Here is what I think -
>> So this is useful of-course when we have a large folio. Because
>> otherwise it's just one block at a time for each folio. This is not a
>> problem once FS buffered-io handling code moves to iomap (because we
>> can then enable large folio support to it).
>
> Yes.
>
>> However, this would still require us to pass a folio to ->map_blocks
>> call to determine the size of the folio (which I am not saying can't be
>> done but just stating my observations here).
>
> XFS currently maps based on the underlyig reservation (delalloc extent)
> and not the actual map size.   This works because on-disk extents are
> allocated as unwritten extents, and only the actual written part is
> the converted.  But if you only want to allocate blocks for the part
> actually written you actually need to pass in the dirty range and not
> just use the whole folio.  This would be the incremental patch to do
> that:

yes. dirty range indeed.

>
> http://git.infradead.org/users/hch/xfs.git/commitdiff/0007893015796ef2ba16bb8b98c4c9fb6e9e6752
>
> But unless your block allocator is very cheap doing what XFS does is
> probably going to work much better.
>
>> ...ok so here is the PoC for seq counter check for ext2. Next let me
>> try to see if we can lift this up from the FS side to iomap - 
>
> This looks good to me from a very superficial view.  Dave is the expert
> on this, though.

Sure.

