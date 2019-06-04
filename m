Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AEBBF34C38
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2019 17:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728072AbfFDP2s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Jun 2019 11:28:48 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:57090 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727843AbfFDP2s (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Jun 2019 11:28:48 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 36685F51F310A0F796DC;
        Tue,  4 Jun 2019 23:28:34 +0800 (CST)
Received: from [127.0.0.1] (10.184.225.177) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Tue, 4 Jun 2019
 23:28:26 +0800
Subject: Re: [PATCH next] sysctl: add proc_dointvec_jiffies_minmax to limit
 the min/max write value
To:     Kees Cook <keescook@chromium.org>, <akpm@linux-foundation.org>
CC:     <mcgrof@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <ebiederm@xmission.com>,
        <pbonzini@redhat.com>, <viro@zeniv.linux.org.uk>,
        <adobriyan@gmail.com>, <mingfangsen@huawei.com>,
        <wangxiaogang3@huawei.com>, "Zhoukang (A)" <zhoukang7@huawei.com>,
        <netdev@vger.kernel.org>, <netdev@vger.kernel.org>
References: <032e024f-2b1b-a980-1b53-d903bc8db297@huawei.com>
 <3e421384-a9cb-e534-3370-953c56883516@huawei.com>
 <d5138655-41a8-0177-ae0d-c4674112bf56@huawei.com>
 <201905150945.C9D1F811F@keescook>
From:   Zhiqiang Liu <liuzhiqiang26@huawei.com>
Message-ID: <dd40ae3b-8e0a-2d55-d402-6f261a6c0e09@huawei.com>
Date:   Tue, 4 Jun 2019 23:27:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <201905150945.C9D1F811F@keescook>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.184.225.177]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> On Wed, May 15, 2019 at 10:53:55PM +0800, Zhiqiang Liu wrote:
> 
> (Please include akpm on CC for next versions of this, as he's likely
> the person to take this patch.)
Thanks for your advice. And sorry to reply you so late.

>>>> In proc_dointvec_jiffies func, the write value is only checked
>>>> whether it is larger than INT_MAX. If the write value is less
>>>> than zero, it can also be successfully writen in the data.
> 
> This appears to be "be design", but I see many "unsigned int" users
> that might be tricked into giant values... (for example, see
> net/netfilter/nf_conntrack_standalone.c)
> 
> Should proc_dointvec_jiffies() just be fixed to disallow negative values
> entirely? Looking at the implementation, it seems to be very intentional
> about accepting negative values.
> 
> However, when I looked through a handful of proc_dointvec_jiffies()
> users, it looks like they're all expecting a positive value. Many in the
> networking subsystem are, in fact, writing to unsigned long variables,
> as I mentioned.
> 
I totally agree with you. And I also cannot find an scenario that expects
negative values. Consideing the "negative" scenario may be exist, I add the
proc_dointvec_jiffies_minmax like proc_dointvec_minmax.

> Are there real-world cases of wanting to set a negative jiffie value
> via proc_dointvec_jiffies()?
Until now, I do not find such cases.

>>>>
>>>> Here, we add a new func, proc_dointvec_jiffies_minmax, to limit the
>>>> min/max write value, which is similar to the proc_dointvec_minmax func.
>>>>
> 
> If proc_dointvec_jiffies() can't just be fixed, where will the new
> function get used? It seems all the "unsigned int" users could benefit.
> 
I tend to add the proc_dointvec_jiffies_minmax func to provide more choices and
not change the previous use of proc_dointvec_jiffies func.

Thanks for your reply again.

