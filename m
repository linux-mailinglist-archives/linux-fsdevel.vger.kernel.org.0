Return-Path: <linux-fsdevel+bounces-8786-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F91E83AFE4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 18:30:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 122C81F22D00
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 17:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9A19811E2;
	Wed, 24 Jan 2024 17:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="SvGXjCdW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA827F7C4
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jan 2024 17:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706117275; cv=none; b=fdcadHfxeocKx4oiBn4vKNH32zoxP61SW0IUsBM1k6ECA7j5Dt01v9vHaH65sayJQXG4H1t2o4Yb8KQQ1VvcP5vXE+YhWxKS23RGFZ26EGNb3W28nMdMxkps+hcMs4BUIElLoP58OHRbNdU51WghZHYX1ca6/pcbLbkllKEYLMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706117275; c=relaxed/simple;
	bh=z6BjyMQCnB/4rQCdDjotQhHRjXz7UoU01MQEf+XrLlI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gaBjE3Vt8QH++ftEbcKePo7Ip6T7tOrL2PCCcbWJPHOb+N8Pu/85TjDg+TLo5bYA4d6bsbjNs9VZ2vktsBaD8TADNUpPGk0+C7Aoy0O3zKwfTa4rO/tr2cwN2OT1fOQRbvIAS0/x5FvSdtQPqnaQAfITxyxuZby5lcebNGFpxrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=SvGXjCdW; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a26fa294e56so582844866b.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jan 2024 09:27:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706117271; x=1706722071; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zTlbGsImqxn7RX+/XBkYgj6lDq/Avh2rTF8zOkCv5JM=;
        b=SvGXjCdWQ583KEVmiYYexUS3zEIYuWQ4wPEPRQhydsb2+08ONPZqteuABDBSVeB9aU
         dIQbevDGSW2O6AHiAezGooZEAgVzm8YuDTC7blChWGde0dRCM2EIc39b67mLjwXF+jMP
         IqFpwja29nj6xc50P9fJ5UiosHhGFgiUFQUgU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706117271; x=1706722071;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zTlbGsImqxn7RX+/XBkYgj6lDq/Avh2rTF8zOkCv5JM=;
        b=KKpdikGdfwANbGPXq+rsSf2hFlikhpWpSXuCE+aXEZl+0VraHi68+MvuzqWXmCr/xz
         KYWehLQxTP6Qyaed7vrgWG4uZt2cnjoJHmE+N5iMduziDRr6mS1U9jvql5VfgBVYd3uq
         CdKyCiU+Pa2N+pQHUba4uMo8+L0khY8EgzSeVue36hacHkKNMG56bWfrU4kVyPQYqMnX
         f7IfS18ZDmeSxnk8kU4dF+oEdlwALiILDzH6JuX9HuIl04gFEEv6Ufu1GZT1qdNB2ELx
         G36Ua3WQAb1Li7K8jBkOkI1wTV1skZFWxJ9J9tSWkbU0LZwgkL3hO/d7TfDavgBvrfYA
         ifJg==
X-Gm-Message-State: AOJu0YzefxkAWTViXlTydkIFSLyO/7csKa5j6hyLCzoEK6AQDVTsJIel
	zcnbyUiIm0bfa6YIKa4IXrXtzKP4Ravwvt9zZfbCdiHu7kemxoZZIhcWAuQabgSScjV3K7EcSVH
	NABcdGA==
X-Google-Smtp-Source: AGHT+IFEgnnDj1G8uEskDA0uPaV/B6kTzSrQbMF9o0Jg2WRLO8aME49HtONo9/cejY13oHtcmbkoDA==
X-Received: by 2002:a17:907:a707:b0:a2c:5ed5:7bfb with SMTP id vw7-20020a170907a70700b00a2c5ed57bfbmr1239648ejc.91.1706117271254;
        Wed, 24 Jan 2024 09:27:51 -0800 (PST)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id ff23-20020a1709069c1700b00a2ed5d9ea19sm90426ejc.190.2024.01.24.09.27.50
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jan 2024 09:27:50 -0800 (PST)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-55783b7b47aso6489281a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jan 2024 09:27:50 -0800 (PST)
X-Received: by 2002:a05:6402:34d4:b0:55c:7444:153f with SMTP id
 w20-20020a05640234d400b0055c7444153fmr2637292edc.60.1706117270433; Wed, 24
 Jan 2024 09:27:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZbE4qn9_h14OqADK@kevinlocke.name> <202401240832.02940B1A@keescook>
 <CAHk-=wgJmDuYOQ+m_urRzrTTrQoobCJXnSYMovpwKckGgTyMxA@mail.gmail.com>
 <CAHk-=wijSFE6+vjv7vCrhFJw=y36RY6zApCA07uD1jMpmmFBfA@mail.gmail.com>
 <CAHk-=wiZj-C-ZjiJdhyCDGK07WXfeROj1ACaSy7OrxtpqQVe-g@mail.gmail.com> <202401240916.044E6A6A7A@keescook>
In-Reply-To: <202401240916.044E6A6A7A@keescook>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 24 Jan 2024 09:27:34 -0800
X-Gmail-Original-Message-ID: <CAHk-=whq+Kn-_LTvu8naGqtN5iK0c48L1mroyoGYuq_DgFEC7g@mail.gmail.com>
Message-ID: <CAHk-=whq+Kn-_LTvu8naGqtN5iK0c48L1mroyoGYuq_DgFEC7g@mail.gmail.com>
Subject: Re: [6.8-rc1 Regression] Unable to exec apparmor_parser from virt-aa-helper
To: Kees Cook <keescook@chromium.org>
Cc: Kevin Locke <kevin@kevinlocke.name>, John Johansen <john.johansen@canonical.com>, 
	Josh Triplett <josh@joshtriplett.org>, Mateusz Guzik <mjguzik@gmail.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 24 Jan 2024 at 09:21, Kees Cook <keescook@chromium.org> wrote:
>
> I opted to tie "current->in_execve" lifetime to bprm lifetime just to
> have a clean boundary (i.e. strictly in alloc/free_bprm()).

Honestly, the less uinnecessary churn that horrible flag causes, the better.

IOW, I think the goal here should be "minimal fix" followed by "remove
that horrendous thing".

              Linus

