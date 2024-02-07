Return-Path: <linux-fsdevel+bounces-10610-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F34E184CC97
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 15:25:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 728601F26A2A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 14:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 782DE7CF00;
	Wed,  7 Feb 2024 14:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="T/XogiOr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBB47C088
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Feb 2024 14:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707315900; cv=none; b=MU1v7qWCLceAT1B1oU00V3KjGU8IU12wAprxwKtG8HrAFlpfV28/VzWsg7bMLWcscB6O+N8k/jIoXxkPh14y8XXSRySW3H6qn08Fg36GbULOhcNBREJhxs8ZEF5LNpQFcz2FKw1fg8y2lksSl+xYilLomMREvhMoYUpBBoTBynY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707315900; c=relaxed/simple;
	bh=fmDZRKAJ+iyEaLTPH9eG1pOzWbScOmhUKK0nz1DRrTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZLRhd2FQwyRnGy2xeMm+1ZRZOSyjgQjVGagSk7AVK/aA0bclh1LDu8vEPXfgh/FuLearuq43TOdKGvrYhithBNTWvaDIzaFXiGPPNYrnl3VFfW4Yd6dJ24Ct5JKFDasJwJWBdE5v+/1bI6Y+2qBEtS0dPjwajGDrAanqOAD1t74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=T/XogiOr; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5c6bd3100fcso499598a12.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Feb 2024 06:24:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707315898; x=1707920698; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RWTf399WiJ8kfKwENv7YV66YYsIFa333tQkHLNWYJlE=;
        b=T/XogiOrbAciZ8Z/r8zOQlhz7B82kGxr2tGGrH1BUhP/fjZ24vDDL6cQnQh/ux02TI
         zZKun0SNpW9AyadLwPESUtmXvfwyOblaFqFh6ALmd2LkaVw7omsWTkWFKtIg1mQryBaz
         7fwtW1Jfky12Dspqqeop2U2B0AxtLQdEeukvQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707315898; x=1707920698;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RWTf399WiJ8kfKwENv7YV66YYsIFa333tQkHLNWYJlE=;
        b=AKQoJacoftksD/g7yL5hFibp7IwJt4c9BS/P/JX2YqQJjZO8IECHHJbzJABjZjjGHt
         6U7IY5P9DkdTtywJF1git4W6HGjPO/kOKIs88ovR1xshuwuxWqXtoMurEEtBY/wo17q5
         Tqxsnb0J7ktUcErXsmnvFg/a3zbUaYnnbIMDPoeRsH4DDW1v48pUsMnCgxHARHFD4S0Z
         k71UL+HHd64g0CIVeAM2lCuuGYPKqda/S51ImC7fcRZIU4ruyIf4j7gmGqSFAPJaKVqw
         f5lbeCMR+pNiKcUENFyPHiqBHRqiMTwyfxrMUZyXcWxvOi7cn6P2Db/xhdOl0wpb0rH4
         QJfQ==
X-Gm-Message-State: AOJu0YwoIB4NA/G6GIhfeUI80IFuDyKpVRghMGnfR/riQcnLIDix3B8C
	xEkbpdI7Tb9H3OZeIPyUbFPWHNkwaD3axj8ZGSC1W0fGtesHTnwNzQGfP0fDEw==
X-Google-Smtp-Source: AGHT+IFsc+BSTCgRv1ZpK/ieJdv+YqxnqxXsVsJR7lZChMujr1OjP6TDVd83adcGpGxlPXua9nMFag==
X-Received: by 2002:a05:6a21:398d:b0:199:86d6:43de with SMTP id ad13-20020a056a21398d00b0019986d643demr6419947pzc.58.1707315898566;
        Wed, 07 Feb 2024 06:24:58 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWqYTB32oLv18AVZReWaKpoBixSOUFmOIGH3sK31jBy9rdQH2doA9rUaPvUaYBAzoAoonnCl0ZZeK/uy5tPYvJR3QjpCEYuDqOdMLVL4cVIZbknrzU+ke7rR6aed0gHWz2X/kXxVDlpsCMogMn6Ye03/Y1SXDfXgbQaeOG8EXTAmXDWnpCP5AZJfNzA2IVTEQ5w3pHxl/r24gGGLCIVlLhMlGP3cqT5LMBSsWRZNjDvZino6v5WKXN3gixGndvEK81j25WB9JTGFESG/TTTxD/UbOjs30B/qWtcYO924wHevka7gOWVhNYsWSboI6fa904vKvIEA/3YnQ1RplKR7/DsikG7N6M5YaHVo23Zgmj8ksnlSmzT40z4OmAjyEy9
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id kz16-20020a170902f9d000b001d987592c6asm1473701plb.232.2024.02.07.06.24.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 06:24:57 -0800 (PST)
Date: Wed, 7 Feb 2024 06:24:57 -0800
From: Kees Cook <keescook@chromium.org>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-security-module <linux-security-module@vger.kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] LSM: add security_execve_abort() hook
Message-ID: <202402070622.D2DCD9C4@keescook>
References: <8fafb8e1-b6be-4d08-945f-b464e3a396c8@I-love.SAKURA.ne.jp>
 <999a4733-c554-43ca-a6e9-998c939fbeb8@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <999a4733-c554-43ca-a6e9-998c939fbeb8@I-love.SAKURA.ne.jp>

On Sat, Feb 03, 2024 at 07:52:54PM +0900, Tetsuo Handa wrote:
> A regression caused by commit 978ffcbf00d8 ("execve: open the executable
> file before doing anything else") has been fixed by commit 4759ff71f23e
> ("exec: Check __FMODE_EXEC instead of in_execve for LSMs") and commit
> 3eab830189d9 ("uselib: remove use of __FMODE_EXEC"). While fixing this
> regression, Linus commented that we want to remove current->in_execve flag.
> 
> The current->in_execve flag was introduced by commit f9ce1f1cda8b ("Add
> in_execve flag into task_struct.") when TOMOYO LSM was merged, and the
> reason was explained in commit f7433243770c ("LSM adapter functions.").
> 
> In short, TOMOYO's design is not compatible with COW credential model
> introduced in Linux 2.6.29, and the current->in_execve flag was added for
> emulating security_bprm_free() hook which has been removed by introduction
> of COW credential model.
> 
> security_task_alloc()/security_task_free() hooks have been removed by
> commit f1752eec6145 ("CRED: Detach the credentials from task_struct"),
> and these hooks have been revived by commit 1a2a4d06e1e9 ("security:
> create task_free security callback") and commit e4e55b47ed9a ("LSM: Revive
> security_task_alloc() hook and per "struct task_struct" security blob.").
> 
> But security_bprm_free() hook did not revive until now. Now that Linus
> wants TOMOYO to stop carrying state across two independent execve() calls,
> and TOMOYO can stop carrying state if a hook for restoring previous state
> upon failed execve() call were provided, this patch revives the hook.
> 
> Since security_bprm_committing_creds() and security_bprm_committed_creds()
> hooks are called when an execve() request succeeded, we don't need to call
> security_bprm_free() hook when an execve() request succeeded. Therefore,
> this patch adds security_execve_abort() hook which is called only when an
> execve() request failed after successful prepare_bprm_creds() call.
> 
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

This looks good to me.

Given this touches execve and is related to the recent execve changes,
shall I carry this in the execve tree for testing and send a PR to Linus
for it before v6.8 releases?

There's already an Ack from Serge, so this seems a reasonable way to go
unless Paul would like it done some other way?

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

