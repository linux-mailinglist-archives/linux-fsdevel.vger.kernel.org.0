Return-Path: <linux-fsdevel+bounces-6830-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29D9281D433
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Dec 2023 14:33:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCD7C1F22925
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Dec 2023 13:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F49D516;
	Sat, 23 Dec 2023 13:33:44 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64DFD300;
	Sat, 23 Dec 2023 13:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav312.sakura.ne.jp (fsav312.sakura.ne.jp [153.120.85.143])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 3BNDXCaO091885;
	Sat, 23 Dec 2023 22:33:12 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav312.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav312.sakura.ne.jp);
 Sat, 23 Dec 2023 22:33:12 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav312.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 3BNDXB7O091879
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 23 Dec 2023 22:33:12 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <bca8d526-2397-4ca5-b1d6-5758c9334a81@I-love.SAKURA.ne.jp>
Date: Sat, 23 Dec 2023 22:33:11 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] fs/ntfs3: Use kvmalloc instead of kmalloc(...
 __GFP_NOWARN)
Content-Language: en-US
To: Matthew Wilcox <willy@infradead.org>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: ntfs3@lists.linux.dev,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
References: <e41f6717-7c70-edf2-2d3a-8034840d14c5@paragon-software.com>
 <890222ac-1bd2-6817-7873-390801c5a172@paragon-software.com>
 <ZYZmFPnJAM3aJLlF@casper.infradead.org>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <ZYZmFPnJAM3aJLlF@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2023/12/23 13:46, Matthew Wilcox wrote:
> On Mon, Jul 03, 2023 at 11:26:36AM +0400, Konstantin Komarov wrote:
>>
>> Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
> 
> So, um, why?  I mean, I know what kvmalloc does, but why do you want to
> do it?  Also, this is missing changes from kfree() to kvfree() so if
> you do end up falling back to vmalloc, you'll hit a bug in kfree().

Right. The first thing we should do is to revert commit fc471e39e38f("fs/ntfs3:
Use kvmalloc instead of kmalloc(... __GFP_NOWARN)"), for that commit is horrible.

> 
>> +++ b/fs/ntfs3/attrlist.c
>> @@ -52,7 +52,8 @@ int ntfs_load_attr_list(struct ntfs_inode *ni, struct
>> ATTRIB *attr)
>>
>>      if (!attr->non_res) {
>>          lsize = le32_to_cpu(attr->res.data_size);
>> -        le = kmalloc(al_aligned(lsize), GFP_NOFS | __GFP_NOWARN);
>> +        /* attr is resident: lsize < record_size (1K or 4K) */
>> +        le = kvmalloc(al_aligned(lsize), GFP_KERNEL);

syzbot is reporting that

  /* attr is resident: lsize < record_size (1K or 4K) */

was false at https://syzkaller.appspot.com/bug?extid=f987ceaddc6bcc334cde .
Maybe you can fix this report by adding more validations. Please be
sure to take into account that the filesystem image is corrupted/crafted.

But you can't replace GFP_NOFS with GFP_KERNEL anyway, for syzbot is also
reporting GFP_KERNEL allocation with filesystem lock held
at https://syzkaller.appspot.com/bug?extid=18f543fc90dd1194c616 .

By the way, you might want to add __GFP_RETRY_MAYFAIL when you can't use
GFP_KERNEL, for GFP_NOFS memory allocation request cannot trigger OOM
killer in order to allocate requested amount of memory, leading to
possibility of out-of-memory deadlock. Especially when there is possibility
that kvmalloc() needs to allocate so many pages...
See https://elixir.bootlin.com/linux/v6.7-rc6/source/mm/page_alloc.c#L3458 .


