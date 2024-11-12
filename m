Return-Path: <linux-fsdevel+bounces-34478-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE1979C5CEA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 17:12:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90BE31F22443
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 16:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E9E206E9D;
	Tue, 12 Nov 2024 16:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XlwjKtOk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFCF3206E73;
	Tue, 12 Nov 2024 16:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731427739; cv=none; b=q95qdAO5cCbXXyUCZqv0EvfMjtYiRb16O8IG6TOdLFYJUKhZH8xZAuiRWvSAFMbjFx223UwSgHtAViOfLVEomhlT6EAQgW2nhKZGDChBfzhYjNH6dRlkeTjyyLWPDWusY0XL82uG69AYEVhQU6yq40a9lVa0XPzvs4sce5EO90M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731427739; c=relaxed/simple;
	bh=8C3CVtNfnEnzT7Ndmzb3yO0t+FQE1lxuroAJZSf5NQ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qkx5oq5uA4JSM8sUmYZa0sPIaI2STnA5FQH8cQTpygoaN9qatqOBMmTnGSa5kocozazPkiMdpjYtQAKmuowYnIP14gAEsfzSlA8AIhQL6bPnNGa5x2huVzHhIR786W9KBWUSoCYQt2FHB8Rx9JdhQSOKgiwxrjEqG7KNuzjkUiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XlwjKtOk; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a9e44654ae3so818188866b.1;
        Tue, 12 Nov 2024 08:08:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731427736; x=1732032536; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=G10/loqilAuJYK1DkgBbM09nZs/X5OwtuuVl876QosU=;
        b=XlwjKtOkSFJy5BGZ5rn1wFB2k0Hb8Dp+hPsfGW/PeKwBwKu5kKpEd3xwgpUgW2dIxB
         H1D4f2dY6K/Rm9XisQKobDsNm0rrGTUqiS39sCU/M2IAWL6jyu3OspabtNiTwRk4f7Gq
         5D1BrZNZK3ozwHFl1n/y7O6zs9PH4qROhAQ88FLMQYP8Sqxh/moCPAkr8A1B5xBFyCny
         ZtXPhc3gDNFmRpmkUbGCxs1h2qsMTCDNErBHSPOMW3XMN9rjoDEZi83N//aWHof+w+M8
         0n2s2aXjY/EtY6qw3NszWtMccUJiAuR55qK4ZSq1JaBpLZ3BF5jGU18katlFJB6HaKNe
         OiiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731427736; x=1732032536;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G10/loqilAuJYK1DkgBbM09nZs/X5OwtuuVl876QosU=;
        b=M+X7gX6eMU9Shk8BMl3WF3F04xfpFZqlBhyKoBpW6a5Up3taCMq9u77XvYRzOvdADI
         wD2+9H2EWiig78OMKS7JO7k2s1CKTsqrFcVDth7f3ZDaUDo4QcO3OdrkPUFKdq1W+8cQ
         pvzPYAZoxcpYm0aajK69yBQtmOhc3DAauk7oYI78WNnJHhBxyGBjtfIHO8x+WPFHi2dK
         mV+6I1IaH2bJQP+Qg1xJu1CLs+qwfYJ8D07gVKQJh7ZNUUiN1S01KBdcpIqnQucUIPks
         AkTUMo1Ur9f1Q7OV9UplcO1Wku2GAFxvaZui/qIv+6WXH28ap1eXynfLq1ghXg9SWATO
         FhEA==
X-Forwarded-Encrypted: i=1; AJvYcCXqW0D9+siJwrA130u4Q+5ssKFE5uUq2y70r/tO9OiSZRaZF6Zs6egyIq/mMnBSwjyDSMSQK/m1jUtC6GM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF8iLjj9AZWfmQMZakNzX67XqBis9+chNKppH3w2s7HXcrJ+IB
	qCXO/WkJY7+Z0Guw9m8cG5qbys3o+V3R0WLG1D9ueZpMHBkDV6Y+
X-Google-Smtp-Source: AGHT+IGjJSvMLx+mb3xEoQ1hZbwlv08MS7r0tHPJzDypU+BGGTi9hnrpOl8XKCTi6W0b8/v+b/gOvQ==
X-Received: by 2002:a17:907:9611:b0:a9e:e1a9:8df0 with SMTP id a640c23a62f3a-a9eeff38a2bmr1773316166b.29.1731427735696;
        Tue, 12 Nov 2024 08:08:55 -0800 (PST)
Received: from ?IPV6:2a01:e11:5400:7400:e8e2:26d3:e800:6066? ([2a01:e11:5400:7400:e8e2:26d3:e800:6066])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa1dda672easm106884266b.40.2024.11.12.08.08.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2024 08:08:54 -0800 (PST)
Message-ID: <f1c3998e-1eaf-465c-9708-bae30d9832cd@gmail.com>
Date: Tue, 12 Nov 2024 17:08:53 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hfs: use kzalloc in hfs_find_init() to fix KMSAN bug
To: brauner@kernel.org, josef@toxicpanda.com, akpm@linux-foundation.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 skhan@linuxfoundation.org,
 syzbot+2e6fb1f89ce5e13cd02d@syzkaller.appspotmail.com
References: <20241022225732.1614156-2-gianf.trad@gmail.com>
From: Gianfranco Trad <gianf.trad@gmail.com>
Content-Language: en-US, it
Autocrypt: addr=gianf.trad@gmail.com; keydata=
 xjMEZyAY2RYJKwYBBAHaRw8BAQdA3W2zVEPRi03dmb95c7NkmFyBZi+VAplZZX9YVcsduG3N
 JkdpYW5mcmFuY28gVHJhZCA8Z2lhbmYudHJhZEBnbWFpbC5jb20+wo8EExYIADcWIQRJFQhW
 JFLZFapGQPDIleIjeBnIywUCZyAY2QUJA8JnAAIbAwQLCQgHBRUICQoLBRYCAwEAAAoJEMiV
 4iN4GcjL+JkA/RWGFWAqY06TH+ZZKuhNhvJhj2+dqgPF0QRjILpGSVJyAQCsvpKVS6H9ykYP
 Qyi/UyxIKxa8tcdSP1oUj9YIAHUcC844BGcgGNkSCisGAQQBl1UBBQEBB0BlosN6xF2pP/d7
 RVTlTFktASXfYhN0cghGG6dk5r47NgMBCAfCfgQYFggAJhYhBEkVCFYkUtkVqkZA8MiV4iN4
 GcjLBQJnIBjZBQkDwmcAAhsMAAoJEMiV4iN4GcjLuIIBAJBEkfB4sVF7T46JBpJBP5jBHm4B
 nmn274Qd7agQUZR4AQDfkC/p4qApuqZvZ3H0qOkexpf9swGV1UtmmzYQdmjyAw==
In-Reply-To: <20241022225732.1614156-2-gianf.trad@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23/10/24 00:57, Gianfranco Trad wrote:
> Syzbot reports KMSAN uninit-value use in hfs_free_fork [1].
> Use kzalloc() instead of kmalloc() to zero-init fd->search_key
> in hfs_find_init() in order to mitigate such KMSAN bug.
> 
> [1] https://syzkaller.appspot.com/bug?extid=2e6fb1f89ce5e13cd02d
> 
> Reported-by: syzbot+2e6fb1f89ce5e13cd02d@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=2e6fb1f89ce5e13cd02d
> Tested-by: syzbot+2e6fb1f89ce5e13cd02d@syzkaller.appspotmail.com
> Signed-off-by: Gianfranco Trad <gianf.trad@gmail.com>
> ---
> 
> Notes: since there's no maintainer for hfs I included Andrew as stated
> in the Documentation. I also considered to include the top 2 commiters
> to hfs subsytem given by scripts/get_maintainers.pl. Hope it's not a
> problem, if so apologies.
> 
>   fs/hfs/bfind.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/hfs/bfind.c b/fs/hfs/bfind.c
> index ef9498a6e88a..c74d864bc29e 100644
> --- a/fs/hfs/bfind.c
> +++ b/fs/hfs/bfind.c
> @@ -18,7 +18,7 @@ int hfs_find_init(struct hfs_btree *tree, struct hfs_find_data *fd)
>   
>   	fd->tree = tree;
>   	fd->bnode = NULL;
> -	ptr = kmalloc(tree->max_key_len * 2 + 4, GFP_KERNEL);
> +	ptr = kzalloc(tree->max_key_len * 2 + 4, GFP_KERNEL);
>   	if (!ptr)
>   		return -ENOMEM;
>   	fd->search_key = ptr;

I ensured syzbot reproducer still triggers KMSAN bug upstream[1].
I ensured that the above patch was tested by syzbot upstream, not 
triggering any issue[2].

I know hfs is orphaned, but if anyone can pick it up or review it for 
additional feedback I'd highly appreciate it, as it addresses bug in 
stable releases.

Thanks for your time,

[1] https://syzkaller.appspot.com/x/log.txt?x=12cd38c0580000
[2] https://syzkaller.appspot.com/x/log.txt?x=136874e8580000

--Gian

