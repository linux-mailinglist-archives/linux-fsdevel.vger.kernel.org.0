Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3002A295FF1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Oct 2020 15:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2894744AbgJVNYI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Oct 2020 09:24:08 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:36890 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2894720AbgJVNYI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Oct 2020 09:24:08 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09MDL1uK189645;
        Thu, 22 Oct 2020 13:23:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=xAviNkMkwfMezgopS+E/VrXKnKQaSf/bgAjZ1auw6vU=;
 b=YX80MFtEDhlIUo9qAubWoUTxAGDQJ5eeIElkxog+vUjyKjKA6xO1XVuHGvJexzv8sYnN
 Fs8KI6WS7BmsOE2R0OwsnAPysY5F5mTJr9/vfWOoPUT4noOPFfr5GSkVvFuzDhNREk1+
 P4LS1/U+Z5xvx4XreAXU1R7VF+RQXOkI9X7Mjhzvt9wZX8Wi7dlsvZ3rYJLpanOOFMpf
 5cWOEAvdyZBpZOO5EDj/rIQYx/TeSdP16vSUUbAWAZF4TwFfBfwB+qbAeHBDCu0LktCP
 4buEF/EUuxY4zSvf6zb49vOQ4M6l9ytjjpv7qpEJr4JJYsr5Fko4+KCqybYo2MGnWM5D pg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 34ak16p5vc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 22 Oct 2020 13:23:40 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09MDG0b2088299;
        Thu, 22 Oct 2020 13:23:40 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 34ak19uq1c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Oct 2020 13:23:39 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 09MDNZ06012298;
        Thu, 22 Oct 2020 13:23:35 GMT
Received: from dhcp-10-65-160-149.vpn.oracle.com (/10.65.160.149)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 22 Oct 2020 06:23:35 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.0.3.2.82\))
Subject: Re: kernel BUG at mm/page-writeback.c:2241 [
 BUG_ON(PageWriteback(page); ]
From:   William Kucharski <william.kucharski@oracle.com>
In-Reply-To: <20201022004906.GQ20115@casper.infradead.org>
Date:   Thu, 22 Oct 2020 07:23:33 -0600
Cc:     Qian Cai <cai@lca.pw>, Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-mm@kvack.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <361D9B8E-CE8F-4BA0-8076-8384C2B7E860@oracle.com>
References: <645a3f332f37e09057c10bc32f4f298ce56049bb.camel@lca.pw>
 <20201022004906.GQ20115@casper.infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
X-Mailer: Apple Mail (2.3654.0.3.2.82)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9781 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=73 mlxscore=0 phishscore=0
 spamscore=0 adultscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010220090
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9781 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0
 priorityscore=1501 clxscore=1011 malwarescore=0 mlxscore=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 mlxlogscore=999
 suspectscore=73 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010220090
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Oct 21, 2020, at 6:49 PM, Matthew Wilcox <willy@infradead.org> =
wrote:
>=20
> On Wed, Oct 21, 2020 at 08:30:18PM -0400, Qian Cai wrote:
>> Today's linux-next starts to trigger this wondering if anyone has any =
clue.
>=20
> I've seen that occasionally too.  I changed that BUG_ON to =
VM_BUG_ON_PAGE
> to try to get a clue about it.  Good to know it's not the THP patches
> since they aren't in linux-next.
>=20
> I don't understand how it can happen.  We have the page locked, and =
then we do:
>=20
>                        if (PageWriteback(page)) {
>                                if (wbc->sync_mode !=3D WB_SYNC_NONE)
>                                        wait_on_page_writeback(page);
>                                else
>                                        goto continue_unlock;
>                        }
>=20
>                        VM_BUG_ON_PAGE(PageWriteback(page), page);
>=20
> Nobody should be able to put this page under writeback while we have =
it
> locked ... right?  The page can be redirtied by the code that's =
supposed
> to be writing it back, but I don't see how anyone can make =
PageWriteback
> true while we're holding the page lock.

Looking at __test_set_page_writeback(), I see that it (and most other
callers to lock_page_memcg()) do the following:

  lock_page_memcg(page)

  /* do other stuff */

  ret =3D TestSetPageWriteback(page);

  /* do more stuff */

  unlock_page_memcg(page)

yet lock_page_memcg() does have a few cases where it can (silently)
return NULL to indicate an error.

Only test_clear_page_writeback() actually saves off the return value
(but it too never bothers to check whether it is NULL or not.)

Could it be one of those error conditions is occurring leading to no
lock actually being taken?

The conditions would be extremely rare, but it feels wrong not to check
somewhere:

	  struct page *head =3D compound_head(page); /* rmap on tail =
pages */

[ ... ]

          if (mem_cgroup_disabled())
              return NULL;
  again:
          memcg =3D head->mem_cgroup;
          if (unlikely(!memcg))
                  return NULL;










