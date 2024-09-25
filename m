Return-Path: <linux-fsdevel+bounces-30111-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4010986451
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 17:58:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F5DD1F29834
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 15:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6351722318;
	Wed, 25 Sep 2024 15:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jA/9B7Si"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE5B1D5AB5;
	Wed, 25 Sep 2024 15:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727279892; cv=none; b=F/SCyNc0HFxJNn1z+i7xLdQLGCKt/sj8HHwaQ1wrW6/1AzoxhgpoDfS21OP2986vLUDaRRe1AWC0ED0txtvdpzzST1C3bLURkngFoItk45K48yXNxZ8IyrFSsPQHYE0cGZlHBf4L0Iqm4AhqSXAIbRpYw47AwX3THd5s5WWtqR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727279892; c=relaxed/simple;
	bh=ZmQ+Hbci72so2fIBNBitL7I3E1hn4Rvgzv27VUz9GOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CFoPLfkB6G8kCG71RML9BNwA9gH66oxxYrXJx1J0Yc6da3H3EvizJVJCMcEQbk5/u7NwYZsWvPqSzks60dIzlQMU/MDGag70K2AcTpebbZ4i56WgmWQ0Zl85/1103ySN038xhB9h60h5RUzttrqPu3Qj4xpPJOKGbDUrKBst1BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jA/9B7Si; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5365a9574b6so12583e87.1;
        Wed, 25 Sep 2024 08:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727279889; x=1727884689; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=udQa39EEbco2n1ErcFrIP+DxYHJRAQavNIBG8lRYP4M=;
        b=jA/9B7SiixRPElRrW1oix0/UuiumCOMfGUZfbQp8GxVdLs0z2cHpTC/0eww/q21xeA
         nDVN6TJxF3p/UpQYOEd+aDuErCziXAaCzuVOcv3ATAao4PKME26QVoRNZDFla2Mqa2Vj
         Ye4q6hz+y4HucUGhnCCdzwENenM902Kv79Nvo1DC6UYJ5hz0n00iD7C+JUeSEHeHxU2+
         BJiH8vJEdi/U/GFoFew0c9wcMtvH2ya8cdiZIsmWWloUIGJym/N20+QKLIt+asaCTs8E
         FohyqrSik0TGR6sGMyLe60pJKcKiv09Ph16+KEMcgGAnZy0n3e0dpw0K7oZk8IuSqV8o
         WfiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727279889; x=1727884689;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=udQa39EEbco2n1ErcFrIP+DxYHJRAQavNIBG8lRYP4M=;
        b=j1t1IDDHEXsE2JxOWpFAh03/QBXz+um3ibtyQ/SJk6JlFsXKQQgZIe+8zfow5wQuPu
         KBCtmS0itfEU0lFEtUxJ9PcDGpHSO/Nb8frhQ5YgLr0l/A8FTqnQwUBH7OoEf6JuUo09
         hKjQ5o2Aob09SlTKcHkiFwi88a+8qPeMC5Ov9HMHNjH2a7/q9EIX2lhMWgCO6G6BXzxZ
         0hOsJLx3UqZcSQrY+deu/hkU2lgD115fciz4rQTsW9j3ziRgtfSP8Hfj5YpNW/gQ1r2R
         hjmrBLPtw1TBFORdNkUQwYljr4N0bUwWH06Nb+k0c1rfgjLvulyHZ18c4UVicJH7Ob+R
         cTGQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7HAKq7z+RmVT+GaOki3SXGAzVhr2LGnhRllfDpDUfPTaXt4AnONR4WB8Y3gG5QOXUjI5u0s1n@vger.kernel.org, AJvYcCVKcoHebrADhRFTX/ibd71rqOXt4+rt9h2IijsxIKcQh09g39zsDVKvXJr5mhTCWNsq0fn5E76yrmjGpWgQZA==@vger.kernel.org, AJvYcCWTFpYk1HyzC8WkqNSxTeQNR1gTvOwlKsfTtYzkvOaa/+D6qUos9+EAH9jxk63L4LsKm0FutpB+ThXSMVMov5p1JHfxp801@vger.kernel.org, AJvYcCXKWLKaq0uOMSdQ8wtZQqiLCXRWWTtRmzSTxqGVsMP+VUd24X8qxk8WD8zAv79TA+PCvUvXUjSEaAs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqmvwKeI2U/5PcNK8p15urutO2J42VpU0FTuvN0Q2P0nuK5aQq
	1OG3RVNZFa3czui2rRNvZ2xjNvpr92SNW6jS+4keL/0FDbhPIWU=
X-Google-Smtp-Source: AGHT+IHQmmriMvCrYWArFCNGsHJHa+Bwek6GuCRIT5BhH3qJ1Vjq9L50rAECCCidv3UX8aSvntbSyw==
X-Received: by 2002:a05:6512:239a:b0:530:e0fd:4a97 with SMTP id 2adb3069b0e04-538693aa1cbmr3157087e87.0.1727279889057;
        Wed, 25 Sep 2024 08:58:09 -0700 (PDT)
Received: from p183 ([46.53.252.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93930f7860sm228237066b.149.2024.09.25.08.58.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 08:58:08 -0700 (PDT)
Date: Wed, 25 Sep 2024 18:58:05 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Adrian Ratiu <adrian.ratiu@collabora.com>,
	Doug Anderson <dianders@chromium.org>, Jeff Xu <jeffxu@google.com>,
	Jann Horn <jannh@google.com>, Kees Cook <kees@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>, corbet@lwn.net,
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
	thuth@redhat.com, bp@alien8.de, tglx@linutronix.de,
	jpoimboe@kernel.org, paulmck@kernel.org, tony@atomide.com,
	xiongwei.song@windriver.com, akpm@linux-foundation.org,
	oleg@redhat.com, casey@schaufler-ca.com, viro@zeniv.linux.org.uk,
	linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.6 048/139] proc: add config & param to block
 forcing mem writes
Message-ID: <e22f3662-c985-4409-99f3-5168fa2a4b9f@p183>
References: <20240925121137.1307574-1-sashal@kernel.org>
 <20240925121137.1307574-48-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240925121137.1307574-48-sashal@kernel.org>

On Wed, Sep 25, 2024 at 08:07:48AM -0400, Sasha Levin wrote:
> From: Adrian Ratiu <adrian.ratiu@collabora.com>
> 
> [ Upstream commit 41e8149c8892ed1962bd15350b3c3e6e90cba7f4 ]
> 
> This adds a Kconfig option and boot param to allow removing
> the FOLL_FORCE flag from /proc/pid/mem write calls because
> it can be abused.

And this is not a mount option why?

> The traditional forcing behavior is kept as default because
> it can break GDB and some other use cases.
> 
> Previously we tried a more sophisticated approach allowing
> distributions to fine-tune /proc/pid/mem behavior, however
> that got NAK-ed by Linus [1], who prefers this simpler
> approach with semantics also easier to understand for users.

