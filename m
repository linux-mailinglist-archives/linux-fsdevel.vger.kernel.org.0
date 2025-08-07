Return-Path: <linux-fsdevel+bounces-56966-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2123EB1D4E9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Aug 2025 11:36:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0438C18A1D9D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Aug 2025 09:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62DAC264F96;
	Thu,  7 Aug 2025 09:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RDsRrwpr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA94624DD00;
	Thu,  7 Aug 2025 09:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754559286; cv=none; b=AaHXuc46kBsopyF+AMiJN9v3dY03W+OH2nQFfiCcB2UyLvj2dYGA+eGv7jWRlq+qIFJb0sJKZTT4ckyXESjnufonkUstLRgG6IEFjERTHAIFJhBdhEoVcKvzBi4ifNJwpjJaSHoz8NZ7sk9/TNAHBm63qcNYJU6KTToo/qqOiaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754559286; c=relaxed/simple;
	bh=bi5/cUDmfgbhIMHd6ZTDNPs0NPoSsPI20ih8TFJpEfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fJLQz1A3QvaLwDQ8zH/ZtMRPL9WM6NDR+x1I1DiYpCp3HRfMWmUa2LfdtP1+cNMhrvfPxqyUqzuxeEFnWjX1aGOWBBFwdDHOe90UeySplaWNK0cd4omz3sA84+5trRX1N2ILNPIPu8LdM/zJB+4+asiM/g4cj8GUAXBMh+GbXa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RDsRrwpr; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5772hmde017964;
	Thu, 7 Aug 2025 09:34:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=6vWCBn2ea2AJ8hlZ7l2i2oo4f/pnID
	rmDJGP0OfWrxg=; b=RDsRrwprbMwU5R7G0NJ4yvG0oFV5lXhM8LLYysN9NxNqDY
	IOiUDqEAfmXwXcZkuN5P9+7tioqcLRqNu6NJrPhueqYfUFDz4CdzWKHX/m81M+3h
	5d6TyKiKe3eoVsLWRcwX1QYle99ayN40vV4hdxKpK5iA0cIenHOa9i7qEa+HDjVZ
	XMVk6MDi1be5/5IuBuG83XzltFC9AMJG/IrCaHO/SY3E4LI7HIn0K4jE+kzRtCqg
	Yl/G26IzF4RKM/KfA+aVM/LJrQFitEyv5WExGuAsMxEFqK9VpYnCXWi3ygP0iIvA
	04hsHo+eSnHMkv7OtFxb0JxmlpHB1xkuRSGiZ/AA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48bq6396h2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Aug 2025 09:34:36 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5779UOoT007961;
	Thu, 7 Aug 2025 09:34:36 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 48bpwmyx1u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Aug 2025 09:34:36 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5779YYxX33947992
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 7 Aug 2025 09:34:34 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3E95220043;
	Thu,  7 Aug 2025 09:34:34 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1853C2004B;
	Thu,  7 Aug 2025 09:34:32 +0000 (GMT)
Received: from li-e7e2bd4c-2dae-11b2-a85c-bfd29497117c.ibm.com (unknown [9.39.27.140])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu,  7 Aug 2025 09:34:31 +0000 (GMT)
Date: Thu, 7 Aug 2025 15:04:29 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: Alex Mastro <amastro@fb.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, Jason Gunthorpe <jgg@ziepe.ca>,
        Keith Busch <kbusch@kernel.org>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        kvm@vger.kernel.org
Subject: Re: [PATCH v4] vfio/pci: print vfio-device syspath to fdinfo
Message-ID: <20250807144938.e0abc7bb-a4-amachhiw@linux.ibm.com>
Mail-Followup-To: Alex Mastro <amastro@fb.com>, 
	Alex Williamson <alex.williamson@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Keith Busch <kbusch@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, kvm@vger.kernel.org
References: <20250804-show-fdinfo-v4-1-96b14c5691b3@fb.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250804-show-fdinfo-v4-1-96b14c5691b3@fb.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA3MDA3MyBTYWx0ZWRfXyzA19daRx9Jv
 +S0nugzECf8LjRgaWq9Uidy+7lXie11jZxPN50pOzFw+DF12e6gEkqmRecrnhnV224ZxELfB8Yj
 G5S+VNlm8+hXRRRhqZlRsju1bQZfgE/PFbK8yDw0afmQ1DAB4VFt8Oy7jLyxLVnEpcE7E0fQhi5
 gF49kT7r/LFgq/VIgFqgjpgzaXMuLOKhcbKFRSBCwAK43Y0CpBwaSnyLRDIOIdfwXcsgIpZoCZS
 9S5Wqrat766/Y1nbEsCpk5YkQAv3YHbUd+WZaGrhVvt2DMATNYaRkU8ZGCnLocGOXCfrZpzkw1r
 QGpGI0lCX+PQXqzRb3PkCDNq4RrCB2dBb8FF60evsJevO9mHhnNAkm2aVhMm61Z59ouqgWu3Y9g
 cWcQGxEkHkA+IXQl/gn92M2TG7Iqc3NroY/kVMyHBAFHY+7IRMSOzTfTm3WCTg0RcuiCvKuk
X-Proofpoint-GUID: CvV8F5CmtDJe8LqRhlB-dMTow_wL2oOA
X-Authority-Analysis: v=2.4 cv=PoCTbxM3 c=1 sm=1 tr=0 ts=6894732d cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=FOH2dFAWAAAA:8
 a=VnNF1IyMAAAA:8 a=kvThyvOQPCVtOW654kcA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: CvV8F5CmtDJe8LqRhlB-dMTow_wL2oOA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-07_01,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_spam_definite policy=outbound
 score=100 suspectscore=0 malwarescore=0 adultscore=0 clxscore=1011
 bulkscore=0 priorityscore=1501 impostorscore=0 mlxlogscore=-999 mlxscore=100
 phishscore=0 lowpriorityscore=0 spamscore=100 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508070073

Hello,

On 2025/08/04 12:44 PM, Alex Mastro wrote:
> Print the PCI device syspath to a vfio device's fdinfo. This enables tools
> to query which device is associated with a given vfio device fd.
> 
> This results in output like below:
> 
> $ cat /proc/"$SOME_PID"/fdinfo/"$VFIO_FD" | grep vfio
> vfio-device-syspath: /sys/devices/pci0000:e0/0000:e0:01.1/0000:e1:00.0/0000:e2:05.0/0000:e8:00.0
> 
> Signed-off-by: Alex Mastro <amastro@fb.com>

I tested this patch on a POWER9 bare metal system with a VFIO PCI device and
could see the VFIO device syspath in fdinfo.

 Without this patch:
 -------------------

    [root@localhost ~]# cat /proc/7059/fdinfo/188
    pos:    0
    flags:  02000002
    mnt_id: 17
    ino:    1113

 With this patch:
 ----------------
    [root@localhost ~]# cat /proc/7722/fdinfo/188
    pos:    0
    flags:  02000002
    mnt_id: 17
    ino:    2145
    vfio-device-syspath: /sys/devices/pci0031:00/0031:00:00.0/0031:01:00.0

..., and the code changes LGTM. Hence,

Reviewed-by: Amit Machhiwal <amachhiw@linux.ibm.com>
Tested-by: Amit Machhiwal <amachhiw@linux.ibm.com>

Thanks,
Amit

> ---
> Changes in v4:
> - Remove changes to vfio.h
> - Link to v3: https://lore.kernel.org/r/20250801-show-fdinfo-v3-1-165dfcab89b9@fb.com
> Changes in v3:
> - Remove changes to vfio_pci.c
> - Add section to Documentation/filesystems/proc.rst
> - Link to v2: https://lore.kernel.org/all/20250724-show-fdinfo-v2-1-2952115edc10@fb.com
> Changes in v2:
> - Instead of PCI bdf, print the fully-qualified syspath (prefixed by
>   /sys) to fdinfo.
> - Rename the field to "vfio-device-syspath". The term "syspath" was
>   chosen for consistency e.g. libudev's usage of the term.
> - Link to v1: https://lore.kernel.org/r/20250623-vfio-fdinfo-v1-1-c9cec65a2922@fb.com
> ---
>  Documentation/filesystems/proc.rst | 14 ++++++++++++++
>  drivers/vfio/vfio_main.c           | 20 ++++++++++++++++++++
>  2 files changed, 34 insertions(+)
> 
> diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
> index 2a17865dfe39..fc5ed3117834 100644
> --- a/Documentation/filesystems/proc.rst
> +++ b/Documentation/filesystems/proc.rst
> @@ -2162,6 +2162,20 @@ DMA Buffer files
>  where 'size' is the size of the DMA buffer in bytes. 'count' is the file count of
>  the DMA buffer file. 'exp_name' is the name of the DMA buffer exporter.
>  
> +VFIO Device files
> +~~~~~~~~~~~~~~~~
> +
> +::
> +
> +	pos:    0
> +	flags:  02000002
> +	mnt_id: 17
> +	ino:    5122
> +	vfio-device-syspath: /sys/devices/pci0000:e0/0000:e0:01.1/0000:e1:00.0/0000:e2:05.0/0000:e8:00.0
> +
> +where 'vfio-device-syspath' is the sysfs path corresponding to the VFIO device
> +file.
> +
>  3.9	/proc/<pid>/map_files - Information about memory mapped files
>  ---------------------------------------------------------------------
>  This directory contains symbolic links which represent memory mapped files
> diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
> index 1fd261efc582..37a39cee10ed 100644
> --- a/drivers/vfio/vfio_main.c
> +++ b/drivers/vfio/vfio_main.c
> @@ -28,6 +28,7 @@
>  #include <linux/pseudo_fs.h>
>  #include <linux/rwsem.h>
>  #include <linux/sched.h>
> +#include <linux/seq_file.h>
>  #include <linux/slab.h>
>  #include <linux/stat.h>
>  #include <linux/string.h>
> @@ -1354,6 +1355,22 @@ static int vfio_device_fops_mmap(struct file *filep, struct vm_area_struct *vma)
>  	return device->ops->mmap(device, vma);
>  }
>  
> +#ifdef CONFIG_PROC_FS
> +static void vfio_device_show_fdinfo(struct seq_file *m, struct file *filep)
> +{
> +	char *path;
> +	struct vfio_device_file *df = filep->private_data;
> +	struct vfio_device *device = df->device;
> +
> +	path = kobject_get_path(&device->dev->kobj, GFP_KERNEL);
> +	if (!path)
> +		return;
> +
> +	seq_printf(m, "vfio-device-syspath: /sys%s\n", path);
> +	kfree(path);
> +}
> +#endif
> +
>  const struct file_operations vfio_device_fops = {
>  	.owner		= THIS_MODULE,
>  	.open		= vfio_device_fops_cdev_open,
> @@ -1363,6 +1380,9 @@ const struct file_operations vfio_device_fops = {
>  	.unlocked_ioctl	= vfio_device_fops_unl_ioctl,
>  	.compat_ioctl	= compat_ptr_ioctl,
>  	.mmap		= vfio_device_fops_mmap,
> +#ifdef CONFIG_PROC_FS
> +	.show_fdinfo	= vfio_device_show_fdinfo,
> +#endif
>  };
>  
>  static struct vfio_device *vfio_device_from_file(struct file *file)
> 
> ---
> base-commit: 4518e5a60c7fbf0cdff393c2681db39d77b4f87e
> change-id: 20250801-show-fdinfo-ef109ca738cf
> 
> Best regards,
> -- 
> Alex Mastro <amastro@fb.com>
> 

