Return-Path: <linux-fsdevel+bounces-78440-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YO1PEnHHn2k8dwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78440-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 05:09:21 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F6E81A0C7A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 05:09:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EFCBD301BFA8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 04:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2233137648D;
	Thu, 26 Feb 2026 04:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=davidgow.net header.i=@davidgow.net header.b="htj/I/0h";
	dkim=pass (4096-bit key) header.d=davidgow.net header.i=@davidgow.net header.b="fp6NsJc1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sphereful.davidgow.net (sphereful.davidgow.net [203.29.242.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58FF219AD8B
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Feb 2026 04:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.242.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772078953; cv=none; b=DPZ/kOU6W/0iCrx7X13dxrYuTeQnAoCOHIPx1oo3WyCRXKzxDbidfY0vKZpQDeS6OMQh9da0LX95XexB1t8VS5kD5uVXRmgUSjd/fYJ3UmjtEYGhgCD5yzljqmSxI9izg/6pPcJsB8NSHJBBCwkCUoDQUU9SnTmhAkQvA42pfss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772078953; c=relaxed/simple;
	bh=BloHjeBNxn7ThSX6xpOF7umSE9aHosr4+HpQwg7vNjg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SOJqzneSCfalfiw6GF2QJRR9xA38IKVJzAv+P2lqZPoayu3LaqUZLvjJVNtZgr8bK9HpRBXKPpAA9J9sF9A4KHIIULN/cNd0xhN/uv0sX9muexCDZSkPYpHPkBn1djUEHXybuslc/rI2ZzpTKY6TUb+2/gMyOPoonPBTosEbvYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=davidgow.net; spf=pass smtp.mailfrom=davidgow.net; dkim=pass (4096-bit key) header.d=davidgow.net header.i=@davidgow.net header.b=htj/I/0h; dkim=pass (4096-bit key) header.d=davidgow.net header.i=@davidgow.net header.b=fp6NsJc1; arc=none smtp.client-ip=203.29.242.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=davidgow.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=davidgow.net
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=davidgow.net;
	s=201606; t=1772078950;
	bh=BloHjeBNxn7ThSX6xpOF7umSE9aHosr4+HpQwg7vNjg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=htj/I/0hy26+PyGFf3v4r5Qwo5SyQODvBnOPFD/O6owIBja/U5eC5KmHt/17FsusG
	 QX0kThYNJGH9WyDzdG0qijnpgjBD3V6X7EA5usO/a8TFSHOzErXxp0BCuuGVeCXQYR
	 QA933eF1qZNo7XznHylazyzYNuh58+aFMhqDXOQS4qpJQQeRf7I4QzlbMVB+49H4PC
	 4YN2cKDzoIZRVVJDtP9Khk8nL4OCecNRMucOf4wRo8fr+VVLnLOhatmmori+DcPe4J
	 8BxKZatL1JaIcX8ILYgZu0wvtwsMMIcedNHOMClN5UFT19f+gGbA9cHq6YtPNCnt3x
	 UqdcFog9HukDHQpZJ/8a5zmaFSCKwiGv2sbuG3U9waDgvJvFtqpG3mDamMZiuLc+tj
	 FkI10pbJG8WHUiXWDuZ18ItAclCcGemtye/zMUOGOKmfW/jajGN8fapz4na4owIf+a
	 cSGebX3IEgJWxVCDwv0FLwTEGO7r1nuIONzIAfm7sfXFwNVvfv6t19aT2UVxPKNEAv
	 r+Cho2VJYimiAQAvxX5zO9/v6/SqY4tr6abvFbVSmUE72cD2GXyiFnwwXRJ83y6cNX
	 GVfe+F6YI7B+LDIz5CJX5Uo2fM9KKoJ+qoGDhqSx0smu0luBoYlTlm7O+mw5senLt5
	 1LUafeqh2Le6oZIoSz3Nqr8A=
Received: by sphereful.davidgow.net (Postfix, from userid 119)
	id 83D5C1E79A4; Thu, 26 Feb 2026 12:09:10 +0800 (AWST)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=davidgow.net;
	s=201606; t=1772078948;
	bh=BloHjeBNxn7ThSX6xpOF7umSE9aHosr4+HpQwg7vNjg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fp6NsJc14JIzyqX+fvUBX5Z2jD1rRf1295Vd1fIh0qkcprJHduy0eNStCFFm69CDd
	 4IHGKmVOd6ZOr+f4/k3KzyN+krrBh8kdDoW/Nm11fUYVmu8Ej1CRUYg/SS6Pw3o+M0
	 p46y0pMsNjr4negvO23O6NmK3JQI+je36v8VETBMvqBxYhf8m3mehCFM7r3TSe7OW/
	 A/9cAYuq9jAnT0qoo4N4jGgQhqGMxxM4G2Z36zV2MSBYL1m720mwvS8/5Bi6CYPiZO
	 j5KgXHNKu+WoGiC+NQWLVxAerMbQz0R4+YEc39D76pF0h1IAbvBVolU0usAd1zFtHv
	 IaAYxd8AB5RuMIk+4ALVoQuKGirXTMsPF9AkIH+PYS6a/Wl0NC7YQwo/LCK9S2av0f
	 QP3QrfbiQ2lMdsBjDFc1Qz0PbBRolPVnA0e3ttrlXdXPXpfW/LCENie/UwVJNIKFA3
	 VuYxwXGMv0Di6ypplASGn/aNLU3IHpuXXh2GRtgn8cwjg/TCPkwkZj2oIV5ZHh8p2V
	 TtuisNaPxBb6LqoBst/tM4tCx+iSYVub30J9FbqifiJQSiBc7ZX20lwKrGec4tNaiA
	 WW6/ICbC5xVgCUPDgg2+V8aJatOeuTf3PYG5G9/ezGn2yDoqNHBZpmlmdm0YddRlZE
	 dwJ/4LdwW+dyhSRynuIPpSFI=
Received: from [IPV6:2001:8003:8824:9e00:6d16:7ef9:c827:387c] (unknown [IPv6:2001:8003:8824:9e00:6d16:7ef9:c827:387c])
	by sphereful.davidgow.net (Postfix) with ESMTPSA id 9F9341E799E;
	Thu, 26 Feb 2026 12:09:08 +0800 (AWST)
Message-ID: <17bff468-30fb-4d13-adf9-5c326657ae02@davidgow.net>
Date: Thu, 26 Feb 2026 12:09:06 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: make_task_dead() & kthread_exit()
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Christian Brauner <brauner@kernel.org>
Cc: Guillaume Tucker <gtucker@gtucker.io>, Tejun Heo <tj@kernel.org>,
 Mateusz Guzik <mjguzik@gmail.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
 Mark Brown <broonie@kernel.org>, kunit-dev@googlegroups.com
References: <20260120-work-pidfs-rhashtable-v2-1-d593c4d0f576@kernel.org>
 <0150e237-41d2-40ae-a857-4f97ca664468@gtucker.io>
 <20260224-kurzgeschichten-urteil-976e57a38c5c@brauner>
 <20260224-mittlerweile-besessen-2738831ae7f6@brauner>
 <CAHk-=whEtuxXcgYLZPk1_mWd2VsLP2WPPCOr5fjPb2SpDsYdew@mail.gmail.com>
Content-Language: fr
From: David Gow <david@davidgow.net>
In-Reply-To: <CAHk-=whEtuxXcgYLZPk1_mWd2VsLP2WPPCOr5fjPb2SpDsYdew@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[davidgow.net,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[davidgow.net:s=201606];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[davidgow.net:+];
	FREEMAIL_CC(0.00)[gtucker.io,kernel.org,gmail.com,zeniv.linux.org.uk,suse.cz,vger.kernel.org,googlegroups.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78440-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[david@davidgow.net,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6F6E81A0C7A
X-Rspamd-Action: no action

Le 25/02/2026 à 3:30 AM, Linus Torvalds a écrit :
> On Tue, 24 Feb 2026 at 08:25, Christian Brauner <brauner@kernel.org> wrote:
>>
>> If a kthread exits via a path that bypasses kthread_exit() (e.g.,
>> make_task_dead() after an oops -- which calls do_exit() directly),
>> the affinity_node remains in the global kthread_affinity_list. When
>> free_kthread_struct() later frees the kthread struct, the linked list
>> still references the freed memory. Any subsequent list_del() by another
>> kthread in kthread_exit() writes to the freed memory:
> 
> Ugh.
> 
> So this is nasty, but I really detest the suggested fix. It just
> smells wrong to have that affinity_node cleanup done in two different
> places depending on how the exit is done.
> 
> IOW, I think the proper fix would be to just make sure that
> kthread_exit() isn't actually ever bypassed.
> 
> Because looking at this, there are other issues with do_exit() killing
> a kthread - it currently also means that kthread->result randomly
> doesn't get set, for example, so kthread_stop() would appear to
> basically return garbage.
> 
> No, nobody likely cares about the kthread_stop() return value for that
> case, but it's an example of the same kind of "two different exit
> paths, inconsistent data structures" issue.
> 
> How about something like the attached, in other words?
> 
> NOTE NOTE NOTE! This is *entirely* untested. It might do unspeakable
> things to your pets, so please check it. I'm sending this patch out as
> a "I really would prefer this kind of approach" example, not as
> anything more than that.
> 
> Because I really think the core fundamental problem was that there
> were two different exit paths that did different things, and we
> shouldn't try to fix the symptoms of that problem, but instead really
> fix the core issue.
> 
> Hmm?

FWIW, the attached patch fixes the issue for me, and my machines have 
been been stable running it this morning (+reverting the firewire merge 
due to [1]), so the idea seems pretty sound.

Tested-by: David Gow <david@davidgow.net>

Cheers,
-- David

[1]: 
https://lore.kernel.org/all/CAHk-=wgUmxkjwsWzX1rTo=DTnaouwY-VT8BjrTqfH7RmTwO72w@mail.gmail.com/

