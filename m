Return-Path: <linux-fsdevel+bounces-70580-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 85416C9FF7C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 03 Dec 2025 17:32:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7E2B43001967
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Dec 2025 16:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D804D36CE00;
	Wed,  3 Dec 2025 16:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="kTxOzvQF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B133A36CDE7
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Dec 2025 16:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764779528; cv=none; b=d/GL2RsC5Pr76ys0ob5ogafm2j5Lr2Uj9mEAUwrupuByduunhVhRpjcVb5nG2PZUub/LuY/kOxpswqhBHmptThNLSfvPiv0DslSsDIjoUlxaAU/tk8Y9xeKGGimLXeufABVmNFO9iRrWWfjSugCCzuZnZ4Aa44Z29qzXEA3z7Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764779528; c=relaxed/simple;
	bh=l0gnY/UzSbFUAuDU1KntIMiLjASuWWo0nEVW8bui9Tk=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=VPCe091ZKEQ0rFoSsd1kPGXozfNS9zyux9WNjlNptnIxKNK/xQSiN02qLuuWCuK5R5LTZIHBROpPwh2GVFSOjResTJUtsT+GWG1xJPBtwJClPiGIVxAgBcpWWjw3oCEP5hUjTPoq31lpXgUHK/d/wBksO6fZSPMAP7lTwa3I+7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=kTxOzvQF; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 36ADE401D3
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Dec 2025 16:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1764779484;
	bh=l0gnY/UzSbFUAuDU1KntIMiLjASuWWo0nEVW8bui9Tk=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type;
	b=kTxOzvQFwwFYahBIdvD+Q0qvBMRKooVbSEzIrDSyXsjQkiDbMfEgzbj+Rxi7qzl++
	 xF/Wwgk9KQee0ysVwVocI/GSM3WUsz49OKtsfE/lrt57IvQDjgLBNvnTGnpsYBEbIp
	 wOw3Hz3YdRNrLvNTnsrZv4SfeX7Iv845zLaRTRy9M32rN/AwmX63DwJVz3U/x/mH8Q
	 u32+jM7yWmESVEAErzupgYKp9rBPWKT021itDBARXMGaJvCHrNZfU2aTpRumLDYvCs
	 m1qEvW9eBCiECNJq6YiqjMmwqjPZt4qsjVpn7NVDopCvOkV0t0FwT2kQtzJzsAVtRX
	 Q5Fq6os9nM39CxdXxXL5W1QwrPwzn5CAp6d383j6ZJvNrhcuceCnTvh4LJmErcOnh1
	 6EGU7X6zBpYgPv9qkK0TaoeJCcnDnvXdrvF1XEacCVv0l+YmU4srBUDFvWYUghfd3J
	 Ukl71JUqpPq2aCcun0ujg9IGf9MHd0U0SDMARUs3gBBn4df87hSnd35X3D+7gq7VHf
	 Kp4ITOUFahfiCNSOTHivj/9twGRY9VYNv48hAKI7hely2r/Ql7TrjFn8mq1ADko22q
	 D1D4M7p5BNDOIspBJzOIhN1bGkrKfui59V8YZ8rv3feVbzdqVQf6nx0jzVwMiy4ouo
	 PPkiOJm+7TGV62FmfkacNBWI=
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4775e00b16fso45912755e9.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Dec 2025 08:31:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764779477; x=1765384277;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l0gnY/UzSbFUAuDU1KntIMiLjASuWWo0nEVW8bui9Tk=;
        b=WY79L1y0kzsQQQoqZWXHV6Z4MbI20YRcGYSXjP1K0YCv3LF81FdVeH0mQnFXHrbYgZ
         OxggPUlnHwIRnpgmQZUg/+0rAQbWHXBXFfUm86xohci3A0Vw9XNwkJvCmCAPMB14aw3v
         CTEqM7FZOpMc2zAVDjr5jnuR7TG39P4Hsb5GNybVJYZHEQatTG9RqR1Lwg5m0nOUi2EZ
         +zDJro+82cmPli7eRIV++q0a+cWOooq6XWHNfQUQ//2Tj/z7zO0VOFi5vLRYt+PrTGn1
         cVBSp5U6kPHzsb8AvQtUK4AJc7gCXToX+VkwPHQ2cESWgCeRyS0yp8ANz0I9DJamysqh
         UuZA==
X-Forwarded-Encrypted: i=1; AJvYcCWxiy3a5feawzZ3Vu4XyLPmvWO1sBoLm6Xjr7lSKSWpRAe28nrjQ1oN1fqKjU8xucV9WkGOkB3Wuo4RVxvh@vger.kernel.org
X-Gm-Message-State: AOJu0YzfzPT3m8L4rqtRQ5Arsdzg83jV4NA+SnoAjOyKcRyutKzNjPfw
	V5Jx+a6S6WVrmY2zUbHEvrRalTwHm/vgjKobLEkLm98PABKyAH3jp9DySjWd7hjl4QPyqwehZzh
	PSUxZp/IMSu7cOWmprDnsy+IghL0s7APIfmnNDCD24tS80g5dhfxoQbX7LSiO6qiH0+kfFSKEjQ
	OPEvOsSow=
X-Gm-Gg: ASbGncsgUcDkc4eJGR8UcxWICQf69f0XV42d+kX7duzywEviij9gV6R/vxZsW80HHzO
	B9eVJBUDBl7qyCKud7W5u5T5ZojGoGjt8rAQK7ep+tRxgyg8X4+fq+ZqVB6yljpTHhg0TMMtvCz
	gFecMSzTOD1afHT19vGAYPBZjf60Syri6KsQjoQd/K17PpTdE9Dw12CK8h3EuJM1t6QQfMeKSre
	qO8isQUADlIwuz8L12XYkRT+c4y7Ch/52d4WpaIkvTmbE7Oudtsh3R9xNmmMgDQm7h1chnynrqC
	8kW56O+OeZy8peGfbY1Gp+J2xXxMr+D0ZpWypNxmHl4xIJVck6itbpCeiwM/WWrveJAiV/0CxvN
	5Qk22gzra1voUG9LxG4VuwUeIfUToG0yppFNdOg0V+Hx6aA3IQwYXk15hVEtv6SkFJ6OimEqaY1
	A=
X-Received: by 2002:a05:600c:a41:b0:46e:74cc:42b8 with SMTP id 5b1f17b1804b1-4792af327dfmr27911685e9.17.1764779476163;
        Wed, 03 Dec 2025 08:31:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHCKejq/2U+1EN5UAB8CezRHOHJDvwMZzcFVGMZ1T1ZB5XD8pg1afh59Y/Z4iwxgxyD87hFlQ==
X-Received: by 2002:a05:600c:a41:b0:46e:74cc:42b8 with SMTP id 5b1f17b1804b1-4792af327dfmr27910815e9.17.1764779475621;
        Wed, 03 Dec 2025 08:31:15 -0800 (PST)
Received: from [10.1.1.222] (atoulon-257-1-167-49.w83-113.abo.wanadoo.fr. [83.113.30.49])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42e1c5c30c4sm40900310f8f.9.2025.12.03.08.31.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Dec 2025 08:31:15 -0800 (PST)
Message-ID: <6b25515b-c364-47f1-bd75-8b7dc16e3701@canonical.com>
Date: Wed, 3 Dec 2025 17:31:13 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: devnull+debug.rivosinc.com@kernel.org
Cc: Liam.Howlett@oracle.com, a.hindborg@kernel.org,
 akpm@linux-foundation.org, alex.gaynor@gmail.com, alexghiti@rivosinc.com,
 aliceryhl@google.com, alistair.francis@wdc.com, andybnac@gmail.com,
 aou@eecs.berkeley.edu, arnd@arndb.de, atishp@rivosinc.com,
 bjorn3_gh@protonmail.com, boqun.feng@gmail.com, bp@alien8.de,
 brauner@kernel.org, broonie@kernel.org, charlie@rivosinc.com,
 cleger@rivosinc.com, cmirabil@redhat.com, conor+dt@kernel.org,
 conor@kernel.org, corbet@lwn.net, dave.hansen@linux.intel.com,
 david@redhat.com, debug@rivosinc.com, devicetree@vger.kernel.org,
 ebiederm@xmission.com, evan@rivosinc.com, gary@garyguo.net, hpa@zytor.com,
 jannh@google.com, jim.shu@sifive.com, kees@kernel.org,
 kito.cheng@sifive.com, krzk+dt@kernel.org, linux-arch@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-mm@kvack.org, linux-riscv@lists.infradead.org,
 lorenzo.stoakes@oracle.com, lossin@kernel.org, mingo@redhat.com,
 ojeda@kernel.org, oleg@redhat.com, palmer@dabbelt.com,
 paul.walmsley@sifive.com, peterz@infradead.org,
 richard.henderson@linaro.org, rick.p.edgecombe@intel.com, robh@kernel.org,
 rust-for-linux@vger.kernel.org, samitolvanen@google.com, shuah@kernel.org,
 tglx@linutronix.de, tmgross@umich.edu, vbabka@suse.cz, x86@kernel.org,
 zong.li@sifive.com
References: <20251112-v5_user_cfi_series-v23-0-b55691eacf4f@rivosinc.com>
Subject: Re: [PATCH v23 00/28] riscv control-flow integrity for usermode
Content-Language: en-US
From: Valentin Haudiquet <valentin.haudiquet@canonical.com>
In-Reply-To: <20251112-v5_user_cfi_series-v23-0-b55691eacf4f@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Tested-by: Valentin Haudiquet <valentin.haudiquet@canonical.com>


