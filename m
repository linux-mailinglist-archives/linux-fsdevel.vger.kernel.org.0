Return-Path: <linux-fsdevel+bounces-78812-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id olp8GGmAommC3gQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78812-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Feb 2026 06:43:05 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B41391C0724
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Feb 2026 06:43:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F3242305F32A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Feb 2026 05:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76BCE3009ED;
	Sat, 28 Feb 2026 05:42:59 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F2119C553
	for <linux-fsdevel@vger.kernel.org>; Sat, 28 Feb 2026 05:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772257379; cv=none; b=T2KBFGiY1/aj5NKPXbqse2L59kIerJhjC3WLLKN9Zexmts27a2f9PzeMu5RIiBsEefN+lXcHcLsCGjxiOmL+hC/ZZfS2ZVllM7WBQN5LJySqYDeFfDM7Ihov7Xjw6c4atZbcYaeZk4g5K8DWmgsH5De2zJqsmK2Wurc0vJV0IKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772257379; c=relaxed/simple;
	bh=qqaq5RfqkWYg90B6CMR7CLCXLyYm47RM0f2C5u25P08=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PCVDnR8RU+/K7yYos6aVOVTt3y9+2yyeG0TuQ0DzjYPg13NEgnmpRSbGquNaX0baaYL5v5mR/p3OqLvw8XOWGHEUGAQBtmBrEhzbs67fsGsODMVIgJFZ86drVCPFu8z8UTS4cxFKr1DkW2p1wJzZIN7mNMkSHVfME3ppQ3WLBlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 61S5gh1N098204;
	Sat, 28 Feb 2026 14:42:43 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.2] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 61S5ghvr098200
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 28 Feb 2026 14:42:43 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <fdb6cd39-14fc-4d35-929d-1fccac653d9e@I-love.SAKURA.ne.jp>
Date: Sat, 28 Feb 2026 14:42:42 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hfs: don't fail operations when files/directories counter
 overflows
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
        "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "frank.li@vivo.com" <frank.li@vivo.com>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        "jkoolstra@xs4all.nl" <jkoolstra@xs4all.nl>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <6e5fd94e-9073-4307-beb7-ee87f3f0665c@I-love.SAKURA.ne.jp>
 <68811931931db09c0ea84f1be8e1bdc0fd453776.camel@ibm.com>
 <4a026754-1c58-40a6-96f9-ecaafa67a2ae@I-love.SAKURA.ne.jp>
 <62e01a3505bca9d1e8779f85e0223ec02c24a6de.camel@ibm.com>
 <ef597d09-0fe0-44bc-93ff-b0223eb97ce8@I-love.SAKURA.ne.jp>
 <37b976e33847b4e3370d423825aaa23bdc081606.camel@ibm.com>
 <f8700c59-3763-4ea9-b5c2-f4510c2106ed@I-love.SAKURA.ne.jp>
 <40a8f3a228cf8f3580f633b9289cd371b553c3e4.camel@ibm.com>
 <524bed1e-fceb-4061-b274-219e64a6b619@I-love.SAKURA.ne.jp>
 <645baa4f25bb435217be8f9f6aa1448de5d5744e.camel@ibm.com>
 <a6e9fe8b-5a20-4c01-a1f8-144572fc3f4a@I-love.SAKURA.ne.jp>
 <fd5c05a5-2752-4dab-ba98-2750577fb9a4@I-love.SAKURA.ne.jp>
 <be0afbc9cf2816b19952a8d38ffb4a82519454e2.camel@ibm.com>
 <15eebd5d-cf5b-42ca-a772-6918520ff140@I-love.SAKURA.ne.jp>
 <0cef4eb7-987e-4fa6-a5b1-a64c5db1f42b@I-love.SAKURA.ne.jp>
 <e29dc9d188ac8925408a825b0073f6ed2990db89.camel@ibm.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <e29dc9d188ac8925408a825b0073f6ed2990db89.camel@ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav401.rs.sakura.ne.jp
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-78812-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DMARC_NA(0.00)[i-love.sakura.ne.jp];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[ibm.com,physik.fu-berlin.de,vivo.com,dubeyko.com,xs4all.nl];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	REDIRECTOR_URL(0.00)[proofpoint.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[penguin-kernel@I-love.SAKURA.ne.jp,linux-fsdevel@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.975];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,proofpoint.com:url,I-love.SAKURA.ne.jp:mid]
X-Rspamd-Queue-Id: B41391C0724
X-Rspamd-Action: no action

On 2026/02/27 2:45, Viacheslav Dubeyko wrote:
> On Thu, 2026-02-26 at 23:01 +0900, Tetsuo Handa wrote:
>> On 2026/02/21 10:50, Tetsuo Handa wrote:
>>>> We cannot simply silently stop accounting folders count. We should complain and
>>>> must return error.
>>
>> Here is an opinion from Google AI mode.
>>
>> https://urldefense.proofpoint.com/v2/url?u=https-3A__share.google_aimode_VTH5mHPFmaH62fnwx&d=DwICaQ&c=BSDicqBQBDjDI9RkVyTcHQ&r=q5bIm4AXMzc8NJu1_RGmnQ2fMWKq4Y4RAkElvUgSs00&m=1F3R0MFsp57UPSWAWnRdZgKGEDAnjK_4zTR5SfmpBVc8B690-uUHhuiDhzewhdMq&s=PVFKvGfwllmy4v6FiMFcL_kyEQ7893sQg8iZcH0znHg&e=  (Expires in 7 days. Please save if needed.)
> 
> I am not going to check what absurd can generate GPUs and ML models. :) I hope
> you are not serious about this. Stupid hardware cannot have an opinion because
> it hasn't soul, it cannot think, it hasn't conscientiousness and it has no idea
> about ethics.

You are saying "MUST return error" and I am saying "NEED NOT TO return error".
A machine learning model compared several filesystems and agreed that the total
count variable is merely a "cache" used for speed and therefore my approach is
acceptable.

Since I don't like that you simply return error without recalculating the total
count variable using the source of truth, I suggest you to recalculate without
returning error. Current code which just returns an error can surprise users.


