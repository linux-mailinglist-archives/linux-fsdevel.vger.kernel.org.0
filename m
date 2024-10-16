Return-Path: <linux-fsdevel+bounces-32077-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A199A0464
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 10:36:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D0791F264DC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 08:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 079931FDF81;
	Wed, 16 Oct 2024 08:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d89GzWFi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C691FCC63
	for <linux-fsdevel@vger.kernel.org>; Wed, 16 Oct 2024 08:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729067786; cv=none; b=CiifC14WuP0KILHhz8hx7VQE7jEvJkLq9Vic+DzAtGCjHA/NFkAG0JUWBGb1TDHizG4wyBDmsfCKdXHoKyG/9JceKKxjMCu/ueTzGrokIzNUAUxFpPhETu3vp0D6eOmQNM3G2QZHUkAGwyccb+RFJq5LdfJCZEdTn6ZqxZ3qi9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729067786; c=relaxed/simple;
	bh=GNCebuizsmxDYYTNS4RuuXhjR8lSTd+b/g+z3SO6iws=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Is9CfgARfjyy4Y3fd9Wwc9uAQhbyXrlCpiLfSgTDuz0cQ0d9QgaS5/bJeOFK2Q4oJVdzNQANybsiaWOH0b3FeBHvQRhp+afMrrk63IFtZUMJHnravHlPaguIYKDO4ZXRq+iMQuRAiFTZUgfKqt23s69Orm3iMGaem8cfZYaNDXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d89GzWFi; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2f7657f9f62so62412381fa.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Oct 2024 01:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729067782; x=1729672582; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GNCebuizsmxDYYTNS4RuuXhjR8lSTd+b/g+z3SO6iws=;
        b=d89GzWFicPLxVm6g1/ek2pHjJ6ktJxCxotIaP4SLI0XkWG4NgP2daNYbcEgJ4jEQJ7
         9dJ3HRACnnIfOJiJqwD8LzojG73PrjVTz8WN0TS4zBFlqCKITAlij3C0Da9bjt/mb2Wb
         4MJlw3UMbj4jpNz6g4KyPyUJyoVWuOb514HfATvE4zQ7XdCyCpK00ltrewLFk8sWIUzx
         I30nt/GQNXIE6kgG1RrM3Lq76GjfZQF+6NSQuWKWPH65RiLEnylf07CcvCzNkIkoMfii
         96tUQxDJecPUVTMxfDA28VAVP3l1zntlvmYG8fSDKOre1O4HY4SJk73FmG1VdACL1X3D
         4syw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729067782; x=1729672582;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GNCebuizsmxDYYTNS4RuuXhjR8lSTd+b/g+z3SO6iws=;
        b=tdqbPCYqLQUcx4omhVVobCnTEpcOV4dJssuWJ0ML1/tfN3vcEy1d0I5Ry/zGFYJNPG
         te/txR6vyDS3H4ejh0yL5n4s1xSLBV4Yk3Dq/hUfrCCqbZoymoG0+QbV6P8mRMVyVHUQ
         0rh3UyHxtk2jPV7MSY6UzDb1Ht7JLzWjFbFDBObSP9NAXqpd8gQNGmwl+Bh44iDYdumQ
         QB7XEO4uYAceArlR3acgCAZvK6fkq/eTl/MqSE7iEyVp2aejBsvTP35b5v6V2Oo+6cdZ
         +4Rgm5oIpt6gM9aAwKY9lGi/oMmmQK/dGQ+i6J5/b09VFl/fj4VDgOOlKiF6rZwyQILn
         rqDA==
X-Forwarded-Encrypted: i=1; AJvYcCW8+5kXaWV88wYE8ypfwCwvTn8eRa47EXLqTbmduPVw3jWiQkHmIBIif+uBq0qRyRPuh9CK0tzoduINBbx4@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2JQ97ud1TwU0RQsBB5X3mr8dJewTY4GMU4sFpFQonxVysGmEK
	IWsIaJqxD9TXM0lMCryAmgLFqnNPwV3mHsR98Ogoboy/Np0llyw4K0g8pApbbKliNhr6VqsRtpB
	GUIWBVyVufWCssWBn1zEcPzryxFKHpeqaK1Oz
X-Google-Smtp-Source: AGHT+IGBp50/rrajvwuHfUxP9JITk22QCzL/u+4K3VGqPUoJic0EKKUAc1hZr7U/fYC7c25/+4pYzcXLeYPkaJsM5pE=
X-Received: by 2002:a2e:be1f:0:b0:2fb:30d5:669f with SMTP id
 38308e7fff4ca-2fb61b3e651mr19527991fa.7.1729067781865; Wed, 16 Oct 2024
 01:36:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJg=8jz4OwA9LdXtWJuPup+wGVJ8kKFXSboT3G8kjPXBSa-qHA@mail.gmail.com>
 <20240612-hofiert-hymne-11f5a03b7e73@brauner> <CAJg=8jxMZ16pCEHTyv3Xr0dcHRYdwEZ6ZshXkQPYMXbNfkVTvg@mail.gmail.com>
 <CAJg=8jyAtJh6Mbj88Ri3J9fXBN0BM+Fh3qwaChGLL0ECuD7w+w@mail.gmail.com>
In-Reply-To: <CAJg=8jyAtJh6Mbj88Ri3J9fXBN0BM+Fh3qwaChGLL0ECuD7w+w@mail.gmail.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Wed, 16 Oct 2024 10:36:10 +0200
Message-ID: <CACT4Y+YS+mSjvx8JheONVbrnA0FZUdm6ciWcvEJOCUzsMwWqXA@mail.gmail.com>
Subject: Re: possible deadlock in freeze_super
To: Marius Fleischer <fleischermarius@gmail.com>
Cc: brauner@kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller@googlegroups.com, harrisonmichaelgreen@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 15 Oct 2024 at 21:30, Marius Fleischer
<fleischermarius@gmail.com> wrote:
>
> Hi,
>
> Hope you are doing well!
>
> Quick update from our side: The reproducers from the previous email
> still trigger the deadlock on v5.15.167 (commit hash
> 3a5928702e7120f83f703fd566082bfb59f1a57e). Happy to also test on
> other kernel versions if that helps.
>
> Please let us know if there is any other helpful information we can provide.
>
> Wishing you a nice day!

Hi Marius,

This is a wrong kernel version for bug reports. Check out:
https://github.com/google/syzkaller/blob/master/docs/linux/reporting_kernel_bugs.md#reporting-linux-kernel-bugs

