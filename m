Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD672DBAD4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Dec 2020 06:44:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725818AbgLPFoL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Dec 2020 00:44:11 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:42278 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725274AbgLPFoL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Dec 2020 00:44:11 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BG5ecQf172932;
        Wed, 16 Dec 2020 05:43:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=T8VJpldCNi+sj6YW08esJ7EhQP7RkcOTlE+MlH6mYLs=;
 b=K5A3QJWodrZBH11uy941tRO6n38iCfy9Czcb7m/MrxhOmWZ3LtNOzj5vrynmZILAFi3C
 o/hBnV8lvTjP95xcdUi2MQqBPRED1ZX8HrGP3mgTO0VaKk49d0oxJdEXrzCmn2WpsevR
 +TKf3vheZaSiHrSF24Jt2/I39qoaraAeIkdbVXRS0prYxUdje7qgYmuOn2TTXv4HXzjE
 zeKrcD4mKuaI2/OXeWyhr/soaSXYHVvz+tqfcvXgUaPqICHwWGgcuyiRquHStTwcTb0m
 7ct+CSzEd6nyCOeJfd9JtpUa/liMsJ9oJqj6TuBsp9LcHVyhraWlR1OYP0ij4CGAf2ZV 7g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 35cn9re4ux-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 16 Dec 2020 05:43:13 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BG5f9TG060072;
        Wed, 16 Dec 2020 05:43:13 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 35e6js8pa1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Dec 2020 05:43:13 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0BG5hAp8001000;
        Wed, 16 Dec 2020 05:43:10 GMT
Received: from [10.159.136.92] (/10.159.136.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 15 Dec 2020 21:43:10 -0800
Subject: Re: [RFC PATCH v3 8/9] md: Implement ->corrupted_range()
To:     Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-mm@kvack.org
Cc:     linux-fsdevel@vger.kernel.org, linux-raid@vger.kernel.org,
        darrick.wong@oracle.com, david@fromorbit.com, hch@lst.de,
        song@kernel.org, rgoldwyn@suse.de, qi.fuli@fujitsu.com,
        y-goto@fujitsu.com
References: <20201215121414.253660-1-ruansy.fnst@cn.fujitsu.com>
 <20201215121414.253660-9-ruansy.fnst@cn.fujitsu.com>
From:   Jane Chu <jane.chu@oracle.com>
Organization: Oracle Corporation
Message-ID: <100fcdf4-b2fe-d77d-e95f-52a7323d7ee1@oracle.com>
Date:   Tue, 15 Dec 2020 21:43:08 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20201215121414.253660-9-ruansy.fnst@cn.fujitsu.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9836 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 adultscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012160035
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9836 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 impostorscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 malwarescore=0 priorityscore=1501 phishscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012160035
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/15/2020 4:14 AM, Shiyang Ruan wrote:
>   #ifdef CONFIG_SYSFS
> +int bd_disk_holder_corrupted_range(struct block_device *bdev, loff_t off,
> +				   size_t len, void *data);
>   int bd_link_disk_holder(struct block_device *bdev, struct gendisk *disk);
>   void bd_unlink_disk_holder(struct block_device *bdev, struct gendisk *disk);
>   #else
> +int bd_disk_holder_corrupted_range(struct block_device *bdev, loff_t off,

Did you mean
   static inline int bd_disk_holder_corrupted_range(..
?

thanks,
-jane

> +				   size_t len, void *data)
> +{
> +	return 0;
> +}
>   static inline int bd_link_disk_holder(struct block_device *bdev,
>   				      struct gendisk *disk)
