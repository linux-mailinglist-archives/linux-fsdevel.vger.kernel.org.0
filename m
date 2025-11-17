Return-Path: <linux-fsdevel+bounces-68766-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D3FD3C65B32
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 19:24:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id E33D128B60
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 18:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87D3B31327A;
	Mon, 17 Nov 2025 18:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="S5uKRssT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DCC2DC333
	for <linux-fsdevel@vger.kernel.org>; Mon, 17 Nov 2025 18:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763403870; cv=none; b=na4Oz1vtD++CU3zblAzar5aaspwyHf0guwyW8Wo4pVwPmxQyf/nDwPyMrP1hQbalnlBjaHxvPpAOKD/V0aCh0YYvY0TUpG5HEfWEj1pNApIXp8Qga5I6KNFjczcjbghSdfU180Klp4xa5zY/bpplQyTcvXiEmpAzRpjYWZRjccU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763403870; c=relaxed/simple;
	bh=DSVaYS00Ppz/lXA0EJ/lwtUlZcIIPkWYwoyJByW18bU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LhHnEG6y5pwxhQMp6XlHbUCCS9BIxCDx0m2EFm5Be1owf05WuOwxcd7xeuZKqMY9X9tWz3J+t77kGtoiINuL0iyWRIxd6SvQlmUyT93JjNvyeWYhNcRS/eKn/R8B5UnQ9ZmwmYnSswraJ7Qcg1JMJn3OH36GdZObI00XSIyEL+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=S5uKRssT; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-64088c6b309so7451584a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Nov 2025 10:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1763403866; x=1764008666; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DSVaYS00Ppz/lXA0EJ/lwtUlZcIIPkWYwoyJByW18bU=;
        b=S5uKRssTjIvfjfTMkVJXvTmWkmBSbpslh9JXGqpBo16LqUCrWfQi2LrOCaDmpZt+F3
         xiFyMPECkusxkEfJWMDqwwcy2gq7Z/UpbMbJIT1nCESE8RV2Mpy9DFugrSmxi36GetDE
         9KxFbApN5ER1PvMLaCxKEeLoOL+sER9gW99arb/ujgI/bPL1xcDMuEikfssfim6MIGS7
         o9VkifnnMbeFiwkVPMa+YjQ6LParO/uVXgGmxTtSQC9sbhhjCfhboPuZ/p3ZafvcXdNn
         My4ZY6zl8rvcq//PL0JLyB3T/pcsCNFcL9+hWlibU8Eiwb8sp4vVNj9NouR0ujak2guu
         lNSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763403866; x=1764008666;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DSVaYS00Ppz/lXA0EJ/lwtUlZcIIPkWYwoyJByW18bU=;
        b=eAqcm5fyOuV0JLtlcOFKu5sIe6wvUZGTKPs2xk88bX0A9EA3A6M0Tdc8RYh/5zpI/D
         ZMh2NgX1mNtXcIb0+g9lo7ll7mAQrA0YRdlWgYoLBIsTEDT1M785jvrMCoF5R2ZoReVr
         6Z+OhjfLQJWCtX3XlVTSTnctCwzsJNglsivRp+AyVc477FB0EqHe88wk8ipJoqBJN13H
         fbFigdmdl6yhKqgiZvEnNikZoxvMpUTVPD+awKfaoPcJHjIfDLcP3m5JOoV47NDv1B7M
         xqPmyWoqxQyI+oduZNRiWGsCLARSwmT9eDt8T0Ql8zBNcjwMwgCACFINMxlnOfne45q9
         UoZA==
X-Forwarded-Encrypted: i=1; AJvYcCXG9r41jnea6Dm60LJp/w+C/lxBuKDOiBcuVqWvOjBlxR3c4ILfJxZtso0E3KXR8q40EXBYdKI09O+NdLfp@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg9HLSv159ryZtZWpKrUpYnkmyivScFJx1pnORAFLYhISfgLgh
	diQvHSUEIRwys/tj5Kgmx9xXQcd9ZWqLQMI6y8h1zH5kz9xFOhWt2k4Lq9VkTF4TVlh8f/s7HUg
	8M5IU5Qac+OHvkwL1xj8/Qm9uzhcq/LUDDWKN4woY0A==
X-Gm-Gg: ASbGncu46+iqSY8+Wcens5Icni2bYPmo6xHcyDIWk/ksg/usXSWThv5ydyxPwFSInLq
	doefwAWtQohVEBMCyZYUh+vFt+3NVlDYqrGoXqssNS7frdzOz3fUmmCFkZAnaVl3i6HDFS/S31b
	R4yNjw5t2WjgYHtI3CrKLMWdz+v4pA7nK3zmxLDjY1Q07L5Qmw6N8ASixziE6XgRFFJQBkAKaWP
	0741nf3vpT/Y8Uje2DbAQ2xiED4K1XCa+38tZWIWdg0bSL0q7H3IK2fQJ8XzwAxP/N88E6NuZ9R
	ccs=
X-Google-Smtp-Source: AGHT+IEEWqHLyN23GdmGqxp16gOz0H99ycEtpAQL2MFddiKttxJOs0DiTjbKI+yQFgL9TB9EokEIYjSn2RJfB01X0+U=
X-Received: by 2002:a05:6402:2806:b0:643:60b6:3eed with SMTP id
 4fb4d7f45d1cf-64360b63f56mr10022358a12.31.1763403866324; Mon, 17 Nov 2025
 10:24:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251115233409.768044-1-pasha.tatashin@soleen.com>
 <20251115233409.768044-19-pasha.tatashin@soleen.com> <c8b46600-d40f-41b4-a5a3-99300ef1a2eb@linux.dev>
In-Reply-To: <c8b46600-d40f-41b4-a5a3-99300ef1a2eb@linux.dev>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Mon, 17 Nov 2025 13:23:49 -0500
X-Gm-Features: AWmQ_bmhggvke7xISGqUn7uC4niyXxh61OdHqC9kU_cJS8AOY1qqJ3NjJ9HlQrw
Message-ID: <CA+CK2bCUG4BVqPJYL5nxC-Uvomx2JT=sE4DrhqFjrBf+zN_m3A@mail.gmail.com>
Subject: Re: [PATCH v6 18/20] selftests/liveupdate: Add kexec-based selftest
 for session lifecycle
To: Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: pratyush@kernel.org, jasonmiu@google.com, graf@amazon.com, rppt@kernel.org, 
	dmatlack@google.com, rientjes@google.com, corbet@lwn.net, 
	rdunlap@infradead.org, ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com, 
	ojeda@kernel.org, aliceryhl@google.com, masahiroy@kernel.org, 
	akpm@linux-foundation.org, tj@kernel.org, yoann.congal@smile.fr, 
	mmaurer@google.com, roman.gushchin@linux.dev, chenridong@huawei.com, 
	axboe@kernel.dk, mark.rutland@arm.com, jannh@google.com, 
	vincent.guittot@linaro.org, hannes@cmpxchg.org, dan.j.williams@intel.com, 
	david@redhat.com, joel.granados@kernel.org, rostedt@goodmis.org, 
	anna.schumaker@oracle.com, song@kernel.org, linux@weissschuh.net, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, 
	gregkh@linuxfoundation.org, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	rafael@kernel.org, dakr@kernel.org, bartosz.golaszewski@linaro.org, 
	cw00.choi@samsung.com, myungjoo.ham@samsung.com, yesanishhere@gmail.com, 
	Jonathan.Cameron@huawei.com, quic_zijuhu@quicinc.com, 
	aleksander.lobakin@intel.com, ira.weiny@intel.com, 
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de, 
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com, 
	stuart.w.hayes@gmail.com, ptyadav@amazon.de, lennart@poettering.net, 
	brauner@kernel.org, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	saeedm@nvidia.com, ajayachandra@nvidia.com, jgg@nvidia.com, parav@nvidia.com, 
	leonro@nvidia.com, witu@nvidia.com, hughd@google.com, skhawaja@google.com, 
	chrisl@kernel.org
Content-Type: text/plain; charset="UTF-8"

> Thanks a lot. Just with kernel image, it is not enough to boot the host.
> Adding initramfs will avoid the crash when the host boots.
> I have made tests to verify this.
>
> Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>

Thank you!

