Return-Path: <linux-fsdevel+bounces-52398-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9CB9AE30DF
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Jun 2025 18:52:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97D817A671E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Jun 2025 16:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D00D1F2B90;
	Sun, 22 Jun 2025 16:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MIeV2T6P"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2152AD04;
	Sun, 22 Jun 2025 16:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750611164; cv=none; b=NviYKWoJcsbbHJXoY7z1Ct+UsYp1x6NZMXfWdg2Sl43JKgCmjdzwxvcT3c8iGblxa8dcBYvaQePHBGr0GHQMiiseYH7Jk5M5/CqQwXbmXRAUWjXv8RWM+A7TUt9wTt8ZusFHnkxztZ9OznoValErp0LTG68F1ug1FFcJCzWts+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750611164; c=relaxed/simple;
	bh=duB4ouV7PVG3cmWJ1QYjkuKk7v4eXinULHvNC0uLzDU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JYLX4Ugmks2PKgfqtLl+P7LzypXgnIMTj1eysYCGUCZvcgFpzg2flMKGkKIj7qgFvVxIx+eNblTqrmt3Kra+HSVOv5K31/Oyemy6rSJLbIPZ+TCJEDHP6iXpa9Ap9qhhtRlPLWShS/hp2BAy3atyhPl2+yK5IFFQ9JD4PvGA/5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MIeV2T6P; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3a6cd1a6fecso2908578f8f.3;
        Sun, 22 Jun 2025 09:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750611161; x=1751215961; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FngSn3FLzaGg6vnTK1EcbPv7loXCwwNpO2CdpOQR/gM=;
        b=MIeV2T6PFCZg27RMbSd4rKsRq5j32NhDVgK88hcktWZF++Aldc1kNhKAohBtsW9Nmu
         WLZY0oTQN20dmsaEVQYzVZ/1OU9xZtQxMt5Cbin83/O6M8K45T3Wz6o3nYgvRzSvYqmi
         pgjvUAZXHRr1vgpzYC1gDLX1Nv+7VF6NLgrq/9fwByaJM4U/fTIw881ju27Eng3HWUA6
         bfe8yca+UzP8NjcpCa+wln24EmNDqBp6TqIdsJaPeQIxI536/4b5CivTZMidbGptuqBo
         T40YUENwqfnsLU3Mg6hIDvw7uUzvcUKWmJWA24sFqyctOuAar4ecQznsFgnz/b7UdN/5
         UrkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750611161; x=1751215961;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FngSn3FLzaGg6vnTK1EcbPv7loXCwwNpO2CdpOQR/gM=;
        b=CwSDbM6fCFminz4LIXAXQeOjhBiuJDyopOH9SXUEyn/fe90X3KRph67+E1BSe0097A
         xutNHV88+m3Wly/uksKP8AElzYlFbwCEDX4aXICelnHYsMO23th72PLEfVHZH6SlC01W
         xdDTBcwHL61u5wOe+fMWCtJI8Fr/5Ofp056oRLZNgrW/BvhV73OzDCxOS2XfPEnZoLYP
         /xfFC6+sZ4oGy/MBQFp31aU7RjpJhK0YK1/bcLtes8o9MHJb39prZDpTiY6WDA1H4l+I
         Qvk2RF5Q2juaSNyb8ZwD01ATD5S5/IEiYokL1u8ytWywOln8yTi/wPx09bTNd3UxsrCk
         L+zA==
X-Forwarded-Encrypted: i=1; AJvYcCURX0U0p3lT7jBLssiRJ8FT5jD3nCDdwX2lbHtCGO+iKLMQVhdrRUg4iI7YuuAe+18V2GmyWNXPiKoCA90n@vger.kernel.org, AJvYcCUpKgTi1VVaFtj1GFNUwcBptXPTob+l4O2RvTAvdxlTzJmPaI4MQ7Gz3jv8gXBujeT1DVtZrjZsfc38eJFF@vger.kernel.org
X-Gm-Message-State: AOJu0YxtfLt5udfG8e8PD6Mj5SiYPauKcTagHsfx3fjoyWWDfheM3xOX
	6ZLGfC4N5iPUZOwM9cmGjUtA7CUIxjiBa8dZbZGPrpN/6d5fj0V6bb/D
X-Gm-Gg: ASbGncuKrP8ZrkKUvC0USs3URWGK2XHlKHK1wfp0FAGF8uGBIZa9m5mZ4UVVJTToq1u
	fTh1CBjSZK4pzpgja1D/JwqZXQRs7uBSHw4c44BXAoCp0/cZiupZA1NLJO98Qj4aOTdZTLRZ9yl
	609LDFFW7ZVemTgCLcH+F/nrQECusR8/3Z/tAG8cTUXSZwlbGirZ9j+OaUXpkeHzD2qbWIBSmbG
	Y6e+TQ6IktbMxrDR43x+e6FeJy4kcddry0wf0KxirPnU8BzwjkmYC49/sA33FH8X2gIVNrF+fmN
	NkUk5QsPdLJ8DanIvHlw77VbFReA3UnTVlrNlNLbjUS9fTmxhcTz7aiBPZu3+lw6oE/jx0GFJEY
	KajaGbcxO5TsQApTub9gjo55t
X-Google-Smtp-Source: AGHT+IGYZ2I7yF8X3Gjleg6T1l+ayP9shmcGOvVNUsuDSBZtK92zgW1wfdx37nTuwhWT/HBaaKSFPg==
X-Received: by 2002:a5d:64ce:0:b0:3a4:f513:7f03 with SMTP id ffacd0b85a97d-3a6d1303b0fmr7534708f8f.44.1750611160377;
        Sun, 22 Jun 2025 09:52:40 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453646d7d8fsm83430075e9.15.2025.06.22.09.52.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jun 2025 09:52:40 -0700 (PDT)
Date: Sun, 22 Jun 2025 17:52:38 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin
 <npiggin@gmail.com>, Naveen N Rao <naveen@kernel.org>, Madhavan Srinivasan
 <maddy@linux.ibm.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian
 Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra
 <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>, Davidlohr Bueso
 <dave@stgolabs.net>, "Andre Almeida" <andrealmeid@igalia.com>, Andrew
 Morton <akpm@linux-foundation.org>, Dave Hansen
 <dave.hansen@linux.intel.com>, Linus Torvalds
 <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org
Subject: Re: [PATCH 2/5] uaccess: Add speculation barrier to
 copy_from_user_iter()
Message-ID: <20250622175238.642d02bf@pumpkin>
In-Reply-To: <f4b2a32853b5daba7aeac9e9b96ec1ab88981589.1750585239.git.christophe.leroy@csgroup.eu>
References: <cover.1750585239.git.christophe.leroy@csgroup.eu>
	<f4b2a32853b5daba7aeac9e9b96ec1ab88981589.1750585239.git.christophe.leroy@csgroup.eu>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 22 Jun 2025 11:52:40 +0200
Christophe Leroy <christophe.leroy@csgroup.eu> wrote:

> The results of "access_ok()" can be mis-speculated.  The result is that
> you can end speculatively:
> 
> 	if (access_ok(from, size))
> 		// Right here
> 
> For the same reason as done in copy_from_user() by
> commit 74e19ef0ff80 ("uaccess: Add speculation barrier to
> copy_from_user()"), add a speculation barrier to copy_from_user_iter().

I'm sure I sent a patch to change this code to used the 'masked' functions.
Probably ought to be done at the same time.
Would have been early feb, about the time I suggested:

+#ifdef masked_user_access_begin
+#define masked_user_read_access_begin(from, size) \
+	((*(from) = masked_user_access_begin(*(from))), 1)
+#define masked_user_write_access_begin(from, size) \
+	((*(from) = masked_user_access_begin(*(from))), 1)
+#else
+#define masked_user_read_access_begin(from, size) \
+	user_read_access_begin(*(from), size)
+#define masked_user_write_access_begin(from, size) \
+	user_write_access_begin(*(from), size)
+#endif

allowing:
-		if (!user_read_access_begin(from, sizeof(*from)))
+		if (!masked_user_read_access_begin(&from, sizeof(*from)))

	David


> 
> See commit 74e19ef0ff80 ("uaccess: Add speculation barrier to
> copy_from_user()") for more details.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  lib/iov_iter.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/lib/iov_iter.c b/lib/iov_iter.c
> index f9193f952f49..ebf524a37907 100644
> --- a/lib/iov_iter.c
> +++ b/lib/iov_iter.c
> @@ -50,6 +50,13 @@ size_t copy_from_user_iter(void __user *iter_from, size_t progress,
>  	if (should_fail_usercopy())
>  		return len;
>  	if (access_ok(iter_from, len)) {
> +		/*
> +		 * Ensure that bad access_ok() speculation will not
> +		 * lead to nasty side effects *after* the copy is
> +		 * finished:
> +		 */
> +		barrier_nospec();
> +
>  		to += progress;
>  		instrument_copy_from_user_before(to, iter_from, len);
>  		res = raw_copy_from_user(to, iter_from, len);


