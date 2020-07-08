Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E956217C30
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jul 2020 02:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728369AbgGHAYz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jul 2020 20:24:55 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:32518 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728208AbgGHAYz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jul 2020 20:24:55 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06803DgJ167205;
        Tue, 7 Jul 2020 20:24:39 -0400
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3250bcmryj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Jul 2020 20:24:39 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0680DDAO010229;
        Wed, 8 Jul 2020 00:24:37 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06fra.de.ibm.com with ESMTP id 322h1g9xm1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Jul 2020 00:24:36 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0680NDRm62980576
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 Jul 2020 00:23:13 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 55FBE52051;
        Wed,  8 Jul 2020 00:24:34 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.200.130])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id CA4565204E;
        Wed,  8 Jul 2020 00:24:31 +0000 (GMT)
Message-ID: <1594167871.23056.132.camel@linux.ibm.com>
Subject: Re: [PATCH v10 2/9] fs: introduce kernel_pread_file* support
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Kees Cook <keescook@chromium.org>,
        Scott Branden <scott.branden@broadcom.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Wolfram Sang <wsa@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Brown <david.brown@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>, bjorn.andersson@linaro.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Olof Johansson <olof@lixom.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Colin Ian King <colin.king@canonical.com>,
        Takashi Iwai <tiwai@suse.de>, linux-kselftest@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Date:   Tue, 07 Jul 2020 20:24:31 -0400
In-Reply-To: <202007071642.AA705B2A@keescook>
References: <20200706232309.12010-1-scott.branden@broadcom.com>
         <20200706232309.12010-3-scott.branden@broadcom.com>
         <202007071642.AA705B2A@keescook>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-07_14:2020-07-07,2020-07-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 cotscore=-2147483648 priorityscore=1501 phishscore=0
 spamscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0 mlxscore=0
 impostorscore=0 malwarescore=0 clxscore=1011 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2007070158
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2020-07-07 at 16:56 -0700, Kees Cook wrote:
> > @@ -951,21 +955,32 @@ int kernel_read_file(struct file *file, void **buf, loff_t *size,
> >               ret = -EINVAL;
> >               goto out;
> >       }
> > -     if (i_size > SIZE_MAX || (max_size > 0 && i_size > max_size)) {
> > +
> > +     /* Default read to end of file */
> > +     read_end = i_size;
> > +
> > +     /* Allow reading partial portion of file */
> > +     if ((id == READING_FIRMWARE_PARTIAL_READ) &&
> > +         (i_size > (pos + max_size)))
> > +             read_end = pos + max_size;
> 
> There's no need to involve "id" here. There are other signals about
> what's happening (i.e. pos != 0, max_size != i_size, etc).

Both the pre and post security kernel_read_file hooks are called here,
but there isn't enough information being passed to the LSM/IMA to be
able to different which hook is applicable.  One method of providing
that additional information is by enumeration.  The other option would
be to pass some additional information.

For example, on the post kernel_read_file hook, the file is read once
into memory.  IMA calculates the firmware file hash based on the
buffer contents.  On the pre kernel_read_file hook, IMA would need to
read the entire file, calculating the file hash.  Both methods of
calculating the file hash work, but the post hook is more efficient.

Mimi
