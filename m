Return-Path: <linux-fsdevel+bounces-76799-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GJAKFtWCimlaLQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76799-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 01:59:01 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E328115D96
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 01:59:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 51936302E0E8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 00:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E04DB25783C;
	Tue, 10 Feb 2026 00:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="y/FIuYfA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E15D1F1315
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Feb 2026 00:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770684908; cv=none; b=lysI+VUxL3PS/jSKNrRK1B0HbS5rAvJrbLcp4TaEYDE6a5eZeDqIpWtjKUJSVDrjEZnNVGZ3Fu7u1y8FFJOLWUSnBiQi9fAWuBn88KLh1SpaTP46F9wrzUE89v/hIRFZ2R+5LyXCWDwEnSqXw2QklY7fk9bxUF/Fyfy/YmUA4h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770684908; c=relaxed/simple;
	bh=bNGbnoYHphmDMq+tsIXTMuGwdyjziIIf/kP8aUBslZY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d0PSixpf/GP8r3n8qqRIUb52nx7ECjgJm7yiNwHaMl0ZA84W3W8dexNVutLHSe4EuDgrTrkZIDVLCfHx7q6wuNU63LOY5bjvy5RrgE+lu5DNBjLsOXlerMXoEwf5dDkzW9afr7/MLDwDo44A80yuEFOAdl3d5gBh0aPKpt3ZO70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=y/FIuYfA; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7d18d9503eeso295716a34.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Feb 2026 16:55:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1770684905; x=1771289705; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lUU6lmqjVZyhTtFbjOJny4LX3nceJtE6En3QGrOjt6g=;
        b=y/FIuYfAAmjoSNRT7jRirMxnfMSAUq+lTEH9Ez6qY73pSI4VaN7p/aEadYRpRj2ZUu
         SbykmOMojtZAkpnV8WWazzYI+KKFFsC8M9tERF9MiqzLfWzcmZoHSAX9iEEJ7DXNSWfn
         JBylfcHVJ+E5N07gv59yXcPpOaHn2A5Gl63TsEhG9bAKZwEsMghAGjSuYymXUnB1Xr+O
         0W5dWuFDHy8V9bCvQquqHZxXDpp47BzmNH9Rhx0aLoI55s8vvcTKF9qSCWPwy8Jtuvvz
         tjKAzfyuaJCLj7AFgNaqZdkJDfSnpQVMtaA1030tPGYssDduGH1nCRPRXoIAC2HlZ0mo
         pL1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770684905; x=1771289705;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lUU6lmqjVZyhTtFbjOJny4LX3nceJtE6En3QGrOjt6g=;
        b=KmPWffUDZy5YkXujqgcmANOiqvsSB3P9UnWdzvJUGNcBp+6WF+xeU+iSRMzaDvq0nY
         uIpYsjf8uAjWG+l8G5vSSh2TN+cmyTRDGYvlzWUvzqLPCnVx+9CFxeNgocB55K6L9z0y
         p9xfVm+srv1Zwpx00eUt//6K1F1YNv9DC6WYZYOaRsTNJYZEWUzDk4T8yviIsQJJfYnR
         t9IOsSer2vttSAWQPFebkqHx1FetSxscFh097DUE67hDC1CdbG5yI6RUFeiUWCkSHTtx
         AiG785cgpoLRbcfNmL9rnvZ6aD8yN6HjRZjGmUSFR/txEgCScDBCdc/cq9m6VIWnCq0B
         yUDg==
X-Forwarded-Encrypted: i=1; AJvYcCWuWWnV3qfQg4AVTbYd8J4umBviEIgDEdOTTW19pixQ4bTF26P/LOxREW7VpX/Jo5Of65AcrPgTI2i9oiiG@vger.kernel.org
X-Gm-Message-State: AOJu0YwtunQRXsoipKW/lUsuF0UYs1zUeRIolsPhkek5Xr8UnHqh+UT3
	aVmcobPlFPY6NVkdZ8EWxV71v/uIfhd/t3MtoZlPCAkyyYjWCofpRBmi+Z/dX/SAE6w=
X-Gm-Gg: AZuq6aKuxBeTXTOoQ0uOV8wNWQKGcCD+BpldYLhP7uFzJDHDvEhm9HOIGpQxdnHTaFP
	3e/bzlvNQVVYBFMQqnx8g4lTlTul4TsEp7Y96qi/eJWEUVmVtNeE+5WgLsp4BczE8zQQJuSdsjn
	ANE59MFb6y+Pzrrih/x4S9yL+MELgdTAcLuVzYWtNgaepnSfxGU8HEmnOu5bBqdhXQFG3s09+Xs
	hHaHxR7Grkk0e3i9L81aUiHZauMbhpuCyVsqvg7rq/E7PUoRhZ7hsPabjZzr+JBkp/ejXqCQ9my
	bq45mqwZ+yMhnieT1IXr015itSty2AFVn8VRr3xYdrxzIGe+Cg1KmckPmK9lpPFJXvJvrsZlAgn
	sMe+DrhaasrSS0lZaNztsTEfcS2BATZb/KymZaBHLKh/zG1NNqqRLBqqOIJMB3Rz7N6zmjc/BiE
	1U2K5OlbYmZcYV8uQ7qtYsSqlSoopq5EMuCUSa6lgioDjO0bfM4pcDsC/rp4nHuluD9ACYMxK5S
	Y5LXBQeTA==
X-Received: by 2002:a05:6830:44aa:b0:7cb:125d:2a47 with SMTP id 46e09a7af769-7d4643e5a0bmr7090026a34.1.1770684905573;
        Mon, 09 Feb 2026 16:55:05 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d46479b9cesm8261665a34.24.2026.02.09.16.55.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Feb 2026 16:55:04 -0800 (PST)
Message-ID: <27cebab8-fb11-4199-a668-25aa259ef3b1@kernel.dk>
Date: Mon, 9 Feb 2026 17:55:03 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 00/11] io_uring: add kernel-managed buffer rings
To: Joanne Koong <joannelkoong@gmail.com>, io-uring@vger.kernel.org
Cc: csander@purestorage.com, krisman@suse.de, bernd@bsbernd.com,
 hch@infradead.org, asml.silence@gmail.com, linux-fsdevel@vger.kernel.org
References: <20260210002852.1394504-1-joannelkoong@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20260210002852.1394504-1-joannelkoong@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel-dk.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-76799-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[kernel.dk];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	FREEMAIL_CC(0.00)[purestorage.com,suse.de,bsbernd.com,infradead.org,gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel-dk.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[axboe@kernel.dk,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kernel-dk.20230601.gappssmtp.com:dkim,kernel.dk:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2E328115D96
X-Rspamd-Action: no action

On 2/9/26 5:28 PM, Joanne Koong wrote:
> Currently, io_uring buffer rings require the application to allocate and
> manage the backing buffers. This series introduces kernel-managed buffer
> rings, where the kernel allocates and manages the buffers on behalf of
> the application.
> 
> This is split out from the fuse over io_uring series in [1], which needs the
> kernel to own and manage buffers shared between the fuse server and the
> kernel.
> 
> This series is on top of the for-next branch in Jens' io-uring tree. The
> corresponding liburing changes are in [2] and will be submitted after the
> changes in this patchset are accepted.

Generally looks pretty good - for context, do you have a branch with
these patches and the users on top too? Makes it a bit easier for cross
referencing, as some of these really do need an exposed user to make a
good judgement on the helpers.

I know there's the older series, but I'm assuming the latter patches
changed somewhat too, and it'd be nicer to look at a current set rather
than go back to the older ones.

-- 
Jens Axboe

