Return-Path: <linux-fsdevel+bounces-77153-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6OBBMbxfj2nNQgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77153-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 18:30:36 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA7B1138A5B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 18:30:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E65B1303431B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 17:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9795366042;
	Fri, 13 Feb 2026 17:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="D2zogm7M"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4DE3EBF3E;
	Fri, 13 Feb 2026 17:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771003832; cv=none; b=QQdPfV0k8UEBkF9ygvHJJe0Zc6sS56OHqF+mvW4L2woRBxon9aN4m4HSmrwfdy+9SD6bfpJwJmvB7AnxbfD2Bj4L+J6oM8r9CoHY6oswEWkY9vC6hDaY+9JZUMfSbHpFJUe119CRYw7x5hxdCAvrQ2cM0obj7VDDFP2lwFfJUvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771003832; c=relaxed/simple;
	bh=Qw+nmt5g75eVQsyFf1dwpb9Qb8LZe3oktqm/rz+BDGk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I8R83/rGMbJyZAJ2iwMkOprP5TpNWrMEr3s82ahFvPnRbjd1ut8XQdlFQtWDx4HO8N7MFMPLHI2MB9JmFdppp63EjUooIJpUnyJERy5263ocbdxLP+vTmVxOe+VhNjPMUQOnQ0ImYQAgP1YKzrsQB43KIXNBsmjTLyKOO5K4I6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=D2zogm7M; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4fCK1r4kwWzlgyGl;
	Fri, 13 Feb 2026 17:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1771003820; x=1773595821; bh=Qw+nmt5g75eVQsyFf1dwpb9Q
	b8LZe3oktqm/rz+BDGk=; b=D2zogm7MPVwmOtG/PhzIQMBy8uvt5tPBfMvt+iEk
	LIu0VxyinTQdodPz6m6pf35HxWc+KWL+7PjRktkwTnO8+3tAKi5vLKifa3Xkl4U0
	ntdqbGsOqxeCUytdTmtn1vAmQQEJHWCD7di2yqm5OUjR7FMMlBEyB0eRoO4Y0YtT
	DH2wqgbeuMd2fBweuV6JsoKLtYtgjZi7lKp0QlGKPU4yxMyw643IWGWwcrm8iJly
	0kSSVviJZ+1jVmUwRD6Ib2impNwGZh8WHD5IxgWlDrfPu/EHO38JYnOpNDU+JPZS
	eXZeSIrClLFN4mdkCkhA98mjgIo2j4tj4yJpy0HWnfB2+w==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id Ys93-gQyVswD; Fri, 13 Feb 2026 17:30:20 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4fCK1d43XCzlfgPv;
	Fri, 13 Feb 2026 17:30:13 +0000 (UTC)
Message-ID: <678a951d-7da1-4089-a3d8-f9d9cb48aa35@acm.org>
Date: Fri, 13 Feb 2026 09:30:12 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF ATTEND][LSF/MM/BPF TOPIC] : blktests: status,
 expansion plan for the storage stack test framework
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 Daniel Wagner <dwagner@suse.de>, Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Hannes Reinecke <hare@suse.de>, hch <hch@lst.de>,
 Jens Axboe <axboe@kernel.dk>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "tytso@mit.edu" <tytso@mit.edu>, Christian Brauner <brauner@kernel.org>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 =?UTF-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>,
 "willy@infradead.org" <willy@infradead.org>, Jan Kara <jack@suse.cz>,
 "amir73il@gmail.com" <amir73il@gmail.com>, "vbabka@suse.cz"
 <vbabka@suse.cz>, Damien Le Moal <dlemoal@kernel.org>
References: <31a2a4c2-8c33-429a-a2b1-e1f3a0e90d72@nvidia.com>
 <459953fa-5330-4eb1-a1b4-7683b04e3d45@flourine.local>
 <24634187-a4fd-4fbd-9053-03484eadf16f@wdc.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <24634187-a4fd-4fbd-9053-03484eadf16f@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[acm.org,reject];
	R_DKIM_ALLOW(-0.20)[acm.org:s=mr01];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77153-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,lists.linux-foundation.org,wdc.com,suse.de,lst.de,kernel.dk,grimberg.me,mit.edu,kernel.org,oracle.com,javigon.com,infradead.org,suse.cz,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[acm.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bvanassche@acm.org,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,acm.org:mid,acm.org:dkim]
X-Rspamd-Queue-Id: CA7B1138A5B
X-Rspamd-Action: no action

On 2/11/26 11:57 PM, Johannes Thumshirn wrote:
> One thing that comes to my mind (and that I always wanted to do for
> fstests but didn't for $REASONS) is adding per-test code coverage
> information.

Code coverage information is useful but it's important to keep in mind
that 100% code coverage (which is very hard to achieve) does not
guarantee code correctness. There are many state machines in the block
layer and also in block drivers. Code coverage information does not
reveal what percentage of the states of state machines has been
triggered.

Bart.


