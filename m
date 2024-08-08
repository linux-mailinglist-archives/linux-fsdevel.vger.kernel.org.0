Return-Path: <linux-fsdevel+bounces-25442-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9230C94C281
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 18:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2D9A1C2505F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 16:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AD90190482;
	Thu,  8 Aug 2024 16:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kX51VQsN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A3F18E02D
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Aug 2024 16:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723134008; cv=none; b=NYos6P+/GkSqbFUNG868TxmJWPEx7qbMEGWKQlz/h4uIpuXi+ZgZucm1z88znjx3ECzl1U3P3jXZ9vlofFHiejbyt72SPvDiT6Su6qBTu/NYdz6W4D6Z3MvrxPW82TVmuKD96/C84H0+5oUq+S92mxeUvXNajBsYxUlCzB2nNH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723134008; c=relaxed/simple;
	bh=P/pVQXy6F0uUkKwDizlXzNmUOGplIeHHGdy6r0tuh/M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GB0+IdXSYy5M5ujfSExZCohsJootm3+oX2y1Q5DrpIK35efwRnOKlRZKngLemnu+fgsmoE6vPWtcRY86rhcWgb5iGYaBvRa33cWQmd0VWZ4C6p9yoKcCxYOLDQF0xvOKIq78BjUnO/VttokjK5G/I/EHZciibfMmJYIeLQ+2p4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kX51VQsN; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52f042c15e3so999544e87.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Aug 2024 09:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723134005; x=1723738805; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=P/pVQXy6F0uUkKwDizlXzNmUOGplIeHHGdy6r0tuh/M=;
        b=kX51VQsNCfzuZMarh1CWs9yqqDKqewZdMq+3qTCnsv/VvIlTamFkvXyOm2KXsBGEmj
         P3ZY1xQQqk09Ywb7CQk2VqpVObKwSrjMjhEr6rCIeL0KF+2XBZWoR7xUcDC+QYn+NmmS
         RJpnfef/440k/NroQqHyDl7eVjXgliNBVzYtw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723134005; x=1723738805;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P/pVQXy6F0uUkKwDizlXzNmUOGplIeHHGdy6r0tuh/M=;
        b=LYsJupzq00in/3Ohnq7Kmdbm5VECou+J0NCc87qzWTfFVq7XisNRlLvsP4Gxy10uJE
         4n8n6bpq05u6JzQXH5Wx7TqXIHBb/8dORY34DjxeCgA+zWiZnMBAX4Lff4uh7MFkJTHy
         BoXedJqmNq/chlduaZdWEeo23qiPtMqB7Np5vz+rdgtL24lsEKY1lK4weoeFynxsO+0T
         J0Zdvbt3tQqoqI9ElOT+X1YS+snQUJ1yaniaEYPBsxIg89Wh3spWg4Kdc74fpD1amEep
         krc/3eHFHc3kW5YBLfpLvA0xiAY4AmyPVyo/C4VHSAHQa+XoWKiS0cpFzN/Hoomw33Gu
         s+Og==
X-Forwarded-Encrypted: i=1; AJvYcCW2kb0KdbI+xC+Q60QwqrmUUuTJfB4fTROsWJE1tJzAeTjT75OtUugb9lArYqzmTZQH7qGpGFW5/sjL55rrPjcyX3er3UU4uGxnU6nK/Q==
X-Gm-Message-State: AOJu0YyVq4M+68tEOu1K9SGQ3FHDC9UL44Mju6fbe8c85xh9dsGskoVQ
	gFHnHVb4SenoYamkaOZtav+INFWIj+ATUrKMi96+ejsROGgJALPnP3INMgywczUPhfZMFGWROpS
	L9ZjjPBRkL0S5SNBTSw49PR9agXDMi5wgh8c4FvZROWS7aQ==
X-Google-Smtp-Source: AGHT+IGM+IplmOKg4nDNcKFtgq1VYsAyFc8E27t7Kh5kyZC1RNU1wOd40qJBqKGPW2Fz1pon2C+QpyksgQD83msyZMY=
X-Received: by 2002:a05:6512:1104:b0:52c:72b4:1b24 with SMTP id
 2adb3069b0e04-530e5d52447mr727655e87.12.1723134004820; Thu, 08 Aug 2024
 09:20:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240620161903.3176859-1-takayas@chromium.org> <20240807211731.16758171@gandalf.local.home>
In-Reply-To: <20240807211731.16758171@gandalf.local.home>
From: Takaya Saeki <takayas@chromium.org>
Date: Fri, 9 Aug 2024 01:19:52 +0900
Message-ID: <CAH9xa6cRGK_oscsDNuAm-ZCJmfkfbm1yOTg_6SSzrkojY-CKFQ@mail.gmail.com>
Subject: Re: [PATCH v2] filemap: add trace events for get_pages, map_pages,
 and fault
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Matthew Wilcox <willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Junichi Uekawa <uekawa@chromium.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

Oh yes. That sounds like a good idea. Let me update the patch with it.

Thanks,
Takaya Saeki

