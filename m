Return-Path: <linux-fsdevel+bounces-39959-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA7A0A1A650
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 15:54:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45CF9188959A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 14:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E9EF211495;
	Thu, 23 Jan 2025 14:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="Ym0FcOBZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E53F2101B5
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jan 2025 14:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737644061; cv=none; b=gk1elZ06O2YUVFEAZN4T0wD0S+7a4d3ghbwOglK9HL8B50BlKcYTTEBpc/woauKuWNcCaQTS41DoNKCZYk5QXCuaGJQH24X5YVXTGmWLMYYsmHqxS9NMxHqtr79UtdIifBphTWefE4nQkBL49GOK0utf8jzxpAAjo7DWDo07wgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737644061; c=relaxed/simple;
	bh=SVntw8cO5WFdmDrG6+8oeaizUlVIhtRZHPs88gnzbME=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kjYsjCipCBApx7wk+bIOmcoXM4X1G2JziwxfN5ye/4aPESlrUYb1iyDSCd7ObhpDjtflzJz4NZralhmO4if3Q9FcuuC/5Q5kxMLeu9+5lN0cDv8DUBpcSyuWOU6eOxDFXhkC1FP04JjpD9yjxz1Rr+So2pIBvorSuVddv6fvu0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=Ym0FcOBZ; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-467bc28277eso8350421cf.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jan 2025 06:54:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1737644059; x=1738248859; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=urQbPLdaGtTTF/fkN+ugVTqTil7Se2gZDVPlYtiAL8k=;
        b=Ym0FcOBZsBY+stlK71kRSUNxvWMKwq+gHeqDQd1jKwvN0pjDkSmFZAhLwspoKVihqb
         nUXTFNttTAJcxW/9VEWKWg0wSloTG7ImEFwICHqF147J8ijTDHuCkswRkhTRLmt9yeuo
         Sh6IbzPPWHS13Kl3339uX8ZiWnHm0C+tba/w0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737644059; x=1738248859;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=urQbPLdaGtTTF/fkN+ugVTqTil7Se2gZDVPlYtiAL8k=;
        b=O0TRDzunYc6QsPVdslcp1zqaYotKaNCSv5F0PC++xmnnOjhNAIkjoDvqGhlflhp7iN
         2B7vFRGdPTUbC+gecS332UjR4uGeJhf/nCRkScpi+yS2X2TR3K39W1OMqGCF6JjG3ErQ
         5xZVr/HkWlCWC/k9icr0iKCM/qnJMuHJPlm1I3HJGp88rnwdHdELbc4vkagKU7GHHD/m
         AVMRJpZOUXL9V2fmMcd+pDP2HzVNAkEg8DSywJ61nKAbxzTvSzn9OFse4gauZZ5KDKRy
         Bfxu66YKEPJbK2/gU5eejBp7H5Q2bdruexIKmIbqTyGjtKTQuR+irRoOqW2u1HW+R/KB
         1dhQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzrTgI9sKTq2Gbbgtz7PKm2ocz9UULi0oQRs8CZUPENP9+sOx5iGJAk0xkNzRB4LKDFpGj5DltFC6+0MyW@vger.kernel.org
X-Gm-Message-State: AOJu0Yw126qNTcQqOKIjrIrmb8Knjx26ZXuqG4eck7aP1a5lS34AzoK3
	3otXF6GQUmhFUfbDNRd3ibLz6Un0mEBjHaB/+xvN1CdNlZ9VUxBueO4JMRzHLWsa20HI8GM70Ah
	xlp2rJU8TdapLq/0vF6m1QAjmB/KQGiExxxbFqA==
X-Gm-Gg: ASbGncuticlXuBh/p3bNhFlSWnVU1HVvNgEAq+/Unbap/X/zcOw7oQLQF3IUyu9U3vl
	cQQaaYtUHiBuWs7TIyGyli9Z34PvVQpE2TL9+nxlgik8shGUOYzlW+FdsIgQs
X-Google-Smtp-Source: AGHT+IE7ZyX1OC5YYjR1PA1qvIDHMExe2nbrxBYw8WKcHPBBRCMMOfT22J0nG37lG5QlrTJdJIMNThSk8MFe5VoIFHo=
X-Received: by 2002:ac8:5a93:0:b0:463:5cd7:ddd3 with SMTP id
 d75a77b69052e-46e12a0c12emr455908881cf.11.1737644058987; Thu, 23 Jan 2025
 06:54:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250122215528.1270478-1-joannelkoong@gmail.com>
 <20250122215528.1270478-3-joannelkoong@gmail.com> <87ikq5x4ws.fsf@igalia.com>
 <CAJfpegtNrTrGUNrEKrcxEc-ecybetAqQ9fF60bCf7-==9n_1dg@mail.gmail.com> <9248bca5-9b16-4b5c-b1b2-b88325429bbe@ddn.com>
In-Reply-To: <9248bca5-9b16-4b5c-b1b2-b88325429bbe@ddn.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 23 Jan 2025 15:54:07 +0100
X-Gm-Features: AbW1kvYwhTKo1-iRy4Y1j7RaDupXlGT6XCsNR_aVYNTCLcL_7t0VLjMFfdDes7s
Message-ID: <CAJfpegsP2C-RgGqY9Wd2D_C2vdWGtcN1JOcwdGxYx29DCm=eVA@mail.gmail.com>
Subject: Re: [PATCH v12 2/2] fuse: add default_request_timeout and
 max_request_timeout sysctls
To: Bernd Schubert <bschubert@ddn.com>
Cc: Joanne Koong <joannelkoong@gmail.com>, linux-fsdevel@vger.kernel.org, 
	bernd.schubert@fastmail.fm, jefflexu@linux.alibaba.com, laoar.shao@gmail.com, 
	jlayton@kernel.org, senozhatsky@chromium.org, tfiga@chromium.org, 
	bgeffon@google.com, etmartin4313@gmail.com, kernel-team@meta.com, 
	Josef Bacik <josef@toxicpanda.com>, Luis Henriques <luis@igalia.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 23 Jan 2025 at 15:41, Bernd Schubert <bschubert@ddn.com> wrote:

> I don't think the timeouts do work with io-uring yet, I'm not sure
> yet if I have time to work on that today or tomorrow (on something
> else right now, I can try, but no promises).
>
> How shall we handle it, if I don't manage in time?

Okay.  Let's just put the timeout patches on hold until this is resolved.

Thanks,
Miklos

