Return-Path: <linux-fsdevel+bounces-12212-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ACEE85D07A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 07:28:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB7EFB2148F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 06:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE35A3A1B7;
	Wed, 21 Feb 2024 06:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pPzdOwWq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC6DA35
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Feb 2024 06:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708496914; cv=none; b=Gsd3KAp9A0FrGTBS7cJa7vDDTtbvQ6z7jt7wKXsn4T3ueOV0AWZ0noMDhO39uSi4KIXNzx98yNhGaT9W7K7nKuxXo0f9kIoXApGeHBq8ByRQuhqZMBa4V+cyJonTK5Ze/il+Sl3rXbj414RJe2ey+oqtdAF9sZU8qWlIAOX4IOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708496914; c=relaxed/simple;
	bh=NvpND8bHneGl1as7liJpg3nMdmeA4xUwGesva2xlrDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZjFMGQhXAAdDix4gEAJh1/xaUk8PVuvZTp/NXV+b/UUPMyF4EWL1x3dxU6mijC6wzYEx2SXj5OK2CAVhKLEGzoHFOHU/WVw7DZzVtfoiTPAideBo227dGyJzqoPZKmas9iEBJR8sYOmiHZm/nBguWOAY7/Vs5lCDzddKokhcD0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pPzdOwWq; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-563ed3d221aso7936769a12.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Feb 2024 22:28:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708496911; x=1709101711; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CcPstB2bYO4HD/z5bA6bWdOkdEkTV183NUIU2ddVXl8=;
        b=pPzdOwWq51+iTIZaoTuCTrArkigKlw6Z3KWf0hcXrfjjjx2s7VLQxEDixgsWwgavIi
         A8QKmSXPGe3sn14Erb8miPzOTYVEQZdGUhSGCXtUjpOhshbc4f8uX2677DUWY79MYvEO
         /Yh4p2HtTSVP4ujTBcxkCviCmX7J14BYlDiK8DU13MvYgGfIrEKxgf1JU3IjdJ9/rxbZ
         bLtV1zjGETa9b0qMgO2UkeqsDsZyx8zoOSz8IBXXO0tFJu9vfYXoVT7kWBT0kcGVV/SD
         RZvTiDVBvEYCzo7erREX7r5i5xEWb0Mqw8Z5MQ/aURC/54NLv9PlDGES4w4fk4rZl6Rl
         0YqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708496911; x=1709101711;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CcPstB2bYO4HD/z5bA6bWdOkdEkTV183NUIU2ddVXl8=;
        b=jPhkSSWUNVgCE1wjwNmkmm4Ri0Gexd0Zv7zx6E+ZSvRpE31JlWcmAxOSnI2nN9hgWi
         HaYSLcfCGDgTI/DP6em6AGRXQDe713WhvK6LvHahLfXUZAkLKgQxrFBKvVLD29250IFl
         wvppSHLuvckhz09nvb60rqzLvTy5ZEizRa8MnCwgtjIOEtV97GmQHU1YsdGdhjGY3n0X
         Ufo+BxgTGw61ft3FF6BVVc8mYibeCN/Eff5YDhmVV6SSuNba5Aklt8S3IgBLfcxE5cPY
         xmAT80P2cTVziJ/+hEFzArmk7zfsNsjbjERShWNKnOVkwjf4N75Nu9vm4zMphuMDWjWw
         5bNw==
X-Forwarded-Encrypted: i=1; AJvYcCXJPf5P55pEdup3nDsnCrZEKLr+9dnBVzciFdzFxHAl3j+muLC9hFeclEgBKmojIXK2Ew73SNus9692A2rcqu2fgJdgos6UM9oDiJsr+g==
X-Gm-Message-State: AOJu0YwxKZaBUZRgMGFV3A2Ju/5jXOULHPVp4m5Io+60217annnVfAWE
	WyOj02c4tX+gqsl6Xo480+99PwTJYsEN8Jpe6sYJZtajUYrcpFRzmNohrBuiSAws0J/TUJMh+Il
	R
X-Google-Smtp-Source: AGHT+IHpriMxroIGBhzF108/XlOwjGc2BsiHpH3gAeVQM0JFaftGLnX8WFuMK3Yp3VE7RBr+jZd/6Q==
X-Received: by 2002:a17:906:4558:b0:a3f:c32:7b0c with SMTP id s24-20020a170906455800b00a3f0c327b0cmr3887561ejq.22.1708496911341;
        Tue, 20 Feb 2024 22:28:31 -0800 (PST)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id tj9-20020a170907c24900b00a3ca56e9bcfsm4652264ejc.187.2024.02.20.22.28.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 22:28:31 -0800 (PST)
Date: Wed, 21 Feb 2024 09:28:27 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] mm: use ERR_CAST() as a cleanup
Message-ID: <09aadb26-88cf-4f3e-bebb-dcbc1fdadeeb@moroto.mountain>
References: <5a64b69a-40a6-4add-b758-ec3a9d93eb11@moroto.mountain>
 <ZdWWyvoCyI4kp4hm@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZdWWyvoCyI4kp4hm@casper.infradead.org>

On Wed, Feb 21, 2024 at 06:23:06AM +0000, Matthew Wilcox wrote:
> On Wed, Feb 21, 2024 at 09:22:13AM +0300, Dan Carpenter wrote:
> > The ->page is the first and only member of the folio struct so this code
> > works fine.  However, if we use ERR_CAST() then it's clearer that
> > this is an error pointer.
> 
> NAK.  &folio->page is an indicator that this code is in need of cleanup.
> I use it in my scripts.

Ah.  Fair enough.

regards,
dan carpenter

