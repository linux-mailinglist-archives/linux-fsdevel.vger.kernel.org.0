Return-Path: <linux-fsdevel+bounces-79820-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6ECRNsAEr2knLwIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79820-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 18:34:56 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4273A23DAF4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 18:34:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0DBBE301BF74
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Mar 2026 17:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2743A2EBDDE;
	Mon,  9 Mar 2026 17:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="KeLY1Koy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZxR7wig+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56211DC9B3
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Mar 2026 17:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773077678; cv=none; b=lgsjD72ys0IsTlQ61T/MxzgvvNDf6EKSe8vWNz9DhS2comeAdAGNcwqvYL/3ZE7Hfqyf0jcsOvCzZywgpGFMikgx94S5fBzpBH+BcxtMVBZshK+tN1eMx+Jevk4yFWE/cW90/wtllUHYlv1WFA1oYKeUTDNc2qqqowmKdWqV/Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773077678; c=relaxed/simple;
	bh=pIbLFdIZBip+RWddW6vHEwW4MriIbVvl0hGCG0r+DJM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kne40+hunwNgb5vLmwii/3tet2lJlmHlLeh52GJQ/bRnyeaZOclN6BiNsBOw5CjXp0TkuDRZFMxT6XSJssia9fgWDbc2Tj8iddDFFvMFcNvrC6u/DrTHAbX2LWd4k4Coqvroy84ZaCOGGOg/nRglX1ssa+PMXE39acLno5o6CfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=KeLY1Koy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZxR7wig+; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id B11A51D00237;
	Mon,  9 Mar 2026 13:34:35 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 09 Mar 2026 13:34:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1773077675;
	 x=1773164075; bh=L/DX4dqZar6JhZnHb+7p+VU+TTqaetDRKHcVQmtZAIQ=; b=
	KeLY1Koy6yedE/q2qfxaNNpGkIQv6kLGDX++ikowMZxa9E4ZVFH8K8aEuyR3wZZo
	XYp4V5CMvyl7uV44ZsOBMPyCmI8mQpvhBBS96GFa+FF66Z2uuv9pNSbaWIiy+ZqC
	DAXTVigkVWN9byTHAWp8HIsQ5UYiuIgFtmZfG4+BljWYzBl6qdqVFiiKZl6iEZ3i
	8xMoDWksguTZ6LyrgXNYWBT4Ovf7r41uOUJimBpNIJnalCLWY0eUyUtixwq1sJaW
	j7e0g2mA88IlIoYH8JsQgkIdcj9twKomWXClvmXqwGIPcq8bmRMBi5QdYh0GD4zy
	N/18KnsEz0z0upF+vYkTuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773077675; x=
	1773164075; bh=L/DX4dqZar6JhZnHb+7p+VU+TTqaetDRKHcVQmtZAIQ=; b=Z
	xR7wig+zVwWuKmDqqXBupAB+7Y2+0uQO62Slpr3ZBZ8M5/BmIHhZYrwvXCFKn/9Y
	AVM24Qn8hmYxT78KoTQaQTTzddqISc3uZPIhKEJnBVQOmh4MtVuAcB47f+o5RJyj
	r7/ZqEd9VSgONhtYsUBauOOU7waIwDk4PEFKcdTt+pv5vmPgoGt4SSkyhGPxfIz3
	0AefV9A6/3R/8YUkQqQIKKhwU9zfChWq44uM4mdQt+uDDUgaYDCIUQg3K+QVzXDB
	McoQHzuBRaIvGiOjHIe74vBL6m63MT5Unp+96E8Th5zmVqfZdyoybZ+KVni72qXH
	rEhXItXspRSkssU8bOnVA==
X-ME-Sender: <xms:qgSvab9WmyKarUkg7LLFlQwaiv-5y7XK9FA9bI-KBofnGp5fOspCBA>
    <xme:qgSvabbKmN0KQLisir18_WmIHyqa39cvs8cRJp76FWXP9Sn_k-tN3jAI6OjBFXlFD
    5r0m269pjZH5fmOos6aJ2Vr5YtiHeEwE72ztwYPstAzMnrHRFDK>
X-ME-Received: <xmr:qgSvaS0uuZxp08rE8b2-Qel8GVQQl-gxCJknaSFav-RuJlLk400pI_RRAIXZOxinQbB3Ja74988M2HuM-4zMD7Phb0PjhUV0870wGtM61ZYZp7YsTg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvjeekjeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeeuvghrnhgu
    ucfutghhuhgsvghrthcuoegsvghrnhgusegsshgsvghrnhgurdgtohhmqeenucggtffrrg
    htthgvrhhnpeeugfevvdeggeeutdelgffgiefgffejheffkedtieduffehledvfeevgeej
    hedtjeenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepsggvrhhnugessghssggvrhhnugdrtgho
    mhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepug
    hjfihonhhgsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegsshgthhhusggvrhhtsegu
    ughnrdgtohhmpdhrtghpthhtohepjhhorghnnhgvlhhkohhonhhgsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehmihhklhhoshesshiivghrvgguihdrhhhupdhrtghpthhtoh
    epnhgvrghlsehgohhmphgrrdguvghv
X-ME-Proxy: <xmx:qgSvaeaGvpU8woaMce1IG9I0qm9Q2hl1QHqzWsJVeYaiO5Ozh1leKA>
    <xmx:qgSvaSLjzyVJJWG_u86M1N0ZUUp86QxVcT9wy7mkdG4D1k3rWSUuEw>
    <xmx:qgSvaVFgHE7ppvf75VHZOzvFWCMnAFMOa1v7BjdgUKRVmCxVd8R8PQ>
    <xmx:qgSvaRs_UtfDLQMYy2PLyu1njm53GRxAv5CpBm9-4N6aBRWiHOlPGw>
    <xmx:qwSvaaV-VpbqQDvbsbj7LRzcDkimge-KrA-SYpkGWMGX77dUQVG3PGgh>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Mar 2026 13:34:33 -0400 (EDT)
Message-ID: <74356338-99d3-41dd-9ec0-12f62a1d7e6a@bsbernd.com>
Date: Mon, 9 Mar 2026 18:34:32 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] libfuse: run fuse servers as a contained service
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: bschubert@ddn.com, joannelkoong@gmail.com, linux-fsdevel@vger.kernel.org,
 miklos@szeredi.hu, neal@gompa.dev
References: <177258294351.1167732.4543535509077707738.stg-ugh@frogsfrogsfrogs>
 <0d3d5dfc-6237-4d6d-abeb-e7adddecf2d9@bsbernd.com>
 <20260304232353.GS13829@frogsfrogsfrogs>
 <20260309022710.GA6012@frogsfrogsfrogs>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <20260309022710.GA6012@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4273A23DAF4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bsbernd.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[bsbernd.com:s=fm2,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[ddn.com,gmail.com,vger.kernel.org,szeredi.hu,gompa.dev];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-79820-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[bsbernd.com:+,messagingengine.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bernd@bsbernd.com,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,messagingengine.com:dkim,bsbernd.com:dkim,bsbernd.com:mid,checkpatch.pl:url]
X-Rspamd-Action: no action

Hi Darrick,

really sorry for mys late reply. To my excuse I have the flu since
Thursday and until yesterday it got worse every day.


On 3/9/26 03:27, Darrick J. Wong wrote:
> On Wed, Mar 04, 2026 at 03:23:53PM -0800, Darrick J. Wong wrote:
>> On Wed, Mar 04, 2026 at 02:36:03PM +0100, Bernd Schubert wrote:
>>>
>>>
>>> On 3/4/26 01:11, Darrick J. Wong wrote:
>>>> Hi Bernd,
>>>>
>>>> Please pull this branch with changes for libfuse.
>>>>
>>>> As usual, I did a test-merge with the main upstream branch as of a few
>>>> minutes ago, and didn't see any conflicts.  Please let me know if you
>>>> encounter any problems.
>>>
>>> Hi Darrick,
>>>
>>> quite some problems actually ;)
>>>
>>> https://github.com/libfuse/libfuse/pull/1444
>>>
>>> Basically everything fails.  Build test with
>>>
>>> ../../../home/runner/work/libfuse/libfuse/lib/fuse_service.c:24:10:
>>> fatal error: 'systemd/sd-daemon.h' file not found
>>>    24 | #include <systemd/sd-daemon.h>
>>>
>>>
>>> Two issues here:
>>> a) meson is not testing for sd-daemon.h?
>>> a.1) If not available needs to disable that service? Because I don't
>>> think BSD has support for systemd.
>>>
>>> b) .github/workflow/*.yml files need to be adjusted to add in the new
>>> dependency.
>>>
>>>
>>> Please also have a look at checkpatch (which is a plain linux copy) and
>>> the spelling test failures.
>>
>> I have a few questions after running checkpatch.pl (the one in the
>> libfuse repo):
>>
>> 1. What are the error return conventions for libfuse functions?
>>
>>    The lowlevel library mostly seems to return 0 for succes or negative
>>    errno, but not all of them are like that, e.g. fuse_parse_cmdline*.
>>
>>    The rest of libfuse mostly seems to return 0 for success or -1 for
>>    error, though it's unclear if they set errno to anything?
>>
>>    This comes up because checkpatch complains about "return ENOTBLK",
>>    saying that it should be returning -ENOTBLK.  But I'm already sorta
>>    confused because libfuse and its examples use positive and negative
>>    errno inconsistently.
> 
> Hi Bernd,
> 
> Having spent a few days looking through lib/fuse*.c more carefully, I've
> come to the conclusion that most lowlevel library functions return 0 or
> negative errno on failure, and they often call fuse_log to complain
> about whatever failed.  Oddly, fuse_reply_err takes positive errno and
> ll servers are required to handle sign conversions correctly.  The high
> level fuse library does this inversion.

Yeah I know, confusing. But without breaking the API I don't think there
is much we can do about now.

> 
> If that sounds like a reasonable approach for fuse_service.c then I'll
> convert it to log and return negative errno like the lowlevel library
> does.  Right now it mostly sets errno and returns -1, and isn't
> completely consistent about fuse_log().  util/mount_service.c will get
> changed to fprintf to stderr and return negative errno on failure.


Sounds good to me. Obviously for expected errors you don't want to
create logs. Logging is another topic I need to address at some point,
so that one can set the actual level one wants to print.

> 
> For *_service.c functions that pass around fds from files opened on the
> other side of the service socket, a failure to open a file will result
> in the negative errno being sent in place of an fd.
> 
> How does that sound?
> 
> --D
> 
>> 2. There's no strscpy, but the check is left on, and there are plenty of
>>    users in libfuse.

Hrmm right, I had copied the script from linux to libfuse so that it
complains about wrong code style. So far it was mostly possible to
disable checks, in this specific case we probably need to modify
checkpatch. Pity, that will make it impossible to simply copy over newer
versions.

>>
>> 3. Comments at the top of files -- checkpatch complains that the
>>    non-first lines of a multiline C comment should start with " * "but
>>    not all of them do that.  Should I just do C comments the way
>>    checkpatch wants?  Or keep going with the existing code?

I guess here it is better to follow checkpatch and change to the style,
it expects.


Thanks,
Bernd



