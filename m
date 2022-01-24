Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 047294982C6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jan 2022 15:59:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238414AbiAXO67 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jan 2022 09:58:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26609 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234477AbiAXO66 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jan 2022 09:58:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643036337;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+GyR2hA3d4f/6NdcbYJKilHqrKzexUXOMmjhu38LlLQ=;
        b=i7BjrYXccbameZBmegkmW0RBMWprykByG7GHAMNbAUrfRiEAff3qmi1y9OpPLfSmfG0/eI
        ztkDBuSNej7gZTkgf0z0cfXVQcJBfnhQcjHKTHcNDyMHYNuVMQLeLo1FDpPsOgMQ5Mdxrf
        q58bL7h0RMc6+Vc7ihLM9GPIXsEr5IE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-62-M3P3h5l0PqW5R3AjSzhSZQ-1; Mon, 24 Jan 2022 09:58:54 -0500
X-MC-Unique: M3P3h5l0PqW5R3AjSzhSZQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1D12D1091DA2;
        Mon, 24 Jan 2022 14:58:53 +0000 (UTC)
Received: from [10.22.35.75] (unknown [10.22.35.75])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 836BA7A23A;
        Mon, 24 Jan 2022 14:58:52 +0000 (UTC)
Message-ID: <8e2fa0ee-12e7-b62a-27ef-aa251761d67e@redhat.com>
Date:   Mon, 24 Jan 2022 09:58:52 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] vfs: Pre-allocate superblock in sget_fc() if !test
Content-Language: en-US
To:     Christian Brauner <brauner@kernel.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220121185255.27601-1-longman@redhat.com>
 <20220124113758.y34xceepk7oe26h7@wittgenstein>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20220124113758.y34xceepk7oe26h7@wittgenstein>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/24/22 06:37, Christian Brauner wrote:
> On Fri, Jan 21, 2022 at 01:52:55PM -0500, Waiman Long wrote:
>> When the test function is not defined in sget_fc(), we always need
>> to allocate a new superblock. So there is no point in acquiring the
>> sb_lock twice in this case. Optimize the !test case by pre-allocating
>> the superblock first before acquring the lock.
>>
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>   fs/super.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/fs/super.c b/fs/super.c
>> index a6405d44d4ca..c2bd5c34a826 100644
>> --- a/fs/super.c
>> +++ b/fs/super.c
>> @@ -520,6 +520,8 @@ struct super_block *sget_fc(struct fs_context *fc,
>>   	struct user_namespace *user_ns = fc->global ? &init_user_ns : fc->user_ns;
>>   	int err;
>>   
>> +	if (!test)
>> +		s = alloc_super(fc->fs_type, fc->sb_flags, user_ns);
> Shouldn't we treat this allocation failure as "fatal" right away and not
> bother taking locks, walking lists and so on? Seems strange to treat it
> as fatal below but not here.
I didn't add the null check because it was a rare case and the check is 
done later on anyway. I do agree that it may look a bit odd. Perhaps I 
should rearrange the code flow as suggested.
>
> (The code-flow in here has always been a bit challenging to follow imho.
> So not super keen to see more special-cases in there. Curious: do you
> see any noticeable performance impact from that lock being taken and
> dropped for the !test case?)

I don't believe there is noticeable performance impact with the !test 
case. The test case, however, can have some noticeable impact if the 
superblock list is long. I am wondering if we just always preallocate 
superblock with the risk that it may get unused and freed later on.

Cheers,
Longman

>

