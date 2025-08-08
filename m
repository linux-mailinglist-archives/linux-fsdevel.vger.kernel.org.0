Return-Path: <linux-fsdevel+bounces-57109-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99FA2B1EC5B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 17:49:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45F547A54A0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 15:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC946285C96;
	Fri,  8 Aug 2025 15:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PkitBGE5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED0D51022;
	Fri,  8 Aug 2025 15:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754668181; cv=none; b=G80Eaheggf4qf+Qry2thLKx7oQyGWvCmFDI3A7XlhJSkNgxxk8bYN3BJXQElcEDCsFLA+C3uIT8sywLdajR7fqkK1OPnjV+l0QKpKGTOe0wSDgDrjcQRvlb7YrQB5ogxX2Ra1j4ksMIEwDVHMAkC735iEPDxbnYTvUEBTI+Ax28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754668181; c=relaxed/simple;
	bh=FKgDRBwvHKW+NItJ/C/tdcMYpqeLoJp+ybnYisRSw+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kAFaaPvFOccYyTVhhv3hu9BbgmGvhfg3oii+oUfL8Y2ilYs8Jh0pJgqloSqIrrOoF9PbM7Q4tveIcXrALFI/R1ghdOK4iYRwJgsXUA47l4mG3M7Xj1JrcGVGq8qq7ESGjlYc0d/0eMLz1vkgMJeb65pXqxSmrS3Kb3jTkYEn+Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PkitBGE5; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 578CaBd6019724;
	Fri, 8 Aug 2025 15:46:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=hVVTbx
	IG4t9rFlI1TQKC+Hxj/Mh9EeK0KpEbo6pNZKE=; b=PkitBGE5UXNDnmL0QwcOYI
	l7pq6FFVIwEjOrGiUDDH8bwROvbS26QXYuKWHhb/tZL+mmi3Xl+Ik/uvlBaVQp7k
	q//FpQH7qMHutGOFraeOVrkGAES92zaciN7zNiXepoCRqFhrhGklVzRBs8Zb63gm
	QRL3NCGQM2+8lzjS6Kjtzm4LQHErARlaz/+kk5MvZ48rxDRzZ1y6D2MEVbU24l+O
	u4NUTqgw8hMD99+ODFXM9mYvFbeNgarmZmWd9SfUJTRyHob/c65+xhhuxzCepTWa
	OcV1+CGqCOiyMumbnbL9wjccNo7jtEvq/zk0+X6oR8ltQTYo8y9g76SXBVjK6fAA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48c26u6mjn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Aug 2025 15:46:04 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 578Eiqlk001500;
	Fri, 8 Aug 2025 15:46:03 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 48bpwr682e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Aug 2025 15:46:03 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 578Fk2F852167082
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 8 Aug 2025 15:46:02 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E3BBA20043;
	Fri,  8 Aug 2025 15:46:01 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C169920040;
	Fri,  8 Aug 2025 15:45:59 +0000 (GMT)
Received: from li-e7e2bd4c-2dae-11b2-a85c-bfd29497117c.ibm.com (unknown [9.39.29.218])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  8 Aug 2025 15:45:59 +0000 (GMT)
Date: Fri, 8 Aug 2025 21:15:57 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>
Cc: Alex Mastro <amastro@fb.com>, Alex Williamson <alex.williamson@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, Jason Gunthorpe <jgg@ziepe.ca>,
        Keith Busch <kbusch@kernel.org>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        kvm@vger.kernel.org
Subject: Re: [PATCH v4] vfio/pci: print vfio-device syspath to fdinfo
Message-ID: <20250808205338.dc652e3e-61-amachhiw@linux.ibm.com>
Mail-Followup-To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>, 
	Alex Mastro <amastro@fb.com>, Alex Williamson <alex.williamson@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Jason Gunthorpe <jgg@ziepe.ca>, Keith Busch <kbusch@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, 
	kvm@vger.kernel.org
References: <20250804-show-fdinfo-v4-1-96b14c5691b3@fb.com>
 <20250807144938.e0abc7bb-a4-amachhiw@linux.ibm.com>
 <dd0b8e6f-1673-49c3-8018-974d1e7f1a54@kaod.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dd0b8e6f-1673-49c3-8018-974d1e7f1a54@kaod.org>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: NYBsndrIoJCnnEC55H9YQzVdDfMBbWza
X-Authority-Analysis: v=2.4 cv=F/xXdrhN c=1 sm=1 tr=0 ts=68961bbc cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=8nJEP1OIZ-IA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=FOH2dFAWAAAA:8
 a=VnNF1IyMAAAA:8 a=mChgkEYXGDxemXdaQwAA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
X-Proofpoint-GUID: NYBsndrIoJCnnEC55H9YQzVdDfMBbWza
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA4MDEyNSBTYWx0ZWRfX6YR5mM/2BZHW
 xa5GBzRRmaz/1XwO+tCFYA8iEOpwsrnCzPfGo+BBQVTxvr7Ui9aHUKEMk7WNu+gia3cGXDhi7kb
 QFx78WefC6e7rkHVQNqpyt8xbEDFy06exMaOeGdMzXaZwC+GAKfHATL+hK5iuJ3PRIwD213L9nG
 ekSBmbrui87dGzoU2NzNHb/nyZ3PsIH27y1abcBMiIfZv1NK7qSjLWY6YL1gr9OcfdY8wRscyyW
 ziToxgGUBMEhDdO6aLVgzIrQQ1r0l6TkwDHuG5rDtvWQWs64RJakKfUk9sMw7Pt2/SirIqXeVnV
 TeF982BvdBVsuFNgs3CF6mxYJy1pur1umDf1vpoBkfU+2B/y74OFITQw6y2UW4TwShayEYdMxPF
 Y1VXf6WJPx6Cb+1LAITPNwqA7wAcT4BoFHJmIvDC4ZO0M81OvE8igPtFW/DjOvUK6KXV7fUb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-08_05,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_spam_definite policy=outbound
 score=100 mlxscore=100 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 clxscore=1011 spamscore=100 bulkscore=0 adultscore=0 mlxlogscore=-999
 malwarescore=0 phishscore=0 suspectscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508080125

Hi Cédric,

Please find my comments inline:

On 2025/08/08 03:49 PM, Cédric Le Goater wrote:
> Hello Amit,
> 
> On 8/7/25 11:34, Amit Machhiwal wrote:
> > Hello,
> > 
> > On 2025/08/04 12:44 PM, Alex Mastro wrote:
> > > Print the PCI device syspath to a vfio device's fdinfo. This enables tools
> > > to query which device is associated with a given vfio device fd.
> > > 
> > > This results in output like below:
> > > 
> > > $ cat /proc/"$SOME_PID"/fdinfo/"$VFIO_FD" | grep vfio
> > > vfio-device-syspath: /sys/devices/pci0000:e0/0000:e0:01.1/0000:e1:00.0/0000:e2:05.0/0000:e8:00.0
> > > 
> > > Signed-off-by: Alex Mastro <amastro@fb.com>
> > 
> > I tested this patch on a POWER9 bare metal system with a VFIO PCI device and
> > could see the VFIO device syspath in fdinfo.
> 
> POWER9 running on OPAL FW : I am curious about the software stack.
> 
> I suppose this is the latest upstream kernel ?

Yes, I used the latest upstream kernel and applied this patch on top of commit
cca7a0aae895.

> Are you using an upstream QEMU to test too ?

No, I had used the Fedora 42 distro qemu. The version details are as below:

  [root@localhost ~]# qemu-system-ppc64 --version
  QEMU emulator version 9.2.4 (qemu-9.2.4-1.fc42)
  Copyright (c) 2003-2024 Fabrice Bellard and the QEMU Project developers

I gave the upstream qemu (HEAD pointing to cd21ee5b27) a try and I see the same
behavior with that too.

  [root@localhost ~]# ./qemu-system-ppc64 --version
  QEMU emulator version 10.0.92 (v10.1.0-rc2-4-gcd21ee5b27-dirty)
  Copyright (c) 2003-2025 Fabrice Bellard and the QEMU Project developers

  [root@localhost ~]# cat /proc/52807/fdinfo/191
  pos:    0
  flags:  02000002
  mnt_id: 17
  ino:    1125
  vfio-device-syspath: /sys/devices/pci0031:00/0031:00:00.0/0031:01:00.0

> 
> and which device ?

I'm using a Broadcom NetXtreme network card (4-port) and passing through its
fn0.

  [root@guest ~]# lspci
  [...]
  0001:00:01.0 Ethernet controller: Broadcom Inc. and subsidiaries NetXtreme BCM5719 Gigabit Ethernet PCIe (rev 01)

Please let me know if I may help you with any additional information.

Thanks,
Amit

> 
> Thanks,
> 
> C.
> 
> 
> 
> 
> > 
> >   Without this patch:
> >   -------------------
> > 
> >      [root@localhost ~]# cat /proc/7059/fdinfo/188
> >      pos:    0
> >      flags:  02000002
> >      mnt_id: 17
> >      ino:    1113
> > 
> >   With this patch:
> >   ----------------
> >      [root@localhost ~]# cat /proc/7722/fdinfo/188
> >      pos:    0
> >      flags:  02000002
> >      mnt_id: 17
> >      ino:    2145
> >      vfio-device-syspath: /sys/devices/pci0031:00/0031:00:00.0/0031:01:00.0
> > 
> > ..., and the code changes LGTM. Hence,
> > 
> > Reviewed-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> > Tested-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> > 
> > Thanks,
> > Amit
> > 
> > > ---
> > > Changes in v4:
> > > - Remove changes to vfio.h
> > > - Link to v3: https://lore.kernel.org/r/20250801-show-fdinfo-v3-1-165dfcab89b9@fb.com
> > > Changes in v3:
> > > - Remove changes to vfio_pci.c
> > > - Add section to Documentation/filesystems/proc.rst
> > > - Link to v2: https://lore.kernel.org/all/20250724-show-fdinfo-v2-1-2952115edc10@fb.com
> > > Changes in v2:
> > > - Instead of PCI bdf, print the fully-qualified syspath (prefixed by
> > >    /sys) to fdinfo.
> > > - Rename the field to "vfio-device-syspath". The term "syspath" was
> > >    chosen for consistency e.g. libudev's usage of the term.
> > > - Link to v1: https://lore.kernel.org/r/20250623-vfio-fdinfo-v1-1-c9cec65a2922@fb.com
> > > ---
> > >   Documentation/filesystems/proc.rst | 14 ++++++++++++++
> > >   drivers/vfio/vfio_main.c           | 20 ++++++++++++++++++++
> > >   2 files changed, 34 insertions(+)
> > > 
> > > diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
> > > index 2a17865dfe39..fc5ed3117834 100644
> > > --- a/Documentation/filesystems/proc.rst
> > > +++ b/Documentation/filesystems/proc.rst
> > > @@ -2162,6 +2162,20 @@ DMA Buffer files
> > >   where 'size' is the size of the DMA buffer in bytes. 'count' is the file count of
> > >   the DMA buffer file. 'exp_name' is the name of the DMA buffer exporter.
> > > +VFIO Device files
> > > +~~~~~~~~~~~~~~~~
> > > +
> > > +::
> > > +
> > > +	pos:    0
> > > +	flags:  02000002
> > > +	mnt_id: 17
> > > +	ino:    5122
> > > +	vfio-device-syspath: /sys/devices/pci0000:e0/0000:e0:01.1/0000:e1:00.0/0000:e2:05.0/0000:e8:00.0
> > > +
> > > +where 'vfio-device-syspath' is the sysfs path corresponding to the VFIO device
> > > +file.
> > > +
> > >   3.9	/proc/<pid>/map_files - Information about memory mapped files
> > >   ---------------------------------------------------------------------
> > >   This directory contains symbolic links which represent memory mapped files
> > > diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
> > > index 1fd261efc582..37a39cee10ed 100644
> > > --- a/drivers/vfio/vfio_main.c
> > > +++ b/drivers/vfio/vfio_main.c
> > > @@ -28,6 +28,7 @@
> > >   #include <linux/pseudo_fs.h>
> > >   #include <linux/rwsem.h>
> > >   #include <linux/sched.h>
> > > +#include <linux/seq_file.h>
> > >   #include <linux/slab.h>
> > >   #include <linux/stat.h>
> > >   #include <linux/string.h>
> > > @@ -1354,6 +1355,22 @@ static int vfio_device_fops_mmap(struct file *filep, struct vm_area_struct *vma)
> > >   	return device->ops->mmap(device, vma);
> > >   }
> > > +#ifdef CONFIG_PROC_FS
> > > +static void vfio_device_show_fdinfo(struct seq_file *m, struct file *filep)
> > > +{
> > > +	char *path;
> > > +	struct vfio_device_file *df = filep->private_data;
> > > +	struct vfio_device *device = df->device;
> > > +
> > > +	path = kobject_get_path(&device->dev->kobj, GFP_KERNEL);
> > > +	if (!path)
> > > +		return;
> > > +
> > > +	seq_printf(m, "vfio-device-syspath: /sys%s\n", path);
> > > +	kfree(path);
> > > +}
> > > +#endif
> > > +
> > >   const struct file_operations vfio_device_fops = {
> > >   	.owner		= THIS_MODULE,
> > >   	.open		= vfio_device_fops_cdev_open,
> > > @@ -1363,6 +1380,9 @@ const struct file_operations vfio_device_fops = {
> > >   	.unlocked_ioctl	= vfio_device_fops_unl_ioctl,
> > >   	.compat_ioctl	= compat_ptr_ioctl,
> > >   	.mmap		= vfio_device_fops_mmap,
> > > +#ifdef CONFIG_PROC_FS
> > > +	.show_fdinfo	= vfio_device_show_fdinfo,
> > > +#endif
> > >   };
> > >   static struct vfio_device *vfio_device_from_file(struct file *file)
> > > 
> > > ---
> > > base-commit: 4518e5a60c7fbf0cdff393c2681db39d77b4f87e
> > > change-id: 20250801-show-fdinfo-ef109ca738cf
> > > 
> > > Best regards,
> > > -- 
> > > Alex Mastro <amastro@fb.com>
> > > 
> > 
> 

