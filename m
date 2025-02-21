Return-Path: <linux-fsdevel+bounces-42212-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37616A3ECBF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 07:18:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 181B219C3117
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 06:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AAFE1FBEBE;
	Fri, 21 Feb 2025 06:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="gEsjZOsU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C81F1E5B78;
	Fri, 21 Feb 2025 06:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740118692; cv=none; b=rIada6EXo931ZVWVeBNI3Y27RSo9YZjys/yXcItyftVKTEJI41N5+9pnZJds1MBiPmwKpvTr054g12ucHVZm5Fa60xqOb91HhuMw/4FpTK537SovwdkHDsHYMGc2tdCRyDP55R8OUHYAHkUV0qACWB5/GfodQ4rEGXzE0cEQ35w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740118692; c=relaxed/simple;
	bh=ryHi591vfcW06vmMEmOMY1QnBYKfIE+G36bndzEt1lQ=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=trzgsfX1ekuBSAzsgGf1d/63HhYRpAb2ba9SRKHrJ1rJZ4fWTTnxb5aIq5ZyIRiKww3r9ESl5W5aikTLY54PKa7AYH+S02knl/CeLbng6bpO7U8o6FDa1B/PgfH2iSQxg+9bhGDtZzccmPb75XzvbNNmgUkQncNyJA+PLmTtwdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=gEsjZOsU; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1740118678; h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:From;
	bh=7bSknmGjcXsrjGFuurLwGaT4F80X9Xa7EPH7LalPEs8=;
	b=gEsjZOsUj6y15HStpSl2Ftz4/7dHJOMzHYkMHz0oEBOOqqcFeHCwIgJ3B2xa6T3mhP2ncpynEIH4yVjXv2PrxDPFONER39c8AerBJpDGS613sbju9rtio2QNljxZk2cuBxyZe9U2j7/6PrRhhI7CoHfk6cNXezFI2cAy5FdXkzE=
Received: from 30.74.144.124(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WPvDc2d_1740118677 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 21 Feb 2025 14:17:57 +0800
Content-Type: multipart/mixed; boundary="------------Ccw1TJVnax7Zyya7x2C0Xm84"
Message-ID: <edd6e5fd-f6d1-420c-a895-2dae5fe746ef@linux.alibaba.com>
Date: Fri, 21 Feb 2025 14:17:56 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] mm/shmem: use xas_try_split() in
 shmem_split_large_entry()
To: Zi Yan <ziy@nvidia.com>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 Matthew Wilcox <willy@infradead.org>, Hugh Dickins <hughd@google.com>,
 Kairui Song <kasong@tencent.com>, Miaohe Lin <linmiaohe@huawei.com>,
 linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
References: <20250218235444.1543173-1-ziy@nvidia.com>
 <20250218235444.1543173-3-ziy@nvidia.com>
 <f899d6b3-e607-480b-9acc-d64dfbc755b5@linux.alibaba.com>
 <AD348832-5A6A-48F1-9735-924F144330F7@nvidia.com>
 <47d189c7-3143-4b59-a3af-477d4c46a8a0@linux.alibaba.com>
 <2e4b9927-562d-4cfa-9362-f23e3bcfc454@linux.alibaba.com>
 <42440332-96FF-4ECB-8553-9472125EB33F@nvidia.com>
 <37C4B6AC-0757-4B92-88F3-75F1B4DEFFC5@nvidia.com>
 <655589D4-7E13-4F5B-8968-3FCB71DCE0FC@nvidia.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <655589D4-7E13-4F5B-8968-3FCB71DCE0FC@nvidia.com>

This is a multi-part message in MIME format.
--------------Ccw1TJVnax7Zyya7x2C0Xm84
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2025/2/21 10:38, Zi Yan wrote:
> On 20 Feb 2025, at 21:33, Zi Yan wrote:
> 
>> On 20 Feb 2025, at 8:06, Zi Yan wrote:
>>
>>> On 20 Feb 2025, at 4:27, Baolin Wang wrote:
>>>
>>>> On 2025/2/20 17:07, Baolin Wang wrote:
>>>>>
>>>>>
>>>>> On 2025/2/20 00:10, Zi Yan wrote:
>>>>>> On 19 Feb 2025, at 5:04, Baolin Wang wrote:
>>>>>>
>>>>>>> Hi Zi,
>>>>>>>
>>>>>>> Sorry for the late reply due to being busy with other things:)
>>>>>>
>>>>>> Thank you for taking a look at the patches. :)
>>>>>>
>>>>>>>
>>>>>>> On 2025/2/19 07:54, Zi Yan wrote:
>>>>>>>> During shmem_split_large_entry(), large swap entries are covering n slots
>>>>>>>> and an order-0 folio needs to be inserted.
>>>>>>>>
>>>>>>>> Instead of splitting all n slots, only the 1 slot covered by the folio
>>>>>>>> need to be split and the remaining n-1 shadow entries can be retained with
>>>>>>>> orders ranging from 0 to n-1.  This method only requires
>>>>>>>> (n/XA_CHUNK_SHIFT) new xa_nodes instead of (n % XA_CHUNK_SHIFT) *
>>>>>>>> (n/XA_CHUNK_SHIFT) new xa_nodes, compared to the original
>>>>>>>> xas_split_alloc() + xas_split() one.
>>>>>>>>
>>>>>>>> For example, to split an order-9 large swap entry (assuming XA_CHUNK_SHIFT
>>>>>>>> is 6), 1 xa_node is needed instead of 8.
>>>>>>>>
>>>>>>>> xas_try_split_min_order() is used to reduce the number of calls to
>>>>>>>> xas_try_split() during split.
>>>>>>>
>>>>>>> For shmem swapin, if we cannot swap in the whole large folio by skipping the swap cache, we will split the large swap entry stored in the shmem mapping into order-0 swap entries, rather than splitting it into other orders of swap entries. This is because the next time we swap in a shmem folio through shmem_swapin_cluster(), it will still be an order 0 folio.
>>>>>>
>>>>>> Right. But the swapin is one folio at a time, right? shmem_split_large_entry()
>>>>>
>>>>> Yes, now we always swapin an order-0 folio from the async swap device at a time. However, for sync swap device, we will skip the swapcache and swapin the whole large folio by commit 1dd44c0af4fa, so it will not call shmem_split_large_entry() in this case.
>>>
>>> Got it. I will check the commit.
>>>
>>>>>
>>>>>> should split the large swap entry and give you a slot to store the order-0 folio.
>>>>>> For example, with an order-9 large swap entry, to swap in first order-0 folio,
>>>>>> the large swap entry will become order-0, order-0, order-1, order-2,… order-8,
>>>>>> after the split. Then the first order-0 swap entry can be used.
>>>>>> Then, when a second order-0 is swapped in, the second order-0 can be used.
>>>>>> When the last order-0 is swapped in, the order-8 would be split to
>>>>>> order-7,order-6,…,order-1,order-0, order-0, and the last order-0 will be used.
>>>>>
>>>>> Yes, understood. However, for the sequential swapin scenarios, where originally only one split operation is needed. However, your approach increases the number of split operations. Of course, I understand that in non-sequential swapin scenarios, your patch will save some xarray memory. It might be necessary to evaluate whether the increased split operations will have a significant impact on the performance of sequential swapin?
>>>
>>> Is there a shmem swapin test I can run to measure this? xas_try_split() should
>>> performance similar operations as existing xas_split_alloc()+xas_split().

I think a simple sequential swapin case is enough? Anyway I can help to 
evaluate the performance impact with your new patch.

>>>>>> Maybe the swapin assumes after shmem_split_large_entry(), all swap entries
>>>>>> are order-0, which can lead to issues. There should be some check like
>>>>>> if the swap entry order > folio_order, shmem_split_large_entry() should
>>>>>> be used.
>>>>>>>
>>>>>>> Moreover I did a quick test with swapping in order 6 shmem folios, however, my test hung, and the console was continuously filled with the following information. It seems there are some issues with shmem swapin handling. Anyway, I need more time to debug and test.
>>>>>> To swap in order-6 folios, shmem_split_large_entry() does not allocate
>>>>>> any new xa_node, since XA_CHUNK_SHIFT is 6. It is weird to see OOM
>>>>>> error below. Let me know if there is anything I can help.
>>>>>
>>>>> I encountered some issues while testing order 4 and order 6 swapin with your patches. And I roughly reviewed the patch, and it seems that the new swap entry stored in the shmem mapping was not correctly updated after the split.
>>>>>
>>>>> The following logic is to reset the swap entry after split, and I assume that the large swap entry is always split to order 0 before. As your patch suggests, if a non-uniform split is used, then the logic for resetting the swap entry needs to be changed? Please correct me if I missed something.
>>>>>
>>>>> /*
>>>>>    * Re-set the swap entry after splitting, and the swap
>>>>>    * offset of the original large entry must be continuous.
>>>>>    */
>>>>> for (i = 0; i < 1 << order; i++) {
>>>>>       pgoff_t aligned_index = round_down(index, 1 << order);
>>>>>       swp_entry_t tmp;
>>>>>
>>>>>       tmp = swp_entry(swp_type(swap), swp_offset(swap) + i);
>>>>>       __xa_store(&mapping->i_pages, aligned_index + i,
>>>>>              swp_to_radix_entry(tmp), 0);
>>>>> }
>>>
>>> Right. I will need to adjust swp_entry_t. Thanks for pointing this out.
>>>
>>>>
>>>> In addition, after your patch, the shmem_split_large_entry() seems always return 0 even though it splits a large swap entry, but we still need re-calculate the swap entry value after splitting, otherwise it may return errors due to shmem_confirm_swap() validation failure.
>>>>
>>>> /*
>>>>   * If the large swap entry has already been split, it is
>>>>   * necessary to recalculate the new swap entry based on
>>>>   * the old order alignment.
>>>>   */
>>>>   if (split_order > 0) {
>>>> 	pgoff_t offset = index - round_down(index, 1 << split_order);
>>>>
>>>> 	swap = swp_entry(swp_type(swap), swp_offset(swap) + offset);
>>>> }
>>>
>>> Got it. I will fix it.
>>>
>>> BTW, do you mind sharing your swapin tests so that I can test my new version
>>> properly?
>>
>> The diff below adjusts the swp_entry_t and returns the right order after
>> shmem_split_large_entry(). Let me know if it fixes your issue.
> 
> Fixed the compilation error. It will be great if you can share a swapin test, so that
> I can test locally. Thanks.

Sure. I've attached 3 test shmem swapin cases to see if they can help 
you with testing. I will also find time next week to review and test 
your patch.

Additionally, you can use zram as a swap device and disable the skipping 
swapcache feature to test the split logic quickly:

diff --git a/mm/shmem.c b/mm/shmem.c
index 745f130bfb4c..7374d5c1cdde 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2274,7 +2274,7 @@ static int shmem_swapin_folio(struct inode *inode, 
pgoff_t index,
         folio = swap_cache_get_folio(swap, NULL, 0);
         if (!folio) {
                 int order = xa_get_order(&mapping->i_pages, index);
-               bool fallback_order0 = false;
+               bool fallback_order0 = true;
                 int split_order;

                 /* Or update major stats only when swapin succeeds?? */

> 
> diff --git a/mm/shmem.c b/mm/shmem.c
> index b35ba250c53d..bfc4ef511391 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -2162,7 +2162,7 @@ static int shmem_split_large_entry(struct inode *inode, pgoff_t index,
>   {
>   	struct address_space *mapping = inode->i_mapping;
>   	XA_STATE_ORDER(xas, &mapping->i_pages, index, 0);
> -	int split_order = 0;
> +	int split_order = 0, entry_order = 0;
>   	int i;
> 
>   	/* Convert user data gfp flags to xarray node gfp flags */
> @@ -2180,6 +2180,7 @@ static int shmem_split_large_entry(struct inode *inode, pgoff_t index,
>   		}
> 
>   		order = xas_get_order(&xas);
> +		entry_order = order;
> 
>   		/* Try to split large swap entry in pagecache */
>   		if (order > 0) {
> @@ -2192,23 +2193,23 @@ static int shmem_split_large_entry(struct inode *inode, pgoff_t index,
>   				xas_try_split(&xas, old, cur_order, GFP_NOWAIT);
>   				if (xas_error(&xas))
>   					goto unlock;
> +
> +				/*
> +				 * Re-set the swap entry after splitting, and the swap
> +				 * offset of the original large entry must be continuous.
> +				 */
> +				for (i = 0; i < 1 << cur_order; i += (1 << split_order)) {
> +					pgoff_t aligned_index = round_down(index, 1 << cur_order);
> +					swp_entry_t tmp;
> +
> +					tmp = swp_entry(swp_type(swap), swp_offset(swap) + i);
> +					__xa_store(&mapping->i_pages, aligned_index + i,
> +						   swp_to_radix_entry(tmp), 0);
> +				}
>   				cur_order = split_order;
>   				split_order =
>   					xas_try_split_min_order(split_order);
>   			}
> -
> -			/*
> -			 * Re-set the swap entry after splitting, and the swap
> -			 * offset of the original large entry must be continuous.
> -			 */
> -			for (i = 0; i < 1 << order; i++) {
> -				pgoff_t aligned_index = round_down(index, 1 << order);
> -				swp_entry_t tmp;
> -
> -				tmp = swp_entry(swp_type(swap), swp_offset(swap) + i);
> -				__xa_store(&mapping->i_pages, aligned_index + i,
> -					   swp_to_radix_entry(tmp), 0);
> -			}
>   		}
> 
>   unlock:
> @@ -2221,7 +2222,7 @@ static int shmem_split_large_entry(struct inode *inode, pgoff_t index,
>   	if (xas_error(&xas))
>   		return xas_error(&xas);
> 
> -	return split_order;
> +	return entry_order;
>   }
> 
>   /*
> 
> 
> Best Regards,
> Yan, Zi
--------------Ccw1TJVnax7Zyya7x2C0Xm84
Content-Type: text/plain; charset=UTF-8; name="shmem_aligned_swapin.c"
Content-Disposition: attachment; filename="shmem_aligned_swapin.c"
Content-Transfer-Encoding: base64

I2luY2x1ZGUgPHN0ZGlvLmg+CiNpbmNsdWRlIDxzdGRsaWIuaD4KI2luY2x1ZGUgPHN5cy9t
bWFuLmg+CiNpbmNsdWRlIDxzeXMvd2FpdC5oPgojaW5jbHVkZSA8dW5pc3RkLmg+CiNpbmNs
dWRlIDxzdHJpbmcuaD4KCiNpZm5kZWYgTUFEVl9QQUdFT1VUCiNkZWZpbmUgTUFEVl9QQUdF
T1VUIDIxCiNlbmRpZgoKLyogMUcgc2l6ZSB0ZXN0aW5nICovCnN0YXRpYyBpbnQgU0laRSA9
IDEwMjRVTCoxMDI0KjEwMjQ7Ci8vc3RhdGljIGludCBTSVpFID0gMlVMKjEwMjQqMTAyNDsK
Ly9zdGF0aWMgaW50IFNJWkUgPSA2NCoxMDI0OwoKaW50IG1haW4odm9pZCkKewoJcGlkX3Qg
cGlkOwoJY2hhciAqc2hhcmVkX21lbW9yeSA9IG1tYXAoTlVMTCwgU0laRSwgUFJPVF9SRUFE
IHwgUFJPVF9XUklURSwgTUFQX1NIQVJFRCB8IE1BUF9BTk9OWU1PVVMsIC0xLCAwKTsKCglp
ZiAoc2hhcmVkX21lbW9yeSA9PSBNQVBfRkFJTEVEKSB7CgkJcGVycm9yKCJtbWFwIGZhaWxl
ZCIpOwoJCWV4aXQoRVhJVF9GQUlMVVJFKTsKCX0KCgkvL3BvcHVsYXRlIHRoZSBzaG1lbQoJ
bWVtc2V0KHNoYXJlZF9tZW1vcnksIDB4YWEsIFNJWkUpOwoKCS8qIGNyZWF0ZSBjaGlsZCAq
LwoJcGlkID0gZm9yaygpOwoJaWYgKHBpZCA8IDApIHsKCQlwZXJyb3IoImZvcmsgZmFpbGVk
Iik7CgkJZXhpdChFWElUX0ZBSUxVUkUpOwoJfSBlbHNlIGlmIChwaWQgPT0gMCkgewoJCXBy
aW50ZigiQ2hpbGQgcHJvY2VzcyBzZWVzIHNoYXJlZF9tZW1vcnlbMHglbHhdID0gJWRcbiIs
ICh1bnNpZ25lZCBsb25nKXNoYXJlZF9tZW1vcnksICpzaGFyZWRfbWVtb3J5KTsKCQkoKnNo
YXJlZF9tZW1vcnkpKys7CgkJcHJpbnRmKCJDaGlsZCBwcm9jZXNzIGluY3JlbWVudGVkIHNo
YXJlZF9tZW1vcnkgdG8gJWRcbiIsICpzaGFyZWRfbWVtb3J5KTsKCQlleGl0KDApOwoJfSBl
bHNlIHsKCQkvKiBwYXJlbnQ6d2FpdCBmb3IgY2hpbGQgdG8gY29tcGxldGUgKi8KCQl3YWl0
KE5VTEwpOwoJCXByaW50ZigiUGFyZW50IHByb2Nlc3Mgc2VlcyBzaGFyZWRfbWVtb3J5ID0g
JWRcbiIsICpzaGFyZWRfbWVtb3J5KTsKCQkoKnNoYXJlZF9tZW1vcnkpKys7CgkJcHJpbnRm
KCJQYXJlbnQgcHJvY2VzcyBpbmNyZW1lbnRlZCBzaGFyZWRfbWVtb3J5IHRvICVkXG4iLCAq
c2hhcmVkX21lbW9yeSk7Cgl9CgoJaWYgKG1hZHZpc2Uoc2hhcmVkX21lbW9yeSwgU0laRSwg
TUFEVl9QQUdFT1VUKSkgewoJCXBlcnJvcigibWFkdmlzZShNQURWX0hVR0VQQUdFKSIpOwoJ
CWV4aXQoMSk7Cgl9CgoJaWYgKG1hZHZpc2Uoc2hhcmVkX21lbW9yeSwgU0laRSwgTUFEVl9Q
QUdFT1VUKSkgewoJCXBlcnJvcigibWFkdmlzZShNQURWX0hVR0VQQUdFKSIpOwoJCWV4aXQo
MSk7Cgl9CgoJbWVtc2V0KHNoYXJlZF9tZW1vcnksIDAsIFNJWkUpOwoKCWlmIChtdW5tYXAo
c2hhcmVkX21lbW9yeSwgU0laRSkgPT0gLTEpIHsKCQlwZXJyb3IoIm11bm1hcCBmYWlsZWQi
KTsKCQlleGl0KEVYSVRfRkFJTFVSRSk7Cgl9CglyZXR1cm4gMDsKfQoK
--------------Ccw1TJVnax7Zyya7x2C0Xm84
Content-Type: text/plain; charset=UTF-8; name="shmem_nonaligned_swapin.c"
Content-Disposition: attachment; filename="shmem_nonaligned_swapin.c"
Content-Transfer-Encoding: base64

I2luY2x1ZGUgPHN0ZGlvLmg+CiNpbmNsdWRlIDxzdGRsaWIuaD4KI2luY2x1ZGUgPHN5cy9t
bWFuLmg+CiNpbmNsdWRlIDxzeXMvd2FpdC5oPgojaW5jbHVkZSA8dW5pc3RkLmg+CiNpbmNs
dWRlIDxzdHJpbmcuaD4KCiNpZm5kZWYgTUFEVl9QQUdFT1VUCiNkZWZpbmUgTUFEVl9QQUdF
T1VUIDIxCiNlbmRpZgoKLyogMUcgc2l6ZSB0ZXN0aW5nICovCnN0YXRpYyBpbnQgU0laRSA9
IDEwMjRVTCoxMDI0KjEwMjQ7Ci8vc3RhdGljIGludCBTSVpFID0gMlVMKjEwMjQqMTAyNDsK
Ly9zdGF0aWMgaW50IFNJWkUgPSA2NCoxMDI0OwoKaW50IG1haW4odm9pZCkKewoJcGlkX3Qg
cGlkOwoJY2hhciAqc2Vjb25kX21lbW9yeTsKCWludCBpOwoJY2hhciAqc2hhcmVkX21lbW9y
eSA9IG1tYXAoTlVMTCwgU0laRSwgUFJPVF9SRUFEIHwgUFJPVF9XUklURSwgTUFQX1NIQVJF
RCB8IE1BUF9BTk9OWU1PVVMsIC0xLCAwKTsKCglpZiAoc2hhcmVkX21lbW9yeSA9PSBNQVBf
RkFJTEVEKSB7CgkJcGVycm9yKCJtbWFwIGZhaWxlZCIpOwoJCWV4aXQoRVhJVF9GQUlMVVJF
KTsKCX0KCgkvL3BvcHVsYXRlIHRoZSBzaG1lbQoJbWVtc2V0KHNoYXJlZF9tZW1vcnksIDB4
YWEsIFNJWkUpOwoKCS8qIGNyZWF0ZSBjaGlsZCAqLwoJcGlkID0gZm9yaygpOwoJaWYgKHBp
ZCA8IDApIHsKCQlwZXJyb3IoImZvcmsgZmFpbGVkIik7CgkJZXhpdChFWElUX0ZBSUxVUkUp
OwoJfSBlbHNlIGlmIChwaWQgPT0gMCkgewoJCXByaW50ZigiQ2hpbGQgcHJvY2VzcyBzZWVz
IHNoYXJlZF9tZW1vcnlbMHglbHhdID0gJWRcbiIsICh1bnNpZ25lZCBsb25nKXNoYXJlZF9t
ZW1vcnksICpzaGFyZWRfbWVtb3J5KTsKCQkoKnNoYXJlZF9tZW1vcnkpKys7CgkJcHJpbnRm
KCJDaGlsZCBwcm9jZXNzIGluY3JlbWVudGVkIHNoYXJlZF9tZW1vcnkgdG8gJWRcbiIsICpz
aGFyZWRfbWVtb3J5KTsKCQlleGl0KDApOwoJfSBlbHNlIHsKCQkvKiBwYXJlbnQ6d2FpdCBm
b3IgY2hpbGQgdG8gY29tcGxldGUgKi8KCQl3YWl0KE5VTEwpOwoJCXByaW50ZigiUGFyZW50
IHByb2Nlc3Mgc2VlcyBzaGFyZWRfbWVtb3J5ID0gJWRcbiIsICpzaGFyZWRfbWVtb3J5KTsK
CQkoKnNoYXJlZF9tZW1vcnkpKys7CgkJcHJpbnRmKCJQYXJlbnQgcHJvY2VzcyBpbmNyZW1l
bnRlZCBzaGFyZWRfbWVtb3J5IHRvICVkXG4iLCAqc2hhcmVkX21lbW9yeSk7Cgl9CgoJaWYg
KG1hZHZpc2Uoc2hhcmVkX21lbW9yeSwgU0laRSwgTUFEVl9QQUdFT1VUKSkgewoJCXBlcnJv
cigibWFkdmlzZShNQURWX0hVR0VQQUdFKSIpOwoJCWV4aXQoMSk7Cgl9CgoJaWYgKG1hZHZp
c2Uoc2hhcmVkX21lbW9yeSwgU0laRSwgTUFEVl9QQUdFT1VUKSkgewoJCXBlcnJvcigibWFk
dmlzZShNQURWX0hVR0VQQUdFKSIpOwoJCWV4aXQoMSk7Cgl9CgoJLy9zd2FwIGluIHNobWVt
IHdpdGhvdXQgYWxpZ25lZCA2NGsKCXNlY29uZF9tZW1vcnkgPSBzaGFyZWRfbWVtb3J5ICsg
NDA5NiAqIDM7Cglmb3IgKGkgPSAwOyBpIDwgU0laRTsgaSArPSA0MDk2ICogMTYpIHsKCQkq
KHNlY29uZF9tZW1vcnkgKyBpKSA9IChjaGFyKWk7CgkJKihzZWNvbmRfbWVtb3J5ICsgaSAr
IDQwOTYgKiAzKSA9IChjaGFyKWk7CgkJKihzZWNvbmRfbWVtb3J5ICsgaSArIDQwOTYgKiAx
MCkgPSAoY2hhcilpOwoJfQoKCWlmIChtdW5tYXAoc2hhcmVkX21lbW9yeSwgU0laRSkgPT0g
LTEpIHsKCQlwZXJyb3IoIm11bm1hcCBmYWlsZWQiKTsKCQlleGl0KEVYSVRfRkFJTFVSRSk7
Cgl9CglyZXR1cm4gMDsKfQoK
--------------Ccw1TJVnax7Zyya7x2C0Xm84
Content-Type: text/plain; charset=UTF-8; name="shmem_concurrent_swapin.c"
Content-Disposition: attachment; filename="shmem_concurrent_swapin.c"
Content-Transfer-Encoding: base64

I2luY2x1ZGUgPHN0ZGlvLmg+CiNpbmNsdWRlIDxzdGRsaWIuaD4KI2luY2x1ZGUgPHN5cy9t
bWFuLmg+CiNpbmNsdWRlIDxzeXMvd2FpdC5oPgojaW5jbHVkZSA8dW5pc3RkLmg+CiNpbmNs
dWRlIDxzdHJpbmcuaD4KCiNpZm5kZWYgTUFEVl9QQUdFT1VUCiNkZWZpbmUgTUFEVl9QQUdF
T1VUIDIxCiNlbmRpZgoKLyogMUcgc2l6ZSB0ZXN0aW5nICovCnN0YXRpYyB1bnNpZ25lZCBs
b25nIFNJWkUgPSAxMFVMKjEwMjQqMTAyNCoxMDI0OwovL3N0YXRpYyBpbnQgU0laRSA9IDJV
TCoxMDI0KjEwMjQ7Ci8vc3RhdGljIGludCBTSVpFID0gNjQqMTAyNDsKCnN0YXRpYyB2b2lk
IGNoaWxkX3N3YXBpbl9zaG1lbShjaGFyICpzaGFyZWRfbWVtb3J5KQp7CgljaGFyICpzZWNv
bmRfbWVtb3J5OwoJaW50IGk7CgoJLy9zd2FwIGluIHNobWVtIHdpdGhvdXQgYWxpZ25lZCA2
NGsKCXNlY29uZF9tZW1vcnkgPSBzaGFyZWRfbWVtb3J5ICsgNDA5NiAqIDI7Cglmb3IgKGkg
PSAwOyBpIDwgU0laRTsgaSArPSA0MDk2ICogMTYpIHsKCQkqKHNlY29uZF9tZW1vcnkgKyBp
KSA9IChjaGFyKWk7CgkJKihzZWNvbmRfbWVtb3J5ICsgaSArIDQwOTYgKiA0KSA9IChjaGFy
KWk7CgkJKihzZWNvbmRfbWVtb3J5ICsgaSArIDQwOTYgKiA5KSA9IChjaGFyKWk7Cgl9Cn0K
CmludCBtYWluKHZvaWQpCnsKCXBpZF90IHBpZDsKCWNoYXIgKnNlY29uZF9tZW1vcnk7Cglp
bnQgaTsKCWNoYXIgKnNoYXJlZF9tZW1vcnkgPSBtbWFwKE5VTEwsIFNJWkUsIFBST1RfUkVB
RCB8IFBST1RfV1JJVEUsIE1BUF9TSEFSRUQgfCBNQVBfQU5PTllNT1VTLCAtMSwgMCk7CgoJ
aWYgKHNoYXJlZF9tZW1vcnkgPT0gTUFQX0ZBSUxFRCkgewoJCXBlcnJvcigibW1hcCBmYWls
ZWQiKTsKCQlleGl0KEVYSVRfRkFJTFVSRSk7Cgl9CgoJLy9wb3B1bGF0ZSB0aGUgc2htZW0K
CW1lbXNldChzaGFyZWRfbWVtb3J5LCAweGFhLCBTSVpFKTsKCgkvKiBzd2Fwb3V0IGFsbCBz
aG1lbSAqLwoJaWYgKG1hZHZpc2Uoc2hhcmVkX21lbW9yeSwgU0laRSwgTUFEVl9QQUdFT1VU
KSkgewogICAgICAgICAgICAgICAgcGVycm9yKCJtYWR2aXNlKE1BRFZfSFVHRVBBR0UpIik7
CiAgICAgICAgICAgICAgICBleGl0KDEpOwogICAgICAgIH0KCiAgICAgICAgaWYgKG1hZHZp
c2Uoc2hhcmVkX21lbW9yeSwgU0laRSwgTUFEVl9QQUdFT1VUKSkgewogICAgICAgICAgICAg
ICAgcGVycm9yKCJtYWR2aXNlKE1BRFZfSFVHRVBBR0UpIik7CiAgICAgICAgICAgICAgICBl
eGl0KDEpOwogICAgICAgIH0KCgkvKiBjcmVhdGUgY2hpbGQgKi8KCXBpZCA9IGZvcmsoKTsK
CWlmIChwaWQgPCAwKSB7CgkJcGVycm9yKCJmb3JrIGZhaWxlZCIpOwoJCWV4aXQoRVhJVF9G
QUlMVVJFKTsKCX0gZWxzZSBpZiAocGlkID09IDApIHsKCQlwcmludGYoIkNoaWxkIHByb2Nl
c3Mgc2VlcyBzaGFyZWRfbWVtb3J5WzB4JWx4XSA9ICVkXG4iLCAodW5zaWduZWQgbG9uZylz
aGFyZWRfbWVtb3J5LCAqc2hhcmVkX21lbW9yeSk7CgkJKCpzaGFyZWRfbWVtb3J5KSsrOwoJ
CWNoaWxkX3N3YXBpbl9zaG1lbShzaGFyZWRfbWVtb3J5KTsKCQlwcmludGYoIkNoaWxkIHBy
b2Nlc3MgaW5jcmVtZW50ZWQgc2hhcmVkX21lbW9yeSB0byAlZFxuIiwgKnNoYXJlZF9tZW1v
cnkpOwoJCWV4aXQoMCk7Cgl9IGVsc2UgewoJCXByaW50ZigiUGFyZW50IHByb2Nlc3Mgc2Vl
cyBzaGFyZWRfbWVtb3J5ID0gJWRcbiIsICpzaGFyZWRfbWVtb3J5KTsKCQkoKnNoYXJlZF9t
ZW1vcnkpKys7CgkJcHJpbnRmKCJQYXJlbnQgcHJvY2VzcyBpbmNyZW1lbnRlZCBzaGFyZWRf
bWVtb3J5IHRvICVkXG4iLCAqc2hhcmVkX21lbW9yeSk7Cgl9CgoJLy9zd2FwIGluIHNobWVt
IHdpdGhvdXQgYWxpZ25lZCA2NGsKCXNlY29uZF9tZW1vcnkgPSBzaGFyZWRfbWVtb3J5ICsg
NDA5NiAqIDM7Cglmb3IgKGkgPSAwOyBpIDwgU0laRTsgaSArPSA0MDk2ICogMTYpIHsKCQkq
KHNlY29uZF9tZW1vcnkgKyBpKSA9IChjaGFyKWk7CgkJKihzZWNvbmRfbWVtb3J5ICsgaSAr
IDQwOTYgKiAzKSA9IChjaGFyKWk7CgkJKihzZWNvbmRfbWVtb3J5ICsgaSArIDQwOTYgKiAx
MCkgPSAoY2hhcilpOwoJfQoKCS8qIHBhcmVudDp3YWl0IGZvciBjaGlsZCB0byBjb21wbGV0
ZSAqLwoJd2FpdChOVUxMKTsKCglpZiAobXVubWFwKHNoYXJlZF9tZW1vcnksIFNJWkUpID09
IC0xKSB7CgkJcGVycm9yKCJtdW5tYXAgZmFpbGVkIik7CgkJZXhpdChFWElUX0ZBSUxVUkUp
OwoJfQoJcmV0dXJuIDA7Cn0KCg==

--------------Ccw1TJVnax7Zyya7x2C0Xm84--

