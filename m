Return-Path: <linux-fsdevel+bounces-42368-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D8FCA41143
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Feb 2025 20:12:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0A167A486D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Feb 2025 19:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E034156677;
	Sun, 23 Feb 2025 19:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="dYvtW6Rt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9838615D1
	for <linux-fsdevel@vger.kernel.org>; Sun, 23 Feb 2025 19:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740337956; cv=none; b=SrbVWsfTBMY7gNdp1bVotymo4KWxD2JwudSPQIgLZ2KNupjfkHcJ0iLZ4Le1O8hmxRDgltabnGFu8YOoc70TrhWgPsrOvHnXSxUKFN10qQjlBlVNfSwaFRw7xccxuqXkgtTBvuY6y5wv41M2Pc/tWzxsaW5XSsrl1KvxceiyNVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740337956; c=relaxed/simple;
	bh=pL62aCTroa2tKEwU1uZgf77b7T7rJBU0loou86z00bg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dz6E69GMLZkCyyKHDC8fiF8OqB32alyRZvrCBMQmQ8Xgk/ZwzL16yGGw3IGr0cwkuQN9mzKcqku+zHh3hoNd+k3Svb4X8lFg4WN38MCeaczqTTL35TmC1WxVqukwDpMR+IqrTsz6f1TqM5eLuH2SGDe9rxkjzepmbAhs5MFqZL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=dYvtW6Rt; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-471f9d11176so43797291cf.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 23 Feb 2025 11:12:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1740337952; x=1740942752; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bHDAUoZjjRE7OQp3ihjIBs7r8OEcOjf2aaDxUVThfoU=;
        b=dYvtW6Rtw9VTkpbTFTbnkfbRwm014/BicAoXVQL2o/WhfLChrj1ZZ1JgQY3oemf5rc
         eFXegJqf4yiOttPECkIvCs8dbJI/eCAtUhquqa/W5ErTGHj/LKpjsj81dFHt/SDaulyg
         ENfU4Qj0GpoyoMWLt+Tn39tm2dT7EKA/mxEn4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740337952; x=1740942752;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bHDAUoZjjRE7OQp3ihjIBs7r8OEcOjf2aaDxUVThfoU=;
        b=seN5Q5/93f2zfYT0BehOnFevg3cZwpjZPQSf1EjP1tu2jMdDuYKEhzjGX4meIu9LSR
         oHEfc+LI4XIMtEjfm1VV6AXlLnth9SLkCec2xkoh++Tw7e3RCgBQOMf6aG7MklaSVdQ5
         kTHc6E/fENeZ3PcPPhLlHM6ib3cF56fwZqw3eW6MfsPENot96XzUFSsDj5iNwsh4GvVu
         ng3NLH9HZ0IBgt0DV/YyLI3+PZwj/sY/oebUfxsAHM+V/napjwwqX1FLbo10nYsQjH1g
         KBr+M1rtnIObOf/VWkZscpCA0l6QPCLU49mFFll9LzqNgnGOc03oaOBFI62YyqaX1noI
         /m7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWu7yzAh1DEXHtcVQoIQm0X+Na+d3USkJiTIu8CDgGxWjcqBoAfIYkplfioxncvxqUHv9aHJU/uyVKnhwtV@vger.kernel.org
X-Gm-Message-State: AOJu0YxA3l1jnrC3nTA8lU4ohpT6ECw8aaXW2gdP4VwOAntuz0PgaD4y
	SnetKSBz5eVTrm1yjZPeMnoiz16nFC/lo1dkYrbbEx85Fg6SpYYVg66WPU8cdqXeIbU92YWgj2f
	8g5whNdXbHh6m7/DFRfRbw3dc8AowubcaUz19Qg==
X-Gm-Gg: ASbGncvZixsTSLg/BHigyglzAQ8a73I5ZXHeF3p9/XNpK6zVCFqTj0CY7YQpsqEC0+C
	oTEw3WBKBYNv7JM0JuyiLDWixd8zCXEEkfkC3egcsf0Gm9GwaNK+w+D1oMDcpEyPnNjLb+gkgPR
	XN2vU0lXlM
X-Google-Smtp-Source: AGHT+IGOKnHttScWBNOivPLsHLk1fWRCcw1L45+gYFIYGMZYlAwyxGTDyOFIabkMjSNQZARcE9bigLLdO99AF7ryW6M=
X-Received: by 2002:a05:622a:1a0e:b0:471:ef69:ad8f with SMTP id
 d75a77b69052e-4722491e984mr162334981cf.43.1740337952272; Sun, 23 Feb 2025
 11:12:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220100258.793363-1-mszeredi@redhat.com> <20250223002821.GR1977892@ZenIV>
In-Reply-To: <20250223002821.GR1977892@ZenIV>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Sun, 23 Feb 2025 20:12:21 +0100
X-Gm-Features: AWEUYZnXJiKYAih1XiIRfb-ZVbTlEOU59aKDaWl_vNrsOI0JK_X2czR73CKUi9w
Message-ID: <CAJfpegv24BN_g3C0uNPZu_gM7GEy_3eSYyFSaeJZ7mLsfcNqJw@mail.gmail.com>
Subject: Re: [PATCH] fuse: don't truncate cached, mutated symlink
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>, Bernd Schubert <bernd.schubert@fastmail.fm>, 
	Laura Promberger <laura.promberger@cern.ch>, Sam Lewis <samclewis@google.com>
Content-Type: text/plain; charset="UTF-8"

On Sun, 23 Feb 2025 at 01:28, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Thu, Feb 20, 2025 at 11:02:58AM +0100, Miklos Szeredi wrote:
>
> > The solution is to just remove this truncation.  This can cause a
> > regression in a filesystem that relies on supplying a symlink larger than
> > the file size, but this is unlikely.  If that happens we'd need to make
> > this behavior conditional.
>
> Note, BTW, that page *contents* must not change at all, so truncation is
> only safe if we have ->i_size guaranteed to be stable.
>
> Core pathwalk really counts upon the string remaining immutable, and that
> does include the string returned by ->get_link().

Page contents will not change after initial readlink, but page could
get invalidated and a fresh page filled with new value for the same
object.

It's weird behavior all right, but seems to be useful in a couple of
cases where invalidating the dentry wouldn't work (I don't remember
the details, cvmfs folks can help with that).

Thanks,
Miklos

