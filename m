Return-Path: <linux-fsdevel+bounces-71030-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E76CB199B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Dec 2025 02:31:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E3964301B804
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Dec 2025 01:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 341C0222560;
	Wed, 10 Dec 2025 01:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="vcWO697F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB8813B584
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Dec 2025 01:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765330317; cv=none; b=OSRGmz0/E2B6D9gDQ8KQng9gaoCKXJCdOr9gbauejzMLoKmWTLMCgayUQ3i892lNKQoM1pngqTsQNKr8KelpUhm58noawjwsTi3TZ+IFYuK/P0uGkEhzJhCY6tGgA9hsqOa5C1gVDouWRapIN106bEc4flMpgEZYsW9wHalkIHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765330317; c=relaxed/simple;
	bh=Qzl2+G26+egzW7NDywgHIPdgsSaruQbcND52dODf3n8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TBM+npaqJthGuQ2KFnJ7IicffwJSeF/HNj5EZin4C8NQSss2RKr8YZZOBElgvKH+AduTev9CrpfhQ644Fc12I7hz3jSBPtBkBJ0tSs95e+rr0xkXZ2owPD1D4PtkNuG8wzyzSZRikpA93aorq53UekWjuEueb4fll1yjhjM1Heg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=vcWO697F; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-297f35be2ffso91823885ad.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Dec 2025 17:31:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1765330314; x=1765935114; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bADCVXBmULrDifzRYGxN5q5EnP7XKBVKqffCRORME+8=;
        b=vcWO697FfeR9XP3IZLye2h5kDXCOy8u4uaEwWUapyEix6y7jfTcVCAiwDu0gQU/tCx
         n6eKFfZWTp7jEz5ZDIDKdDXUb/tABDWOpV8+KdbA65q9EDo0gxovTwFO44A85J3sYWt6
         mngtreF1nRG3mQ/WGiWI3cXpv8Kjmks4AJNPMjUNDuvGz4Pz7n6ClW3sdv8G3XsJjEbr
         9GPXJH1nkd6qtRraL2jRm9hU59fkLMk2Rd+YYOE4+MCjC6xklg3bPg1YFyD1qNkQbUEm
         zDW/lwDX5wQZEIThCubD8U6HW4JPb3nCLTJulvvgbvwYuYciseZI+UkCgeVg0KXOhsbk
         rplw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765330314; x=1765935114;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bADCVXBmULrDifzRYGxN5q5EnP7XKBVKqffCRORME+8=;
        b=FyHtLpx5YFhtvSnIvdwMcYyANBaerUjszivjLDe0bMTthjdASc6aj1j1Q4J6LhIU/J
         HQ1hsGJB6Oq3aqpY1A8Fx4B57UJaomDG7S1rspPJDcc+TtuauRqqfCSr97ykTyQRpA4p
         pUSgSIJbu2ov/biozPdEfImqPRVek8BYUl6O7+O3VOc8e/KhjLy3iPn6ixovR3f2SrfE
         904WUgm09CXQg7un7nGOg7BrJVqqsGjxCDSX3qU2oSRZlf3l5CAvJfgJcsyXE0XSGB8L
         p8i2uBPYAS9lqczyc4ghr34vyo1C0zKwoyNMV0cct27vsr9L64KDoRcS9TuS8KqbUOMj
         +qBg==
X-Forwarded-Encrypted: i=1; AJvYcCXRE8CVY1CEbyVSxiXkXJsD5234f7TbVfRxHpDwK8jLLx3VVq0nzhVeurIDDDE6EHtIuoYu0xJjKPB/jIPz@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo0YTVpTH5qswKD5FxeiPPhKn6FWqt1A67fliCCXOzgl3/TRQb
	e71mEufRWlZ59vOqq0xfC5+L3fldMwfn2eo9ZIgdxwwWASMEGh3cLTTzAPUdN6ZXxVM=
X-Gm-Gg: AY/fxX7Xhf3VEdl/l4W2M34563avKfXIWRFE4zW0ph/QErDNdOD1Szk9syCrb93+fFt
	T6tmYLFDHNZU6vMzPqdUMN0Zewb5GGKGVcinODGSlBwyXXoUJaGV7VcazkiUTNt6SQVepxryt1i
	vexgOLcf2WJHshNox9ocCE+t7an5snOEZp82h0aspEUdKzhj2jy6P9zcVeGnjojC/v1KeMKCmZZ
	vu5hW2VEQtsqVlC9s6XtEHaV/tfD+Zk8ySAdSydGMtpHbP83Af61hEkB8NZ/6toL13FQYTlaXPr
	VPOO4wfGnt67950JYtG+JZyvSwHdMEKro13KZK1CWe6vJKzZqis4oiF/ZREvrpTmthbzC0fhbe/
	cLe6cSgdjtLqws2eisa+F5SBJBNHbGJyHmpLDzgMT97J54FaFadXJdFl/DjWMG38AwOzpJXTtj1
	DzpLfBiNTYZG0G+iFadEPIuL2z/tv9oBfZ9gaG1vob
X-Google-Smtp-Source: AGHT+IF6FoYEiOVVDWUPpLU3jDJvqNCzpKzqnbeVvQnDEvwsoJDLeiTjGFb0z18Vy2LTN2AqGWN2Hw==
X-Received: by 2002:a17:902:da82:b0:298:595d:3d3a with SMTP id d9443c01a7336-29ec27d74f8mr6124455ad.50.1765330313644;
        Tue, 09 Dec 2025 17:31:53 -0800 (PST)
Received: from [172.21.1.37] (fs76eed293.tkyc007.ap.nuro.jp. [118.238.210.147])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29dae99ea20sm163067015ad.49.2025.12.09.17.31.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Dec 2025 17:31:53 -0800 (PST)
Message-ID: <3c535b4d-6eaa-4c33-83fd-8cce3f62c020@kernel.dk>
Date: Tue, 9 Dec 2025 18:31:49 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 00/18] io_uring, struct filename and audit
To: Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Cc: torvalds@linux-foundation.org, brauner@kernel.org, jack@suse.cz,
 mjguzik@gmail.com, paul@paul-moore.com, audit@vger.kernel.org,
 io-uring@vger.kernel.org
References: <20251129170142.150639-1-viro@zeniv.linux.org.uk>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20251129170142.150639-1-viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/29/25 10:01 AM, Al Viro wrote:
> Changes compared to v1:
> 	* putname_to_delayed(): new primitive, hopefully solving the
> io_openat2() breakage spotted by Jens
> 	* Linus' suggestion re saner allocation for struct filename
> implemented and carved up [##11--15]
> 
> It's obviously doing to slip to the next cycle at this point - I'm not
> proposing to merge it in the coming window.
> 
> Please, review.  Branch in
> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git #work.filename-refcnt
> individual patches in followups.

Sorry slow to look at this - from the io_uring POV, this looks good to
me.

-- 
Jens Axboe


