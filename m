Return-Path: <linux-fsdevel+bounces-51579-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D7B5AD8833
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 11:44:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 910483B1BA6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 09:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED08B2C158D;
	Fri, 13 Jun 2025 09:44:02 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mta22.hihonor.com (mta22.honor.com [81.70.192.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A897D238C06;
	Fri, 13 Jun 2025 09:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.192.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749807842; cv=none; b=AnxrIl0I3JQI1Ao0Sr+JKY4V5S9xarxVYQX0WTNUJZIDYFMVDOnk3PHZo6RsyaSdRBqCEsBR1IA5CY5xl0JjFM6JfH26ZSivqM5FHSko0t+a2mBSMAzuiudnqeGDqmZQ66e5mlDg3GbvYz24wZl85YtKsEhrC8xOuIJOeRpFVpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749807842; c=relaxed/simple;
	bh=5qTng8w94cZ0pqhP00XAbIUVrscsHqDDRFScVMngN6c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tZ4j/CKxIr8JTtq3xs49G1mXRONCRSUvOya8zPe5efvnDENQo335VqytTsWr5oiz/N4Uysux5WRBxwGQicPspgBRu+qQHccvJNy1I5tp9TqvyZ6OgrnVj9Jl8pw09c+0Dk9SgQwrNvlkWgR94sRZMbkfRlHhx4CEXFE0QR9lBVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; arc=none smtp.client-ip=81.70.192.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
Received: from w011.hihonor.com (unknown [10.68.20.122])
	by mta22.hihonor.com (SkyGuard) with ESMTPS id 4bJZCT3tmzzYm7yk;
	Fri, 13 Jun 2025 17:41:09 +0800 (CST)
Received: from a018.hihonor.com (10.68.17.250) by w011.hihonor.com
 (10.68.20.122) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 13 Jun
 2025 17:43:09 +0800
Received: from a010.hihonor.com (10.68.16.52) by a018.hihonor.com
 (10.68.17.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 13 Jun
 2025 17:43:09 +0800
Received: from a010.hihonor.com ([fe80::7127:3946:32c7:6e]) by
 a010.hihonor.com ([fe80::7127:3946:32c7:6e%14]) with mapi id 15.02.1544.011;
 Fri, 13 Jun 2025 17:43:08 +0800
From: wangtao <tao.wangtao@honor.com>
To: Christoph Hellwig <hch@infradead.org>, =?iso-8859-1?Q?Christian_K=F6nig?=
	<christian.koenig@amd.com>
CC: "sumit.semwal@linaro.org" <sumit.semwal@linaro.org>, "kraxel@redhat.com"
	<kraxel@redhat.com>, "vivek.kasireddy@intel.com" <vivek.kasireddy@intel.com>,
	"viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "brauner@kernel.org"
	<brauner@kernel.org>, "hughd@google.com" <hughd@google.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "amir73il@gmail.com"
	<amir73il@gmail.com>, "benjamin.gaignard@collabora.com"
	<benjamin.gaignard@collabora.com>, "Brian.Starkey@arm.com"
	<Brian.Starkey@arm.com>, "jstultz@google.com" <jstultz@google.com>,
	"tjmercier@google.com" <tjmercier@google.com>, "jack@suse.cz" <jack@suse.cz>,
	"baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>,
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "wangbintian(BintianWang)"
	<bintian.wang@honor.com>, yipengxiang <yipengxiang@honor.com>, liulu 00013167
	<liulu.liu@honor.com>, hanfeng 00012985 <feng.han@honor.com>
Subject: RE: [PATCH v4 0/4] Implement dmabuf direct I/O via copy_file_range
Thread-Topic: [PATCH v4 0/4] Implement dmabuf direct I/O via copy_file_range
Thread-Index: AQHb1G1ol+FT389RFkuW+lwB3adoKrPw4BKAgAADywCAAAF8AIAE6kCg//+rigCABEW6AIAA1IFwgAEnIgCAAC4PgIAE+w3w
Date: Fri, 13 Jun 2025 09:43:08 +0000
Message-ID: <80ce3ec9104c4f0abbcb589b03a5f3c7@honor.com>
References: <20250603095245.17478-1-tao.wangtao@honor.com>
 <aD7x_b0hVyvZDUsl@infradead.org>
 <09c8fb7c-a337-4813-9f44-3a538c4ee8b1@amd.com>
 <aD72alIxu718uri4@infradead.org> <5d36abace6bf492aadd847f0fabc38be@honor.com>
 <a766fbf4-6cda-43a5-a1c7-61a3838f93f9@amd.com>
 <aEZkjA1L-dP_Qt3U@infradead.org> <761986ec0f404856b6f21c3feca67012@honor.com>
 <d86a677b-e8a7-4611-9494-06907c661f05@amd.com>
 <aEg1BZj-HzbgWKsx@infradead.org>
In-Reply-To: <aEg1BZj-HzbgWKsx@infradead.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0



> On Tue, Jun 10, 2025 at 12:52:18PM +0200, Christian K=F6nig wrote:
> > >> dma_addr_t/len array now that the new DMA API supporting that has
> > >> been merged.  Is there any chance the dma-buf maintainers could
> > >> start to kick this off?  I'm of course happy to assist.
> >
> > Work on that is already underway for some time.
> >
> > Most GPU drivers already do sg_table -> DMA array conversion, I need
> > to push on the remaining to clean up.
>=20
> Do you have a pointer?
>=20
> > >> Yes, that's really puzzling and should be addressed first.
> > > With high CPU performance (e.g., 3GHz), GUP (get_user_pages)
> > > overhead is relatively low (observed in 3GHz tests).
> >
> > Even on a low end CPU walking the page tables and grabbing references
> > shouldn't be that much of an overhead.
>=20
> Yes.
>=20
> >
> > There must be some reason why you see so much CPU overhead. E.g.
> > compound pages are broken up or similar which should not happen in the
> > first place.
>=20
> pin_user_pages outputs an array of PAGE_SIZE (modulo offset and shorter
> last length) array strut pages unfortunately.  The block direct I/O code =
has
> grown code to reassemble folios from them fairly recently which did speed
> up some workloads.
>=20
> Is this test using the block device or iomap direct I/O code?  What kerne=
l
> version is it run on?
Here's my analysis on Linux 6.6 with F2FS/iomap.

Comparing udmabuf+memfd direct read vs dmabuf direct c_f_r:
Systrace: On a high-end 3 GHz CPU, the former occupies >80% runtime vs
<20% for the latter. On a low-end 1 GHz CPU, the former becomes CPU-bound.
Perf: For the former, bio_iov_iter_get_pages/get_user_pages dominate
latency. The latter avoids this via lightweight bvec assignments.
|- 13.03% __arm64_sys_read
|-|- 13.03% f2fs_file_read_iter
|-|-|- 13.03% __iomap_dio_rw
|-|-|-|- 12.95% iomap_dio_bio_iter
|-|-|-|-|- 10.69% bio_iov_iter_get_pages
|-|-|-|-|-|- 10.53% iov_iter_extract_pages
|-|-|-|-|-|-|- 10.53% pin_user_pages_fast
|-|-|-|-|-|-|-|- 10.53% internal_get_user_pages_fast
|-|-|-|-|-|-|-|-|- 10.23% __gup_longterm_locked
|-|-|-|-|-|-|-|-|-|- 8.85% __get_user_pages
|-|-|-|-|-|-|-|-|-|-|- 6.26% handle_mm_fault
|-|-|-|-|- 1.91% iomap_dio_submit_bio
|-|-|-|-|-|- 1.64% submit_bio

|- 1.13% __arm64_sys_copy_file_range
|-|- 1.13% vfs_copy_file_range
|-|-|- 1.13% dma_buf_copy_file_range
|-|-|-|- 1.13% system_heap_dma_buf_rw_file
|-|-|-|-|- 1.13% f2fs_file_read_iter
|-|-|-|-|-|- 1.13% __iomap_dio_rw
|-|-|-|-|-|-|- 1.13% iomap_dio_bio_iter
|-|-|-|-|-|-|-|- 1.13% iomap_dio_submit_bio
|-|-|-|-|-|-|-|-|- 1.08% submit_bio

Large folios can reduce GUP overhead but still significantly slower
than dmabuf to bio_vec conversion.

Regards,
Wangtao.


