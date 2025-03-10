Return-Path: <linux-fsdevel+bounces-43561-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AE48A589BC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 01:39:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21F3F3AC5FF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 00:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 485F935971;
	Mon, 10 Mar 2025 00:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="aT+w9M+b";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="zMXHWwH0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-a2-smtp.messagingengine.com (flow-a2-smtp.messagingengine.com [103.168.172.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D07D1CD15;
	Mon, 10 Mar 2025 00:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741567154; cv=none; b=qQbxUcucp/LgBZX1oC101I4MGPulFmK3trEtyCeg20zPDTjznkSrcpI1bAXW1taXuUilmDhSeIEfW5Njpa9KKgdnH2iE+ZxWpKY1vwcTMlAV+7haPsl7M8rV7v09AXsOyIE5FMWrHXurIVO1ZbhDkIs0WKkzHo+hjvj/sXT67qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741567154; c=relaxed/simple;
	bh=u9Nx8wrWlt/WofCTEK6pT2I/QOYfWprB43rh5LPD7T4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ZRs1qf5a5AWXRBEgrdmF/BeoZja0nmVvQ9PlJUPQiIIiGVc8w1Wg/q8fJDcg8MUuSHBfY57vw8/l2XlniKDNuQZpf8qXD7Zx5HaB7YAvrc6VvJ60T0g3snmNM88/wD7115t/wJdI9Q5N1uyfzokhdT4RRycPq/Nf2lyRQOCGGLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=aT+w9M+b; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=zMXHWwH0; arc=none smtp.client-ip=103.168.172.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailflow.phl.internal (Postfix) with ESMTP id 4DFB02014C1;
	Sun,  9 Mar 2025 20:39:11 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Sun, 09 Mar 2025 20:39:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1741567151;
	 x=1741570751; bh=D3jSE7ftGfdon37NtgJgMCKeInLTwsC9Nm/I/okhYt8=; b=
	aT+w9M+bDNlEAtbf8Y1ZjwcsiPNnYBP7HSF3L7AbDkeR31WsGpDh9s/lRVghet3D
	uCqJTHqjNWbOEPGiRFWLb7GinaUf1hjokzIAIbHiMeZE1H7HizqrJSP8as9x00/D
	4QiEsn/rPq+5xojdFN4knV5KBxicnuwS4xBmRB7KXK9z73Gz3W5tMFDUL7omY2GX
	QHGqUQxUxQQUIsaOsdj+Lfcn77+VXLZCl7697ADbIlWJJ7hIZxgQSD7KB/05GQ3D
	AYeKx7D3J3GAxL8DFPTnjIMgW4zHg0sT0betMkkUGn3VJoFdQpBk3Fgb0Y7UfR+Q
	uL3Ap+jx4VADhU2qtQdvYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741567151; x=
	1741570751; bh=D3jSE7ftGfdon37NtgJgMCKeInLTwsC9Nm/I/okhYt8=; b=z
	MXHWwH06XfyRf6HxSpeMeRobqhczgi8BFmyxtkNuE6iDlI7wzFdY6p/lX2eBLx4i
	FnulVHdcD0LDX3KGdtDH9Qivy4PpqeaoIodj/LWJUSE0LUizbz8QN/DALkcQVvUZ
	rtfQDNz5QOGYvskvy4l99FeF6mcEca+Lws+hscaVdSjD0dB3VER4AhQsbqLNxJ0R
	9f8UQ1ikUMYq1k/CP+d5+YmEbWphnJfn+OkmBZe4n+qIHUvUM1ETwOxK59JGTb5r
	aGDRprV30/GX6csuXcIR59qhFBBJa/EyEQBjU6nS3CcoZrKWBPUUZGr1nQAkAO5i
	O1rD30I+QAcxSZxFO0JwQ==
X-ME-Sender: <xms:rjTOZ0sjJbEN4fViRJLCFnQ0VbvrvrLMWbeo3rbLw76gELvsB3lyog>
    <xme:rjTOZxeFn6X6VSZ0HXmoXKx4rJIrf42o0QaFhfzSpn2AkuspkIr6YYRNsSXOBHO0M
    k9SOf5AEtimZ_Uec84>
X-ME-Received: <xmr:rjTOZ_ysEnH7_r16qWl8l_OKCB3wQtJzPLK52eqcHzigYSlUJLF9yyeGh3YfvX6aggqPLe9M-xsFJTqvyF7PeQJ3V3t6bNd0EtPJqFFyAJ-nXkwawj5RGSn2YKs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduudejledvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepkfffgggfhffuvfevfhgjtgfgsehtkeertddt
    vdejnecuhfhrohhmpefvihhnghhmrghoucghrghnghcuoehmsehmrghofihtmhdrohhrgh
    eqnecuggftrfgrthhtvghrnhepjeefgfeghfejuefhheeigedvteetudeiudefvefhhefg
    gfffhfetudefteevudffnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmsehmrghofihtmhdr
    ohhrghdpnhgspghrtghpthhtohepudegpdhmohguvgepshhmthhpohhuthdprhgtphhtth
    hopehmihgtseguihhgihhkohgurdhnvghtpdhrtghpthhtohepthihtghhohesthihtghh
    ohdrphhiiiiirgdprhgtphhtthhopehgnhhorggtkhesghhoohhglhgvrdgtohhmpdhrtg
    hpthhtohepjhgrtghksehsuhhsvgdrtgiipdhrtghpthhtoheplhhinhhugidqshgvtghu
    rhhithihqdhmohguuhhlvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    grmhhirhejfehilhesghhmrghilhdrtghomhdprhgtphhtthhopehrvghpnhhophesghho
    ohhglhgvrdgtohhmpdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopegsrhgruhhnvghrsehkvghrnhgvlhdrohhr
    gh
X-ME-Proxy: <xmx:rjTOZ3N7kTEf5dcBKrz2bvR425QZgC8e_rKRmwmirt0Rdj9eW1FEKg>
    <xmx:rjTOZ0-mIpTxUzQtDqlqCE2HPIFzt3k21KorxO9BKagZDwMTqBrBPg>
    <xmx:rjTOZ_Vl5ocKQDO5ozwDE0t5GWbqYadThDJu1g6oRxEd_HfDEJJTbg>
    <xmx:rjTOZ9cYLcPILMIJn_46zwxI9Sl9p49QddsFPqqwJRKKnXVCrQrMjg>
    <xmx:rzTOZ_Xf5Z91IPG8JK4SdxlZoQu59VyLTeyZvYf13-I1AxsoQI6HWg-0>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 9 Mar 2025 20:39:08 -0400 (EDT)
Message-ID: <4b0b693d-a152-42c0-bb2c-73e705c3c9b0@maowtm.org>
Date: Mon, 10 Mar 2025 00:39:08 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Tingmao Wang <m@maowtm.org>
Subject: Re: [RFC PATCH 5/9] Define user structure for events and responses.
To: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 Tycho Andersen <tycho@tycho.pizza>
Cc: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
 Jan Kara <jack@suse.cz>, linux-security-module@vger.kernel.org,
 Amir Goldstein <amir73il@gmail.com>, Matthew Bobrowski <repnop@google.com>,
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
 Kees Cook <kees@kernel.org>, Jann Horn <jannh@google.com>,
 Andy Lutomirski <luto@amacapital.net>, Paul Moore <paul@paul-moore.com>,
 linux-api@vger.kernel.org
References: <cover.1741047969.git.m@maowtm.org>
 <cde6bbf0b52710b33170f2787fdcb11538e40813.1741047969.git.m@maowtm.org>
 <20250304.eichiDu9iu4r@digikod.net>
 <fbb8e557-0b63-4bbe-b8ac-3f7ba2983146@maowtm.org>
 <20250306.aej5ieg1Hi6j@digikod.net>
Content-Language: en-US
In-Reply-To: <20250306.aej5ieg1Hi6j@digikod.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/8/25 19:07, Mickaël Salaün wrote:
> On Thu, Mar 06, 2025 at 03:05:10AM +0000, Tingmao Wang wrote:
>> On 3/4/25 19:49, Mickaël Salaün wrote:
>>> On Tue, Mar 04, 2025 at 01:13:01AM +0000, Tingmao Wang wrote:
>> [...]
>>>> +	/**
>>>> +	 * @cookie: Opaque identifier to be included in the response.
>>>> +	 */
>>>> +	__u32 cookie;
>>>
>>> I guess we could use a __u64 index counter per layer instead.  That
>>> would also help to order requests if they are treated by different
>>> supervisor threads.
>>
>> I don't immediately see a use for ordering requests (if we get more than one
>> event at once, they are coming from different threads anyway so there can't
>> be any dependencies between them, and the supervisor threads can use
>> timestamps), but I think making it a __u64 is probably a good idea
>> regardless, as it means we don't have to do some sort of ID allocation, and
>> can just increment an atomic.
> 
> Indeed, we should follow the seccomp unotify approach with a random u64
> incremented per request.

Do you mean a random starting value, incremented by one per request, or 
something like the landlock_id in the audit patch (random increments too)?

> 
>>
>>>> +};
>>>> +
>>>> +struct landlock_supervise_event {
>>>> +	struct landlock_supervise_event_hdr hdr;
>>>> +	__u64 access_request;
>>>> +	__kernel_pid_t accessor;
>>>> +	union {
>>>> +		struct {
>>>> +			/**
>>>> +			 * @fd1: An open file descriptor for the file (open,
>>>> +			 * delete, execute, link, readdir, rename, truncate),
>>>> +			 * or the parent directory (for create operations
>>>> +			 * targeting its child) being accessed.  Must be
>>>> +			 * closed by the reader.
>>>> +			 *
>>>> +			 * If this points to a parent directory, @destname
>>>> +			 * will contain the target filename. If @destname is
>>>> +			 * empty, this points to the target file.
>>>> +			 */
>>>> +			int fd1;
>>>> +			/**
>>>> +			 * @fd2: For link or rename requests, a second file
>>>> +			 * descriptor for the target parent directory.  Must
>>>> +			 * be closed by the reader.  @destname contains the
>>>> +			 * destination filename.  This field is -1 if not
>>>> +			 * used.
>>>> +			 */
>>>> +			int fd2;
>>>
>>> Can we just use one FD but identify the requested access instead and
>>> send one event for each, like for the audit patch series?
>>
>> I haven't managed to read or test out the audit patch yet (I will do), but I
>> think having the ability to specifically tell whether the child is trying to
>> move / rename / create a hard link of an existing file, and what it's trying
>> to use as destination, might be useful (either for security, or purely for
>> UX)?
>>
>> For example, imagine something trying to link or move ~/.ssh/id_ecdsa to
>> /tmp/innocent-tmp-file then read the latter. The supervisor can warn the
>> user on the initial link attempt, and the shenanigan will probably be
>> stopped there (although still, being able to say "[program] wants to link
>> ~/.ssh/id_ecdsa to /tmp/innocent-tmp-file" seems better than just "[program]
>> wants to create a link for ~/.ssh/id_ecdsa"), but even if somehow this ends
>> up allowed, later on for the read request it could say something like
>>
>> 	[program] wants to read /tmp/innocent-tmp-file
>> 	    (previously moved from ~/.ssh/id_ecdsa)
>>
>> Maybe this is a bit silly, but there might be other use cases for knowing
>> the exact details of a rename/link request, either for at-the-time decision
>> making, or tracking stuff for future requests?
> 
> This pattern looks like datagram packets.  I think we should use the
> netlink attributes.  There were concern about using a netlink socket for
> the seccomp unotification though:
> https://lore.kernel.org/all/CALCETrXeZZfVzXh7SwKhyB=+ySDk5fhrrdrXrcABsQ=JpQT7Tg@mail.gmail.com/
> 
> There are two main differences with seccomp unotify:
> - the supervisor should be able to receive arbitrary-sized data (e.g.
>    file name, not path);
> - the supervisor should be able to receive file descriptors (instead of
>    path).
> 
> Sockets are created with socket(2) whereas in our case we should only
> get a supervisor FD (indirectly) through landlock_restrict_self(2),
> which clearly identifies a kernel object.  Another issue would be to
> deal with network namespaces, probably by creating a private one.
> Sockets are powerful but we don't needs all the routing complexity.
> Moreover, we should only need a blocking communication channel to avoid
> issues managing in-flight object references (transformed to FDs when
> received).  That makes me think that a socket might not be the right
> construct, but we can still rely on the NLA macros to define a proper
> protocol with dynamically-sized events, received and send with dedicated
> IOCTL commands.
> 
> Netlink already provides a way to send a cookie, and
> netlink_attribute_type defines the types we'll need, including string.
> 
> For instance, a link request/event could include 3 packets, one for each
> of these properties:
> 1. the source file FD;
> 2. the destination directory FD;
> 3. the destination filename string.
> 
> This way we would avoid the union defined in this patch.

I had no idea about netlink - I will take a look.  Do you know if there 
is any existing code which uses it in a similar way (i.e. not creating 
an actual socket, but using netlink messages)?

I think in the end seccomp-unotify went with an ioctl with a custom 
struct seccomp_notif due to friction with the NL API [1] - do you think 
we will face the same problem here? (I will take a deeper look at 
netlink after sending this.)

(Tycho - could you weigh in?)

[1]: 
https://lore.kernel.org/all/CAGXu5jKsLDSBjB74SrvCvmGy_RTEjBsMtR5dk1CcRFrHEQfM_g@mail.gmail.com/

> 
> There is still the question about receiving FDs though. It would be nice
> to have a (set of?) dedicated IOCTL(s) to receive an FD, but I'm not
> sure how this could be properly handled wrt NLA.

Also, if we go with netlink messages, why do we need additional IOCTLs? 
Can we open the fd when we write out the message? (Maybe I will end up 
realizing the reason for this after reading netlink code, but I would )

> 
>>
>> I will try out the audit patch to see how things like these appears in the
>> log before commenting further on this. Maybe there is a way to achieve this
>> while still simplifying the event structure?
>>
>>>
>>>> +			/**
>>>> +			 * @destname: A filename for a file creation target.
>>>> +			 *
>>>> +			 * If either of fd1 or fd2 points to a parent
>>>> +			 * directory rather than the target file, this is the
>>>> +			 * NULL-terminated name of the file that will be
>>>> +			 * newly created.
>>>> +			 *
>>>> +			 * Counting the NULL terminator, this field will
>>>> +			 * contain one or more NULL padding at the end so
>>>> +			 * that the length of the whole struct
>>>> +			 * landlock_supervise_event is a multiple of 8 bytes.
>>>> +			 *
>>>> +			 * This is a variable length member, and the length
>>>> +			 * including the terminating NULL(s) can be derived
>>>> +			 * from hdr.length - offsetof(struct
>>>> +			 * landlock_supervise_event, destname).
>>>> +			 */
>>>> +			char destname[];
>>>
>>> I'd prefer to avoid sending file names for now.  I don't think it's
>>> necessary, and that could encourage supervisors to filter access
>>> according to names.
>>>
>>
>> This is also motivated by the potential UX I'm thinking of. For example, if
>> a newly installed application tries to create ~/.app-name, it will be much
>> more reassuring and convenient to the user if we can show something like
>>
>> 	[program] wants to mkdir ~/.app-name. Allow this and future
>> 	access to the new directory?
>>
>> rather than just "[program] wants to mkdir under ~". (The "Allow this and
>> future access to the new directory" bit is made possible by the supervisor
>> knowing the name of the file/directory being created, and can remember them
>> / write them out to a persistent profile etc)
>>
>> Note that this is just the filename under the dir represented by fd - this
>> isn't a path or anything that can be subject to symlink-related attacks,
>> etc.  If a program calls e.g.
>> mkdirat or openat (dfd -> "/some/", pathname="dir/stuff", O_CREAT)
>> my understanding is that fd1 will point to /some/dir, and destname would be
>> "stuff"
> 
> Right, this file name information would be useful.  In the case of
> audit, the goal is to efficiently and asynchronously log security events
> (and align with other LSM logs and related limitations), not primarily
> to debug sandboxed apps nor to enrich this information for decision
> making, but the supervisor feature would help here.  The patch message
> should include this rationale.

Will do

> 
>>
>> Actually, in case your question is "why not send a fd to represent the newly
>> created file, instead of sending the name" -- I'm not sure whether you can
>> open even an O_PATH fd to a non-existent file.
> 
> That would not be possible because it would not exist yet, a file name
> (not file path) is OK for this case.
> 
>>
>>>> +		};
>>>> +		struct {
>>>> +			__u16 port;
>>>> +		};
>>>> +	};
>>>> +};
>>>> +
>>>
>>> [...]
>>
>>

