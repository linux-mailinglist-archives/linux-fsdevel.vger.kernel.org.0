Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 253F42BA172
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Nov 2020 05:29:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbgKTE2p (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Nov 2020 23:28:45 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:57116 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbgKTE2p (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Nov 2020 23:28:45 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AK4FOvi170858;
        Fri, 20 Nov 2020 04:28:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=CQqdg7zwdUotsk4N7+R1OvhkjaLayGm28YLdcG9Us9E=;
 b=lblUQJF+dyNY57T7DsamJgz4vE1SjbfsnReqEEREihGRo5/hbgGYyUx3BVXTWT8Xx/D+
 aNGvViIIWC2DdZVAMAmMU3rP2VpQIYUO2O5aqKr1+PpcZcOtyCMCSL/5Y+I2JgQsA57y
 o9Es7hrEJkI+P/tsY5HvVjIlVqAY/Z25UsnMJ3ow6Lu0jhviDlJAfLvXM9gVFT0qOcxC
 dPbGctCDyqdYYqxlMRkAW+X/LIg/YbZcz/t+X44VusUC9oZUCBvX9/YJrr1V8K5f8y49
 /OU2T4rR7sdS0ANCP/Lk1ZrTGhAsB7ri1B/nYH0xAkoAWB3SRH7kt8FDZ3wiC62Zot5r TQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 34t4rb8xc2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 20 Nov 2020 04:28:36 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AK4BPSc136903;
        Fri, 20 Nov 2020 04:28:36 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 34umd2xd1c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Nov 2020 04:28:36 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0AK4SZxt017838;
        Fri, 20 Nov 2020 04:28:35 GMT
Received: from [192.168.1.102] (/39.109.186.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 19 Nov 2020 20:28:35 -0800
Subject: Re: [PATCH v10 09/41] btrfs: disable fallocate in ZONED mode
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
References: <cover.1605007036.git.naohiro.aota@wdc.com>
 <5136fb8ba2a9746bfc55247c93b86e33bdd7eb7b.1605007036.git.naohiro.aota@wdc.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <40d6d755-9b4b-cecf-4596-9510b86049f0@oracle.com>
Date:   Fri, 20 Nov 2020 12:28:29 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <5136fb8ba2a9746bfc55247c93b86e33bdd7eb7b.1605007036.git.naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9810 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 phishscore=0
 spamscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011200028
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9810 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 lowpriorityscore=0 priorityscore=1501
 mlxlogscore=999 adultscore=0 phishscore=0 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011200028
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/11/20 7:26 pm, Naohiro Aota wrote:
> fallocate() is implemented by reserving actual extent instead of
> reservations. This can result in exposing the sequential write constraint
> of host-managed zoned block devices to the application, which would break
> the POSIX semantic for the fallocated file.  To avoid this, report
> fallocate() as not supported when in ZONED mode for now.
> 
> In the future, we may be able to implement "in-memory" fallocate() in ZONED
> mode by utilizing space_info->bytes_may_use or so.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Looks good.

Reviewed-by: Anand Jain <anand.jain@orcle.com>

Thanks.
