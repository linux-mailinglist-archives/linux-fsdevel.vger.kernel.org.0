Return-Path: <linux-fsdevel+bounces-5055-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0957B807B6A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 23:37:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A672C1F21172
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 22:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21A924B140
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 22:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jagalactic.com header.i=@jagalactic.com header.b="f9/W7Jcr";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="V1rD3Zwx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from a11-4.smtp-out.amazonses.com (a11-4.smtp-out.amazonses.com [54.240.11.4])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DED75D5F;
	Wed,  6 Dec 2023 13:02:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=rjayupzefgi7e6fmzxcxe4cv4arrjs35; d=jagalactic.com; t=1701896579;
	h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:Content-Transfer-Encoding:References:Message-Id;
	bh=+9I3ssw05QPbGD2vToTePjOyEAM+Xe9Zko7u06tK2yE=;
	b=f9/W7JcrR3cFrLt6udhD74cwrVj4ciy1WGoPmtyHvEa5heG+eMiD3catYYuZ9oep
	56tzi12nl8AkDK3KGXnv/t4iAPbJCK+1Qd2/MG4vPPrb0V6q+Mnx+PvsnZ4S/ylyY3n
	j8Wgnj7QgXDIX8I3s4fYg4WNOk3ebaG5uWLPEQwI=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=224i4yxa5dv7c2xz3womw6peuasteono; d=amazonses.com; t=1701896579;
	h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:Content-Transfer-Encoding:References:Message-Id:Feedback-ID;
	bh=+9I3ssw05QPbGD2vToTePjOyEAM+Xe9Zko7u06tK2yE=;
	b=V1rD3ZwxYZoGSUBn0hC7+MbX838HmsYWTXA2HzTIi4YseeP2yp3c5e5vSeDVtTIY
	T8dCpeDiymCSMz3kOmNsTPovyx1ENYbOsJ5R14/MQ7Rxmp2+sX69CkdSDGqR8mcAKH6
	5Rlfk0q3rQnBQU3wtU7bblvMPx0UsYXrR9lsbNI8=
Subject: [PATCH RFC 0/4] dev_dax_iomap: introduce iomap for /dev/dax
From: =?UTF-8?Q?John_Groves?= <john@jagalactic.com>
To: =?UTF-8?Q?Dan_Williams?= <dan.j.williams@intel.com>, 
	=?UTF-8?Q?John_Groves?= <jgroves@micron.com>, 
	=?UTF-8?Q?John_Groves?= <john@jagalactic.com>
Cc: =?UTF-8?Q?Vishal_Verma?= <vishal.l.verma@intel.com>, 
	=?UTF-8?Q?Dave_Jiang?= <dave.jiang@intel.com>, 
	=?UTF-8?Q?nvdimm=40lists=2E?= =?UTF-8?Q?linux=2Edev?= <nvdimm@lists.linux.dev>, 
	=?UTF-8?Q?linux-cxl=40v?= =?UTF-8?Q?ger=2Ekernel=2Eorg?= <linux-cxl@vger.kernel.org>, 
	=?UTF-8?Q?linux-kernel=40vger=2Ekernel=2Eorg?= <linux-kernel@vger.kernel.org>, 
	=?UTF-8?Q?linux-fsdevel=40vger=2Ekernel=2Eorg?= <linux-fsdevel@vger.kernel.org>, 
	=?UTF-8?Q?John_Groves?= <john@groves.net>
Date: Wed, 6 Dec 2023 21:02:58 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <20231206210252.52107-1-john@jagalactic.com>
X-Mailer: Amazon WorkMail
Thread-Index: AQHaKIeW9Nsmb4x1TnOasHllAnJBRA==
Thread-Topic: [PATCH RFC 0/4] dev_dax_iomap: introduce iomap for /dev/dax
X-Wm-Sent-Timestamp: 1701896577
X-Original-Mailer: git-send-email 2.39.3 (Apple Git-145)
Message-ID: <0100018c40f0e6d8-e9683548-4dde-4320-8ff3-3fd4103c7274-000000@email.amazonses.com>
Feedback-ID: 1.us-east-1.LF00NED762KFuBsfzrtoqw+Brn/qlF9OYdxWukAhsl8=:AmazonSES
X-SES-Outgoing: 2023.12.06-54.240.11.4

From: John Groves <john@groves.net>

This patch set is not intended to be merged; I'm hoping to get some
clarification as to the correct approach (especialy from Dan). 

This work is related to famfs, which is a dax file system for shared
fabric-attached memory (FAM). Famfs is "coming soon" as an RFC, but
the concept and requirements were presented at LPC 2023. See
https://lpc.events/event/17/contributions/1455/ and
https://www.youtube.com/watch?v=aA_DgO95gLo. My expectation is that
a future (fully working) version of this patch will be folded into the
famfs
patches.

Unlike the current set of fs-dax file systems, famfs does not need a block
(pmem) device, and should really run on a /dev/dax character device since
that's how sharable fabric-attached cxl memory will surface. But
/dev/dax character devices are missing some functionality that is provided
by the block /dev/pmem driver - specifically struct dax_operations pointer
in struct dax_device.

This patch, when CONFIG_DEV_DAX_IOMAP=y, populates dax_dev->ops for
character dax devices. The added operations differ (currently) from
/dev/pmem's dev_dax->ops in that they don't use memremap but instead
provide a physical address in response to the dev_dax->direct_access()
method. 

The dax_operations are direct_access() (which resolves a dax dev offset
to an address), zero_page_range() and recovery_write(). I'm not sure yet
how to test the latter two, but the direct_access() method works in
conjunciton with famfs - but only for mmaped files.

But Posix reads fail. Specifically dax_iomap_iter() calls
dax_copy_to_iter(), which declines to copy the data for some reason in
one of the lower level copy_to_user variants. I've tried to isolate the
reason for the failure with a VM under gdb, but no luck there yet. I'm
wondering if there is some flag or attribute that needs to be applied to
these addresses/pages somehow to allow this to work.

The failing copy_to_user() differs from the same path with pmem fs-dax,
in that pmem does a memremap (which I think generates one contiguous
range, even if the device had more than one range - is this right, and
does this mean it's consuming some of the vmap/vmalloc range?)

I spent some time attempting a memremap, but I haven't figured out the
magic for that. However, I like the simplicity of resolving to phys if
that's not a non-starter for some reason.

I hope this is enough context for a meaningful review and suggestions as to
what a working dev_dax->dax_operations implementation should look like.

Thanks for any tips!


John Groves (4):
  Add add_dax_ops() func for fs-dax to provide dax holder_ops
  Temporary hacks due to linkage issues
  Add dax_operations to /dev/dax struct dax_device
  Add CONFIG_DEV_DAX_IOMAP kernel build parameter

 drivers/dax/Kconfig |   6 ++
 drivers/dax/bus.c   | 155 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/dax/super.c |  16 +++++
 include/linux/dax.h |   5 ++
 4 files changed, 182 insertions(+)

-- 
2.40.1


