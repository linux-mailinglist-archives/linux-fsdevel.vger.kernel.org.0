Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6803560A4E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jun 2022 21:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbiF2T3R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Jun 2022 15:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbiF2T3Q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Jun 2022 15:29:16 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A68838A5;
        Wed, 29 Jun 2022 12:29:15 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25TJ3BXS032642;
        Wed, 29 Jun 2022 19:28:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=g/a4Jgmw6y+Ay8b4bW+6mG3vLSHmUMX3S3jDXTVXAVs=;
 b=UqUmsWyGBBBPA4GPf5EXNgwnKp3uqlTJCAVsa1Gbv8z5Ywzjws86zkHyPSyg73a+oJlA
 kmdnKWw22v7EcYBYsT+3Tj/MytnLXXQkFtHzcPR16lOuUjjBwtOd2nosU4MzX/7Lb72G
 pNvBFF2a1iWXle7hJ7ff2I2+SVNrDMXsipeNCa5m4ciiZCPSy0SnxQ2BOt95TQll1fa0
 2ZnUPhx/L0oiW4vZGG+81tEqAzA23ziMaV7SaoWGCYh3jnL2CQlZ91QzT6aPRkbfrt8v
 Fj79PTsy1gNFhYKZvy6IJLJ45r2oIJqlGHUYEK2equbgRNKRfNAHAvZROypRNX/CqDfh 6Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h0vjb8r4q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Jun 2022 19:28:59 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 25TJ3Tp2033450;
        Wed, 29 Jun 2022 19:28:58 GMT
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h0vjb8r4f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Jun 2022 19:28:58 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25TJKp6c010666;
        Wed, 29 Jun 2022 19:28:57 GMT
Received: from b03cxnp07027.gho.boulder.ibm.com (b03cxnp07027.gho.boulder.ibm.com [9.17.130.14])
        by ppma02wdc.us.ibm.com with ESMTP id 3gwt0a2pcm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Jun 2022 19:28:57 +0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp07027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25TJSuh320054424
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Jun 2022 19:28:56 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A9A3B6A054;
        Wed, 29 Jun 2022 19:28:56 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 46E186A047;
        Wed, 29 Jun 2022 19:28:55 +0000 (GMT)
Received: from farman-thinkpad-t470p (unknown [9.163.2.135])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 29 Jun 2022 19:28:55 +0000 (GMT)
Message-ID: <f8c22cd08f8507ae6797edcccd51f902f2bd39df.camel@linux.ibm.com>
Subject: Re: [PATCHv6 11/11] iomap: add support for dma aligned direct-io
From:   Eric Farman <farman@linux.ibm.com>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Halil Pasic <pasic@linux.ibm.com>, Keith Busch <kbusch@fb.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        axboe@kernel.dk, Kernel Team <Kernel-team@fb.com>, hch@lst.de,
        bvanassche@acm.org, damien.lemoal@opensource.wdc.com,
        ebiggers@kernel.org, pankydev8@gmail.com
Date:   Wed, 29 Jun 2022 15:28:54 -0400
In-Reply-To: <Yryi8VXTjDu1R1Zc@kbusch-mbp>
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
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: S9nhS05_P_KNA8R7JJlY8krihqwJKS9c
X-Proofpoint-ORIG-GUID: UD6TsGL3vpI9DihHEkoPXdY6nP4YukbZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-29_20,2022-06-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 impostorscore=0 malwarescore=0 mlxlogscore=999 clxscore=1015 bulkscore=0
 priorityscore=1501 phishscore=0 suspectscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206290067
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2022-06-29 at 13:07 -0600, Keith Busch wrote:
> On Wed, Jun 29, 2022 at 02:04:47PM -0400, Eric Farman wrote:
> > s390 dasd
> > 
> > This made me think to change my rootfs, and of course the problem
> > goes
> > away once on something like a SCSI volume.
> > 
> > So crawling through the dasd (instead of virtio) driver and I
> > finally
> > find the point where a change to dma_alignment (which you mentioned
> > earlier) would actually fit.
> > 
> > Such a change fixes this for me, so I'll run it by our DASD guys.
> > Thanks for your help and patience.
> 
> I'm assuming there's some driver or device requirement that's making
> this
> necessary. Is the below driver change what you're looking for? 

Yup, that's exactly what I have (in dasd_eckd.c) and indeed gets things
working again. Need to scrounge up some FBA volumes to test that
configuration and the change there.

> If so, I think
> you might want this regardless of this direct-io patch just because
> other
> interfaces like blk_rq_map_user_iov() and blk_rq_aligned() align to
> it.

Good point.

> 
> ---
> diff --git a/drivers/s390/block/dasd_fba.c
> b/drivers/s390/block/dasd_fba.c
> index 60be7f7bf2d1..5c79fb02cded 100644
> --- a/drivers/s390/block/dasd_fba.c
> +++ b/drivers/s390/block/dasd_fba.c
> @@ -780,6 +780,7 @@ static void dasd_fba_setup_blk_queue(struct
> dasd_block *block)
>  	/* With page sized segments each segment can be translated into
> one idaw/tidaw */
>  	blk_queue_max_segment_size(q, PAGE_SIZE);
>  	blk_queue_segment_boundary(q, PAGE_SIZE - 1);
> +	blk_queue_dma_alignment(q, PAGE_SIZE - 1);
>  
>  	q->limits.discard_granularity = logical_block_size;
>  
> --

