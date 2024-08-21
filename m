Return-Path: <linux-fsdevel+bounces-26563-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBC9895A7F0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 00:53:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80209284B05
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 22:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B8B217BB00;
	Wed, 21 Aug 2024 22:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="P8n/w3Qf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF56168497
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Aug 2024 22:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724280830; cv=none; b=XLg9rmN9z54q/SMJo96GGYnZrL0Z/AWEVDB425C7Q9Qjig83V5s2c/6XdlM8RmCHS81oHJCMxmVbNNLfMPg3lFQ8GVTgIqZn0Jsxlpu5mjxhuj77LaM6bv97LKMDtGErIvU3lZ/+i6J3xUpZ933Y66CmhGxwgvByvw/cpmlfTeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724280830; c=relaxed/simple;
	bh=sYHcltixyJC9BU/MLb7HzoJd+QTv9zJpqQlJQYncUPE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SPdcd7eNf97LUBahrR6zHajdThZbTNlXAvr7K8/C7QkphCsN8VSzQuOMPrrzpDEKQw5H9pYn7Xf3LbqINLRHGQkf01bODCOSIAlFJNzuP6uukQupUmuSLm5kKxt7oidSSDwVPd+1gwqT/4sYH6ksyZffQRHRC6hcMJ4hHroXTjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=P8n/w3Qf; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2f3edb2d908so1760311fa.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Aug 2024 15:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1724280826; x=1724885626; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=p+HYCIGDmbAGvPO4lszl1UyZkDNKUCxUn11dV2OZ4OE=;
        b=P8n/w3QfT3X9fU/IgPtmksVb4mBU6ia6Mt0siBL0+wggKq7OQ1CcSZCpC/oRXJLLJU
         xW6drkKvlkih6SVfIg0mqEWoR+lsqPpzcwgSfENuBh83K3n1Vuiv8b2Mdk9Ra3y/E6KT
         srwXY3xqfdiCtNdQb51kwaHkKGjPGFwllOqsY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724280826; x=1724885626;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p+HYCIGDmbAGvPO4lszl1UyZkDNKUCxUn11dV2OZ4OE=;
        b=iB8Jxq7VI7cmkToGcdVmt1vabfeQrT1ac4DgOSFsBkbykK9cqDtoYrMbU+kclR+Kxu
         ISaW7y4Fhl2VGjxus+iS4BW6F8G2lKLSTwi11c9PD3t9V/tSPmXvK4za/h3y5v5za1Kc
         W0UPgbHZ5q+lpoQ6WZHJMoanGMeg2haZmnFa3H5nCm6zcYyAFU04VtrWgddYieKAZ4GZ
         3vfD10HOIVYyZSOAyBNCMxUY0ps7zW/lZfhF1Bjltv75vtQ0qIERe/RLd1BtUunjLaK8
         W86c4mlBrYE3PetB0wD7sYoAdcIV0W2dGilI3kLGlxydCCkWyPachuKWUa2GpYmhEsDL
         w+Cw==
X-Forwarded-Encrypted: i=1; AJvYcCVgSXPYYUj0bvhWtSvWeFsW5n84L8YQzlHzK+wIsTLLx70Sy4oSRUTyQKL6rZDKgp5JL+MsZRe2TsILX8Gt@vger.kernel.org
X-Gm-Message-State: AOJu0YyZmWzUir8P3XfmHLUo5tdVJpivO8UvKFk9L2xA+XiuaWvgGUsA
	Q+X76WbyQiCchtQjrM0Q4o86VJkm3fPh278llcdLTt/c4AKZhhfmB/bdjuYRX8PLSt8HgeXws6W
	NrFPeZw==
X-Google-Smtp-Source: AGHT+IFnUZUmNQ6yLm/vsHK0RcSQEyjDCS6vQ9aaorRVyAsq5tmGLn4GpYNkw7YMSuFGW5yPKR3snA==
X-Received: by 2002:a2e:a9a8:0:b0:2ef:2f19:a8b3 with SMTP id 38308e7fff4ca-2f3f8b5732cmr26772601fa.41.1724280825556;
        Wed, 21 Aug 2024 15:53:45 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f4048add76sm216701fa.126.2024.08.21.15.53.44
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Aug 2024 15:53:44 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5334879ba28so224193e87.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Aug 2024 15:53:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVhjAC0sc/dVJjxhLUCDorA5u+hawlMOc9bwhvIjTYr88xa7PrrD2UbIbHDnIjFa63njE5qrWjF3wSHU7he@vger.kernel.org
X-Received: by 2002:a05:6512:3d86:b0:533:71f:3a53 with SMTP id
 2adb3069b0e04-5334855751dmr3079353e87.19.1724280824072; Wed, 21 Aug 2024
 15:53:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240821-work-i_state-v2-0-67244769f102@kernel.org>
 <20240821-work-i_state-v2-1-67244769f102@kernel.org> <ZsZqCttfl/QtMJqp@dread.disaster.area>
In-Reply-To: <ZsZqCttfl/QtMJqp@dread.disaster.area>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 22 Aug 2024 06:53:27 +0800
X-Gmail-Original-Message-ID: <CAHk-=whuOCMgsq_VyOfqj=j=AKGv2xHaCFReBwbh6+5VYi6SZw@mail.gmail.com>
Message-ID: <CAHk-=whuOCMgsq_VyOfqj=j=AKGv2xHaCFReBwbh6+5VYi6SZw@mail.gmail.com>
Subject: Re: [PATCH RFC v2 1/6] fs: add i_state helpers
To: Dave Chinner <david@fromorbit.com>
Cc: Christian Brauner <brauner@kernel.org>, NeilBrown <neilb@suse.de>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 22 Aug 2024 at 06:28, Dave Chinner <david@fromorbit.com> wrote:
>
> wakeup_var() takes the wait queue head spinlock

That's the part you missed.

wake_up_var() does no such thing. It calles __wake_up_bit(), which does this:

        if (waitqueue_active(wq_head))
                __wake_up(wq_head, TASK_NORMAL, 1, &key);

and that waitqueue_active() is lockless.

That's the thing that wants the barrier (or something else that
guarantees that the waiters actually *see* the new state after they've
added themselves to the wait-list, and before we then look at the
wait-list being empty).

See the comment in <linux/wait.h> above the waitqueue_active().

And yes, this is annoying and subtle and has caused bugs. But taking
waitqueue locks just to notice nobody is waiting is very expensive
indeed, and much more expensive than a memory barrier when the common
case is typically often "nobody is waiting".

               Linus

