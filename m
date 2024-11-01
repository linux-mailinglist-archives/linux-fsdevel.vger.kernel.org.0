Return-Path: <linux-fsdevel+bounces-33485-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C59C09B9587
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 17:36:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D284C1C22060
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 16:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A59B1C7610;
	Fri,  1 Nov 2024 16:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XIcg9who"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00DF7130A73;
	Fri,  1 Nov 2024 16:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730478923; cv=none; b=Eb4XyH+yFjGkZuAGTwIAz/z79x2YN8CDA5p2uvrphRMFxm+Z3iv1aP95we1EB7A6z/VM6W+wzijMLtEqlgivFKMYXiBu+SndlgFvj/eXI37G/fbwshZOE38/hPFaFH85g4GU+VNQYGjP7ZEzdjBJ7vE9GqBwTfwdmxo/VGmsvw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730478923; c=relaxed/simple;
	bh=+1C8XZLRKBsstfJe1rtPfe199feU9kaxe8V4whbdD18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o49vM9ztWZd1oxU03Q+SqAz94eC72El56BExRT4f3esRpO98L1rB8YdG3IRsCy+NtrWmK5EVRGVvNrozo1c6mC5vz5z7AqzoCtffwcP8YRupR/lsc3jOQNOVketbC/p5KrDAhFWtEv5X4ukMH6Ir8emdTXNtSxFvmeeEm+xhPx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XIcg9who; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a9a0f198d38so323215866b.1;
        Fri, 01 Nov 2024 09:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730478919; x=1731083719; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Tpr6TYQOLg8yjzavlYiVrt5ZjA57kPKJZVGbq8xKRME=;
        b=XIcg9whoUXHa1XlmuLRi5CKcjWCZn5YkHsUYpV/OK2bBPX44/3QroxfR37wI4pFYdb
         tpVTxIObr/NONKtZorMbERQhPA8rqCKEdmB/c9cE1chwS4ikq5NzGt5YXuvNoxJpMDKA
         NRNI/kD60kXYTOZEoJnd5eVFbNo2U0uxmKDaRNYUN08Uoz4pU+aGwu3lw3pfPHX8it2Z
         JngceSZV5Y/WaFC/KY6ozHkVL0hlrNvyV1RcoT/clNBXRlpaS45PIWxaLWn7OSdZ8KGd
         CagEV97EKyg44lsTgLuqGF/s2fLgo4qYqZTB4SybUHUsf1RSystxpx9OTniFtRGh34us
         rFNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730478919; x=1731083719;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tpr6TYQOLg8yjzavlYiVrt5ZjA57kPKJZVGbq8xKRME=;
        b=MXcxjweLI0uWNIYsukVZLdHIHLaIrCvxjBnWXO//dq1jFUCKCEvGsorMCRa94Xi36D
         QuoJ7+1UFdu/qp9P+7O5Kt9XkaKkOltnBm1x+S1tOk1pJNUOw+ldE5dpwvqzj2kl2O2B
         PXdKT7hw5Sw07I08ie4YiGg7fnIq/+78KIIpUtEyiXC/4nlYGzwogcofStnLQzU/lvqx
         4f1q2HLPOWWabMWaurUNQGr0C8zIOOcGbT3bXAleubWN2OkGA1MNuYz5lka6zWrPUp3W
         jPGzpRYlS0lfSioB0sjfJOxy0JEvtHBGEPwsicTB4JvpzQDB5JT+6vMdNJJ/kby/f8Ou
         UNWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVdvhWNPIJW7hh5DvuypzeEBgEZISAZ7WkxEGjlwFtYKyaKIAv90/7DjcEELirmmxMIkiIOuZEhAJVp0kRZ@vger.kernel.org, AJvYcCXYMFZP31zrA5JS7yUYkP/OJlTMJO3S4ZWM42KtSuZrM0DBJQDnV+cu6Iwm5GovIG7MLo4MtaLiFYn37g+d@vger.kernel.org
X-Gm-Message-State: AOJu0YwZaqH+HBbfo++o7YcydhElN0Gv6H+3pQw4kN6jd0uzPOzeX+xV
	f9dDk3aObYD4+FHFHgtKTkpzbrHCACVF74S/G4JptQCxwK89HPo=
X-Google-Smtp-Source: AGHT+IEPkDHlV3oZirqn7gb2APSbbjvfSUiHI2RlzZX5BtBGJjrI/zST1FWntl0hYPnzQII0rye3GA==
X-Received: by 2002:a17:906:f5a5:b0:a99:8edf:a367 with SMTP id a640c23a62f3a-a9e657fd779mr364779566b.57.1730478919134;
        Fri, 01 Nov 2024 09:35:19 -0700 (PDT)
Received: from p183 ([46.53.252.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9e56494202sm200956866b.22.2024.11.01.09.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 09:35:18 -0700 (PDT)
Date: Fri, 1 Nov 2024 19:35:16 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Qingjie Xing <xqjcool@gmail.com>, christophe.jaillet@wanadoo.fr,
	willy@infradead.org, brauner@kernel.org, viro@zeniv.linux.org.uk,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] proc: Add a way to make proc files writable
Message-ID: <978cbbac-51ad-4f0b-8cb2-7a3807e6c98d@p183>
References: <20241101013920.28378-1-xqjcool@gmail.com>
 <20241031191453.a4c55e8b2bfb4bf8349f4287@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241031191453.a4c55e8b2bfb4bf8349f4287@linux-foundation.org>

On Thu, Oct 31, 2024 at 07:14:53PM -0700, Andrew Morton wrote:
> On Thu, 31 Oct 2024 18:39:20 -0700 Qingjie Xing <xqjcool@gmail.com> wrote:
> 
> > Provide an extra function, proc_create_single_write_data() that
> > act like its non-write version but also set a write method in
> > the proc_dir_entry struct. Alse provide a macro
> > proc_create_single_write to reduces the boilerplate code in the callers.
> > 
> 
> Please fully describe the reason for making this change.
> 
> Also, we are reluctant to add a new interface to Linux unless we add
> new users of that interface at the same time.

Yeah, /proc outside /proc/${pid} and /proc/sys should be pretty dead.

