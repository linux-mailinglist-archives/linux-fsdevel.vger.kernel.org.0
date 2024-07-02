Return-Path: <linux-fsdevel+bounces-22923-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FAE8923B5C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jul 2024 12:27:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A601FB22B03
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jul 2024 10:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78C9815886E;
	Tue,  2 Jul 2024 10:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dcF3u2tl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F2E15689B
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Jul 2024 10:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719916051; cv=none; b=atMWDeem+XuX/mRZuIllPAtazjWJnFQrboBwBO0XysGCxeLGWQOv23wlR2hfjgO0CksWyfZWn7KhbNK30nDFh4gqMWjxj56tBUmEs7xiTdN6CdSnC/iGMRUQrrlQFrMmEBzj1sdp2ydbJlfR9gxzPJqbRPkrB9Gh7eGPoyATmFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719916051; c=relaxed/simple;
	bh=KGXL9UIXbhLR/5JvNqArR0R/XDUz/ACK4RQxzl9anNE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t95DESaE54iZchXE93nTkdkLvHr7AQqbfEoBGXYbIcw7MNnNXkush0oMBwM3DtNraDq0JLM4fS8MaMraNLv/8QQ+8xBb0XSoayeudF6d/EpWl4Ayz/esrw+Sn9LlsCRDhPKBUut3VXemsTbgXVdtpCRyJAjtscz2LE4F63l5a5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dcF3u2tl; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2ebeefb9a7fso45499341fa.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Jul 2024 03:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1719916048; x=1720520848; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KGXL9UIXbhLR/5JvNqArR0R/XDUz/ACK4RQxzl9anNE=;
        b=dcF3u2tlMqqlru7dKg9knlyIzk51sfjgrzlPJFKgID15PJVypodb7PvoEtCxIcWjGJ
         wcl7cEbePp7tbVOY5/TVrVd29I2d7Z+ySRuRcaiDJlNvsSZb6BAs49S/QMAqSsfgW0ro
         x4/eKqGPlRxWj+pnId9kqbXYhrp6kCiu0C1F8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719916048; x=1720520848;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KGXL9UIXbhLR/5JvNqArR0R/XDUz/ACK4RQxzl9anNE=;
        b=uevcHTURdoMa/RePzRA2EcxnCSlhh3oaUCyEfamaK5zzEduZPSD9xTjhgLf/fI5bdo
         Ip9jV3egqo3TtMc9zgX4sn2u7KYF/5WKJsgZH9111aqPnw+Y1Zu9mYMz+sVuXnpHNu14
         DluXNoQdMmfy/3UAY3ivjgLQZBZVKsSnrGeMSnbPfqUpBy7nq0GnOTUE2bGarsc8pLcw
         MNT7zoAplf5QuSvWZNzfLd0mbdeyOADfn3H80qIeV4rbBcyTj/YangGH8wYQmRbFnDkH
         gYOTTrDQmUKFxXRUDGb/XNrw2aOI8PgyabPWNzQZDjrQ4MXAzb97S3+kPlI/G+C4SM7w
         L+/g==
X-Forwarded-Encrypted: i=1; AJvYcCUUv9wmjIT27UGnrUKKn5SEgxcH/Cr3Q5ah1nzMvHY6kAQ1vTmEZ4FwC/nOpxqGOghH/lp0slnvmtI3qol4qPSnINhAhEdM+d17qzq5kg==
X-Gm-Message-State: AOJu0Yy8SR3FQtUxy/bvPE64oZ4d3ZrxqVsO+nmAFf5EBSd0EojZK6GD
	HObv9WQQFV7CRfFH2q5thzpuf/EiniutwBUf2+rWjrZMAcs/EBnURJabbrESB4l7UOtkQYGoXdu
	dkutQ6VSoWOq8PvVGb2JtdRUXplClcewZ65s=
X-Google-Smtp-Source: AGHT+IFt9f8DTWYXKkF3t2wQ2KUJR9FCI77sv6cMg7QIh3R6KT4/CDFbLN8uqeQubI+1wZca4MimuTa7HkZzfMW2UOo=
X-Received: by 2002:a2e:9ece:0:b0:2ee:594b:8b80 with SMTP id
 38308e7fff4ca-2ee5e6f7a8fmr43928381fa.52.1719916048118; Tue, 02 Jul 2024
 03:27:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240620161903.3176859-1-takayas@chromium.org>
 <20240626213157.e2d1b916bcb28d97620043d1@kernel.org> <20240626095812.2c5ffb72@rorschach.local.home>
In-Reply-To: <20240626095812.2c5ffb72@rorschach.local.home>
From: Takaya Saeki <takayas@chromium.org>
Date: Tue, 2 Jul 2024 19:27:16 +0900
Message-ID: <CAH9xa6ej2g+DvCd=cqjj8sx9yZ=DjL6Ffu6aOfebvcjBmGs5pQ@mail.gmail.com>
Subject: Re: [PATCH v2] filemap: add trace events for get_pages, map_pages,
 and fault
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Junichi Uekawa <uekawa@chromium.org>, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

Hello all, and thank you so much for the review, Steven and Masami.

I'm currently considering replacing the `max_ofs` output with
`length`. Please let me know your thoughts.
With the current design, a memory range of an event is an inclusive
range of [ofs, max_ofs + 4096]. I found the `+4096` part confusing
during the ureadahead's upstreaming work. Replacing `max_ofs` with
`length` makes the range specified by an event much more concise.

