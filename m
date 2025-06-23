Return-Path: <linux-fsdevel+bounces-52570-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F98AE4586
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 15:55:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 685DD17A509
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 13:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6087253340;
	Mon, 23 Jun 2025 13:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fpoCEnRs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268A72581;
	Mon, 23 Jun 2025 13:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750686622; cv=none; b=MGS1FD0dsY2cX9V6QcQWY2g+vgtd8oWZjJJ17V8tnSnOcmKbOj9iqJk6FLXrlAoTzhDw706duf5cjWW9vKmVTD3KMnZN1Bb2TOHGwlx+aDtQGzmqblNAPn7sjwAzwnu1kbMtgD22WEr7ATou8tzCdfF/BUjj+uhSl4iUHswDEeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750686622; c=relaxed/simple;
	bh=c988JZCnBIY2a9KOEJevJggGdOmXGN7J2iiH82lgLQI=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=Rm/WbIYzd6WhZNfXjC3yxngv33jpzdwRaz0jeH5hBtS/6pkn/jhdXnmJpszPBuDc855hwRsPkyh17yd8aotPk+Bqjr6PkfKx90REbiAEgOI7T/eDjuyMnW1NidhStoJkOxCurMDKgD4YY09cGKqiB743vV2BnA5MojYf3y+kcdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fpoCEnRs; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55NA9VKY014328;
	Mon, 23 Jun 2025 13:50:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=SXjC9tjMMl+SAkf/qCEzH8j0GtIm
	8vbuzThmPZktjZE=; b=fpoCEnRsHad4APOXAfsDNuadsC5xZdvDvdHzEVp2oihZ
	cB5MTKFC/caHKDV3KinpiMnlsE5XtnA2/tdy1lTXMB7v2WC6cPYCWONR6p4RwW0D
	s3r3DHZQcwE7Mb6yXNdwZajKMH7EtAnlye/qOG8AUl+dTYAshJdkkQz5VjuCjSll
	l4NcvZ6lSSVM5PZqYcCdZqWcfDLvO9B3dGTl37VlD9iJSmAAgHKzh8UgrRhY2RAl
	NDCO96y0A1BVdfvdKUKQ4y+EBBrksfee17hzadd2sbosh3sAGtktlyVGhMo9v9CB
	bAGwQeTEgiEqIJYmnsp4+fUOgfnogXSvbmol58Rtbg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dj5tjgx1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Jun 2025 13:50:10 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55NCGrh0003976;
	Mon, 23 Jun 2025 13:50:09 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 47e99ket3f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Jun 2025 13:50:09 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55NDo7xN64225782
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Jun 2025 13:50:07 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8D5AE58059;
	Mon, 23 Jun 2025 13:50:07 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DFFEC58043;
	Mon, 23 Jun 2025 13:50:04 +0000 (GMT)
Received: from [9.61.248.239] (unknown [9.61.248.239])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 23 Jun 2025 13:50:04 +0000 (GMT)
Message-ID: <aafeb4a9-31ea-43ad-b807-fd082cc0c9ad@linux.ibm.com>
Date: Mon, 23 Jun 2025 19:20:03 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: LKML <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, riteshh@linux.ibm.com
From: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: [linux-next-20250620] Fails to boot to IBM Power Server
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ccFf3isMMNkuSv0czHmdfmdwQgwxjhS_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIzMDA4MiBTYWx0ZWRfX95AbRz+3xZjR 6Rnx9zgTpXpPs3STnqgc2BNR8+PoaiEQ7RcmpC5HtcwQ4L1nu2wm5ob6jwV9BkdAauWrkdjFd6z 8wAS9oJuM+yjkr6i6B7o1pS9vK5E1FYc0/x+ugatPUVnvFjo/77efSFcfjk/4i+5LfNcVdLm7zj
 SnkriWTPsACDEl+0jJ4x02I+4V98vaVbbHlqveI2LRIio6SrRH4X/u+snJea2oB1xvBwPjfOP8C 1ZwRFAhJWlETDfThsZMZKBiJ8ZImQoykWB0nhSPfs5EDtODP+u1fRCnxnQ+Y8WtcAQFRH3uscFG HlPFMF4ZouU8wJOR9axE5bD1I46R9qIp7J7mM1CkyVxICTKWo8FWpcnaqRgEDnZQ3Azmae2PMhj
 SA4NuWVv69CDAWAUorWZhn6e65b6RR/AjREGOS0aA4css9qE68LKP5o6kDC0AaPgIvptuv1Y
X-Authority-Analysis: v=2.4 cv=MshS63ae c=1 sm=1 tr=0 ts=68595b92 cx=c_pps a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=drOt6m5kAAAA:8 a=VwQbUJbxAAAA:8 a=NEAV23lmAAAA:8 a=VnNF1IyMAAAA:8
 a=TPkE1cP4elOO-XClOicA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=RMMjzBEyIzXRtoq5n5K6:22
X-Proofpoint-GUID: ccFf3isMMNkuSv0czHmdfmdwQgwxjhS_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-23_04,2025-06-23_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 mlxlogscore=999 impostorscore=0
 clxscore=1011 phishscore=0 malwarescore=0 suspectscore=0 adultscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506230082

Greetings!!!


IBM CI has reported a boot issue, while trying to boot from 
linux-next-20250620 repo.


Git Bisect is pointing to below commit as the first bad commit.


a9ea6b0629a5a91d11db9318fba45a2e058babb1 is the first bad commit
commit a9ea6b0629a5a91d11db9318fba45a2e058babb1
Author: Al Viro <viro@zeniv.linux.org.uk>
Date:   Tue Jun 17 00:09:51 2025 -0400

     replace collect_mounts()/drop_collected_mounts() with safer variant

     collect_mounts() has several problems - one can't iterate over the 
results
     directly, so it has to be done with callback passed to 
iterate_mounts();
     it also has oopsable race with d_invalidate(); it also creates 
temporary
     clones of mounts invisibly for sync umount (IOW, you can have 
umount return
     with filesystem not mounted in any other locations and yet have it 
still
     busy as umount(2) returns).

     A saner approach is to give caller an array of struct path that 
would pin
     every mount in a subtree, without cloning any mounts.

             * collect_mounts()/drop_collected_mounts()/iterate_mounts() 
is gone
             * collect_paths(where, preallocated, size) gives either 
ERR_PTR(-E...) or
     a pointer to array of struct path, one for each chunk of tree 
visible under
     'where' (i.e. the first element is a copy of where, followed by 
(mount,root)
     for everything mounted under it - the same set collect_mounts() 
would give).
     Unlike collect_mounts(), the mounts are *not* cloned - we just get 
(pinning)
     references to roots of subtree in the caller's namespaces.
             Array is terminated by {NULL, NULL} struct path.  If it 
fits into
     preallocated array (on-stack, normally), that's where it goes; 
otherwise
     it's allocated by kmalloc_array().  Passing 0 as size means that 
'preallocated'
     is ignored (and expected to be NULL).
             * drop_collected_paths(paths, preallocated) is given the 
array returned
     by collect_paths() and the preallocated array used passed to the 
same.  All
     mount/dentry references are dropped and array is kfree'd if it's 
not equal to
     'preallocated'.
             * instead of iterate_mounts(), users should just iterate 
over array
     of struct path - nothing exotic is needed for that.  Existing users 
(all in
     audit_tree.c) are converted.

     Fixes: 80b5dce8c59b0 ("vfs: Add a function to lazily unmount all 
mounts from any dentry")
     Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

  fs/namespace.c        | 97 
+++++++++++++++++++++++++++++++--------------------
  fs/pnode.h            |  2 --
  include/linux/mount.h |  6 ++--
  kernel/audit_tree.c   | 63 ++++++++++++++++++---------------
  4 files changed, 95 insertions(+), 73 deletions(-)



Traces:


[   26.465091] Kernel attempted to read user page (0) - exploit attempt? 
(uid: 0)
[   26.465146] BUG: Kernel NULL pointer dereference on read at 0x00000000
[   26.465146] BUG: Kernel NULL pointer dereference on read at 0x00000000
[   26.465178] Faulting instruction address: 0xc00000000067a4e0
[   26.465178] Faulting instruction address: 0xc00000000067a4e0
[   26.465206] Oops: Kernel access of bad area, sig: 11 [#1]
[   26.465206] Oops: Kernel access of bad area, sig: 11 [#1]
[   26.465232] LE PAGE_SIZE=64K MMU=Radix  SMP NR_CPUS=8192 NUMA pSeries
[   26.465232] LE PAGE_SIZE=64K MMU=Radix  SMP NR_CPUS=8192 NUMA pSeries
[   26.465264] Modules linked in: nft_compat nf_tables nfnetlink 
rpadlpar_io rpaphp xsk_diag bonding rfkill binfmt_misc mlx5_ib ib_uverbs 
ib_core vmx_crypto pseries_rng drm drm_panel_orientation_quirks ext4 
crc16 mbcache jbd2 dm_service_time sd_mod sg nvme_tcp nvme_fabrics 
ibmvfc nvme_core mlx5_core scsi_transport_fc ibmveth mlxfw psample 
dm_multipath dm_mirror dm_region_hash dm_log dm_mod be2iscsi bnx2i cnic 
uio cxgb4i cxgb4 tls libcxgbi libcxgb qla4xxx iscsi_boot_sysfs iscsi_tcp 
libiscsi_tcp libiscsi scsi_transport_iscsi fuse
[   26.465264] Modules linked in: nft_compat nf_tables nfnetlink 
rpadlpar_io rpaphp xsk_diag bonding rfkill binfmt_misc mlx5_ib ib_uverbs 
ib_core vmx_crypto pseries_rng drm drm_panel_orientation_quirks ext4 
crc16 mbcache jbd2 dm_service_time sd_mod sg nvme_tcp nvme_fabrics 
ibmvfc nvme_core mlx5_core scsi_transport_fc ibmveth mlxfw psample 
dm_multipath dm_mirror dm_region_hash dm_log dm_mod be2iscsi bnx2i cnic 
uio cxgb4i cxgb4 tls libcxgbi libcxgb qla4xxx iscsi_boot_sysfs iscsi_tcp 
libiscsi_tcp libiscsi scsi_transport_iscsi fuse
[   26.465508] CPU: 24 UID: 0 PID: 1196 Comm: osqueryd Kdump: loaded Not 
tainted 6.16.0-rc2-next-20250619-autotest #1 VOLUNTARY
[   26.465508] CPU: 24 UID: 0 PID: 1196 Comm: osqueryd Kdump: loaded Not 
tainted 6.16.0-rc2-next-20250619-autotest #1 VOLUNTARY

[   26.465615] NIP:  c00000000067a4e0 LR: c0000000003035e0 CTR: 
c00000000021b030
[   26.465615] NIP:  c00000000067a4e0 LR: c0000000003035e0 CTR: 
c00000000021b030
[   26.465649] REGS: c000000081b3f400 TRAP: 0300   Not tainted 
(6.16.0-rc2-next-20250619-autotest)
[   26.465649] REGS: c000000081b3f400 TRAP: 0300   Not tainted 
(6.16.0-rc2-next-20250619-autotest)
[   26.465692] MSR:  800000000280b033 <SF,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>  
CR: 24608862  XER: 20040000
[   26.465692] MSR:  800000000280b033 <SF,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>  
CR: 24608862  XER: 20040000
[   26.465740] CFAR: c0000000003035dc DAR: 0000000000000000 DSISR: 
40000000 IRQMASK: 0
[   26.465740] GPR00: c0000000003035e0 c000000081b3f6a0 c000000001658100 
c000000002bb0e38
[   26.465740] GPR04: c000000081b3f798 0000000000000010 c000000081b3f4e0 
0000000000000018
[   26.465740] GPR08: c000000081a88e80 0000000000000000 0000000000000000 
c008000006c5fc88
[   26.465740] GPR12: c00000000021b030 c000000c7db72b00 0000000000000000 
0000000000000000
[   26.465740] GPR16: 0000000000000000 0000000000000000 0000000000000000 
0000000000000000
[   26.465740] GPR20: 0000000000000000 0000000000000018 c000000060abb810 
c000000002b777a0
[   26.465740] GPR24: c000000002b776e0 c00000007f673f70 c00000007f6c3930 
c000000002bb0e38
[   26.465740] GPR28: 0000000000000000 c00000007f673e20 c00000007f6c3900 
ffffffffffffffea
[   26.465740] CFAR: c0000000003035dc DAR: 0000000000000000 DSISR: 
40000000 IRQMASK: 0
[   26.465740] GPR00: c0000000003035e0 c000000081b3f6a0 c000000001658100 
c000000002bb0e38
[   26.465740] GPR04: c000000081b3f798 0000000000000010 c000000081b3f4e0 
0000000000000018
[   26.465740] GPR08: c000000081a88e80 0000000000000000 0000000000000000 
c008000006c5fc88
[   26.465740] GPR12: c00000000021b030 c000000c7db72b00 0000000000000000 
0000000000000000
[   26.465740] GPR16: 0000000000000000 0000000000000000 0000000000000000 
0000000000000000
[   26.465740] GPR20: 0000000000000000 0000000000000018 c000000060abb810 
c000000002b777a0
[   26.465740] GPR24: c000000002b776e0 c00000007f673f70 c00000007f6c3930 
c000000002bb0e38
[   26.465740] GPR28: 0000000000000000 c00000007f673e20 c00000007f6c3900 
ffffffffffffffea
[   26.466083] NIP [c00000000067a4e0] collect_paths+0x5c/0x2c4
[   26.466083] NIP [c00000000067a4e0] collect_paths+0x5c/0x2c4
[   26.466113] LR [c0000000003035e0] audit_add_tree_rule+0x38c/0x6c0
[   26.466113] LR [c0000000003035e0] audit_add_tree_rule+0x38c/0x6c0
[   26.466146] Call Trace:
[   26.466146] Call Trace:
[   26.466158] [c000000081b3f6a0] [c000000081b3f6e0] 0xc000000081b3f6e0 
(unreliable)
[   26.466158] [c000000081b3f6a0] [c000000081b3f6e0] 0xc000000081b3f6e0 
(unreliable)
[   26.466195] [c000000081b3f720] [c0000000003035e0] 
audit_add_tree_rule+0x38c/0x6c0
[   26.466195] [c000000081b3f720] [c0000000003035e0] 
audit_add_tree_rule+0x38c/0x6c0
[   26.466232] [c000000081b3f8f0] [c0000000002f5698] 
audit_add_rule+0xc4/0x368
[   26.466232] [c000000081b3f8f0] [c0000000002f5698] 
audit_add_rule+0xc4/0x368
[   26.466267] [c000000081b3f960] [c0000000002f6d1c] 
audit_rule_change+0x84/0x240
[   26.466267] [c000000081b3f960] [c0000000002f6d1c] 
audit_rule_change+0x84/0x240
[   26.466302] [c000000081b3f9a0] [c0000000002f2bcc] 
audit_receive_msg+0x370/0x131c
[   26.466302] [c000000081b3f9a0] [c0000000002f2bcc] 
audit_receive_msg+0x370/0x131c
[   26.466338] [c000000081b3fac0] [c0000000002f3c94] 
audit_receive+0x11c/0x220
[   26.466338] [c000000081b3fac0] [c0000000002f3c94] 
audit_receive+0x11c/0x220
[   26.466371] [c000000081b3fb40] [c000000000e7d964] 
netlink_unicast+0x328/0x3bc
[   26.466371] [c000000081b3fb40] [c000000000e7d964] 
netlink_unicast+0x328/0x3bc
[   26.466408] [c000000081b3fbb0] [c000000000e7dc18] 
netlink_sendmsg+0x220/0x528
[   26.466408] [c000000081b3fbb0] [c000000000e7dc18] 
netlink_sendmsg+0x220/0x528
[   26.466443] [c000000081b3fca0] [c000000000d7d6b8] 
__sys_sendto+0x1fc/0x28c
[   26.466443] [c000000081b3fca0] [c000000000d7d6b8] 
__sys_sendto+0x1fc/0x28c
[   26.466477] [c000000081b3fdf0] [c000000000d7d784] sys_sendto+0x3c/0x4c
[   26.466477] [c000000081b3fdf0] [c000000000d7d784] sys_sendto+0x3c/0x4c
[   26.466509] [c000000081b3fe10] [c000000000033338] 
system_call_exception+0x138/0x330
[   26.466509] [c000000081b3fe10] [c000000000033338] 
system_call_exception+0x138/0x330
[   26.466547] [c000000081b3fe50] [c00000000000d05c] 
system_call_vectored_common+0x15c/0x2ec
[   26.466547] [c000000081b3fe50] [c00000000000d05c] 
system_call_vectored_common+0x15c/0x2ec
[   26.466588] ---- interrupt: 3000 at 0x7fff92f507c4
[   26.466588] ---- interrupt: 3000 at 0x7fff92f507c4
[   26.466611] NIP:  00007fff92f507c4 LR: 00007fff92f507c4 CTR: 
0000000000000000
[   26.466611] NIP:  00007fff92f507c4 LR: 00007fff92f507c4 CTR: 
0000000000000000
[   26.466645] REGS: c000000081b3fe80 TRAP: 3000   Not tainted 
(6.16.0-rc2-next-20250619-autotest)
[   26.466645] REGS: c000000081b3fe80 TRAP: 3000   Not tainted 
(6.16.0-rc2-next-20250619-autotest)
[   26.466685] MSR:  800000000280f033 
<SF,VEC,VSX,EE,PR,FP,ME,IR,DR,RI,LE>  CR: 44602461  XER: 00000000
[   26.466685] MSR:  800000000280f033 
<SF,VEC,VSX,EE,PR,FP,ME,IR,DR,RI,LE>  CR: 44602461  XER: 00000000
[   26.466734] IRQMASK: 0
[   26.466734] GPR00: 000000000000014f 00007fffe4904780 000000011dc16b98 
0000000000000026
[   26.466734] GPR04: 00007fffe4904808 0000000000000470 0000000000000000 
00007fffe49047f8
[   26.466734] GPR08: 000000000000000c 0000000000000000 0000000000000000 
0000000000000000
[   26.466734] GPR12: 0000000000000000 00007fff932ad2c0 0000000000000020 
00000001584e4310
[   26.466734] GPR16: 00000001585664c0 000000011ddb6b98 0000000000000000 
0000000000000000
[   26.466734] GPR20: 0000000156e56d20 000000015707ee80 00000001585664d0 
0000000000000018
[   26.466734] GPR24: 0000000000000000 000000011dd66b98 00007fffe4904808 
0000000000000026
[   26.466734] GPR28: 0000000000000470 0000000000000000 0000000000000000 
000000000000000c
[   26.466734] IRQMASK: 0
[   26.466734] GPR00: 000000000000014f 00007fffe4904780 000000011dc16b98 
0000000000000026
[   26.466734] GPR04: 00007fffe4904808 0000000000000470 0000000000000000 
00007fffe49047f8
[   26.466734] GPR08: 000000000000000c 0000000000000000 0000000000000000 
0000000000000000
[   26.466734] GPR12: 0000000000000000 00007fff932ad2c0 0000000000000020 
00000001584e4310
[   26.466734] GPR16: 00000001585664c0 000000011ddb6b98 0000000000000000 
0000000000000000
[   26.466734] GPR20: 0000000156e56d20 000000015707ee80 00000001585664d0 
0000000000000018
[   26.466734] GPR24: 0000000000000000 000000011dd66b98 00007fffe4904808 
0000000000000026
[   26.466734] GPR28: 0000000000000470 0000000000000000 0000000000000000 
000000000000000c
[   26.467050] NIP [00007fff92f507c4] 0x7fff92f507c4
[   26.467050] NIP [00007fff92f507c4] 0x7fff92f507c4
[   26.467073] LR [00007fff92f507c4] 0x7fff92f507c4
[   26.467073] LR [00007fff92f507c4] 0x7fff92f507c4
[   26.467096] ---- interrupt: 3000
[   26.467096] ---- interrupt: 3000
[   26.467112] Code: 7c7c1b78 3be0ffea 3b7b8d38 7f63db78 f8010010 
f821ff81 90a1002c e94d0c78 f9410048 39400000 f9210040 f8810038 
<eb5c0000> 48a8a2b9 60000000 e92d0908
[   26.467112] Code: 7c7c1b78 3be0ffea 3b7b8d38 7f63db78 f8010010 
f821ff81 90a1002c e94d0c78 f9410048 39400000 f9210040 f8810038 
<eb5c0000> 48a8a2b9 60000000 e92d0908
[   26.467187] ---[ end trace 0000000000000000 ]---
[   26.467187] ---[ end trace 0000000000000000 ]---
[   26.469587] pstore: backend (nvram) writing error (-1)
[   26.469587] pstore: backend (nvram) writing error (-1)



Git Bisect logs:


git bisect log
git bisect start
# status: waiting for both good and bad commits
# good: [e04c78d86a9699d136910cfc0bdcf01087e3267e] Linux 6.16-rc2
git bisect good e04c78d86a9699d136910cfc0bdcf01087e3267e
# status: waiting for bad commit, 1 good commit known
# bad: [2c923c845768a0f0e34b8161d70bc96525385782] Add linux-next 
specific files for 20250619
git bisect bad 2c923c845768a0f0e34b8161d70bc96525385782
# bad: [c567e1e73106808756096712e1e24ff0e55bc869] Merge branch 'main' of 
git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
git bisect bad c567e1e73106808756096712e1e24ff0e55bc869
# bad: [84f70e2114659fb2aef508a2dabe474b9500e1d0] Merge branch 
'xtensa-for-next' of git://github.com/jcmvbkbc/linux-xtensa.git
git bisect bad 84f70e2114659fb2aef508a2dabe474b9500e1d0
# bad: [8705d9293cf77242a2549cb2db0fac17ea8bc07b] Merge branch 
'mm-unstable' of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
git bisect bad 8705d9293cf77242a2549cb2db0fac17ea8bc07b
# bad: [70d02212789008ab8c7854eec7781442883a06ac] Merge branch 
'mtd/fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git
git bisect bad 70d02212789008ab8c7854eec7781442883a06ac
# bad: [504e9fee35da228b1481cf7821e99118b78a396a] Merge branch 'fixes' 
of git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git
git bisect bad 504e9fee35da228b1481cf7821e99118b78a396a
# good: [5adb635077d1b4bd65b183022775a59a378a9c00] Merge tag 
'selinux-pr-20250618' of 
git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux
git bisect good 5adb635077d1b4bd65b183022775a59a378a9c00
# good: [75856c59ae536a369ac79c1b8f5f5c002a9f5c70] mm/hugetlb: remove 
unnecessary holding of hugetlb_lock
git bisect good 75856c59ae536a369ac79c1b8f5f5c002a9f5c70
# bad: [c918c63d5c13ac59fef9eb02b7688cb464fdb32c] Merge branch 'fixes' 
of git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git
git bisect bad c918c63d5c13ac59fef9eb02b7688cb464fdb32c
# good: [4f24bfcc398eb77aa41fe1bb1621d8c2cca5368d] Merge tag 
'sched_ext-for-6.16-rc2-fixes' of 
git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext
git bisect good 4f24bfcc398eb77aa41fe1bb1621d8c2cca5368d
# good: [74b4cc9b8780bfe8a3992c9ac0033bf22ac01f19] Merge tag 
'cgroup-for-6.16-rc2-fixes' of 
git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup
git bisect good 74b4cc9b8780bfe8a3992c9ac0033bf22ac01f19
# good: [336f36773aec57d6bb6e33e46f6121bca13d33a0] Merge branch 
'misc-6.16' into next-fixes
git bisect good 336f36773aec57d6bb6e33e46f6121bca13d33a0
# bad: [a9ea6b0629a5a91d11db9318fba45a2e058babb1] replace 
collect_mounts()/drop_collected_mounts() with safer variant
git bisect bad a9ea6b0629a5a91d11db9318fba45a2e058babb1
# first bad commit: [a9ea6b0629a5a91d11db9318fba45a2e058babb1] replace 
collect_mounts()/drop_collected_mounts() with safer variant



If you happen to fix this issue, please add below tag.


Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>



Regards,

Venkat.


