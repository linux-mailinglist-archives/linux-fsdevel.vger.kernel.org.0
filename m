Return-Path: <linux-fsdevel+bounces-35505-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 871B59D5671
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 00:54:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FE201F232A9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 23:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB611CC885;
	Thu, 21 Nov 2024 23:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Zepq4qXS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE161CACE9
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Nov 2024 23:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732233232; cv=none; b=YCQNAsrW1AOfDhs+5pgKhFto13j+Q/AVbYiW0m9cwPvdFNI/J4iFkjsNPlGT7a8r31Xqj35QcVVvzcCDZkBOItSmBxc+Lvz/i944ZmtbC7Ea9JuUQ5K8dxk25OKDwJnYfT+gtIX1aWuyTwecHJ8RSjXFRp9IU+SttuZR8YRyYOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732233232; c=relaxed/simple;
	bh=j8HtVc2jXBan6FbqE277Xt6/3C49W0fYTo4fzxzIsb0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZJI7ot8t10OaXmMX16uJ3LQNzT5z6Xz+3CPERjMkxP6f9A/Y3BGVIY9nOdILeOGIIai/8B2a3nurJGBoe7W9dDIH8BJUZ9Y11wcUPN5kgV65xAVsmTFMz6KpLcxwUQ0pn4lVLPOmO0m8YooaesDOMYjf0MVswcldAjosNP3OVXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Zepq4qXS; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-83abe7fc77eso57877439f.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Nov 2024 15:53:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1732233230; x=1732838030; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ljvFTLckgMBXyc/hCWJm3TmPmL56Vi1djSJCVHusK+0=;
        b=Zepq4qXS4bnFi4qOXhrW+Tdl6Bs9VtX8EKZEdpU8FGyHf0F/IwzVsKarg0m4q3LHCx
         rhFC2JhI5GH9RFGKa6xZWRv6Xqo9KV5LMenF7UcIodxREy6axtFlmWRzmrsa8CJ0xWWY
         q4fIhhe+FknbBqFgdtcEBOQfDpCQcP3zW9vk8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732233230; x=1732838030;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ljvFTLckgMBXyc/hCWJm3TmPmL56Vi1djSJCVHusK+0=;
        b=CT1or5VQ7aP+eE6Fn6jrZ2z38EzCV4wu70Bfqou7dUqcJpXIJJP6ox5iAhqdh4WWpp
         Zg9k7whyB05ODTyzzfrAtcsxAl2/D1ozDjFnhw+KLkI4tTlR2ri+CVgpn2i1rrhgdcN4
         UolTpRb3RFaqkeS9xiv4LpldU3ATpGT+ZwJJrPBcz011N5dT92sQp12nK1byA3YlUOkc
         rP/T62YotWGOcsLVkdQ4YhR8KmF+2PPXmprwREuVAZ1bLEnSvjWlFfblQ/qzyJSMKAz8
         ZEfVSm2X7jDgetYnKJmf6QEOp3VlIZkiVFnJfP7AJO6wysLyUaZ+rRh6oCE1Qfop8LyS
         v9Yg==
X-Forwarded-Encrypted: i=1; AJvYcCV08V8bBs16r5zwSqCM2VIA8TCe14aSANZSXFsxQ+mpl2oX7rQDs1QwEYhkKfa5wlZEtGe0Mo1Tq1RmHWAq@vger.kernel.org
X-Gm-Message-State: AOJu0YzhmtJ4KqpLgOpBBMInNU8Rl/rOkSy1ht9aJ15c0BeFZBNvMf+g
	XIt8iL9qnNyjHhGEqMVBjnqqVuzgtzD4AER/8rKpb9NU1A8L8Fcm7/vu0JaRMA0=
X-Gm-Gg: ASbGncv1kKp2lWMNm7n3fTqriXDsbrQJMaKN1V91bweUeW2Gg5rjTJwPAZnBhDDpKYQ
	hnAI/zAc58AvkPGgIE96fxIzDskiMSQkm87lXjBeurXEaOnYCbNXFUZDUqjGU9U/Lg2R3iDbxb5
	rA0kRFUzLcQvAFUcNRf2LK1mmTO5FiEbNe2/xUxHXDXuGViII6IHdy8efBgLDwK54yms+dGVBlS
	4m0aInoqiYxKWpkpVjZiwQmlVGlNByMrZVuD+MBnTYK8nmWHBmu7GtoMINaqw==
X-Google-Smtp-Source: AGHT+IF96MGQRTP0elvAz6sBTHwpiq8D9SyOiWFimZgfz4bG069DfMpMT/a7a5sO+nbaJTtWXJBa8g==
X-Received: by 2002:a05:6602:6405:b0:837:7e21:1688 with SMTP id ca18e2360f4ac-83ecdcf315cmr96081939f.11.1732233230456;
        Thu, 21 Nov 2024 15:53:50 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e1cfe19f0fsm359847173.12.2024.11.21.15.53.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2024 15:53:49 -0800 (PST)
Message-ID: <39e8f416-d136-4307-989a-361bf729e688@linuxfoundation.org>
Date: Thu, 21 Nov 2024 16:53:48 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2 v2] bcachefs: do not use PF_MEMALLOC_NORECLAIM
To: Christoph Hellwig <hch@lst.de>, Theodore Ts'o <tytso@mit.edu>
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
 Michal Hocko <mhocko@suse.com>, Dave Chinner <david@fromorbit.com>,
 Andrew Morton <akpm@linux-foundation.org>, Yafang Shao
 <laoar.shao@gmail.com>, jack@suse.cz, Christian Brauner
 <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-bcachefs@vger.kernel.org,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
 "conduct@kernel.org" <conduct@kernel.org>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <citv2v6f33hoidq75xd2spaqxf7nl5wbmmzma4wgmrwpoqidhj@k453tmq7vdrk>
 <22a3da3d-6bca-48c6-a36f-382feb999374@linuxfoundation.org>
 <vvulqfvftctokjzy3ookgmx2ja73uuekvby3xcc2quvptudw7e@7qj4gyaw2zfo>
 <71b51954-15ba-4e73-baea-584463d43a5c@linuxfoundation.org>
 <cl6nyxgqccx7xfmrohy56h3k5gnvtdin5azgscrsclkp6c3ko7@hg6wt2zdqkd3>
 <9efc2edf-c6d6-494d-b1bf-64883298150a@linuxfoundation.org>
 <be7f4c32-413e-4154-abe3-8b87047b5faa@linuxfoundation.org>
 <nu6cezr5ilc6vm65l33hrsz5tyjg5yu6n22tteqvx6fewjxqgq@biklf3aqlook>
 <v2ur4jcqvjc4cqdbllij5gh6inlsxp3vmyswyhhjiv6m6nerxq@mrekyulqghv2>
 <20241120234759.GA3707860@mit.edu> <20241121042558.GA20176@lst.de>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241121042558.GA20176@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/20/24 21:25, Christoph Hellwig wrote:
> On Wed, Nov 20, 2024 at 03:47:59PM -0800, Theodore Ts'o wrote:
>> On Wed, Nov 20, 2024 at 05:55:03PM -0500, Kent Overstreet wrote:
>>> Shuah, would you be willing to entertain the notion of modifying your...
>>
>> Kent, I'd like to gently remind you that Shuah is not speaking in her
>> personal capacity, but as a representative of the Code of Conduct
>> Committee[1], as she has noted in her signature.  The Code of Conduct
>> Committee is appointed by, and reports to, the TAB[2], which is an
>> elected body composed of kernel developers and maintainers.
> 
> FYI, without taking any stance on the issue under debate here, I find the
> language used by Shuah on behalf of the Code of Conduct committee
> extremely patronising and passive aggressive.  This might be because I
> do not have an American academic class background, but I would suggest
> that the code of conduct committee should educate itself about
> communicating without projecting this implicit cultural and class bias
> so blatantly.

I tend to use formal style when I speak on behalf of the Code of Conduct
committee. I would label it as very formal bordering on pedantic.
  
Would you prefer less formal style in the CoC communication?

I am open to educating myself.

thanks,
-- Shuah



