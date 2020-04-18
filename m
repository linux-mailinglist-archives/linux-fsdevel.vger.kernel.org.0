Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F42A1AF3B3
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Apr 2020 20:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728065AbgDRSrL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Apr 2020 14:47:11 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:52556 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725824AbgDRSrH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Apr 2020 14:47:07 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03IIbvof110170;
        Sat, 18 Apr 2020 18:46:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=OMbwDKsG/vOO5AAoxKcfs/BIRelllRhJg9DLfQ0cROg=;
 b=XarPKwUMp7eFpqLRIA+E9xQ6HCh/1NBQo9ytJJXL2GWJvERJWITDG8npsHm0A3vtM/23
 AK2WjOnJN8Q+JnFN5kmACcUtBxWi6ByISqRcwrOTWuEZd5g1XrMTALImUQKyGTaASrZY
 c2gTo/F7Rtr2Bb+UaZJkRthP1d7dqHb1BoQFH/ah6DeWtsupMYIUzN7zvmKJF3TetZ6d
 LxI5gemgWLkr8CdWBGY1u6v3vxXBHogEkemzupqaynwk1+E7X7Nv5chOi5dOmEgXULA4
 ejp8E/PSLZXUmu6Thg9uKe42tMoDDyGAOA4OE0x2XWAKh2hrsC/CzOSCEc1P348Xlqib Sw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 30g6dwr26c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 18 Apr 2020 18:46:05 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03IIbSC4149674;
        Sat, 18 Apr 2020 18:46:04 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 30fqka563c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 18 Apr 2020 18:46:04 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 03IIjvac015073;
        Sat, 18 Apr 2020 18:45:57 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 18 Apr 2020 11:45:57 -0700
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH 6/9] nfsd: fix empty-body warning in nfs4state.c
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20200418184111.13401-7-rdunlap@infradead.org>
Date:   Sat, 18 Apr 2020 14:45:55 -0400
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, linux-nvdimm@lists.01.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        Zzy Wysm <zzy@zzywysm.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <CDCF7717-7CBC-47CA-9E83-3A18ECB3AB89@oracle.com>
References: <20200418184111.13401-1-rdunlap@infradead.org>
 <20200418184111.13401-7-rdunlap@infradead.org>
To:     Randy Dunlap <rdunlap@infradead.org>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9595 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 mlxscore=0 malwarescore=0 phishscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004180156
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9595 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 lowpriorityscore=0
 malwarescore=0 phishscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 suspectscore=0 mlxlogscore=999 clxscore=1011 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004180156
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Apr 18, 2020, at 2:41 PM, Randy Dunlap <rdunlap@infradead.org> =
wrote:
>=20
> Fix gcc empty-body warning when -Wextra is used:
>=20
> ../fs/nfsd/nfs4state.c:3898:3: warning: suggest braces around empty =
body in an =E2=80=98else=E2=80=99 statement [-Wempty-body]
>=20
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: "J. Bruce Fields" <bfields@fieldses.org>
> Cc: Chuck Lever <chuck.lever@oracle.com>
> Cc: linux-nfs@vger.kernel.org

I have a patch in my queue that addresses this particular warning,
but your change works for me too.

Acked-by: Chuck Lever <chuck.lever@oracle.com>

Unless Bruce objects.


> ---
> fs/nfsd/nfs4state.c |    3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> --- linux-next-20200417.orig/fs/nfsd/nfs4state.c
> +++ linux-next-20200417/fs/nfsd/nfs4state.c
> @@ -34,6 +34,7 @@
>=20
> #include <linux/file.h>
> #include <linux/fs.h>
> +#include <linux/kernel.h>
> #include <linux/slab.h>
> #include <linux/namei.h>
> #include <linux/swap.h>
> @@ -3895,7 +3896,7 @@ nfsd4_setclientid(struct svc_rqst *rqstp
> 		copy_clid(new, conf);
> 		gen_confirm(new, nn);
> 	} else /* case 4 (new client) or cases 2, 3 (client reboot): */
> -		;
> +		do_empty();
> 	new->cl_minorversion =3D 0;
> 	gen_callback(new, setclid, rqstp);
> 	add_to_unconfirmed(new);

--
Chuck Lever



