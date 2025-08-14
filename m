Return-Path: <linux-fsdevel+bounces-57861-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAC20B26031
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 11:08:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98C4E3BC04C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 09:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EBEF2F60C0;
	Thu, 14 Aug 2025 08:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aJiP6LHg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638B02E9EB3;
	Thu, 14 Aug 2025 08:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755161916; cv=none; b=eXmLNSv9j54qXFoJVCj1oPJ2WhxGMm4LjAUXL/xH8ZyGVu1m5hu1CeSOOhhi+F8fyZmPvg2DfmlweB/WlFv65okbYRSdWSBkGsDWMMrt4BhC70p9UrAoFEYfW13zYYOw9rkutR1mTGhByTg1ag1cPy3126rGIwt18FukF8FI4oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755161916; c=relaxed/simple;
	bh=vDE0E1yjqY0f3HYkpoHZtIgg9O221SAmsRn5vbMsxL8=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mv3ZltAwDvwiVf3CwQEGiU15ZXsAv46drUsH2nEw5ISukY1BNecEuCY59OIfv750bXeT8VHKHChrdApho1nns1tYV7Se4Re/etLg+1K7kglwKMnC8NsehqrwnnU6jSCCj0GUQn3y3tlvupwH/aA21IdkX+bbwTqvCKpeRZwSYSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aJiP6LHg; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57DLLlpK015987;
	Thu, 14 Aug 2025 08:58:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=lcCq/XnqkIW2A53JNZQeehAP0zinHF
	hevLkE5cHGNns=; b=aJiP6LHgGSuJ9h8GDC6c6NGZfUBv/48XTnYZ8GV3qDgEsD
	Z077rWzqH810j4Bz2oZYRmWLOx5lUqbBXQNloLCwmfWA10hdiO/L67t0KEqYpFpN
	vPx0V3l72xWNs+6hWRMbVKuozPgVK6JYBMQeGKIZOEQnrv7VyeXHU8+wznTNzjBR
	Rrmz5WAIjR1CFh9mlPnwFASgpi/WxdACkhgU3v0PCcSPx8iWQgHZ8wStPFVwSXsN
	zGyOI4rClzGqIkcd6ix857DtBv+LY0hAjoF5qFh7Cz1JdcsqNpgF8+bav+fnCTlf
	JYOryBwOsjKqL0YoQ3D8MttwJl7G6uPLeWQtyXuQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48dvrp8vyv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Aug 2025 08:58:26 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57E6JJFd017637;
	Thu, 14 Aug 2025 08:58:23 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 48ekc3u366-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Aug 2025 08:58:22 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57E8wLMv32702992
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Aug 2025 08:58:21 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4F04B2004E;
	Thu, 14 Aug 2025 08:58:21 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2BA9320040;
	Thu, 14 Aug 2025 08:58:19 +0000 (GMT)
Received: from li-e7e2bd4c-2dae-11b2-a85c-bfd29497117c.ibm.com (unknown [9.124.218.79])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 14 Aug 2025 08:58:18 +0000 (GMT)
Date: Thu, 14 Aug 2025 14:28:16 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: Alex Mastro <amastro@fb.com>, Alex Williamson <alex.williamson@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, Jason Gunthorpe <jgg@ziepe.ca>,
        Keith Busch <kbusch@kernel.org>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        kvm@vger.kernel.org
Subject: Re: [PATCH v4] vfio/pci: print vfio-device syspath to fdinfo
Message-ID: <20250814141153.8294c6d3-83-amachhiw@linux.ibm.com>
Mail-Followup-To: Alex Mastro <amastro@fb.com>, 
	Alex Williamson <alex.williamson@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Keith Busch <kbusch@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, kvm@vger.kernel.org
References: <20250804-show-fdinfo-v4-1-96b14c5691b3@fb.com>
 <20250807144938.e0abc7bb-a4-amachhiw@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250807144938.e0abc7bb-a4-amachhiw@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDIxOSBTYWx0ZWRfX+7pGaXeFCS82
 iUug+sfuqRUNtHWdb6JNLVlR3LpZ8+kmqKnfWFhvXm9HbjJrRLJhBVwTrh7V98qRBXNxBsXqRId
 y8Hxj/mv3h9DeXDJ5iejH2DiQ2K4MMXqYiDkFZjTABYzS60CRQrQraz/SNfsDLXEuET1MPtuy9L
 fUx2CJYwVirs8Vxg325FM2jzx710QXwrYWJ7e4mR29wqU4ZqNwOg8Qd4UOq2MGtGjcEDlb9ETxx
 g29D/5ujVVN0NLO1LT2TetJ8+ltiUnk3MvhlbjWIW8WZbiWw7PKxjZEhX5saHxy5ybSVEhWmpK+
 7a1iIieYyRvq/PjQyw9OSHcEBoZg3KsOnxMp+jQHlU2L8Ed00ZvusRGgslYzG891bS9Lq2EQTsp
 4qDCEEbI
X-Authority-Analysis: v=2.4 cv=GrpC+l1C c=1 sm=1 tr=0 ts=689da532 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=FOH2dFAWAAAA:8
 a=VnNF1IyMAAAA:8 a=znEx-w3LAaTq8doKefoA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: YD4Sb_c9EQrVEZ1hJvtDxWT_0T1C4fmf
X-Proofpoint-ORIG-GUID: YD4Sb_c9EQrVEZ1hJvtDxWT_0T1C4fmf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_02,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 spamscore=0 impostorscore=0 suspectscore=0
 phishscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508120219

On 2025/08/07 03:04 PM, Amit Machhiwal wrote:
> Hello,
> 
> On 2025/08/04 12:44 PM, Alex Mastro wrote:
> > Print the PCI device syspath to a vfio device's fdinfo. This enables tools
> > to query which device is associated with a given vfio device fd.
> > 
> > This results in output like below:
> > 
> > $ cat /proc/"$SOME_PID"/fdinfo/"$VFIO_FD" | grep vfio
> > vfio-device-syspath: /sys/devices/pci0000:e0/0000:e0:01.1/0000:e1:00.0/0000:e2:05.0/0000:e8:00.0
> > 
> > Signed-off-by: Alex Mastro <amastro@fb.com>
> 
> I tested this patch on a POWER9 bare metal system with a VFIO PCI device and
> could see the VFIO device syspath in fdinfo.
> 
>  Without this patch:
>  -------------------
> 
>     [root@localhost ~]# cat /proc/7059/fdinfo/188
>     pos:    0
>     flags:  02000002
>     mnt_id: 17
>     ino:    1113
> 
>  With this patch:
>  ----------------
>     [root@localhost ~]# cat /proc/7722/fdinfo/188
>     pos:    0
>     flags:  02000002
>     mnt_id: 17
>     ino:    2145
>     vfio-device-syspath: /sys/devices/pci0031:00/0031:00:00.0/0031:01:00.0
> 
> ..., and the code changes LGTM. Hence,

Additionally, I got a chance to test this patch on a pSeries POWER10 logical
partition (L1) running a KVM guest (L2) with a PCI device passthrough and I see
the expected results:

  [root@guest ~]# lscpu
  Architecture:             ppc64le
    Byte Order:             Little Endian
  CPU(s):                   20
    On-line CPU(s) list:    0-19
  Model name:               POWER10 (architected), altivec supported
    Model:                  2.0 (pvr 0080 0200)
  [...]

  [root@guest ~]# lspci
  [...]
  0001:00:01.0 Non-Volatile memory controller: Samsung Electronics Co Ltd NVMe SSD Controller PM9A1/PM9A3/980PRO

  root@host:~ # cat /proc/2116/fdinfo/68
  pos:    0
  flags:  02000002
  mnt_id: 17
  ino:    160
  vfio-device-syspath: /sys/devices/pci0182:70/0182:70:00.0

The L1 was booted with latest upstream kernel (HEAD: 53e760d89498) with the
patch applied and the L2 was booted on distro QEMU (version 10.0.2) and as well
as on latest upstream QEMU (HEAD: 5836af078321, version 10.0.93).

Thanks,
Amit

> 
> Reviewed-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> Tested-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> 
> Thanks,
> Amit
> 
> > ---
> > Changes in v4:
> > - Remove changes to vfio.h
> > - Link to v3: https://lore.kernel.org/r/20250801-show-fdinfo-v3-1-165dfcab89b9@fb.com
> > Changes in v3:
> > - Remove changes to vfio_pci.c
> > - Add section to Documentation/filesystems/proc.rst
> > - Link to v2: https://lore.kernel.org/all/20250724-show-fdinfo-v2-1-2952115edc10@fb.com
> > Changes in v2:
> > - Instead of PCI bdf, print the fully-qualified syspath (prefixed by
> >   /sys) to fdinfo.
> > - Rename the field to "vfio-device-syspath". The term "syspath" was
> >   chosen for consistency e.g. libudev's usage of the term.
> > - Link to v1: https://lore.kernel.org/r/20250623-vfio-fdinfo-v1-1-c9cec65a2922@fb.com
> > ---
> >  Documentation/filesystems/proc.rst | 14 ++++++++++++++
> >  drivers/vfio/vfio_main.c           | 20 ++++++++++++++++++++
> >  2 files changed, 34 insertions(+)
> > 
> > diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
> > index 2a17865dfe39..fc5ed3117834 100644
> > --- a/Documentation/filesystems/proc.rst
> > +++ b/Documentation/filesystems/proc.rst
> > @@ -2162,6 +2162,20 @@ DMA Buffer files
> >  where 'size' is the size of the DMA buffer in bytes. 'count' is the file count of
> >  the DMA buffer file. 'exp_name' is the name of the DMA buffer exporter.
> >  
> > +VFIO Device files
> > +~~~~~~~~~~~~~~~~
> > +
> > +::
> > +
> > +	pos:    0
> > +	flags:  02000002
> > +	mnt_id: 17
> > +	ino:    5122
> > +	vfio-device-syspath: /sys/devices/pci0000:e0/0000:e0:01.1/0000:e1:00.0/0000:e2:05.0/0000:e8:00.0
> > +
> > +where 'vfio-device-syspath' is the sysfs path corresponding to the VFIO device
> > +file.
> > +
> >  3.9	/proc/<pid>/map_files - Information about memory mapped files
> >  ---------------------------------------------------------------------
> >  This directory contains symbolic links which represent memory mapped files
> > diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
> > index 1fd261efc582..37a39cee10ed 100644
> > --- a/drivers/vfio/vfio_main.c
> > +++ b/drivers/vfio/vfio_main.c
> > @@ -28,6 +28,7 @@
> >  #include <linux/pseudo_fs.h>
> >  #include <linux/rwsem.h>
> >  #include <linux/sched.h>
> > +#include <linux/seq_file.h>
> >  #include <linux/slab.h>
> >  #include <linux/stat.h>
> >  #include <linux/string.h>
> > @@ -1354,6 +1355,22 @@ static int vfio_device_fops_mmap(struct file *filep, struct vm_area_struct *vma)
> >  	return device->ops->mmap(device, vma);
> >  }
> >  
> > +#ifdef CONFIG_PROC_FS
> > +static void vfio_device_show_fdinfo(struct seq_file *m, struct file *filep)
> > +{
> > +	char *path;
> > +	struct vfio_device_file *df = filep->private_data;
> > +	struct vfio_device *device = df->device;
> > +
> > +	path = kobject_get_path(&device->dev->kobj, GFP_KERNEL);
> > +	if (!path)
> > +		return;
> > +
> > +	seq_printf(m, "vfio-device-syspath: /sys%s\n", path);
> > +	kfree(path);
> > +}
> > +#endif
> > +
> >  const struct file_operations vfio_device_fops = {
> >  	.owner		= THIS_MODULE,
> >  	.open		= vfio_device_fops_cdev_open,
> > @@ -1363,6 +1380,9 @@ const struct file_operations vfio_device_fops = {
> >  	.unlocked_ioctl	= vfio_device_fops_unl_ioctl,
> >  	.compat_ioctl	= compat_ptr_ioctl,
> >  	.mmap		= vfio_device_fops_mmap,
> > +#ifdef CONFIG_PROC_FS
> > +	.show_fdinfo	= vfio_device_show_fdinfo,
> > +#endif
> >  };
> >  
> >  static struct vfio_device *vfio_device_from_file(struct file *file)
> > 
> > ---
> > base-commit: 4518e5a60c7fbf0cdff393c2681db39d77b4f87e
> > change-id: 20250801-show-fdinfo-ef109ca738cf
> > 
> > Best regards,
> > -- 
> > Alex Mastro <amastro@fb.com>
> > 

