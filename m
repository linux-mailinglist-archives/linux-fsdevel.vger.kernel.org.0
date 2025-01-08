Return-Path: <linux-fsdevel+bounces-38654-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC75A05B18
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2025 13:11:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FF8B1888CFE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2025 12:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B3341F9ED0;
	Wed,  8 Jan 2025 12:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="a3mhkps8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5621A239D;
	Wed,  8 Jan 2025 12:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736338266; cv=none; b=MD8cz5Y9q2uMuEGJagpgSGMybObo+OFbfGVKsk/o+DHvtABL2Qs4GwvhEdSMDyYQmR+Yrik9qn0YPKjV3Bs/UnEErc9OMGCq+3W65eY0YAWVslsv7D7u3Y0jMZnOKSBIVSc//Q/PIuSLtEz8IAAoBo0mBIKZaIDa8dWzwpHNbbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736338266; c=relaxed/simple;
	bh=7fQl+Yh3RdMoR0mL1q+xGHkoBDu0HvZUXFhPUzJcEQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WoheITA5vmuBBuli/7im5vzG1IV1FqjIaUZXNH1wew15vM7oYNI5Z3FXtcF31b+IV2m5ybecOr/7Uv9z60ibTQQudWjcewTzFuSatkH63O7dlB0GaP3xEaWPjjIrJmVNt7SRSPQdYHmkgkYoJobkoH+meoEmLifq6DSj2ZbBta4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=a3mhkps8; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50886DsG022826;
	Wed, 8 Jan 2025 12:10:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=r51rzpkQRIaDuYN5m2napHEaWvqxm7
	bLsc8aVa3GJ6A=; b=a3mhkps8NcJSJ7brUUW2LjGlaaiDXS/SeW445rQPrcg//4
	mzRgfxNjB73jcFwlhy/pOTaQFup5wPf7FLeguOvtiJkmbQ73kUDtGy6mvS/l20l2
	SpAONktG0AljeG72A/bwh3DvxqdsqbgZiE4Ds7kLFO3DZ1cXHPsKjzp72zIQbB/b
	p5t1VjXN4CvGCmKdiDRQDyFYFMkl3rXt1zUfrb23gadfFF7fp2PLC7Um50t3t9Ik
	StEyZHIIri2/+Cuw808QTealaF+fIfjuOhKMw6Jvl6SC9yqBhqG5cK0FAl4VY8fu
	mKqOcZ+hGNDNFvysudC2kNFZ9JTwj4wyAohtCPXg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 441nj393bf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jan 2025 12:10:50 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 508BoOkW013439;
	Wed, 8 Jan 2025 12:10:50 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 441nj393bd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jan 2025 12:10:50 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5089cDI0015805;
	Wed, 8 Jan 2025 12:10:49 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43ygtkygy0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jan 2025 12:10:49 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 508CAjgN49873158
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 8 Jan 2025 12:10:45 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3E2882004B;
	Wed,  8 Jan 2025 12:10:45 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DAEEA20043;
	Wed,  8 Jan 2025 12:10:44 +0000 (GMT)
Received: from osiris (unknown [9.152.212.60])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed,  8 Jan 2025 12:10:44 +0000 (GMT)
Date: Wed, 8 Jan 2025 13:10:43 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-s390@vger.kernel.org,
        virtualization@lists.linux.dev, kvm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, kexec@lists.infradead.org,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
        Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>, Thomas Huth <thuth@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 00/12] fs/proc/vmcore: kdump support for virtio-mem on
 s390
Message-ID: <20250108121043.7704-I-hca@linux.ibm.com>
References: <20241204125444.1734652-1-david@redhat.com>
 <20250108070407-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250108070407-mutt-send-email-mst@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: rwRjGyiOCqOBLv_v9BGL6q74O-HSoqwn
X-Proofpoint-GUID: PmVcktqpx1H2mp0ezMbm_qIXZXexrl8-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 clxscore=1011 adultscore=0 impostorscore=0 mlxlogscore=699 phishscore=0
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501080098

On Wed, Jan 08, 2025 at 07:04:23AM -0500, Michael S. Tsirkin wrote:
> On Wed, Dec 04, 2024 at 01:54:31PM +0100, David Hildenbrand wrote:
> > The only "different than everything else" thing about virtio-mem on s390
> > is kdump: The crash (2nd) kernel allocates+prepares the elfcore hdr
> > during fs_init()->vmcore_init()->elfcorehdr_alloc(). Consequently, the
> > kdump kernel must detect memory ranges of the crashed kernel to
> > include via PT_LOAD in the vmcore.
> > 
> > On other architectures, all RAM regions (boot + hotplugged) can easily be
> > observed on the old (to crash) kernel (e.g., using /proc/iomem) to create
> > the elfcore hdr.
> > 
> > On s390, information about "ordinary" memory (heh, "storage") can be
> > obtained by querying the hypervisor/ultravisor via SCLP/diag260, and
> > that information is stored early during boot in the "physmem" memblock
> > data structure.
> > 
> > But virtio-mem memory is always detected by as device driver, which is
> > usually build as a module. So in the crash kernel, this memory can only be
> > properly detected once the virtio-mem driver started up.
> > 
> > The virtio-mem driver already supports the "kdump mode", where it won't
> > hotplug any memory but instead queries the device to implement the
> > pfn_is_ram() callback, to avoid reading unplugged memory holes when reading
> > the vmcore.
> > 
> > With this series, if the virtio-mem driver is included in the kdump
> > initrd -- which dracut already takes care of under Fedora/RHEL -- it will
> > now detect the device RAM ranges on s390 once it probes the devices, to add
> > them to the vmcore using the same callback mechanism we already have for
> > pfn_is_ram().
> > 
> > To add these device RAM ranges to the vmcore ("patch the vmcore"), we will
> > add new PT_LOAD entries that describe these memory ranges, and update
> > all offsets vmcore size so it is all consistent.
> > 
> > My testing when creating+analyzing crash dumps with hotplugged virtio-mem
> > memory (incl. holes) did not reveal any surprises.
> > 
> > Patch #1 -- #7 are vmcore preparations and cleanups
> > Patch #8 adds the infrastructure for drivers to report device RAM
> > Patch #9 + #10 are virtio-mem preparations
> > Patch #11 implements virtio-mem support to report device RAM
> > Patch #12 activates it for s390, implementing a new function to fill
> >           PT_LOAD entry for device RAM
> 
> Who is merging this?
> virtio parts:
> 
> Acked-by: Michael S. Tsirkin <mst@redhat.com>

I guess this series should go via Andrew Morton. Andrew?

Acked-by: Heiko Carstens <hca@linux.ibm.com> # s390

