Return-Path: <linux-fsdevel+bounces-22112-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B5E191268B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 15:21:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 304AC281539
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 13:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0468155C99;
	Fri, 21 Jun 2024 13:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ff2FX4ag"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968FE1EB45;
	Fri, 21 Jun 2024 13:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718976080; cv=none; b=iXt+/pMl+spnvQOJ+ZSGGUrIp/4mur6V1mTtk3A0QmScpI81DkhqucdJs9hrK1KFMMRiRXPT2VX0Lxmp7tDXG4FmGgFpzs5rSs73/+budUbr03r4RdspYe1jdByxXnztLUsL4ItVQY7agN6jq5hlN83O5ZMeddqD7nO3KuWbt1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718976080; c=relaxed/simple;
	bh=YXTN8AnHs5kVg5BnjMDPV4YwVoFfOI/p1k7bfPspFMc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tditOfDr3+QIY0QnusAtgBL++AiiSrQ122dhoMot3m+YyKBfZYj0WK22hM6q0dXZdmXUPvxE1QbAk8tlUFIQZ9sPcLy0tgmuuGuOnhLGXy0W8YTrsfiN5St73xk5Y3np691/p1TWRv3jr5V2DgY/EDWL6o78n1sY94AJBOULmuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ff2FX4ag; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1f65a3abd01so16361795ad.3;
        Fri, 21 Jun 2024 06:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718976078; x=1719580878; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=iiO8T80cl5LvopnS7kRWxRTjrTm7bzEsxVPTDiM1ErI=;
        b=Ff2FX4ag7mlpNwTjRh6OGuo00LKWL/9OGSgD4lwxUE8/RDUDU3gxGn5QAl93mQycxA
         dWJbuThxyRzWzYwzLgZYVV+0iZmQMj0kt2fqj159XQskSBalEq+LejjcteaTjrDhlYsy
         botXg1ITIhHSrmd8BsiD7uCSDC/UZvWUEW0h2vdi3w3lPz4q4kjQb/NGFTYrsGgYsrBi
         hcP1LVLMVxi3MTofFKk7yUpRGFuyWPS4bS59bovjE4V7151KWHdPt2uc3hlRg+oj1nk8
         XCCDbdi6aIu8dgbY8uiP+VQFegFyJlwb8YbpL9lS4LM/Gund1XfRFSGCNS8Lxs5ccru5
         k2vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718976078; x=1719580878;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iiO8T80cl5LvopnS7kRWxRTjrTm7bzEsxVPTDiM1ErI=;
        b=qEOBg1qba00ad9LCPETDr/43cjjTpPArWhFkPsD/IokixDxgiUCvpfbjV8m77betHo
         c6MhCFkjQTGEZPwkXMsuPxkbZyBkGcxhKEs+FUEp5b04DscvWdGJBVtDGtMWzx1TNaQM
         UStzb+gaFdkEkJXW0Q3CbCV7S/3phSd90J2xa5MmDMrsCwRHP4nyWTmPirC4hl1WbmFW
         54TdFglQn4JrZoFqiifE5a36Q9fBVOiFrbX63m4ByR4hweMkSabnyyRhSm6Rdg2fXpR2
         wEsF9MVTAY0LuJD8gVQnCQoTQ6QTyd5G0W2N84qpZXHgF3agYY5RdYIPsKGbLJOgZdfb
         GasA==
X-Forwarded-Encrypted: i=1; AJvYcCVNJOdV8b5p5qYq6JKLz16cKOLXf9Dn7ZpRGqxA2DjEOErqUT3Z1vhPlxP72SgqMNcMAdbqbh/HwwWIK+UfsHdpiLRG9mFt+OfEA+zeh4OTXNbjIoCNclkvcNpZckV2PwFm5W5Y3cQNI6b4SOhGYn7kNne0p3mIWTkKVa7b3zQ9IjpVXePL8MKbxPdleQ==
X-Gm-Message-State: AOJu0YzkP/kT3NH7mlM/gu3smmurqUBkHgWdIMMjbIxc+my2P2Cinnqt
	qMXS/AJaBnA1KN+UfzeXDSq+O/8PVuMsP84dhnM/NWOUdMnPSkJV
X-Google-Smtp-Source: AGHT+IFuJGwZ7SQL/qqCj2L9JCIRJLNGThpzLmX0VEB415cj9k6digjozulId90mA1mZY8q+GGpJQQ==
X-Received: by 2002:a17:903:187:b0:1f9:f840:1109 with SMTP id d9443c01a7336-1f9f840135fmr10073415ad.42.1718976077710;
        Fri, 21 Jun 2024 06:21:17 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb3c5ccasm13770475ad.171.2024.06.21.06.21.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jun 2024 06:21:17 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <1f410012-bf41-4825-9a37-7b7cc7c1df76@roeck-us.net>
Date: Fri, 21 Jun 2024 06:21:15 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] exec: Avoid pathological argc, envc, and bprm->p
 values
To: Kees Cook <kees@kernel.org>
Cc: Eric Biederman <ebiederm@xmission.com>,
 Justin Stitt <justinstitt@google.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20240520021337.work.198-kees@kernel.org>
 <20240520021615.741800-2-keescook@chromium.org>
 <fbc4e2e4-3ca2-45b7-8443-0a8372d4ba94@roeck-us.net>
 <202406202354.3020C4FCA4@keescook>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <202406202354.3020C4FCA4@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/21/24 00:00, Kees Cook wrote:
> On Thu, Jun 20, 2024 at 05:19:55PM -0700, Guenter Roeck wrote:
>> Hi,
>>
>> On Sun, May 19, 2024 at 07:16:12PM -0700, Kees Cook wrote:
>>> Make sure nothing goes wrong with the string counters or the bprm's
>>> belief about the stack pointer. Add checks and matching self-tests.
>>>
>>> For 32-bit validation, this was run under 32-bit UML:
>>> $ tools/testing/kunit/kunit.py run --make_options SUBARCH=i386 exec
>>>
>>> Signed-off-by: Kees Cook <keescook@chromium.org>
>>
>> With this patch in linux-next, the qemu m68k:mcf5208evb emulation
>> fails to boot. The error is:
> 
> Eeek. Thanks for the report! I've dropped this patch from my for-next
> tree.
> 
>> Run /init as init process
>> Failed to execute /init (error -7)
> 
> -7 is E2BIG, so it's certainly one of the 3 new added checks. I must
> have made a mistake in my reasoning about how bprm->p is initialized;
> the other two checks seems extremely unlikely to be tripped.
> 
> I will try to get qemu set up and take a close look at what's happening.
> While I'm doing that, if it's easy for you, can you try it with just
> this removed (i.e. the other 2 new -E2BIG cases still in place):
> 
> 	/* Avoid a pathological bprm->p. */
> 	if (bprm->p < limit)
> 		return -E2BIG;

I added a printk:

argc: 1 envc: 2 p: 262140 limit: 2097152
                 ^^^^^^^^^^^^^^^^^^^^^^^^
Removing the check above does indeed fix the problem.

Guenter


