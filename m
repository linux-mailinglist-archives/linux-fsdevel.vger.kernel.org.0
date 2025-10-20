Return-Path: <linux-fsdevel+bounces-64706-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D3E2BF1949
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 15:40:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 164A83A51AB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 13:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8645631986F;
	Mon, 20 Oct 2025 13:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Ptjzv4kB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6642D248F7F;
	Mon, 20 Oct 2025 13:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760967613; cv=none; b=eYCgZUZ8z86k58vGa1A3E/bhQqevCzdc9z2te8lB9lhEJ0K+TSkPF/YPgmNkjJ90WC1z2buQjLP7dHywh8zkODppW3bt2VuuNn6GHdm1TjwwCwy9zpd7ADFxl2qFiv69lG1GA9CTqKWlUJitMeexcAmkPj84l8+uCo8D+yLGNwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760967613; c=relaxed/simple;
	bh=jiKHpZ56cLeBkoRbxx48ENzMRCI9UX9Smhb7SclWucM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bw2u181mn8PL4IQrwSGGsrBwq4rg/C8W/1iZYC5A7eHDCe1a2Kr7mENquavYTfGAY54ONF+wc7HytOZv8j/I8UIJmUE6AuveK8UCzDEOsWXE1UIZRSoXTKERJ0tD3RBW6+6njTevNGR9hnp8fk9U+oEqYjEUEQM8N0BK0NEq/GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Ptjzv4kB; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59KCRbo4023459;
	Mon, 20 Oct 2025 13:39:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=ViQ89gOu19UDAiRynbx1fqy0JdIKiO
	kaAlpGFEg0jmo=; b=Ptjzv4kBROTmkVPoTlFfTfmB/4UXjPZvHkVkOlxHn6JGaF
	n942llznxWdYPp3MjsYwnIwwcmkfvftLcKeiYvIOAGDY9eX/lZk7P1NAyXX3k+p2
	vQXts7umot2B8zY367jh/chah1eUCv7e6VHYajk8l2skYinBvfuOiESk/S8QyEd7
	9HI5stj26Psb5zmVPKAJr/zM5BMClWM9lRnxbtQVQVxRAQKv0qec4Ap64fk56vCU
	JBrAPOCWLf+9fhpyiyr79baK5Sfts8ijh4b/sAJDz9XwDScfwVr2zFu2Gd1Ci8PO
	8dpWqQUM2ldPeQw/7da2l3r7Wkl829htX/Zf7J5w==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v31rsqg6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Oct 2025 13:39:15 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59KDSrHp023351;
	Mon, 20 Oct 2025 13:39:14 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v31rsqg3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Oct 2025 13:39:14 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59KC35wv002281;
	Mon, 20 Oct 2025 13:39:13 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 49vqej5p7v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Oct 2025 13:39:12 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59KDd98t29557158
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Oct 2025 13:39:09 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1465F20040;
	Mon, 20 Oct 2025 13:39:09 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0AE432004B;
	Mon, 20 Oct 2025 13:39:07 +0000 (GMT)
Received: from li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com (unknown [9.111.85.12])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 20 Oct 2025 13:39:06 +0000 (GMT)
Date: Mon, 20 Oct 2025 15:39:05 +0200
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
Subject: Re: [PATCH v5 12/15] mm/hugetlbfs: update hugetlbfs to use
 mmap_prepare
Message-ID: <aPY7eQec0bB9847x@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
References: <cover.1760959441.git.lorenzo.stoakes@oracle.com>
 <b1afa16d3cfa585a03df9ae215ae9f905b3f0ed7.1760959442.git.lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1afa16d3cfa585a03df9ae215ae9f905b3f0ed7.1760959442.git.lorenzo.stoakes@oracle.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ZSoy0DnAVX45duhi1_mDLkuJQ3da5vFy
X-Proofpoint-GUID: 2FFr9MxsKTbmfu7DnP8tGWY4DhBVRDkg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfXy3CVS9OyeYuF
 3+tWa5wjvP+gkbv9wIuR2qBo2tCYgmgyTdm2zAqfL8UFStMulHvbtnTG5sqtSbNbGC7YvcprEqv
 0d6/694Ay5/WaywfyIa71bzqVpJ+YelsfaR6Fgo2F6IMpwfoqzJiZIDNnA7xw0K40cEjnFnUiYM
 oDKF5qlhz607Hjx7bxgydKT4VgnEhOta0jia3+WHEGk61414+0Z9tjdEL7VpIj44M5+o7Y1fW82
 OVInIKfzXUDHTrkjx3GSeH/Sqxwna+Wi9hKxe9JcxyPadb1pe+SyjdPgcUFpynbyWFiFEpi45GP
 4FvlBMRbqmC01KgzuyyJ/fw2hjq8Pgqs/7uGjoyGcoquemDY7UnpDzBM6gZj/b+AHFmqBo6ZfMD
 TihvVeJSVrOZw0tNC7yiCSCnr0sABw==
X-Authority-Analysis: v=2.4 cv=IJYPywvG c=1 sm=1 tr=0 ts=68f63b83 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=Ikd4Dj_1AAAA:8 a=VnNF1IyMAAAA:8 a=7mAFR29It3qcuHcA-EIA:9
 a=CjuIK1q_8ugA:10 a=UhEZJTgQB8St2RibIkdl:22 a=Z5ABNNGmrOfJ6cZ5bIyy:22
 a=QOGEsqRv6VhmHaoFNykA:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0 spamscore=0
 bulkscore=0 adultscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022

On Mon, Oct 20, 2025 at 01:11:29PM +0100, Lorenzo Stoakes wrote:
> Since we can now perform actions after the VMA is established via
> mmap_prepare, use desc->action_success_hook to set up the hugetlb lock
> once the VMA is setup.
> 
> We also make changes throughout hugetlbfs to make this possible.
> 
> Note that we must hide newly established hugetlb VMAs from the rmap until
> the operation is entirely complete as we establish a hugetlb lock during
> VMA setup that can be raced by rmap users.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Hi Lorenzo,

Tested this patch with libhugetlbfs tests. No locking issues anymore.

Tested-by: Sumanth Korikkar <sumanthk@linux.ibm.com>

Thank you

