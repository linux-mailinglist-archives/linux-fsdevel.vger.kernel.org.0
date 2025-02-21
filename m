Return-Path: <linux-fsdevel+bounces-42310-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41984A401E1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 22:13:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 498C4420C58
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 21:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B8C9253F06;
	Fri, 21 Feb 2025 21:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3V/XDInB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C13C1F3FE8
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Feb 2025 21:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740172408; cv=none; b=XDfUGHHs43AvG5kJrLI6+Ni8lD0XtyyuxON5dMq+rsIiDZAR089uemNbqrD4GxI+YLp6sPgcZ6yya8XobdxAAfhgfdktRgcx+oThxWDA9f44KuBSEe+wf4VpNARxUeW8Hrd9EYWMxjm+qkYCOxez4ymsvBz99oO0RAZlCIMghKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740172408; c=relaxed/simple;
	bh=0a/5VjZ9YQsqB0qvwA2rQ2LgTDVW7fMERTkm2buWcc0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=sRDjNnbJ5h4tiL30p1r+rUJz9J3HXHmBIi3tCJlq8pLVq87E/kGrYDaUlbH7btIHEUwRjVHZWtQo53fyzE/T7slktT2tfbxUmaElfrt8OdnaaYKCkDWvpSexxyXg8dYp3Ti98XUtWGyk/NP/otdlckCJPm2x3tf7y84HFjXwsT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3V/XDInB; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-221ac1f849fso6155ad.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Feb 2025 13:13:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740172406; x=1740777206; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0a/5VjZ9YQsqB0qvwA2rQ2LgTDVW7fMERTkm2buWcc0=;
        b=3V/XDInBUt+HLR3BcfsAN6PiaVwy2szqd3eBj3Sa4HuU6Iv0rEg4j81eCa1G0zbsxV
         ezAWi+ojgMQ6xCSknZIIAvs0j4P28BK7sOqAY08n2OdDBOgx4MlYKtmujftf3daqOVwa
         DOnCvci1A4zFazXKVjO6rXx7bpXTJkn1FI067xniC9ZoQ/C6q1Zc0tax0dNFkCBr3xs2
         74qupoxoaE4amGH1IxzZI9a1D6Kc5mWzUU04/BwkcnjVDTj7nybWoSUJfOhszslFj4Nu
         xv/9WLTJVUkNDGZNzq4mYlSReZRCEVft2OEEmnPK4i4VNnH/VoFZTaJfrG8iDe6ScjJ5
         JdCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740172406; x=1740777206;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0a/5VjZ9YQsqB0qvwA2rQ2LgTDVW7fMERTkm2buWcc0=;
        b=DvbG94WlKL+Dk4FTMY3jqOTUb15p4KNAEx1vR+p385bhB+vajPlPN3wXVgULU1e5fQ
         5Io0MRSuyJuxDPn2XYEQV5mR0Oigv0YM/jzbyuXtFZ+OjqNwq/HPG4JFW78Mzdvij1SA
         sM+uVBEhm5/3ONb8KqkD5PYmDY0RixWmrH2OeFQbv7OSXGkuAzk+g/Ao1VDhql5mDCfd
         3H5iy2u+xLkZ5eG9TMPPDGPOGMgOG3HhvfXvJTZ/bFR3cA6NJk4brJX5C6eiA30z8rRW
         W7OOoweCB5BNP3rXmvksn0mZ0EzkGFdCwXDkRpRkjml4wrByX5VJfqNN6+81dP5lLzpO
         XhMg==
X-Forwarded-Encrypted: i=1; AJvYcCWylQn/Lq0FtKBeV1ef+9adh6u9pkws7HeAXecOcYOfW4l9mgp+dUid9JXlYKZ5Jx2EZa+/TiBvkr5fu35R@vger.kernel.org
X-Gm-Message-State: AOJu0YwuvgZs313H8708/KjT1tRJAYlEEudRQWlV342gpdPmvanA+hTn
	l5Nl782Hg1kGG0mOJaZb+agyru5wmCQefe4v0uSoEE/vWzghDslf6JFZpITiihzS4SthRmFlPBF
	8CiImYByh3v9QoVlui0yN6G/t7xDFHU5v/+A1
X-Gm-Gg: ASbGncutIQB6hGMtCPg5Ad8HDMiHTMM7+QREl297JCwknuVQIUtYGXYEdDmrOkmnMMm
	+kHOGhQ62sO77kzVul4REVpe2QVCTeamoS9lpl8/QK1Y76PoY9qdsuyefW1LaBDUOozmhSKrJ/J
	v7moHmJ+qAiBXo45dJzHyDxXONtfAABxkHSKls
X-Google-Smtp-Source: AGHT+IF4BBjHqEtO814ZrRj15jBo628pMYidnOtY4XjQ8S+tLYHsl6EerG/5wPIi+nM4wIcnq38arvvR8/KrDP1JDEs=
X-Received: by 2002:a17:903:41c1:b0:215:4bdd:9919 with SMTP id
 d9443c01a7336-221ba6f71a0mr453155ad.17.1740172406211; Fri, 21 Feb 2025
 13:13:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Kalesh Singh <kaleshsingh@google.com>
Date: Fri, 21 Feb 2025 13:13:15 -0800
X-Gm-Features: AWEUYZkEm3e39YfjJK4KLHE7c24y-zC6H-DahuCaL-sEri8pz5hvLohaKAds2Kc
Message-ID: <CAC_TJvfG8GcwG_2w1o6GOTZS8tfEx2h9A91qsenYfYsX8Te=Bg@mail.gmail.com>
Subject: [LSF/MM/BPF TOPIC] Optimizing Page Cache Readahead Behavior
To: lsf-pc@lists.linux-foundation.org, 
	"open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>
Cc: Suren Baghdasaryan <surenb@google.com>, David Hildenbrand <david@redhat.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Juan Yescas <jyescas@google.com>, android-mm <android-mm@google.com>, 
	Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi organizers of LSF/MM,

I realize this is a late submission, but I was hoping there might
still be a chance to have this topic considered for discussion.

Problem Statement
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Readahead can result in unnecessary page cache pollution for mapped
regions that are never accessed. Current mechanisms to disable
readahead lack granularity and rather operate at the file or VMA
level. This proposal seeks to initiate discussion at LSFMM to explore
potential solutions for optimizing page cache/readahead behavior.


Background
=3D=3D=3D=3D=3D=3D=3D=3D=3D

The read-ahead heuristics on file-backed memory mappings can
inadvertently populate the page cache with pages corresponding to
regions that user-space processes are known never to access e.g ELF
LOAD segment padding regions. While these pages are ultimately
reclaimable, their presence precipitates unnecessary I/O operations,
particularly when a substantial quantity of such regions exists.

Although the underlying file can be made sparse in these regions to
mitigate I/O, readahead will still allocate discrete zero pages when
populating the page cache within these ranges. These pages, while
subject to reclaim, introduce additional churn to the LRU. This
reclaim overhead is further exacerbated in filesystems that support
"fault-around" semantics, that can populate the surrounding pages=E2=80=99
PTEs if found present in the page cache.

While the memory impact may be negligible for large files containing a
limited number of sparse regions, it becomes appreciable for many
small mappings characterized by numerous holes. This scenario can
arise from efforts to minimize vm_area_struct slab memory footprint.

Limitations of Existing Mechanisms
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D

fadvise(..., POSIX_FADV_RANDOM, ...): disables read-ahead for the
entire file, rather than specific sub-regions. The offset and length
parameters primarily serve the POSIX_FADV_WILLNEED [1] and
POSIX_FADV_DONTNEED [2] cases.

madvise(..., MADV_RANDOM, ...): Similarly, this applies on the entire
VMA, rather than specific sub-regions. [3]
Guard Regions: While guard regions for file-backed VMAs circumvent
fault-around concerns, the fundamental issue of unnecessary page cache
population persists. [4]

Empirical Demonstration
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Below is a simple program to demonstrate the issue. Assume that the
last 20 pages of the mapping is a region known to never be accessed
(perhaps a guard region).

cachestat is a simple C program I wrote that returns the nr_cached for
the entire file using the new cachestat() syscall [5].

cat pollute_page_cache.sh

#!/bin/bash

FILE=3D"myfile.txt"

echo "Creating sparse file of size 25 pages"
truncate -s 100k $FILE

apparent_size=3D$(ls -lahs $FILE | awk '{ print $6 }')
echo "Apparent Size: $apparent_size"

real_size=3D$(ls -lahs $FILE | awk '{ print $1 }')
echo "Real Size: $real_size"

nr_cached=3D$(./cachestat $FILE | grep nr_cache: | awk '{ print $2 }')
echo "Number cached pages: $nr_cached"

echo "Reading first 5 pages..."
head -c 20k $FILE

nr_cached=3D$(./cachestat $FILE | grep nr_cache: | awk '{ print $2 }')
echo "Number cached pages: $nr_cached"

rm $FILE

-------

./pollute_page_cache.sh
Creating sparse file of size 25 pages
Apparent Size: 100K
Real Size: 0
Number cached pages: 0
Reading first 5 pages...
Number cached pages: 25


Thanks,
Kalesh

[1] https://github.com/torvalds/linux/blob/v6.14-rc3/mm/fadvise.c#L96
[2] https://github.com/torvalds/linux/blob/v6.14-rc3/mm/fadvise.c#L113
[3] https://github.com/torvalds/linux/blob/v6.14-rc3/mm/madvise.c#L1277
[4] https://lore.kernel.org/r/cover.1739469950.git.lorenzo.stoakes@oracle.c=
om/
[5] https://lore.kernel.org/r/20230503013608.2431726-3-nphamcs@gmail.com/

