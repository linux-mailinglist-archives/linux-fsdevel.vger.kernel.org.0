Return-Path: <linux-fsdevel+bounces-60005-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB644B40B63
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 19:00:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03CF5562D2E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 17:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60E4F342C90;
	Tue,  2 Sep 2025 16:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gotplt.org header.i=@gotplt.org header.b="YUuXjWfh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from poodle.tulip.relay.mailchannels.net (poodle.tulip.relay.mailchannels.net [23.83.218.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A5A342CB6
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Sep 2025 16:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.249
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756832382; cv=pass; b=WG6RklcjN9RRH/WsfQBJB1TnJtV1SkhOi9BQz3WM5FMpb8AgDGPUtD7bpBC5qji917pVaCJdRhQqKfWl/GS3byDO0iPwLXtwrpPNi97n2uMcgrdKnrs3EWqR49W8BIr0zeXJ24nxOpW6fpo+ByFvvzWyFsg87ICMVNPFMv3PEKM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756832382; c=relaxed/simple;
	bh=HAs5rh9bXvpCUunCIzXQnzAPu/x0AKsuyxnxYGpcBmU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uHOerf1aNczVFU9qDKeN/A6purOEjn5WRoQetL+xsU8A1XbVheGPkRlfXg3Z3GvpDJ+R2C0wb3w2U+NtT/LJx/HMeSmL3e+nVXbaQ+e5yHjODQYbVMyPuQP96CpWdKjlm9/9wfMgmL+CyVOCEWx5JrN09pPdJNaPw3cbbIpFnG4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gotplt.org; spf=pass smtp.mailfrom=gotplt.org; dkim=pass (2048-bit key) header.d=gotplt.org header.i=@gotplt.org header.b=YUuXjWfh; arc=pass smtp.client-ip=23.83.218.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gotplt.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gotplt.org
X-Sender-Id: dreamhost|x-authsender|siddhesh@gotplt.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id D89878A2C0D;
	Tue,  2 Sep 2025 15:03:26 +0000 (UTC)
Received: from pdx1-sub0-mail-a204.dreamhost.com (trex-blue-4.trex.outbound.svc.cluster.local [100.105.40.229])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 026EA8A0FA5;
	Tue,  2 Sep 2025 15:03:25 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1756825406; a=rsa-sha256;
	cv=none;
	b=wOnQaCE4H4mdzW5Rq9ggAIhJ52JhNrRos99x2g5pIZw1TlY72tMEFHvSg2UBSHUpKgJVNN
	2KB7z3wDvNx3uPSsKSJsufifD7HdBrxd+lSizPYsB2ZRFScrdAQ7o56+Q27fsNQ0Vvyqrc
	Fhkv3HFVu8IfmofIOR0lPxMqD9CuwuymtMfn/bIwk0ODWpUBfxU2QQFZfeaGES9U8VBgt1
	+TOsH3Kjz1aW3BwEjLFJfI6yyQ/i4uz92gpkplbmVXvdyPCI9LxWQ2pRYKoSQqjMR7ajtl
	xXhE8nd35V8SJtCISG38wxJVDZuntAH30M18WAO5UephwJHFOem28+HFcPs4mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1756825406;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=dxYn4hmz5MhYwK5vgec+z3sGz7Cyr8gPlLu1W5W0keE=;
	b=QgI8YfemtkeVRg7wM/gv+lNOC/KmycMLJya4OE1NXjPJD3554wxJVW0n0RPWd74WoVH6uj
	XbwIQH5706mVmhB1iLLI4IZq4OLPGGA+6NF65CJbVmS75zgh5SdQJGyT+tVQaVWZU0jAA1
	MjZNQVS1CmY968CkenQeZ/t7h3kQiFss4Cbp3UfaPmWUJQbwRlbYHFC1e2Wl32S836PmAv
	JyH2W/2RxscgoU0/z5/U57P7yIloiM0zeESOWQKEY7g9o3ZrYLokIOSQNmvwaM/czkU0tq
	6AmgLTPe8zIuRzXiPEhFOUXQWAgWRE5QxrLXypAVmytUTpFEhJYUOKmGt9OXwA==
ARC-Authentication-Results: i=1;
	rspamd-9594d4cf9-r6sxx;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=siddhesh@gotplt.org
X-Sender-Id: dreamhost|x-authsender|siddhesh@gotplt.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|siddhesh@gotplt.org
X-MailChannels-Auth-Id: dreamhost
X-Decisive-Lyrical: 5565e3b01a98d61f_1756825406620_838952920
X-MC-Loop-Signature: 1756825406620:1056724731
X-MC-Ingress-Time: 1756825406620
Received: from pdx1-sub0-mail-a204.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.105.40.229 (trex/7.1.3);
	Tue, 02 Sep 2025 15:03:26 +0000
Received: from [192.168.0.135] (unknown [38.23.181.90])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: siddhesh@gotplt.org)
	by pdx1-sub0-mail-a204.dreamhost.com (Postfix) with ESMTPSA id 4cGTWx0LhMzBC;
	Tue,  2 Sep 2025 08:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gotplt.org;
	s=dreamhost; t=1756825405;
	bh=dxYn4hmz5MhYwK5vgec+z3sGz7Cyr8gPlLu1W5W0keE=;
	h=Date:Subject:To:Cc:From:Content-Type:Content-Transfer-Encoding;
	b=YUuXjWfhwntF0NmvpkAlv5sj54DXdcMHSW3XZb0du5n/lWUmrjvyXLXMnEZBrTeBk
	 uOUX72ao8OlZ/U6AVPqOyyZwQfKtn/4NvR9x3uV2TcjGfSY1GwEA5pZL5rHxbY3VP2
	 zLFxHyFSMYc3Oap4n3zPNvr4e+vsGtF+CZuqGQLiLQqm0dVnnBCdoEnYUnahyIGImw
	 05EXJhJskhO09X4Ch/U+lqqwhu9C/TH54LrpGCuDtx4Rlark6t08WSFbBqRSyOH67I
	 ORUb2MfFEmhKIGS/bveAOhNg79leIP4NnjKpIGFok1tnQDjTh3+Evj++Xy4ExL5sFF
	 a1k8MkX3Yt5RQ==
Message-ID: <ed70bad5-c1a8-409f-981e-5ca7678a3f08@gotplt.org>
Date: Tue, 2 Sep 2025 11:03:23 -0400
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] does # really need to be escaped in devnames?
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz, Ian Kent <raven@themaw.net>,
 David Howells <dhowells@redhat.com>, Christian Brauner <brauner@kernel.org>
References: <20250828230806.3582485-1-viro@zeniv.linux.org.uk>
 <20250828230806.3582485-61-viro@zeniv.linux.org.uk>
 <CAHk-=wgZEkSNKFe_=W=OcoMTQiwq8j017mh+TUR4AV9GiMPQLA@mail.gmail.com>
 <20250829001109.GB39973@ZenIV>
 <CAHk-=wg+wHJ6G0hF75tqM4e951rm7v3-B5E4G=ctK0auib-Auw@mail.gmail.com>
 <20250829060306.GC39973@ZenIV> <20250829060522.GB659926@ZenIV>
 <20250829-achthundert-kollabieren-ee721905a753@brauner>
 <20250829163717.GD39973@ZenIV> <20250830043624.GE39973@ZenIV>
 <20250830073325.GF39973@ZenIV>
 <CAHk-=wiSNJ4yBYoLoMgF1M2VRrGfjqJZzem=RAjKhK8W=KohzQ@mail.gmail.com>
Content-Language: en-US
From: Siddhesh Poyarekar <siddhesh@gotplt.org>
In-Reply-To: <CAHk-=wiSNJ4yBYoLoMgF1M2VRrGfjqJZzem=RAjKhK8W=KohzQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-08-30 15:40, Linus Torvalds wrote:
> On Sat, 30 Aug 2025 at 00:33, Al Viro <viro@zeniv.linux.org.uk> wrote:
>>
>> So...  Siddhesh, could you clarify the claim about breaking getmntent(3)?
>> Does it or does it not happen on every system that has readonly AFS
>> volumes mounted?
> 
> Hmm. Looking at various source trees using Debian code search, at
> least dietlibc doesn't treat '#' specially at all.
> 
> And glibc seems to treat only a line that *starts* with a '#'
> (possibly preceded by space/tab combinations) as an empty line.
> 
> klibc checks for '#' at the beginning of the file (without any
> potential space skipping before)
> 
> Busybox seems to do the same "skip whitespace, then skip lines
> starting with '#'" that glibc does.
> 
> So I think the '#'-escaping logic is wrong.  We should only escape '#'
> marks at the beginning of a line (since we already escape spaces and
> tabs, the "preceded by whitespace" doesn't matter).


This was actually the original issue I had tried to address, escaping 
'#' in the beginning of the devname because it ends up in the beginning 
of the line, thus masking out the entire line in mounts.  I don't 
remember at what point I concluded that escaping '#' always was the 
answer (maybe to protect against any future instances where userspace 
ends up ignoring the rest of the line following the '#'), but it appears 
to be wrong.

Sid

