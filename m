Return-Path: <linux-fsdevel+bounces-62506-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D614BB95BF7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Sep 2025 13:53:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C92A84E1CDD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Sep 2025 11:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E174322C77;
	Tue, 23 Sep 2025 11:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EFGvr8Qy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5782E8881;
	Tue, 23 Sep 2025 11:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758628385; cv=none; b=LXmK+HXY0ZgEN75GkRox8EDGaxy5MA65bmIE/5LxDFwRwpm14qSxsa2xGSdhmVkzAu/0t6eHAsUn9TU1H1zu4PrOcND+orEf/9Tct380YV/G/8YT37bXpLzk+pyvLbbbLSeWcbLFRqx/6xbJgKWSPObu/2rc01372dtaa2qhZIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758628385; c=relaxed/simple;
	bh=uC3KukjZxErvZyqVNyTZvCwwhubZja1S6u22ZrF2EwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KDydQcy4398DaaLTE1shEEXK83C0oajYGMlHMFs3CZ+a04Ol9wrH0XUM7nUV8hMrvloQZ2Re1L8oyP91B9KzL0suQ4EzyEEi08jdSz3h560befX6/B9VWbG8Imphi+SXlRQ+9qwNfDwqAzx4HPjm658pqAcanFcVxB7P0hqf2DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EFGvr8Qy; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58N8Y12b008695;
	Tue, 23 Sep 2025 11:52:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=FZaoT1QNSR93wIPtHts3CPzp0ctIk0
	vYDNbzffEOi0c=; b=EFGvr8QyltIf32/aszOR/qJfepgW+UcWXreJDplTglupit
	m+X7rmX3tdEzuL1hJj2o5XWwJ0r+pCJ4BjGEMOhGvQ5uA7F1CUxQtR7TqdF163bV
	I3YXhbagNN2r+8NAvqFEHYkOG72rBgt1rm+ek1A/MwpmvyPZqT+huO4x+iKBFWTR
	eo6ih9hfsFn2nHia9aCP+YLY6UeADcGZp/ivckC/FFUA6i0IL4LnbBeJbqc6eiAl
	5jWsuCjMMTLD7wV7h8suNXD082oB3YYd9QtgvibDoicaRjRsG3bClbPAwbAw7H1U
	VId+vHnlTcxFpVyEmlJvEr0+HDviZMbBrXxprVQA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 499n0jgm9c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Sep 2025 11:52:19 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58NBn9Dd005820;
	Tue, 23 Sep 2025 11:52:18 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 499n0jgm96-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Sep 2025 11:52:18 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58N9Tk1U019675;
	Tue, 23 Sep 2025 11:52:17 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49a83k31qr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Sep 2025 11:52:17 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58NBqDIE43516160
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Sep 2025 11:52:13 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F401A20043;
	Tue, 23 Sep 2025 11:52:12 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A61F420040;
	Tue, 23 Sep 2025 11:52:10 +0000 (GMT)
Received: from li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com (unknown [9.87.150.243])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 23 Sep 2025 11:52:10 +0000 (GMT)
Date: Tue, 23 Sep 2025 13:52:09 +0200
From: Sumanth Korikkar <sumanthk@linux.ibm.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, Matthew Wilcox <willy@infradead.org>,
        Guo Ren <guoren@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, Nicolas Pitre <nico@fluxnic.net>,
        Muchun Song <muchun.song@linux.dev>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>, Tony Luck <tony.luck@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Dave Martin <Dave.Martin@arm.com>, James Morse <james.morse@arm.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Hugh Dickins <hughd@google.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org, linux-mm@kvack.org,
        ntfs3@lists.linux.dev, kexec@lists.infradead.org,
        kasan-dev@googlegroups.com, Jason Gunthorpe <jgg@nvidia.com>,
        iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v4 11/14] mm/hugetlbfs: update hugetlbfs to use
 mmap_prepare
Message-ID: <aNKJ6b7kmT_u0A4c@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
References: <cover.1758135681.git.lorenzo.stoakes@oracle.com>
 <e5532a0aff1991a1b5435dcb358b7d35abc80f3b.1758135681.git.lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5532a0aff1991a1b5435dcb358b7d35abc80f3b.1758135681.git.lorenzo.stoakes@oracle.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAzMyBTYWx0ZWRfX1/CT4ehdu5F7
 6VnJC5JZb/TGq0GTxXqzwutGBpnh5zvXhqXxihnE0ZIBeLxavZe5A1rzKbuxO1bDNyuFhUEM+Rk
 4I1KMXyeBzNEU/g4Tedu1h1rULa5Sn/p0/UqkELdAnxrKDhWjf96WssSMg0ltTS+aMBZqn2U8bf
 Mm6V030K3rfmUmm6+2tKL/Lil9yhk2vaa1ilZs3936p1XOaPfvsu3tSuBabaOBW+S4p6UJCCS7o
 UssKxq/W9pewKawoXgWRMXrenvRD0Q+OeFvs8GRRauXhjlsHet/L1r4+QnnsJQ0kVijCVo4qQhY
 p/3nafFZQN3AWkhiFthvrI3hfInHVuTDSlQN3xLdzE/r0zMDPQuTX7WW9M8m8X+BWNkt+j6HOZU
 bcmWMt/c
X-Authority-Analysis: v=2.4 cv=TOlFS0la c=1 sm=1 tr=0 ts=68d289f3 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=yJojWOMRYYMA:10 a=NEAV23lmAAAA:8 a=yPCof4ZbAAAA:8
 a=Ikd4Dj_1AAAA:8 a=P7Dlay8f7KcL8MNlhToA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: F6nP2Q8ol4BSxLNz15joz3bImrmTREZ1
X-Proofpoint-GUID: 5HR21TLQQZuGh5ctB-qo8M6ErsQDpoDW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-23_02,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 priorityscore=1501 phishscore=0 impostorscore=0 adultscore=0
 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509200033

On Wed, Sep 17, 2025 at 08:11:13PM +0100, Lorenzo Stoakes wrote:
> Since we can now perform actions after the VMA is established via
> mmap_prepare, use desc->action_success_hook to set up the hugetlb lock
> once the VMA is setup.
> 
> We also make changes throughout hugetlbfs to make this possible.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  fs/hugetlbfs/inode.c           | 36 ++++++++++------
>  include/linux/hugetlb.h        |  9 +++-
>  include/linux/hugetlb_inline.h | 15 ++++---
>  mm/hugetlb.c                   | 77 ++++++++++++++++++++--------------
>  4 files changed, 85 insertions(+), 52 deletions(-)
> 
> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> index f42548ee9083..9e0625167517 100644
> --- a/fs/hugetlbfs/inode.c
> +++ b/fs/hugetlbfs/inode.c
> @@ -96,8 +96,15 @@ static const struct fs_parameter_spec hugetlb_fs_parameters[] = {
>  #define PGOFF_LOFFT_MAX \
>  	(((1UL << (PAGE_SHIFT + 1)) - 1) <<  (BITS_PER_LONG - (PAGE_SHIFT + 1)))
>  
> -static int hugetlbfs_file_mmap(struct file *file, struct vm_area_struct *vma)
> +static int hugetlb_file_mmap_prepare_success(const struct vm_area_struct *vma)
>  {
> +	/* Unfortunate we have to reassign vma->vm_private_data. */
> +	return hugetlb_vma_lock_alloc((struct vm_area_struct *)vma);
> +}

Hi Lorenzo,

The following tests causes the kernel to enter a blocked state,
suggesting an issue related to locking order. I was able to reproduce
this behavior in certain test runs.

Test case:
git clone https://github.com/libhugetlbfs/libhugetlbfs.git
cd libhugetlbfs ; ./configure
make -j32
cd tests
echo 100 > /proc/sys/vm/nr_hugepages
mkdir -p /test-hugepages && mount -t hugetlbfs nodev /test-hugepages
./run_tests.py <in a loop>
...
shm-fork 10 100 (1024K: 64):    PASS
set shmmax limit to 104857600
shm-getraw 100 /dev/full (1024K: 32):
shm-getraw 100 /dev/full (1024K: 64):   PASS
fallocate_stress.sh (1024K: 64):  <blocked>

Blocked task state below:

task:fallocate_stres state:D stack:0     pid:5106  tgid:5106  ppid:5103
task_flags:0x400000 flags:0x00000001
Call Trace:
 [<00000255adc646f0>] __schedule+0x370/0x7f0
 [<00000255adc64bb0>] schedule+0x40/0xc0
 [<00000255adc64d32>] schedule_preempt_disabled+0x22/0x30
 [<00000255adc68492>] rwsem_down_write_slowpath+0x232/0x610
 [<00000255adc68922>] down_write_killable+0x52/0x80
 [<00000255ad12c980>] vm_mmap_pgoff+0xc0/0x1f0
 [<00000255ad164bbe>] ksys_mmap_pgoff+0x17e/0x220
 [<00000255ad164d3c>] __s390x_sys_old_mmap+0x7c/0xa0
 [<00000255adc60e4e>] __do_syscall+0x12e/0x350
 [<00000255adc6cfee>] system_call+0x6e/0x90
task:fallocate_stres state:D stack:0     pid:5109  tgid:5106  ppid:5103
task_flags:0x400040 flags:0x00000001
Call Trace:
 [<00000255adc646f0>] __schedule+0x370/0x7f0
 [<00000255adc64bb0>] schedule+0x40/0xc0
 [<00000255adc64d32>] schedule_preempt_disabled+0x22/0x30
 [<00000255adc68492>] rwsem_down_write_slowpath+0x232/0x610
 [<00000255adc688be>] down_write+0x4e/0x60
 [<00000255ad1c11ec>] __hugetlb_zap_begin+0x3c/0x70
 [<00000255ad158b9c>] unmap_vmas+0x10c/0x1a0
 [<00000255ad180844>] vms_complete_munmap_vmas+0x134/0x2e0
 [<00000255ad1811be>] do_vmi_align_munmap+0x13e/0x170
 [<00000255ad1812ae>] do_vmi_munmap+0xbe/0x140
 [<00000255ad183f86>] __vm_munmap+0xe6/0x190
 [<00000255ad166832>] __s390x_sys_munmap+0x32/0x40
 [<00000255adc60e4e>] __do_syscall+0x12e/0x350
 [<00000255adc6cfee>] system_call+0x6e/0x90


Thanks,
Sumanth

