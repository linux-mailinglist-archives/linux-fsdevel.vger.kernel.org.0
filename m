Return-Path: <linux-fsdevel+bounces-43562-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF0C6A589BE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 01:39:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A18D16A210
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 00:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 670162BD11;
	Mon, 10 Mar 2025 00:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="YW4L6Fvz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BcyVoxUA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-a2-smtp.messagingengine.com (flow-a2-smtp.messagingengine.com [103.168.172.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0AEC35976;
	Mon, 10 Mar 2025 00:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741567162; cv=none; b=OhhyRHac02iK/PhZjrw/WCf+70LV+Hn005COTIOBkhjP1On/zWqs6vOlp4+rZJSxrN6ZEJPj7zbZOo7VinKZI3AvV7j0RBzn3USvNxcZbFt735Ld9rNuIBRBCAgvwH6E/BxkplP3WsoFAB6Movc3w6BUO1HDT8JVcNY3+CoM95U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741567162; c=relaxed/simple;
	bh=qYER83dfMWCq/Y8i6hOP6WV+FDpJEKYwLNU88lbFD4I=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=HoCEk45Nh5wGoYDri4vI7mPZ6/C7PKKzVCXOhX0UOjocHLaXWOYR/d7i1i7gXggw9e2PHGcpUICcP7tuSs154blXrPAiAcd37VSON6Ex5F2AQVZP0ZUJqMPXmLZ6FHQ9Ozfaxzp+yhT66YGYQWzPqtVjy6D5qtu8eBwU/eke9dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=YW4L6Fvz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BcyVoxUA; arc=none smtp.client-ip=103.168.172.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailflow.phl.internal (Postfix) with ESMTP id C96D42014BD;
	Sun,  9 Mar 2025 20:39:19 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Sun, 09 Mar 2025 20:39:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1741567159;
	 x=1741570759; bh=M8SmFdfg/cqp/nFJuIfc+fnzM2SLzZOhG95BZTTl99c=; b=
	YW4L6Fvze8EdcMkkdwMmLWdolEUc0meHvKB1M34chhBnUmpEaUoBAewM2G+iKlbZ
	yiR6s6Vl3ootiwcYdRJ0bZs+SzFJwfQabG6fUXDZgWBzIrIoHksXHQH5BVxTFTFh
	e3PFF3ax3VyN2v0zFIl0pyRthiTlz/K5sGM60mhVdm7aKphKWK4l4JMujB5vrYFR
	Lhrws/r0vY0Ek5gqErcj9QceL5ZuQMDRuAtZE/wRhkrWNUKb5n1XBXQGxJcmYgE+
	Ruxjc+5nFCgWkTMoksziJmzj4saA44dCwy9yiS6YjP4IV/dtdj3J3chu9OaW9F3b
	XqqBM+tcePNAOfO27fIEgQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741567159; x=
	1741570759; bh=M8SmFdfg/cqp/nFJuIfc+fnzM2SLzZOhG95BZTTl99c=; b=B
	cyVoxUARwKie90aJnSdTH02HomAndKUjplcaDRCCx855Jvw7ulrSpocRUvNnjWcw
	LtbhICNPKytX07AZcATFtS4/G467OlLqEGesqODUk8d5SvoFXGu9CPb4yHCFKdO5
	m2RF4w9bTkgXbZQS7fRPFAhHvrhWu6MOIUvFHFNMcGDZsBlOCpUSh3iBWVn2Sy0d
	LxH3VLCIyoxx8OMwYjKajQUaliwfBOyRMSeWwTpSVfte9TnG/zT9nK4H9VkPly7k
	IoDZP08wpRs0y46b/ogRBrnLLUlGDq3GrAarfJKC4Z01psnn6tktLpjgI3RBuSGD
	nCADXfgctSIvIc2TNR5gA==
X-ME-Sender: <xms:tzTOZydYphi2IvybMRftSc5Bw9y8gU8poh_l9EAhlfVuu3KxlG7qPQ>
    <xme:tzTOZ8Ou8E8ZFkm8u9M-Qcr3Z0fo-FaXxLeCVSlBFWiCg9x2JOt2V63KQCGrGuuAW
    YLtdw4Y1khz48d4EWg>
X-ME-Received: <xmr:tzTOZzjzoXOznt3H5gbKx3KLA2aglRThWA3xPrAKakIR723rTmQCH1GTeYU0BMfOx6XHaYqnirAPGdS37qJchauhZruMVfRLChjjfLxCuAG3NX70WHMNMAIH660>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduudejledvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepkfffgggfhffuvfevfhgjtgfgsehtkeertddt
    vdejnecuhfhrohhmpefvihhnghhmrghoucghrghnghcuoehmsehmrghofihtmhdrohhrgh
    eqnecuggftrfgrthhtvghrnhepvdegudeugfdujefgtdetffdujeejleeliedukeeujedu
    heetgffhgedvteevffeunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepmhesmhgrohifthhmrdhorhhgpdhnsggprhgtphhtthhopeekpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehmihgtseguihhgihhkohgurdhnvghtpdhrtg
    hpthhtohepghhnohgrtghksehgohhoghhlvgdrtghomhdprhgtphhtthhopehjrggtkhes
    shhushgvrdgtiidprhgtphhtthhopehlihhnuhigqdhsvggtuhhrihhthidqmhhoughulh
    gvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghmihhrjeefihhlsehg
    mhgrihhlrdgtohhmpdhrtghpthhtoheprhgvphhnohhpsehgohhoghhlvgdrtghomhdprh
    gtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepthihtghhohesthihtghhohdrphhiiiiirg
X-ME-Proxy: <xmx:tzTOZ_9K_MgmkRE7ljLUuazlbuF8h39RKjpQvoPOw0o8G5EKZsN7NA>
    <xmx:tzTOZ-vMJMA6d2QU3RwlMTJxPVirA8vP21GGQw4H0Cw7kh3QRW_Paw>
    <xmx:tzTOZ2H-UBNTXM5FE8LcYnivjIUW7E8CV1Mw6oBWJ92WkQQ6DUQwsQ>
    <xmx:tzTOZ9MGERCZys2CyK_zC4Xqn2aSKi8FFL6thf-NhRGxGqN750kOzg>
    <xmx:tzTOZwX8mJ6v5jwu3GkN0yH8UziRMicp4xIZYjhkzWVKJcyzN5QiPHZ7>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 9 Mar 2025 20:39:18 -0400 (EDT)
Message-ID: <f6e136a8-7594-4cca-bf48-58c0ddc0ddc7@maowtm.org>
Date: Mon, 10 Mar 2025 00:39:17 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Tingmao Wang <m@maowtm.org>
Subject: Re: [RFC PATCH 6/9] Creating supervisor events for filesystem
 operations
To: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
 Jan Kara <jack@suse.cz>, linux-security-module@vger.kernel.org,
 Amir Goldstein <amir73il@gmail.com>, Matthew Bobrowski <repnop@google.com>,
 linux-fsdevel@vger.kernel.org, Tycho Andersen <tycho@tycho.pizza>
References: <cover.1741047969.git.m@maowtm.org>
 <ed5904af2bdab297f4137a43e44363721894f42f.1741047969.git.m@maowtm.org>
 <20250304.oowung0eiPee@digikod.net>
Content-Language: en-US
In-Reply-To: <20250304.oowung0eiPee@digikod.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/4/25 19:50, Mickaël Salaün wrote:
> On Tue, Mar 04, 2025 at 01:13:02AM +0000, Tingmao Wang wrote:
>> NOTE from future me: This implementation which waits for user response
>> while blocking inside the current security_path_* hooks is problematic due
>> to taking exclusive inode lock on the parent directory, and while I have a
>> proposal for a solution, outlined below, I haven't managed to include the
>> code for that in this version of the patch. Thus for this commit in
>> particular I'm probably more looking for suggestions on the approach
>> rather than code review.  Please see the TODO section at the end of this
>> message before reviewing this patch.
> 
> This is good for an RFC.
> 
>>
>> ----
>>
>> This patch implements a proof-of-concept for modifying the current
>> landlock LSM hooks to send supervisor events and wait for responses, when
>> a supervised layer is involved.
>>
>> In this design, access requests which would end up being denied by other
>> non-supervised landlock layers (or which would fail the normal inode
>> permission check anyways - but this is currently TODO, I only thought of
>> this afterwards) are denied straight away to avoid pointless supervisor
>> notifications.
> 
> Yes, only denied access should be forwarded to the supervisor.

I assume you meant only denied access *by the supervised layers* should 
be forwarded to the supervisor.

> In another patch series we could enable the supervisor to update its layer
> with new rules as well.

I did consider the possibility of this - if the supervisor has decided 
to allow all future access to e.g. a directory, ideally this can be 
"offloaded" to the kernel, but I was a bit worried about the fact that 
landlock currently quite heavily assumes the domain is immutable. While 
in the supervised case breaking that rule here should be alright (no 
worse security), not sure if there is some potential logic / data race 
bugs if we now make domains mutable.

> 
> The audit patch series should help to properly identify which layer
> denied a request, and to only use the related supervisor.

The current patch does correctly identify which layer(s) (and sends 
events to the right supervisor(s)), but aligning with and re-using code 
in the audit patch is sensible.  Will have a look.

> 
>>
>> Currently current_check_access_path only gets the path of the parent
>> directory for create/remove operations, which is not enough for what we
>> want to pass to the supervisor.  Therefore we extend it by passing in any
>> relevant child dentry (but see TODO below - this may not be possible with
>> the proper implementation).
> 
> Hmm, I'm not sure this kind of information is required (this is not
> implemented for the audit support).  The supervisor should be fine
> getting only which access is missing, right?
> 
>>
>> This initial implementation doesn't handle links and renames, and for now
>> these operations behave as if no supervisor is present (and thus will be
>> denied, unless it is allowed by the layer rules).  Also note that we can
>> get spurious create requests if the program tries to O_CREAT open an
>> existing file that exists but not in the dcache (from my understanding).
>>
>> Event IDs (referred to as an opaque cookie in the uapi) are currently
>> generated with a simple `next_event_id++`.  I considered using e.g. xarray
>> but decided to not for this PoC. Suggestions welcome. (Note that we have
>> to design our own event id even if we use an extension of fanotify, as
>> fanotify uses a file descriptor to identify events, which is not generic
>> enough for us)
> 
> That's another noticable difference with fanotify.  You can add it to
> the next cover letter.
> 
>>
>> ----
>>
>> TODO:
>>
>> When testing this I realized that doing it this way means that for the
>> create/delete case, we end up holding an exclusive inode lock on the
>> parent directory while waiting for supervisor to respond (see namei.c -
>> security_path_mknod is called in may_o_create <- lookup_open which has an
>> exclusive lock if O_CREAT is passed), which will prevent all other tasks
>> from accessing that directory (regardless of whether or not they are under
>> landlock).
> 
> Could we use a landlock_object to identify this inode instead?

Sorry - earlier when reading this I didn't quite understand this 
suggestion and forgot to say so, however the problem here is the 
location of the security_path_... hooks (by the time they are called the 
lock is already held). I'm not sure how we identify the inode makes a 
difference?

> 
>>
>> This is clearly unacceptable, but since landlock (and also this extension)
>> doesn't actually need a dentry for the child (which is allocated after the
>> inode lock), I think this is not unsolvable.  I'm experimenting with
>> creating a new LSM hook, something like security_pathname_mknod
>> (suggestions welcome), which will be called after we looked up the dentry
>> for the parent (to prevent racing symlinks TOCTOU), but before we take the
>> lock for it.  Such a hook can still take as argument the parent dentry,
>> plus name of the child (instead of a struct path for it).
>>
>> Suggestions for alternative approaches are definitely welcome!
>>
>> Signed-off-by: Tingmao Wang <m@maowtm.org>
>> ---
>>   security/landlock/fs.c        | 134 ++++++++++++++++++++++++++++++++--
>>   security/landlock/supervise.c | 122 +++++++++++++++++++++++++++++++
>>   security/landlock/supervise.h | 106 ++++++++++++++++++++++++++-
>>   3 files changed, 354 insertions(+), 8 deletions(-)
>>
> 
> [...]


