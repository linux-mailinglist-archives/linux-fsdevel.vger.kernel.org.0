Return-Path: <linux-fsdevel+bounces-1974-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27E777E10E3
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Nov 2023 21:16:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F9C5B20FB2
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Nov 2023 20:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF14B24218;
	Sat,  4 Nov 2023 20:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nD04PvV+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F81D22F1B
	for <linux-fsdevel@vger.kernel.org>; Sat,  4 Nov 2023 20:16:38 +0000 (UTC)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA3B2E0
	for <linux-fsdevel@vger.kernel.org>; Sat,  4 Nov 2023 13:16:37 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1cc30bf9e22so25216455ad.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 04 Nov 2023 13:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699128997; x=1699733797; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=F3q+26NQjsCSsUclbOoVT3OpgFnwDtiYbZS3n2A1sXk=;
        b=nD04PvV+MBhuj5r5pcXaR7Sk7u2/7o2NLWP8LPzI8HkgV6CsBdlek7cNIyLE5Ex2Yx
         ZzAg0m7IHGZ1AcZqoevXmg75dGrfPpkNZ17z/bFHuMVfjiTsRzdUY/x/nrgdh0jXbYfi
         cuVJdfGC6YSazIh6IEZDofmxfk6VM+Wk5Rhbc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699128997; x=1699733797;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F3q+26NQjsCSsUclbOoVT3OpgFnwDtiYbZS3n2A1sXk=;
        b=rrpBLSryN+AHpYirYW0pZ9sK4BI8+NDKd38mnD16IpmKYCkyYHLlh8PPi8Lw7VYa/J
         Oq9SrZdZY0DRwwtdqoDeh4wkMFLUBeUk8yQ90ZgkfKV6VEjAEPtYu5u+DKG4RNy4rHoa
         mLPCM4jVVOqf16wzh5dJTc9Sn9C14yabGn0E2+l7dWr34Oy3y47OcsKsZsKjVixUC6+t
         67HbSLrM3TakIf+SMs/l71LLg5W1XQRlYB1EgvtzilhD3MWJVHDRvhh/uDoBMVNkeeMr
         dnv4kQWwlOkaC1VkU8rXVVQsr1VAvzoZgZuv1CX55FWmQ7qcAH8s8A7kaGZLmp/4IdUM
         Rn/Q==
X-Gm-Message-State: AOJu0Yy1gaDotlEj1EiBomcyZklLkFIA2YMTheg8HW60ZhurUaxrNHN4
	DgO5nlEwEtb0D87TUvO7pdh7kg==
X-Google-Smtp-Source: AGHT+IG3c5xfOJz1RbIcNJcl94Po9noSiBFDwt07JlMVvyocCZu40rrhyVtY2DVrXGeuet84jn2G3Q==
X-Received: by 2002:a17:902:e88e:b0:1c7:5776:a30f with SMTP id w14-20020a170902e88e00b001c75776a30fmr8832331plg.12.1699128997174;
        Sat, 04 Nov 2023 13:16:37 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id q16-20020a17090311d000b001ca2484e87asm3280474plh.262.2023.11.04.13.16.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Nov 2023 13:16:36 -0700 (PDT)
Date: Sat, 4 Nov 2023 13:16:35 -0700
From: Kees Cook <keescook@chromium.org>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: j.granados@samsung.com, patches@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Add Joel Granados as co-maintainer for proc
 sysctl
Message-ID: <202311041315.F91B4DE@keescook>
References: <20231102203158.2443176-1-mcgrof@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231102203158.2443176-1-mcgrof@kernel.org>

On Thu, Nov 02, 2023 at 01:31:58PM -0700, Luis Chamberlain wrote:
> Joel Granados has been doing quite a bit of the work to help us move
> forward with the proc sysctl cleanups, and is keen on helping and
> so has agreed to help with maintenance of proc sysctl. Add him as
> a maintainer.
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

And honestly, I should likely be switch to "R:" -- that's most of what I
do for sysctl. :)

-- 
Kees Cook

