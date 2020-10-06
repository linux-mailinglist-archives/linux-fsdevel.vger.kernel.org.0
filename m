Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 144412843D0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Oct 2020 03:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726075AbgJFB1S (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Oct 2020 21:27:18 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:49070 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbgJFB1S (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Oct 2020 21:27:18 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0961Aw9P023363;
        Tue, 6 Oct 2020 01:27:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : mime-version :
 content-type; s=corp-2020-01-29;
 bh=+jqH+gCjTnoSMLQMcgMYCzbAm6K826JajoLh0LCFQbI=;
 b=kBYsBI/Wev6VmHfD3XUw3Z/e3GQ92OIPc5QlaI6tTzyoUWPwAai5ga042hsVt0Rn38R4
 7qdxW/uWKkF4hzl36nWSx3q7OUmTZByZLtMSAZ+MWsPMz803GOZILiKsNYXgcKTMg+2r
 HE+mu0QqtFJL4UaNR4ivKa3KNOmuFfVcDHrGdlvGROMmUR3UkJtgRSYnZwJ8tBDfhECm
 Z4oabjNVimJyJMBfOyPh02Sdfz682d7doZDaQUMPW43YO/YzRHUwrxyCO9n0UDFNJWDi
 uqUShxniYcB/WdSwvWxYUibNugu7DhkcaObinMh1pPF7F4lW0gk79GixDrYluGl6WfJw UA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 33ym34ehdt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 06 Oct 2020 01:27:04 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0961BJfm145117;
        Tue, 6 Oct 2020 01:27:04 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 33yyjes89h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Oct 2020 01:27:04 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0961R0l1025382;
        Tue, 6 Oct 2020 01:27:00 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 05 Oct 2020 18:27:00 -0700
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org, dsterba@suse.com, hare@suse.com,
        linux-fsdevel@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH v8 01/41] block: add bio_add_zone_append_page
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1v9fo87tz.fsf@ca-mkp.ca.oracle.com>
References: <cover.1601572459.git.naohiro.aota@wdc.com>
        <dece91bca322ce44bed19f2b0f460fa5ded2e512.1601574234.git.naohiro.aota@wdc.com>
        <yq1k0w8g3rw.fsf@ca-mkp.ca.oracle.com>
        <20201005134319.GA11537@infradead.org>
Date:   Mon, 05 Oct 2020 21:26:57 -0400
In-Reply-To: <20201005134319.GA11537@infradead.org> (Christoph Hellwig's
        message of "Mon, 5 Oct 2020 14:43:19 +0100")
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9765 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 adultscore=0 bulkscore=0
 phishscore=0 mlxlogscore=996 mlxscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010060003
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9765 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 priorityscore=1501
 mlxscore=0 mlxlogscore=999 clxscore=1015 bulkscore=0 spamscore=0
 malwarescore=0 phishscore=0 suspectscore=1 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010060003
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Christoph,

>> max_zone_append_sectors also appears to be gated exclusively by hardware
>> constraints. Is there user-controllable limit in place for append
>> operations?
>
> Zone Append operations can't be split, as they return the first written
> LBA to the caller.  If you'd split it you'd now need to return multiple
> start LBA values.

Yep, this limit would have to be enforced at the top.

Anyway, not sure how important this is given modern drives. I just know
that for our workloads the soft limit is something we almost always end
up tweaking.

-- 
Martin K. Petersen	Oracle Linux Engineering
