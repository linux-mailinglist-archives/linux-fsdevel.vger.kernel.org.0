Return-Path: <linux-fsdevel+bounces-59410-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87A88B3886E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 19:19:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89A93189D4FE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 17:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27AA42BFC8F;
	Wed, 27 Aug 2025 17:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Gj4NCmUP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8AC747F
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 Aug 2025 17:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756315174; cv=none; b=lsl6P4DUGMNldISE77OoyLMoIsjd0Ihx8jtimm9Yqw9/mcmCauRl0HwpCt6eaBlvkThZWNjJR3yXRD2yDhcenJkAD1XXlOe1QxEut76/gZP/4AdK4UoO4aZLpHi7GhVkfeVyT6oUOuH8j5IoTZegZu2oEb7uqZVBXdgJQBgo+Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756315174; c=relaxed/simple;
	bh=08+bPUpD3NofbGdesaWjVS4AGDF6/nxtnUq/g1HIZ+0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WZb/i4deYn12b3uF4Pm+0AOfX5GqTwXDPU6frXQNbLgtbigMDyAJfcKUbTyMTY06gdvfwu2SeGWhikJM9wb0C/ApmBtT7Lgbbvnpp80do+Fwz5kG5SRfokkSumXgo+99h6U2GjHhWEr5+tzQsV8FprMfpHoCCx4Mn/RvALT4cm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Gj4NCmUP; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-afcb731ca8eso8473466b.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Aug 2025 10:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1756315170; x=1756919970; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iCay8qhy3suZSeXAmIkGdLPibCYtWXMbhYxDwyVYsIY=;
        b=Gj4NCmUPpA3mvug4hPPUAO2Ylz9G9FlRZ3rSNwRqWD1TOrSj12i/VURsBDL1MH4CqH
         wLSylBLsYCeJKxi/4lfR70NZ/XSi/Od45Rfv6uqewSUhvgSIKUAWWRfwKO1Gsljn2HNj
         L58dHRQSUiREvU9LAtS8Kirk7g7Q/jm1NODQA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756315170; x=1756919970;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iCay8qhy3suZSeXAmIkGdLPibCYtWXMbhYxDwyVYsIY=;
        b=uG5Bp7BL9VgsE4i6ec7o9b2wNU7+AeGPcg7b54/ReyhIE/UV/RAVHAk86RUyeSTToY
         4ad/tOHRO8P0/7SG5yVKj8w6NXWhVogyJmoNXHYKbLchH3PXyhRGuncTnlMlvevI/HNc
         rm7Is/69QipLAmYkGSty701Kr9hcgr1FzXyu0k0mDR1L1SOAQMqxu8fFmk9SM3PMrXNw
         vCHQeq01IxblkL929HoTEFjvttkkpWwrJZJlh4Oj8eko62usSAJ/G8XwBxK88iwgVsa7
         XxXQIEcBsnzvfH+gcInr8ir7i1BnBQMZWC40W57buoBluNFXJ+zW/JYMrpzwpt3w9g7+
         Srqg==
X-Forwarded-Encrypted: i=1; AJvYcCVl2Hdbm3HmM6TJwCqUxqeatoerd1MIAwFAajFdMl2zcd6aomAdIQaCTx/ZtzCHXo5WoGkZ2s5BvrDv6/6N@vger.kernel.org
X-Gm-Message-State: AOJu0YzxHURx/RXBPbgbtJUHNSthcTMJcM/j4Y1QCJ151bbZi4uo9+w1
	v6M2i3QhngMsdt9oODIQZbXu/c7umSX5EMvPV2hoLaDGEMPbUb/rIMwmCPuQ5FRYLXfbUHl+nF/
	jOTR1450=
X-Gm-Gg: ASbGncux3p8RfoPtdHi4X27TZ5LmnwrvRUcY/LYmQMa74kUHvuWa1M8z3+oLDqTXyyO
	yBvpPGB2Ps4/6Dd5rF/EykKKrPkhrqVSOjl86pM9XEUyS5NZur1QSEdPoOaqFatixXhFvd8sBBV
	hswruBJ/3tsvjq9IdT2uJ1FrO3v9eTebawwe0dr0NwL9s8+0D5nxt0+AkJnx+rplgnbAnNYo9h3
	4Mvk6EMUhGZ7C9l1r4KD9CRx+m5Wl5Nwf2W++hD0EJohF+ZkHp3odRA0OBd0YHB6JwhAcwuY8kQ
	s/xm82eclWMRb72lVQPPgriV/5jxB7v03MOBHq8UzkGCfI3nP9wlQBpCnzaG5XMXX10i3ZqJrc2
	ur0AhL93p500oVOfExdB9d6s+p13RBp4lJZRMziv6bU6hTxgLDt/h0fjNuxY6LuXtN454RJZpNM
	UP/fvvnbldo2OoASJ8pg==
X-Google-Smtp-Source: AGHT+IFZCjle/Q7DoNRPzIsQcC2P5LX9q6P3qC5YRcMiyHyB4SbwbXVYepWPxGL5UFFSztnj/OIOSw==
X-Received: by 2002:a17:907:e98b:b0:afe:7bc0:4d0e with SMTP id a640c23a62f3a-afe7bc04e59mr1010118666b.23.1756315170296;
        Wed, 27 Aug 2025 10:19:30 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afeadca2988sm393439966b.19.2025.08.27.10.19.28
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Aug 2025 10:19:29 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-61c24250b38so44306a12.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Aug 2025 10:19:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWV+LPwnuGlJaICZD7D9yOnFXq18D/9Sw9dqcen22boLtTuF50ZPCgwrfqpo35uCuHfhrrF1RjktfmT6EhF@vger.kernel.org
X-Received: by 2002:a05:6402:4408:b0:61c:87da:4c06 with SMTP id
 4fb4d7f45d1cf-61c87da5164mr6973273a12.21.1756315168210; Wed, 27 Aug 2025
 10:19:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250825044046.GI39973@ZenIV> <20250825-glanz-qualm-bcbae4e2c683@brauner>
 <20250825161114.GM39973@ZenIV> <20250825174312.GQ39973@ZenIV> <20250826-umbenannt-bersten-c42dd9c4dc6a@brauner>
In-Reply-To: <20250826-umbenannt-bersten-c42dd9c4dc6a@brauner>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 27 Aug 2025 10:19:11 -0700
X-Gmail-Original-Message-ID: <CAHk-=whBm4Y=962=HuYNpbmYBEq-7X8O_aOAPQpqFKv5h5UbSA@mail.gmail.com>
X-Gm-Features: Ac12FXwqfqnkmUEn7hEXyjAiow7ocMtB0dGx5uX-cnUp2yMJpSlLhTS8u2Jlf50
Message-ID: <CAHk-=whBm4Y=962=HuYNpbmYBEq-7X8O_aOAPQpqFKv5h5UbSA@mail.gmail.com>
Subject: Re: [PATCHED][RFC][CFT] mount-related stuff
To: Christian Brauner <brauner@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
	Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"

On Tue, 26 Aug 2025 at 01:56, Christian Brauner <brauner@kernel.org> wrote:
>
> I'm not doing that for my own personal wellness cure

Please only do this for things that were actually discussed.

Because for *my* wellness cure, I get really damn annoyed when I
wonder about some context of a commit, and follow a link to look at
the background, and all I see is that SAME DAMN PATCH that I already
looked at, and wondered about, then that link damn well wasted my
time.

It's annoying as hell.

And no, some "maybe people add acks or context later" is not a valid
reason to add a link. If there was no discussion about it at the time
it was committed, a link to some mailing list posting by definition
doesn't explain why the commit exists.

                    Linus

