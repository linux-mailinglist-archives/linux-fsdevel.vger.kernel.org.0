Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E04F91DFC9A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 May 2020 04:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388306AbgEXCxu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 23 May 2020 22:53:50 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55614 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388262AbgEXCxu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 23 May 2020 22:53:50 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04O2WueA118978;
        Sat, 23 May 2020 22:52:25 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 316xn3hqc0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 23 May 2020 22:52:25 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 04O2XQhe120524;
        Sat, 23 May 2020 22:52:24 -0400
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 316xn3hqbk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 23 May 2020 22:52:24 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 04O2pcoi020197;
        Sun, 24 May 2020 02:52:23 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma01fra.de.ibm.com with ESMTP id 316uf8gmuw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 24 May 2020 02:52:22 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 04O2p6C066060664
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 24 May 2020 02:51:07 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E7F6311C050;
        Sun, 24 May 2020 02:52:19 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 398BE11C04C;
        Sun, 24 May 2020 02:52:17 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.203.161])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun, 24 May 2020 02:52:17 +0000 (GMT)
Message-ID: <1590288736.5111.431.camel@linux.ibm.com>
Subject: Re: [PATCH 0/3] fs: reduce export usage of kerne_read*() calls
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Scott Branden <scott.branden@broadcom.com>,
        Kees Cook <keescook@chromium.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Luis Chamberlain <mcgrof@kernel.org>, viro@zeniv.linux.org.uk,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        ebiederm@xmission.com, jeyu@kernel.org, jmorris@namei.org,
        paul@paul-moore.com, stephen.smalley.work@gmail.com,
        eparis@parisplace.org, nayna@linux.ibm.com,
        dan.carpenter@oracle.com, skhan@linuxfoundation.org,
        geert@linux-m68k.org, tglx@linutronix.de, bauerman@linux.ibm.com,
        dhowells@redhat.com, linux-integrity@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, kexec@lists.infradead.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Sat, 23 May 2020 22:52:16 -0400
In-Reply-To: <c48a80f5-a09c-6747-3db8-be23a260a0cb@broadcom.com>
References: <20200513152108.25669-1-mcgrof@kernel.org>
         <20200513181736.GA24342@infradead.org>
         <20200515212933.GD11244@42.do-not-panic.com>
         <20200518062255.GB15641@infradead.org>
         <1589805462.5111.107.camel@linux.ibm.com>
         <7525ca03-def7-dfe2-80a9-25270cb0ae05@broadcom.com>
         <202005221551.5CA1372@keescook>
         <c48a80f5-a09c-6747-3db8-be23a260a0cb@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-23_14:2020-05-22,2020-05-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 malwarescore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 lowpriorityscore=0 cotscore=-2147483648 phishscore=0 spamscore=0
 mlxscore=0 mlxlogscore=999 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005240020
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2020-05-22 at 16:25 -0700, Scott Branden wrote:
> Hi Kees,
> 
> On 2020-05-22 4:04 p.m., Kees Cook wrote:
> > On Fri, May 22, 2020 at 03:24:32PM -0700, Scott Branden wrote:
> >> On 2020-05-18 5:37 a.m., Mimi Zohar wrote:
> >>> On Sun, 2020-05-17 at 23:22 -0700, Christoph Hellwig wrote:
> >>>> On Fri, May 15, 2020 at 09:29:33PM +0000, Luis Chamberlain wrote:
> >>>>> On Wed, May 13, 2020 at 11:17:36AM -0700, Christoph Hellwig wrote:
> >>>>>> Can you also move kernel_read_* out of fs.h?  That header gets pulled
> >>>>>> in just about everywhere and doesn't really need function not related
> >>>>>> to the general fs interface.
> >>>>> Sure, where should I dump these?
> >>>> Maybe a new linux/kernel_read_file.h?  Bonus points for a small top
> >>>> of the file comment explaining the point of the interface, which I
> >>>> still don't get :)
> >>> Instead of rolling your own method of having the kernel read a file,
> >>> which requires call specific security hooks, this interface provides a
> >>> single generic set of pre and post security hooks.  The
> >>> kernel_read_file_id enumeration permits the security hook to
> >>> differentiate between callers.
> >>>
> >>> To comply with secure and trusted boot concepts, a file cannot be
> >>> accessible to the caller until after it has been measured and/or the
> >>> integrity (hash/signature) appraised.
> >>>
> >>> In some cases, the file was previously read twice, first to measure
> >>> and/or appraise the file and then read again into a buffer for
> >>> use.  This interface reads the file into a buffer once, calls the
> >>> generic post security hook, before providing the buffer to the caller.
> >>>    (Note using firmware pre-allocated memory might be an issue.)
> >>>
> >>> Partial reading firmware will result in needing to pre-read the entire
> >>> file, most likely on the security pre hook.
> >> The entire file may be very large and not fit into a buffer.
> >> Hence one of the reasons for a partial read of the file.
> >> For security purposes, you need to change your code to limit the amount
> >> of data it reads into a buffer at one time to not consume or run out of much
> >> memory.
> > Hm? That's not how whole-file hashing works. :)
> 
> >
> > These hooks need to finish their hashing and policy checking before they
> > can allow the rest of the code to move forward. (That's why it's a
> > security hook.) If kernel memory utilization is the primary concern,
> > then sure, things could be rearranged to do partial read and update the
> > hash incrementally, but the entire file still needs to be locked,
> > entirely hashed by hook, then read by the caller, then unlocked and
> > released.

Exactly.

> >
> > So, if you want to have partial file reads work, you'll need to
> > rearchitect the way this works to avoid regressing the security coverage
> > of these operations.
> I am not familiar with how the security handling code works at all.
> Is the same security check run on files opened from user space?
> A file could be huge.
> 
> If it assumes there is there is enough memory available to read the 
> entire file into kernel space then the improvement below can be left as
> a memory optimization to be done in an independent (or future) patch series.

There are two security hooks - security_kernel_read_file(),
security_kernel_post_read_file - in kernel_read_file().  The first
hook is called before the file is read into a buffer, while the second
hook is called afterwards.

For partial reads, measuring the firmware and verifying the firmware's
signature will need to be done on the security_kernel_read_file()
hook.

> 
> > So, probably, the code will look something like:
> >
> >
> > file = kernel_open_file_for_reading(...)
> > 	file = open...
> > 	disallow_writes(file);
> > 	while (processed < size-of-file) {
> > 		buf = read(file, size...)
> > 		security_file_read_partial(buf)
> > 	}
> > 	ret = security_file_read_finished(file);
> > 	if (ret < 0) {
> > 		allow_writes(file);
> > 		return PTR_ERR(ret);
> > 	}
> > 	return file;
> >
> > while (processed < size-of-file) {
> > 	buf = read(file, size...)
> > 	firmware_send_partial(buf);
> > }
> >
> > kernel_close_file_for_reading(file)
> > 	allow_writes(file);

Right, the ima_file_mmap(), ima_bprm_check(), and ima_file_check()
hooks call process_measurement() to do this.  ima_post_read_file()
passes a buffer to process_measurement() instead.

Scott, the change should be straight forward.  The additional patch
needs to:
- define a new kernel_read_file_id enumeration, like
FIRMWARE_PARTIAL_READ.
- Currently ima_read_file() has a comment about pre-allocated firmware
buffers.  Update ima_read_file() to call process_measurement() for the
new enumeration FIRMWARE_PARTIAL_READ and update ima_post_read_file()
to return immediately.

The built-in IMA measurement policy contains a rule to measure
firmware.  The policy can be specified on the boot command line by
specifying "ima_policy=tcb".  After reading the firmware, the firmware
measurement should be in <securityfs>/ima/ascii_runtime_measurements.

thanks,

Mimi
