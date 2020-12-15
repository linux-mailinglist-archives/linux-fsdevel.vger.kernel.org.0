Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFD292DAC8F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Dec 2020 13:02:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728957AbgLOMA6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Dec 2020 07:00:58 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:23578 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728743AbgLOMAt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Dec 2020 07:00:49 -0500
X-IronPort-AV: E=Sophos;i="5.78,420,1599494400"; 
   d="scan'208";a="102419797"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 15 Dec 2020 20:00:29 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id 928374CE600B;
        Tue, 15 Dec 2020 20:00:26 +0800 (CST)
Received: from irides.mr (10.167.225.141) by G08CNEXMBPEKD05.g08.fujitsu.local
 (10.167.33.204) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 15 Dec
 2020 20:00:25 +0800
Subject: Re: [RFC PATCH v2 0/6] fsdax: introduce fs query to support reflink
To:     Jane Chu <jane.chu@oracle.com>, <linux-kernel@vger.kernel.org>,
        <linux-xfs@vger.kernel.org>, <linux-nvdimm@lists.01.org>,
        <linux-mm@kvack.org>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-raid@vger.kernel.org>,
        <darrick.wong@oracle.com>, <dan.j.williams@intel.com>,
        <david@fromorbit.com>, <hch@lst.de>, <song@kernel.org>,
        <rgoldwyn@suse.de>, <qi.fuli@fujitsu.com>, <y-goto@fujitsu.com>
References: <20201123004116.2453-1-ruansy.fnst@cn.fujitsu.com>
 <89ab4ec4-e4f0-7c17-6982-4f55bb40f574@oracle.com>
From:   Ruan Shiyang <ruansy.fnst@cn.fujitsu.com>
Message-ID: <bb699996-ddc8-8f3a-dc8f-2422bf990b06@cn.fujitsu.com>
Date:   Tue, 15 Dec 2020 19:58:36 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <89ab4ec4-e4f0-7c17-6982-4f55bb40f574@oracle.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.167.225.141]
X-ClientProxiedBy: G08CNEXCHPEKD06.g08.fujitsu.local (10.167.33.205) To
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204)
X-yoursite-MailScanner-ID: 928374CE600B.AB884
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@cn.fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Jane

On 2020/12/15 上午4:58, Jane Chu wrote:
> Hi, Shiyang,
> 
> On 11/22/2020 4:41 PM, Shiyang Ruan wrote:
>> This patchset is a try to resolve the problem of tracking shared page
>> for fsdax.
>>
>> Change from v1:
>>    - Intorduce ->block_lost() for block device
>>    - Support mapped device
>>    - Add 'not available' warning for realtime device in XFS
>>    - Rebased to v5.10-rc1
>>
>> This patchset moves owner tracking from dax_assocaite_entry() to pmem
>> device, by introducing an interface ->memory_failure() of struct
>> pagemap.  The interface is called by memory_failure() in mm, and
>> implemented by pmem device.  Then pmem device calls its ->block_lost()
>> to find the filesystem which the damaged page located in, and call
>> ->storage_lost() to track files or metadata assocaited with this page.
>> Finally we are able to try to fix the damaged data in filesystem and do
> 
> Does that mean clearing poison? if so, would you mind to elaborate 
> specifically which change does that?

Recovering data for filesystem (or pmem device) has not been done in 
this patchset...  I just triggered the handler for the files sharing the 
corrupted page here.


--
Thanks,
Ruan Shiyang.

> 
> Thanks!
> -jane
> 
>> other necessary processing, such as killing processes who are using the
>> files affected.
> 
> 


