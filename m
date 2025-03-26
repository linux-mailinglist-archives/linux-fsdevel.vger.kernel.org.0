Return-Path: <linux-fsdevel+bounces-45052-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A6D5A70DDF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Mar 2025 01:04:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33F7618877A9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Mar 2025 00:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20C312E3370;
	Wed, 26 Mar 2025 00:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="DMFNZpC2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="W5P69hPP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-b8-smtp.messagingengine.com (flow-b8-smtp.messagingengine.com [202.12.124.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A218196;
	Wed, 26 Mar 2025 00:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742947455; cv=none; b=oWIqcCY3QVLrU/HbbUw9O/W7PNTGTPMRFHFqTdjkbxSsW9rMQwQVdzHTKRt8lmH0CsSwk+LYy8P6ZXr5hBSPKzsnXprskCXGzq+n09Us6oVag/Gs8S6KzuwXm8L8X5qS1z34/YKzIcbLnNPy5S/rqrVqnrsM7WuRDQ3Cuh783rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742947455; c=relaxed/simple;
	bh=TR7DrG4K7pZ1c/JQSnI5XUVv96vN8aATvSbBfUmZWH0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XF6jo8Sb1SLyHFGJIeqrbpRgHyvo3nng51vo/kw8qvzcjLRSEa3iKCyfldpUL9KjJoqt/sSN6mnTtWnxGhsRS+I5MfjuW+ct0sq+FD5qI41veBmejilOjSkPYtQuPYTwWsMAPiJH7vLBjIMVOZRSeshmIuTUifo2ViKk8dYMfsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=DMFNZpC2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=W5P69hPP; arc=none smtp.client-ip=202.12.124.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailflow.stl.internal (Postfix) with ESMTP id C9CD21D414E3;
	Tue, 25 Mar 2025 20:04:11 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 25 Mar 2025 20:04:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1742947451;
	 x=1742951051; bh=m4l/q9V2dSOFC5U3I6XEeoMUQl4KjUMU85tGOonrlrM=; b=
	DMFNZpC25hT6H+fKwumbe/vSglRJiNTQddwrW+9U7Ud8IlI3Zvd7ZxZTcDWIt66Z
	4V/9h2UJ5Iei9knip7uiiNM1DbZysV4y60cCwMgCaVzmSeVbNciGyyvC1THbQqK0
	+rSPIb8NxC23YlPk4xVpVu/be01DAlW2SQUFWuYQLsJfrQIbgCbpG/n09G3QNKoi
	OjaWXUfSWaWJ8++8dTcN/KO25qKOVtOPRkiOzSfy69+LUswIv/ndIkBMCO1L3LC4
	SSKqK4TZHy+LfqjG14YaHk/myBu95s4le4juzm3ULVpruovrF1U99mWDyzooFYrX
	ou8GSLCoFAtdOwAnuGtNUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1742947451; x=
	1742951051; bh=m4l/q9V2dSOFC5U3I6XEeoMUQl4KjUMU85tGOonrlrM=; b=W
	5P69hPPUyrvg8JvABM71oKhn6dp5QMY8Y4PpBt7Ci0uAealYBCnhIvquiZWt5vbh
	KH3PtCpZyfj59GioqykwYxA5QJvkLnBe5VfjFeWjEqSJXSoZdwCnv85nVYG1qFQl
	cLSxJYOjdJRLsKBNhsyKCj3jFPF5h+9y8/I5RXfmZB6VvjOzJSz9zCu13r0KKL54
	UocGorFHKiH8vQtnzbkikuTWZVHYfpf/3rKf7FR13dnydrqR269GR+u7QuBbbVDg
	C6wWun+7OHb3JpR58HhKMElP/KhwGuBWp47JzQ2HqwNEKXH4CY3J9kWd1Uh7PK44
	3bjfJykygblzmKgFyNUHw==
X-ME-Sender: <xms:ekTjZwkDVP7Ih-aIGWpxBQmmC6qu4cchY54ETo4iqzvWect0vfPTXA>
    <xme:ekTjZ_18waaxWJIb0WtpUgrliDbskX7h787WjQH2J2E5dTJrVawqqhR86NoWjWXwI
    hdEbFRgjOFVFuJLMNU>
X-ME-Received: <xmr:ekTjZ-rdSW2FUDtVY2EX7lw_XklXhPme5oX6UOLMVV6ptGxs03WOzoxTwy3AK-k3AUp4Zg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieegtdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddt
    vdejnecuhfhrohhmpefvihhnghhmrghoucghrghnghcuoehmsehmrghofihtmhdrohhrgh
    eqnecuggftrfgrthhtvghrnhepfffhhfegueejkeefhffffeetieejffevtedutefhhfej
    jeegleeuieejfffggedunecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmsehmrghofihtmhdr
    ohhrghdpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epmhhitgesughighhikhhougdrnhgvthdprhgtphhtthhopehgnhhorggtkhesghhoohhg
    lhgvrdgtohhmpdhrtghpthhtohepjhgrtghksehsuhhsvgdrtgiipdhrtghpthhtoheplh
    hinhhugidqshgvtghurhhithihqdhmohguuhhlvgesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopegrmhhirhejfehilhesghhmrghilhdrtghomhdprhgtphhtthhope
    hrvghpnhhophesghhoohhglhgvrdgtohhmpdhrtghpthhtoheplhhinhhugidqfhhsuggv
    vhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehthigthhhosehthi
    gthhhordhpihiiiigrpdhrtghpthhtohepnhhitgholhgrshdrsghouhgthhhinhgvthes
    shhsihdrghhouhhvrdhfrh
X-ME-Proxy: <xmx:ekTjZ8kkb6qBllyPCsvvRo23Lxe22CcczNkESBikknvKzBLeKSAzdw>
    <xmx:ekTjZ-0D79_4anMZQTZb914-fvcdylZ8SsNYcs52iBYfwcpZskTA1Q>
    <xmx:ekTjZzs2rrsNlvdjeNtrIGp-nGwdjoHNkh_slAwPMrlU1vAY99pCVA>
    <xmx:ekTjZ6Wq5wjkGHdDSLO1q5xUVpPSCjJ0DFrFJ8m_9yVcBQeBvDMssQ>
    <xmx:e0TjZ4o83KaBeBwvVoCdUAxIYHkPiX5F2jn3U_gP3ILcCbvrZmcH2ATe>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Mar 2025 20:04:09 -0400 (EDT)
Message-ID: <d46ab68c-efec-4204-b720-5fb819daa329@maowtm.org>
Date: Wed, 26 Mar 2025 00:02:38 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 5/9] Define user structure for events and responses.
To: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
 Jan Kara <jack@suse.cz>, linux-security-module@vger.kernel.org,
 Amir Goldstein <amir73il@gmail.com>, Matthew Bobrowski <repnop@google.com>,
 linux-fsdevel@vger.kernel.org, Tycho Andersen <tycho@tycho.pizza>,
 Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
References: <cover.1741047969.git.m@maowtm.org>
 <cde6bbf0b52710b33170f2787fdcb11538e40813.1741047969.git.m@maowtm.org>
 <20250304.eichiDu9iu4r@digikod.net>
 <fbb8e557-0b63-4bbe-b8ac-3f7ba2983146@maowtm.org>
 <543c242b-0850-4398-804c-961470275c9e@maowtm.org>
 <20250311.laiGhooquu1p@digikod.net>
 <63681c08-dd9e-4f8f-9c41-f87762ea536c@maowtm.org>
 <20250312.uo7QuoiZ7iu1@digikod.net>
Content-Language: en-US
From: Tingmao Wang <m@maowtm.org>
In-Reply-To: <20250312.uo7QuoiZ7iu1@digikod.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/12/25 11:49, Mickaël Salaün wrote:
> On Tue, Mar 11, 2025 at 11:18:49PM +0000, Tingmao Wang wrote:
>> On 3/11/25 19:28, Mickaël Salaün wrote:
>>> On Mon, Mar 10, 2025 at 12:39:04AM +0000, Tingmao Wang wrote:
>>>> On 3/6/25 03:05, Tingmao Wang wrote:
>>>> [...]
>>>>> This is also motivated by the potential UX I'm thinking of. For example,
>>>>> if a newly installed application tries to create ~/.app-name, it will be
>>>>> much more reassuring and convenient to the user if we can show something
>>>>> like
>>>>>
>>>>>        [program] wants to mkdir ~/.app-name. Allow this and future
>>>>>        access to the new directory?
>>>>>
>>>>> rather than just "[program] wants to mkdir under ~". (The "Allow this
>>>>> and future access to the new directory" bit is made possible by the
>>>>> supervisor knowing the name of the file/directory being created, and can
>>>>> remember them / write them out to a persistent profile etc)
>>>>
>>>> Another significant motivation, which I forgot to mention, is to auto-grant
>>>> access to newly created files/sockets etc under things like /tmp,
>>>> $XDG_RUNTIME_DIR, or ~/Downloads.
>>>
>>> What do you mean?  What is not currently possible?
>>
>> It is not currently possible with landlock to say "I will allow this
>> application access to create and open new file/folders under this directory,
>> change or delete the files it creates, but not touch any existing files".
>> Landlock supervisor can make this possible (keeping track via its own state
>> to allow future requests on the new file, or modifying the domain if we
>> support that), but for that the supervisor has to know what file the
>> application tried to create, hence motivating sending filename.
> 
> This capability would be at least inconsistent, and dangerous at worse,
> because of policy inconsistencies over time.  A sandbox policy should be
> seen over several invocations of the same sandbox.  See related deny
> listing issues: https://github.com/landlock-lsm/linux/issues/28
> 
> Let's say a first instance of the sandbox can create files and access
> them, but not other existing files in the same directory.  A second
> instance of this sandbox would not be able to access the files the same
> application created, so it will not be able to clean them if required.
> That could be OK in the case of the ~/Downloads directory but I think it
> would be weird for users to not be able to open their previous
> downloaded files from the browser, whereas it was allowed before.
> 
> For such use case, if we want to avoid new browser instances to access
> old downloaded files, I'd recommand to create a new download directory
> per browser/sandbox launch.
> 

I had some more thoughts on this - In terms of inconsistency / security 
implications of such a supervisor behaviour, I think I can identify two 
aspects:

First is policy inconsistency over different instances / restarts (like 
the example you mentioned about not being able to open previously 
downloaded files).  I think in this case, this is fine and would not be 
dangerous, because it will only result in extra permission requests 
(potentially the user having to allow the access again, or maybe the 
sandboxer can remember it from last time and auto-allow it internally). 
(whereas an inconsistent deny rule is more problematic because it opens 
up the access on the next restart / for other instances, if done wrong)

The second problem is that if the supervisor wants to automatically 
permit further access to the newly created files, it can only do so by 
remembering and comparing file names, since the new inode doesn't exist 
yet*, and so even with mutable domains there is nothing to attach new 
rules to.  This means that there is a potential for files/dirs to be 
moved/created/linked behind its back onto the destination by someone 
outside the sandbox, and this may result in the supervisor 
unintentionally allowing access to files it doesn't want to? (like, if 
it approves the request based solely on the belief that the file is new)

*: Assuming we don't want to lock the parent dir forever until the 
supervisor replies.

While this does seem like a problem, I'm not sure how practical it would 
be to exploit, since any further action by the sandboxed app itself on 
the destination can/would also be blocked by landlock, and in some sense 
we're already dead if the sandboxed app can somehow convince something 
outside of the sandbox to create arbitrary links or move arbitrary files 
to a destination path that would appear to belong legitimately to the 
malicious app.  But this does raises more questions than I initially 
thought, and shows how an overly creative supervisor may shoot itself in 
the foot -- when filenames are involved in permission decisions the 
semantics starts becoming a bit fuzzy, and is different from current 
landlock which is entirely inode-based.

With that said, I would still really like to make the mentioned UX 
possible tho - allowing an app to create a file/dir and any further 
access to it as well _feels very intuitive_, and is especially 
convenient for cases where the first launch of an app is sandboxed.  But 
I do recognize that this capability is less important for self-sandbox 
scenarios (since the supervisor can pre-create all the scaffolding 
directories it knows the app would need).

I have some thoughts, none of which are perfect, and not doing any of 
them is also an option (i.e. the supervisor just have to decide whether 
to give permission to create files of arbitrary names or not, and can't 
find out about any new files/dirs created (unless with some other Linux 
mechanism)):

1. Maybe there can be a mechanism for the supervisor to be invoked 
post-creation (passing in a fd for the new file directly), then it can 
prompt the user and either allow and optionally add the new inode to the 
mutable domain, or it can "undo" the operation by deleting the new 
file/dir then reject the "request".  I recognize that this is a bit 
weird and is also only applicable to supervise mode, but it might be 
acceptable since merely creating an empty file/dir is relatively 
harmless (ignoring symlinks and device nodes for the moment).

2. The supervisor can create the file/dir/device-node/symlink on behalf 
of the sandboxed app, if we can pass all the relevant arguments to it in 
the request.  Then there needs to be a mechanism for it to tell the 
kernel to return a custom error code to the invoking program.
(seccomp-unotify deja vu)

3. We find a way to implement "allow once" which will only allow this 
particular create request, with this name.  At least this way the 
supervisor can implement the above mentioned feature, with the caveat 
mentioned above.

(For other's reference, I had a discussion with Mickaël and it looks 
like we will want to have mutable domains and base the implementation of 
landlock supervise off that, returning a -ERESTARTNOINTR from the hook 
when access is allowed.  I will write up the discussion tomorrow / later)


>>
>> (I can see this kind of policy being applied to dirs like /tmp or my
>> Downloads folder. $XDG_RUNTIME_DIR is also a sensible place for this
>> behaviour due to the common pattern of creating a lock/pid file/socket
>> there, although on second thought a GUI sandbox probably will want to create
>> a private copy of that dir anyway for each app, to do dbus filtering etc)
> 
> An $XDG_RUNTIME_DIR per sandbox looks reasonable, but in practice we
> also need secure proxies/portals to still share some user's resources.
> This part should be implemented in user space because the kernel doesn't
> know about this semantic (e.g. DBus requests).


