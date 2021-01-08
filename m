Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D8EE2EF72A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Jan 2021 19:17:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728061AbhAHSQI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Jan 2021 13:16:08 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:43920 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727429AbhAHSQH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Jan 2021 13:16:07 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 108HwwOY004690;
        Fri, 8 Jan 2021 18:15:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=KiTw25sQnwXSQX+0iRD1HBB4uXxJXhd7Tk5XQ9JUJTE=;
 b=gTJvSGLjyueTzS8vgNsV+rpKJmQFk8fY+zb3p5ZDQqfAWD0TXtxr0+zcwpk/Z5f9BG5e
 VwNDwsqFMNUcseD6IEwkpfpSHYOITZNUp5dTFJF3GZJlV0Qbvj5cXNFfUWQ4mhZbb6Kh
 7t601GM0mXU18dnI2cVo1qytEC2sUIBJA6/fu4DmcG+wxp0PxPmrBAwkqYTHm9KeCfXv
 FqcIB4Ec7M+DYaIHNVo1oCCjPzOaZ1lgAMjgQF/f8urKsNVcjV12MvAhvgmFwrWXDi2x
 SFEINWClUGqtHlOWAU9dapkOdg1gHd2jiFKW+9gf1IC+ZJpceqxWihAQYrpFIpewNTLj zg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 35wcuy2pbg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 08 Jan 2021 18:15:08 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 108I0wFn081682;
        Fri, 8 Jan 2021 18:15:08 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 35v1fcvpaa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Jan 2021 18:15:08 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 108IF6J1019818;
        Fri, 8 Jan 2021 18:15:06 GMT
Received: from [10.159.230.21] (/10.159.230.21)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 08 Jan 2021 18:15:05 +0000
Subject: Re: [RFC PATCH v3 0/9] fsdax: introduce fs query to support reflink
To:     Ruan Shiyang <ruansy.fnst@cn.fujitsu.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-raid@vger.kernel.org,
        dan.j.williams@intel.com, david@fromorbit.com, hch@lst.de,
        song@kernel.org, rgoldwyn@suse.de, qi.fuli@fujitsu.com,
        y-goto@fujitsu.com
References: <20201215121414.253660-1-ruansy.fnst@cn.fujitsu.com>
 <7fc7ba7c-f138-4944-dcc7-ce4b3f097528@oracle.com>
 <a57c44dd-127a-3bd2-fcb3-f1373572de27@cn.fujitsu.com>
 <20201218034907.GG6918@magnolia>
 <16ac8000-2892-7491-26a0-84de4301f168@cn.fujitsu.com>
From:   Jane Chu <jane.chu@oracle.com>
Organization: Oracle Corporation
Message-ID: <f3f93809-ba68-521f-70d8-27f1ba5d0036@oracle.com>
Date:   Fri, 8 Jan 2021 10:14:58 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <16ac8000-2892-7491-26a0-84de4301f168@cn.fujitsu.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9858 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 spamscore=0 bulkscore=0 adultscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101080099
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9858 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 clxscore=1011 spamscore=0 impostorscore=0 priorityscore=1501 mlxscore=0
 adultscore=0 mlxlogscore=999 lowpriorityscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101080099
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi, Shiyang,

On 12/18/2020 1:13 AM, Ruan Shiyang wrote:
>>>>
>>>> So I tried the patchset with pmem error injection, the SIGBUS payload
>>>> does not look right -
>>>>
>>>> ** SIGBUS(7): **
>>>> ** si_addr(0x(nil)), si_lsb(0xC), si_code(0x4, BUS_MCEERR_AR) **
>>>>
>>>> I expect the payload looks like
>>>>
>>>> ** si_addr(0x7f3672e00000), si_lsb(0x15), si_code(0x4, 
>>>> BUS_MCEERR_AR) **
>>>
>>> Thanks for testing.  I test the SIGBUS by writing a program which calls
>>> madvise(... ,MADV_HWPOISON) to inject memory-failure.  It just shows 
>>> that
>>> the program is killed by SIGBUS.  I cannot get any detail from it.  So,
>>> could you please show me the right way(test tools) to test it?
>>
>> I'm assuming that Jane is using a program that calls sigaction to
>> install a SIGBUS handler, and dumps the entire siginfo_t structure
>> whenever it receives one...

Yes, thanks Darrick.

> 
> OK.  Let me try it and figure out what's wrong in it.

I injected poison via "ndctl inject-error",  not expecting it made any 
difference though.

Any luck?

thanks,
-jane

