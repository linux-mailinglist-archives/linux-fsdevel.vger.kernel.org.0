Return-Path: <linux-fsdevel+bounces-8315-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15CAF832C81
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jan 2024 16:49:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 660E5B2180A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jan 2024 15:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C336054BDF;
	Fri, 19 Jan 2024 15:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nvf669uk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85B554BCB;
	Fri, 19 Jan 2024 15:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705679347; cv=none; b=GNKnO809pyF6mmfPtq/HcZWvZgpoQL5s29yjRPu34TYlXOVQ5BonwMAVIRDE9skSHwvav9wBbUyjgrtVPEhEwOuQGGRt8stgpbJuNPlezKjTwJMGj60HTnDNyd945dN6OTi0BNX2Xh9pIfpWmRoxqta9eu4+hkQqMJ9VGHthfxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705679347; c=relaxed/simple;
	bh=HCWh7lQ/W3HxtWCwtOdwFHHK7Klg3DCi9PmosL7r9yo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=S+W4GbsNR360w0JkSOvTlGazR0UXQhLpRfON1WmKtrOlakJgxFk9xZ5yMxsvRw2tdIqwmdDKivtWBwNpTlTU9EeSlRKo7/nd5OKmIu+1JOJtGWmlDW41eePHDYpLTvTZXu3eHq5vc5s4XEAKgYHG756rVuIV55G+NbA5AzE+P4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=nvf669uk; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40JFMamB013798;
	Fri, 19 Jan 2024 15:48:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=J9ig2IJPl4P+QEzFCNblDiqJod4+v+VvpLkQeSXtsGc=; b=nv
	f669uktnYhKxrOtL5tcoVJYreCLcVtLMFK7Gqhue0TlFOFgHinaQW6+oagC5bq/X
	YxejjpXot7W9LnbNV48FnRMqQ+z9iJfIGwAeKxVZbMxM3AAfi4XYHZ/L7UsEXrqP
	b4WSVp6Y6I6eUSE4KX1RkTIaUmcybRgzltSmcXOiXYX+K8/MZwz9p6AjybPUmPqp
	OeSpc/11hFlJxoOf/muge1+cfAl7fSbbSTOFeyvwMut8fSi2U8PCeUmGWP1eQFtG
	KVfcZvO59E7UTo85rLYk6n0tWoxh6TWwDmEzb97ibGfCkuIcIinpAQzmqOh30xxe
	Y9tFM53BQyAGTW7WKnYw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vq403k6vj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jan 2024 15:48:40 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40JFmdcT004408
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jan 2024 15:48:39 GMT
Received: from [10.216.49.108] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 19 Jan
 2024 07:48:36 -0800
Message-ID: <c85fffe6-e455-d0fa-e332-87e81e0a0e86@quicinc.com>
Date: Fri, 19 Jan 2024 21:18:32 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] fs: improve dump_mapping() robustness
To: Baolin Wang <baolin.wang@linux.alibaba.com>,
        Al Viro
	<viro@zeniv.linux.org.uk>
CC: <akpm@linux-foundation.org>, <willy@infradead.org>, <brauner@kernel.org>,
        <jack@suse.cz>, <linux-mm@kvack.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <937ab1f87328516821d39be672b6bc18861d9d3e.1705391420.git.baolin.wang@linux.alibaba.com>
 <20240118013857.GO1674809@ZenIV>
 <d5979f89-7a84-423a-a1c7-29bdbf7c2bc1@linux.alibaba.com>
Content-Language: en-US
From: Charan Teja Kalla <quic_charante@quicinc.com>
In-Reply-To: <d5979f89-7a84-423a-a1c7-29bdbf7c2bc1@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: QnU7MX2vPrWySRf9jhtVFKZ2LZqmokq7
X-Proofpoint-ORIG-GUID: QnU7MX2vPrWySRf9jhtVFKZ2LZqmokq7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-19_09,2024-01-19_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1011
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 bulkscore=0 phishscore=0
 spamscore=0 adultscore=0 mlxlogscore=741 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2401190088

Hi Matthew/Baolin,

On 1/18/2024 8:13 AM, Baolin Wang wrote:
> 
> 
> On 1/18/2024 9:38 AM, Al Viro wrote:
>> On Tue, Jan 16, 2024 at 03:53:35PM +0800, Baolin Wang wrote:
>>
>>> With checking the 'dentry.parent' and 'dentry.d_name.name' used by
>>> dentry_name(), I can see dump_mapping() will output the invalid dentry
>>> instead of crashing the system when this issue is reproduced again.
>>
>>>       dentry_ptr = container_of(dentry_first, struct dentry,
>>> d_u.d_alias);
>>> -    if (get_kernel_nofault(dentry, dentry_ptr)) {
>>> +    if (get_kernel_nofault(dentry, dentry_ptr) ||
>>> +        !dentry.d_parent || !dentry.d_name.name) {
>>>           pr_warn("aops:%ps ino:%lx invalid dentry:%px\n",
>>>                   a_ops, ino, dentry_ptr);
>>>           return;
>>
>> That's nowhere near enough.  Your ->d_name.name can bloody well be
>> pointing
>> to an external name that gets freed right under you.  Legitimately so.
>>
>> Think what happens if dentry has a long name (longer than would fit into
>> the embedded array) and gets renamed name just after you copy it into
>> a local variable.  Old name will get freed.  Yes, freeing is RCU-delayed,
>> but I don't see anything that would prevent your thread losing CPU
>> and not getting it back until after the sucker's been freed.
> 
> Yes, that's possible. And this appears to be a use-after-free issue in
> the existing code, which is different from the issue that my patch
> addressed.
> 
> So how about adding a rcu_read_lock() before copying the dentry to a
> local variable in case the old name is freed?
> 

We too seen the below crash while printing the dentry name.

aops:shmem_aops ino:5e029 dentry name:"dev/zero"
flags:
0x8000000000080006(referenced|uptodate|swapbacked|zone=2|kasantag=0x0)
raw: 8000000000080006 ffffffc033b1bb60 ffffffc033b1bb60 ffffff8862537600
raw: 0000000000000001 0000000000000000 00000003ffffffff ffffff807fe64000
page dumped because: migration failure
migrating pfn aef223 failed ret:1
page:000000009e72a120 refcount:3 mapcount:0 mapping:000000003325dda1
index:0x1 pfn:0xaef223
memcg:ffffff807fe64000
Unable to handle kernel NULL pointer dereference at virtual address
0000000000000000
Mem abort info:
  ESR = 0x0000000096000005
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x05: level 1 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000005
  CM = 0, WnR = 0
user pgtable: 4k pages, 39-bit VAs, pgdp=000000090c12d000
[0000000000000000] pgd=0000000000000000, p4d=0000000000000000,
pud=0000000000000000
Internal error: Oops: 0000000096000005 [#1] PREEMPT SMP

dentry_name+0x1f8/0x3a8
pointer+0x3b0/0x6b8
vsnprintf+0x4a4/0x65c
vprintk_store+0x168/0x4a8
vprintk_emit+0x98/0x218
vprintk_default+0x44/0x70
vprintk+0xf0/0x138
_printk+0x54/0x80
dump_mapping+0x17c/0x188
dump_page+0x1d0/0x2e8
offline_pages+0x67c/0x898



Not much comfortable with block layer internals, TMK, the below is what
happening in the my case:
memoffline	     		dput()
(offline_pages)		 (as part of closing of the shmem file)
------------		 --------------------------------------
					.......
			1) dentry_unlink_inode()
			      hlist_del_init(&dentry->d_u.d_alias);

			2) iput():
			    a) inode->i_state |= I_FREEING
				.....
			    b) evict_inode()->..->shmem_undo_range
			       1) get the folios with elevated refcount
3) do_migrate_range():
   a) Because of the elevated
   refcount in 2.b.1, the
   migration of this page will
   be failed.

			       2) truncate_inode_folio() ->
				     filemap_remove_folio():
 				(deletes from the page cache,
				 set page->mapping=NULL,
				 decrement the refcount on folio)
  b) Call dump_page():
     1) mapping = page_mapping(page);
     2) dump_mapping(mapping)
	  a) We unlinked the dentry in 1)
           thus dentry_ptr from host->i_dentry.first
           is not a proper one.

         b) dentry name print with %pd is resulting into
	   the mentioned crash.


At least in this case, I think __this patchset in its current form can
help us__.

Thanks,
Charan

