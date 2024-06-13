Return-Path: <linux-fsdevel+bounces-21681-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 369C6907EBB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jun 2024 00:18:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35E231C21C82
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 22:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 175CF14C5B5;
	Thu, 13 Jun 2024 22:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="T2tnF733"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6AB14B950
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Jun 2024 22:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718317096; cv=none; b=EkKU3LecNeSFnePplLYuuzj1eZ02b3v2p8G1umw03L2qQqzRhGNDycOhD6F7c+NbX0vfZAEaBvXs58lPIuuyGMcpMBkNkc032tqJfyJYPBcTGx+pu0DN8wvGoDZD7wQUn1MFAxOI8P/60Ez7P2FuQoPgrnMBLlViyYUCt+Lyhng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718317096; c=relaxed/simple;
	bh=GspCeXbe53JYdKAHLrPNjz5Bk3zxp4umRvOyOhKibSg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hq6U90eyeEvt8yMECYwNrRFqHep/Bl4yha/t06xYamh5zqEgQKHscXtBqOyj67KSwU7UHYafHFZnezJ5QLSCjSumIAOhQgAbnnaFmtqpQdAv+YEkI5o5vm9owAA3Y6Rky892cWlTv931y0EQ+syX4van9LqJSFkoblQ6m3qCdb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=T2tnF733; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2e72224c395so14045391fa.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Jun 2024 15:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1718317093; x=1718921893; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ivv8xxFePEFaIPZc0G+v3++kMFBsUSKEIP1k/xbjdQI=;
        b=T2tnF733UAe9Y4nUwJuReNyBT6Fm2MMTW67nnizZbHZ3KuzfIPIvCoyBPY9wd2gIW9
         ZmdTgiU70M8jF9OFVtKsaJesy6RZILjIhvlSaSOHyqT9xAd5YPTAL+J0YRvGspOG82fv
         lqvxHt9ZY2ES90gmIk8dR3pkhUFZvDgEHVkNU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718317093; x=1718921893;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ivv8xxFePEFaIPZc0G+v3++kMFBsUSKEIP1k/xbjdQI=;
        b=X5izums44rXqPLe96CETbhi2PpijD2zvJY5dB3SC1Lqvw9MW7HrleHbMzT4Owc3bdP
         87lFNc0lcy/FkbYVjbSKSMFtMmnygLkTZ2PyM+2Z/4NPPuxOLAYKdS8g7+xt/vFYNxSP
         TVx6ArilfK/g/AJTNw7trjRi+4wPdto1JbmYKX3R46/sDENGPQGbglErQ5uPhTJGWrHK
         s1Ii4OHCAnr7zD2kKGpf+8LDnbNRldIvXqpeI32fMroLG4ep632iL+ui19cyuuKDxrzd
         2kQViiFU94fFILRaPM7dJx/xnw9grF9eYPjBHBkg6gNeLBuq9T6mYGpsMA8O2ixqnRWT
         ML4A==
X-Forwarded-Encrypted: i=1; AJvYcCULyt6yE3ex/JvHmJaxsfg42KDK0EuO2G4fMCEr+wUEWmTKKTUkPINKckf8BQOe7WAEmOv1ULiYn85dppF7vhB1i+/+SQfrgj1jHK9bOg==
X-Gm-Message-State: AOJu0YxvPYv5xqKY39wEMhsK2MXMmHQA/GBJJy/BAETkFwdCc00BHBow
	kNeKEmqt+Of2pW71nvJqQBXpXOEYwGs4mQ7F352V8HzHvbJxxAet9dLeZZdNz6MZUHYhYbFs59Z
	gMuNgkg==
X-Google-Smtp-Source: AGHT+IG+fi7b+ZeXZsRCcs5qbPvmaPWXblYQj7ykFr0kARQq41jT8EQyxtpwP/5l4v1IzfGLLlgRFg==
X-Received: by 2002:a2e:9141:0:b0:2ea:ea29:32b2 with SMTP id 38308e7fff4ca-2ec0e5d1193mr6351431fa.31.1718317092623;
        Thu, 13 Jun 2024 15:18:12 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ec05c05005sm3797601fa.44.2024.06.13.15.18.10
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jun 2024 15:18:11 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2e72224c395so14045111fa.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Jun 2024 15:18:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUCEf84J6PT7uKGhHnS6lKYe/RsP+YGVr9oLCucCVBWwubiOrvadsmFTaqcVtDujaDt6wteoByT949K+yS6JO9SQqkBvL6Gtr5xwXSbUg==
X-Received: by 2002:a2e:92d6:0:b0:2eb:242b:652a with SMTP id
 38308e7fff4ca-2ec0e5c6ce9mr6646061fa.15.1718317090589; Thu, 13 Jun 2024
 15:18:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613023044.45873-1-laoar.shao@gmail.com> <20240613023044.45873-6-laoar.shao@gmail.com>
 <20240613141435.fad09579c934dbb79a3086cc@linux-foundation.org>
In-Reply-To: <20240613141435.fad09579c934dbb79a3086cc@linux-foundation.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 13 Jun 2024 15:17:53 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgqrwFXK-CO8-V4fwUh5ymnUZ=wJnFyufV1dM9rC1t3Lg@mail.gmail.com>
Message-ID: <CAHk-=wgqrwFXK-CO8-V4fwUh5ymnUZ=wJnFyufV1dM9rC1t3Lg@mail.gmail.com>
Subject: Re: [PATCH v2 05/10] mm/util: Fix possible race condition in kstrdup()
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Yafang Shao <laoar.shao@gmail.com>, ebiederm@xmission.com, 
	alexei.starovoitov@gmail.com, rostedt@goodmis.org, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	audit@vger.kernel.org, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 13 Jun 2024 at 14:14, Andrew Morton <akpm@linux-foundation.org> wrote:
>
> The concept sounds a little strange.  If some code takes a copy of a
> string while some other code is altering it, yes, the result will be a
> mess.  This is why get_task_comm() exists, and why it uses locking.

The thing is, get_task_comm() is terminally broken.

Nobody sane uses it, and sometimes it's literally _because_ it uses locking.

Let's look at the numbers:

 - 39 uses of get_task_comm()

 - 2 uses of __get_task_comm() because the locking doesn't work

 - 447 uses of raw "current->comm"

 - 112 uses of raw 'ta*sk->comm' (and possibly

IOW, we need to just accept the fact that nobody actually wants to use
"get_task_comm()". It's a broken interface. It's inconvenient, and the
locking makes it worse.

Now, I'm not convinced that kstrdup() is what anybody should use
should, but of the 600 "raw" uses of ->comm, four of them do seem to
be kstrdup.

Not great, I think they could be removed, but they are examples of
people doing this. And I think it *would* be good to have the
guarantee that yes, the kstrdup() result is always a proper string,
even if it's used for unstable sources. Who knows what other unstable
sources exist?

I do suspect that most of the raw uses of 'xyz->comm' is for
printouts. And I think we would be better with a '%pTSK' vsnprintf()
format thing for that.

Sadly, I don't think coccinelle can do the kinds of transforms that
involve printf format strings.

And no, a printk() string still couldn't use the locking version.

               Linus

