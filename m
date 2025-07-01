Return-Path: <linux-fsdevel+bounces-53561-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 977ABAF022D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 19:48:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E625B3B7AAD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 17:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACC3927F166;
	Tue,  1 Jul 2025 17:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="bHfEA+49"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C862027C172
	for <linux-fsdevel@vger.kernel.org>; Tue,  1 Jul 2025 17:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751392094; cv=none; b=rHKZlpYayhTuuDD+Wz81eVwQKFnxgx2kvA9UPYnGdohEjZdj+ab7S9KHI5oqUa1uZRTHPizhj2xpTrN3CQohxhEdPuL/mQ1vCWGCqJ+/FMZ6xoSqm58eHkZP/Uhx2cYB6KUHdGTRIChomUveigXHntIuGFXlqGnHAEmlfRO0wCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751392094; c=relaxed/simple;
	bh=DdPSe17PXLm89iLTi9/3SdUFAFpkAnoMoYtcRxMoWac=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nUXWbocTJ7H20rED+ufpCgVN9d1HCdlT1Zm+U766FZM8f0bpE4EuCLG8upAZWytaBqcYQx9UyAc21McWQTc+iU/UkxBFHGB/ofbi9MKOA+Fji3yzcdw+xx71nw0PUPt74UkH54Hhsuh9m9AGySdcwkqoFOvVpSSK//lFwdr2s1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=bHfEA+49; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-237311f5a54so32069255ad.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Jul 2025 10:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1751392092; x=1751996892; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vUhE2HsdzOvsmAbckD0m6jjvbpj7XyX/x02FlZZbqvI=;
        b=bHfEA+49laj5lTnWOK2tZmw5Ao9VhSSeytp6BS85BXojzV9W8b3wFUF0hKzKDK6ZR/
         h0imx0WxywPJ29cLzYZBc96XwR6oxhDOGy/6aI+trVhRngf4QVsTava2SI++0pVMVDal
         GAsSmjVnoF51R9sm1k6buulMH2fWtqDciLCQo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751392092; x=1751996892;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vUhE2HsdzOvsmAbckD0m6jjvbpj7XyX/x02FlZZbqvI=;
        b=EC+2Vl/5NYAegdZ+mrk8i5MzJUHcIcAn94mlXmZ2jYl5QPb/hIerVpeYN3KRX36TtU
         x5uOr+8D1X0NCsMkkPlUo//D6JD+lHxumpvtni09wqvoAxfYG4bATBupiAYidIghXWiQ
         opwl3eDjgBe34AP7tVyH8Wvs2nz4UWpwn9oFjupWjSEye7HU51/8m6zacvM6SmygWoDp
         CsA3arQZOzNGj8UeHFx7Ox7MLuZmqNKyjIE27wi6YOLCoenGOJ9FAEVu179MyjUHh6ws
         C8vIiMEQcCRo6iEugq3kzQLIWIe49bngRSlbRMSVtHAptFEc8Xq/Mjb4MA1qy/U0sosU
         +yNw==
X-Forwarded-Encrypted: i=1; AJvYcCV5YIwEBqu4Vv+DpCZzG6WpaOaCTn3lIK0Uw9id/qlF7G31nCgElVXzjGr/KAx0UnZEFuHZcyG58b2YCJGF@vger.kernel.org
X-Gm-Message-State: AOJu0YwCc+a3rRSXC71SzOK6jPl6zkfejN9T+rgEQvsCALFqJPz3ODnC
	JzXMpI2i/0QC8uToDXDnqVcxiv8znycPmzwKzBl+pLk3K2tX2ym9fSC0dpKClxP5BA==
X-Gm-Gg: ASbGncut0xG2K6XaoESMMPIEkLQ+cZOMvqHpGH6e5QZmc44mZcIdbpI9Ac1H0YZ1jB7
	uG3U3M4fbvloOKJGmc3cA6OxL95qZNa7ptK3cChVWiFJyG5o42UFaRZgeLEx9YlIGB68Zrxw4Rb
	tMWCukMniFJuxk5/HmSft9kSxuq1vmuC4xZf8gsPValND6b6wcuzE7rbZ3P887loaTrUl5Lslv7
	UJPoNhhwkyrqf/0UotMbV/UGejz83TdUynShz5ydcv4p73xc/Ld25xi/8m7asv1zydddfeetH03
	RWAiYPx68jdO7FAny5sTEeTKxCkfhDvfBsQzPxxGInsMBTxm7XxUALHB5lytWeQC6uYN9eG86kh
	bzCUmCySYsfUmQKBJDe2ccjDDIg==
X-Google-Smtp-Source: AGHT+IHvR0U8+cGJ1i+JMqhfCC+79DQTCIeN7N8kWS5OV7xEczKqikosjahYyJH2OcxGmgW4+yB+Hg==
X-Received: by 2002:a17:902:ce87:b0:235:eb8d:800b with SMTP id d9443c01a7336-23ac45e2232mr306750965ad.26.1751392092085;
        Tue, 01 Jul 2025 10:48:12 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb39f4c0sm109277495ad.103.2025.07.01.10.48.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jul 2025 10:48:11 -0700 (PDT)
Message-ID: <a5be20ce-ec88-4ddc-96d2-21c6ace682e6@broadcom.com>
Date: Tue, 1 Jul 2025 10:48:10 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scripts: gdb: vfs: Support external dentry names
To: Illia Ostapyshyn <illia@yshyn.com>, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Kieran Bingham
 <kbingham@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
 Andrew Morton <akpm@linux-foundation.org>, Jan Kara <jack@suse.cz>,
 Christian Brauner <brauner@kernel.org>
References: <20250629003811.2420418-1-illia@yshyn.com>
Content-Language: en-US
From: Florian Fainelli <florian.fainelli@broadcom.com>
Autocrypt: addr=florian.fainelli@broadcom.com; keydata=
 xsBNBFPAG8ABCAC3EO02urEwipgbUNJ1r6oI2Vr/+uE389lSEShN2PmL3MVnzhViSAtrYxeT
 M0Txqn1tOWoIc4QUl6Ggqf5KP6FoRkCrgMMTnUAINsINYXK+3OLe7HjP10h2jDRX4Ajs4Ghs
 JrZOBru6rH0YrgAhr6O5gG7NE1jhly+EsOa2MpwOiXO4DE/YKZGuVe6Bh87WqmILs9KvnNrQ
 PcycQnYKTVpqE95d4M824M5cuRB6D1GrYovCsjA9uxo22kPdOoQRAu5gBBn3AdtALFyQj9DQ
 KQuc39/i/Kt6XLZ/RsBc6qLs+p+JnEuPJngTSfWvzGjpx0nkwCMi4yBb+xk7Hki4kEslABEB
 AAHNMEZsb3JpYW4gRmFpbmVsbGkgPGZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tPsLB
 IQQQAQgAywUCZWl41AUJI+Jo+hcKAAG/SMv+fS3xUQWa0NryPuoRGjsA3SAUAAAAAAAWAAFr
 ZXktdXNhZ2UtbWFza0BwZ3AuY29tjDAUgAAAAAAgAAdwcmVmZXJyZWQtZW1haWwtZW5jb2Rp
 bmdAcGdwLmNvbXBncG1pbWUICwkIBwMCAQoFF4AAAAAZGGxkYXA6Ly9rZXlzLmJyb2FkY29t
 Lm5ldAUbAwAAAAMWAgEFHgEAAAAEFQgJChYhBNXZKpfnkVze1+R8aIExtcQpvGagAAoJEIEx
 tcQpvGagWPEH/2l0DNr9QkTwJUxOoP9wgHfmVhqc0ZlDsBFv91I3BbhGKI5UATbipKNqG13Z
 TsBrJHcrnCqnTRS+8n9/myOF0ng2A4YT0EJnayzHugXm+hrkO5O9UEPJ8a+0553VqyoFhHqA
 zjxj8fUu1px5cbb4R9G4UAySqyeLLeqnYLCKb4+GklGSBGsLMYvLmIDNYlkhMdnnzsSUAS61
 WJYW6jjnzMwuKJ0ZHv7xZvSHyhIsFRiYiEs44kiYjbUUMcXor/uLEuTIazGrE3MahuGdjpT2
 IOjoMiTsbMc0yfhHp6G/2E769oDXMVxCCbMVpA+LUtVIQEA+8Zr6mX0Yk4nDS7OiBlvOwE0E
 U8AbwQEIAKxr71oqe+0+MYCc7WafWEcpQHFUwvYLcdBoOnmJPxDwDRpvU5LhqSPvk/yJdh9k
 4xUDQu3rm1qIW2I9Puk5n/Jz/lZsqGw8T13DKyu8eMcvaA/irm9lX9El27DPHy/0qsxmxVmU
 pu9y9S+BmaMb2CM9IuyxMWEl9ruWFS2jAWh/R8CrdnL6+zLk60R7XGzmSJqF09vYNlJ6Bdbs
 MWDXkYWWP5Ub1ZJGNJQ4qT7g8IN0qXxzLQsmz6tbgLMEHYBGx80bBF8AkdThd6SLhreCN7Uh
 IR/5NXGqotAZao2xlDpJLuOMQtoH9WVNuuxQQZHVd8if+yp6yRJ5DAmIUt5CCPcAEQEAAcLB
 gQQYAQIBKwUCU8AbwgUbDAAAAMBdIAQZAQgABgUCU8AbwQAKCRCTYAaomC8PVQ0VCACWk3n+
 obFABEp5Rg6Qvspi9kWXcwCcfZV41OIYWhXMoc57ssjCand5noZi8bKg0bxw4qsg+9cNgZ3P
 N/DFWcNKcAT3Z2/4fTnJqdJS//YcEhlr8uGs+ZWFcqAPbteFCM4dGDRruo69IrHfyyQGx16s
 CcFlrN8vD066RKevFepb/ml7eYEdN5SRALyEdQMKeCSf3mectdoECEqdF/MWpfWIYQ1hEfdm
 C2Kztm+h3Nkt9ZQLqc3wsPJZmbD9T0c9Rphfypgw/SfTf2/CHoYVkKqwUIzI59itl5Lze+R5
 wDByhWHx2Ud2R7SudmT9XK1e0x7W7a5z11Q6vrzuED5nQvkhAAoJEIExtcQpvGagugcIAJd5
 EYe6KM6Y6RvI6TvHp+QgbU5dxvjqSiSvam0Ms3QrLidCtantcGT2Wz/2PlbZqkoJxMQc40rb
 fXa4xQSvJYj0GWpadrDJUvUu3LEsunDCxdWrmbmwGRKqZraV2oG7YEddmDqOe0Xm/NxeSobc
 MIlnaE6V0U8f5zNHB7Y46yJjjYT/Ds1TJo3pvwevDWPvv6rdBeV07D9s43frUS6xYd1uFxHC
 7dZYWJjZmyUf5evr1W1gCgwLXG0PEi9n3qmz1lelQ8lSocmvxBKtMbX/OKhAfuP/iIwnTsww
 95A2SaPiQZA51NywV8OFgsN0ITl2PlZ4Tp9hHERDe6nQCsNI/Us=
In-Reply-To: <20250629003811.2420418-1-illia@yshyn.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/28/25 17:38, Illia Ostapyshyn wrote:
> d_shortname of struct dentry only reserves D_NAME_INLINE_LEN characters
> and contains garbage for longer names.  Use d_name instead, which always
> references the valid name.
> 
> Link: https://lore.kernel.org/all/20250525213709.878287-2-illia@yshyn.com/
> Fixes: 79300ac805b672a84b64 ("scripts/gdb: fix dentry_name() lookup")
> Signed-off-by: Illia Ostapyshyn <illia@yshyn.com>

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>

Thanks Illia!
-- 
Florian

