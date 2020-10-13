Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA1928CF2D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Oct 2020 15:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728322AbgJMNcl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Oct 2020 09:32:41 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:55396 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727448AbgJMNcl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Oct 2020 09:32:41 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09DDTk1e074238;
        Tue, 13 Oct 2020 13:32:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=Vm4B4Ns9RFZduzYbWzc5CEBgid2fbz26ZcCyorFJ2zs=;
 b=N2SvjOoDMviUQr4w4eY8HbfgzXnJSqhtlJd6WK1OFLiR5LB1W7J3dCaK/Vo+v6jiA1jS
 wzAm1wNVOZ/lVXkhZ23oBL7RkpxN6tHyiaqQJsMbHFCJJa8aT8IY9B7QmEcSQ17/b60u
 HT32RyJGz6EFlzOu1wYp8nGCBPSvmqsBSNxNuoZQ0XZFrxxpUzS53MPfrHDBtZ3d0nVu
 ZzE+VTW3a4qtDS1RWkcfOFpKUl2t7+fbwhbANwrC7R3kmoILlTNw8nGXPqGDNpixIEbS
 6nUZRokUQYDKujdrgGZTQpXR0RhRMpLnnxsvFkYEemcBYXE0UPNmtKpNXgMvSGYep5P0 vg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 343vae8h0y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 13 Oct 2020 13:32:26 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09DDUXLL109855;
        Tue, 13 Oct 2020 13:32:26 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 343pvwbxes-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Oct 2020 13:32:26 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 09DDWOpI027076;
        Tue, 13 Oct 2020 13:32:24 GMT
Received: from [192.168.0.110] (/73.243.10.6)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 13 Oct 2020 06:32:24 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.0.3.2.52\))
Subject: Re: [PATCH 0/3] Wait for I/O without holding a page reference
From:   William Kucharski <william.kucharski@oracle.com>
In-Reply-To: <20201013030008.27219-1-willy@infradead.org>
Date:   Tue, 13 Oct 2020 07:32:23 -0600
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Mel Gorman <mgorman@techsingularity.net>
Content-Transfer-Encoding: quoted-printable
Message-Id: <5EEF6D22-639C-492E-BF81-C6239D68ABFD@oracle.com>
References: <20201013030008.27219-1-willy@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
X-Mailer: Apple Mail (2.3654.0.3.2.52)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9772 signatures=668681
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 bulkscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010130101
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9772 signatures=668681
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 clxscore=1011
 impostorscore=0 phishscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 mlxscore=0 suspectscore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010130101
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Oct 12, 2020, at 9:00 PM, Matthew Wilcox (Oracle) =
<willy@infradead.org> wrote:
>=20
> The upcoming THP patchset keeps THPs Uptodate at all times unless we
> hit an I/O error.  So I have a patch which induces I/O errors in 10%
> of readahead I/Os in order to test the fallback path.  It hits a
> problem with xfstests generic/273 which has 500 threads livelocking
> trying to split the THP.  This patchset fixes that livelock and
> takes 21 lines out of generic_file_buffered_read().
>=20
> Matthew Wilcox (Oracle) (3):
>  mm: Pass a sleep state to put_and_wait_on_page_locked
>  mm/filemap: Don't hold a page reference while waiting for unlock
>  mm: Inline __wait_on_page_locked_async into caller
>=20
> include/linux/pagemap.h |   3 +-
> mm/filemap.c            | 129 +++++++++++++++-------------------------
> mm/huge_memory.c        |   4 +-
> mm/migrate.c            |   4 +-
> 4 files changed, 52 insertions(+), 88 deletions(-)
>=20
> --=20
> 2.28.0

For the series:

Reviewed-by: William Kucharski <william.kucharski@oracle.com>

