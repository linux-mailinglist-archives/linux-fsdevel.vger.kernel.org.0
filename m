Return-Path: <linux-fsdevel+bounces-26384-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ADFAA958D1C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2024 19:20:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 609F81F2434D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2024 17:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD1F1BE228;
	Tue, 20 Aug 2024 17:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="TGuey5sy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DBC81C4635
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Aug 2024 17:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724174374; cv=none; b=N1Z8FOrLH0Dst8WSUeV4V+6aMZzP4zL8p8uzulKcyr3Pf5zfFCV0WyToW87Vhk4iNZqQk4L8mupo58VHURt/91m9okMosbZXX0WxhIbZ8j/47FrynCuobkll7a1uc5xGnz1hooov+iz2TXTMFQSMYCYtU6jH056RFw+Fto3YxUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724174374; c=relaxed/simple;
	bh=h8+rAT6PKkf3l/JsLf4+AjmrK3P6xlDQaWUbOqj5V88=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cAWL85QFyJ/uY9QUgZLzrmeTZJfK+HlSn8ppehLU7B7CNp3ZmiVbG5QgFMzH45x3Do10qaJ5CE9JxXow+BguFAqRBIkeJhCnSJWW8khJNz40H5DX0iZhUznlIuQtYvI/j4Upily2aZxtm1TZwdZ6gMDCO87LTMV7gJAAUrxn4XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=TGuey5sy; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52efd8807aaso7532505e87.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Aug 2024 10:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1724174369; x=1724779169; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6paAwPht6e0edIulQ9pkTptE1WNbdOgM93RCIpCEbrY=;
        b=TGuey5sySDHK0lLKBsw2/LkXY8ETmqdbmi7sOO0NTeb/8Skx/uNx6+mnzg1fvxELzX
         aUnizjt4awax5tWL1+0pbK4gDSlMXlQtO8o8P65dJ1uumxUtoKW/sB7rxozRjinXUW/K
         FePKsOKx4ZmbdyRnQjLUmhb5+eZht5uOtHSSk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724174369; x=1724779169;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6paAwPht6e0edIulQ9pkTptE1WNbdOgM93RCIpCEbrY=;
        b=tUlZPJA+JB44yQRiIjNTSg36zVkwXUgV1kCZb9NLt6WW0DUzzAd2jQAd7rV1S+u4qk
         JHV6h9Dadmov/P8/Xrkkkedsr8ZgOlEsxzR+KG6Ar+EllFwuR63gQMf3CCTv+iZBH/Gx
         3CjjnlCuXfAqXjtSlWo/6K0NEfTYMzsNI7i118i00nPz71ja6XVCFQYyUZsS9+ysRRD+
         OxrZBkkH6mQmXD/qaQFPWEl3hCOo5Lf1hLrkSZM1dZ0FMHFWj1TFAzBaeLgCi0qaaANX
         gTBhX0BS1XF3CQ4e/hDd3Yrd0E8Be0iVpERLh8y8V4BUrmp8TqykOyQwsxr/wcmQLE54
         Mjfg==
X-Forwarded-Encrypted: i=1; AJvYcCU+8jnzjeoB/fuhvXjsnV3GB5G6ml7klsdPM7Lc6SRThdFwrZ9LtRWMbo41gCPd0nJSzKLSCH3XMxeXOb6P@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy3xe7HVIFwFQdD2lOaqp/3ZdWjli/Yt+28skgq70Wz7dTWXjP
	NQf6q4LHTf/inOYivQBFozScvP1+9T1z3n5A+CS4kaGFwc5kGq15Q2sMnm7OGesYeKArsvAwsDI
	8jhcP2g==
X-Google-Smtp-Source: AGHT+IE4kSHs/X21GBPyjJUduAEJxy5o9Wg0gCzPHTLiRXxtCvjsvK/OVejrzcPRW98tju1dwyBaSQ==
X-Received: by 2002:a05:6512:3989:b0:52e:fd53:a25e with SMTP id 2adb3069b0e04-533407870fcmr1554693e87.2.1724174369099;
        Tue, 20 Aug 2024 10:19:29 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53346869800sm22458e87.55.2024.08.20.10.19.28
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Aug 2024 10:19:28 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52efd8807aaso7532465e87.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Aug 2024 10:19:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUYz4QjNZCYzuqERsPLi2a8B1mWuwR+xVrvJ5jG7zPVrFWaf6xHNjo1+zxqhW0zMcmsPqbnBShGQqBrZP8U@vger.kernel.org
X-Received: by 2002:a05:651c:54b:b0:2ef:26dc:efbe with SMTP id
 38308e7fff4ca-2f3e9fdb1eamr25221991fa.42.1724174367649; Tue, 20 Aug 2024
 10:19:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240820-work-i_state-v1-0-794360714829@kernel.org>
 <20240820-work-i_state-v1-1-794360714829@kernel.org> <CAHk-=whU6+8ndPZjXnebdW-LK+oVnp07e7EfY1M3yhdDpcinLg@mail.gmail.com>
In-Reply-To: <CAHk-=whU6+8ndPZjXnebdW-LK+oVnp07e7EfY1M3yhdDpcinLg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 20 Aug 2024 10:19:11 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgxDM_g+PHPriey7J8OEy49dAKx2D5ASFXPuaed=x86-A@mail.gmail.com>
Message-ID: <CAHk-=wgxDM_g+PHPriey7J8OEy49dAKx2D5ASFXPuaed=x86-A@mail.gmail.com>
Subject: Re: [PATCH RFC 1/5] fs: add i_state helpers
To: Christian Brauner <brauner@kernel.org>
Cc: NeilBrown <neilb@suse.de>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

.. and one more comment on that patch: it would probably be a good
idea to make sure that the __I_xyz constants that are used for this
are in the range 0-3.

It doesn't really *matter*, in the sense that it will all just be a
cookie with a random address, but if anybody else ever uses the same
trick (or just uses bit_waitqueue) for another field in the inode, the
two cookies might end up being the same if you are very unlucky.

So from a future-proofing standpoint it would be good if the cookies
that are used are always "within" the address range of i_state.

I don't think any of the bits in i_state have any actual meaning, so
moving the bits around shouldn't be a problem.

                 Linus

