Return-Path: <linux-fsdevel+bounces-45053-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7426BA70DEB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Mar 2025 01:07:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35D217A5146
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Mar 2025 00:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D40D31DFCB;
	Wed, 26 Mar 2025 00:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="k3HvnckE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iGXkj6+Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-b8-smtp.messagingengine.com (flow-b8-smtp.messagingengine.com [202.12.124.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B1914AA9;
	Wed, 26 Mar 2025 00:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742947578; cv=none; b=OUQxdlCwzxpGv7IAwr5DyHwEo+CSPxUOrfmnAX/gLpKvY8qbOaDsfmYnWTbZuNfPpUGpSfxz0FCNklc9sKTI6twqw9cWE+vtgkXMXg71j3TdGaqO06IkiKG4UNTZ4e5wHt3DuBst6DyPUIUaBYPk111swlDExZjr6jylN88VZ08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742947578; c=relaxed/simple;
	bh=5R6XRfnsdKBQMQ6CD770dovj5JvfOIqX1GlfUodKmOI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Lp2KrMQYOA/4YMiPVOv3GsUgPMZ8qjXsnehbqtsjtmIVU/W7V/zDo29Fo2jaBzAG6T+VgAT6iyiSoSAn+uC5r7+YvMz1Voy0VNZTYnGhXurtYk9U9nDwetYfgruCkU5ReUZ9P2otJ6H81H1LukREmVKS4SB3SmnNslBdEwLuM8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=k3HvnckE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iGXkj6+Z; arc=none smtp.client-ip=202.12.124.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailflow.stl.internal (Postfix) with ESMTP id D6F711D414E1;
	Tue, 25 Mar 2025 20:06:13 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 25 Mar 2025 20:06:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1742947573;
	 x=1742951173; bh=ZkSqicNdurS37UAljS55ZTdPpvPuMCRkYkhNyEUzw4o=; b=
	k3HvnckEUn880y0wp70qMBh9omhxHGGJSvJ+LCDo5N4ztbC7HmYXw+x4zkA1iZhH
	YT+JDTN7/qFZ+UA0JZfTa/1WrIFk+Ppcf6D07Xq4iWcGyDU4jq0Jj/kJyyoIi6bO
	EtK+JkQru5Wu4aKCkLSQ55MMFKtGtnn3E+eRVTM/OkyyjMRko2PstXkOLS0bf83T
	YtzYM3Glj/jQtJaASC+eQ15P5utWivCyDcqa7G/zISoaIf2bsPAt/rfBvZUPyCWI
	eowbiGIwlrpxxqORS/Ndy88UpQ6b1h6DrYgKapmv50x8dGil2TeBMtHQrFzvPliE
	IrsQfIXhN0Hfea43Nyx/3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1742947573; x=
	1742951173; bh=ZkSqicNdurS37UAljS55ZTdPpvPuMCRkYkhNyEUzw4o=; b=i
	GXkj6+ZAH3ombnRsR942SGRWgGyqXeeKq6Sma9QVNmJqd8Z5KFfQCjo9TT9E1qvX
	h720Af12RWLMWXPmaphTuFLs/qdgHTorv6kE0LEV4mtMiudw+Q/FQBfgss6vZSVH
	+G67zwOH9jzhDJUzvzfnXEewp62wxNsT6xWZEUgUpEY6/Lsu4l4PXSE8Uh/fIcod
	6HZuJkUVQ85SGVpqmN9tm/AEuZy44hj00k5edTMpxSbZDmbR0osHf4qG9K4oO7x0
	LLC6/dgw6xSFoLsUc27UOAqirzW6il1ufrYg2l+nG1OYdTR1NZFCj8L3DnDYTSZa
	W99E8ghLUiSYYr33QtPHg==
X-ME-Sender: <xms:9ETjZ152AZjKtj_GkLRHH0hYhVZkjDXOh0IjQI_OYCt1rCqhPMGYyw>
    <xme:9ETjZy72lfPrZ0eq6Ij3BT0pwfxGAONRuZF38Ad11vcAlTajqkfeNv39uR9sDiI1t
    KGV3USp8LJqGbrqfBY>
X-ME-Received: <xmr:9ETjZ8d9zz9AA-qhUs4jLhDWsAtOhYIEC_fz3Sxb3EY0WAnM1dgIJxUfQj51b1PJutOtgg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieegtdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepkfffgggfhffuvfevfhgjtgfgsehtkeertddt
    vdejnecuhfhrohhmpefvihhnghhmrghoucghrghnghcuoehmsehmrghofihtmhdrohhrgh
    eqnecuggftrfgrthhtvghrnhepjeefgfeghfejuefhheeigedvteetudeiudefvefhhefg
    gfffhfetudefteevudffnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmsehmrghofihtmhdr
    ohhrghdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epmhhitgesughighhikhhougdrnhgvthdprhgtphhtthhopehgnhhorggtkhesghhoohhg
    lhgvrdgtohhmpdhrtghpthhtohepjhgrtghksehsuhhsvgdrtgiipdhrtghpthhtoheplh
    hinhhugidqshgvtghurhhithihqdhmohguuhhlvgesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopegrmhhirhejfehilhesghhmrghilhdrtghomhdprhgtphhtthhope
    hlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepjhgrnhhnhhesghhoohhglhgvrdgtohhmpdhrtghpthhtoheplhhuthhosegrmhgrtg
    grphhithgrlhdrnhgvth
X-ME-Proxy: <xmx:9UTjZ-LDsGAbKk7jQsw_oAHoNdZT8IZbmI7efjWLedslwP-6JwsyXQ>
    <xmx:9UTjZ5I33Mf9cM4pEpQvIMU09ciXIDN8hXTtwsN5KRglLvIuMUwXbg>
    <xmx:9UTjZ3xxL0r6udzJDSFYgmrNz_Q11VwEq01Q_Pqhj9pASwtjSU2l8Q>
    <xmx:9UTjZ1JLFs8PO9B35ksFrJosJhwe9EQohofHv7UBaZm68DjUfbh4Bg>
    <xmx:9UTjZ3iPBGSSzOcJcIZyyrtW33a52rYfC9bhlx0ZcfLNS-ZaXWeNB0s->
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Mar 2025 20:06:11 -0400 (EDT)
Message-ID: <c96a0cc8-6231-4ca9-94a7-2dbf8de9cdaf@maowtm.org>
Date: Wed, 26 Mar 2025 00:06:11 +0000
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
 Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org,
 Jann Horn <jannh@google.com>, Andy Lutomirski <luto@amacapital.net>
References: <cover.1741047969.git.m@maowtm.org>
 <03d822634936f4c3ac8e4843f9913d1b1fa9d081.1741047969.git.m@maowtm.org>
 <20250305.peiLairahj3A@digikod.net>
 <8f4abea4-d453-4dfe-be02-7a712f90d1a0@maowtm.org>
 <20250311.ieX5eex4ieka@digikod.net>
Content-Language: en-US
In-Reply-To: <20250311.ieX5eex4ieka@digikod.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/11/25 19:28, Mickaël Salaün wrote:
> On Mon, Mar 10, 2025 at 12:41:28AM +0000, Tingmao Wang wrote:
>> On 3/5/25 16:09, Mickaël Salaün wrote:
>>> On Tue, Mar 04, 2025 at 01:13:00AM +0000, Tingmao Wang wrote:
>>>> We allow the user to pass in an additional flag to landlock_create_ruleset
>>>> which will make the ruleset operate in "supervise" mode, with a supervisor
>>>> attached. We create additional space in the landlock_ruleset_attr
>>>> structure to pass the newly created supervisor fd back to user-space.
>>>>
>>>> The intention, while not implemented yet, is that the user-space will read
>>>> events from this fd and write responses back to it.
>>>>
>>>> Note: need to investigate if fd clone on fork() is handled correctly, but
>>>> should be fine if it shares the struct file. We might also want to let the
>>>> user customize the flags on this fd, so that they can request no
>>>> O_CLOEXEC.
>>>>
>>>> NOTE: despite this patch having a new uapi, I'm still very open to e.g.
>>>> re-using fanotify stuff instead (if that makes sense in the end). This is
>>>> just a PoC.
>>>
>>> The main security risk of this feature is for this FD to leak and be
>>> used by a sandboxed process to bypass all its restrictions.  This should
>>> be highlighted in the UAPI documentation.

In particular, if for some reason the supervisor does a fork without 
exec, it must close this fd in the "about-to-be-untrusted" child.

(I wonder if it would be worth enforcing that the child calling 
landlock_restrict_self must not have any open supervisor fd that can 
supervise its own domain (returning an error if it does), but that can 
be difficult to implement so nevermind)

>>>
>>>>
>>>> Signed-off-by: Tingmao Wang <m@maowtm.org>
>>>> ---
>>>>    include/uapi/linux/landlock.h |  10 ++++
>>>>    security/landlock/syscalls.c  | 102 +++++++++++++++++++++++++++++-----
>>>>    2 files changed, 98 insertions(+), 14 deletions(-)
>>>>
>>>> diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
>>>> index e1d2c27533b4..7bc1eb4859fb 100644
>>>> --- a/include/uapi/linux/landlock.h
>>>> +++ b/include/uapi/linux/landlock.h
>>>> @@ -50,6 +50,15 @@ struct landlock_ruleset_attr {
>>>>    	 * resources (e.g. IPCs).
>>>>    	 */
>>>>    	__u64 scoped;
>>>> +	/**
>>>> +	 * @supervisor_fd: Placeholder to store the supervisor file
>>>> +	 * descriptor when %LANDLOCK_CREATE_RULESET_SUPERVISE is set.
>>>> +	 */
>>>> +	__s32 supervisor_fd;
>>>
>>> This interface would require the ruleset_attr becoming updatable by the
>>> kernel, which might be OK in theory but requires current syscall wrapper
>>> signature update, see sandboxer.c change.  It also creates a FD which
>>> might not be useful (e.g. if an error occurs before the actual
>>> enforcement).
>>>
>>> I see a few alternatives.  We could just use/extend the ruleset FD
>>> instead of creating a new one, but because leaking current rulesets is
>>> not currently a security risk, we should be careful to not change that.
>>>
>>> Another approach, similar to seccomp unotify, is to get a
>>> "[landlock-domain]" FD returned by the landlock_restrict_self(2) when a
>>> new LANDLOCK_RESTRICT_SELF_DOMAIN_FD flag is set.  This FD would be a
>>> reference to the newly created domain, which is more specific than the
>>> ruleset used to created this domain (and that can be used to create
>>> other domains).  This domain FD could be used for introspection (i.e.
>>> to get read-only properties such as domain ID), but being able to
>>> directly supervise the referenced domain only with this FD would be a
>>> risk that we should limit.
>>>
>>> What we can do is to implement an IOCTL command for such domain FD that
>>> would return a supervisor FD (if the LANDLOCK_RESTRICT_SELF_SUPERVISED
>>> flag was also set).  The key point is to check (one time) that the
>>> process calling this IOCTL is not restricted by the related domain (see
>>> the scope helpers).
>>
>> Is LANDLOCK_RESTRICT_SELF_DOMAIN_FD part of your (upcoming?) introspection
>> patch? (thinking about when will someone pass that only and not
>> LANDLOCK_RESTRICT_SELF_SUPERVISED, or vice versa)
> 
> I don't plan to work on such LANDLOCK_RESTRICT_SELF_DOMAIN_FD flag for
> now, but the introspection feature(s) would help for this supervisor
> feature.
> 
>>
>> By the way, is it alright to conceptually relate the supervisor to a domain?
>> It really would be a layer inside a domain - the domain could have earlier
>> or later layers which can deny access without supervision, or the supervisor
>> for earlier layers can deny access first. Therefore having supervisor fd
>> coming out of the ruleset felt sensible to me at first.
> 
> Good question.  I've been using the name "domain" to refer to the set of
> restrictions enforced on a set of processes, but these restrictions are
> composed of inherited ones plus the latest layer.  In this case, a
> domain FD should refer to all the restrictions, but the supervisor FD
> should indeed only refer to the latest layer of a domain (created by
> landlock_restrict_self).
> 
>>
>> Also, isn't "check that process calling this IOCTL is not restricted by the
>> related domain" and the fact that the IOCTL is on the domain fd, which is a
>> return value of landlock_restrict_self, kind of contradictory?  I mean it is
>> a sensible check, but that kind of highlights that this interface is
>> slightly awkward - basically all callers are forced to have a setup where
>> the child sends the domain fd back to the parent.
> 
> I agree that its confusing.  I'd like to avoid the ruleset to gain any
> control on domains after they are created.
> 
> Another approach would be to create a supervisor FD with the
> landlock_create_ruleset() syscall, and pass this FD to the ruleset,
> potentially with landlock_add_rule() calls to only request this
> supervisor when matching specific rules (that could potentially be
> catch-all rules)?

Maybe passing in a fd per landlock_add_rule calls, and thus potentially 
allowing different supervisor fd tied to different rules in the same 
ruleset, is a bit overkill (as now each rule needs to store a supervisor 
pointer?) and I don't really see the use of it.  I think it would be 
better to just pass it once in the landlock_ruleset_attr, which gets 
around the signature having const for the ruleset_attr problem. (I'm 
also open to the ioctl on domain fd idea, but I'm slightly wary of 
making this more complicated then necessary for the user space, as it 
now has to set up a socket (?) and pass a fd with scm_rights (?))

The other aspect of this is whether we want to have the supervisor mark 
specific rules as supervised, rather than having all denied access (from 
this layer) result in a supervisor invocation.  I also don't think this 
is necessary, as denials are supposed to be "abnormal" in some sense, 
and I would imagine most supervisors would want to find out about these 
(at least to print/show a warning of some sort, if it knows that the 
requested access is bad).  If a supervisor really wants to have the 
kernel just "silently" (from its perspective, but maybe there would be 
audit logs) deny any access outside of some known rules, it can also 
create a nested, unsupervised landlock domain that has the right effect. 
Avoiding having some sort of tri-state rules would simplify 
implementation, I imagine.

> 
> Overall, my main concern about this patch series is that the supervisor
> could get a lot of requests, which will make the sandbox unusable
> because always blocked by some thread/process.  This latest approach and
> the ability to update the domain somehow could make it workable.
> 
>>
>>>
>>> Relying on IOCTL commands (for all these FD types) instead of read/write
>>> operations should also limit the risk of these FDs being misused through
>>> a confused deputy attack (because such IOCTL command would convey an
>>> explicit intent):
>>> https://docs.kernel.org/security/credentials.html#open-file-credentials
>>> https://lore.kernel.org/all/CAG48ez0HW-nScxn4G5p8UHtYy=T435ZkF3Tb1ARTyyijt_cNEg@mail.gmail.com/
>>> We should get inspiration from seccomp unotify for this too:
>>> https://lore.kernel.org/all/20181209182414.30862-1-tycho@tycho.ws/
>>
>> I think in the seccomp unotify case the problem arises from what the setuid
>> binary thinks is just normal data getting interpreted by the kernel as a fd,
>> and thus having different effect if the attacker writes it vs. if the suid
>> app writes it.  In our case I *think* we should be alright, but maybe we
>> should go with ioctl anyway...
> 
> I don't see why Jann's attack scenario could work for this Landlock
> supervisor too.  The main point that it the read/write interfaces are
> used by a lot of different FDs, and we may not need them.
> 
>> However, how does using netlink messages (a
>> suggestion from a different thread) affect this (if we do end up using it)?
>> Would we have to do netlink msgs via IOCTL?
> 
> Because all requests should be synchronous, one IOCTL could be used to
> both acknowledge a previous event (or just start) and read the next one.
> 
> I was thinking about an IOCTL with these arguments:
> 1. supervisor FD
> 2. (extensible) IOCTL command (see PIDFD_GET_INFO for instance)
> 3. pointer to a fixed-size control structure
> 
> The fixed-size control structure could contain:
> - handled access rights, used to only get event related to specific
>    access.
> - flags, to specify which kind of FD we would like to get (e.g. only
>    directory FD, pidfd...)
> - fd[6]: an array of received file descriptors.
> - pointer to a variable-size data buffer that would contain all the
>    records (e.g. source dir FD, source file name, destination dir FD,
>    destination file name) for one event, potentially formatted with NLA.
> - the size of this buffer
> 
> I'm not sure about the content of this buffer and the NLA format, and
> the related API might not be usable without netlink sockets though.
> Taking inspiration from the fanotify message format is another option.
> 
>>
>>
>>>> +	/**
>>>> +	 * @pad: Unused, must be zero.
>>>> +	 */
>>>> +	__u32 pad;
>>>
>>> In this case we should pack the struct instead.
>>>
>>>>    };
>>>>    /*
>>>> @@ -60,6 +69,7 @@ struct landlock_ruleset_attr {
>>>>     */
>>>>    /* clang-format off */
>>>>    #define LANDLOCK_CREATE_RULESET_VERSION			(1U << 0)
>>>> +#define LANDLOCK_CREATE_RULESET_SUPERVISE		(1U << 1)
>>>>    /* clang-format on */
>>>>    /**
>>>
>>> [...]
>>
>>


