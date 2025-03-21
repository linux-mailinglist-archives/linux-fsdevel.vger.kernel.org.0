Return-Path: <linux-fsdevel+bounces-44732-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C988A6C28F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Mar 2025 19:38:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 249AD189D9FF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Mar 2025 18:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D746F22FDE2;
	Fri, 21 Mar 2025 18:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ypsf8qN2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC597B664;
	Fri, 21 Mar 2025 18:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742582320; cv=none; b=F1zxo5AxdHVOlNTk9S5C1hvcFK95Q4baITr4swdLIKr3p6kSx4u8yNkpY5MK/QEtEROjgLv/wCWbd509QUHQZcnYRXP4YkJ4Ehc98WGhKwh5y67AnIbTM7eUKRasn8K1bWvh0fL+UaoV3dCgVIFL+mazLi0pOK/DBClzdHw7Urg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742582320; c=relaxed/simple;
	bh=4rrZLfeHbIKAjKa1DKmEyWOdLHgdJOl0MAzQeIkOudo=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=As+l4FOgLRSd0Mv6QwQ5JZTxtVMARDdUVGPnFp7L3x8a4ut6/e6Ciw8LGYBSdl03WUxfMBUUoqUfNXjtKl6WpQiXEnNL/uMd68LxASpEYwFf0ltkZTq9nrrJipVspppUxTeatDq9Yvb79LVKmQlgC2bPPCTl067zuBx5yXoob2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ypsf8qN2; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-22401f4d35aso51935995ad.2;
        Fri, 21 Mar 2025 11:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742582318; x=1743187118; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WLg29Du4d9hxLW5NIOZlGqy6bsHbWf+jMBwTEsqW+BA=;
        b=Ypsf8qN2KrQURN6SH0K2taGNXHi0zbNJPcthckFp6/HWPP6t8mLO+sUljtBBQsstVB
         D57R8aS8bEYuSZsM0X8m+mfeE3J9Nbpj2dm+BLyLdBUiWuODDi0p96+QD/brT2IdXan9
         Fq9Rb3kmcdD3G+kPJKFgXTEteLDMkObQ8a0dEL5eQaY9Dxi1yERxpuFvK1i9aPFVnhj2
         XkGutoQCaFobjbcs4lexsU6KlEHKjPFLBGHYkYCodFN9VT3c7EvUb2Ip2AWrNJbIEQy+
         xXTfShGtYnrFHBRpREaDXV+x/uHVP/xZBTjFZ2LK+biAGay0oA4kzh6nA7crbWXtJzJt
         cm3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742582318; x=1743187118;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WLg29Du4d9hxLW5NIOZlGqy6bsHbWf+jMBwTEsqW+BA=;
        b=UZnrGgChz+dBCf6hofljt95GnIR01kxMefqs0XzB/8sT3erUZysKHjFgJGfkdnxGP4
         ILLg5Rj/Fghn6HC6f1i+8iuuMKLIebOF8OvoJNDNlRUDGwaeUNQBPu/4x7c9yHzLyazU
         U4yWLV8iwgYieNbyvRO1qWl9aLo9E3GhuFKmhweYoqnLLhndRo6PIwBvT8ao1gChYxDw
         FiN/OF0LZgQplCUFsDINMn6oqLMcRG1i/rqmd0ZLheq0ZjMbg90+jMEOUxQtFPB/odcu
         kMTxttzXA9U7XM9acGZu20B/wePalNcw3K21xXAmlH+EmmIN+CXaQe8f54Cpn71AHdG3
         pisQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkr2BnThEyOhxBIFT4ZbBivrD8dAzTTCCqplX7SdcEj0Jbi68PC+xUBROzfIXfPRyNLMB98zaH9qvGXw==@vger.kernel.org, AJvYcCVzM7SS3rHpaIjj25TYnyjYf7/QgPUrJPgnUABIQAytguk6u2CoWaMG7z9D3nZJnzm5JLhMXjkN6KOi+ZkAOw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwcC+Nub/ORMLmLbClrt3S5HOHsONR+W+U/v0IoIXBmJoR2k+Pr
	rZj53UIOH81PYHUSupcM35IdCC6OHcxoIPwSnE6Z90qAcHehmTdc
X-Gm-Gg: ASbGncstiAxSAU027typRVXISkxpWAbZYzCxmON53aUdTP89P0SXSx0Ki5gPDNsx48B
	h7b5pVjYovE70BnNbfYybiA55UxdfCJjtrNHb6qsE0W4YPukqYfroDROwTBAzdV2L2QXcg0qo2l
	IoBGZgyIOEmoz0mQvwPG6czqJ31FKgVvP+8Rp+cTVXX0qkVBWOW/wFKfut2qA4g5fBOg3SAVApA
	PpW4y3Q5QLAMZNKiUIGBQoQw/QRqCHLhAgAbb2qrujbx/qAXFVi6bSMiaXH359KOR4btVX07h5C
	ql6Felv6EryIRaSm/fblq+gGYWVnLr37N8JDRg==
X-Google-Smtp-Source: AGHT+IHWkYu5R5KHVsYmHJNCVf/nynTskt0Y86WId2DrBJREIzTZC0pMVzC1eXdRjZpNgDwkmpUIoA==
X-Received: by 2002:a17:903:98d:b0:223:5e76:637a with SMTP id d9443c01a7336-22780d980fcmr73987485ad.23.1742582318033;
        Fri, 21 Mar 2025 11:38:38 -0700 (PDT)
Received: from dw-tp ([171.76.82.198])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22780f397d9sm20752535ad.49.2025.03.21.11.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 11:38:37 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Keith Busch <kbusch@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-block@vger.kernel.org, lsf-pc@lists.linux-foundation.org, david@fromorbit.com, leon@kernel.org, hch@lst.de, sagi@grimberg.me, axboe@kernel.dk, joro@8bytes.org, brauner@kernel.org, hare@suse.de, willy@infradead.org, john.g.garry@oracle.com, p.raghav@samsung.com, gost.dev@samsung.com, da.gomez@samsung.com
Subject: Re: [LSF/MM/BPF TOPIC] breaking the 512 KiB IO boundary on x86_64
In-Reply-To: <Z92WBePJ620r5-13@kbusch-mbp>
Date: Fri, 21 Mar 2025 22:51:42 +0530
Message-ID: <87frj6s3ix.fsf@gmail.com>
References: <Z9v-1xjl7dD7Tr-H@bombadil.infradead.org> <87o6xvsfp7.fsf@gmail.com> <20250320213034.GG2803730@frogsfrogsfrogs> <87jz8jrv0q.fsf@gmail.com> <Z92WBePJ620r5-13@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Keith Busch <kbusch@kernel.org> writes:

> On Fri, Mar 21, 2025 at 07:43:09AM +0530, Ritesh Harjani wrote:
>> i.e. w/o large folios in block devices one could do direct-io &
>> buffered-io in parallel even just next to each other (assuming 4k pagesize). 
>> 
>>            |4k-direct-io | 4k-buffered-io | 
>> 
>> 
>> However with large folios now supported in buffered-io path for block
>> devices, the application cannot submit such direct-io + buffered-io
>> pattern in parallel. Since direct-io can end up invalidating the folio
>> spanning over it's 4k range, on which buffered-io is in progress.
>
> Why would buffered io span more than the 4k range here? You're talking
> to the raw block device in both cases, so they have the exact same
> logical block size alignment. Why is buffered io allocating beyond
> the logical size granularity?

This can happen in following 2 cases - 
1. System's page size is 64k. Then even though the logical block size
granularity for buffered-io is set to 4k (blockdev --setbsz 4k
/dev/sdc), it still will instantiate a 64k page in the page cache.

2. Second is the recent case where (correct me if I am wrong) we now
have large folio support for block devices. So here again we can
instantiate a large folio in the page cache where buffered-io is in
progress correct? (say a previous read causes a readahead and installs a
large folio in that region). Or even iomap_write_iter() these days tries
to first allocate a chunk of size mapping_max_folio_size().


However with large folio support now in block devices, I am not sure
whether an application can retain much benefit of doing buffered-io (if
they happen to mix buffered-io and direct-io carefully over a logical
boundary). Because the direct-io can end up invalidating the entire
large folio, if there is one, in the region where the direct-io
operation is taking place. However this may still be useful if only
buffered-io is being performed on the block device.

-ritesh

