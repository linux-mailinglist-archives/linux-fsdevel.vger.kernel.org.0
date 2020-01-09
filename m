Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B97F135209
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2020 04:41:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727785AbgAIDlQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jan 2020 22:41:16 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:54784 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726913AbgAIDlQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jan 2020 22:41:16 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 0093Y91f165213;
        Thu, 9 Jan 2020 03:40:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2019-08-05;
 bh=d286TUXfSVAxHnl9z2DyeRiz3PyfuYs/FVhffcmdrHI=;
 b=qBjXF9EEZvVjREBQqOD3nS6joNQ8l/CSfkq4zKjHaqIx8/X7IZD04wuMDFHN2trWNTGd
 QoTryWftjxWUVg8DU1R+kRczakqJBoKgetQ8TBOSPBefI3gmE5edCg04UvqdTz5MWYqd
 R76CHK9kDCD4rhD2blijFxJmD3N3AQie1mM5vh/oangx5yw7VmOmJSBIAGOQAutcEjfm
 WjwtitDt+Z8llvkwc6kkAxpxaQ/RmBjnVZHVKO2ax4FbSSUJ3W4cCyyD8Sg4DZxyU9PU
 nQvYEMCtNFtntHLvu06/h/W3hUdX/G6ouabHTNuWZU0DB2P587n4ViSqtyuse2HuzZkZ aA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2xajnq83nd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Jan 2020 03:40:36 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 0093XAkf107048;
        Thu, 9 Jan 2020 03:40:35 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2xdmrx90ua-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Jan 2020 03:40:35 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0093eXBk007672;
        Thu, 9 Jan 2020 03:40:33 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 08 Jan 2020 19:40:33 -0800
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Eric Biggers <ebiggers@kernel.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Satya Tangirala <satyat@google.com>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Kim Boojin <boojin.kim@samsung.com>
Subject: Re: [PATCH v6 2/9] block: Add encryption context to struct bio
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20191218145136.172774-1-satyat@google.com>
        <20191218145136.172774-3-satyat@google.com>
        <20191218212116.GA7476@magnolia> <yq1y2v9e37b.fsf@oracle.com>
        <20191218222726.GC47399@gmail.com> <yq1fthhdttv.fsf@oracle.com>
        <20200108140730.GC2896@infradead.org>
Date:   Wed, 08 Jan 2020 22:40:30 -0500
In-Reply-To: <20200108140730.GC2896@infradead.org> (Christoph Hellwig's
        message of "Wed, 8 Jan 2020 06:07:30 -0800")
Message-ID: <yq1ftgpxpox.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9494 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=598
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001090033
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9494 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=659 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001090033
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Christoph,

>> Absolutely. That's why it's a union. Putting your stuff there is a
>> prerequisite as far as I'm concerned. No need to grow the bio when the
>> two features are unlikely to coexist. We can revisit that later should
>> the need arise.
>
> With NVMe key per I/O support some form of inline encryption and PI are
> very likely to be used together in the not too far future.

I don't disagree that we'll have to manage coexistence eventually. Hence
my comments about being able to chain multiple things to a bio.

In the immediate term, though, I think it makes sense to leverage the
integrity pointer to avoid growing struct bio.

-- 
Martin K. Petersen	Oracle Linux Engineering
