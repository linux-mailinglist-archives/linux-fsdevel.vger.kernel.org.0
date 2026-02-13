Return-Path: <linux-fsdevel+bounces-77121-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yP3xKSD8jmljGwEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77121-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 11:25:36 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 481BE1350BC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 11:25:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CC8AD3050D5A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 10:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6539350D65;
	Fri, 13 Feb 2026 10:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mB9EV/QN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E4D313554
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Feb 2026 10:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770978324; cv=none; b=bSJfRKsbJdN7quGzynDC4A1iLGg+DjmDXWxAs+tQEfN56ExTqe6pHFcN8ku9lbrQ597gOtaDKHxXn0+MjqzqcUyHOAvTXVwBeKVD2nAPLAmQG1FcgHSXNlgvVbi/PKpM8j4D7G0L/K3LxNjsyjrNGUea55CftJj7l9QTLA2Bf78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770978324; c=relaxed/simple;
	bh=aOSOkJx+F5n0agQz+RdKAqL6Ll+cCCa/aJaGebEFJJc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dz4ARZwvDG7eob2oQWyL3idSNkjZtHwnOgOTDuS+fNERPx8ycsxu2Jl6EiKErYBfXF3nl9Ak3qlZ82NYVIxaq3pJokXOljY0gp+50tceLHgORWYxWgASV/PxumCchwQGl1o94aFLxoD5clysW58+j+YXV+QFBwKmnADlrtEBHs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mB9EV/QN; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4801bc32725so6245415e9.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Feb 2026 02:25:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770978322; x=1771583122; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NYROThY/7ZHEET/uel6hPwtunmdQZfk/w+xpuNRVP/g=;
        b=mB9EV/QNGisvTKyRjOF2XJviXpqv8wYhlu0uRvNZBA+Q1FQ1AVhVnCzFEQae77afTx
         i+DYh+NmxvhbtC/iFwxvXM+zGMiTGOdMf/kjD79TT/O9vA8EP9ZDigJ2gUHdVrxsVImF
         zZYwGpGigS8OKziQ2VGEomtv26Ip+yI5O+iOxZ9pt5ezj5yYu7MgG9+soOOKAVCJGCCk
         Rpk6F/4zO9JigHgbTx6WD21KwrdLO9nOn/gqVZaAaqSLtapAkAmclPNy0NhHfCP4hSPW
         bxybbTuNoFixLZOB9pvdGxoAmPZU8Srvcev4XeJNl48RKKUzv4N0xkkgYySXNd34kX+y
         WEUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770978322; x=1771583122;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NYROThY/7ZHEET/uel6hPwtunmdQZfk/w+xpuNRVP/g=;
        b=fzkoWrzEntO4ZtFuoQ7Z8pz14TZqyESmOKyyDyVbjOtOaWQDn5aI3Iozk5AWS/RNpd
         fXcob47SRykD1TQjmPBhlNkI1eLLWxG17r4lPwKa//ui8SCtx+CAXhru6bqX1gB7RMmO
         rU86Hnd/ggFZIkyELpGmikmNRQwR1hKmbNUGhCfAmYUcWehgKmKZ51pJLl2xr4pDaKjs
         GadpkRRrDEfrqkv91/JMgA7UrOewy2MJVgxelMkgFPJI93BnQyRgcgD/w1FaJ4e6uzA1
         QzDe+M/7XmlfpYOX4wGOCl238dToSlX9dpGLwhqQhKxUrQRbQhfCZPW3HMMpO5G+OwHj
         ELTg==
X-Forwarded-Encrypted: i=1; AJvYcCVjSM6NE/Zedbb4T2in4SOGvOOaoWUkOS1sKPMLg4xg24Wm54299LaH4wEbdHbLxTkwR0OBj18otxI0aXwU@vger.kernel.org
X-Gm-Message-State: AOJu0YxEH1rWwVKsQ7/kieMEi4Rt9aFitPulMZj7g9a1kZgvUKRErqVt
	8A8D9Nsv2YoF7CYdDEZLrhkeZ6hyptGpCKJWXUifhHyd6ZT25TnVocx7
X-Gm-Gg: AZuq6aLZDJULF7a5B8LheKHelV6s64d/Vh49WLpMWnWMM7XzrvF+4iMdwhxSaA3IsYF
	1L2DCxVYgNGrFrPJm3417yXyBV1qp19idbce8emIP/M89q7b0CpnhF378wqfTCHOJqIzmIAm8Wh
	0oak9aFbEUlw2U/hRGz9aQZDPiE7dAXziObiFVaX9cgCYs2xsg3uRZgD3Mgc7L6W9IIRVP5KXJU
	gow0YjHUxiMaUOQKy6Mh4MOzr1c6nTcogAgGA3PJcf59JLSmGuIdF+ksxMhvFVoOggPcFneDNEz
	tu4pq8ORPSeu9qDWAirVRgb6OGXnDFr4Z3nu2LHJFCAVrQvD6bh+V3rrkTZrWyeo09vMT2ugZJR
	DGdTMcz8K9Yk3uSAbFG9l2enol/geX9k/jQBlJrHvfe4HTKaAjdyWQ5NiATHCQIrRX30DCKoPVS
	T6IqeJkzUf3TlEIl76Cyysajozufbfg4rgD0NL9OYqrt/dN3k2oQWTLew=
X-Received: by 2002:a05:600c:4fc9:b0:477:2f7c:314f with SMTP id 5b1f17b1804b1-48373a1ba16mr20756045e9.10.1770978321454;
        Fri, 13 Feb 2026 02:25:21 -0800 (PST)
Received: from [10.128.170.182] ([77.234.210.12])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4835dfb4bd4sm188893315e9.7.2026.02.13.02.25.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Feb 2026 02:25:21 -0800 (PST)
Message-ID: <4870d506-e29f-4c68-8d93-03aa3a931fa1@gmail.com>
Date: Fri, 13 Feb 2026 13:25:20 +0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: File name is not persisted if opened with O_SYNC and O_TRUNC
 flags
To: Christoph Hellwig <hch@infradead.org>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org
References: <4b207a36-5789-41d2-ac17-df86d4cde6da@gmail.com>
 <aY7T1LS5vnZI-ZxE@infradead.org>
Content-Language: en-US
From: Vyacheslav Kovalevsky <slava.kovalevskiy.2014@gmail.com>
In-Reply-To: <aY7T1LS5vnZI-ZxE@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-77121-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[slavakovalevskiy2014@gmail.com,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: 481BE1350BC
X-Rspamd-Action: no action

On 13/02/2026 10:33, Christoph Hellwig wrote:
> On Thu, Feb 12, 2026 at 02:51:47PM +0300, Vyacheslav Kovalevsky wrote:
>> Detailed description ==================== Hello, there seems to be an 
>> issue with O_SYNC flag when used together with O_TRUNC on various 
>> file systems. Opening a file with O_SYNC (or using fsync(fd)) should 
>> persist directory entry. 
> No, it should not. I'm not sure who hallucinated, but O_SYNC has 
> always always applied to persistency semantics after writes and 
> nothing else.
You are right, opening file with O_SYNC does not persist anything and 
ftruncate or O_TRUNC do not count as write I/O it seems. Also found an 
error related to these assumptions in our testing tool. Thanks.

