Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF8E32C1C0D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Nov 2020 04:30:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728935AbgKXD37 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Nov 2020 22:29:59 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:57434 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727168AbgKXD37 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Nov 2020 22:29:59 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AO3SxCF099940;
        Tue, 24 Nov 2020 03:29:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=ktNRS4xVdZs6jwJg6V2dcoRQK/STslHC/YYS2vx/iNg=;
 b=AGFQ2OtZX3Dat/eTzoax+7gfO6N0DIlHg8aeQFV2pfzOO0nQZauQ/EPOpaC9D8o2E+p+
 DKPwVfR3QUr6gPQPF19XI4VgHSrNlT8pOSmmseLt4v8vmhN2xuUC1Zz54xd9qI8BNvzT
 12gx6Dfi9ic7nCFLH9ntunSdH5JDBBThhD0Mq+ITgHZLqs0ViPQJGYkmz7UKuZZA2YEe
 XzND2bcGAOv21v0iajv19QfArB7ki/dx2z/0rpiCXxBZjv71ncEX+jHLzFCQlE/S1oxr
 TlBkjKzZQY1UfWcav7q06VMwkDUvPDZTUSRz8faqqAiPWo/qr0NuqbFJcKI91KiDjJ4X oA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 34xtum0cd4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 24 Nov 2020 03:29:37 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AO3OtgV051468;
        Tue, 24 Nov 2020 03:29:36 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 34yctvt52d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Nov 2020 03:29:36 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0AO3TUNY022314;
        Tue, 24 Nov 2020 03:29:31 GMT
Received: from [192.168.1.102] (/39.109.186.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 23 Nov 2020 19:29:30 -0800
Subject: Re: [PATCH v10 08/41] btrfs: disallow NODATACOW in ZONED mode
To:     dsterba@suse.cz, Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org, dsterba@suse.com, hare@suse.com,
        linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <cover.1605007036.git.naohiro.aota@wdc.com>
 <a7debcd84dafac8b0d0f67da6b4e410ea346bffb.1605007036.git.naohiro.aota@wdc.com>
 <05414b36-2a3f-b2fb-a596-48cf8d59512b@oracle.com>
 <20201123172155.GJ8669@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <292082d0-5381-0022-60d6-c49140e0950d@oracle.com>
Date:   Tue, 24 Nov 2020 11:29:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201123172155.GJ8669@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9814 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 malwarescore=0 spamscore=0 phishscore=0 mlxlogscore=999 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011240019
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9814 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 mlxlogscore=999 impostorscore=0 spamscore=0 mlxscore=0
 phishscore=0 clxscore=1015 suspectscore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011240019
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 24/11/20 1:21 am, David Sterba wrote:
> On Fri, Nov 20, 2020 at 12:17:21PM +0800, Anand Jain wrote:
>> On 10/11/20 7:26 pm, Naohiro Aota wrote:
>>> +				    unsigned int flags)
>>> +{
>>> +	if (btrfs_is_zoned(fs_info) && (flags & FS_NOCOW_FL))
>>
>>
>>> +		return -EPERM;
>>
>> nit:
>>    Should it be -EINVAL instead? I am not sure. May be David can fix
>> while integrating.
> 
> IIRC we've discussed that in some previous iteration. EPERM should be
> interpreted as that it's not permitted right now, but otherwise it is a
> valid operation/flag. The constraint is the zoned device.
> 
> As an example: deleting default subvolume is not permitted (EPERM), but
> otherwise subvolume deletion is a valid operation.
> 
> So, EINVAL is for invalid combination of parameters or a request for
> something that does not make sense at all.
> 

Ok. Thanks.
