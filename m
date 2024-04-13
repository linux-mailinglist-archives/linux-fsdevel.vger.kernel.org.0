Return-Path: <linux-fsdevel+bounces-16867-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 918E68A3DE1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Apr 2024 19:08:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B44D81C208F7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Apr 2024 17:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A4D94C637;
	Sat, 13 Apr 2024 17:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="arRQsuH2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268702BD19
	for <linux-fsdevel@vger.kernel.org>; Sat, 13 Apr 2024 17:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713028092; cv=none; b=ZwhobrqhN0cma3FkeiC/RQhBLU2jMnrL0GoeCn5cMJG3h2DMcuAk5LOt+o0dw5pnQ+iWbckZsIbh3yUwfBJI1h+8+DvFY0aj9k9sHC8Ot+/KgM0vvRriZo0xFnb+pw0pnCoUfkwIyxOJ9yPWQKDP8izoKMAE+oJIdjDECpOUjVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713028092; c=relaxed/simple;
	bh=/khNbArPndluhqCaANPbWbHRwmuLkIPd8/Lt2wdByhA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fjf2nIdDz7q0ajCUj5c2YhsFNhQI1P+/J0rDKtI5eHi8w4o6LIvb8fTbe230nZX0RltxrKS9U+k7bKpwOjOQpSip33VgdzEeO9Mr/c8viMnP7dpMv7HbpvBV0yqm42i/dXoyst+eUi4CYR/iT66Rj3qTCFy0LH//rIehFtYJIj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=arRQsuH2; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a5252e5aa01so48228766b.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 13 Apr 2024 10:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1713028088; x=1713632888; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4OnnwVVaFTHIt4jRXFbPcAEbvxYG9TZ1uG1UtFPzbms=;
        b=arRQsuH2WJqyMC4vkUo2mGe3dfiOcrRDal9eG31aNThmzmFiajyzgSSy9RsO5VB6go
         XnvzmJDW7qS3FW4ZaRnIyD5n3O7NZg9Gx5IbRW38y/mXkT93jZ+LW3dWrAMnZRCQOC59
         xOGjtN4CwX7+U6l3iYWDhQTzwc/yAr4DL20EI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713028088; x=1713632888;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4OnnwVVaFTHIt4jRXFbPcAEbvxYG9TZ1uG1UtFPzbms=;
        b=L2m+m/UX18GxFtJUX8gZxHV/1wpVbG59sz4e24FNhVj9OrDURW5F8iMQH6HFKH7iO/
         T5a/nHqxb+WZGgghl4O3Rlg8qscaR8URzDgHS+I2EY9QsWtK32sgK+pUVyMHBn6+chmX
         tAQKiCx67u9mPRILTaORvnGxARO+IDz3dCt5Q9x0wF/VApsD1VbMWOgWnHNMqUWZclOC
         Y1z+v4G46FpaYdL+FOZq8iZB2bijBimOSZEufv+e7s0aH/zkhUcVZKQt/gTstQwFZRBd
         Ik0Ni6ZRlvdWiVCqsZnNYTyvbkoL1UeiUG3Esf3WBQFGBjI/VkintY+vmVdkhX6izSbH
         Ke9Q==
X-Gm-Message-State: AOJu0YxYl3fiIc6L4HHaNRVMRx+liNjINlxtBOtQOzWmzkPt9MRijpr2
	WGqLHdxfaE4zbwD08e3HZrg4MvwGzAzJRSkvuPBlDlrHVGsQvecMBElBeR/f5IUETsOGvp58gsN
	0hWgMXA==
X-Google-Smtp-Source: AGHT+IGH4TryHf3MKUZWb1mbMJojq8aBUGQcWAKD9US8TsI4qaekyETOPu7Zr+ZWqMOT8z4TIunNDQ==
X-Received: by 2002:a17:906:1355:b0:a52:2ca5:f701 with SMTP id x21-20020a170906135500b00a522ca5f701mr3151883ejb.48.1713028088336;
        Sat, 13 Apr 2024 10:08:08 -0700 (PDT)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id cr19-20020a170906d55300b00a46b4c09670sm3179661ejc.131.2024.04.13.10.08.07
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Apr 2024 10:08:07 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a51d3193e54so225165466b.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 13 Apr 2024 10:08:07 -0700 (PDT)
X-Received: by 2002:a17:907:5c5:b0:a52:1be:f4a6 with SMTP id
 wg5-20020a17090705c500b00a5201bef4a6mr4223271ejb.21.1713028086862; Sat, 13
 Apr 2024 10:08:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411001012.12513-1-torvalds@linux-foundation.org>
 <20240412-vegetarisch-installieren-1152433bd1a7@brauner> <CAHk-=wiYnnv7Kw7v+Cp2xU6_Fd-qxQMZuuxZ61LgA2=Gtftw-A@mail.gmail.com>
 <20240413-aufgaben-feigen-e61a1ec3668f@brauner> <20240413-armbrust-specht-394d58f53f0f@brauner>
In-Reply-To: <20240413-armbrust-specht-394d58f53f0f@brauner>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 13 Apr 2024 10:07:50 -0700
X-Gmail-Original-Message-ID: <CAHk-=wifPKRG2w4mw+YchNtAuk4mMJBde7bG-Z7wt0+ZeQMJ_A@mail.gmail.com>
Message-ID: <CAHk-=wifPKRG2w4mw+YchNtAuk4mMJBde7bG-Z7wt0+ZeQMJ_A@mail.gmail.com>
Subject: Re: [PATCH] vfs: relax linkat() AT_EMPTY_PATH - aka flink() - requirements
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andrew Lutomirski <luto@kernel.org>, Peter Anvin <hpa@zytor.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"

On Sat, 13 Apr 2024 at 08:16, Christian Brauner <brauner@kernel.org> wrote:
>
> I think it should be ok to allow AT_EMPTY_PATH with NULL because
> userspace can detect whether the kernel allows that by passing
> AT_EMPTY_PATH with a NULL path argument and they would get an error back
> that would tell them that this kernel doesn't support NULL paths.

Yeah, it should return -1 / EFAULT on  older kernels.

> I'd like to try a patch for this next week. It's a good opportunity to
> get into some of the more gritty details of this area.
>
> From a rough first glance most AT_EMPTY_PATH users should be covered by
> adapting getname_flags() accordingly.
>
> Imho, this could likely be done by introducing a single struct filename
> null_filename.

It's probably better to try to special-case it entirely.

See commit 9013c51c630a ("vfs: mostly undo glibc turning 'fstat()'
into 'fstatat(AT_EMPTY_PATH)'") and the numbers in there in
particular.

That still leaves performance on the table exactly because it has to
do that extra "get_user()" to check for an empty path, but it avoids
not only the pathname allocation, but also the setup for the pathname
walk.

If we had a NULL case there, I'd expect that fstatat() and fstat()
would perform the same (modulo a couple of instructions).

Of course, the performance of get_user() will vary depending on
microarchitecture. If you don't have SMAP, it's cheap. It's the
STAC/CLAC that is most of the cost, and the exact cost of those will
then depend on implementations - they *could* be much faster than they
are.

              Linus

