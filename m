Return-Path: <linux-fsdevel+bounces-1887-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 640767DFBF6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 22:22:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EAC21C21036
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 21:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E2A621352;
	Thu,  2 Nov 2023 21:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="eVip9fRF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C3421374
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Nov 2023 21:22:01 +0000 (UTC)
Received: from smtp.smtpout.orange.fr (smtp-30.smtpout.orange.fr [80.12.242.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0B60195
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Nov 2023 14:21:56 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
	by smtp.orange.fr with ESMTPA
	id yf8Rqp7S1uQcKyf8RqIfdN; Thu, 02 Nov 2023 22:21:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1698960113;
	bh=lug65i9SpeCxzvrYTmUZ5JS3Ay8/Kn/DlLaH6z3IhH8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=eVip9fRFNHWDPpYoUlO67CGTnE5aVD6Ok7JeiqTgUzBtEMpoqVHN+1iWRvnokiG2P
	 czruQufq+8nreAWpibk4+WCd0Cov/lPQcJscEMSSMIEsGh8ALpTUebqffPgeqChcsa
	 8Exa7B9LYwVUUUI3w/nzuwfcyAVZislOh6guKhCm1zo2tAqiziVgvhsFGYkOKjUvqH
	 T2oJvZ6DEF/ZkAavYyvi2zpKPutTtFhampzhJAT2KPhF0rq74P8jcTAFL5Qtd8VNQE
	 sTWWEvkjWSU9Ki5PRahWbR1gIO0DZ0Nzmjtp0pRIfju6UwwxLQgsB5ayjX/WpXEdTi
	 GiHD3fvjEeAdg==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 02 Nov 2023 22:21:53 +0100
X-ME-IP: 86.243.2.178
Message-ID: <95fdad28-95d5-4720-811b-8bbef8600830@wanadoo.fr>
Date: Thu, 2 Nov 2023 22:21:51 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] vboxsf: Avoid an spurious warning if load_nls_xxx()
 fails
To: Matthew Wilcox <willy@infradead.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Christoph Hellwig
 <hch@infradead.org>, Al Viro <viro@zeniv.linux.org.uk>,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
References: <d09eaaa4e2e08206c58a1a27ca9b3e81dc168773.1698835730.git.christophe.jaillet@wanadoo.fr>
 <ZUOWS6Vr0rg4VVIb@casper.infradead.org>
Content-Language: fr, en-US
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <ZUOWS6Vr0rg4VVIb@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 02/11/2023 à 13:30, Matthew Wilcox a écrit :
> On Wed, Nov 01, 2023 at 11:49:48AM +0100, Christophe JAILLET wrote:
>> If an load_nls_xxx() function fails a few lines above, the 'sbi->bdi_id' is
>> still 0.
>> So, in the error handling path, we will call ida_simple_remove(..., 0)
>> which is not allocated yet.
>>
>> In order to prevent a spurious "ida_free called for id=0 which is not
>> allocated." message, tweak the error handling path and add a new label.
> 
> That's not spurious!

My fault, as a non-native English speaking man.
I've always sought that spurious was meaning "odd" or "strange", but I 
was wrong :(

Here, a better wording could be "to prevent an un-expected "ida..."".
Is that ok for you?

Or the last sentence could shortened to only "In order to fix it, tweak 
the error handling path and add a new label.".

CJ

> You're freeing something that wasn't allocated.
> A good quality malloc allocation will warn you if you free() a random
> pointer.  I agree with everything abuot this patch (and the next) except
> for the changelog.
> 
>> Fixes: 0fd169576648 ("fs: Add VirtualBox guest shared folder (vboxsf) support")
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> ---
>>   fs/vboxsf/super.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/vboxsf/super.c b/fs/vboxsf/super.c
>> index 1fb8f4df60cb..9848af78215b 100644
>> --- a/fs/vboxsf/super.c
>> +++ b/fs/vboxsf/super.c
>> @@ -151,7 +151,7 @@ static int vboxsf_fill_super(struct super_block *sb, struct fs_context *fc)
>>   		if (!sbi->nls) {
>>   			vbg_err("vboxsf: Count not load '%s' nls\n", nls_name);
>>   			err = -EINVAL;
>> -			goto fail_free;
>> +			goto fail_destroy_idr;
>>   		}
>>   	}
>>   
>> @@ -224,6 +224,7 @@ static int vboxsf_fill_super(struct super_block *sb, struct fs_context *fc)
>>   		ida_simple_remove(&vboxsf_bdi_ida, sbi->bdi_id);
>>   	if (sbi->nls)
>>   		unload_nls(sbi->nls);
>> +fail_destroy_idr:
>>   	idr_destroy(&sbi->ino_idr);
>>   	kfree(sbi);
>>   	return err;
>> -- 
>> 2.34.1
>>
>>
> 
> 


