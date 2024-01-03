Return-Path: <linux-fsdevel+bounces-7270-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1AA9823775
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 23:07:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 784441F25EF4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 22:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A05261DA46;
	Wed,  3 Jan 2024 22:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="FIFhC+JR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7962A1DA2C
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jan 2024 22:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2ccb4adbffbso96284871fa.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Jan 2024 14:07:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1704319624; x=1704924424; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SGTvqwTPDHKOw2dBon6pGIVG5u9VcyiSKusgLBhPCPA=;
        b=FIFhC+JR94gPZmt6bdpLxo31FgCF8ds5TUEmsVAFCZF9uxJpbkJgGw5zZ87reZHYPd
         vf3zYFoIFENzFZ6RJ8Pkmdtwsajq08Z7/G63WaBrs8dI/5dXE23M+QD6/I+46Uv+2PjW
         Y84l0I1EyLwPDrumVylVnfUjToxh43zm0jts0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704319624; x=1704924424;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SGTvqwTPDHKOw2dBon6pGIVG5u9VcyiSKusgLBhPCPA=;
        b=Yawwa6jgTv5V9Lnxl+mY7D+4MP8CYF0mIKi2c51i+0T5CnpCDck+cOMPKZACTCY3CH
         7U1J4v1oXyiXH0nVPBHEUswB9EHinnc/rx7Zg1g9I9aK80gjQIv2Tj8MBg/EE1dgRZpj
         x1r6tA7DfHvh0l4n6rYv1OUObt+KR13MMlmTFmnjsBpgaPqJwDoeMneq4Gf8nqh66V4p
         bEm5qJFFM83yu4SACGwU0oGZAAvqKpEOBDPb5HhG0H5BqRRilhUP/AJPAb+fuWUYH6t1
         Eir1QuuvA3PUd0PIj2um01WUdhV7HXYDLhln7QwBBMSpeDVXLOZssXG0PnrA5s+3go/S
         3m8g==
X-Gm-Message-State: AOJu0YxoANuR7uUfb6rKdPRk2aEeEaVPhPgypgWUQnrnLaYtVB55HKKg
	GHAiROLEoOCCQIr4wgjsiqzIpsWriYi/DrvWc1xS8kvWudqOQOlZ
X-Google-Smtp-Source: AGHT+IHcrYztlh4Nvv7C+FGk7vW4RcS+NBtwP1UMHh/SPY+5r31PRLz/S3j6Pt5E4X6I2YosliJtOw==
X-Received: by 2002:a05:651c:b0c:b0:2cd:1ae2:ba67 with SMTP id b12-20020a05651c0b0c00b002cd1ae2ba67mr744069ljr.32.1704319624427;
        Wed, 03 Jan 2024 14:07:04 -0800 (PST)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com. [209.85.128.47])
        by smtp.gmail.com with ESMTPSA id h12-20020a0564020e0c00b005561a8c2badsm5797656edh.83.2024.01.03.14.07.03
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jan 2024 14:07:03 -0800 (PST)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40d88f9e602so27574255e9.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Jan 2024 14:07:03 -0800 (PST)
X-Received: by 2002:a05:600c:3c94:b0:40d:62fe:a160 with SMTP id
 bg20-20020a05600c3c9400b0040d62fea160mr5605515wmb.93.1704319622802; Wed, 03
 Jan 2024 14:07:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240103102553.17a19cea@gandalf.local.home> <CAHk-=whrRobm82kcjwj625bZrdK+vvEo0B5PBzP+hVaBcHUkJA@mail.gmail.com>
 <CAHk-=wjVdGkjDXBbvLn2wbZnqP4UsH46E3gqJ9m7UG6DpX2+WA@mail.gmail.com>
 <20240103145306.51f8a4cd@gandalf.local.home> <CAHk-=wg=tnnsTjnzTs8xRQOBLvw4ceKe7=yxfzNtx4Z9gb-xJw@mail.gmail.com>
 <CAHk-=wh5kkk2+JAv_D1fm8t1SOpTQyb4n7zuMuVSBG094HH7gA@mail.gmail.com>
In-Reply-To: <CAHk-=wh5kkk2+JAv_D1fm8t1SOpTQyb4n7zuMuVSBG094HH7gA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 3 Jan 2024 14:06:45 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgJouS5fWAf7ReooLLES0rq2F=V1s-fPyLDX+OoXX+JBw@mail.gmail.com>
Message-ID: <CAHk-=wgJouS5fWAf7ReooLLES0rq2F=V1s-fPyLDX+OoXX+JBw@mail.gmail.com>
Subject: Re: [PATCH] eventfs: Stop using dcache_readdir() for getdents()
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Al Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 3 Jan 2024 at 13:54, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Here's an updated patch that builds, and is PURELY AN EXAMPLE.

Oh, and while doing this patch, I found another bug in tracefs,
although it happily is one that doesn't have any way to trigger.

Tracefs has code like this:

        if (dentry->d_inode->i_mode & S_IFDIR) {

and that's very wrong. S_IFDIR is not a bitmask, it's a value that is
part of S_IFMT.

The reason this bug doesn't have any way to trigger is that I think
tracefs can only have S_IFMT values of S_IFDIR and S_IFREG, and those
happen to not have any bits in common, so doing it as a bit test is
wrong, but happens to work.

The test *should* be done as

        if (S_ISDIR(dentry->d_inode->i_mode)) {

(note "IS" vs "IF" - not the greatest user experience ever, but hey,
it harkens back to Ye Olden Times).

                Linus

