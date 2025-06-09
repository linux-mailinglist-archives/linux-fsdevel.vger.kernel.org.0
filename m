Return-Path: <linux-fsdevel+bounces-50981-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D60AD189A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 08:34:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44B827A5999
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 06:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0ADF280017;
	Mon,  9 Jun 2025 06:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cGk+E0Qb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA29C14A82
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Jun 2025 06:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749450860; cv=none; b=aC1Iba6XxlBhS4sUOk2Ff0dX3yaSMfZiz8Y3s2FCpVWDD31QApqzBj3lzLhGeMvnR4Jpmr/IVKrCuFOJl858JP+Rv0PQbIneWm2QYMIFj68NTcylLBva//xnPHET9mdwjd3rV2sytSRLV3QeJITfgETcIJP8UuhzcpUQqla/Yi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749450860; c=relaxed/simple;
	bh=V1MvQecxBbsavQOuQL/+VWXWI79oj6KeM3sdM+7ZXso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IC+16zs0xnfPw6sPgO1saL5JCKPDpVn7q0n73PoytiZmp3H2BTtPNcOCVs6QS8hRgPF0Xi8Tbacb1Pe7oqL9SyuZ8A61xRz1ewKnf7YTnN8hQglHRlCpQ/T3wCKNv7KWBo3qM7bJj/H6luLX+Z6tPxjikbQpD8l0uttwE69EgTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=cGk+E0Qb; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-742caef5896so3228933b3a.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 08 Jun 2025 23:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1749450858; x=1750055658; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3kw8UwXF8nhjHGY10czvDoV0t7L/vYXrP4PDYhL4cNY=;
        b=cGk+E0Qb0kslps4aLhesm1wmHl0j6yhJig/KaMmEeHfqRbRgTUEOsoyq9pWcOID/dG
         +O/Vum17Qt1t8YEK/kmF6gkDis5owyk5P45MnYWQewIx79pzUJjpNLAyG1gAEUgidQ5X
         RB3udox2uCM9wu3Rg4kS1G4J8xm0mV0pMcXPc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749450858; x=1750055658;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3kw8UwXF8nhjHGY10czvDoV0t7L/vYXrP4PDYhL4cNY=;
        b=kMIvKzMxZVO3Q3ft9DdKE/uLJblv7XVq5sgckUJRBOK4JHvOtJcxYsMS/BEMqcsTJd
         IEN5p+umO8DoRyc6dDbyyR4H71UhTSJfRz5JlO9s+du9MJgzM4Px1dnXl1JO7WUBaTbk
         2DrdV4YsKvFhVSwdCIjOpN0DkCJftMd54kmnxdhe+kaWp2V7odgXKarfL/2wI0F680I0
         juwq+RIc8wDBGW85otGerxT4JAG3AL6t0oiItCWZ4X4ZmEZfXeX4cmx5mvGAu2CrX35R
         jTMZhyBD2kcz0Lpe+zoonhKTDFpczbhmMywb8Cs7TvlacOZlEF08rvTciU60Pxq9ZSVA
         pnfg==
X-Forwarded-Encrypted: i=1; AJvYcCXjALSDoA5NNWmH/21IfdbKHhr6GaFtWVmQemUGyFFOtvIMAWs4DfuCz1uxIBL3e2xDzOiTQ+4EdhXIBluJ@vger.kernel.org
X-Gm-Message-State: AOJu0YzRRbSJdyaHw5O0QIWb4WdTMeJlOYM4vOlvF9k7Cxy2K7Z4E3Fb
	QTzd5R4Ea+pdXCceHotnc2Y5ASunASH2UhU5yEGSZaysCL6W6f3rFrGePO8vMzOKPg==
X-Gm-Gg: ASbGncuCczwO/4JDxsC1Zsf0gWqCTydC4P7KSCJfTiLPaIeDFyAGawkkEX8oWJd8iO8
	frzpTYodji75IG9a2iI/IJ/HbDwDdzC/bI8FUc/vyYHS1UY3QvlBNrFC4PVEOxcLpcipDD1FyPX
	w5QqCWmvxM6bAZnJ0LOWVjkkKqtX2raJTiUL8J8RGx23YWfEbi7i4SIgFI8XopXjTL0Km8y+7Bn
	3vOtUG0OChnARSA4af8IO/djFzv3gj8M9D3kuIoD/h1IeYO14hnXxmh8SY64AgjcNzZi9ya8Dv1
	BzzK9YKnC/H3RwaeA4hO3gYKY3nBO3ttt++/KeZVJ/n6o9uFxWdmenk=
X-Google-Smtp-Source: AGHT+IGVMJMWeDkYNbKUWivodOVr3uS6WQKwvY28M+3/tgEEyS48Au7YaNU7yzcFV4tmbn8HKPfFAA==
X-Received: by 2002:a05:6a00:4612:b0:736:a8db:93bb with SMTP id d2e1a72fcca58-74827fa2840mr14544040b3a.5.1749450858092;
        Sun, 08 Jun 2025 23:34:18 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:eb64:2cdb:5573:f6f1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7482b0f28a2sm5185966b3a.174.2025.06.08.23.34.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jun 2025 23:34:17 -0700 (PDT)
Date: Mon, 9 Jun 2025 15:34:12 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Tomasz Figa <tfiga@chromium.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] wait: add wait_event_freezable_killable_exclusive
Message-ID: <fyx2kxtef3fha4timgtwrcwyacarb6g6tz66qjiehoi7ierslw@hkbdq5aguxnz>
References: <20250609030759.3576335-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250609030759.3576335-1-senozhatsky@chromium.org>

On (25/06/09 12:07), Sergey Senozhatsky wrote:
> Add a freezable variant of exclusive wait.  This can be useful
> in, for example, FUSE when system suspend occurs while FUSE is
> blocked on requests (which prevents system suspend.)
> 
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> ---
>  include/linux/wait.h | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/include/linux/wait.h b/include/linux/wait.h
> index 327894f022cf..b98cfd094543 100644
> --- a/include/linux/wait.h
> +++ b/include/linux/wait.h
> @@ -657,6 +657,20 @@ do {										\
>  	__ret;									\
>  })
>  
> +#define __wait_event_freezable_killable_exclusive(wq, condition)		\
> +	___wait_event(wq, condition, (TASK_KILLABLE|TASK_FREEZABLE), 1, 0,	\
> +		      schedule())
> +
> +#define wait_event_freezable_killable_exclusive(wq, condition)			\
> +({										\
> +	int __ret = 0;								\
> +	might_sleep();								\
> +	if (!(condition))							\
> +		__ret = __wait_event_freezable_killable_exclusive(wq,		\
> +								  condition);	\
> +	__ret;									\
> +})

Or I can do something like:

+#define __wait_event_state_exclusive(wq, condition, state)			\
+	___wait_event(wq, condition, state, 1, 0, schedule())
+
+#define wait_event_state_exclusive(wq, condition, state)			\
+({										\
+	int __ret = 0;								\
+	might_sleep();								\
+	if (!(condition))							\
+		__ret = __wait_event_state_exclusive(wq, condition, state);	\
+	__ret;									\
+})


And then in fuse something like this:

@@ -207,8 +207,9 @@ static struct fuse_req *fuse_get_req(struct mnt_idmap *idmap,
 
 	if (fuse_block_alloc(fc, for_background)) {
 		err = -EINTR;
-		if (wait_event_killable_exclusive(fc->blocked_waitq,
-				!fuse_block_alloc(fc, for_background)))
+		if (wait_event_state_exclusive(fc->blocked_waitq,
+				!fuse_block_alloc(fc, for_background),
+				(TASK_KILLABLE|TASK_FREEZABLE)))
 			goto out;
 	}

