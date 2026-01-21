Return-Path: <linux-fsdevel+bounces-74892-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qFogKEcqcWniewAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74892-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 20:34:31 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4521C5C449
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 20:34:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9350C822CEF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 18:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C0C636AB62;
	Wed, 21 Jan 2026 17:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="xPlMB1r9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CDA1337113;
	Wed, 21 Jan 2026 17:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769018398; cv=none; b=aKRQ2pNHgpiO2q1RWthd9IUcjlkQ/ZukrlIcy3NvepcvU0FqeFZsia35JumzJrveGeyv4SxHrwkts+xdUpHrCQeypNCBSyrUzzzZfNxMuoY0TN/B50Pfj2ANM1oS0cOMHbyEKh0/xu4USGnu86w12Q3uFjpxjShtU98WTMfdtjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769018398; c=relaxed/simple;
	bh=cB7R//NyyNvgFjDreXZmNdq9+kWv2SQNEu5wQ+LEJsc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lF6V+kZRfZ14GrfggaEO+jd2S7sG0oLYnJSA3Go7PcJse+DJCjXZaYt8CjdZaPy7HJBPeZDJbxdVisWJfGtabenm0EHKi5AXKQ86vrJgdnvXumfBTo8YWSrCMaKxI4QP+7Wnak1XpyczBVSdpw2PhUmybuAu46sodlOfUfCdWio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=xPlMB1r9; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4dxBmX5YtWzlfc9J;
	Wed, 21 Jan 2026 17:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1769018394; x=1771610395; bh=X95i5SKsyEWEDZbyP0xAvaZy
	AHiPEpx9o5mzJwtQaRI=; b=xPlMB1r9293lwx+nqLmvq3sIWxaQv+DR6irp2zLd
	Zlua7TSWZ8wMnhaUmn/e8NGQWAgd25zfYZSa2+EAdxPRrIFp/QSNCNTg039YMpSZ
	KqiVG1YlurwxJ5MjITbfO+z9ycSu4QHlCrlKxcRyVNQsDSqRNwSzAYKfe8TQt6VO
	jR7zAslx/P9nFEaKybxWySyeQNwzic+l58UsD/YAWL97RocJFnKYw3nqlx8Qp6Gh
	SzoVFuf1xXaTvZAbnvOnBuOBA8HBS4jvwVIpL4lv7i44YCq32+OPEPIrTkhXjksG
	Coccv8upOwnfpsqVrwOaPvgRE1gG0L40K8+tQO49JkcAwA==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id CF6OQ5EBPfQt; Wed, 21 Jan 2026 17:59:54 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4dxBmQ3ps2zlfvq4;
	Wed, 21 Jan 2026 17:59:50 +0000 (UTC)
Message-ID: <6927d0f7-5bf5-4035-b1c2-50f3edae4b7f@acm.org>
Date: Wed, 21 Jan 2026 09:59:49 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scsi: target: Fix recursive locking in
 __configfs_open_file()
To: Prithvi <activprithvi@gmail.com>
Cc: martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
 target-devel@vger.kernel.org, linux-kernel@vger.kernel.org, hch@lst.de,
 jlbec@evilplan.org, linux-fsdevel@vger.kernel.org,
 linux-kernel-mentees@lists.linux.dev, skhan@linuxfoundation.org,
 david.hunter.linux@gmail.com, khalid@kernel.org,
 syzbot+f6e8174215573a84b797@syzkaller.appspotmail.com, stable@vger.kernel.org
References: <20260108191523.303114-1-activprithvi@gmail.com>
 <2f88aa9b-b1c2-4b02-81e8-1c43b982db1b@acm.org>
 <20260119185049.mvcjjntdkmtdk4je@inspiron>
 <ac604919-1620-4fea-9401-869fd15f3533@acm.org>
 <20260121175136.2ku57xskhwwg7syz@inspiron>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260121175136.2ku57xskhwwg7syz@inspiron>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[acm.org:s=mr01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-74892-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[oracle.com,vger.kernel.org,lst.de,evilplan.org,lists.linux.dev,linuxfoundation.org,gmail.com,kernel.org,syzkaller.appspotmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[acm.org,reject];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bvanassche@acm.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[acm.org:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-fsdevel,f6e8174215573a84b797];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,acm.org:mid,acm.org:dkim]
X-Rspamd-Queue-Id: 4521C5C449
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 1/21/26 9:51 AM, Prithvi wrote:
> I tried using lockdep_register_key() and lockdep_unregister_key() for the
> frag_sem lock, however it stil gives the possible recursive locking
> warning. Here is the patch and the bug report from its test:
> 
> https://lore.kernel.org/all/6767d8ea.050a0220.226966.0021.GAE@google.com/T/#m3203ceddf3423b7116ba9225d182771608f93a6f
> 
> Would using down_read_nested() and subclasses be a better option here?
> 
> I also checked out some documentation regarding it and learnt that to use
> the _nested() form, the hierarchy among the locks should be mapped
> accurately; however, IIUC, there isn't any hierarchy between the locks in
> this case, is this right?
> 
> Apologies if I am missing something obvious here, and thanks for your
> time and guidance.

This is unexpected. Please ask help from someone who is familiar with 
VFS internals. I'm not familiar with these internals.

Thanks,

Bart.

