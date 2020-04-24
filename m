Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 639931B7DBB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Apr 2020 20:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728903AbgDXSTP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Apr 2020 14:19:15 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35801 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727123AbgDXSTN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Apr 2020 14:19:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587752351;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zBlEEl/4DE3AueNz8EcPFW+nerY+eN9VDgbsYvuIwAk=;
        b=W4NpuWC/qtPem98Y7DBRzVPQChRSnsLSimaPALbvOZlhmnq6USddT5MEAI6rnFxxSw5KIy
        y2FB9EheNGdtzPQ1PokMeC1QJTiqNndIPJ0d1oHB8yVQVE2Oz02ooEob2snGrKaQzk+YqA
        ZgFvBAC9cV2iyp51fLm+l66Ye5XFSUo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-358-wM_L9XSxPy-Wam3e3x_hbA-1; Fri, 24 Apr 2020 14:18:57 -0400
X-MC-Unique: wM_L9XSxPy-Wam3e3x_hbA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 676B48015D1;
        Fri, 24 Apr 2020 18:18:50 +0000 (UTC)
Received: from w520.home (ovpn-112-162.phx2.redhat.com [10.3.112.162])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 73F46619DC;
        Fri, 24 Apr 2020 18:18:47 +0000 (UTC)
Date:   Fri, 24 Apr 2020 12:18:46 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     John Hubbard <jhubbard@nvidia.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Michal Hocko <mhocko@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Shuah Khan <shuah@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        <linux-doc@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        <linux-mm@kvack.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [regression] Re: [PATCH v6 06/12] mm/gup: track FOLL_PIN pages
Message-ID: <20200424121846.5ee2685f@w520.home>
In-Reply-To: <20200211001536.1027652-7-jhubbard@nvidia.com>
References: <20200211001536.1027652-1-jhubbard@nvidia.com>
        <20200211001536.1027652-7-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/aRIlGjxB14=fzhStE9AJEEB"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--MP_/aRIlGjxB14=fzhStE9AJEEB
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Mon, 10 Feb 2020 16:15:30 -0800
John Hubbard <jhubbard@nvidia.com> wrote:

> Add tracking of pages that were pinned via FOLL_PIN. This tracking is
> implemented via overloading of page->_refcount: pins are added by
> adding GUP_PIN_COUNTING_BIAS (1024) to the refcount. This provides a
> fuzzy indication of pinning, and it can have false positives (and that's
> OK). Please see the pre-existing
> Documentation/core-api/pin_user_pages.rst for details.
>=20
> As mentioned in pin_user_pages.rst, callers who effectively set FOLL_PIN
> (typically via pin_user_pages*()) are required to ultimately free such
> pages via unpin_user_page().
>=20
> Please also note the limitation, discussed in pin_user_pages.rst under
> the "TODO: for 1GB and larger huge pages" section. (That limitation will
> be removed in a following patch.)
>=20
> The effect of a FOLL_PIN flag is similar to that of FOLL_GET, and may be
> thought of as "FOLL_GET for DIO and/or RDMA use".
>=20
> Pages that have been pinned via FOLL_PIN are identifiable via a
> new function call:
>=20
>    bool page_maybe_dma_pinned(struct page *page);
>=20
> What to do in response to encountering such a page, is left to later
> patchsets. There is discussion about this in [1], [2], [3], and [4].
>=20
> This also changes a BUG_ON(), to a WARN_ON(), in follow_page_mask().
>=20
> [1] Some slow progress on get_user_pages() (Apr 2, 2019):
>     https://lwn.net/Articles/784574/
> [2] DMA and get_user_pages() (LPC: Dec 12, 2018):
>     https://lwn.net/Articles/774411/
> [3] The trouble with get_user_pages() (Apr 30, 2018):
>     https://lwn.net/Articles/753027/
> [4] LWN kernel index: get_user_pages():
>     https://lwn.net/Kernel/Index/#Memory_management-get_user_pages
>=20
> Reviewed-by: Jan Kara <jack@suse.cz>
> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Suggested-by: Jan Kara <jack@suse.cz>
> Suggested-by: J=C3=A9r=C3=B4me Glisse <jglisse@redhat.com>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
>  Documentation/core-api/pin_user_pages.rst |   6 +-
>  include/linux/mm.h                        |  82 +++++--
>  mm/gup.c                                  | 254 +++++++++++++++++-----
>  mm/huge_memory.c                          |  29 ++-
>  mm/hugetlb.c                              |  54 +++--
>  5 files changed, 334 insertions(+), 91 deletions(-)

Hi John,

I'm seeing a regression bisected back to this commit (3faa52c03f44
mm/gup: track FOLL_PIN pages).  I've attached some vfio-pci test code
that reproduces this by mmap'ing a page of MMIO space of a device and
then tries to map that through the IOMMU, so this should be attempting
a gup/pin of a PFNMAP page.  Previously this failed gracefully (-EFAULT),
but now results in:

BUG: unable to handle page fault for address: ffffae5cbfe5e938
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 0 P4D 0=20
Oops: 0000 [#1] SMP NOPTI
CPU: 18 PID: 3365 Comm: vfio-pci-dma-ma Tainted: G           OE     5.6.0+ =
#6
Hardware name: AMD Corporation Diesel/Diesel, BIOS TDL100CB 03/17/2020
RIP: 0010:get_pfnblock_flags_mask+0x22/0x70
Code: c3 0f 1f 80 00 00 00 00 0f 1f 44 00 00 48 8b 05 bc e1 d9 01 48 89 f7 =
49 89 c8 48 c1 ef 0f 48 85 c0 74 48 48 89 f1 48 c1 e9 17 <48> 8b 04 c8 48 8=
5 c0 74 0b 40 0f b6 ff 48 c1 e7 04 48 01 f8 48 c1
RSP: 0018:ffffb55289b3fcc8 EFLAGS: 00010216
RAX: ffff9e5cbff50000 RBX: 0000000000000001 RCX: 000001fffffe1d27
RDX: 0000000000000002 RSI: ffffff0e93acd633 RDI: 0001fffffe1d2759
RBP: ffffb55289b3fd88 R08: 0000000000000007 R09: ffff9e48a52476a8
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000001
R13: 0000000000000000 R14: 0000000000000001 R15: ffff9e48ab358cc0
FS:  00007f4ef7269740(0000) GS:ffff9e48afa80000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffae5cbfe5e938 CR3: 0000000c61eda000 CR4: 00000000003406e0
Call Trace:
 __gup_longterm_locked+0x274/0x620
 vaddr_get_pfn+0x74/0x110 [vfio_iommu_type1]
 vfio_pin_pages_remote+0x6e/0x370 [vfio_iommu_type1]
 vfio_iommu_type1_ioctl+0x8e5/0xaac [vfio_iommu_type1]
 ksys_ioctl+0x86/0xc0
 __x64_sys_ioctl+0x16/0x20
 do_syscall_64+0x5b/0x1f0
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x7f4ef6d7d307
Code: 44 00 00 48 8b 05 69 1b 2d 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff =
ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff f=
f 73 01 c3 48 8b 0d 39 1b 2d 00 f7 d8 64 89 01 48
RSP: 002b:00007fff76ada738 EFLAGS: 00000213 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f4ef6d7d307
RDX: 00007fff76ada760 RSI: 0000000000003b71 RDI: 0000000000000003
RBP: 00007fff76ada930 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000213 R12: 0000000000400950
R13: 00007fff76adaa10 R14: 0000000000000000 R15: 0000000000000000
Modules linked in: vfio_pci(OE) vfio_virqfd(OE) vfio_iommu_type1(OE) vfio(O=
E) amd64_edac_mod edac_mce_amd kvm_amd kvm rfkill sunrpc ipmi_ssif vfat irq=
bypass fat ipmi_si crct10dif_pclmul crc32_pclmul sp5100_tco ghash_clmulni_i=
ntel ipmi_devintf pcspkr joydev ccp i2c_piix4 k10temp ipmi_msghandler pinct=
rl_amd acpi_cpufreq ip_tables nouveau ast video mxm_wmi drm_vram_helper wmi=
 drm_ttm_helper i2c_algo_bit drm_kms_helper cec ttm drm i40e e1000e crc32c_=
intel
CR2: ffffae5cbfe5e938
---[ end trace a384ab7cc8e37d46 ]---
RIP: 0010:get_pfnblock_flags_mask+0x22/0x70
Code: c3 0f 1f 80 00 00 00 00 0f 1f 44 00 00 48 8b 05 bc e1 d9 01 48 89 f7 =
49 89 c8 48 c1 ef 0f 48 85 c0 74 48 48 89 f1 48 c1 e9 17 <48> 8b 04 c8 48 8=
5 c0 74 0b 40 0f b6 ff 48 c1 e7 04 48 01 f8 48 c1
RSP: 0018:ffffb55289b3fcc8 EFLAGS: 00010216
RAX: ffff9e5cbff50000 RBX: 0000000000000001 RCX: 000001fffffe1d27
RDX: 0000000000000002 RSI: ffffff0e93acd633 RDI: 0001fffffe1d2759
RBP: ffffb55289b3fd88 R08: 0000000000000007 R09: ffff9e48a52476a8
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000001
R13: 0000000000000000 R14: 0000000000000001 R15: ffff9e48ab358cc0
FS:  00007f4ef7269740(0000) GS:ffff9e48afa80000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffae5cbfe5e938 CR3: 0000000c61eda000 CR4: 00000000003406e0

Thanks,
Alex

--MP_/aRIlGjxB14=fzhStE9AJEEB
Content-Type: text/x-c++src
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=vfio-pci-dma-map-mmio.c

#include <errno.h>
#include <libgen.h>
#include <fcntl.h>
#include <signal.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/eventfd.h>
#include <sys/ioctl.h>
#include <sys/mman.h>
#include <sys/stat.h>
#include <sys/time.h>
#include <sys/types.h>

#include <linux/ioctl.h>
#include <linux/vfio.h>
#include <linux/pci_regs.h>

void usage(char *name)
{
	fprintf(stderr, "usage: %s <ssss:bb:dd.f>\n", name);
	fprintf(stderr, "\tssss: PCI segment, ex. 0000\n");
	fprintf(stderr, "\tbb:   PCI bus, ex. 01\n");
	fprintf(stderr, "\tdd:   PCI device, ex. 06\n");
	fprintf(stderr, "\tf:    PCI function, ex. 0\n");
}

int main(int argc, char **argv)
{
	int seg, bus, slot, func;
	int ret, container, group, device, groupid;
	char path[50], iommu_group_path[50], *group_name;
	struct stat st;
	ssize_t len;
	void *map = MAP_FAILED;
	int i;
	unsigned int bar;
	struct vfio_group_status group_status = {
		.argsz = sizeof(group_status)
	};
	struct vfio_region_info region_info = {
		.argsz = sizeof(region_info)
	};
	struct vfio_region_info config_info = {
		.argsz = sizeof(config_info)
	};
	struct vfio_iommu_type1_dma_map dma_map = {
		.argsz = sizeof(dma_map),
		.flags = VFIO_DMA_MAP_FLAG_READ | VFIO_DMA_MAP_FLAG_WRITE,
	};

	if (argc != 2) {
		usage(argv[0]);
		return -1;
	}

	ret = sscanf(argv[1], "%04x:%02x:%02x.%d", &seg, &bus, &slot, &func);
	if (ret != 4) {
		fprintf(stderr, "Invalid device\n");
		usage(argv[0]);
		return -1;
	}

	/* Boilerplate vfio setup */
	container = open("/dev/vfio/vfio", O_RDWR);
	if (container < 0) {
		fprintf(stderr, "Failed to open /dev/vfio/vfio, %d (%s)\n",
		       container, strerror(errno));
		return container;
	}

	snprintf(path, sizeof(path),
		 "/sys/bus/pci/devices/%04x:%02x:%02x.%01x/",
		 seg, bus, slot, func);

	ret = stat(path, &st);
	if (ret < 0) {
		fprintf(stderr, "No such device\n");
		return ret;
	}

	strncat(path, "iommu_group", sizeof(path) - strlen(path) - 1);

	len = readlink(path, iommu_group_path, sizeof(iommu_group_path));
	if (len <= 0) {
		fprintf(stderr, "No iommu_group for device\n");
		return -1;
	}

	iommu_group_path[len] = 0;
	group_name = basename(iommu_group_path);

	if (sscanf(group_name, "%d", &groupid) != 1) {
		fprintf(stderr, "Unknown group\n");
		return -1;
	}

	snprintf(path, sizeof(path), "/dev/vfio/%d", groupid);
	group = open(path, O_RDWR);
	if (group < 0) {
		fprintf(stderr, "Failed to open %s, %d (%s)\n",
		       path, group, strerror(errno));
		return group;
	}

	ret = ioctl(group, VFIO_GROUP_GET_STATUS, &group_status);
	if (ret) {
		fprintf(stderr, "ioctl(VFIO_GROUP_GET_STATUS) failed\n");
		return ret;
	}

	if (!(group_status.flags & VFIO_GROUP_FLAGS_VIABLE)) {
		fprintf(stderr,
			"Group not viable, all devices attached to vfio?\n");
		return -1;
	}

	ret = ioctl(group, VFIO_GROUP_SET_CONTAINER, &container);
	if (ret) {
		fprintf(stderr, "Failed to set group container\n");
		return ret;
	}

	ret = ioctl(container, VFIO_SET_IOMMU, VFIO_TYPE1_IOMMU);
	if (ret) {
		fprintf(stderr, "Failed to set IOMMU\n");
		return ret;
	}

	snprintf(path, sizeof(path), "%04x:%02x:%02x.%d", seg, bus, slot, func);

	device = ioctl(group, VFIO_GROUP_GET_DEVICE_FD, path);
	if (device < 0) {
		fprintf(stderr, "Failed to get device\n");
		return -ENODEV;
	}

	config_info.index = VFIO_PCI_CONFIG_REGION_INDEX;
	ret = ioctl(device, VFIO_DEVICE_GET_REGION_INFO, &config_info);
	if (ret) {
		fprintf(stderr, "Failed to get config space region info\n");
		return ret;
	}

	for (i = 0; i < 6; i++) {
		if (pread(device, &bar, sizeof(bar),
		          config_info.offset + PCI_BASE_ADDRESS_0 + (4 * i)) !=
		    sizeof(bar)) {
			fprintf(stderr, "Error reading BAR%d\n", i);
			return -errno;
		}

		if (!(bar & PCI_BASE_ADDRESS_SPACE)) {
			break;

tryagain:
			if (bar & PCI_BASE_ADDRESS_MEM_TYPE_64)
				i++;
		}
	}

	if (i >= 6) {
		fprintf(stderr, "No memory BARs found\n");
		return -ENODEV;
	}

	region_info.index = VFIO_PCI_BAR0_REGION_INDEX + i;
	ret = ioctl(device, VFIO_DEVICE_GET_REGION_INFO, &region_info);
	if (ret) {
		fprintf(stderr, "Failed to get BAR%d region info\n", i);
		return ret;
	}
  
	if (!(region_info.flags & VFIO_REGION_INFO_FLAG_MMAP)) {
		printf("No mmap support, try next\n");
		goto tryagain;
	}

	if (region_info.size < getpagesize()) {
		printf("Too small for mmap, try next\n");
		goto tryagain;
	}

	map = mmap(NULL, getpagesize(), PROT_READ | PROT_WRITE,
		   MAP_SHARED, device, region_info.offset);
	if (map == MAP_FAILED) {
		fprintf(stderr, "Error mmap'ing BAR: %m\n");
		goto tryagain;
	}

	dma_map.size = getpagesize();
	dma_map.vaddr = (__u64)map;
	dma_map.iova = 1024 * 1024 * 1024; /* 1GB IOVA, arbitrary */

	ret = ioctl(container, VFIO_IOMMU_MAP_DMA, &dma_map);
	if (ret) {
		fprintf(stderr, "Failed to DMA map: %m\n");
		return ret;
	}
		
	printf("Passed\n");
	return 0;
}

--MP_/aRIlGjxB14=fzhStE9AJEEB--

