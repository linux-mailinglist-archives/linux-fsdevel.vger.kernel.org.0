Return-Path: <linux-fsdevel+bounces-24411-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94DC893F0D0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 11:19:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C48961C21FCF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 09:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69F15140369;
	Mon, 29 Jul 2024 09:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="Px/GhlI1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B9913DDCE
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jul 2024 09:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722244738; cv=none; b=TSGQ86QVH/nSfGNV/AD3YLeRhjEVgcvP7w1dMmdqI6VqQLmCOxV7O/9Y69q2e1YyJnV7t2SAWVC8Hj4IGhc8bQcmrYBVHJEaYbSi6wYT+f9nmzJ8wSoQBjpJJTvtL6uypHtzcvmCYI/YBsrbhU2qIClf8nGRe3lp7uDDLq6Im88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722244738; c=relaxed/simple;
	bh=5r3fxAG4g4laolpFoGhmEDZc6wbbuEOFScedWUPcaP8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UxQHHPjBkfoGspIY3VMNAhU/MbYUDH6Rqb4OlnyyaVSLFkEYqc585kX3rebD5oNexrjfTwAngM9rD7n2AJOoq6cPs0Yu/G5kak+3G8Gh3ARWT3xdIfP7wDCl6G5eGfHzpVIoEEU6fwf0ny+lNvQUZ5ZK2aHn/W20QCn2kE1KPbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=Px/GhlI1; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7a1be7b7bb5so2200697a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jul 2024 02:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1722244737; x=1722849537; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PdAE/yK+gUuSfcs5gVxoPZ6y5I3vp0voLS2APYoe664=;
        b=Px/GhlI1LkZkCzb2wVr9ShJdWR3OG1GFbrZUpz/LtWv1ytErZeH/b3uxsFrBjk5bKo
         KQSFmcWO7mvqQ2105L6KsYGJ7gwocq3TAvUz7qLryn263NO/L0CVNm+91zhmHzq8yzsZ
         MgDfc2bP3bjj2yYV65YGiqInIUC+epUi8DeaUZSHM6d41KlMYfDwCcMD+TkMZnreXj1g
         r6k353UoN9Pb8q5/EtLQUudBx5k9vQNX7AQe9sAvvjnnR81Lj4rvf2uAyypaCzYCku6v
         LYoAhj2tB6/9hHaBws+lKolZgSsIJ9FeNwR6qbFpe4ywCQdVZPjBE+YI1Tq4Pvfk0du1
         7sNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722244737; x=1722849537;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PdAE/yK+gUuSfcs5gVxoPZ6y5I3vp0voLS2APYoe664=;
        b=rmT7R76yDUI0LDKZ61U+OSjYkLVmF5HChVIYPbjd20xIaBAQs18z0VPhqfHXpTxDE/
         tcMUM9V7Y4/o102m383afCspfno+dIu6hV5ufFMSj5Qy4WkRwYBWOABdDAQAIkl9vnuL
         Q+y4iDgeE3jQjq5rq9Wk0EosfA3wb3rdEQApioB9xqKU3mzjkHg8x6pUnGA4ltgdSDza
         XVUxCoAVNCLlKWgdzbO4ZeWLxNT+8rIR44zuuE7Oz/eQ7PdSPDioNA1I5WbwBduLi0iP
         5gksJx65i9JIktHf1u8M0V8S+BDsafuEloSI5WeaJs0WRIzov592ycajoqSkGhFqo194
         VtRw==
X-Forwarded-Encrypted: i=1; AJvYcCVWPflW13i7OzBbnaYvmX9Hb66vN/B4SFNwJpaEPlL2z2GIfkhSAEwGrGtJGIEiOWa/+RzZWw0Ys3PFV8BCi8g2GwgRjHh0mwcqGWaitA==
X-Gm-Message-State: AOJu0YzwLpzTZ1xk9hWyw1vpZigHKc0x9S1G8jMBd6rPmNN3Cpz0uxwo
	rMhQGr4easgLKkyJaJhN/Fw1kCFXdpRoOCrNntlNBsovwLuWZyydQSDBYJ+8HPo=
X-Google-Smtp-Source: AGHT+IHTPQXzqz24j+2hKrgTp3s9jmn+bgbEWhbJcYhBdSFvLyYV1tgPzryl34QRsdT5NH4pnTBHvA==
X-Received: by 2002:a05:6a20:2589:b0:1c4:88ce:c996 with SMTP id adf61e73a8af0-1c4a14e6af1mr9573959637.46.1722244736766;
        Mon, 29 Jul 2024 02:18:56 -0700 (PDT)
Received: from [10.54.24.59] ([143.92.118.3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7ee2f21sm78016425ad.154.2024.07.29.02.18.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jul 2024 02:18:56 -0700 (PDT)
Message-ID: <80b9a201-3417-4532-a695-98bf5313e52c@shopee.com>
Date: Mon, 29 Jul 2024 17:18:51 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs/writeback: fix kernel-doc warnings
To: Christian Brauner <brauner@kernel.org>
Cc: jack@suse.cz, axboe@kernel.dk, tj@kernel.org, viro@zeniv.linux.org.uk,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel test robot <lkp@intel.com>
References: <20240729020606.332894-1-haifeng.xu@shopee.com>
 <20240729-endabrechnung-proletarisch-4843dd0ea1bd@brauner>
From: Haifeng Xu <haifeng.xu@shopee.com>
In-Reply-To: <20240729-endabrechnung-proletarisch-4843dd0ea1bd@brauner>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024/7/29 17:12, Christian Brauner wrote:
> On Mon, Jul 29, 2024 at 10:06:06AM GMT, Haifeng Xu wrote:
>> The kernel test robot reported kernel-doc warnings here:
>>
>>     fs/fs-writeback.c:1144: warning: Function parameter or struct member 'sb' not described in 'cgroup_writeback_umount'
>>
>> cgroup_writeback_umount() is missing an argument description, fix it.
>>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Closes: https://urldefense.proofpoint.com/v2/url?u=https-3A__lore.kernel.org_oe-2Dkbuild-2Dall_202407261749.LkRbgZxK-2Dlkp-40intel.com_&d=DwIBaQ&c=R1GFtfTqKXCFH-lgEPXWwic6stQkW4U7uVq33mt-crw&r=3uoFsejk1jN2oga47MZfph01lLGODc93n4Zqe7b0NRk&m=3sAi8IhB62KzbeV_8pr_6us5hrO-Gga06if2AaD4IQo4VIdWPC-0PKIGoZBqxcE1&s=8yhRcJ4dpQqgNctjFIIXg2P-2gJxFL66FZoYu5O90ho&e= 
>> Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
>> ---
> 
> Unfortunately I had already fixed that before applying. Thanks though!

OK, Thanks!

