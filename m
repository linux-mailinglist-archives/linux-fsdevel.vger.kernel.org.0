Return-Path: <linux-fsdevel+bounces-23466-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B965C92CCC7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2024 10:21:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D31FB1C22989
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2024 08:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FD0C12BEBB;
	Wed, 10 Jul 2024 08:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZLIBhcfm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC7D12B169
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jul 2024 08:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720599658; cv=none; b=dYFwfgOdzbZ2+/xfAubZxjt+U4S38lwIB01uG5/5kyEUILdtB+7NDkYD9LQjs3A1oONM/WAbBjMJr0tHZV4j2B59K8YHSTLLFwVMK32Syd1pkmePeYKoSLCT86akqW4POi2dKY3G7g/VQUCurn/2WIjMZSCXsrx42SYcckZ9SEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720599658; c=relaxed/simple;
	bh=E+RlSDDTSsw+TczheJFJM0ymz3DgCZJKh5AaCvk1b9Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T3AFJnsxx1CPUhA+9fnh/QG/fYH19ArgIpwo0ikN5kF+4Ss0PX6jsH7/xkYosL4tfGciZobgyK1VDoSKnmOUiWakLdKlqz61Z+tyUZkKu5kwm3Gh7TzAbcE7RLratPi9hSQpohVY9kEyS4sW5syDt2S70j8wrrY+rqXPswYipwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ZLIBhcfm; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2eaae2a6dc1so86601691fa.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jul 2024 01:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1720599655; x=1721204455; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=E+RlSDDTSsw+TczheJFJM0ymz3DgCZJKh5AaCvk1b9Q=;
        b=ZLIBhcfmXNzxci9p7l2DkVuG2NlGxfs2vR3FypWbXi1IxHvgyhsnYPbW4JrojtAk3p
         +r5zzmwqUoTm8tLsIlLsk3DnIaXBSotsziUha+GWSj0L1XVGjQCbkXUe9MYjQREiDtwb
         cHQ2r+ZELLQXV0iS/DjYnaSBVtuTDpnfJmRvI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720599655; x=1721204455;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E+RlSDDTSsw+TczheJFJM0ymz3DgCZJKh5AaCvk1b9Q=;
        b=nR5iZiu+R5FMSvcmw2JuL/+RbX9rJJHUiCg7sgJgAl5RFIV1An5g7KNarDAHwwe8VQ
         h95ssLX6FDhM+1TStqz9eALRPK93PhU62xC6vvO+76b1/vz3i10mNHGhTXYkmkJmdGQU
         xSlG076o+KKqff7Q/1GpAg8a03402up4UvnqmDrZL/iImjJ5nrU9ywYHFEsaryj49LRx
         mQSciYJn+ijN5iRXJkcbCU378yoI+ScaxHjHRH9+UOcOlLJxj6fyxYdeBh7JEy9a46pj
         FEER3ilaS4hn8rxHdM5WwF0zioJrFgggxDr9MXdRxbdMu0avXk3RoRg5FqF4/+VGPbDP
         4FCg==
X-Forwarded-Encrypted: i=1; AJvYcCUGYkT6gug0Q607ZMB9yHZIbg32okPSZc1FqCThHRzVQJ4zKZD31saKMd/WePX/DV10m2RezVFNL6p7l50Wdj35XMQZ5cPZutUdJET4wg==
X-Gm-Message-State: AOJu0YxVGlpMuVSYS71dq7Mga2l/5QhwSur5220iml2MoDDXJ0bjVI6e
	H/m3lGv6duHwAWBLVJSlcxfA2coAJM4p/suYXfmZIuVNnFJmSSAz0VOesf8DvxKEzdvACv5XZ1+
	Vjwum9UcfG8J7XibHp+tOV7h+oSZk0rfkgu0=
X-Google-Smtp-Source: AGHT+IEAq4kkSUgtsxyOH15D6jkCwSRAL31AifedA+YyD0JGizHJjSS3vklJsbyYJkyWrD4JVRnuf2baYIixrqDEEAk=
X-Received: by 2002:a2e:9b50:0:b0:2ee:be50:52d5 with SMTP id
 38308e7fff4ca-2eebe5055d9mr14147121fa.43.1720599655293; Wed, 10 Jul 2024
 01:20:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240620161903.3176859-1-takayas@chromium.org>
 <20240626213157.e2d1b916bcb28d97620043d1@kernel.org> <20240626095812.2c5ffb72@rorschach.local.home>
 <CAH9xa6ej2g+DvCd=cqjj8sx9yZ=DjL6Ffu6aOfebvcjBmGs5pQ@mail.gmail.com> <20240702123747.796b98c5@rorschach.local.home>
In-Reply-To: <20240702123747.796b98c5@rorschach.local.home>
From: Takaya Saeki <takayas@chromium.org>
Date: Wed, 10 Jul 2024 17:20:42 +0900
Message-ID: <CAH9xa6eGynkLNaSixQXOZMDTgi4H8vb6eY8e92aGRnbPPq_pPQ@mail.gmail.com>
Subject: Re: [PATCH v2] filemap: add trace events for get_pages, map_pages,
 and fault
To: Matthew Wilcox <willy@infradead.org>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Junichi Uekawa <uekawa@chromium.org>, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"

Hello Matthew, I'd appreciate it if you could comment on this.

Thank you.

