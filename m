Return-Path: <linux-fsdevel+bounces-55498-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27B64B0AEEF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Jul 2025 11:06:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56A19567FEA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Jul 2025 09:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5196B238C0B;
	Sat, 19 Jul 2025 09:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bMCULtZQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22CE522154D;
	Sat, 19 Jul 2025 09:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752916003; cv=none; b=RwgafuSVWW5rKMk+b98XbbdbwfWfBZA4ZTZHLE5EC0ajWQ+GCTZ5VpEXye3ml9TP5iOLyHv5R4ccw7bt/YR61Fyw7MNlBIkZucIyMjnYpz1DFbbnliiEmwh8O5sbzxOrD5m6GYPQ6yM6dyG+W50Op7fVfM7Ravs8dUdq/SAzTbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752916003; c=relaxed/simple;
	bh=debctRQjSzlJnYfyYhsd6s1lTimVzgSBxJR2tnVBhTg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PARdFzuKFcarctjB4XBIsio99DK4cqK+tH5rvPrefFqcXj6/NcI+wcgCcEARqGr0Iu/nRQ16eiAQx1nRBcB9YG9/9eUkCZWJ0M95YsMBvj7Jpayx1fJl5GYewIzQwDwho5Sy2dPHb+iXA0RVWhV2Gp22TrE98rEIRxMp0bpjYlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bMCULtZQ; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3a57c8e247cso2596113f8f.1;
        Sat, 19 Jul 2025 02:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752916000; x=1753520800; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jJ4/BbAm7q5b5dUXzy7e13UOkoRfXmjmgAGnC5vo4+w=;
        b=bMCULtZQd2JwXVXBxuPp68FiF12ofIcuwxDwg3m1sCbCFycANlvP+/lVWMYHDijg+I
         TjqWt4tfjGMx27KNhTQV72NeSyKDsns1nZkSEo9bDd+YvqrOrgayA3N+z0ZheB+r5Upj
         Wo4nXCdgBJChf/tAh7VtWkKRnxkVDaZ9m7tT4PIXOTOs6tblVuFKQwobQxh8HjbyrIaM
         jn2ho5ilex2+rTJ/Nn2anBcRdxvYSXFByDaxyeOpQAmZk349dBb+eS1zQQBwuGM0zYxF
         +DhRzoutr0ypi6VGesWNk61tWzrS32vbdaKLQer2u8kZxLvackERlQ3pw7xedOZA1HUb
         luHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752916000; x=1753520800;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jJ4/BbAm7q5b5dUXzy7e13UOkoRfXmjmgAGnC5vo4+w=;
        b=bh7TXlDHWPUu8B4y3ZwVE1WXp9moe4ZvKhqsaxymMrRuGKNrKzvrLHPokeabTh6nrB
         bS5MzIwldl1uTTQVD4L706wGwZYpW663lvfFK4lPOqLLde7Ek3OmrDbJ+9PzVK8enBJw
         6P5T40hR6JWKn7sRBdANJcgnSU0h8I13/1qv3+8DB28nqjKVW/w0nOxVtjPuh8MgAMEr
         ozT28DjXvC1SkFPuoE9HfWH0sui58Od8rMzYdsrX1k10qikMEhwuGw8yDkuqf/7BGf56
         zer/rUMTzAQHvws5RlgZ0x/QN44F+pZjMs873w8zp+syqEa6yUmAEgID0SUI7FzHK3+3
         7eSQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+pdkOxejZCzM/BUjt7ZGwAxX7w/xY20zBqlhNxvWMZxSE3KSM3FWNPjYvvZmYUn5BsM/gZscGVOYMSvbo@vger.kernel.org, AJvYcCVWOfQnPii8TCMUvmW4p4SXFmsrtlF9DqyKjfGkGpK6tJZHclT/buFON52U7visJxUqGiH8QY9frEDG6pKl@vger.kernel.org, AJvYcCW7ODKNsC351dnVHGbxBzdG6AJWxspc+Ehuhq42oLTXysfjjyTGlFsWgI9SxXQaXXd/PnU=@vger.kernel.org, AJvYcCWTMowA//k6xhpJ9h3njhZdzx7M7y+dI7DQyopQTd7a10zUaqn7d+8KDg5HmRNxY1mPxMqAYBBTuSZnv2ArqMqo@vger.kernel.org, AJvYcCX+cqFAiMw8cKBa/hDVJz9JLVHxu30slYfK7ky42BZFMsh67tl9o1mWhkqyx52Oy0Gz51nPq4YkcKPgtgAqLA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwkzQX1LcYGeUuFolspJK2WiFuf1X8RPhKVU5n0tn6CZc5JgMbN
	9sn8V8Rdx2mABHl9sizaqT4QJ4O7DV7OnTNmglf/qCUJZ+3nHuH6JgHU
X-Gm-Gg: ASbGncs0dSY7k130LkxGf1CvRL7gXwp6t1bn1nn9DRHg1oK6odf6irTDHdbEG+G6yBk
	b/VkRM6bn0zn6LHXy6lCUVoaxFg76njp+JuDNDX3yyhvoI7R1zslJe2wfz7Rqn+gIoaVtiuo5n+
	xZLtHmlky56wRM1Q9XP1LFKX8G/QUtgL++HO3qzDTWTGBJH0OGnmoT5dxV3jzWOAkfrLd0NnUTX
	P/nSimgA5l8l619C7w0ZvB5Ehvi6GJxfVV6iWu+TVSpmQDkElNutkMuHI7MbuB5q4Vygf3inpTi
	Dl2LcTDfHOLCujDkkBaui5Ckifk/CeiTtKkKU5pgQcrY52BuO6ywdwc6wipR+H76Tc+q9o+B7+0
	wtVtMEaNea+qyJG2aIyOFaeSK7TmLpQ0K//R4eb55SJwKUZNkFCHPJAaLTNpzamt3qwqkiaY=
X-Google-Smtp-Source: AGHT+IF2V+UaRRGWERhibmmvf++qHDKUS+GtMYh7BtAfk0WgUMadD9FW5R+2I2VCTdG51w3bMa1o2A==
X-Received: by 2002:a05:6000:3102:b0:3a4:ec23:dba5 with SMTP id ffacd0b85a97d-3b60e4c910dmr10702500f8f.5.1752916000122;
        Sat, 19 Jul 2025 02:06:40 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4563b74f9c0sm42586495e9.28.2025.07.19.02.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jul 2025 02:06:39 -0700 (PDT)
Date: Sat, 19 Jul 2025 10:06:37 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Eugenio =?UTF-8?B?UMOpcmV6?=
 <eperezma@redhat.com>, Ilpo =?UTF-8?B?SsOkcnZpbmVu?=
 <ilpo.jarvinen@linux.intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Al
 Viro <viro@zeniv.linux.org.uk>, Alexei Starovoitov <ast@kernel.org>, Alexey
 Dobriyan <adobriyan@gmail.com>, Andrew Morton <akpm@linux-foundation.org>,
 Andrii Nakryiko <andrii@kernel.org>, Arnd Bergmann <arnd@kernel.org>,
 Borislav Petkov <bp@alien8.de>, Cong Wang <cong.wang@bytedance.com>, Dan
 Williams <dan.j.williams@intel.com>, Daniel Borkmann
 <daniel@iogearbox.net>, Dave Hansen <dave.hansen@linux.intel.com>, David
 Laight <David.Laight@aculab.com>, David Lechner <dlechner@baylibre.com>,
 Dinh Nguyen <dinguyen@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Gatlin Newhouse <gatlin.newhouse@gmail.com>, Hao Luo <haoluo@google.com>,
 Ingo Molnar <mingo@redhat.com>, Jakub Sitnicki <jakub@cloudflare.com>, Jan
 Hendrik Farr <kernel@jfarr.cc>, Jason Wang <jasowang@redhat.com>, Jiri Olsa
 <jolsa@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Jonathan
 Cameron <Jonathan.Cameron@huawei.com>, Josh Poimboeuf
 <jpoimboe@kernel.org>, KP Singh <kpsingh@kernel.org>, Kees Cook
 <kees@kernel.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Marc
 Herbert <Marc.Herbert@linux.intel.com>, Martin KaFai Lau
 <martin.lau@linux.dev>, Mateusz Guzik <mjguzik@gmail.com>, Michal Luczaj
 <mhal@rbox.co>, Miguel Ojeda <ojeda@kernel.org>, Mykola Lysenko
 <mykolal@fb.com>, NeilBrown <neil@brown.name>, Peter Zijlstra
 <peterz@infradead.org>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Sami Tolvanen <samitolvanen@google.com>, Shuah Khan <shuah@kernel.org>,
 Song Liu <song@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Thomas
 Gleixner <tglx@linutronix.de>, Thorsten Blum <thorsten.blum@linux.dev>,
 Uros Bizjak <ubizjak@gmail.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Yafang Shao <laoar.shao@gmail.com>, Ye Bin <yebin10@huawei.com>, Yonghong
 Song <yonghong.song@linux.dev>, Yufeng Wang <wangyufeng@kylinos.cn>,
 bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-sparse@vger.kernel.org, virtualization@lists.linux.dev,
 x86@kernel.org
Subject: Re: [PATCH 4/7] arch/nios: replace "__auto_type" with "auto"
Message-ID: <20250719100637.361bcf09@pumpkin>
In-Reply-To: <CAHk-=whGcopJ_wewAtzfTS7=cG1yvpC90Y-xz5t-1Aw0ew682w@mail.gmail.com>
References: <20250718213252.2384177-1-hpa@zytor.com>
	<20250718213252.2384177-5-hpa@zytor.com>
	<CAHk-=whGcopJ_wewAtzfTS7=cG1yvpC90Y-xz5t-1Aw0ew682w@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 18 Jul 2025 14:49:41 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Fri, 18 Jul 2025 at 14:34, H. Peter Anvin <hpa@zytor.com> wrote:
> >
> > -       __auto_type __pu_ptr = (ptr);                                   \
> > +       auto __pu_ptr = (ptr);                                  \
> >         typeof(*__pu_ptr) __pu_val = (typeof(*__pu_ptr))(x);            \  

You need to align the \
Plausibly possible by post-processing the diffs.

	David

