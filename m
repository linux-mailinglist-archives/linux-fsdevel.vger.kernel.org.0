Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBD771EFFEC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jun 2020 20:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbgFEShx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Jun 2020 14:37:53 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45536 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726294AbgFEShw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Jun 2020 14:37:52 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 055IW5Gv123119;
        Fri, 5 Jun 2020 14:37:27 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 31f9dfg0s5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 05 Jun 2020 14:37:27 -0400
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 055IZdZb142400;
        Fri, 5 Jun 2020 14:37:26 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 31f9dfg0rc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 05 Jun 2020 14:37:26 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 055IZoGE002136;
        Fri, 5 Jun 2020 18:37:24 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03fra.de.ibm.com with ESMTP id 31bf47d60d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 05 Jun 2020 18:37:24 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 055IbLk263242476
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 5 Jun 2020 18:37:21 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D0E074C044;
        Fri,  5 Jun 2020 18:37:21 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CDBF64C04A;
        Fri,  5 Jun 2020 18:37:18 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.181.45])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  5 Jun 2020 18:37:18 +0000 (GMT)
Message-ID: <1591382238.5816.27.camel@linux.ibm.com>
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
Date:   Fri, 05 Jun 2020 14:37:18 -0400
In-Reply-To: <1c68c0c7-1b0a-dfec-0e50-1b65eedc3dc7@broadcom.com>
References: <20200513152108.25669-1-mcgrof@kernel.org>
         <20200513181736.GA24342@infradead.org>
         <20200515212933.GD11244@42.do-not-panic.com>
         <20200518062255.GB15641@infradead.org>
         <1589805462.5111.107.camel@linux.ibm.com>
         <7525ca03-def7-dfe2-80a9-25270cb0ae05@broadcom.com>
         <202005221551.5CA1372@keescook>
         <c48a80f5-a09c-6747-3db8-be23a260a0cb@broadcom.com>
         <1590288736.5111.431.camel@linux.ibm.com>
         <1c68c0c7-1b0a-dfec-0e50-1b65eedc3dc7@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-05_05:2020-06-04,2020-06-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 adultscore=0 impostorscore=0 phishscore=0 malwarescore=0 clxscore=1011
 suspectscore=0 cotscore=-2147483648 priorityscore=1501 mlxlogscore=984
 lowpriorityscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006050134
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2020-06-05 at 11:15 -0700, Scott Branden wrote:
> Hi Mimi,
> 
> On 2020-05-23 7:52 p.m., Mimi Zohar wrote:
> > Scott, the change should be straight forward.  The additional patch
> > needs to:
> > - define a new kernel_read_file_id enumeration, like
> > FIRMWARE_PARTIAL_READ.
> > - Currently ima_read_file() has a comment about pre-allocated firmware
> > buffers.  Update ima_read_file() to call process_measurement() for the
> > new enumeration FIRMWARE_PARTIAL_READ and update ima_post_read_file()
> > to return immediately.
> Should this be what is in ima_read_file?
> {
>      enum ima_hooks func;
>      u32 secid;

Please don't remove the existing comment.

>      if (read_id != READING_FIRMWARE_PARTIAL_READ)
>          return 0;
> 
>      if (!file) { /* should never happen */
>          if (ima_appraise & IMA_APPRAISE_ENFORCE)
>              return -EACCES;
>          return 0;
>      }

This checks for any IMA appraise rule.  You want to enforce firmware
signature checking only if there is a firmware appraise rule.  Refer
to ima_post_read_file().

>      security_task_getsecid(current, &secid);
>      return process_measurement(file, current_cred(), secid, NULL,
>                     0, MAY_READ, FILE_CHECK);

The read_idmap enumeration should be updated similar to the other
firmware.  Keep the code generic.  Refer to ima_post_read_file().
 func will be defined as FIRMWARE_CHECK.

thanks,

Mimi
