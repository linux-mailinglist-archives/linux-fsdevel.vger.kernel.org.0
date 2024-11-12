Return-Path: <linux-fsdevel+bounces-34425-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D15FC9C53DE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 11:34:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 895FC1F231FC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 10:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B5C2139C4;
	Tue, 12 Nov 2024 10:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="MTdWGo2v"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249F320D4E3
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2024 10:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731407577; cv=none; b=XqtkZTB5F8xNV7cEfwEPj+2Dbod3YmcYRCILpQEsWKlr/+n1Mb1B/X4PM1iNGy/PjVr/DQE86XiJk6yhqLq71XCj3+XOKRD2fw90RgesWJhaaE7Qwx760rg8nww4e00/jIZye1p2Lx6L02j4qo/0cBQ801DwdBRxarrCdY4viz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731407577; c=relaxed/simple;
	bh=OIew12GHF+xnt8Vkq19r/MC1ps1jVYsEHY2A8MzHpF8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lWasP6xoCeiuc0xAa7usRDbKWO+rpMSUePzMWwLwo4Qqgv1fLCd6up3o+daT0J/mGr+3bqZOBbSnUZYuB5eSPvKmIwL2VM+pcCT6UimfcV8nQCp0asDRRhYPsU7cjlM4GThLaexMy4P0MHQu5Hg1TCYQQjQZ59PSHYYoqukGs1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=MTdWGo2v; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4609d75e2f8so55379831cf.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2024 02:32:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1731407573; x=1732012373; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=r7gAq+ChZEKrR9v0dJsNpJxXDvU0gKFXo5LHzSUCVyQ=;
        b=MTdWGo2vjRF9Jb64/hLvhmfUPdW6E9/2o4cFsyhCdgph+c5OGHE+6IrRaoVQd/wJHc
         CVJNA1feXS2qwpoh6SyHYA8W0Ffqe8L+CQYHO8dVNAhSwOeNXoBO2nPmrIUwVvV6CdoZ
         OnrOBHcoEsrARNmVD3iwzZqW/4iXs+JCOd8TQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731407573; x=1732012373;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r7gAq+ChZEKrR9v0dJsNpJxXDvU0gKFXo5LHzSUCVyQ=;
        b=TU/7VD5LxDzMJ4298xHFHYNYbI8bwpEpiJ5XQMIZwrKER2GfdCPkocIrtBPlJfJANC
         dlM24a539znY3wxBg+apWp/cEOioesoz6OLGh0vtgznqC0DqJmRrEmMfd29g+JHLVPhn
         UdyJkvZgGy05As90teyTFjymMGGlw5N/50kFxlYGIQwipPGXH0noe6dQf5qSTokGLFFQ
         GCbcYfBi+aijSS5Gqfm4BrEr1aH5sFOTUI3gGVVBguHRfXvR6lp/GtTAxF93pjvV2pj+
         +uArW4Y1PIPOXz5VpTq4tCvYr5Arp3QReYyqsk0NJKGcpu0ZOyDuMV0vF0nhfJ8Q2xZc
         48JA==
X-Forwarded-Encrypted: i=1; AJvYcCXTreM9vwRGKSosCTicX4es4464mA4FYU456mc1N1gK3XWS93fSBVCX5KRhWRcVEvl7e+XIVlRgcuo9VaEK@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs4Fy2jY0dIFMSgPlhgOMTWzHXqMuHTxwnXxuoTD1Qrr3KIjAN
	0iWJ13o1e6XXZtE37X/uYdIjE2gguWm7pIduKjCROi11cIiJZDCFt2+Wg00cwhOqULVb2ooL0Gm
	O7gJFfC08j6xjQCJ+E8mswsu052yHxbz5YWdktA==
X-Google-Smtp-Source: AGHT+IHpSETzbG96Ob7chAWHSfTkPJ7hV2uyCplMZIYtf3U1U9TVDdH1wtyxXaUdTVsu+jL810WTxx/QQ22N+bZtYMo=
X-Received: by 2002:a05:622a:5448:b0:462:a961:6316 with SMTP id
 d75a77b69052e-4630864c5f4mr279927521cf.26.1731407573119; Tue, 12 Nov 2024
 02:32:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241111-statmount-v4-0-2eaf35d07a80@kernel.org>
In-Reply-To: <20241111-statmount-v4-0-2eaf35d07a80@kernel.org>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 12 Nov 2024 11:32:42 +0100
Message-ID: <CAJfpegtPY+g5nApZ47AGbexncJrvUJ7iCotYpgApCHzGDONGqg@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] fs: allow statmount to fetch the fs_subtype and sb_source
To: Jeff Layton <jlayton@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Ian Kent <raven@themaw.net>, Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 11 Nov 2024 at 16:10, Jeff Layton <jlayton@kernel.org> wrote:
>
> Meta has some internal logging that scrapes /proc/self/mountinfo today.
> I'd like to convert it to use listmount()/statmount(), so we can do a
> better job of monitoring with containers. We're missing some fields
> though. This patchset adds them.
>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

When thinking of the naming for the unescaped options, I realized that
maybe "source" is better than "sb_soure" which just adds redundant
info.   Just a thought, don't bother if you don't agree.

Acked-by: Miklos Szeredi <mszeredi@redhat.com>

Thanks,
Miklos

