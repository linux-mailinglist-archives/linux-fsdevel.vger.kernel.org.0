Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E886A7952
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2019 05:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727805AbfIDDbp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Sep 2019 23:31:45 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:46922 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727374AbfIDDbp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Sep 2019 23:31:45 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x843OxvF181183;
        Wed, 4 Sep 2019 03:30:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2019-08-05; bh=/yozfkmsZkCl6GVHGm2yICi3pPNQQonPColbnD8GEnI=;
 b=ALbQ/r385Oq6bKNTcHJTr4qOuM/Dmuljrqkv6711uhQOyTbHPsHQVyGWkTm4bVziiZXz
 v8iHJXOxYeBm6S8thLZgdQnhXPDxFOxAMEwEQzQ30XD3rZw8icS9Hyh2eNkWja0W9cxs
 ufa/t8thHHg70nv1NgkTXhVxqZa2PcgBm0156ouPcoXp8uAhXC5ehHqmi1FRHVf6Y4vv
 bz6EW+90Gj9e4m/umInsLr2pCQB+Qrgc9P2hqiLVhOvS6t7ahy6hr7waSAEytdaRcaDa
 bx0qxTfXJsf2nyYBaGjpg2POPKfUJnM2hPHh5swEiyEvpzXjHYygEqZPB/A34T5WLOVa BQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2ut59r013e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Sep 2019 03:30:34 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x843SbjG122606;
        Wed, 4 Sep 2019 03:30:33 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2us5phkdk2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Sep 2019 03:30:33 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x843UWVU023334;
        Wed, 4 Sep 2019 03:30:32 GMT
Received: from [192.168.0.110] (/73.243.10.6)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 03 Sep 2019 20:30:31 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3578.1\))
Subject: Re: [PATCH v5 1/2] mm: Allow the page cache to allocate large pages
From:   William Kucharski <william.kucharski@oracle.com>
In-Reply-To: <20190903115748.GS14028@dhcp22.suse.cz>
Date:   Tue, 3 Sep 2019 21:30:30 -0600
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Bob Kasten <robert.a.kasten@intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Chad Mynhier <chad.mynhier@oracle.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Johannes Weiner <jweiner@fb.com>,
        Matthew Wilcox <willy@infradead.org>
Content-Transfer-Encoding: 7bit
Message-Id: <68E123A9-22A8-40ED-B2ED-897FC02D7D75@oracle.com>
References: <20190902092341.26712-1-william.kucharski@oracle.com>
 <20190902092341.26712-2-william.kucharski@oracle.com>
 <20190903115748.GS14028@dhcp22.suse.cz>
To:     Michal Hocko <mhocko@kernel.org>
X-Mailer: Apple Mail (2.3578.1)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9369 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=896
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1909040035
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9369 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=955 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1909040035
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Sep 3, 2019, at 5:57 AM, Michal Hocko <mhocko@kernel.org> wrote:
> 
> On Mon 02-09-19 03:23:40, William Kucharski wrote:
>> Add an 'order' argument to __page_cache_alloc() and
>> do_read_cache_page(). Ensure the allocated pages are compound pages.
> 
> Why do we need to touch all the existing callers and change them to use
> order 0 when none is actually converted to a different order? This just
> seem to add a lot of code churn without a good reason. If anything I
> would simply add __page_cache_alloc_order and make __page_cache_alloc
> call it with order 0 argument.

All the EXISTING code in patch [1/2] is changed to call it with an order
of 0, as you would expect.

However, new code in part [2/2] of the patch calls it with an order of
HPAGE_PMD_ORDER, as it seems cleaner to have those routines operate on
a page, regardless of the order of the page desired.

I certainly can change this as you request, but once again the question
is whether "page" should MEAN "page" regardless of the order desired,
or whether the assumption will always be "page" means base PAGESIZE.

Either approach works, but what is the semantic we want going forward?

Thanks again!


