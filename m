Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F020D5611E4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jun 2022 07:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231620AbiF3Fpb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jun 2022 01:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbiF3Fpa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jun 2022 01:45:30 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DF5B220C2;
        Wed, 29 Jun 2022 22:45:29 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25U5j2ke032089;
        Thu, 30 Jun 2022 05:45:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=VoxilQHYTOvtN/3xYTNYRHQYcSVuN2/FdHfQD65sdkE=;
 b=d4uMpM+zD8s4sRL+7/tZGukn5sgY+YL9jWAcRI261n4LlTykRbD5zqd222RMcf0cODZC
 kNMhJpkMMDaSLOtFkBomv8VfLUT+kSk7tJb4/uSv1loQrFlUtR3ji3aBptTAGkq7pPOR
 xdRQ04wxwz1vf7jWAC1mG3tIKPb3HwFabvZNIMD/40g5JQaUZ6ATyynAwkvQo9HcpLrN
 2RwK1LgoV4cQ51xm4OLuIrzSXR+vnrb2YkHcf6yLpZQKKTfpEual9pK6h1KnvCAzUtBt
 rOh0E/fuDR5LlEtGbVJoZ5QFMWUe/WOYNvqoWwCVFm6u42irhsxV22owQGrXu2uaVN2O qA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h15y60064-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Jun 2022 05:45:12 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 25U5jB3w032377;
        Thu, 30 Jun 2022 05:45:11 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h15y60054-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Jun 2022 05:45:11 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25U5bH1W018623;
        Thu, 30 Jun 2022 05:45:09 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06ams.nl.ibm.com with ESMTP id 3gwsmj7js9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Jun 2022 05:45:08 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25U5j5R814418258
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Jun 2022 05:45:05 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9C6F34C04A;
        Thu, 30 Jun 2022 05:45:05 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DF1524C04E;
        Thu, 30 Jun 2022 05:45:04 +0000 (GMT)
Received: from [9.171.88.50] (unknown [9.171.88.50])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 30 Jun 2022 05:45:04 +0000 (GMT)
Message-ID: <cffe618e-e104-ef55-70aa-efda904a9c21@linux.ibm.com>
Date:   Thu, 30 Jun 2022 07:45:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCHv6 11/11] iomap: add support for dma aligned direct-io
Content-Language: en-US
To:     Keith Busch <kbusch@kernel.org>, Eric Farman <farman@linux.ibm.com>
Cc:     Halil Pasic <pasic@linux.ibm.com>, Keith Busch <kbusch@fb.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, axboe@kernel.dk,
        Kernel Team <Kernel-team@fb.com>, hch@lst.de,
        bvanassche@acm.org, damien.lemoal@opensource.wdc.com,
        ebiggers@kernel.org, pankydev8@gmail.com,
        Stefan Haberland <sth@linux.ibm.com>,
        =?UTF-8?Q?Jan_H=c3=b6ppner?= <hoeppner@linux.ibm.com>
References: <YrS6/chZXbHsrAS8@kbusch-mbp>
 <e2b08a5c452d4b8322566cba4ed33b58080f03fa.camel@linux.ibm.com>
 <e0038866ac54176beeac944c9116f7a9bdec7019.camel@linux.ibm.com>
 <c5affe3096fd7b7996cb5fbcb0c41bbf3dde028e.camel@linux.ibm.com>
 <YrnOmOUPukGe8xCq@kbusch-mbp.dhcp.thefacebook.com>
 <20220628110024.01fcf84f.pasic@linux.ibm.com>
 <83e65083890a7ac9c581c5aee0361d1b49e6abd9.camel@linux.ibm.com>
 <a765fff67679155b749aafa90439b46ab1269a64.camel@linux.ibm.com>
 <YrvMY7oPnhIka4IF@kbusch-mbp.dhcp.thefacebook.com>
 <f723b1c013d78cae2f3236eba0d14129837dc7b0.camel@linux.ibm.com>
 <Yryi8VXTjDu1R1Zc@kbusch-mbp>
From:   Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <Yryi8VXTjDu1R1Zc@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: r1VTj3oQr0NpGzaHgrEEIFoeroqGhtRV
X-Proofpoint-ORIG-GUID: kQnHM4h2VuTXtiCC-vVXCW0L0xPDoJgR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-30_02,2022-06-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 bulkscore=0 clxscore=1011 mlxscore=0 mlxlogscore=999
 lowpriorityscore=0 impostorscore=0 adultscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206300020
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

CCing Stefan, Jan.

Below is necessary (in dasd-eckd.c) to make kvm boot working again (and this seems to be the right thing anyway).

Am 29.06.22 um 21:07 schrieb Keith Busch:
> On Wed, Jun 29, 2022 at 02:04:47PM -0400, Eric Farman wrote:
>> s390 dasd
>>
>> This made me think to change my rootfs, and of course the problem goes
>> away once on something like a SCSI volume.
>>
>> So crawling through the dasd (instead of virtio) driver and I finally
>> find the point where a change to dma_alignment (which you mentioned
>> earlier) would actually fit.
>>
>> Such a change fixes this for me, so I'll run it by our DASD guys.
>> Thanks for your help and patience.
> 
> I'm assuming there's some driver or device requirement that's making this
> necessary. Is the below driver change what you're looking for? If so, I think
> you might want this regardless of this direct-io patch just because other
> interfaces like blk_rq_map_user_iov() and blk_rq_aligned() align to it.
> 
> ---
> diff --git a/drivers/s390/block/dasd_fba.c b/drivers/s390/block/dasd_fba.c
> index 60be7f7bf2d1..5c79fb02cded 100644
> --- a/drivers/s390/block/dasd_fba.c
> +++ b/drivers/s390/block/dasd_fba.c
> @@ -780,6 +780,7 @@ static void dasd_fba_setup_blk_queue(struct dasd_block *block)
>   	/* With page sized segments each segment can be translated into one idaw/tidaw */
>   	blk_queue_max_segment_size(q, PAGE_SIZE);
>   	blk_queue_segment_boundary(q, PAGE_SIZE - 1);
> +	blk_queue_dma_alignment(q, PAGE_SIZE - 1);
>   
>   	q->limits.discard_granularity = logical_block_size;
>   
> --
