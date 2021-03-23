Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52B0534587E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Mar 2021 08:21:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbhCWHVC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Mar 2021 03:21:02 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:52290 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbhCWHU7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Mar 2021 03:20:59 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12N78pon163839;
        Tue, 23 Mar 2021 07:20:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=+06lCpqdOfejaxVMqAmaOiuZmidiGCUNKfmOlMN9K0g=;
 b=Uubky1p5Wze59pYeTEnRAJ3kw9aF3wdUmLpdMGbC6VgDgekneuUsd1jS7ERkOT+yOSu7
 99DrgZ8ecjIeyfB7cJXr1IZb7Mv1xk/pLuNGEHLfr87kMBlPrqIufyhBKGM6mRQzu3od
 pnRQ2SHAr9Hm5SAe0zyuIeijHF2/UDwo1avxdUuShTLprv5RrunD899VdhrvZezH3cyW
 kYNEqPI6WQFi6F5cUbI7ILUYvIBdBr6nuTEZzYXCIPWWRyZwgIVvQ92BrvKjVzdyrUIZ
 StgZiaox2kngGArg5gdQWuyxLMozlDWtLQMpNIwX72giLmFQmCrmkuKAqcsVSkreVFrl zg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 37d8fr5vcm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Mar 2021 07:20:06 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12N7EfYk014961;
        Tue, 23 Mar 2021 07:20:05 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 37dtyx2nqa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Mar 2021 07:20:04 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 12N7JvvK022969;
        Tue, 23 Mar 2021 07:19:57 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 23 Mar 2021 00:19:56 -0700
Date:   Tue, 23 Mar 2021 10:19:45 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Namjae Jeon <namjae.jeon@samsung.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-cifs@vger.kernel.org,
        linux-cifsd-devel@lists.sourceforge.net, smfrench@gmail.com,
        senozhatsky@chromium.org, hyc.lee@gmail.com,
        viro@zeniv.linux.org.uk, hch@lst.de, hch@infradead.org,
        ronniesahlberg@gmail.com, aurelien.aptel@gmail.com,
        aaptel@suse.com, sandeen@sandeen.net, colin.king@canonical.com,
        rdunlap@infradead.org,
        "'Sergey Senozhatsky'" <sergey.senozhatsky@gmail.com>,
        "'Steve French'" <stfrench@microsoft.com>
Subject: Re: [PATCH 2/5] cifsd: add server-side procedures for SMB3
Message-ID: <20210323071945.GJ1667@kadam>
References: <20210322051344.1706-1-namjae.jeon@samsung.com>
 <CGME20210322052206epcas1p438f15851216f07540537c5547a0a2c02@epcas1p4.samsung.com>
 <20210322051344.1706-3-namjae.jeon@samsung.com>
 <20210322064712.GD1667@kadam>
 <009b01d71f71$9224f4e0$b66edea0$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <009b01d71f71$9224f4e0$b66edea0$@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9931 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103230050
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9931 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 adultscore=0 malwarescore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103230049
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 23, 2021 at 08:17:47AM +0900, Namjae Jeon wrote:
> > > +
> > > +static int
> > > +compare_oid(unsigned long *oid1, unsigned int oid1len,
> > > +	    unsigned long *oid2, unsigned int oid2len) {
> > > +	unsigned int i;
> > > +
> > > +	if (oid1len != oid2len)
> > > +		return 0;
> > > +
> > > +	for (i = 0; i < oid1len; i++) {
> > > +		if (oid1[i] != oid2[i])
> > > +			return 0;
> > > +	}
> > > +	return 1;
> > > +}
> > 
> > Call this oid_eq()?
> Why not compare_oid()? This code is come from cifs.
> I need clear reason to change both cifs/cifsd...
> 

Boolean functions should tell you what they are testing in the name.
Without any context you can't know what if (compare_oid(one, two)) {
means, but if (oid_equal(one, two)) { is readable.

regards,
dan carpenter


