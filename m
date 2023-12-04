Return-Path: <linux-fsdevel+bounces-4809-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 57D968041C5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 23:41:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECD3CB20584
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 22:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 592613C470
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 22:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="KqMZiWIu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE48EFA
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 Dec 2023 14:09:49 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-5c6910e93e3so123341a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 Dec 2023 14:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1701727789; x=1702332589; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N7YVZRS1Yk2p3iV3hbb4MrgXwpXbi4TeT5VGkU/u+Jk=;
        b=KqMZiWIu6Huk1KRv62/VLR70dCPjpFds0G8v2g0RW8hC/DSworJnr6ZLlYFO2j3c88
         hYt0tr1acI6wUHCWFiu7iY1jpRvkg1u8+yu9FZd5fuC8Zf+jlvjquBCuceBwUmcx8e6C
         tQxq1a6mza04HO9xXTeS620tIojtLyJHI29WYy2ChNCSz01NTw+772Nd0CqqV+eXo5/v
         WPYcaPYgTu3/7VJW0ooRbRSH56JUPEQLJeN/ZqZ2X8+G/ImlxtpTe2tJ/rKD6wGGTPU/
         MqFenhCRgBmedtBNgv8emQ5Tjr/YO+/jCl1UcYKdG7J4J/STnzMJ0jN25nDqFX/C4VI/
         Xz1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701727789; x=1702332589;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N7YVZRS1Yk2p3iV3hbb4MrgXwpXbi4TeT5VGkU/u+Jk=;
        b=Ou76HRqUV0tyo/bmK/8+u+unf5OU62/4dsT4a+bA6D9OIEbhakmlzyH3HR6x7v4nst
         zo6VxV93CHyHDu2TTdi5NOUVDZbu+4D5MoogE8c4EKmGPRhuPkIgD+/BYWFWanR0yxut
         0KzqyqiVq6dsVTKaBPiv17mzyB/1gH3/SK63MPfFJl6v3BO+pNACcyL/YqzFXqxXynk4
         6cTttSMyN6woZn3jbmk8ZolHxyTivTTaOcwgNNDMHAt3VifqCpiN/EZLv8TL5cHcqKLU
         tpIkl2lsFsHzMq8zO3PURj3U6h8mJrtQjuQLpeW7wWddVUJZrVR5rgawpVQnAPhH8fkM
         fb7g==
X-Gm-Message-State: AOJu0YzZ5mtGmMiR7cLaQ3dskrBbKKGmWtcAQUUPE1spMC3PSTuTsMLr
	HdUNpyOU/1wHs/+rscf7DX0Mfi9Im1OparkyIwJM7Q==
X-Google-Smtp-Source: AGHT+IHDv1b42RKXKN4tRifZv0mEX5EckA+D3oEFHeJfjju4L9UJaftPOWecVThY8YBY1KMQIFUJ4A==
X-Received: by 2002:a17:903:234a:b0:1d0:b693:ae30 with SMTP id c10-20020a170903234a00b001d0b693ae30mr2493966plh.6.1701727789078;
        Mon, 04 Dec 2023 14:09:49 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id t4-20020a170902bc4400b001bf11cf2e21sm5844131plz.210.2023.12.04.14.09.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Dec 2023 14:09:46 -0800 (PST)
Message-ID: <a070b6bd-0092-405e-99d2-00002596c0bc@kernel.dk>
Date: Mon, 4 Dec 2023 15:09:44 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] Allow a kthread to declare that it calls
 task_work_run()
Content-Language: en-US
To: NeilBrown <neilb@suse.de>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner
 <brauner@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
 Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org
References: <20231204014042.6754-1-neilb@suse.de>
 <20231204014042.6754-2-neilb@suse.de>
 <e9a1cfed-42e9-4174-bbb3-1a3680cf6a5c@kernel.dk>
 <170172377302.7109.11739406555273171485@noble.neil.brown.name>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <170172377302.7109.11739406555273171485@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/4/23 2:02 PM, NeilBrown wrote:
> It isn't clear to me what _GPL is appropriate, but maybe the rules
> changed since last I looked..... are there rules?
> 
> My reasoning was that the call is effectively part of the user-space
> ABI.  A user-space process can call this trivially by invoking any
> system call.  The user-space ABI is explicitly a boundary which the GPL
> does not cross.  So it doesn't seem appropriate to prevent non-GPL
> kernel code from doing something that non-GPL user-space code can
> trivially do.

By that reasoning, basically everything in the kernel should be non-GPL
marked. And while task_work can get used by the application, it happens
only indirectly or implicitly. So I don't think this reasoning is sound
at all, it's not an exported ABI or API by itself.

For me, the more core of an export it is, the stronger the reason it
should be GPL. FWIW, I don't think exporting task_work functionality is
a good idea in the first place, but if there's a strong reason to do so,
it should most certainly not be accessible to non-GPL modules. Basically
NO new export should be non-GPL.

-- 
Jens Axboe


