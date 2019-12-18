Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD93125490
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2019 22:25:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbfLRVZv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Dec 2019 16:25:51 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:48002 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbfLRVZu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Dec 2019 16:25:50 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBIL9ubq024580;
        Wed, 18 Dec 2019 21:25:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2019-08-05;
 bh=o0Ec6O81R9S/s1aFgVFSRf2acsKPiDwr5VOnJ+jfnv8=;
 b=mMpmzkws+v31mLu/VlvZnAUKkcGHP6plUjCvB2GGXXq3LAAtECCEK/gdYL4ExBxv0S9n
 /jEtn3HJ7VVEUYv+EXkztASzutP5ltutquVsTZHg9G/Zjl9aEQNq3t4kILILagMb9AIu
 dq0QY9pIPV8z3Z4ITvf1c35zRzvN49mqesNdu+PVp89NlF+ouc9UkUY5GWlHFQ6Y6kQ6
 w2cRE0WKJ/kpqjgxwtB/hH2Scis+xrvMPCK671uOlw8BiugMNc69vg2feShxxd2AcO4b
 UrarR2dgvf8NVMMoZdTs/VL5h/oiDsYwCTyAuUcnfo3gWbo4QVTQA3pmDRcFISrAWebt VA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2wvq5urcae-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Dec 2019 21:25:32 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBILAtB4186597;
        Wed, 18 Dec 2019 21:25:32 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2wyut48eeq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Dec 2019 21:25:31 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xBILPVFJ003758;
        Wed, 18 Dec 2019 21:25:31 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 18 Dec 2019 13:25:31 -0800
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Satya Tangirala <satyat@google.com>, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Kim Boojin <boojin.kim@samsung.com>
Subject: Re: [PATCH v6 2/9] block: Add encryption context to struct bio
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20191218145136.172774-1-satyat@google.com>
        <20191218145136.172774-3-satyat@google.com>
        <20191218212116.GA7476@magnolia>
Date:   Wed, 18 Dec 2019 16:25:28 -0500
In-Reply-To: <20191218212116.GA7476@magnolia> (Darrick J. Wong's message of
        "Wed, 18 Dec 2019 13:21:16 -0800")
Message-ID: <yq1y2v9e37b.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9475 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=981
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912180163
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9475 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912180163
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Darrick,

>> +#ifdef CONFIG_BLK_INLINE_ENCRYPTION
>> +	struct bio_crypt_ctx	*bi_crypt_context;
>> +#endif
>
> This grows struct bio even if we aren't actively using bi_crypt_context,
> and I thought Jens told us to stop making it bigger. :)

Yeah. Why not use the bio integrity plumbing? It was explicitly designed
to attach things to a bio and have them consumed by the device driver.

-- 
Martin K. Petersen	Oracle Linux Engineering
