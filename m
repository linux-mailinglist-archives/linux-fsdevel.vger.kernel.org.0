Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD273E8800
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Aug 2021 04:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231650AbhHKC2j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Aug 2021 22:28:39 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:57595 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231233AbhHKC2i (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Aug 2021 22:28:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1628648895; x=1660184895;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=mqrHT7lSpTYubUb4Uun7g5pFgQ69qr5SKKRD11vsmq0=;
  b=cdpMn0NbdlMX8mp1KU9fWzZ5lmzHKsv6m0vp7L4C5DvWtjqynyG0V/sG
   6qauRtKuziRD9TssNytxIXmZQWl+1hmYK5brB12d7T0bU/78u/RauZHLY
   wkBq5PPqpdwzgoycHsnVLpLHYBozSu7WN3saxAeRSPDqe6fkuP/+Uns3Q
   Q=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 10 Aug 2021 19:28:15 -0700
X-QCInternal: smtphost
Received: from nasanexm03e.na.qualcomm.com ([10.85.0.48])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/AES256-SHA; 10 Aug 2021 19:28:15 -0700
Received: from [10.111.168.10] (10.80.80.8) by nasanexm03e.na.qualcomm.com
 (10.85.0.48) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Tue, 10 Aug
 2021 19:28:13 -0700
Subject: Re: move the bdi from the request_queue to the gendisk
To:     Christoph Hellwig <hch@lst.de>
CC:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Jan Kara <jack@suse.cz>, <linux-block@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        <cgroups@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-mm@kvack.org>
References: <20210809141744.1203023-1-hch@lst.de>
 <e5e19d15-7efd-31f4-941a-a5eb2f94b898@quicinc.com>
 <20210810200256.GA30809@lst.de>
From:   Qian Cai <quic_qiancai@quicinc.com>
Message-ID: <4e108ea6-b1dd-510e-afc4-757eae697dab@quicinc.com>
Date:   Tue, 10 Aug 2021 22:28:12 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210810200256.GA30809@lst.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanexm03c.na.qualcomm.com (10.85.0.106) To
 nasanexm03e.na.qualcomm.com (10.85.0.48)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 8/10/2021 4:02 PM, Christoph Hellwig wrote:
> On Tue, Aug 10, 2021 at 03:36:39PM -0400, Qian Cai wrote:
>>
>>
>> On 8/9/2021 10:17 AM, Christoph Hellwig wrote:
>>> Hi Jens,
>>>
>>> this series moves the pointer to the bdi from the request_queue
>>> to the bdi, better matching the life time rules of the different
>>> objects.
>>
>> Reverting this series fixed an use-after-free in bdev_evict_inode().
> 
> Please try the patch below as a band-aid.  Although the proper fix is
> that non-default bdi_writeback structures grab a reference to the bdi,
> as this was a landmine that might have already caused spurious issues
> before.

This works fine with a quick test.
