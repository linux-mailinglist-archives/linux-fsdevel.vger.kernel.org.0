Return-Path: <linux-fsdevel+bounces-8826-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C94F683B47D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 23:09:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BE8C1F23B75
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 22:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F1AB135A58;
	Wed, 24 Jan 2024 22:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Bm1uM0Iu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580F21350FF
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jan 2024 22:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706134184; cv=none; b=aFqA/jsJJNVtyQ5vmNcbNXLgeybUQZW0e29Ym/JLGke8fzcRKb8bYlyn4zSUSJ+a5zw40PSueyu0QyEP2u7dS89GO4Wqr9H25APeV5glqtRP/oUz2nrr7Pb+OXrsmsVrqwhoc7tBBsdgjpSvx7ROUWK71psfaAmYLSX6LZgOKNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706134184; c=relaxed/simple;
	bh=UQmXMpFOIh4kaKkMBDQ4eCuMf1Sn6QVhCPFE62Hwr5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uK40zbpMxoYU52SGdcOQuge1O6mOPMoJemzld9SgjBWZ8Jr1trHq+LRmmFQDneKR7FbbGGqpSgGlzQQUfuVYqaTjdhkAnOusLhqc6+4gO80Wdavd/rpDLj9UcMvYPeV4epiVwphU+G+lVTXUSVWOMkpIvc2NHA05C7Rtgt1q1AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Bm1uM0Iu; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1d71cb97937so38549105ad.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jan 2024 14:09:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706134181; x=1706738981; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+2HfF9lupAEm1OXAQn6hzn1NaSwJWDcoC+WNHu+TurA=;
        b=Bm1uM0IuP1+QnewQhVXpyXRow9FD25u+xJffrKC4wMTBzaLmSABFDKIzqIM2bx/SmM
         t0tfn0eMt2jaRHmC+liWPK1juyfVJmT4Me/jviogAndspfKZ/ROKj1yxDrZK0+Dgocwy
         2C1+ShExPYRU5V5n0du+wD1RhcllEGiHcAemM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706134181; x=1706738981;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+2HfF9lupAEm1OXAQn6hzn1NaSwJWDcoC+WNHu+TurA=;
        b=cX0weeP6qdaLUZ2zbTm7+xUN2+eVrY979oPNMqzgRHTojdjJUddtM15rXZnmFqVPr8
         vjex+1h8uXdlLk7fUO1KgR0PpL4u4ZCCwFeIOIafJ+tWnC/1MFVOQlMAkfwnDz0lNacD
         74u/RVjz3bVdUxxBozs1G1riIbR5K6RlVYs3kXI4e+q+VNAWARxXXXD8wU3QfxYdUkJD
         wEjdzh20DBvu/EdHBsXsRcoP4IV9YdyIelI38p0wHbscfTmr8RqHWzzE97hOIhTnvEI4
         DnqCi4F/k8nfdiOtISh/qZ/y9dFI9Q+alP8PmoXYOjPyZjim+CEMq3IWRaO3wCw7vBeE
         0BPg==
X-Gm-Message-State: AOJu0YwO9rFUDbM1o77cMABe0ets8o0QwGd0sGRa5VnQdhSZLw4D8eFn
	eoKHB1UJXm2ePg5HbC6gTESU+UFmXLnysLTbwmkNc0oGCUR3VzzEnZrjnT3J+74dkRjBEZGrd6Q
	=
X-Google-Smtp-Source: AGHT+IHwjfVcQfQSMaltTGpvSx5H8mpO1d+72MKHAgocTXkrSUI+xD0uCoBa7P9UapqyrXYteTG9ug==
X-Received: by 2002:a17:902:c3c5:b0:1d7:1b61:579e with SMTP id j5-20020a170902c3c500b001d71b61579emr51632plj.89.1706134180745;
        Wed, 24 Jan 2024 14:09:40 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id g9-20020a1709026b4900b001d75044fb5bsm5572290plt.141.2024.01.24.14.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 14:09:40 -0800 (PST)
Date: Wed, 24 Jan 2024 14:09:39 -0800
From: Kees Cook <keescook@chromium.org>
To: Kevin Locke <kevin@kevinlocke.name>
Cc: Jann Horn <jannh@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] exec: Remove __FMODE_EXEC from uselib()
Message-ID: <202401241409.AD68CE57A@keescook>
References: <20240124220619.work.227-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124220619.work.227-kees@kernel.org>

On Wed, Jan 24, 2024 at 02:06:23PM -0800, Kees Cook wrote:
> Path-based LSMs will bypass uselib() "open" checks since commit
> 4759ff71f23e ("exec: Check __FMODE_EXEC instead of in_execve for LSMs"),
> so don't set __FMODE_EXEC during uselib(). The LSM "open" and eventual
> "mmap" hooks will be restored. (uselib() never set current->in_execve.)

Ah, nevermind, I see Linux's commit has taken care of this already:
https://git.kernel.org/linus/3eab830189d94f0f80f34cbff609b5bb54002679

-- 
Kees Cook

