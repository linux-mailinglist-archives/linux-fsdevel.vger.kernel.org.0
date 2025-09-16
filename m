Return-Path: <linux-fsdevel+bounces-61712-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DAE2B59281
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 11:42:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DAB53B02C5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 09:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7931A299AAF;
	Tue, 16 Sep 2025 09:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NROLxOU4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D066129B775
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Sep 2025 09:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758015727; cv=none; b=VYKw4G3EHhe2lVLtZMvhly2xy5t9g3bBbViydyYNvDs+va8Pwx97ce8tJu3z3KB0AG8XnSlMUpHA38dl4hA/yk7Gf9q3alvetxKgjUgugekw+AW+6EZR3vIaNOXYkxxMeW7kG8Oy6ZTOtALOeMMFZdVop3logXH8DseT8J+zvqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758015727; c=relaxed/simple;
	bh=wtSv0L6/GwqZZywYhmXmG694rGZXr5C/8JsbMi/MtQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UAzknHM83w3J/Qd1RxMNVcKlsw9AnA9jCgSL3Ze2WWJ6A4Ovo44veGmG91pPYXObDCHEtGNt+UAcHX6JGolIOqUXcU4Hw1D6fqw7jb+adqc60mo8U11FIpMBIlGH3NLs5pgtW+4ScWAZYhnp6CoL9GndtcY0y/Jn+g/XAxHbROM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NROLxOU4; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-336ce4a8bfcso40715341fa.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Sep 2025 02:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758015724; x=1758620524; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=haBjQsvE5vE3ZaF/RXUldLy+CB1Z0cpROeB+NEV/yO0=;
        b=NROLxOU4z9V4kypeFZVw3XwLvlvgr7633NM1a03un3CtR4lJaMlWQe4MQ9UCfQlvEb
         6ob7dt32cZ4IpbAOwNI4qTzia9lGJazUfcNRQp/OvPUSDu7sGMuWeYcpArVUzIW4p20/
         gKtwWEXsjbsLeP+PHDVCpBxenDK1C/PGey1OlckTGwKYRad5H3S3uYuXCz0vu8CDIW7T
         egPW/KGCxW3n6bStOzn36fCBk211k/YGoekXP8VanV1j1gkifMzn/eUrtagsp5xDC43J
         /jMULwG82ttCurMTfCNleWqTU5QOCkSM5vljU7z/8VsgANXljSZs6vhM5Asl795xTzI1
         suEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758015724; x=1758620524;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=haBjQsvE5vE3ZaF/RXUldLy+CB1Z0cpROeB+NEV/yO0=;
        b=YetprDiqzFT8rgNeC+OUUuRnFrKCK4ZpjsLu/HHI5GiO+3Op97SWsS4EP3lf08Sa2I
         //IxJfSSLWkl8b/l4kmTpNLb1QU2athZIFLpY+k7738MF6wpmhI6WcMmzOgm0kqjIch0
         GjR4li7t4l+0a16pyCGWGF11gK5D9M0vn8yzfsfRV3FEYLQ3Hfs38KyTNYuSQbW6XCYO
         lCJ+3yaNPn9fxyACrc+NuT04gyd1Ibkp6AYkU32KIW3XS6abFaPwfW9jL2weyNqpYWCZ
         AsmNVK6wXDGzYu94HYCcM1Ejiy3y8d4p76TLBe6aHEqE+SvhntIbbQnKPmM0hkJjn/sG
         TRlA==
X-Forwarded-Encrypted: i=1; AJvYcCV5du/gMM5P+TqRqm4yXExxnlrTILBHRERInR14h2C1X0dOcQn38rSWA0K1KcTGjdckBH7HkgyYG8kuTAWv@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1yrl6s6xs5s1HphxQxi5UjNvMddVqjHhwoTsP8boj/abSiN4i
	3+mdzS/CSdyisnghBts7t6VEAF4qmC7Qg4o/wZ1a2LaMCeY2GYLw4AvI
X-Gm-Gg: ASbGncsX/xh32YP8r5uHO2GPuJXgYYM5l+UG49jvBicSmmda7PE/b2e3E6bLIS9c/ho
	a7cYgFK66Vwe8EhU71h1N7HICAQs5pcbxJ+BVJpNtXn9iRqJRdNEeetubWDdlryPwAIkECR/4UO
	LJ44RuklXDYG5Sdq8la3xC52YCjKckaIpyFYGaFmuT8PtYc1Q2eHM22HQ0ALgC3w5UlzX0zrohD
	M5dMiQvpylBXLOmIFYU/xbYfiDI2edmk8EXmgWcDCcIwdU1Wyvwa4hAqcRQfs2L3HyeNszyo/B3
	/YhI/hjJIIA3Ui6KMJ8eKT2qJlpbSv5PYbORuY2MOLUJeO/P5sFmQ+K/Vb9cuHKNRlhpiMMtPty
	pvrQtQ8oQtp/PmtVstj6eALSQhUcIct3CodhP4rNDpLloyYk=
X-Google-Smtp-Source: AGHT+IGHsAz1XUgqjX9cBNXDDceT4RSYaRrx53ol9Kht+YGnRRfTcQN5imeqv3DeXohNMYqhdx9Bfg==
X-Received: by 2002:a2e:a00e:0:20b0:34a:7575:36db with SMTP id 38308e7fff4ca-351401fd0f5mr48965051fa.33.1758015723646;
        Tue, 16 Sep 2025 02:42:03 -0700 (PDT)
Received: from home.paul.comp (paulfertser.info. [2001:470:26:54b:226:9eff:fe70:80c2])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-34f15a5835asm32481881fa.4.2025.09.16.02.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 02:42:02 -0700 (PDT)
Received: from home.paul.comp (home.paul.comp [IPv6:0:0:0:0:0:0:0:1])
	by home.paul.comp (8.15.2/8.15.2/Debian-22+deb11u3) with ESMTP id 58G9fwKw021585;
	Tue, 16 Sep 2025 12:41:59 +0300
Received: (from paul@localhost)
	by home.paul.comp (8.15.2/8.15.2/Submit) id 58G9fts1021584;
	Tue, 16 Sep 2025 12:41:55 +0300
Date: Tue, 16 Sep 2025 12:41:55 +0300
From: Paul Fertser <fercerpav@gmail.com>
To: pengdonglin <dolinux.peng@gmail.com>
Cc: tj@kernel.org, tony.luck@intel.com, jani.nikula@linux.intel.com,
        ap420073@gmail.com, jv@jvosburgh.net, freude@linux.ibm.com,
        bcrl@kvack.org, trondmy@kernel.org, longman@redhat.com,
        kees@kernel.org, bigeasy@linutronix.de, hdanton@sina.com,
        paulmck@kernel.org, linux-kernel@vger.kernel.org,
        linux-rt-devel@lists.linux.dev, linux-nfs@vger.kernel.org,
        linux-aio@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, netdev@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, linux-wireless@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-s390@vger.kernel.org,
        cgroups@vger.kernel.org, Samuel Mendoza-Jonas <sam@mendozajonas.com>,
        pengdonglin <pengdonglin@xiaomi.com>
Subject: Re: [PATCH v3 11/14] net: ncsi: Remove redundant
 rcu_read_lock/unlock() in spin_lock
Message-ID: <aMkw4zTLRJqpVGCm@home.paul.comp>
References: <20250916044735.2316171-1-dolinux.peng@gmail.com>
 <20250916044735.2316171-12-dolinux.peng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916044735.2316171-12-dolinux.peng@gmail.com>

Hello pengdonglin,

Thank you for the patch, looks reasonable and justified.

On Tue, Sep 16, 2025 at 12:47:32PM +0800, pengdonglin wrote:
> From: pengdonglin <pengdonglin@xiaomi.com>
> 
> Since commit a8bb74acd8efe ("rcu: Consolidate RCU-sched update-side function definitions")
> there is no difference between rcu_read_lock(), rcu_read_lock_bh() and
> rcu_read_lock_sched() in terms of RCU read section and the relevant grace
> period. That means that spin_lock(), which implies rcu_read_lock_sched(),
> also implies rcu_read_lock().
> 
> There is no need no explicitly start a RCU read section if one has already
> been started implicitly by spin_lock().
> 
> Simplify the code and remove the inner rcu_read_lock() invocation.

Reviewed-by: Paul Fertser <fercerpav@gmail.com>

