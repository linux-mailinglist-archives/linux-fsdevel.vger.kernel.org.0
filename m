Return-Path: <linux-fsdevel+bounces-31965-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8030999E7C9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 13:58:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F57C1F23495
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 11:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 556791E766C;
	Tue, 15 Oct 2024 11:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BI+7WdpH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181B41E6339;
	Tue, 15 Oct 2024 11:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728993475; cv=none; b=iRX3CJu0Pxt/I74BrWovmlYOuDWBafcZIaGfTMzPdvpghEYaR2UxdZPcnBGZQ11mVBy9njf03R95VvS8EYkmQvaCSaabbxQQFicPDX/PhoImk5ZdfVR79VEj+ps0xAJ6idiYAHm/v1d+gv/Vrqn/suhZJU9pAWseKo1PbgDL98U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728993475; c=relaxed/simple;
	bh=og7fTE1d8NsHVgj1tMmLOC1ZMPfJ/PL3G72GW+EOOdc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=sE9FwK4Eqx/9XaRI1/AixVWfkGybkx2hw/YGa2xNR5HjqQOHOMgEp1FLDwCWvl0R/l9PUZqVS5P9HadTnx0G1rpcP7Zh66KjeVhWXV+NCSLHT4O2J0PKo7guW6W470sw+mbAHS9W3yV59jAiVTfzJ1YM+od72RQ1cTcgPmeqd28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BI+7WdpH; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5c9454f3bfaso5646168a12.2;
        Tue, 15 Oct 2024 04:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728993472; x=1729598272; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZdiZfnvhG5YsMD0eaXsVxZWVn5zxKhg6IVuE5un0X8E=;
        b=BI+7WdpHyzhpn+E/BWuFAA7Rb2O3dAiLDSjKGw1yKAozAObxsMeaIzUfcO7k30xIX9
         Sc5Yd/z4ThcUBM/DOsfXxtDi0XNk/4jwmTd0TzcG940us3/3oPJbnvuasEF0W7kf1I8w
         dM5fkCdc1IfRXuMiKw1htiP/TWkhjl0Qay4Kx+phxqh/aLZrcSa6FmKSndDz059jv6Lb
         dqP9AYKOJ267zgnJU+Smxn7btmxSD1mQr1ZzY1YmdBngqmehjRj6Z4Jor66pek/85UxN
         v3vGlBkLE011/DQa0jrZQp3TR7IIuYh9KUIMvK6rOCw+zlFCZp0P738tSozVKollNCMG
         gbZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728993472; x=1729598272;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZdiZfnvhG5YsMD0eaXsVxZWVn5zxKhg6IVuE5un0X8E=;
        b=pcExUL9C0aIGSFT3dwXfAZimcMi8aO02Xc/alqnxGDro0TNLm5OPm3j96br5WEI7S4
         ldFmG/hFt9IzH0FX4TcJYbaBvVi4RmlDwoMAZXI45zntACRuvzOBZkKPuM5i2Gr/v74p
         XmgxE5sqedxXCGchRT4w2uGborM2LISWiaUNnkPc1tIvoekEoffD4debQe+pnlMtoDv+
         2SBSy8N/hFx5Yr7oDoB6AtErIFG+gPBj1LMbaPRx9d+vgB5/SPuzw0DkOOSyHoiKmV7s
         43Dd18sZcQkRAFAk9HWGKt2SXKjS1ba6J59ooysgjx2Iumo74LbYloowSoUmbh++KjoG
         oB4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXQc6JIvzEKmdGRy8NML7dFURIbzqPjZkatzDdbhC478aMV6HAvsnBmRXUVoTQ1pYLyUSZJ1AqUYwwGdSvz@vger.kernel.org, AJvYcCXsddwa9ZXAd1FQ5ckIe+wM/5MEqjsRSeaa8leYG79w5ElztFAH0JES6DfaRSe7VugkiMOZ4qsRPZhjT5y/@vger.kernel.org
X-Gm-Message-State: AOJu0YxUCg2nvq7pGq+DFu/1KDaQZMrYtvPaDE/OUX8Sro9JIwIF+sZ5
	hwS9BoMEAC8fd8G23HT579cPAZOhdUyP3z+8l9WAU+ycBK8sG4/H
X-Google-Smtp-Source: AGHT+IE7aQ12blyPbk3gKJQP1ZO2wA/0lbJ9xXyHgPphIpxaYqg6nyZBIGmlSM4oQ1yLDDxqbJAiPg==
X-Received: by 2002:a05:6402:2753:b0:5c9:4c7a:b001 with SMTP id 4fb4d7f45d1cf-5c95ac60455mr8278461a12.30.1728993472057;
        Tue, 15 Oct 2024 04:57:52 -0700 (PDT)
Received: from ?IPV6:2a01:e11:5400:7400:5411:6fe9:5d33:c711? ([2a01:e11:5400:7400:5411:6fe9:5d33:c711])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c98d778b80sm613820a12.78.2024.10.15.04.57.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2024 04:57:51 -0700 (PDT)
Message-ID: <8bb6722b-52d8-4585-8377-194c241462f1@gmail.com>
Date: Tue, 15 Oct 2024 13:57:50 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm: fix null pointer dereference in read_cache_folio
From: Gianfranco Trad <gianf.trad@gmail.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, skhan@linuxfoundation.org,
 syzbot+4089e577072948ac5531@syzkaller.appspotmail.com
References: <20240929230548.370027-3-gianf.trad@gmail.com>
 <20240930090225.28517-2-gianf.trad@gmail.com>
 <ZvrqotTfw06vAK9Y@casper.infradead.org>
 <991c8404-1c1c-47c7-ab27-2117d134b59b@gmail.com>
Content-Language: en-US, it
In-Reply-To: <991c8404-1c1c-47c7-ab27-2117d134b59b@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 04/10/24 14:07, Gianfranco Trad wrote:
> On 30/09/24 20:14, Matthew Wilcox wrote:
>> On Mon, Sep 30, 2024 at 11:02:26AM +0200, Gianfranco Trad wrote:
>>> @@ -2360,6 +2360,8 @@ static int filemap_read_folio(struct file 
>>> *file, filler_t filler,
>>>       /* Start the actual read. The read will unlock the page. */
>>>       if (unlikely(workingset))
>>>           psi_memstall_enter(&pflags);
>>> +    if (!filler)
>>> +        return -EIO;
>>
>> This is definitely wrong because you enter memstall, but do not exit it.
> 
> Got it, thanks.
> 
>>
>> As Andrew says, the underlying problem is that the filesystem does not
>> implement ->read_folio.  Which filesystem is this?
> 
> Reproducer via procfs accesses a bpf map backed by an anonymous
> inode (anon_inode_fs_type), with mapping->a_ops pointing to anon_aops,
> hence, read_folio() undefined.
> 
>>
>>>       error = filler(file, folio);
>>>       if (unlikely(workingset))
>>>           psi_memstall_leave(&pflags);
>>> -- 
>>> 2.43.0
>>>
> 
> I suppose the next step would be to contact the proper maintainers(?)
> If you have any additional suggestions, I'd be more than glad to listen.
> 
> Thanks to both of you for your time,
> 
> --Gian
> 

Hello,

While studying how to implement read_folio in anon_aops for this 
specific case (bpf map backed by anon_inode_fs_type) I've come up with 
an intermediate solution that mitigates the null pointer dereference and 
avoids the memstall issue (compared to my previous patch) immediately, 
for all filesystems that do not implement read_folio in their 
address_space_operations.

The patch [1] looks like this:

diff --git a/mm/filemap.c b/mm/filemap.c
index 4f3753f0a158..680d98086c00 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3775,6 +3775,8 @@ static struct folio *do_read_cache_folio(struct 
address_space *mapping,
  	struct folio *folio;
  	int err;

+	if (!filler && (!mapping->a_ops || !mapping->a_ops->read_folio))
+		return ERR_PTR(-ENOSYS);
  	if (!filler)
  		filler = mapping->a_ops->read_folio;
  repeat:

Patch was already tested with syzbot on the same reproducer case. 
Reproducer did not trigger any issue [2].

Let me know if for now this patch looks good enough, therefore I'll send 
it to you, or if I should work on it more.

Thanks for your time,

[1] https://syzkaller.appspot.com/text?tag=Patch&x=142e045f980000
[2] https://syzkaller.appspot.com/x/log.txt?x=1551045f980000

-- Gian



