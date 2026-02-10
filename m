Return-Path: <linux-fsdevel+bounces-76866-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6AJbHmlyi2m7UQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76866-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 19:01:13 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ED61011E32C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 19:01:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8B07F30106BD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 18:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48E9A12E1E9;
	Tue, 10 Feb 2026 18:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="pQ5rPdwU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0320C2877CF
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Feb 2026 18:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770746458; cv=none; b=d/0/owdeoeYffGZNW3waYu72PkL8roCofVh9CwUSkinAduBvTtp86ZodG9mFXRhmQQd6tWm59njt0J/Zb0tyTJWzjdOCidiGs2y4tPv77OgKVUgj68XqLUp+t/r/LdMG1A9X1Cotj0dVyHjieoAkwel5taM7ows4Reo7ncGpBDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770746458; c=relaxed/simple;
	bh=er72VwDfSI+2eDb+LJym7LDsAMBe46UATWtaDYqIReQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gEwm1LVx9su6yWwdp/n5sw79r8YJEDL+EQ8pXX4c1mvq8ua6PmrTz1hpUaK+6ZbLq4fsCfCM8u7DvGFD+w0Dpf8goI9wu3Va3FWC47m3ZRXn5wDAPKAiNMmIEwuv9T9rW0BRoCIfq71fIQa3NTQA8Y1xRs37FhRMyUCPKiX4QFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=pQ5rPdwU; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-662f9aeb782so3597230eaf.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Feb 2026 10:00:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1770746456; x=1771351256; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X3y2dMzcvbiVwpz18dYY5p7GLV+r7073Uyi9rb7xYAY=;
        b=pQ5rPdwUsXLG6Bv9fiJ4GoCT57/MXfxzyefhZtciiR2YqKOJhCbdsoLReBOSf0T3pE
         5hWvyEUoWdgl1je2fWWrWMxafzZfEu71UDsiThlR09D0VRjFplnKTGRB/9p0jge+5Bbf
         FEaRWwYGE0/7qik8nqycQ8HhkEqTz7L+mNoL/QUIDy4eMEJ9Z3hLWHEy/A9xtcxUJFJM
         cVZsswGAVllK6l4QDStyDbjq20oHFS12NA4bkn6RhPjMDUliz+CaHxXeGFTVa9KnDHNP
         aoWocDefJniCaduyguwJq4VA/9WgA/ZloQZ0gm4CJXvt2MG3M7lN68d+CQ+Ch3VkAj4d
         HCnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770746456; x=1771351256;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X3y2dMzcvbiVwpz18dYY5p7GLV+r7073Uyi9rb7xYAY=;
        b=tibQdjfL0iqSadlbSa7/awp3w5814BCoX+fgD1YTyMxNIu2KuZ3qWXC1tjsgTjp+d3
         yvnw8R9qYsHfcxy/pxp5/Pw0JpMd86Gy1DSRr37B4W/KzYE53Lt2FXSlIz6DBvaUl6e2
         q6eJk8Y9dxenGZQPBp1XKDMhPSJxxLvr+B69ROkrcJ91e41YuP2pbgP+8w3bRJK9FhL4
         fsCYrZ0IrwVb1rCXhSk3ouAST9lpBsC++3QfAyxb4HjKETqNE2gIVyvC1D36YP1JWGzL
         A8Y0hFkJeEuUFsTNisHafRpfDkAnyUtCnR43XbifNbVI2xzSFtXKYaFg6qTmYYMbTLvl
         9/cQ==
X-Forwarded-Encrypted: i=1; AJvYcCXebJC4KuPo2Tno3NMZ8iZMoGDfINDxaJNeI4H9jCnBM23EBLmyTmOF0PaC7ICDqYY2q/3fBmMPmgbYhEiU@vger.kernel.org
X-Gm-Message-State: AOJu0YwDgKR3WwQxZGg8QMRQIy8leLcoq1SI9b8Puin8ly3ytONkyIWJ
	y00f7fv7UomjUsIe/67VcpnDF0metamfb7YLPlemOPmefg6zVCojc2u9Xi7L7/ic7WCTGIgdjmb
	lwBPQF4s=
X-Gm-Gg: AZuq6aKsfYFVvSUCxqEJxCiGmSoH8gIHgXt06dtE6ETG8tw0IHVnrArY94djg4GmEHK
	2CUDmsC8aX/H0g/FPGCSPiEzWFKp0qR2RPWwGRgBNFRXhUoL2NW0ahvMtHhmzfun3FxPwffZ4ql
	WkBHH2AVv7eAS6ZT81Iv9TMhTN2vS4niFv/NLmEzmdcDYR1JxsLmUYWwP4WFHjP39WIysEOahvy
	gaheqjK/hpuyKyXQ6OJyx3VufVxpRMXYsyMIGxMsd0/Bh+hSEZskNghkEzJUFCDjHqaArIBE0F4
	E1xbWx09L0JfahyTXn0YuAz909jjsizprssasmD+BLuNl017GOueGj6qGiNImhsDUK0jfoLjTSd
	baNoSKM3CetXRIpK801X1KpDakhzSf1PDXpIcVpEz8n6MOtQ10sK+pii8XcdqTjCiQmCXQZBtgJ
	rW8ULYe+Kd9aER1Jx4KC7XYk1qdtu4yHsCsvOMQSFfzQ63eDTv+RFQXJSHI+LYG69TEkXAI0QNC
	Kc/4ezk
X-Received: by 2002:a05:6820:825:b0:668:d715:109c with SMTP id 006d021491bc7-672fed84b42mr1459303eaf.65.1770746455602;
        Tue, 10 Feb 2026 10:00:55 -0800 (PST)
Received: from [192.168.1.102] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-66d3b2a75d4sm7939680eaf.15.2026.02.10.10.00.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Feb 2026 10:00:55 -0800 (PST)
Message-ID: <b8ed4d3b-efd0-42dc-8628-2a864b050518@kernel.dk>
Date: Tue, 10 Feb 2026 11:00:54 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 06/11] io_uring/kbuf: add buffer ring pinning/unpinning
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Joanne Koong <joannelkoong@gmail.com>, io-uring@vger.kernel.org,
 krisman@suse.de, bernd@bsbernd.com, hch@infradead.org,
 asml.silence@gmail.com, linux-fsdevel@vger.kernel.org
References: <20260210002852.1394504-1-joannelkoong@gmail.com>
 <20260210002852.1394504-7-joannelkoong@gmail.com>
 <8826110e-cb5c-4923-99cd-b9f21f536d32@kernel.dk>
 <CADUfDZoiHYKrfb=NxLH=K99ALuDoABCnrOFC4_mZgqvT6qQPXw@mail.gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CADUfDZoiHYKrfb=NxLH=K99ALuDoABCnrOFC4_mZgqvT6qQPXw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel-dk.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76866-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[kernel.dk];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,suse.de,bsbernd.com,infradead.org];
	ASN_FAIL(0.00)[1.2.3.5.c.f.2.1.0.0.0.0.0.0.0.0.5.7.0.0.1.0.0.e.5.1.c.3.0.0.6.2.asn6.rspamd.com:query timed out];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel-dk.20230601.gappssmtp.com:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[axboe@kernel.dk,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kernel-dk.20230601.gappssmtp.com:dkim,kernel.dk:mid,kernel.dk:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: ED61011E32C
X-Rspamd-Action: no action

On 2/10/26 10:57 AM, Caleb Sander Mateos wrote:
> On Mon, Feb 9, 2026 at 5:07?PM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> On 2/9/26 5:28 PM, Joanne Koong wrote:
>>> +int io_uring_buf_ring_pin(struct io_uring_cmd *cmd, unsigned buf_group,
>>> +                       unsigned issue_flags, struct io_buffer_list **bl)
>>> +{
>>> +     struct io_ring_ctx *ctx = cmd_to_io_kiocb(cmd)->ctx;
>>> +     struct io_buffer_list *buffer_list;
>>> +     int ret = -EINVAL;
>>
>> Probably use the usual struct io_buffer_list *bl here and either use an
>> ERR_PTR return, or rename the passed on **bl to **blret or something.
>>
>>> +int io_uring_buf_ring_unpin(struct io_uring_cmd *cmd, unsigned buf_group,
>>> +                    unsigned issue_flags)
>>> +{
>>> +     struct io_ring_ctx *ctx = cmd_to_io_kiocb(cmd)->ctx;
>>> +     struct io_buffer_list *bl;
>>> +     int ret = -EINVAL;
>>> +
>>> +     io_ring_submit_lock(ctx, issue_flags);
>>> +
>>> +     bl = io_buffer_get_list(ctx, buf_group);
>>> +     if (bl && (bl->flags & IOBL_BUF_RING) && (bl->flags & IOBL_PINNED)) {
>>
>> Usually done as:
>>
>>         if ((bl->flags & (IOBL_BUF_RING|IOBL_PINNED)) == (IOBL_BUF_RING|IOBL_PINNED))
> 
> FWIW, modern compilers will perform this optimization automatically.
> They'll even optimize it further to !(~bl->flags &
> (IOBL_BUF_RING|IOBL_PINNED)): https://godbolt.org/z/xGoP4TfhP

Sure, it's not about that, it's more about the common way of doing it,
which makes it easier to read for people. FWIW, your example is easier
to read too than the original.

-- 
Jens Axboe

