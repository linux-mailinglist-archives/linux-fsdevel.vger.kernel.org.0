Return-Path: <linux-fsdevel+bounces-63398-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 81997BB820B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 03 Oct 2025 22:43:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 71AF24E526D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Oct 2025 20:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBDCD2459C9;
	Fri,  3 Oct 2025 20:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="V+N28uQZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3731123DEB6
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Oct 2025 20:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759524222; cv=none; b=e812JCz6ZBOb8dbnCTuPWyww/FTgl1CuJxajkNU44veXKDzv6P4R896KSC/51VYNSEwX4UjijbwPD5Jej4W3xpdg8fz8R8DgJqHesZomu+W1diYNa/K5ZeddLn+y11eR/9uSkdyq5Y/SXXZDpX2wqQiaXu0fS11DBvXCZ1vz+Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759524222; c=relaxed/simple;
	bh=QJ+MiU2RqFKMeTRol7GNlGYGMHKg0sbxCL/I/vvGj78=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eKXLvsax8bubjl3jgmRGD0ThixincXsgetsvnooswjDK75x1xJ82EOHFG+VRluWn1+AT0DnooTH/iJRwHpUUfudpSunqX8lpkiYJeQkU6eQKi/pzhwIJSFgGXJ8MXnAcd8+1f/NeVqw4Tbn7Vwh8i7ckj1DurpAc22cAW7ny+PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=V+N28uQZ; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-628f29d68ecso6284415a12.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 Oct 2025 13:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1759524218; x=1760129018; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9cQ5CmO398PdIuFd4iYVItRphmtKilftePIOaP9WHYc=;
        b=V+N28uQZYg1Yn/r9PrNknqR6KDKOsAdLyzN4Z3jXhXwJK4QkB2m3YjqFDGZh/9ud9r
         aq5KrDug/X3tDW/bQvkEvWMAWK/rQYc2sbpJHEzWoQM1ud6f1X3pvmrYD6qcszCtq61J
         HL2CB1jQidbsI1bMqYJT/Qo19zoVq1xo931yI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759524218; x=1760129018;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9cQ5CmO398PdIuFd4iYVItRphmtKilftePIOaP9WHYc=;
        b=vTpEdMsjyWWSHrwdp++bF+C+OE4jtBDgGo5JVaXdoY8fmBd9JrwOQ0muTmKQHJ1kSc
         naPCNzk8TCr0oq7fLwrhFaA9FNqE93DwE3x2jFw9WiKhQVoF7Rfct6VdvZ9DAJdEZOzL
         IVwAtNkQ43kWtMyy7W0qpULuJnkMOcvBix1amS23lBO0oG01UQd+FcpkuKYpcgdgUv5e
         KoY4CF65PlNC1VS/YD/PeHEA1NqURt6CFJbKPb3YH/AJV6roEH1JeC9PJGMz4Dmrrlzp
         rzSu2TwjpnqDjZEwmlYYPtYsmVKS+dRXS+LnwGm7kOyypFgmt75c6eQFNZy3rSYzruRc
         3Sbg==
X-Gm-Message-State: AOJu0Ywziv3YURZQWQ1Jy3p17zFh6+cH8cJWdU2bowWTBsqi1apv/oZ/
	Emr0Wh/36aB5ujf0z21K5OdA9F8G7G7X4CrkQJA6ooo7hXwHVfuoZm4/OFQwSExQ0r9QG/HyhPs
	VATnlzds=
X-Gm-Gg: ASbGncvs0R7YeAlEx3gBW+z84Bqqt40eOoGs65s8JUYvojnloD/kev1bUOA74Evy5fB
	Ij45Jj+79f64cuEC24noRpSvUv/NHUDYzhp2cy7C2JCMpitpdnUmr8s4Rt1N+QYHJ8BbbrK9l08
	EhGcmmBvCFvXuh2F57jJ9RbU9D7P9RiLNLX5p0mWCl0woMXgahB3Kc+YA7tSkP6KiXO4A2X0CGz
	hmtjJ4i2W1qcvxDaINLpepyNJERg0FG5Z30DmIzoH9BjNVer0uLlfREIMav0Wk9NwvPN58Di/jl
	GMvvYGMNY0zVFQTUxPUjtBVavZ7SuNXLetvcKXvAjJlSkm0WMCQTJGKmcvWFQlpHDMgtIbiJJ+G
	BuowN8O+eyUpWGO+yR7660URpwfj1VbaJ33neDdvRmlBraSw3ex2XxcXURDTarTr/hq91QvesHH
	3ncvqm5gaUm3+z3ptk/oL6A+oiL/iHAhA=
X-Google-Smtp-Source: AGHT+IGHuwMbfP34QVVZxhcPrL0QsgnmnWGLWXZY99LmJi9WQiM0NPLyUkWK4SKZpw3x5byAqj2GJQ==
X-Received: by 2002:a05:6402:84e:b0:638:3f72:25b5 with SMTP id 4fb4d7f45d1cf-639348ccbecmr4667080a12.13.1759524218395;
        Fri, 03 Oct 2025 13:43:38 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63788100129sm4781139a12.24.2025.10.03.13.43.37
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Oct 2025 13:43:37 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-637dbabdb32so5094037a12.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 Oct 2025 13:43:37 -0700 (PDT)
X-Received: by 2002:a17:907:608b:b0:b41:e675:95cd with SMTP id
 a640c23a62f3a-b49c157d064mr533292366b.13.1759524216939; Fri, 03 Oct 2025
 13:43:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6lzkazta75sjxv2wrxqmskzqzm36zxgbo7w7yjqqlaejbyjegn@tdxtdkkiqzks>
In-Reply-To: <6lzkazta75sjxv2wrxqmskzqzm36zxgbo7w7yjqqlaejbyjegn@tdxtdkkiqzks>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 3 Oct 2025 13:43:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=wicSxaRNJwTJqvCMCQjoL1KozAdVVq55jYcp-PfgsK2QQ@mail.gmail.com>
X-Gm-Features: AS18NWDptiRxmj-YMgs2PfxO2oOybWVol739TEXxXbRWKKhQ8Wcya31n1pCT6c4
Message-ID: <CAHk-=wicSxaRNJwTJqvCMCQjoL1KozAdVVq55jYcp-PfgsK2QQ@mail.gmail.com>
Subject: Re: [GIT PULL] udf and quota fixes for 6.18-rc1
To: Jan Kara <jack@suse.cz>, Tejun Heo <tj@kernel.org>
Cc: linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 1 Oct 2025 at 04:29, Jan Kara <jack@suse.cz> wrote:
>
> Shashank A P (1):
>       fs: quota: create dedicated workqueue for quota_release_work

I've pulled this, but I do wonder why we have so many of these
occasional workqueues that seem to make so little sense.

Could we perhaps just add a system workqueue for reclaim? Instead of
having tons of individual workqueues that all exist mainly just for
that single reason (and I think they all end up also getting a
"rescuer" worker too?)

Tejun, comments?

              Linus

