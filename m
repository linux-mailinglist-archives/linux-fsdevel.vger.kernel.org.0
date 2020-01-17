Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F1101413F7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2020 23:16:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727195AbgAQWQR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jan 2020 17:16:17 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:50132 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726861AbgAQWQR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jan 2020 17:16:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=CFwRKOc+gezyceo0kC40ZLd3xOsAPmQzS5kapaZ2B18=; b=oKyPNlVDNwLxSQvsjfAkGK9aF
        R9eBYNoE5+kpCUwwuCM4AIBAFTneRiyrGJFIsrpgGpiY5vl652zEBt5pFSlhiGeGXy8CW1OjBk3iQ
        P/mwDGmpeXiizWRqFXXiZq5GZ/nCoznlISFqOqczXQzwAEKz4cjuJtZc988M18xUs01YsUj3eeJPP
        k5rUNPFnZIkmxfG8BzmfOUyVedBRIrP7PicBbfBevLz5OkFNdhy4PMuLb2AB73bfVZh67MXl9jMop
        LqLNId60/MmxANfdKyra+NdBP9yZ465zbOrudluqx7J0gwtqrMApT0L59lqQWDWHhdzNZxc4xqkSO
        qyuO8rj6w==;
Received: from [2601:1c0:6280:3f0::ed68]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1isZuG-0001rZ-79; Fri, 17 Jan 2020 22:15:56 +0000
Subject: Re: mmotm 2019-12-10-19-14 uploaded (objtool: func() falls through)
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, broonie@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au,
        Peter Zijlstra <peterz@infradead.org>
References: <20191211031432.iyKVQ6m9n%akpm@linux-foundation.org>
 <07777464-b9d8-ff1d-41d9-f62cc44f09f3@infradead.org>
 <20191212184859.zjj2ycfkvpcns5bk@treble>
 <042c6cd7-c983-03f1-6a79-5642549f57c4@infradead.org>
 <20191212205811.4vrrb4hou3tbiada@treble>
 <20200117181121.3h72dajey7oticbf@treble>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <d1dc6614-9089-62a8-e303-84b9d57297a3@infradead.org>
Date:   Fri, 17 Jan 2020 14:15:54 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200117181121.3h72dajey7oticbf@treble>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/17/20 10:11 AM, Josh Poimboeuf wrote:
> On Thu, Dec 12, 2019 at 02:58:11PM -0600, Josh Poimboeuf wrote:
>> On Thu, Dec 12, 2019 at 12:21:17PM -0800, Randy Dunlap wrote:
>>> On 12/12/19 10:48 AM, Josh Poimboeuf wrote:
>>>> On Wed, Dec 11, 2019 at 08:31:08AM -0800, Randy Dunlap wrote:
>>>>> On 12/10/19 7:14 PM, Andrew Morton wrote:
>>>>>> The mm-of-the-moment snapshot 2019-12-10-19-14 has been uploaded to
>>>>>>
>>>>>>    http://www.ozlabs.org/~akpm/mmotm/
>>>>>>
>>>>>> mmotm-readme.txt says
>>>>>>
>>>>>> README for mm-of-the-moment:
>>>>>>
>>>>>> http://www.ozlabs.org/~akpm/mmotm/
>>>>>>
>>>>>> This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
>>>>>> more than once a week.
>>>>>>
>>>>>> You will need quilt to apply these patches to the latest Linus release (5.x
>>>>>> or 5.x-rcY).  The series file is in broken-out.tar.gz and is duplicated in
>>>>>> http://ozlabs.org/~akpm/mmotm/series
>>>>>>
>>>>>> The file broken-out.tar.gz contains two datestamp files: .DATE and
>>>>>> .DATE-yyyy-mm-dd-hh-mm-ss.  Both contain the string yyyy-mm-dd-hh-mm-ss,
>>>>>> followed by the base kernel version against which this patch series is to
>>>>>> be applied.
>>>>>
>>>>> on x86_64:
>>>>>
>>>>> drivers/hwmon/f71882fg.o: warning: objtool: f71882fg_update_device() falls through to next function show_pwm_auto_point_temp_hyst()
>>>>> drivers/ide/ide-probe.o: warning: objtool: hwif_register_devices() falls through to next function hwif_release_dev()
>>>>> drivers/ide/ide-probe.o: warning: objtool: ide_host_remove() falls through to next function ide_disable_port()
>>>>
>>>> Randy, can you share the .o files?
>>>
>>> Sure. They are attached.
>>
>> These look like compiler bugs to me... execution is falling off the edge
>> of the functions for no apparent reason.  Could potentially be triggered
>> by the '#define if' trace code.
> 
> Randy, do you happen to have a config which triggers the above bugs?  I
> can reduce the test cases and open a GCC bug.
> 

No, but I'll try to recreate the issue and get back to you.

-- 
~Randy

