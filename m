Return-Path: <linux-fsdevel+bounces-13146-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D39186BCC7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 01:25:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5405B288B6B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 00:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B22320335;
	Thu, 29 Feb 2024 00:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J64noYs2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E364B101C8;
	Thu, 29 Feb 2024 00:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709166026; cv=none; b=RwahxRjvDIkHSyN0hX4Y/UsnKLTe2KWaFn+EBtD3YkYeBznEcp3mL8Pzmq3k8IBS3oAYRO8fSOVuZuDGl+Dp6zMuUYzjmZnpF1oGTqxMcyZMsdtlhojvtI+ho4WlogspZpq06RQgHxtrEP6uHIgZg/SnwWij/n1lyEQYvs0aCwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709166026; c=relaxed/simple;
	bh=BvdAVAaadK3QwHaal211fg0PskV4RkLz4NBeTDVh3Ig=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ueifhf84ysAGWD/vWtmmmQBb535iH3yhzvO9bO4wET5jogDNPYfdypbLVmCW/IvkKFGXl4++SiRx8xcCaJDthZeqSfNCE1BOKJAlmqC8u3Pz8q6HgTGSMoHECDawzyiHolccRq86pFlGQ59zueO3q23PJlK3+PtQxhQSpcUhGJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J64noYs2; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6e47a3202f0so113862a34.2;
        Wed, 28 Feb 2024 16:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709166024; x=1709770824; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=w393zCdu0xHlp2PBB/YtzlCDvLqiNOOGgXpK5V2Qh88=;
        b=J64noYs2ThWbXJcemtmJ+2qYS1xG5yGuPifKnDCt9cak6tJ/b0gjbk/dMc+BWYplTQ
         4+yM52VIJN9cYaaw8EgAt2bO4Tr9oNKfNXiWaEQZmRNJ5Nf6Hgn2L2dhu71LL9VCnULC
         iq8AdSKSQ85RtE1Vv25F2ESgmZA75DCS9q8FjrXpQahCCikUixEuvj2aj8Zr+e7mAkxC
         HhwgcT/D57p7pfVv50GV9whB6qu/aoT3qtOYoaY0FCjDADSnufqhRdLXvQDrgBhFpBVy
         LSu3zCIm0U7J2kTg87Ux+7DqagvA5Aj1uSTP3Gjfmuu/+FUwQsqoNOaiTMN51eSh6GBx
         R1hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709166024; x=1709770824;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w393zCdu0xHlp2PBB/YtzlCDvLqiNOOGgXpK5V2Qh88=;
        b=U5y0V4bdXn6s//b+P5pXkf5cxB6KsP9dWV0QMvG0eT/HVZYqzLSzDP7jzlxjuJIU/F
         hzEvZnmdEtbQW13l+RsBkNfm5eZ3oivC6KWkK5TTg0cLxiPnnQPu1esuBJO5MrqdFkU4
         gsCzY4ODEMnx+455cj2/oEgT/SBn839BKCBh3owEXJg8zzyeqKdfPNJ9LjguwbpiPkoU
         35qP9aOmvT2LS3aEd9phRDBgWQqCo1EVzXN/ahzi9POPp2u9FJQWS7hD81ZqKhV9YGHD
         f7c1Mo5JzFHF5QnHqNG92a97h+w4BOSvNuKG1oNlxzk6X+V1fo3F6beN6PSgtcQRGQyZ
         ssng==
X-Forwarded-Encrypted: i=1; AJvYcCWGtyXxtn1fsRwR3Bxf/5pGhtrHh5zVLCLjUhC9mYFk24EN3dUo1vrN4KzYbCM0Jq1ihxx2avGCnLEZ7d9Jg8QtzLTOK7PYvm9aMK3WUbdIVVGJ9LUI0Yp5c5UEgTq7FYg3DiMiBmsuRQ==
X-Gm-Message-State: AOJu0YxgG0blEgo7XzHN9oR9HVcxY6D4NvE2Zfgzq/rWJtXybME4Pzxk
	Tsxigt1DmBK/ZjML0A/Nhxnx8FKOVvdPs2nK+y4LGWTEvR0cALoj
X-Google-Smtp-Source: AGHT+IFvFMvwDpZbAKYi3GrDuwDqqFPdGia4/8Y/ma96atLSvwHu/ThBLUGHswkqbeFZWAUmvnClRQ==
X-Received: by 2002:a05:6871:3404:b0:21f:a649:dc65 with SMTP id nh4-20020a056871340400b0021fa649dc65mr608151oac.6.1709166023805;
        Wed, 28 Feb 2024 16:20:23 -0800 (PST)
Received: from localhost.localdomain (070-114-203-196.res.spectrum.com. [70.114.203.196])
        by smtp.gmail.com with ESMTPSA id re4-20020a056871628400b002205bc51bfbsm93194oab.14.2024.02.28.16.20.21
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 28 Feb 2024 16:20:23 -0800 (PST)
Sender: John Groves <grovesaustin@gmail.com>
From: John Groves <John@Groves.net>
X-Google-Original-From: John Groves <john@groves.net>
To: lsf-pc@lists.linux-foundation.org,
	Jonathan Corbet <corbet@lwn.net>,
	Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Matthew Wilcox <willy@infradead.org>,
	linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	nvdimm@lists.linux.dev
Cc: John Groves <John@Groves.net>,
	John Groves <jgroves@micron.com>,
	john@jagalactic.com,
	Dave Chinner <david@fromorbit.com>,
	Christoph Hellwig <hch@infradead.org>,
	dave.hansen@linux.intel.com,
	gregory.price@memverge.com,
	Randy Dunlap <rdunlap@infradead.org>,
	Jerome Glisse <jglisse@google.com>,
	David Rientjes <rientjes@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	John Hubbard <jhubbard@nvidia.com>,
	Zi Yan <ziy@nvidia.com>,
	Bharata B Rao <bharata@amd.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
	Alistair Popple <apopple@nvidia.com>,
	Christoph Lameter <cl@gentwo.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jon Grimm <jon.grimm@amd.com>,
	Brian Morris <bsmorris@google.com>,
	Wei Xu <weixugc@google.com>,
	Theodore Ts'o <tytso@mit.edu>,
	mykolal@meta.com,
	Aravind Ramesh <arramesh@micron.com>,
	Ajay Joshi <ajayjoshi@micron.com>,
	Eishan Mirakhur <emirakhur@micron.com>,
	Ravi Shankar <venkataravis@micron.com>,
	Srinivasulu Thanneeru <sthanneeru@micron.com>
Subject: [LSF/MM/BPF TOPIC] Famfs: shared memory file system for disaggregated memory [LSF/MM/BPF ATTEND]
Date: Wed, 28 Feb 2024 18:20:20 -0600
Message-Id: <20240229002020.85535-1-john@groves.net>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

John Groves, Micron

Micron recently released the first RFC for famfs [1]. Although famfs is not
CXL-specific in any way, it aims to enable hosts to share data sets in shared
memory (such as CXL) by providing a memory-mappable fs-dax file system
interface to the memory.

Sharable disaggregated memory already exists in the lab, and will be possible
in the wild soon. Famfs aims to do the following:

* Provide an access method that provides isolation between files, and does not
  tempt developers to mmap all the memory writable on every host.
* Provide an an access method that can be used by unmodified apps.

Without something like famfs, enabling the use of sharable memory will involve
the temptation to do things that may destabilize systems, such as
mapping large shared, writable global memory ranges and hooking allocators to
use it (potentially sacrificing isolation), and forcing the same virtual
address ranges in every host/process (compromising security).

The most obvious candidate app categories are data analytics and data lakes.
Both make heavy use of "zero-copy" data frames - column oriented data that
is laid out for efficient use via (MAP_SHARED) mmap. Moreover, these use case
categories are generally driven by python code that wrangles data into
appropriate data frames - making it straightforward to put the data frames
into famfs. Furthermore, these use cases usually involve the shared data being
read-only during computation or query jobs - meaning they are often free of
cache coherency concerns.

Workloads such as these often deal with data sets that are too large to fit
in a single server's memory, so the data gets sharded - requiring movement via
a network. Sharded apps also sometimes have to do expensive reshuffling -
moving data to nodes with available compute resources. Avoiding the sharding
overheads by accessing such data sets in disaggregated shared memory looks
promising to make make better use of memory and compute resources, and by
effectively de-duplicating data sets in memory.

About sharable memory

* Shared memory is pmem-like, in that hosts will connect in order to access
  pre-existing contents
* Onlining sharable memory as system-ram is nonsense; system-ram gets zeroed...
* CXL 3 provides for optionally-supported hardware-managed cache coherency
* But "multiple-readers, no writers" use cases don't need hardware support
  for coherency
* CXL 3.1 dynamic capacity devices (DCDs) should be thought of as devices with
  an allocator built in.
* When sharable capacity is allocated, each host that has access will see a
  /dev/dax device that can be found by the "tag" of the allocation. The tag is
  just a uuid.
* CXL 3.1 also allows the capacity associated with any allocated tag to be
  provided to each host (or host group) as either writable or read-only.

About famfs

Famfs is an append-only log-structured file system that places many limits
on what can be done. This allows famfs to tolerate clients with a stale copy
of metadata. All memory allocation and log maintenance is performed from user
space, but file extent lists are cached in the kernel for fast fault
resolution. The current limitations are fairly extreme, but many can be relaxed
by writing more code, managing Byzantine generals, etc. ;)

A famfs-enabled kernel can be cloned at [3], and the user space repo can be
cloned at [4]. Even with major functional limitations in its current form
(e.g. famfs does not currently support deleting files), it is sufficient to
use in data analytics workloads - in which you 1) create a famfs file system,
2) dump data sets into it, 3) run clustered jobs that consume the shared data
sets, and 4) dismount and deallocate the memory containing the file system.

Famfs Open Issues

* Volatile CXL memory is exposed as character dax devices; the famfs patch
  set adds the iomap API, which is required for fs-dax but until now missing
  from character dax.
* (/dev/pmem devices are block, and support the iomap api for fs-dax file
  systems)
* /dev/pmem devices can be converted to /dev/dax mode, but native /dev/dax
  devices cannot be converted to pmem mode.
* /dev/dax devices lack the iomap api that fs-dax uses with pmem, so the famfs
  patch set adds that.
* VFS layer hooks for a file system on a character device may be needed.
* Famfs has uncovered some previously latent bugs in the /dev/dax mmap
  machinery that probably require attention.
* Famfs currently works with either pmem or devdax devices, but our
  inclination is to drop pmem support to, reduce the complexity of supporting
  two different underlying device types - particularly since famfs is not
  intended for actual pmem.


Required :-
Dan Williams
Christian Brauner
Jonathan Cameron
Dave Hansen

[LSF/MM + BPF ATTEND]

I am the author of the famfs file system. Famfs was first introduced at LPC
2023 [2]. I'm also Micron's voting member on the Software and Systems Working
Group (SSWG) of the CXL Consortium, and a co-author of the CXL 3.1
specification.


References

[1] https://lore.kernel.org/linux-fsdevel/cover.1708709155.git.john@groves.net/#t
[2] https://lpc.events/event/17/contributions/1455/
[3] https://www.computeexpresslink.org/download-the-specification
[4] https://github.com/cxl-micron-reskit/famfs-linux

Best regards,
John Groves
Micron

