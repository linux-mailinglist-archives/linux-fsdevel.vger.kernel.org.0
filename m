Return-Path: <linux-fsdevel+bounces-16709-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33E6D8A1A8D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 18:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E4091F26119
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 16:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E03121E7935;
	Thu, 11 Apr 2024 15:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="K2jBXDJZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91581E6F63
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Apr 2024 15:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850061; cv=none; b=ZRu3Js9Hbpg0Q0Hoo9EF1YnvfIat7GtB1r4dBDzZS8hMmKu8Q8PMwLt8OSjdJF//+EkPj/a3yuEUzsNsJUgEroVsSR9FAd4tXof1WwGGJWjbU9EQcVUTvSiJ/BzZRp0PwhTAg7ygHU5F6UXKMrGo+FzC+ueSYGES3WOPfXGr9KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850061; c=relaxed/simple;
	bh=20UuiQFkTockG+yyYjHc4F13je0ENmFxiz4QhWzCdQ4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A1oEll6g/PX2/s1HgQdjqzv+DXZ5jJ3eFktFybAcceLhcnHPIhcSNIm+1f0UkNSBVxvgIF3obbOka92QtCoUnZCttaZrrNyonxD6gmZ/6Bn4z7LZX8Z1YFDusK0/jDJ6oTiRDMQbfOqgQvi0GEpr5p6n0mp3hhHIkAHOMJJ9Qr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=K2jBXDJZ; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5dbcfa0eb5dso5959333a12.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Apr 2024 08:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1712850059; x=1713454859; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TNCBXKOK5vc3YGKFYUbQmuJn7ivy3cDWCe8OlWYsEZM=;
        b=K2jBXDJZ7wjvKfKnwiMLofu6RwQ6rusISxBzPJ5lI3R7EyiNkROirQre/eI+PorQXO
         auLgTDXyOBcC9CduWzqhBTHI/2vifhzkGkIvUd2cOrHFB5gvqa1yQ2FWoL8cu7U0n5bJ
         uIFH8weIUJsHtaLPXOzo0KdSu8coM3QSMMfrc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712850059; x=1713454859;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TNCBXKOK5vc3YGKFYUbQmuJn7ivy3cDWCe8OlWYsEZM=;
        b=IsySh5PTLoNXdzsXCwMXAYbGdz/QH+Sw0y5VRuzUhtCXcy/C4exu2NnNCijeTwnyUR
         B1duQEkmilY3rKSJ3qPtlfsJcWpwGfTGG3L2vwKAzsT1p1Tv8S2B0jsfxKnQWbgtHM91
         0l+Wnd2JfuUFz/9olXuvIlOPpldv/py/3EeMgUBALiF9onehRk8Y0cnVhRK+lawm+mV8
         mmWLePQiBDrepQXD9F/JVKI6Wiq/1ihuaAyMmxTd4slpx5QJeFRti1/4dtNTgw/ye3XV
         AmVBnnzxyzmVGOhiJaw/293JDOtY+2Jedn9BnYvTJXz3UWZlF5RImAsfu54PGjE2HGJJ
         KYlw==
X-Forwarded-Encrypted: i=1; AJvYcCUjUGfej8hHKMwnjcua7sEdkn3n1BHEjBTrRm1F7LDu1CGTs1Gfg5LTLZBfphKm/Nbuecsr+O/7sd1kwie4k7fmS1SeAmE1I/L31V06JQ==
X-Gm-Message-State: AOJu0YxgQvGdTp7xVgZFVVxHRMbGIO7aoQHnr7fc0NFLO9ja6Ug35Q9z
	QCw1NVjip5rUXc6Pvrj94M0aABULRbSJZ7tHxPx04qrfZAqCeVuS4hsKtmH3yA==
X-Google-Smtp-Source: AGHT+IH9jxm0Fb4/9rDpVIPFtRTSYrpVWRroIqBhY1mn62exKNoGoLU12zMbf7I0bbrEMi3h9K0kNg==
X-Received: by 2002:a17:90a:f3c5:b0:2a5:7e31:5030 with SMTP id ha5-20020a17090af3c500b002a57e315030mr5833139pjb.15.1712850058943;
        Thu, 11 Apr 2024 08:40:58 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id gk16-20020a17090b119000b002a42d247a93sm1266081pjb.36.2024.04.11.08.40.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:40:58 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Marco Elver <elver@google.com>
Cc: Kees Cook <keescook@chromium.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Eric Biederman <ebiederm@xmission.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Azeem Shaikh <azeemshaikh38@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH v2] tracing: Add sched_prepare_exec tracepoint
Date: Thu, 11 Apr 2024 08:40:51 -0700
Message-Id: <171285004930.3255679.4082124903503205236.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240411102158.1272267-1-elver@google.com>
References: <20240411102158.1272267-1-elver@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 11 Apr 2024 12:20:57 +0200, Marco Elver wrote:
> Add "sched_prepare_exec" tracepoint, which is run right after the point
> of no return but before the current task assumes its new exec identity.
> 
> Unlike the tracepoint "sched_process_exec", the "sched_prepare_exec"
> tracepoint runs before flushing the old exec, i.e. while the task still
> has the original state (such as original MM), but when the new exec
> either succeeds or crashes (but never returns to the original exec).
> 
> [...]

Applied to for-next/execve, thanks!

[1/1] tracing: Add sched_prepare_exec tracepoint
      https://git.kernel.org/kees/c/5c5fad46e48c

Take care,

-- 
Kees Cook


