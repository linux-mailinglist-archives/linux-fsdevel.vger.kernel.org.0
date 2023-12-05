Return-Path: <linux-fsdevel+bounces-4900-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58C548061D8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 23:42:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF5981F21272
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 22:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 681763FE50
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 22:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="f4S4a9eZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAF06183
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 Dec 2023 13:58:49 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-6cdf3e99621so1049870b3a.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 Dec 2023 13:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1701813529; x=1702418329; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LGvf0v3WO1jMmuVd3YQ6/5GaYR43CazhfwAsFHfc+Ck=;
        b=f4S4a9eZ4yRnQE+c/EYEZft+z5LwGHOMtwil4SftE9bKXVjoxszmqe0DyV3iZm1vjo
         tMIyEL5XRODyVrQ5kYoA6+Q2ygLf1i0UmwwNae/gUywStyqlJAmB7mwKsDVdkAwNGBD9
         p0NUkvkrOj8aPkfQDXZ4eTusE987yRTOkZGDRysZAmWGP2FxbnZue0DVX/5Ey62c08Y1
         dAO3AsO8Fk4FfE+nJKLLSol/XwAJr+4RIVck0p08z2QkNlF/a5SpJ1BVt5Q18JFqBZcl
         dchpBAwLWHqLEGn9XuI4ILb88hEANmvkNXgNg31I6eVMl6IrvruWLziC2GyL2NawVc7Z
         ajeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701813529; x=1702418329;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LGvf0v3WO1jMmuVd3YQ6/5GaYR43CazhfwAsFHfc+Ck=;
        b=L/UrsLJe2jjxQy05W0YemnX3uTBnvWvHcQFYVdBGszNOTamEzu8W5J21xIM84EejqB
         rr19A2ay4xA2Wz/+Y3T7993pIm+xNihO3oAMK4xJwBHjEqrKLVSBLvHA67xjrXQl1AuZ
         xh1MnPYv3oqbHK2p1qC+kNxg3LsCTismXEj23KcLRq3CjtspLKpsTf15G6wNx7gwjXKC
         cSLF42GisgEDj8UWLvrC9l5dzbmXpEQI/xdrN84RRFQxbYAaxeC9fzhzYlv9AmH2H29S
         ypkreFXa3urN/2R+aU0I/hO5PFSt8fTPk9surEC7R72HC+3OmDcMzfrvEElqR56tMzoU
         RspA==
X-Gm-Message-State: AOJu0YxOJGRWseZt6J+eijh/Lpn4fxSNVnpnYJgXEPJ6e3/gFv1oEOpD
	QgvKyPxzn3ctc9VzDbXk61fg/A==
X-Google-Smtp-Source: AGHT+IGzPTTW74AHvrXhGeY2ZDF1XGD7k+iKI5ldfYRplCp96c8z1TYYf/Vu3DKKXnbWDhDWGuE0MA==
X-Received: by 2002:aa7:88c6:0:b0:6ce:4c49:58e4 with SMTP id k6-20020aa788c6000000b006ce4c4958e4mr8822580pff.0.1701813529029;
        Tue, 05 Dec 2023 13:58:49 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id v14-20020aa7850e000000b006cde2889213sm1323983pfn.14.2023.12.05.13.58.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Dec 2023 13:58:48 -0800 (PST)
Message-ID: <fb713388-661a-46e0-8925-6d169b46ff9c@kernel.dk>
Date: Tue, 5 Dec 2023 14:58:46 -0700
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
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <170181169515.7109.11121482729257102758@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/5/23 2:28 PM, NeilBrown wrote:
> On Tue, 05 Dec 2023, Christian Brauner wrote:
>> On Mon, Dec 04, 2023 at 03:09:44PM -0700, Jens Axboe wrote:
>>> On 12/4/23 2:02 PM, NeilBrown wrote:
>>>> It isn't clear to me what _GPL is appropriate, but maybe the rules
>>>> changed since last I looked..... are there rules?
>>>>
>>>> My reasoning was that the call is effectively part of the user-space
>>>> ABI.  A user-space process can call this trivially by invoking any
>>>> system call.  The user-space ABI is explicitly a boundary which the GPL
>>>> does not cross.  So it doesn't seem appropriate to prevent non-GPL
>>>> kernel code from doing something that non-GPL user-space code can
>>>> trivially do.
>>>
>>> By that reasoning, basically everything in the kernel should be non-GPL
>>> marked. And while task_work can get used by the application, it happens
>>> only indirectly or implicitly. So I don't think this reasoning is sound
>>> at all, it's not an exported ABI or API by itself.
>>>
>>> For me, the more core of an export it is, the stronger the reason it
>>> should be GPL. FWIW, I don't think exporting task_work functionality is

>>
>> Yeah, I'm not too fond of that part as well. I don't think we want to
>> give modules the ability to mess with task work. This is just asking for
>> trouble.
>>
> 
> Ok, maybe we need to reframe the problem then.
> 
> Currently fput(), and hence filp_close(), take control away from kernel
> threads in that they cannot be sure that a "close" has actually
> completed.
> 
> This is already a problem for nfsd.  When renaming a file, nfsd needs to
> ensure any cached "open" that it has on the file is closed (else when
> re-exporting an NFS filesystem it can result in a silly-rename).
> 
> nfsd currently handles this case by calling flush_delayed_fput().  I
> suspect you are no more happy about exporting that than you are about
> exporting task_work_run(), but this solution isn't actually 100%
> reliable.  If some other thread calls flush_delayed_fput() between nfsd
> calling filp_close() and that same nfsd calling flush_delayed_fput(),
> then the second flush can return before the first flush (in the other
> thread) completes all the work it took on.
> 
> What we really need - both for handling renames and for avoiding
> possible memory exhaustion - is for nfsd to be able to reliably wait for
> any fput() that it initiated to complete.
> 
> How would you like the VFS to provide that service?

Since task_work happens in the context of your task already, why not
just have a way to get it stashed into a list when final fput is done?
This avoids all of this "let's expose task_work" and using the task list
for that, which seems kind of pointless as you're just going to run it
later on manually anyway.

In semi pseudo code:

bool fput_put_ref(struct file *file)
{
	return atomic_dec_and_test(&file->f_count);
}

void fput(struct file *file)
{
	if (fput_put_ref(file)) {
		...
	}
}

and then your nfsd_file_free() could do:

ret = filp_flush(file, id);
if (fput_put_ref(file))
	llist_add(&file->f_llist, &l->to_free_llist);

or something like that, where l->to_free_llist is where ever you'd
otherwise punt the actual freeing to.

-- 
Jens Axboe


