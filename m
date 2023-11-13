Return-Path: <linux-fsdevel+bounces-2800-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C637EA1E4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Nov 2023 18:33:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E5B81F21C9E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Nov 2023 17:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BDD9224D7;
	Mon, 13 Nov 2023 17:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="FYzTBB+c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16FA219FC
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Nov 2023 17:33:35 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDF2C10D0;
	Mon, 13 Nov 2023 09:33:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Oszu5XvrVNjHHpeK4r7h72jVIlFgy+VOxbgYat+iRyE=; b=FYzTBB+cC+G7OVtfs0tkFHV+y1
	HKEc7qQeBcuzChdD76UPhjieh/h2iFH8z68QD2xTtYf4gLOlJJh6UO8srGtujduhUiYwTWytQuAP1
	pIlzaZ/Jg7cLi+VzruoZoc2K4YC61d+AemRwb8GfoJaFWgN/9GDepi5EqyyorbZdw2/JMHefanrLW
	hLOEhTYSqFeRMoC7gFS0qC9SEFwXK7LUeOAVoTQOv+hQ5TN3x+lZagRiKUJOKhk7bSgjqLdECJe1i
	kLM2TsYYwST0WUrlNFMhCorQHSoBa9jYgvx5b9qvwzf3HyFWl/v3WvZlQN5g7HZ8KADUufDJXQyBX
	Ebq7DVKQ==;
Received: from 189-68-155-43.dsl.telesp.net.br ([189.68.155.43] helo=[192.168.1.60])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1r2aoK-002oJt-CX; Mon, 13 Nov 2023 18:33:20 +0100
Message-ID: <8dc5069f-5642-cc5b-60e0-0ed3789c780b@igalia.com>
Date: Mon, 13 Nov 2023 14:33:13 -0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [RFC PATCH 0/2] Introduce a way to expose the interpreted file
 with binfmt_misc
To: Kees Cook <keescook@chromium.org>, David Hildenbrand <david@redhat.com>,
 sonicadvance1@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, kernel-dev@igalia.com, kernel@gpiccoli.net,
 ebiederm@xmission.com, oleg@redhat.com, yzaikin@google.com,
 mcgrof@kernel.org, akpm@linux-foundation.org, brauner@kernel.org,
 viro@zeniv.linux.org.uk, willy@infradead.org, dave@stgolabs.net,
 joshua@froggi.es
References: <20230907204256.3700336-1-gpiccoli@igalia.com>
 <e673d8d6-bfa8-be30-d1c1-fe09b5f811e3@redhat.com>
 <202310091034.4F58841@keescook>
Content-Language: en-US
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <202310091034.4F58841@keescook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/10/2023 14:37, Kees Cook wrote:
> On Fri, Oct 06, 2023 at 02:07:16PM +0200, David Hildenbrand wrote:
>> On 07.09.23 22:24, Guilherme G. Piccoli wrote:
>>> Currently the kernel provides a symlink to the executable binary, in the
>>> form of procfs file exe_file (/proc/self/exe_file for example). But what
>>> happens in interpreted scenarios (like binfmt_misc) is that such link
>>> always points to the *interpreter*. For cases of Linux binary emulators,
>>> like FEX [0] for example, it's then necessary to somehow mask that and
>>> emulate the true binary path.
>>
>> I'm absolutely no expert on that, but I'm wondering if, instead of modifying
>> exe_file and adding an interpreter file, you'd want to leave exe_file alone
>> and instead provide an easier way to obtain the interpreted file.
>>
>> Can you maybe describe why modifying exe_file is desired (about which
>> consumers are we worrying? ) and what exactly FEX does to handle that (how
>> does it mask that?).
>>
>> So a bit more background on the challenges without this change would be
>> appreciated.
> 
> Yeah, it sounds like you're dealing with a process that examines
> /proc/self/exe_file for itself only to find the binfmt_misc interpreter
> when it was run via binfmt_misc?
> 
> What actually breaks? Or rather, why does the process to examine
> exe_file? I'm just trying to see if there are other solutions here that
> would avoid creating an ambiguous interface...
> 

Thanks Kees and David! Did Ryan's thorough comment addressed your
questions? Do you have any take on the TODOs?

I can maybe rebase against 6.7-rc1 and resubmit , if that makes sense!
But would be better having the TODOs addressed, I guess.

Thanks in advance for reviews and feedback on this.
Cheers,


Guilherme

