Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0AB424D0DF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Aug 2020 10:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbgHUIyJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Aug 2020 04:54:09 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55564 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726243AbgHUIyG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Aug 2020 04:54:06 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07L8X7fK072907;
        Fri, 21 Aug 2020 04:54:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : date : mime-version : in-reply-to : content-type :
 content-transfer-encoding : message-id; s=pp1;
 bh=tMpNeTWf65DjC70rS5HyK/935zN2nZFWJAbrMtoWLWM=;
 b=ROGpziHzLer7q4RxRNMlsIh02QHcsuW4nx++4W55MlAtDvOnm/34MSU8qEoaLAzmD+7w
 nqAjYrE1XeOtfd8QRjezVGQfBhj6Sd0bbGl7Bo751retTKKsInVQwOhtx9QscBOoaYne
 0rY8IHweV1QP7Mo0k7L/MZMzooxmsfqVyBdJlWGwGRiln6UxMRjbz/neUvPF6qZ3bEOw
 b+HXkegr5fRrIG5z2nG0fwUTDXaduQntoBkSWO+/FFsYVwv1fk59mY/82uYE/hUk4ag0
 j93qu64MIdTR5+BTPYz1fVQ4QxOhjkqoIS3wfbfGLBovyc+ehlsOaclW4gqGgD8noq7L ng== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33257sshsd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Aug 2020 04:54:02 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07L8q58q025176;
        Fri, 21 Aug 2020 08:54:00 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06ams.nl.ibm.com with ESMTP id 330tbvtupg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Aug 2020 08:54:00 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07L8rwYK65405230
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Aug 2020 08:53:58 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 16D634C044;
        Fri, 21 Aug 2020 08:53:58 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 93CF64C040;
        Fri, 21 Aug 2020 08:53:56 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.33.217])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 21 Aug 2020 08:53:56 +0000 (GMT)
Subject: Re: [PATCH] iomap: Fix the write_count in iomap_add_to_ioend().
To:     Christoph Hellwig <hch@infradead.org>,
        Anju T Sudhakar <anju@linux.vnet.ibm.com>,
        linux-block@vger.kernel.org
Cc:     darrick.wong@oracle.com, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        willy@infradead.org
References: <20200819102841.481461-1-anju@linux.vnet.ibm.com>
 <20200821060710.GC31091@infradead.org>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Fri, 21 Aug 2020 14:23:55 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200821060710.GC31091@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <20200821085356.93CF64C040@d06av22.portsmouth.uk.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-21_06:2020-08-21,2020-08-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 mlxlogscore=840 suspectscore=0 impostorscore=0 mlxscore=0 adultscore=0
 spamscore=0 clxscore=1011 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008210079
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 8/21/20 11:37 AM, Christoph Hellwig wrote:
> On Wed, Aug 19, 2020 at 03:58:41PM +0530, Anju T Sudhakar wrote:
>> From: Ritesh Harjani <riteshh@linux.ibm.com>
>>
>> __bio_try_merge_page() may return same_page = 1 and merged = 0.
>> This could happen when bio->bi_iter.bi_size + len > UINT_MAX.
>> Handle this case in iomap_add_to_ioend() by incrementing write_count.
>> This scenario mostly happens where we have too much dirty data accumulated.
>>
>> w/o the patch we hit below kernel warning,
> 
> I think this is better fixed in the block layer rather than working
> around the problem in the callers.  Something like this:
> 
> diff --git a/block/bio.c b/block/bio.c
> index c63ba04bd62967..ef321cd1072e4e 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -879,8 +879,10 @@ bool __bio_try_merge_page(struct bio *bio, struct page *page,
>   		struct bio_vec *bv = &bio->bi_io_vec[bio->bi_vcnt - 1];
>   
>   		if (page_is_mergeable(bv, page, len, off, same_page)) {
> -			if (bio->bi_iter.bi_size > UINT_MAX - len)
> +			if (bio->bi_iter.bi_size > UINT_MAX - len) {
> +				*same_page = false;
>   				return false;
> +			}
>   			bv->bv_len += len;
>   			bio->bi_iter.bi_size += len;
>   			return true;
> 

Ya, we had think of that. But what we then thought was, maybe the
API does return the right thing. Meaning, what API says is, same_page is
true, but the page couldn't be merged hence it returned ret = false.
With that thought, we fixed this in the caller.

But agree with you that with ret = false, there is no meaning of
same_page being true. Ok, so let linux-block comment on whether
above also looks good. If yes, I can spin out an official patch with
all details.

-ritesh
