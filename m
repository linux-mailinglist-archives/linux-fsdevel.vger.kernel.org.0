Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50CFB2DA23C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Dec 2020 22:04:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503690AbgLNVBw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Dec 2020 16:01:52 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:57024 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503706AbgLNVBs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Dec 2020 16:01:48 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BEKsHeE144093;
        Mon, 14 Dec 2020 21:00:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=aa0Ax+bPQnK4YL5LoY0LgelOl5GRjz9JrB0IR+sjwy4=;
 b=ZI3+5u9fy8oScjTCPSIf0nTtRFLUqT+rmE9ZY5kRukhi7zEbtkOhM1ANvHwO7nOCgi2N
 09NS9xbcnV9uICnIhloRb5nT4+Mh5wNP7E2k95vLT5yq+NicQHkzj3sQUClD2B63PCkV
 iu7c4BOhuH8BbVldQeT3+PcYmeGxEao0sfoVdwy+2ncWx6tfP07IUKuugxzSQ1vAxNZ5
 pJTECX1MndtEGJigCmXGolSHW7PE/aS5eQm8VB7s2G8lKqMpLyfPuJFhuE6+an4rhX3k
 hcUTsD8xzCT2fLlHKZAHeCpXJ53fwnhQjCpfUUdvlvCcRh04cKwzor65YmwqTBoBXiRI lg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 35cn9r7ftb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 14 Dec 2020 21:00:47 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BEKt5rf135821;
        Mon, 14 Dec 2020 20:58:47 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 35e6jq0b48-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Dec 2020 20:58:47 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0BEKwcf0020933;
        Mon, 14 Dec 2020 20:58:39 GMT
Received: from [10.159.141.221] (/10.159.141.221)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 14 Dec 2020 12:58:38 -0800
Subject: Re: [RFC PATCH v2 0/6] fsdax: introduce fs query to support reflink
To:     Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-mm@kvack.org
Cc:     linux-fsdevel@vger.kernel.org, linux-raid@vger.kernel.org,
        darrick.wong@oracle.com, dan.j.williams@intel.com,
        david@fromorbit.com, hch@lst.de, song@kernel.org, rgoldwyn@suse.de,
        qi.fuli@fujitsu.com, y-goto@fujitsu.com
References: <20201123004116.2453-1-ruansy.fnst@cn.fujitsu.com>
From:   Jane Chu <jane.chu@oracle.com>
Organization: Oracle Corporation
Message-ID: <89ab4ec4-e4f0-7c17-6982-4f55bb40f574@oracle.com>
Date:   Mon, 14 Dec 2020 12:58:32 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20201123004116.2453-1-ruansy.fnst@cn.fujitsu.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9834 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 adultscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012140140
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9834 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 impostorscore=0 lowpriorityscore=0 clxscore=1011 spamscore=0
 malwarescore=0 priorityscore=1501 phishscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012140140
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi, Shiyang,

On 11/22/2020 4:41 PM, Shiyang Ruan wrote:
> This patchset is a try to resolve the problem of tracking shared page
> for fsdax.
> 
> Change from v1:
>    - Intorduce ->block_lost() for block device
>    - Support mapped device
>    - Add 'not available' warning for realtime device in XFS
>    - Rebased to v5.10-rc1
> 
> This patchset moves owner tracking from dax_assocaite_entry() to pmem
> device, by introducing an interface ->memory_failure() of struct
> pagemap.  The interface is called by memory_failure() in mm, and
> implemented by pmem device.  Then pmem device calls its ->block_lost()
> to find the filesystem which the damaged page located in, and call
> ->storage_lost() to track files or metadata assocaited with this page.
> Finally we are able to try to fix the damaged data in filesystem and do

Does that mean clearing poison? if so, would you mind to elaborate 
specifically which change does that?

Thanks!
-jane

> other necessary processing, such as killing processes who are using the
> files affected.
