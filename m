Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9B2B7BEAA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2019 12:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387839AbfGaKuv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Jul 2019 06:50:51 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48472 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726151AbfGaKuu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Jul 2019 06:50:50 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6VAlflu014052
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 Jul 2019 06:50:49 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2u39ea0cuw-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 Jul 2019 06:50:48 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Wed, 31 Jul 2019 11:50:47 +0100
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 31 Jul 2019 11:50:42 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x6VAoO2a36831616
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Jul 2019 10:50:24 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 35FC8A4059;
        Wed, 31 Jul 2019 10:50:41 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CC671A4055;
        Wed, 31 Jul 2019 10:50:40 +0000 (GMT)
Received: from osiris (unknown [9.152.212.134])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 31 Jul 2019 10:50:40 +0000 (GMT)
Date:   Wed, 31 Jul 2019 12:50:39 +0200
From:   Heiko Carstens <heiko.carstens@de.ibm.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Kai =?iso-8859-1?Q?M=E4kisara?= <Kai.Makisara@kolumbus.fi>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-ide@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH v5 15/29] compat_ioctl: move tape handling into drivers
References: <20190730192552.4014288-1-arnd@arndb.de>
 <20190730195819.901457-1-arnd@arndb.de>
 <20190730195819.901457-3-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190730195819.901457-3-arnd@arndb.de>
X-TM-AS-GCONF: 00
x-cbid: 19073110-0008-0000-0000-000003028EAC
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19073110-0009-0000-0000-0000227033BB
Message-Id: <20190731105039.GB3488@osiris>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-31_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=664 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1907310112
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 30, 2019 at 09:55:31PM +0200, Arnd Bergmann wrote:
> MTIOCPOS and MTIOCGET are incompatible between 32-bit and 64-bit user
> space, and traditionally have been translated in fs/compat_ioctl.c.
> 
> To get rid of that translation handler, move a corresponding
> implementation into each of the four drivers implementing those commands.
> 
> The interesting part of that is now in a new linux/mtio.h header that
> wraps the existing uapi/linux/mtio.h header and provides an abstraction
> to let drivers handle both cases easily. Using an in_compat_syscall()
> check, the caller does not have to keep track of whether this was
> called through .unlocked_ioctl() or .compat_ioctl().
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Besides the two minor things below

Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com>

> diff --git a/include/linux/mtio.h b/include/linux/mtio.h
> new file mode 100644
> index 000000000000..fa2783fd37d1
> --- /dev/null
> +++ b/include/linux/mtio.h
> @@ -0,0 +1,59 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _LINUX_MTIO_COMPAT_H
> +#define _LINUX_MTIO_COMPAT_H
> +
> +#include <linux/compat.h>
> +#include <uapi/linux/mtio.h>
> +#include <linux/uaccess.h>
> +
> +/*
> + * helper functions for implementing compat ioctls on the four tape
> + * drivers: we define the 32-bit layout of each incompatible strucucture,

typo: structure

> + * plus a wrapper function to copy it to user space in either format.
> + */
> +
> +struct	mtget32 {
> +	s32	mt_type;
> +	s32	mt_resid;
> +	s32	mt_dsreg;
> +	s32	mt_gstat;
> +	s32	mt_erreg;
> +	s32	mt_fileno;
> +	s32	mt_blkno;
> +};
> +#define	MTIOCGET32	_IOR('m', 2, struct mtget32)
> +
> +struct	mtpos32 {
> +	s32 	mt_blkno;
> +};
> +#define	MTIOCPOS32	_IOR('m', 3, struct mtpos32)
> +
> +static inline int put_user_mtget(void __user *u, struct mtget *k)
> +{
> +	struct mtget32 k32 = {
> +		.mt_type   = k->mt_type,
> +		.mt_resid  = k->mt_resid,
> +		.mt_dsreg  = k->mt_dsreg,
> +		.mt_gstat  = k->mt_gstat,
> +		.mt_fileno = k->mt_fileno,
> +		.mt_blkno  = k->mt_blkno,
> +	};

mt_erreg is missing here.

