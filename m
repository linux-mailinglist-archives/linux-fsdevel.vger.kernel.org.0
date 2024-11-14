Return-Path: <linux-fsdevel+bounces-34760-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A2FD9C890B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 12:34:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E988B34279
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 11:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1B811F9A85;
	Thu, 14 Nov 2024 11:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fZdj/rbO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1539189BA0;
	Thu, 14 Nov 2024 11:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731582210; cv=none; b=Gx4smhdngalXEy+OX08imNxU2eucGHeQg9S7yWyJF+B8kma+09aFV3oIg2ZQEBuOEm+ERIXtXoY+GCpi3fMaZmAlbDsK3fqAAYHDTfRppsifwcqLaIovIjCCYFtJRf7sPEe+a5oQFamsJC563Q8DxnTxiNAVpkRaQc7LHhdJMzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731582210; c=relaxed/simple;
	bh=eDaGMejrU5nK7a1RddQpx8rlLCmezwaor7gmPF1bfDs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A9sZ8MTkEXxAMqp9IqMFhQvTWU3UuP3/yVTbhuoik+q7Xe817jebsrxTCAkS4ph1oVyn5yJgcHuW1gBoP9roEDNmX2r+xkyYjctZj/W+GPXMg2QMynLBMKFKUhTTLq3mzHbHlX2ORYQ8/DDkuF2JIWQ8NN2X3g4YvWHSAe6tGHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fZdj/rbO; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6cbceb321b3so3090196d6.3;
        Thu, 14 Nov 2024 03:03:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731582207; x=1732187007; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eDaGMejrU5nK7a1RddQpx8rlLCmezwaor7gmPF1bfDs=;
        b=fZdj/rbOW5JA9XiuHrjtv83cVUC24qeIZm4+yZG9aOqbengaQbr/+0crhjsRURiqc+
         s1SC8j1VjVWWwOZmAov3Me6zIUoGYEiGFsQY7sIToAvT2qgMy9Suw/wGCnxdUp/aeZg3
         Fdb+8paSqIRxT4boITLPRiuD7Qk0mDEjaToxnUpFkuJqTZTR6MB9o9wm0T+I2/c/m7en
         puF7FSJGgQEmXFWDQP5RDTium728+ZwTF/Ab9ukJMhsEPWz+kX4jsUkh/K6cUEBEmYEj
         VHYJxPrwDAbVzi3c+CRRO/v3t/BE7bzPdiKnPuWqxLoA2Xepp0jrWIbUBL0EQ1tR07Ep
         jJNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731582207; x=1732187007;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eDaGMejrU5nK7a1RddQpx8rlLCmezwaor7gmPF1bfDs=;
        b=AOU1COq0bDykE3otwZGblTgm8Fzylnl+YnipmlR1auhQQ4b73j8hSz4yeoAIdc6Q1B
         H5/vERsfLc973cnCZUqiYEShzLY8gK0wtHEbWwhRgA8dAia9Su+/7Wif6F1cb0jKD3G6
         Z9bxdfVj0XBgb9gYyTrEmtAzxb0dr80w2xLAPji3b4sIq/anp+SDi/Uiq7mibUD5vyIK
         hxfeOGV+23sAt3uTNOZqJVHGh60G9ayz7W+yBlAzfu2jwBmZFtNxZvZauGdzxpJE8aWy
         uFbLVubMzZVTAeMd4V46HiUW7S5a0L9PpVKhNLc1TEEiXNhruU4PWl6WtX2KcEJgspMz
         GkSw==
X-Forwarded-Encrypted: i=1; AJvYcCUnt0/E3T9uP9tIoLfsDp3f85c02li7tVMfCCN5v7lR4WO65GDXbfzdFYvIiKCF0n3Zo5WMkrmE4DcBjAFE@vger.kernel.org, AJvYcCXFHO8KzDviCbXY+FeXG2/kRTwbCVb8lh+dEezNIysiwkIl4RprcnGZWFquGW3bsb1bwElH6FOvtXmkxcdfrQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwilmlfvyAWOSH2X27gMnQqVeUyAdRzrq84lLsrfdWm8CGYGMWu
	FYHN2/1C5qBus/Q9eVfTgg38qPfDJX6UON9oIdNX2l6Z1oVcwr56RZWqVIbits91di+DzMkSrKL
	ULzwWZdCrvfMMBnK76suIOxVUWx8=
X-Google-Smtp-Source: AGHT+IE0eCKuJM6SqSWUcrW+tb8XrphNc7s8jGFP7AL6pcXgX5Ki7WfBvDLqP5uvsAMdsc3EnD+MVdN2JyTcsC50oWY=
X-Received: by 2002:a05:6214:5c07:b0:6cd:ef6f:830b with SMTP id
 6a1803df08f44-6d39e14fe8bmr329592546d6.21.1731582207505; Thu, 14 Nov 2024
 03:03:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241114100536.628162-1-amir73il@gmail.com> <20241114-lockvogel-fenster-0d967fbf6408@brauner>
In-Reply-To: <20241114-lockvogel-fenster-0d967fbf6408@brauner>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 14 Nov 2024 12:03:16 +0100
Message-ID: <CAOQ4uxjj0KNFzL5bxwyZ6XvCM0EnzR3pY3isRZd7JEOeDQcUPQ@mail.gmail.com>
Subject: Re: [PATCH] ovl: pass an explicit reference of creators creds to callers
To: Christian Brauner <brauner@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Vinicius Costa Gomes <vinicius.gomes@intel.com>, 
	linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 14, 2024 at 11:12=E2=80=AFAM Christian Brauner <brauner@kernel.=
org> wrote:
>
> On Thu, Nov 14, 2024 at 11:05:36AM +0100, Amir Goldstein wrote:
> > ovl_setup_cred_for_create() decrements one refcount of new creds and
> > ovl_revert_creds() in callers decrements the last refcount.
> >
> > In preparation to revert_creds_light() back to caller creds, pass an
> > explicit reference of the creators creds to the callers and drop the
> > refcount explicitly in the callers after ovl_revert_creds().
> >
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > ---
> >
> > Miklos, Christian,
> >
> > I was chasing a suspect memleak in revert_creds_light() patches.
> > This fix is unrelated to memleak but I think it is needed for
> > correctness anyway.
> >
> > This applies in the middle of the series after adding the
> > ovl_revert_creds() helper.
>
> I'm going to try and reproduce the kmemleak with your ovl_creds branch
> as is and then retry with the series applied as is plus one small fix
> you correctly pointed out.

Don't bother. The fix that Vinicius sent me was correct.
I still want to use this patch, so would appreciate a review.

Thanks,
Amir.

