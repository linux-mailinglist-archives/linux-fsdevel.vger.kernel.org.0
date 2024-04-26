Return-Path: <linux-fsdevel+bounces-17874-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E578B3341
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 10:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F00128285C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 08:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 605C313CAB7;
	Fri, 26 Apr 2024 08:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A3J/Wyo2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB3C14293;
	Fri, 26 Apr 2024 08:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714121419; cv=none; b=T5sNx7KANcQIUF+mq44NVFnO+KYAq/OH2Iiy2V/cQLjo/3Q20np6OSAcpwCPv9aXsVflqnUVR/mX+0zIwjHH4qt/CEgFbvs9l1xCuhr0deBdtSFpKiitIxN74OvnENVL52W5oL0blju649wTAfyx4LfwbR7DK1WpgXqEaVIhWGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714121419; c=relaxed/simple;
	bh=DYNyroIVKSZ0unmnVFHuxmgLOubVibFZ/fyc8X1R8f8=;
	h=Date:Message-Id:From:To:Cc:Subject:In-Reply-To; b=nBa8HN9FbuPH+pPbwAoTyRtOF7qih+nxh3tI3aDESwJ5pvD1uaQjDXTOcpW8iS1xCEfSjKTnaWzVm00GDAnD7PKbaTk1xAnUhWHDhbEo1u4KYs9I5Yc+7TKHAIYwo3PtD44gpuLmZanDC/4sBECZFkjxTTaHjlXNmIMh0LjybSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A3J/Wyo2; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-60c49bdbcd3so517982a12.0;
        Fri, 26 Apr 2024 01:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714121418; x=1714726218; darn=vger.kernel.org;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cJFMMSFWa30LVDJuI+U3h4eLS4EveVUZvpWPDq6Pib4=;
        b=A3J/Wyo2xwjgOMWyBdMtUfVWXPYA6+GmPoGaMsicZkZffLBVmdokLub+mMMKE/eF7Z
         8rfnpUYxIbaJaLsKmVaNngPrELRs2EhS1EVNV4m7ZsCiBKmmFqAvlWfICkwdZQD06ipY
         9KK7PQAixruu6ApvyGCBs66B+G37h4ANd/cdBELHQo8d4gib0QZTkNoeSS4sVwzDk6cv
         EgfS/aVINe5gn0d2p79KJbMdvngXiJqVZ7NbP4jOvVlxw6MD0CJ4Mrqh0ZVF0duiRP9N
         3IvQlDbyWg7CnkDTDKXrYIG9MiwhMhRBEeu5+sN9TGrYyK4YSMcG3J8jvWKTYrD9vTgp
         YX6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714121418; x=1714726218;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cJFMMSFWa30LVDJuI+U3h4eLS4EveVUZvpWPDq6Pib4=;
        b=qXOzJbOUsx67hxYg2d3uWE2Z+4xeh5ZPZYYHy6zftA8aJpiVbWDwjqnNXKmTUiI4RK
         /MvxQM46MTavg/OWGr4R1quE2/rSYtFNyb0+Iwkc16p5rJkPOX3+yhSZ5Faj3orpuHeu
         hcNocAIUjQ8FshVJbEM9JSSC9L51baTqMXRrYsoUDbuPKGDBmyPuxpmHxINm5JCo4Kiv
         9ik5twUDJWxzHQDuvdu5YxFSh3KvyUPtrTOlvQI4ZPWyxESUfkjnnkAF15u8BLCL40AG
         0j+B6boz5AKHDUGkqDuiI+FPM2TP92NYCmbJp2E5H8BhUXKQfRKqr33ZJKYpP4KwdUVM
         M+Dw==
X-Forwarded-Encrypted: i=1; AJvYcCUxvkGf9EnQNtaQZenyKfn+3cwx5Voiy7oPudqQ5UNQvM4ZYAKRVgKkzcpTSiVSlu6Df4fbA03N86e99SJG47CV80goc4VObOay3NEsf9C49Yx0vWuP939U10ubBvGtwHUzw8HWHeyIOA==
X-Gm-Message-State: AOJu0YyiBJ7TAsxdhZOdinnA8JDQ0F9Cg5ytRk1PsErymro9uIpNP6Dr
	Y/zSnNUoUba2ScELgOFG/jvjSvPdbf6xrHj2M4GYKb57PZji6GTs
X-Google-Smtp-Source: AGHT+IGxZ62PmQ42Oa+TlKbuThlX/EEh+sLT9Dn2wqRaG7974BD0kJBa+ZEsvaggtj4RBRD4Ah+VfA==
X-Received: by 2002:a05:6a20:daa7:b0:1ad:7e4d:6dae with SMTP id iy39-20020a056a20daa700b001ad7e4d6daemr2613505pzb.6.1714121417750;
        Fri, 26 Apr 2024 01:50:17 -0700 (PDT)
Received: from dw-tp ([171.76.87.172])
        by smtp.gmail.com with ESMTPSA id 192-20020a6301c9000000b0060795a08227sm3694145pgb.37.2024.04.26.01.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 01:50:17 -0700 (PDT)
Date: Fri, 26 Apr 2024 14:20:05 +0530
Message-Id: <87wmokik3m.fsf@gmail.com>
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, "Darrick J . Wong" <djwong@kernel.org>, Ojaswin Mujoo <ojaswin@linux.ibm.com>, Jan Kara <jack@suse.cz>
Subject: Re: [RFCv3 6/7] iomap: Optimize iomap_read_folio
In-Reply-To: <ZitPUH20e-jOb0n-@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Christoph Hellwig <hch@infradead.org> writes:

> On Thu, Apr 25, 2024 at 06:58:50PM +0530, Ritesh Harjani (IBM) wrote:
>> iomap_readpage_iter() handles "uptodate blocks" and "not uptodate blocks"
>> within a folio separately. This makes iomap_read_folio() to call into
>> ->iomap_begin() to request for extent mapping even though it might already
>> have an extent which is not fully processed.
>> 
>> This happens when we either have a large folio or with bs < ps. In these
>> cases we can have sub blocks which can be uptodate (say for e.g. due to
>> previous writes). With iomap_read_folio_iter(), this is handled more
>> efficiently by not calling ->iomap_begin() call until all the sub blocks
>> with the current folio are processed.
>
> Maybe throw in a sentence here that this copies what
> iomap_readahead_iter already does?

Does this sound any better?

iomap_read_folio_iter() handles multiple sub blocks within a given
folio but it's implementation logic is similar to how
iomap_readahead_iter() handles multiple folios within a single mapped
extent. Both of them iterate over a given range of folio/mapped extent
and call iomap_readpage_iter() for reading.


>
> Otherwise this looks good to me modulo the offset comment from willy.

Yes, I will address willy's comment too. 
Thanks for the review!

-ritesh

