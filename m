Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 813CA3462FA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Mar 2021 16:34:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232867AbhCWPeV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Mar 2021 11:34:21 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34962 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232853AbhCWPeB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Mar 2021 11:34:01 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12NFXcFP150155;
        Tue, 23 Mar 2021 11:33:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=YqS3na95Ho535in/dh2q3fs8bdKZ7R+TwkyLJxzgWbA=;
 b=pAeB6mwriUHnYO/APRkVbX4gPJ+/0hA5hMbejcsrUv7i0BxlDO3SaFzh2U37aVJ7mIDb
 SO2Y9C4DA4AvFiQ4ayiDepCsglS6bNPrl2wUWaG6Edouk5OV+wXBmVuUJ35YA38623U+
 m7uxV8egq0HEj8BXL0Wc1eYpnT6j2oAducuCnisq04E9wkH6SZ92HBEdscLYE0Zshr/z
 zDpHinFveEAJ0paHO04H+oidt5wg9iXHxxSUpMeSRgBThkoYyiW97VQshHvAB8wGGjW9
 TNZsRo0aYSN7/eO5csIuAWdnP790IPawqh/uG+Fmsgi+COGq9+BhwfQxASXnAR76rpTw Dg== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0b-001b2d01.pphosted.com with ESMTP id 37fjp18rx1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Mar 2021 11:33:39 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 12NFNMUE014649;
        Tue, 23 Mar 2021 15:33:22 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma02fra.de.ibm.com with ESMTP id 37d9d8sthu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Mar 2021 15:33:22 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 12NFXKaZ19988922
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Mar 2021 15:33:20 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2EAB052051;
        Tue, 23 Mar 2021 15:33:20 +0000 (GMT)
Received: from [9.199.34.65] (unknown [9.199.34.65])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 9BB5C52057;
        Tue, 23 Mar 2021 15:33:15 +0000 (GMT)
Subject: Re: [PATCH v3 01/10] fsdax: Factor helpers to simplify dax fault code
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org
Cc:     darrick.wong@oracle.com, dan.j.williams@intel.com,
        willy@infradead.org, jack@suse.cz, viro@zeniv.linux.org.uk,
        linux-btrfs@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        david@fromorbit.com, hch@lst.de, rgoldwyn@suse.de
References: <20210319015237.993880-1-ruansy.fnst@fujitsu.com>
 <20210319015237.993880-2-ruansy.fnst@fujitsu.com>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Message-ID: <b55aab1e-95d9-108d-9bb3-199f588c0fbe@linux.ibm.com>
Date:   Tue, 23 Mar 2021 21:03:13 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210319015237.993880-2-ruansy.fnst@fujitsu.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-23_07:2021-03-22,2021-03-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 spamscore=0 impostorscore=0 phishscore=0 malwarescore=0 mlxlogscore=999
 adultscore=0 bulkscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103230114
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 3/19/21 7:22 AM, Shiyang Ruan wrote:
> The dax page fault code is too long and a bit difficult to read. And it
> is hard to understand when we trying to add new features. Some of the
> PTE/PMD codes have similar logic. So, factor them as helper functions to
> simplify the code.
> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>   fs/dax.c | 152 ++++++++++++++++++++++++++++++-------------------------
>   1 file changed, 84 insertions(+), 68 deletions(-)
> 

Refactoring & the changes looks good to me.
Feel free to add.

Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>
