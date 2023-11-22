Return-Path: <linux-fsdevel+bounces-3455-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BE1F7F4EE8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 19:05:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 528AB1C2095D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 18:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F5C458AB7;
	Wed, 22 Nov 2023 18:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="bMPYynvP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7342B1B5
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Nov 2023 10:05:23 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2c887d1fb8fso985521fa.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Nov 2023 10:05:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1700676321; x=1701281121; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Gq1921R5qonz0jKq21RQx690MDT5ZQbM5JVJ9K0dwUU=;
        b=bMPYynvP93a9ydw3pBXJ/hsOtcw9UaMA8dnOeSQxZOEs4zEr+DAep7A097Lf8SAnHY
         G9mHgcLKFcvUbefprI6sspDnPxV5KrpksMOH1Pr42zF1Upjax7wIEfB5GDuCJjsqwjVR
         suF5cY+sVUliZV6sHtdD2CtRX839G1uBhaAZw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700676321; x=1701281121;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gq1921R5qonz0jKq21RQx690MDT5ZQbM5JVJ9K0dwUU=;
        b=Uvk9SIwJRFt2TvZz4DadUKu1/as7hLu0qH3uRhueHAlt84jeOvPVbs3YK6XDZGGZoi
         qvfAcTMrZ/hzVeKqmYLv+WTsQ3AEqUHuztLmGuC0w4baoMSFI7ITGvyTzJAW/Ub+jKnx
         nuY0mN4qRqb3C0TO3WZG3a7UlLC37R1YZL0mx9naM4zWEbDwCIhECYty5Glx5x1WNkyg
         ipUe/Tb4ew5vKRC/SUs9BTxR+r+GyNQUN5IszmQISvqERs70xHcWq7MTWI0DwBG5KYSk
         yZHSrxed8kyNUhnizeUpZhD6abgAFXfgbX0LPWdlpzvZOIvdnlm3vT08xofkKYGZ977n
         56Zw==
X-Gm-Message-State: AOJu0YyQPfWhOuaU+xQ6ohIUqGt4dt7/yRATL6c0a3ULAmz5Fz9dCOag
	TrmHz3QlscOjAiKhB9mzbcL/IhCDMUKNelO/5FYU7g==
X-Google-Smtp-Source: AGHT+IEoy+h2EOruimIpaOG+Miv6E/dbSNOPG7lQcnrqjuYU5vpXPZhDIOSy4YsppmnDEziX/by8qg==
X-Received: by 2002:a05:651c:19aa:b0:2c7:2e27:5b46 with SMTP id bx42-20020a05651c19aa00b002c72e275b46mr2418739ljb.37.1700676321454;
        Wed, 22 Nov 2023 10:05:21 -0800 (PST)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id x44-20020a2ea9ac000000b002c83b0bd971sm7748ljq.2.2023.11.22.10.05.20
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Nov 2023 10:05:20 -0800 (PST)
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-507973f3b65so9997248e87.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Nov 2023 10:05:20 -0800 (PST)
X-Received: by 2002:ac2:531a:0:b0:501:c779:b3bb with SMTP id
 c26-20020ac2531a000000b00501c779b3bbmr2055715lfh.60.1700676319938; Wed, 22
 Nov 2023 10:05:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231031061226.GC1957730@ZenIV> <20231101062104.2104951-1-viro@zeniv.linux.org.uk>
 <20231101062104.2104951-9-viro@zeniv.linux.org.uk> <20231101084535.GG1957730@ZenIV>
 <CAHk-=wgP27-D=2YvYNQd3OBfBDWK6sb_urYdt6xEPKiev6y_2Q@mail.gmail.com>
 <20231101181910.GH1957730@ZenIV> <20231110042041.GL1957730@ZenIV>
 <CAHk-=wgaLBRwPE0_VfxOrCzFsHgV-pR35=7V3K=EHOJV36vaPQ@mail.gmail.com>
 <ZV2rdE1XQWwJ7s75@gmail.com> <CAHk-=wj5pRLTd8i-2W2xyUi4HDDcRuKfqZDs=Fem9n5BLw4bsw@mail.gmail.com>
 <CAHk-=wg6D_d-zaRfXZ=sUX1fbTJykQ4KxXCmEk3aq73wVk_ORA@mail.gmail.com>
In-Reply-To: <CAHk-=wg6D_d-zaRfXZ=sUX1fbTJykQ4KxXCmEk3aq73wVk_ORA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 22 Nov 2023 10:05:03 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjnKaBNzHau_yj=HZP2Cr2reJXp0zpp71uZ0OFZHRbRcw@mail.gmail.com>
Message-ID: <CAHk-=wjnKaBNzHau_yj=HZP2Cr2reJXp0zpp71uZ0OFZHRbRcw@mail.gmail.com>
Subject: Re: lockless case of retain_dentry() (was Re: [PATCH 09/15] fold the
 call of retain_dentry() into fast_dput())
To: Guo Ren <guoren@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Peter Zijlstra <peterz@infradead.org>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 22 Nov 2023 at 09:52, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Bah. Might as well do the reference decrements with the same logic,
> not just the increments.

And thanks for reminding me about this issue. I just committed the
trivial one-liner fix for qspinlock code generation that apparently
never went anywhere (mostly my own damn fault for not having pushed it
enough and made a proper commit message).

               Linus

