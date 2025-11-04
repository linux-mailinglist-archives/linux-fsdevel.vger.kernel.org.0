Return-Path: <linux-fsdevel+bounces-66876-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D90C2F2F9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 04 Nov 2025 04:44:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E53BD4E2392
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Nov 2025 03:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 163FF299A94;
	Tue,  4 Nov 2025 03:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="hBFzAFez"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202361F37D4;
	Tue,  4 Nov 2025 03:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762227855; cv=none; b=a/7RQuLKa7tlSh/ssxoVgd8MHxNPcQERwI1U5tyPLASbLrfyb93I9BN7kDpPsS3NZPTL2/kuKucBOv1JKUPmKnpw1BHHoAOCBthk3KDvZ7aAWuAcUiV+x72PV8I5H/azuRkz4Z5gBmXemyyKWovNDHi4yYNNBaoSdrjO/K3fJlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762227855; c=relaxed/simple;
	bh=umoX7VA18Gl5MBsm3Nw6/8CP6zXuM1RGPYbHB5gKFOg=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=L7EWQyHPV02xo3yEEVy49Sk8sQB9JoYQKmr0Os9wan1KuyGVR+vc4Gz1+5fEUDFCfpuH0u62rO9lDVEW3cqKz1ZXEsuwhoo1rTvL5aK/NrT9L2XWSUyPcIpigwQ+UhOnbnBj9oHaCZOSM8G9g79fXriux5FtM0Jzdz3qkJDTUhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=hBFzAFez; arc=none smtp.client-ip=113.46.200.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=mI5NZzwX6x6xO/W1T3LkO8z5F3lpSfn/IETM235fG98=;
	b=hBFzAFezSw5JUCqYW5mq4lqx75pi/JseqBGO1dB9WuIWOkL3yRPZ07q09rs6isMru3p+tiNC7
	GjC2VM3ts7O8bU6uaEZHyqT2D6IHqU5GpI7oS18Jut473ONzsEfaZ6qzrtQmQ0oL3x3FZ64ox2k
	v1YpxsgeVzQICoCb8/hW3uk=
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4d0vR829VdzmV6Y;
	Tue,  4 Nov 2025 11:42:28 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id E19A51400E8;
	Tue,  4 Nov 2025 11:44:02 +0800 (CST)
Received: from kwepemq500010.china.huawei.com (7.202.194.235) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 4 Nov 2025 11:44:02 +0800
Received: from [10.173.125.37] (10.173.125.37) by
 kwepemq500010.china.huawei.com (7.202.194.235) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 4 Nov 2025 11:44:01 +0800
Subject: Re: [RFC PATCH v1 0/3] Userspace MFR Policy via memfd
To: Jiaqi Yan <jiaqiyan@google.com>, Harry Yoo <harry.yoo@oracle.com>
CC: =?UTF-8?Q?=e2=80=9cWilliam_Roche?= <william.roche@oracle.com>, "Ackerley
 Tng" <ackerleytng@google.com>, <jgg@nvidia.com>, <akpm@linux-foundation.org>,
	<ankita@nvidia.com>, <dave.hansen@linux.intel.com>, <david@redhat.com>,
	<duenwen@google.com>, <jane.chu@oracle.com>, <jthoughton@google.com>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, <muchun.song@linux.dev>, <nao.horiguchi@gmail.com>,
	<osalvador@suse.de>, <peterx@redhat.com>, <rientjes@google.com>,
	<sidhartha.kumar@oracle.com>, <tony.luck@intel.com>,
	<wangkefeng.wang@huawei.com>, <willy@infradead.org>, <vbabka@suse.cz>,
	<surenb@google.com>, <mhocko@suse.com>, <jackmanb@google.com>,
	<hannes@cmpxchg.org>, <ziy@nvidia.com>
References: <20250118231549.1652825-1-jiaqiyan@google.com>
 <20250919155832.1084091-1-william.roche@oracle.com>
 <CACw3F521fi5HWhCKi_KrkNLXkw668HO4h8+DjkP2+vBuK-=org@mail.gmail.com>
 <aPjXdP63T1yYtvkq@hyeyoo>
 <CACw3F50As2jPzy1rRjzpm3uKOALjX_9WmKxMPGnQcok96OfQkA@mail.gmail.com>
 <aQBqGupCN_v8ysMX@hyeyoo> <d3d35586-c63f-c1be-c95e-fbd7aafd43f3@huawei.com>
 <CACw3F51qaug5aWFNcjB54dVEc8yH+_A7zrkGcQyKXKJs6uVvgA@mail.gmail.com>
 <aQhk4WtDSaQmFFFo@harry> <aQhti7Dt_34Yx2jO@harry>
 <CACw3F503FG01yQyA53hHAo7q0yE3qQtMuT9kOjNHpp8Q9qHKPQ@mail.gmail.com>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <425edf39-fd51-cf99-9608-34ee314486a6@huawei.com>
Date: Tue, 4 Nov 2025 11:44:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CACw3F503FG01yQyA53hHAo7q0yE3qQtMuT9kOjNHpp8Q9qHKPQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemq500010.china.huawei.com (7.202.194.235)

On 2025/11/4 0:57, Jiaqi Yan wrote:
> On Mon, Nov 3, 2025 at 12:53 AM Harry Yoo <harry.yoo@oracle.com> wrote:
>>
>> On Mon, Nov 03, 2025 at 05:16:33PM +0900, Harry Yoo wrote:
>>> On Thu, Oct 30, 2025 at 10:28:48AM -0700, Jiaqi Yan wrote:
>>>> On Thu, Oct 30, 2025 at 4:51 AM Miaohe Lin <linmiaohe@huawei.com> wrote:
>>>>> On 2025/10/28 15:00, Harry Yoo wrote:
>>>>>> On Mon, Oct 27, 2025 at 09:17:31PM -0700, Jiaqi Yan wrote:
>>>>>>> On Wed, Oct 22, 2025 at 6:09 AM Harry Yoo <harry.yoo@oracle.com> wrote:
>>>>>>>> On Mon, Oct 13, 2025 at 03:14:32PM -0700, Jiaqi Yan wrote:
>>>>>>>>> On Fri, Sep 19, 2025 at 8:58 AM “William Roche <william.roche@oracle.com> wrote:
>>>>>>>> But even after fixing that we need to fix the race condition.
>>>>>>>
>>>>>>> What exactly is the race condition you are referring to?
>>>>>>
>>>>>> When you free a high-order page, the buddy allocator doesn't not check
>>>>>> PageHWPoison() on the page and its subpages. It checks PageHWPoison()
>>>>>> only when you free a base (order-0) page, see free_pages_prepare().
>>>>>
>>>>> I think we might could check PageHWPoison() for subpages as what free_page_is_bad()
>>>>> does. If any subpage has HWPoisoned flag set, simply drop the folio. Even we could
>>>>
>>>> Agree, I think as a starter I could try to, for example, let
>>>> free_pages_prepare scan HWPoison-ed subpages if the base page is high
>>>> order. In the optimal case, HugeTLB does move PageHWPoison flag from
>>>> head page to the raw error pages.
>>>
>>> [+Cc page allocator folks]
>>>
>>> AFAICT enabling page sanity check in page alloc/free path would be against
>>> past efforts to reduce sanity check overhead.
>>>
>>> [1] https://lore.kernel.org/linux-mm/1460711275-1130-15-git-send-email-mgorman@techsingularity.net/
>>> [2] https://lore.kernel.org/linux-mm/1460711275-1130-16-git-send-email-mgorman@techsingularity.net/
>>> [3] https://lore.kernel.org/all/20230216095131.17336-1-vbabka@suse.cz
>>>
>>> I'd recommend to check hwpoison flag before freeing it to the buddy
>>> when we know a memory error has occurred (I guess that's also what Miaohe
>>> suggested).
>>>
>>>>> do it better -- Split the folio and let healthy subpages join the buddy while reject
>>>>> the hwpoisoned one.
>>>>>
>>>>>>
>>>>>> AFAICT there is nothing that prevents the poisoned page to be
>>>>>> allocated back to users because the buddy doesn't check PageHWPoison()
>>>>>> on allocation as well (by default).
>>>>>>
>>>>>> So rather than freeing the high-order page as-is in
>>>>>> dissolve_free_hugetlb_folio(), I think we have to split it to base pages
>>>>>> and then free them one by one.
>>>>>
>>>>> It might not be worth to do that as this would significantly increase the overhead
>>>>> of the function while memory failure event is really rare.
>>>>
>>>> IIUC, Harry's idea is to do the split in dissolve_free_hugetlb_folio
>>>> only if folio is HWPoison-ed, similar to what Miaohe suggested
>>>> earlier.
>>>
>>> Yes, and if we do the check before moving HWPoison flag to raw pages,
>>> it'll be just a single folio_test_hwpoison() call.
>>>
>>>> BTW, I believe this race condition already exists today when
>>>> memory_failure handles HWPoison-ed free hugetlb page; it is not
>>>> something introduced via this patchset. I will fix or improve this in
>>>> a separate patchset.
>>>
>>> That makes sense.
>>
>> Wait, without this patchset, do we even free the hugetlb folio when
>> its subpage is hwpoisoned? I don't think we do, but I'm not expert at MFR...
> 
> Based on my reading of try_memory_failure_hugetlb, me_huge_page, and
> __page_handle_poison, I think mainline kernel frees dissolved hugetlb
> folio to buddy allocator in two cases:
> 1. it was a free hugetlb page at the moment of try_memory_failure_hugetlb
> 2. it was an anonomous hugetlb page

I think there are some corner cases that can lead to hugetlb folio being freed while
some of its subpages are hwpoisoned. E.g. get_huge_page_for_hwpoison can return
-EHWPOISON when hugetlb folio is happen to be isolated. Later hugetlb folio might
become free and __update_and_free_hugetlb_folio will be used to free it into buddy.

If page sanity check is enabled, hwpoisoned subpages will slip into buddy but they
won't be re-allocated later because check_new_page will drop them. But if page sanity
check is disabled, I think there is still missing a way to stop hwpoisoned subpages
from being reused.

Let me know if I miss something.

Thanks both.
.


