Return-Path: <linux-fsdevel+bounces-68639-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 21EE4C62ADE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 08:12:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E4ED04EA1D9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 07:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CF673191BA;
	Mon, 17 Nov 2025 07:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DsfQNHX4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8250D316909;
	Mon, 17 Nov 2025 07:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763363478; cv=none; b=EnG8EjoAq3+1f5YGySY1V4ZUeV18mVh4+ftQH2MmHlc7fytqQnJejRDSLInXtPsFeHOkUne0E8cD3EKwhQXadLfX7ERz6Yd1RvS9hweh8DJMZmhvLK7F45+PyHeMRynUSY2Gbfa3CAo+nSUaA5T3TAONq3GJjXAaa/TZJQSxC8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763363478; c=relaxed/simple;
	bh=n/Lorf00oIeL8NcXXfKtNjzNM8fzyT8fT3D731d/Zfg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MZ00IuCvuAWA9HDjVp6EOUbRXohenGvVGa7otddcNwDSlmfw6HEcoS3z1TVVz4vnffpWA/TkVWGGmujvgrYm9URmoocw7wCy73ytCjhl8Q29dOiE9mZbZAZ4Ozz27vC3a/0fDgvWxO6oufSIfXiXm09N95+7GWQtCXUzEJMUOPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DsfQNHX4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45CB7C4CEF1;
	Mon, 17 Nov 2025 07:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763363478;
	bh=n/Lorf00oIeL8NcXXfKtNjzNM8fzyT8fT3D731d/Zfg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DsfQNHX4yHKMEuQNzivLmPSvNg1GT14FSWM8cLhfJduQojTUVNLgOs8iq/0syOojh
	 WuGuaPAGYKsQdP/DTSQDb9+unoP5KJ0tkl6le5fgCvcevJvCeiN2D95pWt0LwJP735
	 ZRKVcx3qQ2zWb+seVPgj7YbVDiWyFqhO5+ePRYpWWGZeufxCZ665RjJd9ewM4tNyON
	 ip5+0Cpbucoq/0HGmYoAtYsApisjo0N6ae+W9VbkZP/HwJhrARilXWfQH4AykjNS+t
	 5ZdX7Yoj0rZio3OoCbYdkDqfe9H07IfcFHZWl5/1biRvZIH/VBh4qBvczCi+LqtEEJ
	 rKmC312gtIFWQ==
Message-ID: <4758205a-14ae-498e-8dcd-6770787ddb3f@kernel.org>
Date: Mon, 17 Nov 2025 08:11:11 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/10] uaccess: Use
 masked_user_{read/write}_access_begin when required
To: Thomas Gleixner <tglx@linutronix.de>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>,
 Andre Almeida <andrealmeid@igalia.com>,
 Andrew Morton <akpm@linux-foundation.org>, Eric Dumazet
 <edumazet@google.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>
Cc: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
References: <cover.1762427933.git.christophe.leroy@csgroup.eu>
 <5effda898b110d413dc84a53c5664d4c9d11c1bf.1762427933.git.christophe.leroy@csgroup.eu>
 <87h5uv9ts5.ffs@tglx>
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Content-Language: fr-FR
In-Reply-To: <87h5uv9ts5.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 15/11/2025 à 16:53, Thomas Gleixner a écrit :
> On Thu, Nov 06 2025 at 12:31, Christophe Leroy wrote:
>> diff --git a/net/core/scm.c b/net/core/scm.c
>> index 66eaee783e8be..4a65f9baa87e7 100644
>> --- a/net/core/scm.c
>> +++ b/net/core/scm.c
>> @@ -274,7 +274,7 @@ int put_cmsg(struct msghdr * msg, int level, int type, int len, void *data)
>>   		check_object_size(data, cmlen - sizeof(*cm), true);
>>   
>>   		if (can_do_masked_user_access())
>> -			cm = masked_user_access_begin(cm);
>> +			cm = masked_user_write_access_begin(cm);
>>   		else if (!user_write_access_begin(cm, cmlen))
>>   			goto efault;
> 
> Shouldn't this be converted to scoped_....() ?

Sure. I made the same comment to you when reviewing your series, see [1]

[1] 
https://lore.kernel.org/all/e0795f90-1030-4954-aefc-be137e9db49e@csgroup.eu/

Do you prefer me to do it as part of my series ?

Christophe

