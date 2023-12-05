Return-Path: <linux-fsdevel+bounces-4901-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 240788061D9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 23:42:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 472621C20F60
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 22:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A779B3FE38
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 22:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Y49si3Z7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3960B135
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 Dec 2023 14:03:49 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1d03f03cda9so11707425ad.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 Dec 2023 14:03:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1701813828; x=1702418628; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wzBUASs8pPfv/I/aupn6RulJurEpXssH14Jo91yxznE=;
        b=Y49si3Z7ejmZaeBTbG9/v3b/cPyXwdYt0UiG8aX94+NPqpxaT8VoVErfm+PrgRSZsH
         w2cu97G/plmUiFCzm4/kdnUSKoaad8kXZ5CyqHebLabGVO/XWyyP6/79O+KyocVlvDXH
         W0q9EomiP9Wnx/EpqJVonxzI2Cz2JdJQGGJ8Viou42ryz1BokkpMBnxxPGzaePyIoUEv
         ST9ayZp/M/0lgBj31VPSa1Fco+cGkVXxOVBrWWYOTRuoKjdCwajPbh8Ltl727IjBceiU
         u14xvr0qMZO+UPwL6uS4sVHPlBMjk7FRlgurcZv4CpmS3l2Pffxtyd1IQM8qibn4YIsG
         dsiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701813828; x=1702418628;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wzBUASs8pPfv/I/aupn6RulJurEpXssH14Jo91yxznE=;
        b=jhwr7xskXQWvg/CMCje0g4TFcjxTOBoS4lxtOc6T8wydg47kP0KJOPFQp+KYswf0pQ
         vPIx0EpRb7HicJAeET1MkioDwU0n9Ew6/iMxAA8ArsWnTY8OzLz4k2ITkwZYDwxUjNBy
         Qt854myNSsKQpJXdCekSIuD3nRhFNd86+czAP7T19qUvnEWalNoEK/vcNNNZMDWJh012
         HFkb8xOY6qyt4ZcJXGJPW3qfJhV9f/lv9aPvlsrKscbh7BD49jGWyZ2UksUBkAXVMfgS
         Pe5wnBHrSR+pIYeeAxn8CWfDtn1jkAzD72Y6LQDBnEpnlOZZ9/H7Fd6gKtcC7OhA1CHG
         doqg==
X-Gm-Message-State: AOJu0Ywn3czUDC9y3M9qPFlZEtc8e45969IvAU0MDjRjquQHGYBUB2hq
	8WsLIfMwThbivgmG0bzixqC+BA==
X-Google-Smtp-Source: AGHT+IHn86HDzSMhpNhyY9U2scelISrYU4K7J8FgUXKRUsQlnxlxtNMDac6hoQbyov1I7LtoEVcEgQ==
X-Received: by 2002:a17:90a:4bc7:b0:286:f169:79f1 with SMTP id u7-20020a17090a4bc700b00286f16979f1mr1945090pjl.2.1701813828561;
        Tue, 05 Dec 2023 14:03:48 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id q24-20020a170902bd9800b001d1c96a0c63sm190278pls.274.2023.12.05.14.03.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Dec 2023 14:03:48 -0800 (PST)
Message-ID: <3609267c-3fcd-43d6-9b43-9f84bef029a2@kernel.dk>
Date: Tue, 5 Dec 2023 15:03:46 -0700
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
From: Jens Axboe <axboe@kernel.dk>
To: NeilBrown <neilb@suse.de>, Christian Brauner <brauner@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Oleg Nesterov <oleg@redhat.com>,
 Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org
References: <20231204014042.6754-1-neilb@suse.de>
 <20231204014042.6754-2-neilb@suse.de>
 <e9a1cfed-42e9-4174-bbb3-1a3680cf6a5c@kernel.dk>
 <170172377302.7109.11739406555273171485@noble.neil.brown.name>
 <a070b6bd-0092-405e-99d2-00002596c0bc@kernel.dk>
 <20231205-altbacken-umbesetzen-e5c0c021ab98@brauner>
 <170181169515.7109.11121482729257102758@noble.neil.brown.name>
 <fb713388-661a-46e0-8925-6d169b46ff9c@kernel.dk>
In-Reply-To: <fb713388-661a-46e0-8925-6d169b46ff9c@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/5/23 2:58 PM, Jens Axboe wrote:
> On 12/5/23 2:28 PM, NeilBrown wrote:
>> On Tue, 05 Dec 2023, Christian Brauner wrote:
>>> On Mon, Dec 04, 2023 at 03:09:44PM -0700, Jens Axboe wrote:
>>>> On 12/4/23 2:02 PM, NeilBrown wrote:
>>>>> It isn't clear to me what _GPL is appropriate, but maybe the rules
>>>>> changed since last I looked..... are there rules?
>>>>>
>>>>> My reasoning was that the call is effectively part of the user-space
>>>>> ABI.  A user-space process can call this trivially by invoking any
>>>>> system call.  The user-space ABI is explicitly a boundary which the GPL
>>>>> does not cross.  So it doesn't seem appropriate to prevent non-GPL
>>>>> kernel code from doing something that non-GPL user-space code can
>>>>> trivially do.
>>>>
>>>> By that reasoning, basically everything in the kernel should be non-GPL
>>>> marked. And while task_work can get used by the application, it happens
>>>> only indirectly or implicitly. So I don't think this reasoning is sound
>>>> at all, it's not an exported ABI or API by itself.
>>>>
>>>> For me, the more core of an export it is, the stronger the reason it
>>>> should be GPL. FWIW, I don't think exporting task_work functionality is
> 
>>>
>>> Yeah, I'm not too fond of that part as well. I don't think we want to
>>> give modules the ability to mess with task work. This is just asking for
>>> trouble.
>>>
>>
>> Ok, maybe we need to reframe the problem then.
>>
>> Currently fput(), and hence filp_close(), take control away from kernel
>> threads in that they cannot be sure that a "close" has actually
>> completed.
>>
>> This is already a problem for nfsd.  When renaming a file, nfsd needs to
>> ensure any cached "open" that it has on the file is closed (else when
>> re-exporting an NFS filesystem it can result in a silly-rename).
>>
>> nfsd currently handles this case by calling flush_delayed_fput().  I
>> suspect you are no more happy about exporting that than you are about
>> exporting task_work_run(), but this solution isn't actually 100%
>> reliable.  If some other thread calls flush_delayed_fput() between nfsd
>> calling filp_close() and that same nfsd calling flush_delayed_fput(),
>> then the second flush can return before the first flush (in the other
>> thread) completes all the work it took on.
>>
>> What we really need - both for handling renames and for avoiding
>> possible memory exhaustion - is for nfsd to be able to reliably wait for
>> any fput() that it initiated to complete.
>>
>> How would you like the VFS to provide that service?
> 
> Since task_work happens in the context of your task already, why not
> just have a way to get it stashed into a list when final fput is done?
> This avoids all of this "let's expose task_work" and using the task list
> for that, which seems kind of pointless as you're just going to run it
> later on manually anyway.
> 
> In semi pseudo code:
> 
> bool fput_put_ref(struct file *file)
> {
> 	return atomic_dec_and_test(&file->f_count);
> }
> 
> void fput(struct file *file)
> {
> 	if (fput_put_ref(file)) {
> 		...
> 	}
> }
> 
> and then your nfsd_file_free() could do:
> 
> ret = filp_flush(file, id);
> if (fput_put_ref(file))
> 	llist_add(&file->f_llist, &l->to_free_llist);
> 
> or something like that, where l->to_free_llist is where ever you'd
> otherwise punt the actual freeing to.

Should probably have the put_ref or whatever helper also init the
task_work, and then reuse the list in the callback_head there. Then
whoever flushes it has to call ->func() and avoid exposing ____fput() to
random users. But you get the idea.

-- 
Jens Axboe


