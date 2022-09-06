Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC9F5ADC5A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Sep 2022 02:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232924AbiIFA3Y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Sep 2022 20:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiIFA3V (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Sep 2022 20:29:21 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D62A67C97;
        Mon,  5 Sep 2022 17:29:19 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2860PN84029388;
        Tue, 6 Sep 2022 00:29:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=uoUrYGZzi+3lSG2HVCqGrSprixecUzyMBFpaMPP/HDI=;
 b=CdBJFs7Wmbr2Uzueb6exfhqNDJTk+c6uE8PHebVUAbul6nVJ86PHGCt9PtmAjopVwgry
 5bDPExXYuzlNHITEaKYUL1+ggpil7VLO0kZSg4JrWNMAY5/1Nnm5OHk/zxEWx/o8R+PK
 Hb/yyloG2CSwaUWp3m5Xc070gCH1RWFfXaIFEf19xHDeOmIsBWtsLwbeg+B2U7NnTtIr
 +98fBsQr1Qp3Q4H86yW+jcS81Wi4FzgobVhQICtdhIC4kPGwGZkOxc+T347T9X3Qw7mC
 l7dFXO4e8aIC+Nzh8dZTTjUFpzDaH9gEPIBUqWJVlS25hfx6IpFvl+xNkYu4hwZpnPQp xQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jcgu4uqg0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Sep 2022 00:29:16 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2860TFDt001872
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 6 Sep 2022 00:29:15 GMT
Received: from [10.232.65.248] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 5 Sep 2022
 17:29:14 -0700
Message-ID: <29577961-be15-3c33-c8db-5a92405a87f8@quicinc.com>
Date:   Tue, 6 Sep 2022 08:29:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.3
Subject: Re: [PATCH] fuse: fix the deadlock in race of reclaim path with
 kswapd
To:     Miklos Szeredi <miklos@szeredi.hu>
CC:     <linux-fsdevel@vger.kernel.org>, <quic_maow@quicinc.com>,
        <linux-kernel@vger.kernel.org>
References: <20220905071744.8350-1-quic_yingangl@quicinc.com>
 <CAJfpegs6Jbr8eF9ZNycEjfCtJNVQJECjFnOC9-v8WSXHvpWxCg@mail.gmail.com>
Content-Language: en-US
From:   Kassey Li <quic_yingangl@quicinc.com>
In-Reply-To: <CAJfpegs6Jbr8eF9ZNycEjfCtJNVQJECjFnOC9-v8WSXHvpWxCg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ojOd_1wwjhAHQb9mvvW03n801jW1Wy_t
X-Proofpoint-ORIG-GUID: ojOd_1wwjhAHQb9mvvW03n801jW1Wy_t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-05_16,2022-09-05_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 mlxscore=0 malwarescore=0 clxscore=1015 mlxlogscore=576
 adultscore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209060000
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 9/5/2022 9:28 PM, Miklos Szeredi wrote:
> On Mon, 5 Sept 2022 at 09:17, Kassey Li <quic_yingangl@quicinc.com> wrote:
>>
>> Task A wait for writeback, while writeback Task B send request to fuse.
>> Task C is expected to serve this request, here it is in direct reclaim
>> path cause deadlock when system is in low memory.
>>
>> without __GFP_FS in Task_C break throttle_direct_reclaim with an
>> HZ timeout.
>>
>> kswpad (Task_A):                    writeback(Task_B):
>>      __switch_to+0x14c                   schedule+0x70
>>      __schedule+0xb5c                    __fuse_request_send+0x154
>>      schedule+0x70                       fuse_simple_request+0x184
>>      bit_wait+0x18                       fuse_flush_times+0x114
>>      __wait_on_bit+0x74                  fuse_write_inode+0x60
>>      inode_wait_for_writeback+0xa4       __writeback_single_inode+0x3d8
>>      evict+0xa8                          writeback_sb_inodes+0x4c0
>>      iput+0x248                          __writeback_inodes_wb+0xb0
>>      dentry_unlink_inode+0xdc            wb_writeback+0x270
>>      __dentry_kill[jt]+0x110             wb_workfn+0x37c
>>      shrink_dentry_list+0x17c            process_one_work+0x284
>>      prune_dcache_sb+0x5c
>>      super_cache_scan+0x11c
>>      do_shrink_slab+0x248
>>      shrink_slab+0x260
>>      shrink_node+0x678
>>      kswapd+0x8ec
>>      kthread+0x140
>>      ret_from_fork+0x10
>>
>> Task_C:
>>      __switch_to+0x14c
>>      __schedule+0xb5c
>>      schedule+0x70
>>      throttle_direct_reclaim
>>      try_to_free_pages
>>      __perform_reclaim
>>      __alloc_pages_direct_reclaim
>>      __alloc_pages_slowpath
>>      __alloc_pages_nodemask
>>      alloc_pages
>>      fuse_copy_fill+0x168
>>      fuse_dev_do_read+0x37c
>>      fuse_dev_splice_read+0x94
> 
> Should already be fixed in v5.16 by commit 5c791fe1e2a4 ("fuse: make
> sure reclaim doesn't write the inode").
   thanks for this info.
> 
> Thanks,
> Miklos
