Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCBA83D24DB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jul 2021 15:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232118AbhGVNJn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Jul 2021 09:09:43 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39162 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231925AbhGVNJn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Jul 2021 09:09:43 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16MDX0E3128636;
        Thu, 22 Jul 2021 09:50:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=kos3FVmTd7oXvlZ3XCZRWpWrBVMFG6Ui1FBGEyaRtbM=;
 b=DAyvb9xvFE2UQS0Zg29ILghYMai1hPTyTS1IjqmMirx29XIBVi16ARu24ieY7aMdoZ/U
 LT8kv5W08Yl0FhygOB9/wJSDgUtTBB2rPmMrrv3OTsCQrtVAx8tzbxVocRekDFegYoUR
 rOilz2tiKreRQJbwnQFnbQXfyVSYnys6kvnyMlqeIwh6QGaXmeYUQGxJ3h2BbyhOnJfN
 6Xlubt9owPftU0vPOHKrnutK9JaxxwSHSoaXn5D8hrZi53EjvPwuwUh0BpO+QlODWDyP
 rfoxXyzLKTpo9tWb0PSPjesK7ApBo5KdrVDRkmtvrMb0oPtAo9QnxqYV+WyrwIoUn0D7 0A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39y8xahu24-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Jul 2021 09:50:15 -0400
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 16MDXeMb136193;
        Thu, 22 Jul 2021 09:50:15 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39y8xahtyw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Jul 2021 09:50:15 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16MDlGuG008371;
        Thu, 22 Jul 2021 13:50:12 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06ams.nl.ibm.com with ESMTP id 39vng724gw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Jul 2021 13:50:12 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16MDlfMx23921074
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Jul 2021 13:47:41 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E0D3D11C054;
        Thu, 22 Jul 2021 13:50:09 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D3B6B11C04A;
        Thu, 22 Jul 2021 13:50:07 +0000 (GMT)
Received: from sig-9-65-201-143.ibm.com (unknown [9.65.201.143])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 22 Jul 2021 13:50:07 +0000 (GMT)
Message-ID: <decadc5869f3de0bc78f783703e5ca9286f42522.camel@linux.ibm.com>
Subject: Re: [syzbot] possible deadlock in mnt_want_write (2)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Miklos Szeredi <miklos@szeredi.hu>,
        syzbot <syzbot+b42fe626038981fb7bfa@syzkaller.appspotmail.com>,
        Hillf Danton <hdanton@sina.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-integrity <linux-integrity@vger.kernel.org>
Date:   Thu, 22 Jul 2021 09:50:06 -0400
In-Reply-To: <CAJfpegsYNcv+mEVpLBxVGSQhXr0Q_UnOUC1VkYuYB=xzRt+f-A@mail.gmail.com>
References: <00000000000067d24205c4d0e599@google.com>
         <CAJfpegsYNcv+mEVpLBxVGSQhXr0Q_UnOUC1VkYuYB=xzRt+f-A@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: jNI6zunxBaehC_v-7eAEcm_fNZPdIjc1
X-Proofpoint-ORIG-GUID: v1AYLtooOcVymVRZmDtX_OfRce_DyXX7
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-22_07:2021-07-22,2021-07-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 clxscore=1011 mlxlogscore=930 mlxscore=0 spamscore=0
 malwarescore=0 bulkscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107220091
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[CC'ing Hillf Danton <hdanton@sina.com>]

Hi Miklos,

On Mon, 2021-07-19 at 17:11 +0200, Miklos Szeredi wrote:
> [CC: linux-intergrity]
> 
> On Tue, 15 Jun 2021 at 18:59, syzbot
> <syzbot+b42fe626038981fb7bfa@syzkaller.appspotmail.com> wrote:
> >
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    06af8679 coredump: Limit what can interrupt coredumps
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=162f99afd00000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=547a5e42ca601229
> > dashboard link: https://syzkaller.appspot.com/bug?extid=b42fe626038981fb7bfa
> > compiler:       Debian clang version 11.0.1-2
> >
> > Unfortunately, I don't have any reproducer for this issue yet.

There was a similar syzbot report and followup discussion [1].  
According to Amir Goldstein,  it's a false positive lockdep warning.  
At this point we understand how to fix the problem, but are waiting for
a reproducer.

thanks,

Mimi

[1] Message-Id: <20210616090142.734-1-hdanton@sina.com>

> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+b42fe626038981fb7bfa@syzkaller.appspotmail.com


