Return-Path: <linux-fsdevel+bounces-27774-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B164963DAA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 09:51:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06B5C1F235B9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 07:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64697189F31;
	Thu, 29 Aug 2024 07:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="nuh3tOkf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4732F15821A
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Aug 2024 07:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724917901; cv=none; b=h5CJZECd3grGVLohhULth097UXi7KtWb0EyEJYQwc/ydr7vj2ozWZYhihFDP+qqXIP53hEG6M0RkSy+QU3gaQQlXr6hQ1byDH9U5sSvdrX5FwqZtBt9KojG2Y1BIXMCXXy5r9UNBJxbAHKM8YJD+vzusDdxciv/0kbfXnqsOYdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724917901; c=relaxed/simple;
	bh=arR/sffRsobr9Borj4X8VYDf7KRXtoIkqMFf8ghs5Os=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b6JmJURjmtu64YViViN7qICkUZBjySxquW5yEJ54Kc5mNgaFcyxtBlKoJ+qGzXUWWKmLMGPTJdMSW6lQjDOm/uBTV7HpLVBPl8UT/8Ls2uPHMfpHwf8xNhB1dRd53F0OMzzR0igxD6rskLlPesOXZC9iGQlR7vzR96dZBeoYlAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=nuh3tOkf; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5334879ba28so488513e87.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Aug 2024 00:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1724917897; x=1725522697; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=E88LT5D74HyhmMarxCefY4oc65GfE3ptwLbyJI7Amzc=;
        b=nuh3tOkfsSCfXgq3Ojf/0G4fK2WdPToFj5cFVB61CgF2AkF3cFbmOwvZNnztBQtZiY
         j2IZCzNLvKZoHKuV+Ev4Qn3e3h/YlQ3kNmxQdBOtzVyOjvz3BGHgRxjxiqWVQ9XdbXqp
         MQEHRqudPqtnBUGIAgnvtTEcW/qWuWTKk4NJ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724917897; x=1725522697;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E88LT5D74HyhmMarxCefY4oc65GfE3ptwLbyJI7Amzc=;
        b=kJd23gJ5MKbMf9NVELxXv0nIw4D6o/SdSUBGMCmaTeRSp/RLfYGi792OEgSM/gM6KY
         OGIn04qdt50T4IP16sA0h3G6KKhjqcTb8fPv2fAf+bbKYyTKwRsjDOXLfjX26/QzyXBl
         2H4Qs4l9/BncX7/Ko+7HJnGzzlpZBY1iJtDvoQ6UqKXC83Mluw4S/fJCGC8kXdEBMUuO
         3WDUptN4uVWBEt6lCYHp0fOqWh6ABH9z2t2KfDFoGsbWGrLWaO5Wg2zaUz0GqRNYYnOU
         eQaZzjG7DJ1cKiNwU81X6/gxphUtFVCcPMtfTpLQDpA8sv/+gmvYkiAmyhEAOvw5Z6Zd
         +b8w==
X-Forwarded-Encrypted: i=1; AJvYcCVzQ+NuISZfODne97XrBuPgQA5jCimU7pOkplKFfLEsnF2tuNd5bkI/QoNStLU6ZXTalbQeCtoMWUYDUy8W@vger.kernel.org
X-Gm-Message-State: AOJu0YzYwUY7BKCSvkEGHcKS8NDWVsjLCWvnbOmPhMzFunHsCo1YjJDm
	bRHCLHNlr4pq5LHXrxMD4obj+tML/vhXSY43oGutjkcAczCfRRzfpd7+eX4FHXxe8651pJfWVIP
	yLvpVkiG6WarZZjYDD3xNR6H9VLVp5Is7QHasOs8zWW58cgtw
X-Google-Smtp-Source: AGHT+IEWGAYWw/fSwcJOQ+/o+9pIqQrvIPE/w5ugEv+xbpFYiBYNMLRLtLp/5DzAZKrFPIlkHWk6IKYg42J6jWYWDkc=
X-Received: by 2002:a05:6512:10c4:b0:52c:d5b3:1a6a with SMTP id
 2adb3069b0e04-5353e57fc94mr1225703e87.28.1724917896827; Thu, 29 Aug 2024
 00:51:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240705100449.60891-1-jefflexu@linux.alibaba.com>
 <ca86fc29-b0fe-4e23-94b3-76015a95b64f@fastmail.fm> <8fd07d19-b7eb-4ae6-becc-08e6e1502fc8@linux.alibaba.com>
In-Reply-To: <8fd07d19-b7eb-4ae6-becc-08e6e1502fc8@linux.alibaba.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 29 Aug 2024 09:51:25 +0200
Message-ID: <CAJfpegsgCJEv=XxuHgo+Qn-3y8Rc_Bsmt2YKTHn4XaBqvgshew@mail.gmail.com>
Subject: Re: [PATCH] fuse: make foffset alignment opt-in for optimum backend performance
To: Jingbo Xu <jefflexu@linux.alibaba.com>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 5 Jul 2024 at 14:00, Jingbo Xu <jefflexu@linux.alibaba.com> wrote:
> I'm okay with resuing max_pages as the alignment constraint.  They are
> the same in our internal scenarios.  But I'm not sure if it is the case
> in other scenarios.

max_pages < alignment makes little sense.

max_pages = n * alignment could make sense, i.e. allow writes that are
whole multiples of the alignment.

I'm not against adding a separate alignment, but it could be just
uint8_t to take up less space in init_out.   We could have done that
with max_stack_depth too.   Oh well...

Thanks,
Miklos

