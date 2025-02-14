Return-Path: <linux-fsdevel+bounces-41694-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 812ADA353D8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2025 02:43:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7456188FE1C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2025 01:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D21F378F4C;
	Fri, 14 Feb 2025 01:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WJvmiJi1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A1D39FD9;
	Fri, 14 Feb 2025 01:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739497430; cv=none; b=mnBtxHeADlCqCBa2orAIgHS2fh6A5PW35wv3QPOaF4Q0nuLuIFmURZbQyWhhTlJ9x0zLFu1kXmISgmW8eV2Xvrf3VW8oeR3qrsyPQCtA0qKH8cBTDPXSZu4XnX1LkBXmCEmAtiI2al6IV6vVMITl1lSz4DF+Tuj/JOzRjXHF0R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739497430; c=relaxed/simple;
	bh=RMf39PKqJWsy5g60ZvMeyrshwi4LTmDx7UDuDNExSc4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tAGh2KlR5arrR49iVIvfWK4BVeFhIGFIj4PMuu/+2NoPQ3CSiP7WrzPjilHC31H1tZRlAD1iIddIiAG0Fw5tiIhUZIyPI3ath+t9kBxNUZfUs8g97SQiOLs4LGvY0tLI42JT8dwOdJxNXPHbKBSonYveNs7so/hNPVMdSwaRnMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WJvmiJi1; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-220e989edb6so14366005ad.1;
        Thu, 13 Feb 2025 17:43:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739497428; x=1740102228; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BzgpsseLXLXSSN0TgFVPAOoW3MbcGaqggzNT0LTWJEs=;
        b=WJvmiJi1MHWHpUwPzbZ+wZWk8y48Qy69gBL0zLVXgpvuOAOaF+VFgNpaTJMlmp+CGD
         yw6j66j/1Y7py6G9elwLulqJqy+CMP1Mes0pNpl06Vr5SUrHT89/2k5Lnvv4w7e+1piX
         hVwvizmWjkiqsTGJPTLries72OwIe0BHJOXBk5BRNI4ZlqX2A8jiDIrqXEhmGxgol5r6
         vrMB3jJREWLnRQrnWhFMuC8i5qJD20kHDs/LV4pLTa8DZ55S+Wm1Ou2RSBsgGbr28KJl
         4KZ6vN0kUfRFO0Q8gG/rvby2xX37po+pN0tqPBJ2Y+OgK30mGWhWPVPIQC0hc9SUNYWw
         2QBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739497428; x=1740102228;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BzgpsseLXLXSSN0TgFVPAOoW3MbcGaqggzNT0LTWJEs=;
        b=k1JUT9/vxtOmV2pCpJP+w8IUU1O7qej1/GJMEmxwV9Rrxo9wSj1uknAFv14SCwOBcH
         4wpAqxk1L1unji8dYLEKThi2TfA/DSPooiZzDLZB3x8hHtFQdZzNgLu8MhqpbYmWk/Ur
         9lg7mD2NE0Do4DhVhf8Ogl1i+cV12mL7twrEI8K+qecH0TXEjwHI7lqFCfmOnCDbFIu0
         Xj03n3IWZIhpTwfrg4p8UUNg5YqDJB+XnFtDWi8VzlVoQ0ygqeQD4pFkQKdmm1MTsW7G
         npDq2StHyN8dMStyEpb1ut9o+u7OGAP/xQw8wQPN6KRtPVbUqultWs7TUZPdnkLk3srT
         E3fw==
X-Forwarded-Encrypted: i=1; AJvYcCVqHKZykms3OyI7SAthBSf3y/rUDV8kJp3y1hsDvGNpWQvvEqKzoA7EARZBEcVFOkjYQtATrJwa5s3SIKIu@vger.kernel.org, AJvYcCWItTink7Fz8PBADToaEdsNBmC6jSN2QyYvatNi/6YxMbXvUEj2gR1J6rNGveWm9u7qiZvCD1SZV0CgCmKF@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1vDPFTMYdgCajD1wIEA2Ra3JOUgdBWvW46pgCP2ojDqLbLYG/
	5zSL7dQyQhB+gtwi4dotVpi/9LdA9omUm6EQ/D1fwcY+ldm9yEiv
X-Gm-Gg: ASbGncvdRquwQ09IehuIH9aHMVXqWBy6BZRfQ1mo62fMNDjw4NSudH1cY1rYHfqBrL5
	l9pv4P2y5Wd1lljM7wzwdZ807iGbXp9LpfJvLEM7JpshNfjW94MdwdRXxyTOoy1w2EhxyZyAPdz
	ku4eGQ1kLcEfigaND82YzjnphF2id6Zkr9oZ73IDtLpPzl+R6kEJr95hJy12t9C2WsfHSNIdyQR
	eh2AbYhqPFfsEt1N+PdFMfr7haoexOh8QboM7SsF+AKQBT4cHIG27x0ELtNvX4OKOJSiZ6jzLcc
	cul7Plup91i31Fwo6G7x75kopBmq
X-Google-Smtp-Source: AGHT+IHg1pg2cAr3C6EWTO+TBk4Dnw15pfyPMZhhWShm1M3ShoZauVqqo8cDn1hsSMSb3ztVYhAQXQ==
X-Received: by 2002:a05:6a20:c6ce:b0:1e1:3970:d75a with SMTP id adf61e73a8af0-1ee6b30ced3mr9418188637.9.1739497428082;
        Thu, 13 Feb 2025 17:43:48 -0800 (PST)
Received: from VM-32-27-fedora.. ([129.226.128.251])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73242581ad2sm1962989b3a.77.2025.02.13.17.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 17:43:47 -0800 (PST)
From: Jinliang Zheng <alexjlzheng@gmail.com>
X-Google-Original-From: Jinliang Zheng <alexjlzheng@tencent.com>
To: viro@zeniv.linux.org.uk
Cc: alexjlzheng@gmail.com,
	alexjlzheng@tencent.com,
	brauner@kernel.org,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: remove useless d_unhashed() retry in d_alloc_parallel()
Date: Fri, 14 Feb 2025 09:43:44 +0800
Message-ID: <20250214014344.329213-1-alexjlzheng@tencent.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250213132006.GV1977892@ZenIV>
References: <20250213132006.GV1977892@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 13 Feb 2025 13:20:06 +0000, Al Viro wrote:
> On Thu, Feb 14, 2025 at 08:21:37PM +0800, Jinliang Zheng wrote:
> > After commit 45f78b0a2743 ("fs/dcache: Move the wakeup from
> > __d_lookup_done() to the caller."), we will only wake up
> > d_wait_lookup() after adding dentry to dentry_hashtable.
> 
> Not true.  d_lookup_done() might be called without having
> *ever* hashed the sucker.
> 
> Just think for a moment - what, for example, should happen
> if ->lookup() fails?  Would you have d_alloc_parallel()
> coming during that ->lookup() (while dentry is in in-lookup
> hash) hang forever?

Haha, yes, my bad. Thanks for pointing out my mistake.

Thank you, :)
Jinliang Zheng

> 
> NAK.

