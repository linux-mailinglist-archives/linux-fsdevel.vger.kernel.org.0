Return-Path: <linux-fsdevel+bounces-30491-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C6D298BB77
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 13:44:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DE1B1C23531
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 11:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 754E41C1AB3;
	Tue,  1 Oct 2024 11:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="E2Sms+vA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from forward502a.mail.yandex.net (forward502a.mail.yandex.net [178.154.239.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E1D1C0DE8;
	Tue,  1 Oct 2024 11:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727783060; cv=none; b=Vk1v96FC1VpAJBTEVYAGf3lzrj2/tGRlzXddWHzmOYgbAA1SHqPcgfLLP++bAp/MPhB/qY8HIa3O5pI7lfqnbRGm+cyOqIrhFVaTsWVhDXYE65WzBmjs06xPH/mnLN2m/Pr81QCtaI5Zal8CrkSjhtjiV0vkcvtKjjb7Y2ozXqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727783060; c=relaxed/simple;
	bh=vf5UiZA0vTJSGISspXXbncYGj9jU7xRtOyVNA/MviVU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YmN5sda0ZnIU5ESTQjq3SxLxYo+61q5rEgmlLQjGutYA8cWcXE29cf/ZIuIsEB28uY56iYNtQEBEo5dx6qlKa1ULvKXBzk7DEIBo8rw5tXJoqABQEuEKZip6M6xI52yeWs/Y1mxatB2323QB6IisjkG+rKrgpJEdPUujAN0SifM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=E2Sms+vA; arc=none smtp.client-ip=178.154.239.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-55.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-55.vla.yp-c.yandex.net [IPv6:2a02:6b8:c0f:604:0:640:5e0e:0])
	by forward502a.mail.yandex.net (Yandex) with ESMTPS id 6DB5261731;
	Tue,  1 Oct 2024 14:37:23 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-55.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id JbYXgU6uG4Y0-xzpIRnzq;
	Tue, 01 Oct 2024 14:37:22 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1727782642; bh=nkUi1re8xSaX4VEbWTAH8Gbnb9x5lV8m5bMF1DhNAKY=;
	h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
	b=E2Sms+vAggUNd9njWTLIKE+Q+iyP0cW9aXjfY52hI4t8tVdPCIcEwLr2Q8wdxMm/r
	 iZZtbLto9JqK88zcwzhQwbxWv/UpeK6BUM6SOadNobVyFEWi8kSmL0n5Xbx83ZWwmC
	 47RzdYWIAwQRN/fkKB2oNPJthHKNBOHm0P3vQUU4=
Authentication-Results: mail-nwsmtp-smtp-production-main-55.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <02ae38f6-698c-496f-9e96-1376ef9f1332@yandex.ru>
Date: Tue, 1 Oct 2024 14:37:18 +0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] add group restriction bitmap
To: Oleg Nesterov <oleg@redhat.com>
Cc: linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Jens Axboe <axboe@kernel.dk>, Andrew Morton <akpm@linux-foundation.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Florent Revest <revest@chromium.org>, Kees Cook <kees@kernel.org>,
 Palmer Dabbelt <palmer@rivosinc.com>, Charlie Jenkins
 <charlie@rivosinc.com>, Benjamin Gray <bgray@linux.ibm.com>,
 Helge Deller <deller@gmx.de>, Zev Weiss <zev@bewilderbeest.net>,
 Samuel Holland <samuel.holland@sifive.com>, linux-fsdevel@vger.kernel.org,
 Eric Biederman <ebiederm@xmission.com>, Andy Lutomirski <luto@kernel.org>,
 Josh Triplett <josh@joshtriplett.org>
References: <20240930195958.389922-1-stsp2@yandex.ru>
 <20241001111516.GA23907@redhat.com>
Content-Language: en-US
From: stsp <stsp2@yandex.ru>
In-Reply-To: <20241001111516.GA23907@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Yandex-Filter: 1

01.10.2024 14:15, Oleg Nesterov пишет:
> I can't comment the intent, just some nits about implementation.
>
> On 09/30, Stas Sergeev wrote:
>>   struct group_info {
>>   	refcount_t	usage;
>> +	unsigned int	restrict_bitmap;
> Why not unsigned long?

My impl claims to support 31bit only.
Maybe use "unsigned long long" to
get like 63? Isn't "unsigned long"
arch-dependent? What would be the
benefit of an arch-dependent bitmap?

>>   int groups_search(const struct group_info *group_info, kgid_t grp)
>>   {
>>   	unsigned int left, right;
>> @@ -105,7 +108,7 @@ int groups_search(const struct group_info *group_info, kgid_t grp)
>>   		else if (gid_lt(grp, group_info->gid[mid]))
>>   			right = mid;
>>   		else
>> -			return 1;
>> +			return mid + 1;
> Suppose we change groups_search()
>
> 	--- a/kernel/groups.c
> 	+++ b/kernel/groups.c
> 	@@ -104,8 +104,11 @@ int groups_search(const struct group_info *group_info, kgid_t grp)
> 				left = mid + 1;
> 			else if (gid_lt(grp, group_info->gid[mid]))
> 				right = mid;
> 	-		else
> 	-			return 1;
> 	+		else {
> 	+			bool r = mid < BITS_PER_LONG &&
> 	+				 test_bit(mid, &group_info->restrict_bitmap);
> 	+			return r ? -1 : 1;
> 	+		}
> 		}
> 		return 0;
> 	 }
>
> so that it returns, say, -1 if the found grp is restricted.
>
> Then everything else can be greatly simplified, afaics...
This will mean updating all callers
of groups_search(), in_group_p(),
in_egroup_p(), vfsxx_in_group_p()
and so on. Also I am not sure if it really
helps: in_group_p() has also gid, so
if in_group_p() returns -1 for not found
and 0 for gid, then I still need to
increment the retval of groups_search(),
just as I do now.
So unless I am missing your intention,
this isn't really helping.

