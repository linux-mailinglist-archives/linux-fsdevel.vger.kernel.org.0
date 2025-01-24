Return-Path: <linux-fsdevel+bounces-40084-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 903DFA1BD98
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2025 21:45:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D679188CBB2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2025 20:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2FDB1DC07D;
	Fri, 24 Jan 2025 20:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="d8raj5YT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823F01DB366;
	Fri, 24 Jan 2025 20:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737751505; cv=none; b=Nd85Vk3q806paPls1yRdd3zX7z8pAkIxm5TjCc4YDdw4rNtQcT3jtbk8uQZcKfLzAOVDkpsMmlYKU4W4S3fthusmmFkdQ7KWj8bUVX05MPH9/8n/3eLIE4IzaOXt64W3+lEIXvuRFqVuSzMND0+q3dqinz9XDpmibQg4H09P4nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737751505; c=relaxed/simple;
	bh=HvpEBN45GzDmgxWHcbBUa/pcwqLD//p4GZQ6gKqLo38=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gE/1zD+w1TU5oT7ijdIpJAEtuIvpoe3yDZhV/S56Ki9bMxcdixpC6QokDZVFtda2Djt7NcSA4q+GQHkjAJIiyl7FGtKKjtt39t5fkNMalcbjfWaXj5lzgMRuqGM4dPegRJQCCDHbCdIK+cTzjdc8X+V7RVHBBhfPtRoFmkSTzBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=d8raj5YT; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4YfqZ14WZNzlfw6d;
	Fri, 24 Jan 2025 20:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1737751494; x=1740343495; bh=HvpEBN45GzDmgxWHcbBUa/pc
	wqLD//p4GZQ6gKqLo38=; b=d8raj5YTM0/w+WJ8pwX8GV6Ws02TW6UVoprOyPSR
	542LGZkqYy/d4bJdwNlMBuUbgakqNCB6Ro0KVyK6yswZjG0ttEQEBTJnG07f/O1i
	0cWIA04hYGtARCTvDlGx3q1c9qMtK6efprnzT3b7cU9ceZnHuAVVyda9dpohA6Pt
	J6vVzYOMPM/I5QcTrfx2LXbZCAbboYYx0qPwlW8xeav0zZHG+Ow3V5EQYFmXNcSo
	eYctmqENHhY6xm6vee/9Af5HvbZHYaJ5KfziofrY3h1J5l3gbwyTI4WxxTenKQuj
	UablqmEKaRzPn+9fO72ugFM6E/pV5oKWOkByhzRnsEtuDg==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 4MUY4w9Pz3is; Fri, 24 Jan 2025 20:44:54 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4YfqYx0jRhzlfw6c;
	Fri, 24 Jan 2025 20:44:52 +0000 (UTC)
Message-ID: <39de3063-a1c8-4d59-8819-961e5a10cbb9@acm.org>
Date: Fri, 24 Jan 2025 12:44:52 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] Generalized data temperature estimation
 framework
To: Viacheslav Dubeyko <slava@dubeyko.com>, lsf-pc@lists.linux-foundation.org
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
 linux-mm@kvack.org, javier.gonz@samsung.com, Slava.Dubeyko@ibm.com,
 gfarnum@ibm.com
References: <20250123203319.11420-1-slava@dubeyko.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20250123203319.11420-1-slava@dubeyko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/23/25 12:33 PM, Viacheslav Dubeyko wrote:
> I would like to discuss a generalized data "temperature"
> estimation framework.

Hi Slava,

Is data available that shows the effectiveness of this approach and
that compares this approach with existing approaches?

Thanks,

Bart.


