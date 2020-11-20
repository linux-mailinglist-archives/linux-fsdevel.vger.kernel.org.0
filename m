Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D9F12BA179
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Nov 2020 05:35:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbgKTEc7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Nov 2020 23:32:59 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:60088 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbgKTEc6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Nov 2020 23:32:58 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AK4V39q001863;
        Fri, 20 Nov 2020 04:32:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=/AV0mHO/lcsiXWM9pmRmY4VBC69NBUJe7oLX0ySmVvI=;
 b=bHTPBDxJXCnB4J5C/jaE0xXJl2EgXx/dsXPzn+usgBFO0L6kPEaMXp7brjrJ4zrT2gm3
 Ui3r3zd9XUYezrmDe8R15ocmteJRmK9B/ZNzCew/n4aV9F2PKMizs255vzrAcTuaghM7
 jUvA/vO+4x6LS8PU2kgu5ConUwYbzJ1zzMQxnoyq+St5uqLKW7vB0DhPkyi7SfgP1Isx
 itCBIWd1pH7b5CTBtRRE2WKUGiWJal7/t3IJ0K9cbrJ92ougcEl3JmctWPV/1y4WIxZo
 y09CKDWhkjWDylIv3p3H5kOhLBLhtnVCyRcRgIJRxl60FXM0z34jCBh4wcr4bGJzMMsO tA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 34t4rb8xkq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 20 Nov 2020 04:32:49 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AK4Uvmd182002;
        Fri, 20 Nov 2020 04:32:48 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 34ts60y75p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Nov 2020 04:32:48 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0AK4Wlx2003426;
        Fri, 20 Nov 2020 04:32:47 GMT
Received: from [192.168.1.102] (/39.109.186.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 19 Nov 2020 20:32:46 -0800
Subject: Re: [PATCH v10 10/41] btrfs: disallow mixed-bg in ZONED mode
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Josef Bacik <josef@toxicpanda.com>
References: <cover.1605007036.git.naohiro.aota@wdc.com>
 <b4cb1394eb65fb4a28fb5eb18e905dc817199272.1605007036.git.naohiro.aota@wdc.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <99f451d7-9c0a-5610-ea4a-856496d34d33@oracle.com>
Date:   Fri, 20 Nov 2020 12:32:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <b4cb1394eb65fb4a28fb5eb18e905dc817199272.1605007036.git.naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9810 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 phishscore=0
 suspectscore=0 mlxscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011200029
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9810 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 lowpriorityscore=0 priorityscore=1501
 mlxlogscore=999 adultscore=0 phishscore=0 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011200029
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/11/20 7:26 pm, Naohiro Aota wrote:
> Placing both data and metadata in a block group is impossible in ZONED
> mode. For data, we can allocate a space for it and write it immediately
> after the allocation. For metadata, however, we cannot do so, because the
> logical addresses are recorded in other metadata buffers to build up the
> trees. As a result, a data buffer can be placed after a metadata buffer,
> which is not written yet. Writing out the data buffer will break the
> sequential write rule.
> 
> This commit check and disallow MIXED_BG with ZONED mode.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> ---


Reviewed-by: Anand Jain <anand.jain@oracle.com>

Thanks.
