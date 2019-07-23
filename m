Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3971E720D2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jul 2019 22:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731401AbfGWUdd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Jul 2019 16:33:33 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49138 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729564AbfGWUdd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Jul 2019 16:33:33 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6NKIMSQ059165;
        Tue, 23 Jul 2019 16:33:31 -0400
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2tx8se1b1n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Jul 2019 16:33:31 -0400
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x6NKFLTQ015329;
        Tue, 23 Jul 2019 20:33:30 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma01wdc.us.ibm.com with ESMTP id 2tx61ms59f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Jul 2019 20:33:30 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x6NKXUsL48562614
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Jul 2019 20:33:30 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3ECFA112066;
        Tue, 23 Jul 2019 20:33:30 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 24490112062;
        Tue, 23 Jul 2019 20:33:29 +0000 (GMT)
Received: from LeoBras (unknown [9.85.207.175])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 23 Jul 2019 20:33:28 +0000 (GMT)
Message-ID: <ae19f8ddc770135572323dd431d0efbe3e419582.camel@linux.ibm.com>
Subject: Question about vmsplice + SPLICE_F_GIFT
From:   Leonardo Bras <leonardo@linux.ibm.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>
Date:   Tue, 23 Jul 2019 17:33:24 -0300
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-ZgaTWFQtsP42ufrT2Umv"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-23_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1031 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1907230207
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--=-ZgaTWFQtsP42ufrT2Umv
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello everybody,

I am not sure if this is the right place to be asking this. If is not,
I apologize for the inconvenience. Also, please tell me where is a
better way to as these questions.

I am trying to create a basic C code to test vmsplice + SPLICE_F_GIFT
for moving memory pages between two processes without copying.

I have followed the man pages and several recipes across the web, but I
could not reproduce it yet.

Basically, I am doing:
Sending process:
- malloc + memcpy for generating pages to transfer
- vmsplice with SPLICE_F_GIFT sending over named pipe (in a loop)
Receiving process:
- Create mmaped file to receive the pages
- splice with SPLICE_F_MOVE receiving from named pipe (in a loop)

I have seen the SPLICE_F_MOVE being used on steal ops from the
'pipebuffer', but I couldn't find a way to call it from splice.

Questions:=20
It does what I think it does? (reassign memory pages from a process to
another)
If so, does page gifting still works?
If so, is there a basic recipe to test it's workings?

Thank you for reading,

Leonardo Br=C3=A1s=20

--=-ZgaTWFQtsP42ufrT2Umv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEMdeUgIzgjf6YmUyOlQYWtz9SttQFAl03bxQACgkQlQYWtz9S
ttSMpQ//fs8clOXz8ga616r2sL5Pc57j0D347HrmLVymwaxMMifG/qo4aX9b3n42
8ORpK4ZS1EQ+V5b4BE2oRNdn6I3rvJgPMPmnh+38KZJBXqdj+adKPpUmAexFPNat
AXqOMkgZGblE16QF0bsCe+HmNwN12Kz3hTB3ua5Bweot6VWqR22ZV93WPm0siYms
ny1cA4O/EDNz0ktjx5pDXgCu5MrtuRwZ7vqtu/qMLajLm1ZXzTRVOkvKcFYPT4Eh
tncXvj/3SZfJyAl+veuwbZ5o3DLAtGRWa20WBfs56FN97kMmbWR7eFjuYsTKfy53
5XkHdf6zE+EkIc2qaz9fwQ61Kd8al/T7qFrL8d/9TQ5mJ0Yfv2s+w+ulj8YCuVpu
PeFKz7kVSVNXvCHnX/p3LGd1zKbh7WJqNE6tKh0BgTyAwROI90KC6VVGCBryhXg5
LAPLufVsoHxHMXpEm74wwPwR/vQnoGfL95kbVwJqU2V7ccqA4vgX8IFk8TZBO420
IpcChcAkznXNI2ZpJMphs7siTJX5JAEKuxVmQBzBq+ceqvpe/ZKJ+bPbdjVLZAkl
hGRqv4kGPUAh2uSFJfaMB3nyhRyTqcMaROg56C8e7S0gtE7PPdgRnr6v1NR6KS+K
FPfx7X6tNRYodJSW+xnIsWH8rZ0cadTMPoL8GsVhFkZK9Cx4+XY=
=PCPk
-----END PGP SIGNATURE-----

--=-ZgaTWFQtsP42ufrT2Umv--

