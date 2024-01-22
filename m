Return-Path: <linux-fsdevel+bounces-8456-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 237CF836D5C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 18:29:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A90371F23260
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 17:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A1246E2AB;
	Mon, 22 Jan 2024 16:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="amU3C5ri"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA266DD1E;
	Mon, 22 Jan 2024 16:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705940970; cv=none; b=k6UJcfqAbdYGbgv7iHtdofrEaCOq6XOMQjYUe6PB90vOzh4JrXulPygtLA2opWkyfzzlVieISjDMqSdvTZpxKOF+UldyeZTjXiA2al0oazUAIj9jiQEmQjxl1bFWqNgL46SSi/7BMjEJdmgaqJl/3fDQAsg78cU6aWWJ+iPbcEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705940970; c=relaxed/simple;
	bh=vl+R0rWWXZHC8ghf5EWIkrJi2cNEQrmwA3Y9oRwhUbE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=lWMD3QrnglUAgk5Oui0GaOVlebrxYrQNuhJcBg5VbDDrxp0eJQVETMUEn/qJmTwrBuJ/47kq62Ph1Mt8s4T7w0tlUa7TitTRuoQiO3Ea4nc3w+2bpxGe/OZuUU/oQHpWGCDv/AvrXRQ1qgEL8ERyrowQjEDa65nxNqdqj3+evWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=amU3C5ri; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40MDqQlp012522;
	Mon, 22 Jan 2024 16:29:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=wRN+W7s0zbBB8ytoJUN8VhJYn1r1TrlpBUStEouQaMk=; b=am
	U3C5riLs9hr5uu/u5qpOtjkte4r2hTJELgXhFY/YoHDB14kNINnS2yVfrRqP4opv
	TKw/UoKcWaTZNi5GClGWCUUiuPwpiD0YvEKvsYW651ualr61LxYz4darcoLxW7Sr
	lBX69vJYw2FqYmaQT8vMRdWqSAHo1KUSaF34AsCgzaS3Dz6+xI8k1969iVgvKNhv
	mMugUtEGe4opUd2tndMeIyDlwxyioYdbb6DnnQzKHI3GQDZYs//zTaS2k75HQmRb
	+7A/H7hiNLazzfKlFFUG1923d0d3iBMoIyUBQ6YvKO+SfFg/tYiOV579vn8yEWqp
	9iOyO42qFHThPrBYbIXw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vskn19bt3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jan 2024 16:29:06 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40MGT52M014482
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jan 2024 16:29:05 GMT
Received: from [10.216.2.182] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 22 Jan
 2024 08:29:02 -0800
Message-ID: <e095c3dd-42e0-fc4f-5670-7db6393e96a7@quicinc.com>
Date: Mon, 22 Jan 2024 21:58:58 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] fs: improve dump_mapping() robustness
Content-Language: en-US
To: Baolin Wang <baolin.wang@linux.alibaba.com>,
        Al Viro
	<viro@zeniv.linux.org.uk>
CC: <akpm@linux-foundation.org>, <willy@infradead.org>, <brauner@kernel.org>,
        <jack@suse.cz>, <linux-mm@kvack.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <937ab1f87328516821d39be672b6bc18861d9d3e.1705391420.git.baolin.wang@linux.alibaba.com>
 <20240118013857.GO1674809@ZenIV>
 <d5979f89-7a84-423a-a1c7-29bdbf7c2bc1@linux.alibaba.com>
 <c85fffe6-e455-d0fa-e332-87e81e0a0e86@quicinc.com>
 <8f52414c-e0f2-4931-9b32-5c22f1d581f0@linux.alibaba.com>
From: Charan Teja Kalla <quic_charante@quicinc.com>
In-Reply-To: <8f52414c-e0f2-4931-9b32-5c22f1d581f0@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: dKDExpz0nIEfAfSqdeFPCW848sObxDsl
X-Proofpoint-ORIG-GUID: dKDExpz0nIEfAfSqdeFPCW848sObxDsl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-22_07,2024-01-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 mlxlogscore=691 priorityscore=1501 impostorscore=0 phishscore=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401220113



On 1/22/2024 12:47 PM, Baolin Wang wrote:
>>
>> We too seen the below crash while printing the dentry name.
>>
>> aops:shmem_aops ino:5e029 dentry name:"dev/zero"
>> flags:
>> 0x8000000000080006(referenced|uptodate|swapbacked|zone=2|kasantag=0x0)
>> raw: 8000000000080006 ffffffc033b1bb60 ffffffc033b1bb60 ffffff8862537600
>> raw: 0000000000000001 0000000000000000 00000003ffffffff ffffff807fe64000
>> page dumped because: migration failure
>> migrating pfn aef223 failed ret:1
>> page:000000009e72a120 refcount:3 mapcount:0 mapping:000000003325dda1
>> index:0x1 pfn:0xaef223
>> memcg:ffffff807fe64000
>> Unable to handle kernel NULL pointer dereference at virtual address
>> 0000000000000000
>> Mem abort info:
>>    ESR = 0x0000000096000005
>>    EC = 0x25: DABT (current EL), IL = 32 bits
>>    SET = 0, FnV = 0
>>    EA = 0, S1PTW = 0
>>    FSC = 0x05: level 1 translation fault
>> Data abort info:
>>    ISV = 0, ISS = 0x00000005
>>    CM = 0, WnR = 0
>> user pgtable: 4k pages, 39-bit VAs, pgdp=000000090c12d000
>> [0000000000000000] pgd=0000000000000000, p4d=0000000000000000,
>> pud=0000000000000000
>> Internal error: Oops: 0000000096000005 [#1] PREEMPT SMP
>>
>> dentry_name+0x1f8/0x3a8
>> pointer+0x3b0/0x6b8
>> vsnprintf+0x4a4/0x65c
>> vprintk_store+0x168/0x4a8
>> vprintk_emit+0x98/0x218
>> vprintk_default+0x44/0x70
>> vprintk+0xf0/0x138
>> _printk+0x54/0x80
>> dump_mapping+0x17c/0x188
>> dump_page+0x1d0/0x2e8
>> offline_pages+0x67c/0x898
>>
>>
>>
>> Not much comfortable with block layer internals, TMK, the below is what
>> happening in the my case:
>> memoffline                 dput()
>> (offline_pages)         (as part of closing of the shmem file)
>> ------------         --------------------------------------
>>                     .......
>>             1) dentry_unlink_inode()
>>                   hlist_del_init(&dentry->d_u.d_alias);
>>
>>             2) iput():
>>                 a) inode->i_state |= I_FREEING
>>                 .....
>>                 b) evict_inode()->..->shmem_undo_range
>>                    1) get the folios with elevated refcount
>> 3) do_migrate_range():
>>     a) Because of the elevated
>>     refcount in 2.b.1, the
>>     migration of this page will
>>     be failed.
>>
>>                    2) truncate_inode_folio() ->
>>                      filemap_remove_folio():
>>                   (deletes from the page cache,
>>                  set page->mapping=NULL,
>>                  decrement the refcount on folio)
>>    b) Call dump_page():
>>       1) mapping = page_mapping(page);
>>       2) dump_mapping(mapping)
>>       a) We unlinked the dentry in 1)
>>             thus dentry_ptr from host->i_dentry.first
>>             is not a proper one.
>>
>>           b) dentry name print with %pd is resulting into
>>        the mentioned crash.
>>
>>
>> At least in this case, I think __this patchset in its current form can
>> help us__.
> 
> This looks another case of NULL pointer access. Thanks for the detailed
> analysis. Could you provide a Tested-by or Reviewed-by tag if it can
> solve your problem?
Seen this issue couple of times, over 3 months back. Not sure if we ever
encounter this issue again. Still, will pick this and let you know the
side effects of this patch, after thorough testing.

Thanks.

