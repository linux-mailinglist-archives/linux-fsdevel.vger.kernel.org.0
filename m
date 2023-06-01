Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9E3A71983E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Jun 2023 12:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231442AbjFAKEd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Jun 2023 06:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231759AbjFAKER (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Jun 2023 06:04:17 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 807431BC0;
        Thu,  1 Jun 2023 03:02:31 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3518RgB0013360;
        Thu, 1 Jun 2023 10:02:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=9YhZL77hUjojM3sAha0buzcJVPx5TiIbyValSPOlTpM=;
 b=kHlAaDXhkn1zQqBSmwOg8xDX2V5VggyOBAWPRvLa7kkSsGxtVVJTtSpzPfJ1y3cW+yc+
 NI6UMziYeo1SD9Q8WPMR4n80YRurC2R9ne28bNcBknKmiFzrJz62ppgrhfNCBswJfK2z
 m36XK/5MC3GFS8TJ77/S4oJ0EkihtmdvXm1b27Lm8ctaq5c7RruAdGrklsqXz9JQcMZC
 43foSAZg/pLjZ5QdHjd+5X5MBccuY6jS/L3cIxzMS7YdPF7CqFqdRlKpONuvaZG120aR
 L2qvyByPlNRE4q9LZMALeGjhPCeVSW440u3ODAUCSDN4iMr0NLJgrqwSiGiMdJCv0sXh OQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qxnwv0g08-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Jun 2023 10:02:29 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 351A2SWd015318
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 1 Jun 2023 10:02:28 GMT
Received: from [10.217.216.105] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Thu, 1 Jun 2023
 03:02:27 -0700
Message-ID: <27f39698-8b70-52df-3371-338f2de27108@quicinc.com>
Date:   Thu, 1 Jun 2023 15:32:24 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH V1] fuse: Abort the requests under processing queue with a
 spin_lock
Content-Language: en-US
To:     Miklos Szeredi <miklos@szeredi.hu>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230531092643.45607-1-quic_pragalla@quicinc.com>
 <CAJfpegtr4dZkLzWD_ezAbFgTnbYaGDRq4TR1DUzz4AfFLSLJEA@mail.gmail.com>
From:   Pradeep Pragallapati <quic_pragalla@quicinc.com>
In-Reply-To: <CAJfpegtr4dZkLzWD_ezAbFgTnbYaGDRq4TR1DUzz4AfFLSLJEA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: sPjmLtvOwCeNyHSUez6TyW-EhIzoSR4x
X-Proofpoint-ORIG-GUID: sPjmLtvOwCeNyHSUez6TyW-EhIzoSR4x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-01_06,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 suspectscore=0
 bulkscore=0 clxscore=1015 malwarescore=0 impostorscore=0 mlxscore=0
 mlxlogscore=787 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2306010089
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 5/31/2023 5:22 PM, Miklos Szeredi wrote:
> On Wed, 31 May 2023 at 11:26, Pradeep P V K <quic_pragalla@quicinc.com> wrote:
>> There is a potential race/timing issue while aborting the
>> requests on processing list between fuse_dev_release() and
>> fuse_abort_conn(). This is resulting into below warnings
>> and can even result into UAF issues.
> Okay, but...
>
>> [22809.190255][T31644] refcount_t: underflow; use-after-free.
>> [22809.190266][T31644] WARNING: CPU: 2 PID: 31644 at lib/refcount.c:28
>> refcount_warn_saturate+0x110/0x158
>> ...
>> [22809.190567][T31644] Call trace:
>> [22809.190567][T31644]  refcount_warn_saturate+0x110/0x158
>> [22809.190569][T31644]  fuse_file_put+0xfc/0x104
> ...how can this cause the file refcount to underflow?  That would
> imply that fuse_request_end() will be called for the same request
> twice.  I can't see how that can happen with or without the locking
> change.
Please ignore this patch. i overlooked it as list_splice in 
fuse_dev_release() and made the change.
> Do you have a reproducer?

don't have exact/specific steps but i will try to recreate. This is 
observed during stability testing (involves io, reboot, monkey, e.t.c.) 
for 24hrs. So, far this is seen on both 5.15 and 6.1 kernels. Do you 
have any points or speculations to share ?

Thanks,

Pradeep

> Thanks,
> Miklos
