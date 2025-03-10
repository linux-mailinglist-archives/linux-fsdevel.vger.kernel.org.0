Return-Path: <linux-fsdevel+bounces-43563-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4980DA589C2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 01:41:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FE813AC5B0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 00:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A95203595B;
	Mon, 10 Mar 2025 00:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="Jo1uNrxp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iG/NNq5A"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-a2-smtp.messagingengine.com (flow-a2-smtp.messagingengine.com [103.168.172.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390811CD15;
	Mon, 10 Mar 2025 00:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741567294; cv=none; b=WaRXR8E0fXfkVF/J79BOI0D4kuUyHbhlRffYTGn8S+l4k4VpmjoA4q9dAVvs1OOu88OROFlQiqKTQmAHYAkXVIcrnNebArhJXcO0HvXGZhvb0potPJ2UkLJlZn/fHLnbPfjbYiUN0a+0lzjk8SpTyZ5zTmIuk18IZlpX4yIPeeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741567294; c=relaxed/simple;
	bh=C0lIOYeQxK4BOGgbfxQ5Qw90gmHSfcZXG5ZasD9/0IA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=YQ369jbOBXEPt1ZRqHyrjgTInAuwhtQuVMxno/7ryntGXsLLA5MZXv26vEbiVe9SKYhR9NwTt606b+BiKEYUtOPwFCTds39WYkMFRd9QkokuvvRc3VnnmZxg35/pW7zURgkbIIrnSgIrEMyJDEw4NqntCHQOCpp1jEf+nDxdxfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=Jo1uNrxp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iG/NNq5A; arc=none smtp.client-ip=103.168.172.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailflow.phl.internal (Postfix) with ESMTP id 59E84201205;
	Sun,  9 Mar 2025 20:41:31 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Sun, 09 Mar 2025 20:41:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1741567291;
	 x=1741570891; bh=PXc7HL+oK3BydLoUL+4If3m8tkgn/qEjXBfFPyzRVHI=; b=
	Jo1uNrxp5Hcn/1wFJn5cjxcpHzny3Hs3EefK6KsL8aZRXi1fkgwtFNlpYaoD55Uv
	znBZ8b1vo1PqI02XPvjBVLooJB1bRK/qqDZs4OupZbjvetLUnK5/eaD8UAeox31p
	GnZJlmsdiiB3tq5ROedRb1BYsmdZ4o9hL5QCPuqKVKfUVa/QtlDpMpQR+6lPCBK6
	YoA6dTXfCI7Fo5n5uTFsURns2Apt0wYOEnbI3k68cqX2OxeAhhh2OrPdHL8ENf9w
	AFvEohDVZ7sj3fwI26unNHmh57R6O8LFTjdfENEJMHpJZGfKlzOco7cUJS9w92hF
	rZRtdt5lCh6fKZf4qRT4+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741567291; x=
	1741570891; bh=PXc7HL+oK3BydLoUL+4If3m8tkgn/qEjXBfFPyzRVHI=; b=i
	G/NNq5A1wucONX8Ib4bTqsu3o+uVXFfizTiEhOgCYbrQutiQWkHEEMKXHQq4Od7B
	SnBZ9JpIRCJbY2tsv4wikYlMPpwARjcET2E2hn9xwM7FnKUVbMHjlzLj7/Wu+TQ8
	cyPjHhMKOO+pdTpHSA9hVrkXPj8YyvSRAveH6rFpt8u2l9Y9kL215byau4cf8+92
	BpPeQqgzGpGTo0W1Ge2FZZLfhbuuBvCE+F9F1qktGduxZerPkpGfsgtJT4ERYhCH
	42+SEkxLcWB5rEw+z3uVACtVgcV0r58GJ+NcX5xgt4VVG1Yyxo4Cqd2PiR/dsndD
	UwLtp8s0qsgOxv9B5GLyQ==
X-ME-Sender: <xms:OjXOZ35lqW8BMU2CeaOQPArq5gnQlDBRg8oB2wUbFOB8Egc8nJxT6w>
    <xme:OjXOZ86GbdgM0T2tOVoQiTL94fElwUHOdVwzdAsnmTPhi5psljOr5DTA6M4wvsYL3
    kvo69BJjHtCFTr64Y8>
X-ME-Received: <xmr:OjXOZ-fRB2__C-mYL3M7G9pHegWGvhCYo-K_6FGAis1I5_sbatxiD-DPlZbP6blh6jTIMBlppJaNpa5zUji_HODrO_qrrJotZ9eXNBU0Iq6vvNR7ADo4vAC2KMo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduudejledvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepkfffgggfhffuvfevfhgjtgfgsehtkeertddt
    vdejnecuhfhrohhmpefvihhnghhmrghoucghrghnghcuoehmsehmrghofihtmhdrohhrgh
    eqnecuggftrfgrthhtvghrnhepjeefgfeghfejuefhheeigedvteetudeiudefvefhhefg
    gfffhfetudefteevudffnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmsehmrghofihtmhdr
    ohhrghdpnhgspghrtghpthhtohepuddtpdhmohguvgepshhmthhpohhuthdprhgtphhtth
    hopehmihgtseguihhgihhkohgurdhnvghtpdhrtghpthhtohepghhnohgrtghksehgohho
    ghhlvgdrtghomhdprhgtphhtthhopehjrggtkhesshhushgvrdgtiidprhgtphhtthhope
    hlihhnuhigqdhsvggtuhhrihhthidqmhhoughulhgvsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtoheprghmihhrjeefihhlsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    eprhgvphhnohhpsehgohhoghhlvgdrtghomhdprhgtphhtthhopehlihhnuhigqdhfshgu
    vghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthihtghhohesth
    ihtghhohdrphhiiiiirgdprhgtphhtthhopehjrghnnhhhsehgohhoghhlvgdrtghomh
X-ME-Proxy: <xmx:OjXOZ4JVwWRIXPXtslpij9Vmsd7PlHHnxSyGBXjI-4uF7wm9AVV5hQ>
    <xmx:OjXOZ7L4P2UmtMle_4mmVRbqSOcQi-0Uy2A2R-Jo8yogdR5w-CIw5w>
    <xmx:OjXOZxxsq7b59JnzHrpMRlaGU99SMNqv0LyisJacFQIMa2o06nyaqw>
    <xmx:OjXOZ3LBiy6PcVdADJAx2_qVbArdVE8j0ejnGJq57g7EZV6Mj645Fw>
    <xmx:OzXOZ4pgnhb5XhvVdWxsOp5_8kOzLjrhw8MZxTzQR4p1axMVHame6CwN>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 9 Mar 2025 20:41:29 -0400 (EDT)
Message-ID: <8f4abea4-d453-4dfe-be02-7a712f90d1a0@maowtm.org>
Date: Mon, 10 Mar 2025 00:41:28 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Tingmao Wang <m@maowtm.org>
Subject: Re: [RFC PATCH 4/9] User-space API for creating a supervisor-fd
To: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
 Jan Kara <jack@suse.cz>, linux-security-module@vger.kernel.org,
 Amir Goldstein <amir73il@gmail.com>, Matthew Bobrowski <repnop@google.com>,
 linux-fsdevel@vger.kernel.org, Tycho Andersen <tycho@tycho.pizza>,
 Jann Horn <jannh@google.com>, Andy Lutomirski <luto@amacapital.net>
References: <cover.1741047969.git.m@maowtm.org>
 <03d822634936f4c3ac8e4843f9913d1b1fa9d081.1741047969.git.m@maowtm.org>
 <20250305.peiLairahj3A@digikod.net>
Content-Language: en-US
In-Reply-To: <20250305.peiLairahj3A@digikod.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/5/25 16:09, Mickaël Salaün wrote:
> On Tue, Mar 04, 2025 at 01:13:00AM +0000, Tingmao Wang wrote:
>> We allow the user to pass in an additional flag to landlock_create_ruleset
>> which will make the ruleset operate in "supervise" mode, with a supervisor
>> attached. We create additional space in the landlock_ruleset_attr
>> structure to pass the newly created supervisor fd back to user-space.
>>
>> The intention, while not implemented yet, is that the user-space will read
>> events from this fd and write responses back to it.
>>
>> Note: need to investigate if fd clone on fork() is handled correctly, but
>> should be fine if it shares the struct file. We might also want to let the
>> user customize the flags on this fd, so that they can request no
>> O_CLOEXEC.
>>
>> NOTE: despite this patch having a new uapi, I'm still very open to e.g.
>> re-using fanotify stuff instead (if that makes sense in the end). This is
>> just a PoC.
> 
> The main security risk of this feature is for this FD to leak and be
> used by a sandboxed process to bypass all its restrictions.  This should
> be highlighted in the UAPI documentation.
> 
>>
>> Signed-off-by: Tingmao Wang <m@maowtm.org>
>> ---
>>   include/uapi/linux/landlock.h |  10 ++++
>>   security/landlock/syscalls.c  | 102 +++++++++++++++++++++++++++++-----
>>   2 files changed, 98 insertions(+), 14 deletions(-)
>>
>> diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
>> index e1d2c27533b4..7bc1eb4859fb 100644
>> --- a/include/uapi/linux/landlock.h
>> +++ b/include/uapi/linux/landlock.h
>> @@ -50,6 +50,15 @@ struct landlock_ruleset_attr {
>>   	 * resources (e.g. IPCs).
>>   	 */
>>   	__u64 scoped;
>> +	/**
>> +	 * @supervisor_fd: Placeholder to store the supervisor file
>> +	 * descriptor when %LANDLOCK_CREATE_RULESET_SUPERVISE is set.
>> +	 */
>> +	__s32 supervisor_fd;
> 
> This interface would require the ruleset_attr becoming updatable by the
> kernel, which might be OK in theory but requires current syscall wrapper
> signature update, see sandboxer.c change.  It also creates a FD which
> might not be useful (e.g. if an error occurs before the actual
> enforcement).
> 
> I see a few alternatives.  We could just use/extend the ruleset FD
> instead of creating a new one, but because leaking current rulesets is
> not currently a security risk, we should be careful to not change that.
> 
> Another approach, similar to seccomp unotify, is to get a
> "[landlock-domain]" FD returned by the landlock_restrict_self(2) when a
> new LANDLOCK_RESTRICT_SELF_DOMAIN_FD flag is set.  This FD would be a
> reference to the newly created domain, which is more specific than the
> ruleset used to created this domain (and that can be used to create
> other domains).  This domain FD could be used for introspection (i.e.
> to get read-only properties such as domain ID), but being able to
> directly supervise the referenced domain only with this FD would be a
> risk that we should limit.
> 
> What we can do is to implement an IOCTL command for such domain FD that
> would return a supervisor FD (if the LANDLOCK_RESTRICT_SELF_SUPERVISED
> flag was also set).  The key point is to check (one time) that the
> process calling this IOCTL is not restricted by the related domain (see
> the scope helpers).

Is LANDLOCK_RESTRICT_SELF_DOMAIN_FD part of your (upcoming?) 
introspection patch? (thinking about when will someone pass that only 
and not LANDLOCK_RESTRICT_SELF_SUPERVISED, or vice versa)

By the way, is it alright to conceptually relate the supervisor to a 
domain? It really would be a layer inside a domain - the domain could 
have earlier or later layers which can deny access without supervision, 
or the supervisor for earlier layers can deny access first. Therefore 
having supervisor fd coming out of the ruleset felt sensible to me at first.

Also, isn't "check that process calling this IOCTL is not restricted by 
the related domain" and the fact that the IOCTL is on the domain fd, 
which is a return value of landlock_restrict_self, kind of 
contradictory?  I mean it is a sensible check, but that kind of 
highlights that this interface is slightly awkward - basically all 
callers are forced to have a setup where the child sends the domain fd 
back to the parent.

> 
> Relying on IOCTL commands (for all these FD types) instead of read/write
> operations should also limit the risk of these FDs being misused through
> a confused deputy attack (because such IOCTL command would convey an
> explicit intent):
> https://docs.kernel.org/security/credentials.html#open-file-credentials
> https://lore.kernel.org/all/CAG48ez0HW-nScxn4G5p8UHtYy=T435ZkF3Tb1ARTyyijt_cNEg@mail.gmail.com/
> We should get inspiration from seccomp unotify for this too:
> https://lore.kernel.org/all/20181209182414.30862-1-tycho@tycho.ws/

I think in the seccomp unotify case the problem arises from what the 
setuid binary thinks is just normal data getting interpreted by the 
kernel as a fd, and thus having different effect if the attacker writes 
it vs. if the suid app writes it.  In our case I *think* we should be 
alright, but maybe we should go with ioctl anyway... However, how does 
using netlink messages (a suggestion from a different thread) affect 
this (if we do end up using it)?  Would we have to do netlink msgs via 
IOCTL?


>> +	/**
>> +	 * @pad: Unused, must be zero.
>> +	 */
>> +	__u32 pad;
> 
> In this case we should pack the struct instead.
> 
>>   };
>>   
>>   /*
>> @@ -60,6 +69,7 @@ struct landlock_ruleset_attr {
>>    */
>>   /* clang-format off */
>>   #define LANDLOCK_CREATE_RULESET_VERSION			(1U << 0)
>> +#define LANDLOCK_CREATE_RULESET_SUPERVISE		(1U << 1)
>>   /* clang-format on */
>>   
>>   /**
> 
> [...]


