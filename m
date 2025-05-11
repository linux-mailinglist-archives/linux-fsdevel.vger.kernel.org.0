Return-Path: <linux-fsdevel+bounces-48684-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F29B0AB2983
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 May 2025 18:19:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 893A21896BC5
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 May 2025 16:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB6D425C6F0;
	Sun, 11 May 2025 16:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="fbqqmxWn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1D9146A68;
	Sun, 11 May 2025 16:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746980368; cv=none; b=bdjMm1sjyoUrwfr54dvmm0FxbwpeiIiGz8h9hGdxjLEzYUmSoCwV/+PS0N4jaOYL3bSzpQcoxFG8arPjA3P22ouTa/N4PITQ+LF6ikoPjJqbGQMZh3KZwghQ6CU4U3hk+fRYFclaxg1jwgAoy5SWNj6MNWcIEKtAwPhhCrbEYiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746980368; c=relaxed/simple;
	bh=3YdFEW24FYdImKeOrdKx57Erk+jxkC/GvYlIhkgwcFk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g/XjxvnZrVIevZTWgy9ZWdkRKPOLcj3qusoaDpp8II2QDO/MChVWl0BcEcSGep/MySOop5n/1IRQEb/S/kux+8vPAwIvjgxqAgqaR9UFzHillN5UNjMSBlBmXPKdI+CBw95pwzVTokIFEYRfCkpeZKic4NbA1pQ1iTmUAHfG7HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=fbqqmxWn; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1746980358;
	bh=J5tWhr332dnCQ16PRXkqcwwmeT+PgiEOfPiltO84PdI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To;
	b=fbqqmxWnUGvokzCY0CVdXzfhM/hxB0KGCtyxdJAWmr0z57xXGDbIPrSpSNnfDgnjx
	 IDfH6WIHSGJLOpuuUOIATQbi9zaPATXYuVYM7Zd5Y9LDO3vxLw7ImDpUXqoqA0D80J
	 VUjFWqe4P1f5w6Veo/Fsqm0f343C9E4RADhprm9Y=
X-QQ-mid: zesmtpgz8t1746980356t02b84b04
X-QQ-Originating-IP: 1jnH0zJNbLrRC2UF2rN1b3YwuN47qO+Gxf6CaM7vQQU=
Received: from mail-yw1-f180.google.com ( [209.85.128.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 12 May 2025 00:19:14 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 10478636569671076574
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-70a1f2eb39aso33318397b3.1;
        Sun, 11 May 2025 09:19:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV/SMh5BaPwSpUPvuzbTiNKOR+jIUVxM8cW0xHpAijLgwaZsUPawnHEQU4OT0MsgSkw/BoXAz1AkSW4j59w@vger.kernel.org, AJvYcCXY/YgvYz79ar9F/2tsCngrZfcz5jFFc91fn2PRPK8QJtVxlEQhGJwoFNCkS/JdjwtbhQpchdqTWKUK5cC/@vger.kernel.org
X-Gm-Message-State: AOJu0YwwWTeMnpl0m5q76rGb9taWYVm9hNccB7GWASobxgeL2MKfQOF1
	Fa8BTanm9vBwxoDbB2RxSiVHjjyjHq6bW8Br7Bz+B225PNQZ08iXTQhBKe6o2PBM4Gl/57hZ/VZ
	bdD8Wj7lLSj7evslTiE7NTpJcApg=
X-Google-Smtp-Source: AGHT+IERBdaRZXgUT1g/1q4Od7MBM0x8pc4kZ8Urgl41YNECSDCUznTTFXLG7rGJGKuAsyKD+Er5SMWlDEeGPByAE1Q=
X-Received: by 2002:a05:690c:4b13:b0:703:ad10:a71b with SMTP id
 00721157ae682-70a3fb171c0mr134040447b3.29.1746980353594; Sun, 11 May 2025
 09:19:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3885DACAB5D311F7+20250511114243.215132-1-wangyuli@uniontech.com> <20250511142237.GA2023217@ZenIV>
In-Reply-To: <20250511142237.GA2023217@ZenIV>
From: Chen Linxuan <chenlinxuan@uniontech.com>
Date: Mon, 12 May 2025 00:19:01 +0800
X-Gmail-Original-Message-ID: <940BC913548C5B0B+CAC1kPDP4MCfUFkrQu0-Fg3Du7bz25QAY1Wyqdi_HGVbw326U1w@mail.gmail.com>
X-Gm-Features: AX0GCFuY_lZMhgdM_xEAR-dGh18ktHEAsNXhAvS21BXkkDvlrq3yfXP_TlzI4wQ
Message-ID: <CAC1kPDP4MCfUFkrQu0-Fg3Du7bz25QAY1Wyqdi_HGVbw326U1w@mail.gmail.com>
Subject: Re: [PATCH] proc: Show the mountid associated with exe
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: WangYuli <wangyuli@uniontech.com>, brauner@kernel.org, jack@suse.cz, 
	akpm@linux-foundation.org, tglx@linutronix.de, jlayton@kernel.org, 
	frederic@kernel.org, chenlinxuan@uniontech.com, xu.xin16@zte.com.cn, 
	adrian.ratiu@collabora.com, lorenzo.stoakes@oracle.com, mingo@kernel.org, 
	felix.moessbauer@siemens.com, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, zhanjun@uniontech.com, niecheng1@uniontech.com, 
	guanwentao@uniontech.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: MPEeF6PUOsC8QaVptKtEdNgk9SkVexRjdHZ+7zSrU/NkU+f0y6Zqzxb0
	htJmg1aOOtQecPaVIMbHVcx6f6gy2b5B8jSRAWQEvrJmqVegxQSAQ5OX5jMFxG3V8TghzHU
	I/qO3BBI7FlG38XCztFOAhmrjyeQzo0uTVpb31tTPz8lFSu57GThHJQi/d9ZA/iVKBcy3Od
	s9asp5R4FsMcjhz9DPN0S9F9TUT0Xs9AsF9LXEIvizbuPqp95RnRHEq+mZYgw4Gr2ZKN/o1
	fXwGUtr1yVZZTP8xCXo3yF8WDpXn5L+hxdMQI6QPUh8sIFxGFnxT9vtw9lyl4UqpLTG7dxl
	Y4EkUufxi9C1Ge3IqJUCOXYuy+9ZoWOcHu6UVEu3Zx8a5uvEFIB2K/++4aq4VGVzm2ZfT+Z
	6XuQlnGH0CYBJC4ZcFRYRYnB9yCVTMLVg8E+/LPrCs1WVrR7SuhFPTuZN65y+RvIxW9ggLj
	6GJeMZjoAnHtAhzLDMi0UeRGsNvHtDOiqR8V0Q674oeaF3JFZ0/5aaL2JFQweFG03lyYpRc
	YfkCw4ZaZapFYlb014NZJQYgYmzBnRnoiPjQRs8WZG6ftDUdJJ2VdvT/Ftyh9L9CPgjCCa4
	7gnque6IjablmAeIOZHnpcVj8CFa5oTlU3u3dx9qbbiZ8ANLTfrIerNxwuj8eP2VBtb+RWQ
	cWe4A0nYKqS3zPCJmMuGgFowRM8pgLqTb8baaHgeC/VbU0piINOYsrboOdyE8T+8Y33nYI2
	KiXfyU0yWy6AmT1aj+NlwjwESe/SDqTlcr7wmktFIIkUCZvJs2O5GrEK+ma+irsYPqSdjJt
	5tvNhTWr1XSssFPyFbQhpUlZO5sxcyMr+7lneb74px+OV71/SydZxv+paBkjewFraMvlIk2
	Mhn4BgmY6be2Il5g/fxkbiuISs/AmYMxUz/eMmLgfftSYXZcaWQo7DoZPbqHqAsSZZsncED
	zefUu0ANCwWtpfTbIpjDRnSt1leoHAFpNYbvKRbn1EOedwoOjHtG4keFLzqd+9y/8uY+CUX
	lNjaSYfsaTzsHykUmz
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-RECHKSPAM: 0

On Sun, May 11, 2025 at 10:22=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> =
wrote:

> Excuse me, just what is that path_get/path_put for?  If you have
> an opened file, you do have its ->f_path pinned and unchanging.
> Otherwise this call of path_get() would've itself been unsafe...

I am not very familiar with how these functions should be used.
I just copied similar logic from proc_exe_link and added a path_put.
Maybe I made a stupid mistake...

