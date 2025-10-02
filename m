Return-Path: <linux-fsdevel+bounces-63312-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79662BB4982
	for <lists+linux-fsdevel@lfdr.de>; Thu, 02 Oct 2025 18:49:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74D7719E02BC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Oct 2025 16:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC6626B777;
	Thu,  2 Oct 2025 16:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="AxlQeLEl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23D8239E9A
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Oct 2025 16:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759423781; cv=none; b=CM3kq1YEli6F9hHHFvnS+ckg5qX7BpByWkYXnG+a3W2e9ZrpvIfZnsS77ggiaAFuWD2QaJ+E+srAiNM2vs9TOQo/XJpSVeQWPV0m3le8+NAU9Ty7HTME6WxiliFFjwjbeFyzJP0QRycgdqCq4qxgTlgbIV5w7o3Kj8FdtPFCdCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759423781; c=relaxed/simple;
	bh=GPNKqk2IjCezt+iOiIGHZBvYwRYM9eI/at8SyT0aJvg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CI8AqV63l+ktcxO+X9GbKFKYVsy7YX4P9DgEBZZipUYy2VANoF9tgGlrq2nlRuT1EkaycpkpesAyfTzj1iQB1YP4Iq2rV0HWnz9XGcc/PL/L9wBudxN7GCrYeCRWxJGVPV7L96Xak7sAOuQK6pFHZ3B4jDEt3yP1tU8bqR55nxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=AxlQeLEl; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-62fc89cd68bso2233105a12.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Oct 2025 09:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1759423777; x=1760028577; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ri4QyfvFryudbRTr4zjJak2/cwqBuXGVPepccBH1HNc=;
        b=AxlQeLElIi1tgzW0Xa49BWGvyXrG6bFPHJtslsFFETI4dTNNDjRuAzVayqe7DRxthj
         bobx66wtxCU+Qt2ArxD4Va2QDhZJD6ONF3umpFSCbbRQP5AXPHeK3hVAuUukuwcD60uK
         XgS+hhJsYKOkHjWqkqRdmpgvVvYaEvg2kgCxU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759423777; x=1760028577;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ri4QyfvFryudbRTr4zjJak2/cwqBuXGVPepccBH1HNc=;
        b=w05zfrlCbM0kZ1DeYLr9h+HZp5X6KQNb3p1mqdqNXta++F9wZhTPyrb9t+gemcvTU1
         9CxVv5pilo2IAY5+uxSmmkRJaJXezwVnIEEhj1IkZqio5JVnUIcAx30P5M+Cb5CYoy0Q
         GdFXUSOxByEdEJL4T21pLLihFW5wHilM8450p7ArZglujQvPE2XJcLlP9BeVl+TRBGDt
         iri8fB5PjZkp61zZiEq87aQxaom2daz9Omrm/TX/Batm0o2DRXs3WC+/7Ob36i5VdBvV
         gakBQ4bCWuPbOYfBiJZAjArVjrtb/j8Wb5rDa789k6LLg4HwjNStmjM7pqs0hIkUrA0A
         bCVA==
X-Forwarded-Encrypted: i=1; AJvYcCVDIhyNyIIZh2f8GJ6Ou8HaOxhuj8LvX+nZEWNoQWqVI8gqyksmnxJ0FysCWRiL+ANeqIAXmuh3KqAusRq1@vger.kernel.org
X-Gm-Message-State: AOJu0YypBdU9EHHx3uvn6dflT/Fow4X7bCHDPctC0sDnTVAz1k/dXs73
	dO4BEMVxijC6KnkCc/GEyVm1+A+RlZF7PBShnV+3+cNreTMSttEMlHUd3SLTCekog3LYTepTp1S
	/m2gTBB4=
X-Gm-Gg: ASbGnctJg6MclDdghp1I6XTaweRhBZeOmE80bD6/dT02sqFcgvL7UwKFn71Yx8m/2vL
	ddVrCwXeGTyQ2U9+Ezerk+XukaVYPeFPp8Ln+WWkd5xBuJxr521ERiPW3PisSHwE0TuHZF+yxs9
	vuCAwkiAp69sTNe/gYKjhEXe8IzRPmWwmTOU8gPOQD4XWCJtFjQlOynt9mY2YeVbuC9oyvqYeCW
	hH50d2v8pMtp/DxXKVV5StQY91r3PUc/2GWSrey7JVM6QkWfeRpI9gcfcH97HnSJabRhslkxEJT
	tlP82fCO6HegQ5jyynPOFPaScRjsrjI9Y9zW3xszklzPOuOxpN8RVl/dHpKzV1JmcCQ2eSrAn1f
	s8Qzv98eq0QMr6ti8JbxXl5bt0Kg5CcE59OakLDUDslYr7V5IiyPYAIauIhfq+4a8XpMDl02V6U
	AVHRVrijkU6e3Gdx/EOX1UPyecWldv3jY=
X-Google-Smtp-Source: AGHT+IFjZMaUKm3fkOwN4tSWLPRCFlw2MmEZJD9MWb3aSVIwCUDbLLNqeCTOL3BTGtukOV09bb2jLQ==
X-Received: by 2002:a05:6402:26c4:b0:637:ec31:be93 with SMTP id 4fb4d7f45d1cf-637ec31c3cfmr2277401a12.2.1759423776878;
        Thu, 02 Oct 2025 09:49:36 -0700 (PDT)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63788112bbdsm2170421a12.41.2025.10.02.09.49.34
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Oct 2025 09:49:35 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b3e25a4bfd5so249102166b.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Oct 2025 09:49:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXKFusslhwg2IUB3uxWm7/7o95FaIp7J4IdR3H2AhLYGXZSn+50VvAwN4gaQ3wmECGsPtzNg6wISWvoh65J@vger.kernel.org
X-Received: by 2002:a17:906:6a25:b0:b3e:c7d5:4cc2 with SMTP id
 a640c23a62f3a-b49c39360f6mr14187866b.38.1759423774528; Thu, 02 Oct 2025
 09:49:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250730074614.2537382-1-nilay@linux.ibm.com> <20250730074614.2537382-3-nilay@linux.ibm.com>
 <25a87311-70fd-4248-86e4-dd5fecf6cc99@gmail.com> <bfba2ef9-ecb7-4917-a7db-01b252d7be04@gmail.com>
 <05b105b8-1382-4ef3-aaaa-51b7b1927036@linux.ibm.com> <1b952f48-2808-4da8-ada2-84a62ae1b124@kernel.dk>
In-Reply-To: <1b952f48-2808-4da8-ada2-84a62ae1b124@kernel.dk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 2 Oct 2025 09:49:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjf1HX1WwREHPs7V_1Hg_54sqOVSr9rNObudEpT9VgQDw@mail.gmail.com>
X-Gm-Features: AS18NWAX_XbsCSn1cSvTBt8Jd93mNINtxqs7sE9J-usQvnLgAAKgdff6fAuW3Hk
Message-ID: <CAHk-=wjf1HX1WwREHPs7V_1Hg_54sqOVSr9rNObudEpT9VgQDw@mail.gmail.com>
Subject: Re: [6.16.9 / 6.17.0 PANIC REGRESSION] block: fix lockdep warning
 caused by lock dependency in elv_iosched_store
To: Jens Axboe <axboe@kernel.dk>
Cc: Nilay Shroff <nilay@linux.ibm.com>, Kyle Sanderson <kyle.leet@gmail.com>, 
	linux-block@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, hch@lst.de, 
	ming.lei@redhat.com, hare@suse.de, sth@linux.ibm.com, gjoyce@ibm.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 2 Oct 2025 at 08:58, Jens Axboe <axboe@kernel.dk> wrote:
>
> Sorry missed thit - yes that should be enough, and agree we should get
> it into stable. Still waiting on Linus to actually pull my trees though,
> so we'll have to wait for that to happen first.

Literally next in my queue, so that will happen in minutes..

           Linus

