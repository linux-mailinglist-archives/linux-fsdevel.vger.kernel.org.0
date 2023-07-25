Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B508D761051
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jul 2023 12:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbjGYKLY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Jul 2023 06:11:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231623AbjGYKLW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Jul 2023 06:11:22 -0400
Received: from out-60.mta1.migadu.com (out-60.mta1.migadu.com [95.215.58.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EC7F10FA
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Jul 2023 03:11:14 -0700 (PDT)
Message-ID: <9b0a164d-3d0e-cc57-81b7-ae32bef4e9d7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1690279872;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cp2G6Suk2Avgq5OP5WwoCgbwBHs06hhcMJV7ZyIbEuo=;
        b=VB2J3ghJq5xLs1cyTqWpdXTFvI5iEbfSWggwbTi9iY0JjW0Hdt/TGxEyqNs2FmVp++YRjZ
        kPtzdP0DqA4HqecPpeUutJq0VaB4JIxVB2Mc5/PSnYO5eX1/cEIzSdvNHGCnAVwFeVGfjO
        /8/Z7JCq/4RwPLemJtd10OK/rn2KOfE=
Date:   Tue, 25 Jul 2023 18:11:05 +0800
MIME-Version: 1.0
Subject: Re: [External] [fuse-devel] [PATCH 3/3] fuse: write back dirty pages
 before direct write in direct_io_relax mode
To:     Bernd Schubert <bernd.schubert@fastmail.fm>,
        Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>,
        fuse-devel@lists.sourceforge.net
Cc:     linux-fsdevel@vger.kernel.org, Wanpeng Li <wanpengli@tencent.com>,
        cgxu519@mykernel.net, miklos@szeredi.hu
References: <20230630094602.230573-1-hao.xu@linux.dev>
 <20230630094602.230573-4-hao.xu@linux.dev>
 <e5266e11-b58b-c8ca-a3c8-0b2c07b3a1b2@bytedance.com>
 <2622afd7-228f-02f3-3b72-a1c826844126@linux.dev>
 <396A0BF4-DA68-46F8-9881-3801737225C6@fastmail.fm>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Hao Xu <hao.xu@linux.dev>
In-Reply-To: <396A0BF4-DA68-46F8-9881-3801737225C6@fastmail.fm>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/21/23 19:56, Bernd Schubert wrote:
> On July 21, 2023 1:27:26 PM GMT+02:00, Hao Xu <hao.xu@linux.dev> wrote:
>> On 7/21/23 14:35, Jiachen Zhang wrote:
>>>
>>> On 2023/6/30 17:46, Hao Xu wrote:
>>>> From: Hao Xu <howeyxu@tencent.com>
>>>>
>>>> In direct_io_relax mode, there can be shared mmaped files and thus dirty
>>>> pages in its page cache. Therefore those dirty pages should be written
>>>> back to backend before direct write to avoid data loss.
>>>>
>>>> Signed-off-by: Hao Xu <howeyxu@tencent.com>
>>>> ---
>>>>    fs/fuse/file.c | 7 +++++++
>>>>    1 file changed, 7 insertions(+)
>>>>
>>>> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
>>>> index 176f719f8fc8..7c9167c62bf6 100644
>>>> --- a/fs/fuse/file.c
>>>> +++ b/fs/fuse/file.c
>>>> @@ -1485,6 +1485,13 @@ ssize_t fuse_direct_io(struct fuse_io_priv *io, struct iov_iter *iter,
>>>>        if (!ia)
>>>>            return -ENOMEM;
>>>> +    if (fopen_direct_write && fc->direct_io_relax) {
>>>> +        res = filemap_write_and_wait_range(mapping, pos, pos + count - 1);
>>>> +        if (res) {
>>>> +            fuse_io_free(ia);
>>>> +            return res;
>>>> +        }
>>>> +    }
>>>>        if (!cuse && fuse_range_is_writeback(inode, idx_from, idx_to)) {
>>>>            if (!write)
>>>>                inode_lock(inode);
>>>
>>> Tested-by: Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
>>>
>>>
>>> Looks good to me.
>>>
>>> By the way, the behaviour would be a first FUSE_WRITE flushing the page cache, followed by a second FUSE_WRITE doing the direct IO. In the future, further optimization could be first write into the page cache and then flush the dirty page to the FUSE daemon.
>>>
>>
>> I think this makes sense, cannot think of any issue in it for now, so
>> I'll do that change and send next version, super thanks, Jiachen!
>>
>> Thanks,
>> Hao
>>
>>>
>>> Thanks,
>>> Jiachen
>>
> 
> On my phone, sorry if mail formatting is not optimal.
> Do I understand it right? You want DIO code path copy into pages and then flush/invalidate these pages? That would be punish DIO for for the unlikely case there are also dirty pages (discouraged IO pattern).

Hi Bernd,
I think I don't get what you said, why it is punishment and why it's 
discouraged IO pattern?
On my first eyes seeing Jiachen's idea, I was thinking "that sounds
disobeying direct write semantics" because usually direct write is
"flush dirty page -> invalidate page -> write data through to backend"
not "write data to page -> flush dirty page/(writeback data)"
The latter in worst case write data both to page cache and backend
while the former just write to backend and load it to the page cache
when buffered reading. But seems there is no such "standard way" which
says we should implement direct IO in that way.

Regards,
Hao

