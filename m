Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70A97403DFB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Sep 2021 18:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349999AbhIHQzj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Sep 2021 12:55:39 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44166 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S235666AbhIHQzi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Sep 2021 12:55:38 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 188GXLCL019212;
        Wed, 8 Sep 2021 12:54:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=UFUuMWLVoMZuIsxaszDJEv/XsW5TDiT4te8RaJ+mT0k=;
 b=OA7N13R/reJICTV2DtIPzYzBQAWWLJIzjDTjvNo6JTPZCT3wT6QPwrcaULaHgeSL1bwi
 +aRU4nSehRFCrUH674TBgGCHKhhUVlmIa1L+OC7CY1xH3ExYL2EPaIr+qOfQd6I1rusl
 SngVNUdM3foNGlpW4wJlCc0rRDosfZ2OfydUHnQpbXSvketwLlhMTR1Tu9+azda1e6x8
 5k6poRAkd7Pq38MtBlNJHI0S9Q6vHCJc1EEBTiviNc18feoNu4cpOTBzbZ9jM2qBp/5i
 SWvddobLN7khJZ3Q2W45GbBgTeS23212Vv0UW1VcHnN1HPVdJKjXPsXshduJADVyCSR+ +Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3axyvc289b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Sep 2021 12:54:27 -0400
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 188GYlZa023305;
        Wed, 8 Sep 2021 12:54:27 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3axyvc288h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Sep 2021 12:54:27 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 188Gm4G7022026;
        Wed, 8 Sep 2021 16:54:25 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma02fra.de.ibm.com with ESMTP id 3axcnk3qtj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Sep 2021 16:54:24 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 188GsLVf50790674
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 Sep 2021 16:54:21 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 56D89A406F;
        Wed,  8 Sep 2021 16:54:21 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D65EBA4055;
        Wed,  8 Sep 2021 16:54:20 +0000 (GMT)
Received: from osiris (unknown [9.145.165.20])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed,  8 Sep 2021 16:54:20 +0000 (GMT)
Date:   Wed, 8 Sep 2021 18:54:19 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        linux-s390@vger.kernel.org, linux-mm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v1] hugetlbfs: s390 is always 64bit
Message-ID: <YTjquztIqDE0Ew3A@osiris>
References: <20210908154506.20764-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210908154506.20764-1-david@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: zVAwf6gTfkN1fKu6s0lGD0g_iuDCoh9Q
X-Proofpoint-GUID: loEvSY1R8qvreNBZGroeBSls14zRCJOj
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-08_06:2021-09-07,2021-09-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 priorityscore=1501 bulkscore=0 spamscore=0 suspectscore=0 mlxlogscore=791
 impostorscore=0 phishscore=0 malwarescore=0 mlxscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109080103
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 08, 2021 at 05:45:06PM +0200, David Hildenbrand wrote:
> No need to check for 64BIT. While at it, let's just select
> ARCH_SUPPORTS_HUGETLBFS from arch/s390x/Kconfig.
                                    ^^^^^
s390 :)

> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  arch/s390/Kconfig | 1 +
>  fs/Kconfig        | 3 +--
>  2 files changed, 2 insertions(+), 2 deletions(-)

I'll apply this to the s390 tree. Thanks David!
