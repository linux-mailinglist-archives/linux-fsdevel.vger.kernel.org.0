Return-Path: <linux-fsdevel+bounces-60254-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 15714B43617
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 10:41:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BD4164E5588
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 08:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B1E92C327C;
	Thu,  4 Sep 2025 08:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="AgZNxVTe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566B62C17A3
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Sep 2025 08:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756975254; cv=none; b=QLgqqLcfHYVKZwrUilvSxX+X3oPbWKKTpWOFwkrWwP5LxKk9UdIgWErJPvoQdATcms99gziYfNYFboDLhvRRMyzRXtCP9DjpIYFTDuRs9tIOVV0u7ksvBXNqNLwbJcFAVwoVShFSFthRB41PpvbsB3cLJ3OtAM36HfkmTpP2nY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756975254; c=relaxed/simple;
	bh=3fB9b5I3Kn6WS0pnGa/2P2nNzuXa+Y8Q7kd4ZY9H7p4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gmusc3SR/RXWiEG0zDiDcZ+HsihA/32ONGxwcW2a0oPGBnckTwlVk3ibIihvAqL4PTPRmV428HADMoPmZyvQMy+Mv1pub/pTUzPeqCdH6a7cEEN+DlsPg/r9pNkOe4KoSCp8lbj58MFK+qqzTknwQeUtE8mu9O/D5rY/CgtlYTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=AgZNxVTe; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4b33945989bso14771651cf.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 Sep 2025 01:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1756975251; x=1757580051; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=95wfGGVFVGnvDRkOAo08Sli4i7CgJ0TfhXshmox6PTs=;
        b=AgZNxVTe6ehBECZPK2kuQZ56J474nBkZL//6h82AAhujskSvqN2BWFIkSf2wzyC+GP
         yxK5A5YW24A+ugBljsSGBSOywzUfnpymswHzbLGrEG8OlLbT256x3ATx6TqT1zjSzVnZ
         4C+DjYFqbDMIIFO+atkIsj4/oc5d1+RrndF20=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756975251; x=1757580051;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=95wfGGVFVGnvDRkOAo08Sli4i7CgJ0TfhXshmox6PTs=;
        b=HfWdlk/vow3GIYRHYybUCL7hEJ7bEYFCi6jwNpya18U8O5gzx5mXcUvUtNtMq/GF4E
         s6GEW9Nn+Dp/JsoanHA/vmFzloBjvYm5Zxd89PT9L8bIdTGQPf/wLG75wPXFUcMFTyIt
         CMOptD4S3BAuJbM3yPowvw+lp8Yx2Bn8RbW9yKqK+0Z5axaVop/JthUAIoql31+zS+6B
         tSVPWOShwo7bzpk5mGS5ypcru8QospvbnPrKTrdTXYYw9fT/kp9aprni3wpqG55wE3Q1
         2MXn1lxrI2ERQ/sxuu2dJFASntFTzyTgXRL252yvX8bYn6TqBIOKZmsYEcg6+FJSuZ+x
         MDQg==
X-Forwarded-Encrypted: i=1; AJvYcCWtkgyNdBptBAwa98Y1zZ3JE9Nix+q7Onqlw7uhQte/Aw0ncze1SbUUdGmsMcpwNUoQyGp6WJ6S4c+pU2dW@vger.kernel.org
X-Gm-Message-State: AOJu0YwRlX9dWXMchmjKNiSzygRyDP34rMbADykNa/X7exKeRcf8xNQG
	UjmnEqn069nS3Z6aiaVFMvzyPot5a0/efhnFZRkiYljDjgMu1mrLV+ouj/bFWCCyVOyT4PRoZXI
	bbOStcL3TLmeD3cK4Azc/wZb4neBRtSwRdGxf8VOBDw==
X-Gm-Gg: ASbGncsjo8WrcMwixFP9I79F7pDBpAd43LIOAEePsOWxiY5kN5S3gQh/Rkhkb9JgKzE
	m2h+KZiA7NWXu9EE1Blbd6ynUuzJYKWzJMy+B5eZ5V82SrOM6yGirQ4FwyeygzM4IrPLZEckOzJ
	oz9uPhUQYOW+h6RagvzmqsilhdZA/cmnXxWuoH+WqBVFgUp8WlNoaag4XH2e2nJDvxxIilrikJh
	sWFlcbYlA==
X-Google-Smtp-Source: AGHT+IHC7FslwL92EMoWkWJFtaYJAHdu7nFeoKnQmVrR5RuWkUsBsDaqbOthWlmGQ8AhNWljwDOe66mKF+bZCw1p1eM=
X-Received: by 2002:a05:622a:1441:b0:4b2:eef0:74a3 with SMTP id
 d75a77b69052e-4b31da1d388mr239759031cf.52.1756975250946; Thu, 04 Sep 2025
 01:40:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250903083453.26618-1-luis@igalia.com> <CAJnrk1aWaZLcZkQ_OZhQd8ZfHC=ix6_TZ8ZW270PWu0418gOmA@mail.gmail.com>
 <87ikhze1ub.fsf@wotan.olymp> <20250903204847.GQ1587915@frogsfrogsfrogs>
 <CAJnrk1aa97AwixCq9+eGQT52LAfqL-S1Ci5fSUygfFOo-6kMHA@mail.gmail.com> <878qiumxqx.fsf@wotan.olymp>
In-Reply-To: <878qiumxqx.fsf@wotan.olymp>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 4 Sep 2025 10:40:39 +0200
X-Gm-Features: Ac12FXzUpDt_2mK7Xpn2XvEqTpsMqt9U7uWkfOumky57k0KQPFZSynmixWe2nUk
Message-ID: <CAJfpegsJigpXwhc35KZH4LOihjinz7e0OCBPT5fLHkio1GGkfw@mail.gmail.com>
Subject: Re: [PATCH v2] fuse: prevent possible NULL pointer dereference in fuse_iomap_writeback_{range,submit}()
To: Luis Henriques <luis@igalia.com>
Cc: Joanne Koong <joannelkoong@gmail.com>, "Darrick J. Wong" <djwong@kernel.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-dev@igalia.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 4 Sept 2025 at 10:24, Luis Henriques <luis@igalia.com> wrote:

> I don't have a preference between v1 and v2 of this patch.  v1 removed the
> WARNs because I don't think they are useful:
>
> 1. the assertions are never true, but
> 2. if they are, they are useless because we'll hit a NULL pointer
>    dereference anyway.
>
> v2 tries to fix the code assuming the assertions can be triggered.
>
> So, yeah I'll just leave the 3 options (v1, v2, or do nothing) on the
> table :-)

WARN_ON is a useful tool to document interface constrains.  But so is
dereferencing of a pointer.

V2 style WARN_ON should only be used if it's difficult to prove that
the condition will evaluate to false and we don't want the kernel to
crash in some unknown corner case.  AFAICS it is not the case here, so
I'd opt for v1.

Thanks,
Miklos

