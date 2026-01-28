Return-Path: <linux-fsdevel+bounces-75718-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ELyyNXn+eWm71QEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75718-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 13:18:01 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E25EA1157
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 13:18:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 95E2C30166C0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 12:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A1529993D;
	Wed, 28 Jan 2026 12:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="a2G1Lxk7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B2E19E97F
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jan 2026 12:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769602675; cv=none; b=kks138hBF7EvvWI8h92dOraHp7W/sCvAMuolutH8ysYr77iF6JI2vdCLe7ikG1KMKxmq3N7ojiO3teEvv2af4RAetohM+lQFIS8WS6y4UciTvWBJy7A3pWCUCQhc7dB2wLdGDPALJXy8yPlZ3NAcU+7PD8GRrUDimlWaDlTA/Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769602675; c=relaxed/simple;
	bh=vFWdb3PBX2zBDqdrtWvluSHxOAFMa8qzzSmnhwckFpM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BaSDM6NZxOiytH++OuMc1+yaBkPZLFtxwOYIkI97I+V4YwOH+174RG9FG8MDt3jqas+1cnLwzhwRJFBWWIoDaas2qRwCbuT8jOepnv0aHg/+Zy/ygw7wE0DgCvEyyROzi2PuP2W+N9atJcTtHv1wuyP9svU2rTcMzon2H/m+yjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=a2G1Lxk7; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-5014db8e268so107128601cf.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jan 2026 04:17:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1769602673; x=1770207473; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oUdr6DX+iZadrtnG4gSybF93zfd1qmcT/Pp5WRh3xdg=;
        b=a2G1Lxk7CIFt4ENvf74rVs3dqeguCzXVUM6iwL4ie2uAmZoILtB/RsgMsZDjMrwbD1
         id4dtvofNsrVaclLtDvNYmjZZSWjTdS33c2RkE2Q+aJeeRwT6heUpJeGFMX6FI2lWgxl
         kA0BblUvbtLUPsehbivOin7icBcePugSvEozowjSo6kUZDj4wumtkk+A50qhK1FqE7+U
         WN/z6rHu4qEwq9f0nJm4yzRHFTPeizc2UFb5ayHqKzUEldB+9ygKHVJdcWeZu1WR/r6R
         6DPpK+aQMoOZeQ+OYZVAIjyBDng+k4y+d7z0nMedmYXprQYZBGGTRdiCmvmUC/+/bKNH
         cA9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769602673; x=1770207473;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oUdr6DX+iZadrtnG4gSybF93zfd1qmcT/Pp5WRh3xdg=;
        b=KJkX0M/P7/QxDYII+OucHt/0/gzMaGHAeeZO8eP1YWQcxL6eUeWuD3MzL8f3fDleaX
         fC9wb982NzzuMGIunMbctOtzESpdsIpGjslShOh9xpnRwhHTElgRhoXTCOPFYYCf+xOD
         N40+ONtWpJHT10fkckDaQNeHJe88cKWIVcHmv6dbse9DrkAdCHQtolEegP7cFcfaQWQ/
         3poFgGv58gOOzh+lrL8z+zbNL2duPNj/5d1jy3AMFEy164W/DF7CGg/c+f9RksZ2sdyy
         g1yOExQ9l288Y/PZoJfLcPeiI+op35EEYplz8OBMn2vigNpotOCfsqi5LgGBHCff1Eia
         EmUg==
X-Forwarded-Encrypted: i=1; AJvYcCWsLWNIRef3ZaX9lPUtDadyYzsEL1b86OUZIR+aKQEyTUDBaNH+N1J/lcqjmEYx2xU3oTrnYBGpLJfb0m0p@vger.kernel.org
X-Gm-Message-State: AOJu0Yyyku9Av04KOx1CJjW/fi0a29zFt1Y6s8z9EfLTOq76UHta9ws1
	5halCCxBs3appQKYQtjy0fjyW4xxjfl9t7qkoQ2FqshlnrZBWSFvJu4CkO2U0r4uCLU=
X-Gm-Gg: AZuq6aIBUglD4+/ijTGoSSNqjPCvEdN4ufr6M1U/jNsV4UI8ZUQvXhccLeHX8+46ohz
	4p2Ob8nMiWXntlLXdmBQ/KxuPaCwUr6vza+l0OT0vDvGhvgwrLTgEbMNkOIgyvYp5DZV3WbQ6sh
	r+Ej1hAVHa2nqsYTvH00vDPxTFfP742Xge8wDMIxOxj9QFCeus/jINj7nrPwVD4xwGvbqxkPF2i
	e+S8TwhnlSUwyVGxGkaONqzc5kmS5p8Eb86ZVE+LpEVB/yKqLajGlibbtCYveAeZbjlRq6ijkFL
	rPTdeV/ZuViWD6UTVrnRBhWGplVyI8ja5EI4RaZCMP0J9snIXJuT31ChssZmAj3IE/YrtUtlNAw
	LSx54fmuAB/IwcTA7lTLmQjbawOLA3UwPkyV8lfNC2E0Qo/ndjWAFgqP4Udh7X5WyPN0YgdjtT6
	+FOPO/zEWEhrKYkcCBxPMfEAZMddemA7zMj/0HOx5ye/e0p53iwyQqbQ9g1nD3g9mY05z+KHM=
X-Received: by 2002:a05:622a:2d5:b0:502:6ed5:7b0d with SMTP id d75a77b69052e-5032f8f0e01mr63543941cf.48.1769602665322;
        Wed, 28 Jan 2026 04:17:45 -0800 (PST)
Received: from [192.168.201.17] ([50.234.116.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5033745c4e3sm14749451cf.6.2026.01.28.04.17.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jan 2026 04:17:44 -0800 (PST)
Message-ID: <16e41d3d-401f-4600-a304-08f1d2ba6892@kernel.dk>
Date: Wed, 28 Jan 2026 05:17:42 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: bounce buffer direct I/O when stable pages are required v3
To: Christoph Hellwig <hch@lst.de>, Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>, Carlos Maiolino <cem@kernel.org>,
 Qu Wenruo <wqu@suse.com>, Al Viro <viro@zeniv.linux.org.uk>,
 linux-block@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
References: <20260126055406.1421026-1-hch@lst.de>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20260126055406.1421026-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[kernel-dk.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75718-lists,linux-fsdevel=lfdr.de];
	DKIM_TRACE(0.00)[kernel-dk.20230601.gappssmtp.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[kernel.dk];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[axboe@kernel.dk,linux-fsdevel@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kernel-dk.20230601.gappssmtp.com:dkim,kernel.dk:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6E25EA1157
X-Rspamd-Action: no action

On 1/25/26 10:53 PM, Christoph Hellwig wrote:
> Hi all,
> 
> [note to maintainers:  we're ready to merge I think, and Christian
> already said he'd do on Friday.  If acceptable to everyone I'd like
> to merge it through the block tree, or topic branch in it due to
> pending work on top of this]

Queued up in a fork off for-7.0/block, for-7.0/block-stable-pages.

-- 
Jens Axboe


