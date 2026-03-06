Return-Path: <linux-fsdevel+bounces-79586-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6MhZBB21qml9VgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79586-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 12:06:05 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C53C21F6C7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 12:06:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 19E14304D1CD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Mar 2026 11:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 472953803F6;
	Fri,  6 Mar 2026 11:06:02 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DE06219FC
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Mar 2026 11:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772795162; cv=none; b=jJItUxIT1hptmZUN75OKUN/K/3/N8NDryFp7JN3biQphxlEkNhcaXKfSPG6d6eQovVmCNAsjPET9dYlukjAT3nc2cLb7ysStpqbdqcc+cKR5M7uLA7OWmv2ueGiJtLpZMmOZTYw+AKrt0fametzjYZy8KFcYJmCTDozb4788d/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772795162; c=relaxed/simple;
	bh=DJ4cQmNmsK4Gb3Yf5gMyF9e0iOCX8ITNVKyApzcTA4E=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=Bet0sQPYOGhlAQBAv1JZ8YNeF0+YA8VEOYNmKNvwYHlnkVAwC0FoFCKRsA3k3bkfNQcaRwAPSrbLzB0dcOAZkwcSWlX1mt8R2Hza1AGexmuVduej81fya+8ha3JjgTAYMMeiq1Btrh1MTOfatu4HNcG+xmsCtz/ODo3dlnJ01CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 69475497;
	Fri,  6 Mar 2026 03:05:52 -0800 (PST)
Received: from [10.1.27.43] (e127648.arm.com [10.1.27.43])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 578DD3F836;
	Fri,  6 Mar 2026 03:05:56 -0800 (PST)
Content-Type: multipart/mixed; boundary="------------MJdlQRec10OKNPoTnrSOb2Du"
Message-ID: <1ff1bce2-8bb4-463c-a631-16e14f4ea7e2@arm.com>
Date: Fri, 6 Mar 2026 11:05:54 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: make_task_dead() & kthread_exit()
To: Christian Brauner <brauner@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: Guillaume Tucker <gtucker@gtucker.io>, Tejun Heo <tj@kernel.org>,
 Mateusz Guzik <mjguzik@gmail.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
 Mark Brown <broonie@kernel.org>, kunit-dev@googlegroups.com,
 David Gow <davidgow@google.com>
References: <20260120-work-pidfs-rhashtable-v2-1-d593c4d0f576@kernel.org>
 <0150e237-41d2-40ae-a857-4f97ca664468@gtucker.io>
 <20260224-kurzgeschichten-urteil-976e57a38c5c@brauner>
 <20260224-mittlerweile-besessen-2738831ae7f6@brauner>
 <CAHk-=whEtuxXcgYLZPk1_mWd2VsLP2WPPCOr5fjPb2SpDsYdew@mail.gmail.com>
 <20260226-ungeziefer-erzfeind-13425179c7b2@brauner>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20260226-ungeziefer-erzfeind-13425179c7b2@brauner>
X-Rspamd-Queue-Id: 7C53C21F6C7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.26 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain,text/x-patch];
	DMARC_POLICY_SOFTFAIL(0.10)[arm.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	FREEMAIL_CC(0.00)[gtucker.io,kernel.org,gmail.com,zeniv.linux.org.uk,suse.cz,vger.kernel.org,googlegroups.com,google.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79586-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[christian.loehle@arm.com,linux-fsdevel@vger.kernel.org];
	MIME_TRACE(0.00)[0:+,1:+,2:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

This is a multi-part message in MIME format.
--------------MJdlQRec10OKNPoTnrSOb2Du
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/26/26 09:47, Christian Brauner wrote:
> On Tue, Feb 24, 2026 at 11:30:57AM -0800, Linus Torvalds wrote:
>> On Tue, 24 Feb 2026 at 08:25, Christian Brauner <brauner@kernel.org> wrote:
>>>
>>> If a kthread exits via a path that bypasses kthread_exit() (e.g.,
>>> make_task_dead() after an oops -- which calls do_exit() directly),
>>> the affinity_node remains in the global kthread_affinity_list. When
>>> free_kthread_struct() later frees the kthread struct, the linked list
>>> still references the freed memory. Any subsequent list_del() by another
>>> kthread in kthread_exit() writes to the freed memory:
>>
>> Ugh.
>>
>> So this is nasty, but I really detest the suggested fix. It just
>> smells wrong to have that affinity_node cleanup done in two different
>> places depending on how the exit is done.
>>
>> IOW, I think the proper fix would be to just make sure that
>> kthread_exit() isn't actually ever bypassed.
>>
>> Because looking at this, there are other issues with do_exit() killing
>> a kthread - it currently also means that kthread->result randomly
>> doesn't get set, for example, so kthread_stop() would appear to
>> basically return garbage.
>>
>> No, nobody likely cares about the kthread_stop() return value for that
>> case, but it's an example of the same kind of "two different exit
>> paths, inconsistent data structures" issue.
>>
>> How about something like the attached, in other words?
>>
>> NOTE NOTE NOTE! This is *entirely* untested. It might do unspeakable
>> things to your pets, so please check it. I'm sending this patch out as
>> a "I really would prefer this kind of approach" example, not as
>> anything more than that.
>>
>> Because I really think the core fundamental problem was that there
>> were two different exit paths that did different things, and we
>> shouldn't try to fix the symptoms of that problem, but instead really
>> fix the core issue.
>>
>> Hmm?
>>
>> Side note: while writing this suggested patch, I do note that this
>> comment is wrong:
>>
>>  * When "(p->flags & PF_KTHREAD)" is set the task is a kthread and will
>>  * always remain a kthread.  For kthreads p->worker_private always
>>  * points to a struct kthread.  For tasks that are not kthreads
>>  * p->worker_private is used to point to other things.
>>
>> because 'init_task' is marked as PF_KTHREAD, but does *not* have a
>> p->worker_private.
>>
>> Anyway, that doesn't affect this particular code, but it might be
>> worth thinking about.
> 
> Oh nice.
> I was kinda hoping Tejun would jump on this one and so just pointed to
> one potential way to fix it but didn't really spend time on it.
> 
> Anyway, let's just take what you proposed and slap a commit message on
> it. Fwiw, init_task does have ->worker_private it just gets set later
> during sched_init():
> 
>           /*
>            * The idle task doesn't need the kthread struct to function, but it
>            * is dressed up as a per-CPU kthread and thus needs to play the part
>            * if we want to avoid special-casing it in code that deals with per-CPU
>            * kthreads.
>            */
>           WARN_ON(!set_kthread_struct(current));
> 
> I think that @current here is misleading. When sched_init() runs it
> should be single-threaded still and current == &init_task. So that
> set_kthread_struct(current) call sets @init_task's worker_private iiuc.
> 
> Patch appended. I'll stuff it into vfs.fixes.

FWIW this leaves the stale BTF reference:

------8<------
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 401d6c4960ec..8db79e593156 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -25261,7 +25261,6 @@ BTF_ID(func, __x64_sys_exit_group)
 BTF_ID(func, do_exit)
 BTF_ID(func, do_group_exit)
 BTF_ID(func, kthread_complete_and_exit)
-BTF_ID(func, kthread_exit)
 BTF_ID(func, make_task_dead)
 BTF_SET_END(noreturn_deny)
 

--------------MJdlQRec10OKNPoTnrSOb2Du
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-bpf-drop-kthread_exit-from-noreturn_deny.patch"
Content-Disposition: attachment;
 filename="0001-bpf-drop-kthread_exit-from-noreturn_deny.patch"
Content-Transfer-Encoding: base64

RnJvbSA2YjI0MjY1NDFiMjk2ZTg4NjU0YTkwYTcxMzk1Y2JiZjcxZmFhODIzIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBDaHJpc3RpYW4gTG9laGxlIDxjaHJpc3RpYW4ubG9l
aGxlQGFybS5jb20+CkRhdGU6IEZyaSwgNiBNYXIgMjAyNiAxMDo0OToxOCArMDAwMApTdWJq
ZWN0OiBbUEFUQ0hdIGJwZjogZHJvcCBrdGhyZWFkX2V4aXQgZnJvbSBub3JldHVybl9kZW55
CgprdGhyZWFkX2V4aXQgYmVjYW1lIGEgbWFjcm8gdG8gZG9fZXhpdCBpbiBjb21taXQgMjhh
YWE5YzM5OTQ1Cigia3RocmVhZDogY29uc29saWRhdGUga3RocmVhZCBleGl0IHBhdGhzIHRv
IHByZXZlbnQgdXNlLWFmdGVyLWZyZWUiKSwKc28gdGhlcmUgaXMgbm8ga3RocmVhZF9leGl0
IGZ1bmN0aW9uIEJURiBJRCB0byByZXNvbHZlLiBSZW1vdmUgaXQgZnJvbQpub3JldHVybl9k
ZW55IHRvIGF2b2lkIHJlc29sdmVfYnRmaWRzIHVucmVzb2x2ZWQgc3ltYm9sIHdhcm5pbmdz
LgoKU2lnbmVkLW9mZi1ieTogQ2hyaXN0aWFuIExvZWhsZSA8Y2hyaXN0aWFuLmxvZWhsZUBh
cm0uY29tPgotLS0KIGtlcm5lbC9icGYvdmVyaWZpZXIuYyB8IDEgLQogMSBmaWxlIGNoYW5n
ZWQsIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9rZXJuZWwvYnBmL3ZlcmlmaWVyLmMg
Yi9rZXJuZWwvYnBmL3ZlcmlmaWVyLmMKaW5kZXggNDAxZDZjNDk2MGVjLi44ZGI3OWU1OTMx
NTYgMTAwNjQ0Ci0tLSBhL2tlcm5lbC9icGYvdmVyaWZpZXIuYworKysgYi9rZXJuZWwvYnBm
L3ZlcmlmaWVyLmMKQEAgLTI1MjYxLDcgKzI1MjYxLDYgQEAgQlRGX0lEKGZ1bmMsIF9feDY0
X3N5c19leGl0X2dyb3VwKQogQlRGX0lEKGZ1bmMsIGRvX2V4aXQpCiBCVEZfSUQoZnVuYywg
ZG9fZ3JvdXBfZXhpdCkKIEJURl9JRChmdW5jLCBrdGhyZWFkX2NvbXBsZXRlX2FuZF9leGl0
KQotQlRGX0lEKGZ1bmMsIGt0aHJlYWRfZXhpdCkKIEJURl9JRChmdW5jLCBtYWtlX3Rhc2tf
ZGVhZCkKIEJURl9TRVRfRU5EKG5vcmV0dXJuX2RlbnkpCiAKLS0gCjIuMzQuMQoK

--------------MJdlQRec10OKNPoTnrSOb2Du--

