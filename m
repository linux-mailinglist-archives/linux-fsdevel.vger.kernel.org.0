Return-Path: <linux-fsdevel+bounces-58332-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C844B2CA98
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 19:31:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12FCC189DE0C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 17:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E45E72FB984;
	Tue, 19 Aug 2025 17:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="F1nYIJI0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B6A1BDCF
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 Aug 2025 17:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755624703; cv=none; b=qL57Kt8zJb/l9yQkGEYFlu8/t1ypRvsW6yMEyVfnJH8ys3l3fOqIKG3S28k/byC583N0xZrWN8Tvg5rMBbUXO6k7Ff0v1y3etXKpWhukiKUVRyMYszbJlBWs8sZ+PJoPiWsIQWCl9vdBBv8hDTc8UbZIarWNdh7qPHsYcnNKGRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755624703; c=relaxed/simple;
	bh=I61z+mtYNBhAyJVH1fkp2wLzl2ZNunhH9aHYPER9ndc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S2vC/7lQ1W/W2nsxEwDnCxR0T8jcfAPBgUxTGFWYbB5PRaa+ug48Lkn01bQtmW6TLKpRtkXjEuhIR/gAPHenplR/mFytmKWAo3lb7uQpd/6xI8n2fGsnI/vim/y/HWe3x36Pz9Rs0hC+Xf69LHeDK+NVKgLQMhu4W7QPoaPN5mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=F1nYIJI0; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6188b6f501cso6717811a12.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Aug 2025 10:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1755624699; x=1756229499; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Z/R/kErobH1DOekM+cr6Z5l5drtfncbuYR4IyU7trEE=;
        b=F1nYIJI0OPPTJSpGh83ntaT0kDew4Bf39x8O4DrwMjASxxKsIGeYeq/WhuGTe5jdfP
         ZAOuzH48DoLuTYVQK4D11HigZZ6MLLBEHnrp6/iupj45q9u4VInYEN3AbyCuqXFQU/wO
         GXGCfTvmdiLg/7mu+mPmgpODzO9Gx0LoObXQk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755624699; x=1756229499;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z/R/kErobH1DOekM+cr6Z5l5drtfncbuYR4IyU7trEE=;
        b=AzFeZJzuQuRsVMFBirDrnL13lK+ZXMJqZNr3ZAII4NBptiHG1ngnIb62ZuK1ialZXb
         SJF0PwNZd5cuN6YT7CktRn/xnfHh+AqPtcfEUgmKuwnqcYS9p/kVkmYi8/V5TKGZ174w
         Ir5ax1xSImYCl7JiFLypz32kzfgZvoi1gOLcrdchRpsFOU5Cx9O6QKZ/Qc+Ej2lzJqIR
         3N4ao84+kJYQG/6VSzkSuCuzRO36IM9eOInW7PhPbJpVXYBLCWLslepeGtqjIk5Eb20s
         6DBRcs8D0S37PMdeh782ZBzEBh0oC7AiY6Ir9/hg2wkGY0Ie0dd2E0J8zP3Xm4d5U+nH
         WmsA==
X-Forwarded-Encrypted: i=1; AJvYcCUEMAWmbboxzaKD9ADunp8tdMSgaaht2wR9OPD4bVMcHCDDNMhbCCDLVtk/7QzEmCCMWp77FPorO3do6MjU@vger.kernel.org
X-Gm-Message-State: AOJu0YwCbbyhXQr4SaCID+MVl8/7UMRMSC5nOlyYkZi7qAMMdIx2J4Hg
	2YeJO9LD0ejw76n/H22ukfEj8kRkeYJ8FZLPLY3zs9ZpzGkJBu6R8kjQaisuUrY4NZwHdPM6hDA
	+K4DpTkw=
X-Gm-Gg: ASbGncvNzCyRWuSrGWRBGwPr4ZOu/1tkKZlUoKGZbkMER66VD/2gfGR6tCPHlTBa1oY
	oTY+OiB4ujSrTAtNFmzqscqChuq9v9mu4INNA73VaZZkXYe4U7Rf+lBPom7J2hTSr/H2TJVDt8I
	pfCjaWgSks0cItVYloOIfxEjz8GrzIydEjjM541BSkh5MSUkpuZBqSmly1Q+yEDp4Wf5+hh3yfB
	/jlP2TWIoLWqB+9Cd1LRm+6C6nGcLDYJZg1mvNCmX09z9ipPT6BsbFiH3yNBk4bA34PKrFc1sa6
	oo18QuYF8i4o3a8QnrLWNvJoPVhZLBWF1RmTzPmzTUKR6BmScxq/sj+AdC5gu6pfo74VQvNBjhT
	4VTxJJzDKmH4guADvifMuCdjv2auJ6/asZIOHd7qMpkBXg2yXjtUJNV1vxyMz6Rs9Kae4FC8T
X-Google-Smtp-Source: AGHT+IFkrauQez+D6qEy6opzSdjs79A1CEfFbB/Aq/S3SfYDs44T/5haGS9AIBV5vCWNzn2BcOC2xQ==
X-Received: by 2002:a05:6402:438b:b0:618:40ef:fa47 with SMTP id 4fb4d7f45d1cf-61a9752bd31mr148386a12.1.1755624698326;
        Tue, 19 Aug 2025 10:31:38 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61a755f876bsm2059023a12.13.2025.08.19.10.31.37
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Aug 2025 10:31:37 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-61a2a5b0689so5142134a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Aug 2025 10:31:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUn/786592y6j0TDWpSJ/L60OJCGHLiW7uZWyUCngEoDSkSNiYYUj7eLJwjiPm7B+Ujs46EGFrFYydGwNaZ@vger.kernel.org
X-Received: by 2002:a05:6402:13c7:b0:618:3a61:b1c with SMTP id
 4fb4d7f45d1cf-61a97833eedmr124687a12.31.1755624697200; Tue, 19 Aug 2025
 10:31:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250815233316.GS222315@ZenIV> <20250819161228.GH222315@ZenIV>
In-Reply-To: <20250819161228.GH222315@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 19 Aug 2025 10:31:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=whrhpSZ-wd+GA8hhK-zp6YQsC7rXwK34AZoMq00y6VKwQ@mail.gmail.com>
X-Gm-Features: Ac12FXwjiW0502rGrJxNJRPlUsk4VClKf48UniKUvlKbf6nptktKxtWSNh1KfZA
Message-ID: <CAHk-=whrhpSZ-wd+GA8hhK-zp6YQsC7rXwK34AZoMq00y6VKwQ@mail.gmail.com>
Subject: Re: [git pull] mount fixes
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	"Lai, Yi" <yi1.lai@linux.intel.com>, Tycho Andersen <tycho@tycho.pizza>, 
	Andrei Vagin <avagin@google.com>, Pavel Tikhomirov <snorcht@gmail.com>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 19 Aug 2025 at 09:12, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> (collected *-by and slightly cleaned the text in commit message of [3/4]; otherwise
> identical to what had been posted and sat in #fixes)

Minor note relating to my workflow: I almost overlooked this pull
request, because it was a continuation of a thread with the subject
"[PATCHES][RFC][CFT]", and then shows up in my mailbox as part of that
thread.

So even though you had removed those RFC/CFT notes from the subject
line, that ended up being not entirely obvious in my MUA, and I was
about to archive the email before I started looking closer.

Now, this time I obviously caught it, but in general it might be safer
to make it more obvious that it has gone from a RFC to a "this is a
real pull".  Not being threaded is obviously one way, or just a bigger
note to make it more obvious.

And hey, this is not generally a huge problem. I could miss emails for
other random reasons like flaky spam detectors or just plain
(hopefully rare) incompetence on my part.

So obviously the general fix to "why didn't Linus pull" is to send me
a follow-up email reminding me about missed pull requests, but I
thought I'd mention this as a "avoid potential delays and confusion"
thing.

              Linus

