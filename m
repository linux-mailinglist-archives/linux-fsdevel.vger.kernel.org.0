Return-Path: <linux-fsdevel+bounces-25046-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A57D19484D8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 23:34:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 173C3B23573
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 21:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16D8016F91D;
	Mon,  5 Aug 2024 21:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="dTZT/y/B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A999F16D9DC
	for <linux-fsdevel@vger.kernel.org>; Mon,  5 Aug 2024 21:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722893324; cv=none; b=agNZ6Ci928kOp9Ax9iFAVIDZdT3Pm/BslEESU4K3m+85CNWkSVSF8TSvhcoJxcd2GvZ1FLE6KtELTZGRtvfJdoTg+L9l0enzJK8HEknY7ulHF9dwuchpVvnrmROuag+gmg7uJj7wnQgPCu7idpY5/igUVEt78um5WrCbft4bioA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722893324; c=relaxed/simple;
	bh=CTTjcSVZh00GG8bK8bn079xIUwIcu3ks1xC9HUn/WHo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZnX65Hnqii4fmT82UCO9erH1tMiKRsDk6FSI3nGZJ8vQwcmX9UutA/FXAQ1avKD1GkSBxcgCnYStzR4Tplt2o8Y6tTYONXQ/q+IClaHtb8UcZEuMK9MbuDeno7wWsGfBg8YjyV610agfeWceNUuJH6qgDARhY2/fQ7UD3i4fQX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=dTZT/y/B; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52f0277daa5so17075556e87.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 05 Aug 2024 14:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1722893320; x=1723498120; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4JmhoGoeqp0EkHzxnqjsByi1+fgV+qGizB/Udaf1KjI=;
        b=dTZT/y/BmtXDpNcwqQMY3r3ejI4e59QXjXxyGeNXYZD6tW8wNuCQ4kCQQBZn0lvYBO
         DmXZRZ/73uIhMLyk1j5H8HTMiGkEJcEXqN1L71oINzOYy4qxj7xqtXPeA+horB6a5PC8
         UALAjaTOlI0ZqPh9wNw6eezhLySxTMLWvYomk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722893320; x=1723498120;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4JmhoGoeqp0EkHzxnqjsByi1+fgV+qGizB/Udaf1KjI=;
        b=oLd/dxm1KLFCpASYxdxKhWfXKg20HFpFYDB0Lw3GG/+iF8g6ZhW1+cZLYJvKyAAbVD
         1rv6LiP/St37IiTN1dt0gp5TvzZnXHaahF4WHMEQbg+bhwhAt7azjcD3EjkO+m5cLfA4
         QxEZ5a7pFD2DMjQlUnGf0QwQApBrcGTY0Q9Pv4SaTzyzudIdXE8RFoF/W9vbn1LLM933
         9Sl8zm4gbKnfvyqwRULB4eVB7VFIeabaOhUG7q9ARcEL7ynJtvyvocxUciesl/VufwIn
         xcr2oFvWSn5rYUM03QJQQJa+TIwhG7+KecMmc4dHHmWXBMxqz0N+vcQI4O/Ib71+ojKr
         yBhg==
X-Forwarded-Encrypted: i=1; AJvYcCX/Mjzc38KrPQgfezcOxjZriYRHXW5PSJgr/xmNz24o1a+3k4jzpWKX4DuO5Z7BI7DXKTNLiKB0XxLzuzX2pIIqG4WgZea5hHNwJ02qgw==
X-Gm-Message-State: AOJu0Yzch84uXETSI2jMIgsMpea4KEzkWTmlD/wJ0AMlkFPMWMrOZbBM
	i7xR8GTbyNDgZ2Th6jsT6N2J7wS84RaQO60ny8cA66GdSVRVt75z+K2F0zXmceqbuI6pUxZSLKo
	zqFDZag==
X-Google-Smtp-Source: AGHT+IEsM2cMXrCLN7rZxvXCyAO4LD55Qs9dwhpTo7LQxER7PXiqNMBUobt+2ekfQCGNslF5izQNpg==
X-Received: by 2002:a05:6512:e9d:b0:52c:d27b:ddcb with SMTP id 2adb3069b0e04-530bb366800mr9774715e87.3.1722893320241;
        Mon, 05 Aug 2024 14:28:40 -0700 (PDT)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9ec8dafsm489983366b.220.2024.08.05.14.28.39
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Aug 2024 14:28:39 -0700 (PDT)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5ba43b433beso2515358a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 05 Aug 2024 14:28:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW+hbmmKn7EYAhEUa+W7sDkOxuoadAlrAFo4ArJiEc71brMAfozZqy55exZFJVZSsi/XLB9SfgAWP/49EccfpWsHSj5HStulfIs3Yt0PA==
X-Received: by 2002:aa7:df97:0:b0:5af:758a:6934 with SMTP id
 4fb4d7f45d1cf-5b7f0fc7f1amr8956337a12.0.1722893319128; Mon, 05 Aug 2024
 14:28:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240804075619.20804-1-laoar.shao@gmail.com>
In-Reply-To: <20240804075619.20804-1-laoar.shao@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 5 Aug 2024 14:28:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=whWtUC-AjmGJveAETKOMeMFSTwKwu99v7+b6AyHMmaDFA@mail.gmail.com>
Message-ID: <CAHk-=whWtUC-AjmGJveAETKOMeMFSTwKwu99v7+b6AyHMmaDFA@mail.gmail.com>
Subject: Re: [PATCH v5 0/9] Improve the copy of task comm
To: Yafang Shao <laoar.shao@gmail.com>
Cc: akpm@linux-foundation.org, ebiederm@xmission.com, 
	alexei.starovoitov@gmail.com, rostedt@goodmis.org, catalin.marinas@arm.com, 
	penguin-kernel@i-love.sakura.ne.jp, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	audit@vger.kernel.org, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 4 Aug 2024 at 00:56, Yafang Shao <laoar.shao@gmail.com> wrote:
>
> There is a BUILD_BUG_ON() inside get_task_comm(), so when you use
> get_task_comm(), it implies that the BUILD_BUG_ON() is necessary.

Let's just remove that silly BUILD_BUG_ON(). I don't think it adds any
value, and honestly, it really only makes this patch-series uglier
when reasonable uses suddenly pointlessly need that double-underscore
version..

So let's aim at

 (a) documenting that the last byte in 'tsk->comm{}' is always
guaranteed to be NUL, so that the thing can always just be treated as
a string. Yes, it may change under us, but as long as we know there is
always a stable NUL there *somewhere*, we really really don't care.

 (b) removing __get_task_comm() entirely, and replacing it with a
plain 'str*cpy*()' functions

The whole (a) thing is a requirement anyway, since the *bulk* of
tsk->comm really just seems to be various '%s' things in printk
strings etc.

And once we just admit that we can use the string functions, all the
get_task_comm() stuff is just unnecessary.

And yes, some people may want to use the strscpy_pad() function
because they want to fill the whole destination buffer. But that's
entirely about the *destination* use, not the tsk->comm[] source, so
it has nothing to do with any kind of "get_task_comm()" logic, and it
was always wrong to care about the buffer sizes magically matching.

Hmm?

                Linus

