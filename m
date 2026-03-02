Return-Path: <linux-fsdevel+bounces-78904-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CBhWFnaYpWnXEgYAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78904-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 15:02:30 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AB6A1DA4A7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 15:02:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 14DE6303D4E1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2026 13:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 552B93FB052;
	Mon,  2 Mar 2026 13:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jd2LsCVC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43343E5563;
	Mon,  2 Mar 2026 13:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772459850; cv=none; b=gxMHg/1MDny2NCI/5VgYwPpXgH44FZcJ7fcPHdlPpt3W2jRZ+jcxSk9wdX5F+v8j4l1wW+vAzvfJffhnvUG7jAy7yD2VI0SeBjs4Y+pHCBobZKqi4FAq8U6YO6ycoUR33yqLpDp9BEJ4lqkIu6owiR888xhW014MevKbUAQ0goI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772459850; c=relaxed/simple;
	bh=UV2mNPBNzqomza8bGMJZVxSDC6YpRR0TOAlLfetIp9M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eiyieAFqxgRjvk8xSbOZnYfaEccU4LIqHPuI413eTFS9HRhBzc8VuBzRQqlRbJEj3JbBzbcwqqhCCYlFpX2Awlt6wzvvB5/lonsvhKs+Z323s6JxX/sqxjxTYI0srG3kD6z79FjqCTMM9XcZtaUhXSCqpL03Q1XfFDhjBKF0l4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jd2LsCVC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80786C19423;
	Mon,  2 Mar 2026 13:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772459850;
	bh=UV2mNPBNzqomza8bGMJZVxSDC6YpRR0TOAlLfetIp9M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Jd2LsCVCQ7xuIl5ZNQ/Usg0S+rgGGYa+BwwiymmVREWmOaCSGbGfPcTHS60e3cECR
	 eieLMPUsvOqbrIzsQuCDbaGARJ5YxKGeohDjdJzjpDI+uVaZ3uGcbJtSDAiZ/o1Hjo
	 zzZkvU9Jjm1Z4sKQMokRZOrB7wRIhNt9GzMTUhMi1O+HoDBUACxdvdJ8RIspigE9zh
	 iu/+2FmrskCm3sYPA8MiWu0qCrX6J2MdJeMQ3Z7uxoWvGmNaGGaTGANfhRwNNQmDbw
	 h9LidjBVhgij0rY8yI90uTAochDeVyjY4FexLkmaD5atdgFlx54jV7iuT/WT2+oW4s
	 9VQ00DlFkw2xQ==
Message-ID: <d7abef36-ce90-4b36-af16-e8bd61b963ed@kernel.org>
Date: Mon, 2 Mar 2026 08:57:28 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] fs: add umount notifier chain for filesystem
 unmount notification
To: NeilBrown <neil@brown.name>
Cc: Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.com>,
 Jeff Layton <jlayton@kernel.org>, Olga Kornievskaia <okorniev@redhat.com>,
 Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
 linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Chuck Lever <chuck.lever@oracle.com>
References: <20260224163908.44060-1-cel@kernel.org>
 <20260224163908.44060-2-cel@kernel.org>
 <20260226-alimente-kunst-fb9eae636deb@brauner>
 <CAOQ4uxhEpf1p3agEF7_HBrhUeKz1Fb_yKAQ0Pjo0zztTJfMoXA@mail.gmail.com>
 <1165a90b-acbf-4c0d-a7e3-3972eba0d35a@kernel.org>
 <jxyalrg3a2yjtjfmdylncg7fz63jstbq6pwhhqlaaxju5sk72f@55lb7mfucc5i>
 <3cff098e-74a8-4111-babb-9c13c7ba2344@kernel.org>
 <CAOQ4uxiX5anNeZge9=uzw8Dkbad3bMBk5Ana5S94t9VfKNFO5g@mail.gmail.com>
 <d7f2562a-7d32-41d5-a02e-904aa4203ed3@app.fastmail.com>
 <CAOQ4uxiO+NCjhBme=YWCfnVyhJ=Zcg4zmnfoRspJab3n5waSCA@mail.gmail.com>
 <07a2af61-6737-4e47-ad69-652af18eb47b@app.fastmail.com>
 <177242454307.7472.11164903103911826962@noble.neil.brown.name>
From: Chuck Lever <cel@kernel.org>
Content-Language: en-US
Organization: kernel.org
In-Reply-To: <177242454307.7472.11164903103911826962@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,suse.cz,kernel.org,suse.com,redhat.com,oracle.com,talpey.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-78904-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5AB6A1DA4A7
X-Rspamd-Action: no action

On 3/1/26 11:09 PM, NeilBrown wrote:
> On Mon, 02 Mar 2026, Chuck Lever wrote:
>>
>> On Sun, Mar 1, 2026, at 1:09 PM, Amir Goldstein wrote:
>>> On Sun, Mar 1, 2026 at 6:21 PM Chuck Lever <cel@kernel.org> wrote:
>>>> Perhaps that description nails down too much implementation detail,
>>>> and it might be stale. A broader description is this user story:
>>>>
>>>> "As a system administrator, I'd like to be able to unexport an NFSD
>>>
>>> Doesn't "unexporting" involve communicating to nfsd?
>>> Meaning calling to svc_export_put() to path_put() the
>>> share root path?
>>>
>>>> share that is being accessed by NFSv4 clients, and then unmount it,
>>>> reliably (for example, via automation). Currently the umount step
>>>> hangs if there are still outstanding delegations granted to the NFSv4
>>>> clients."
>>>
>>> Can't svc_export_put() be the trigger for nfsd to release all resources
>>> associated with this share?
>>
>> Currently unexport does not revoke NFSv4 state. So, that would
>> be a user-visible behavior change. I suggested that approach a
>> few months ago to linux-nfs@ and there was push-back.
>>
> 
> Could we add a "-F" or similar flag to "exportfs -u" which implements the
> desired semantic?  i.e.  asking nfsd to release all locks and close all
> state on the filesystem.

That meets my needs, but should be passed by the linux-nfs@ review
committee.

-F could probably just use the existing "unlock filesystem" API
after it does the unexport.


-- 
Chuck Lever

