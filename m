Return-Path: <linux-fsdevel+bounces-58090-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18686B29355
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Aug 2025 15:50:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 780F61B24A99
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Aug 2025 13:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F41B628DEF8;
	Sun, 17 Aug 2025 13:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RnVMBNmg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C541128B50A;
	Sun, 17 Aug 2025 13:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755438612; cv=none; b=o/S0rL6BY10KryOaeKAkQle8hxoV+FFsDIqcP0j0ZwWx8D/7Uc1aJES2X8iO9KGyCBssaH/UIKe2m31y9wm+vmmRZMqRxoS1nGgTXUn9NTw86pa1l+kc2guzo0OfbE/7DWSg0DfbQ5pJRUDK+JJnbCcgJNmTtpRZMuuuNYXQ1Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755438612; c=relaxed/simple;
	bh=FAhrRvkDZSSNICXN+K40yB2WSBpz0uSk9J/rhUEE8o4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LYuZhZ90mjUtGEwjbVjp8JvRwHFvO8/Ffm4t2vWc+34TaeAGQypwxVKwtdAkr060rFfMsGfHmP7KwddcVN+JZDvuzARZ3i3g59kjskbdtifclIMKSHaA3w1njzyX3aYLzyN6AjOxB5Goqpwx3YpxkLobSyQxl7EUwOZf3oCY3no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RnVMBNmg; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45a1b0b2d21so14447215e9.2;
        Sun, 17 Aug 2025 06:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755438609; x=1756043409; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/yoZElYHHluW6HXReDqCRUDoS4VRBHZ+MHdPE0sfQVI=;
        b=RnVMBNmgtPoLpGfKMaJv6Z6pNSUUJZ/obdTouBzQaPRa2osJlsGZbt1FSRe0GiwmZM
         t3xF7yJqgon0nqK3m+xl9oJwUemoGuRgjk8MOuQCULGy1iPbMV6DFdz7MhR+z3In0BXn
         PdMJAIi1tTxguGIrOnzdYvlEataLuJA4oHqmVi7+3CcM5bwycl/RLlS/XLPgwTBRJADC
         6sVha22L0kFNepa7f7rWMe6mFN69ZrovFYML2WLGCro01H2XDlssj4FJ8AD/we0Z7DRx
         rNBNVqljh+/nGmezXhIaUDqc/3+jcuEiEtvGAVgq9LBOC9sw0/CZVx8mEXiMLNhBAy8e
         QCvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755438609; x=1756043409;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/yoZElYHHluW6HXReDqCRUDoS4VRBHZ+MHdPE0sfQVI=;
        b=SbnjlkcC4G8z94++3etZ3Krmgsq9sAHCDgBdkl5PoGohBGixCxDsKoZeU2T6L8O2aa
         a8BGQvdFT5WJoCg7OJTr2Oekg3ymT790J7ye1fN9UeNyKQieeEdrFZ961Z+8PbUYEqcL
         7/hJDRI1QnXvWOKug3Y8ZqeRXA8yGWU0eckxUptK0mSR/QENiCDHZWeHx47XagURi8Jq
         6dvDf+M10aofsa4wiKKqvDp5l5QZQ0wu/V1C6PPYf5efqILUTQn6aK+5ZG5qrqXPPDP9
         KYYs8sc/2lptZhi/nSoggvxsCCenyQhNnzVic4gO+52nw5SdBoMfJAG+Ngvf6n/1Mf5V
         ybyg==
X-Forwarded-Encrypted: i=1; AJvYcCWmM0LuzsaXdvZZX2y+77iPOzY7o9VgLPzkRKNKxuCT/LECqA9Jp34CKtGOUnAc2fO7QB/MglDEfT+NfJDH@vger.kernel.org
X-Gm-Message-State: AOJu0YwCAmTUekhHGyBiRYy/2uwqnL3Zu6H0Mxidj0Ec9syGtKMXYyNN
	Q10CjAveCd5T841e59LWlTayyZ550a10hOd4bNDjGgarg+g57x79+KbfuUJ+fA==
X-Gm-Gg: ASbGnct3e4hwp9ZPxshDZZwE0fVUilt8Wn9g+MqwTf2omjAo+7Xc/YwsMem3MU15ixD
	3NyF2K6sc364Id5Yq6QCvEY4sb/6XB6QbeNxn5IriaY1GwvijuoE0Vw6kUIvOPO5dEWjqiWPQMQ
	7ot5DaJMkoKIAx8kgJUoRsx/UbW1klgTI1bph2lfQZpck3Jf9tVUei4pBppTyY9iV3ONJuiFjnr
	RwcHK5ByAXKZjf9gVK6iSqxqT4LUc8ZuhWIsEnZufp71ktbGVRpKmmWlqFqrkL1+4ZdF7CLJ4vJ
	HVplmAgY7nFZSv11fQag8gewZXXnz1tr9qYadSGBaPeqGC7FJyaxQN39jrvq/L/doH0vKV29HNZ
	Gdl/8ZQcdbjz3eOCpzMpnxTwyLpJH7+N0Ghhd5nsCuAhSH9cytuRNiG+VPeM38Q+qCoWKKeU=
X-Google-Smtp-Source: AGHT+IEK2JQHzY9JjOBt/rAKrEsir7aaDbT+/HLG20AKYyI0t/BGE7MCKUX8VvAazzko6xmLdH6ASA==
X-Received: by 2002:a05:600c:154d:b0:458:b7d1:99f9 with SMTP id 5b1f17b1804b1-45a217fd4e8mr69892265e9.11.1755438608859;
        Sun, 17 Aug 2025 06:50:08 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1c773e57sm138545945e9.23.2025.08.17.06.50.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Aug 2025 06:50:08 -0700 (PDT)
Date: Sun, 17 Aug 2025 14:49:43 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Linus Torvalds
 <torvalds@linux-foundation.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Peter Zijlstra <peterz@infradead.org>,
 Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>,
 =?UTF-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>, x86@kernel.org,
 Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner
 <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org
Subject: Re: [patch 0/4] uaccess: Provide and use helpers for user masked
 access
Message-ID: <20250817144943.76b9ee62@pumpkin>
In-Reply-To: <20250813150610.521355442@linutronix.de>
References: <20250813150610.521355442@linutronix.de>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 Aug 2025 17:57:00 +0200 (CEST)
Thomas Gleixner <tglx@linutronix.de> wrote:

> commit 2865baf54077 ("x86: support user address masking instead of
> non-speculative conditional") provided an optimization for
> unsafe_get/put_user(), which optimizes the Spectre-V1 mitigation in an
> architecture specific way. Currently only x86_64 supports that.
> 
> The required code pattern screams for helper functions before it is copied
> all over the kernel. So far the exposure is limited to futex, x86 and
> fs/select.
> 
> Provide a set of helpers for common single size access patterns:

(gmail hasn't decided to accept 1/4 yet - I need to find a better
mail relay...)

+/*
+ * Conveniance macros to avoid spreading this pattern all over the place
    ^ spelling...
+ */
+#define user_read_masked_begin(src) ({					\
+	bool __ret = true;						\
+									\
+	if (can_do_masked_user_access())				\
+		src = masked_user_access_begin(src);			\
+	else if (!user_read_access_begin(src, sizeof(*src)))		\
+		__ret = false;						\
+	__ret;								\
+})

I proposed something very similar a while back.
Since it updated 'src' it really ought to be passed by address.
For the general case you also need the a parameter for the size.

Linus didn't like it, but I've forgotten why.

I'm also not convinced of the name.
There isn't any 'masking' involved, so it shouldn't be propagated.

There is also an implementation issue.
The original masker_user_access_begin() returned ~0 for kernel addresses.
That requires that the code always access offset zero first.
I looked up some candidates for this code and found one (possibly epoll)
that did the accesses in the wrong order.
The current x86-64 'cmp+cmov' version returns the base of the guard page,
so is safe provided the accesses are 'reasonably sequential'.
That probably ought to be a requirement.

	David




