Return-Path: <linux-fsdevel+bounces-36513-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC6589E4D0F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2024 05:35:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E4C718805B6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2024 04:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D46781922D4;
	Thu,  5 Dec 2024 04:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UPIdnbKC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496812119
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Dec 2024 04:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733373352; cv=none; b=WvjJrHJg6Q4zry3TYXKEw92L76alxZb8DNYFRGoy82/0Y4lP+0XnP1wknDcg0nLzEDsaFj6ri3b4QZh8m1RLI0CT+BGMob5hBMi9w2d/7VHFXtbZhzosQ2CD7fmlHmgPbFZR62WOHRIvkHrdL440/6dZMOSrEaNBkzLY/5Gqp9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733373352; c=relaxed/simple;
	bh=uiNNXseuROWmgCpz6MHoHMtZaYwfpO53Yy2y0pgRuUs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MVdERki3HC6WlO0dCQ30F8shkev+310QSI3Srirh9k6KZu04IYlcUB5ImnThcCC9pkw07p1nm0GYABf5RqNrnkfq4uBsRCEcIlcORN4oj+Chd8JiZNxWAj6TwXOrROLgdcsMJtR0XjSJXzSy0fOrNetkbxewLEAp1n8A2/xgTBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UPIdnbKC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733373349;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0toYV7O5m7SIQhioF5KP2treLFyuAZomjZkcJd8tQOM=;
	b=UPIdnbKCE5Nlu33Vho9D4asc7RnccKoo4mf//GGZGJ5INaCkvzBDYo3wAwxHgP4ZcPJpJr
	y3geszLFyTzgGHmiCU1VbsDp6pDllUMzlc3t76nTPDuFP6EdTr5QtQdyFLREhLB8ljmlG6
	qksq1G+Zwn+JQ5wuWcE4EJGRw/MTv8s=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-u21AXz8NO9yVfX0PEiaAaQ-1; Wed, 04 Dec 2024 23:35:47 -0500
X-MC-Unique: u21AXz8NO9yVfX0PEiaAaQ-1
X-Mimecast-MFC-AGG-ID: u21AXz8NO9yVfX0PEiaAaQ
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a77a0ca771so5507455ab.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Dec 2024 20:35:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733373347; x=1733978147;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0toYV7O5m7SIQhioF5KP2treLFyuAZomjZkcJd8tQOM=;
        b=hs3m7GB3uS26LWltwy3RHsBDiGiGnVGW9wNIyyWDpXKk9+V853r7PB2hT4UzhSVlxr
         /av2s+J5V7aWqKf1QsFjULKi51PQayBPYFwNYZldh7VCKX4jYrBfUZIDZV0m3Ngb1TIu
         MWU/fnOBcJn2f5oC1+fPA4badVILySAM29Bjch5GUGmr/cU0m4fUpAiqfd63M/H5ASFo
         CpbObCmrxS+w5+YFoOiBt3l2MRk+OAdBv139qPbnc1sXbUbA+wow6t0uPcDPmD87U623
         waRwyGJugngTyKzMiYV3siWc+xQVssf0w2+sUu1n8ofkh9eRDkog7I8C8UfxBJVdSfpp
         hfHA==
X-Gm-Message-State: AOJu0YxLelMt/47x28mLwhJxRFq0DDXX4vv0Cs0ecUxDf9hPInL6pUdC
	Ro8d2r8Ty75ozvdUKk2eYyE2i5jvXb0in9k0VwHwg8BJvmU5la/r7rheShRjNGgWKWKFnXcZOK3
	/QeyCqJ+yXCJQBT7zB8E3zRurbdIUPikkNkQzo1kO229v08dZh7CNzgixWnMw8b0=
X-Gm-Gg: ASbGncsXs8YWQgy9RP3JeZRSWwIYX8UG1JClhyoPH3oUeHsnsB12Ln280s4xrzzIwOD
	ne6p54OKcETMJw2kVk9zspgrlcKjrSasXkfSK4C8DqW5NYAb7LTP7mgq2Z4ORPr8TsNZIWAo0u1
	a09+NcTpQCLyIA7j2uX6+xW8UxeeDRmqtNivj1u2YF0zzujMpq+a5Z+dbLknM7J+U8z8rlYfm3q
	NeTj2AjhJ4a3klZN67O4k3NJPaPc4L091P1DuchBjZnTvPf5K5UcdiyMvCaksnyrk2QXcvXjteH
	2pRhm+tD3vZF
X-Received: by 2002:a05:6e02:350b:b0:3a7:fe8c:b012 with SMTP id e9e14a558f8ab-3a7fe8cb0damr84155215ab.18.1733373347032;
        Wed, 04 Dec 2024 20:35:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHC8qtYhZohMTLDB//11ZaFrpRsOUaLt9pecqfj3xsswKrVgp4ixwyQVtzcB3lFYfmEB8DAVQ==
X-Received: by 2002:a05:6e02:350b:b0:3a7:fe8c:b012 with SMTP id e9e14a558f8ab-3a7fe8cb0damr84155035ab.18.1733373346753;
        Wed, 04 Dec 2024 20:35:46 -0800 (PST)
Received: from [10.0.0.214] (97-116-181-73.mpls.qwest.net. [97.116.181.73])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a808da2623sm2186565ab.22.2024.12.04.20.35.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 20:35:46 -0800 (PST)
Message-ID: <0272e083-8915-407a-9d7f-0c1a253c32d7@redhat.com>
Date: Wed, 4 Dec 2024 22:35:45 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] common/config: use modprobe -w when supported
To: Luis Chamberlain <mcgrof@kernel.org>, patches@lists.linux.dev,
 fstests@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, gost.dev@samsung.com
References: <20241205002624.3420504-1-mcgrof@kernel.org>
Content-Language: en-US
From: Eric Sandeen <sandeen@redhat.com>
In-Reply-To: <20241205002624.3420504-1-mcgrof@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/4/24 6:26 PM, Luis Chamberlain wrote:
> Eric, I saw you mentioning on IRC you didn't understand *why*
> the patient module remover was added. Even though I thought the
> commit log explained it, let me summarize again: fix tons of
> flaky tests which assume module removal is being done correctly.
> It is not and fixing this is a module specific issue like with
> scsi_debug as documented in the commit log bugzilla references.
> So any sane test suite thing relying on module removal should use
> something like modprobe -w <timeout-in-ms>.

Well, I was having a sad because the upshot of all of that was
that when xfs was not removable at all because it was the root
filesystem, the end result was something like this:

    --- tests/xfs/435.out	2024-11-21 05:13:04.000000000 -0500
    +++ /var/lib/xfstests/results//xfs/435.out.bad	2024-11-21 05:14:47.949206141 -0500
    @@ -3,3 +3,4 @@
     Create a many-block file
     Remount to check recovery
     See if we leak
    +custom patient module removal for xfs timed out waiting for refcnt to become 0 using timeout of 50

which is kind of nonsense, but that probably has more to do with
the test not realizing /before it starts/ that the module cannot
be removed and it should not even try.

Darrick fixed that with:

[PATCH 2/2] xfs/43[4-6]: implement impatient module reloading

but it's starting to feel like a bit of a complex house of cards
by now. We might need a more robust framework for determining whether
a module is removable /at all/ before we decide to wait patiently
for a thing that cannot ever happen?

-Eric


