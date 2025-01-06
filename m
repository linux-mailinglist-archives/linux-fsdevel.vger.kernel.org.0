Return-Path: <linux-fsdevel+bounces-38413-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9C60A021A1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2025 10:20:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A09B916394E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2025 09:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D9831D8A10;
	Mon,  6 Jan 2025 09:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="efCVxMqQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1811CEEB2
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Jan 2025 09:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736155226; cv=none; b=fJDlGFNkh8/4DZeuhD704e+fDUCgoF44nqZAImeNGLJ9SiqMfDz3xs+Hh675THwKu3Lulz6G9pVCgNHJjUOfHVsYNIgSbFD6S6lRf7mUJ3eWaSwhlpLHtMpdbYU1HVGFVmmpAcFGrl5KB2uELGhlWy/8oPzZQcNnm2kbpnGdDS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736155226; c=relaxed/simple;
	bh=o+kXTplRVUCUvhEajnIjUGWu05VGVRRba7eVIYEAOuk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SOMvsUHo484J0RQjX4BMqhVw5xUptwk+Bsb92/76p4bXorIvWMydWs064ijd9Q4adCYD1o4gwnIfn6GkbA0jGy/dXQTIr/TQD5+S2rAo0acoyVm1JqgXQwurn/Zft894dkAYCYF/xTsV4p4DKykUgRoWceAADbW1kS5gN62xbE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=efCVxMqQ; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-46901d01355so128418851cf.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Jan 2025 01:20:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1736155223; x=1736760023; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=o+kXTplRVUCUvhEajnIjUGWu05VGVRRba7eVIYEAOuk=;
        b=efCVxMqQ/oeJ7v8p0pXZNwnuoVCSBQbmjBOL8izKEBGzIqWV7hndEmXU4ltjQ1Baml
         YRuGc+pKDOwrsnU2KJw6cat86P8RV2+dREz+0Na5eFhWttWEnKFbTKzZpkQ4ZCzjhrMb
         pRLrv56rxGJleDaE9yiKU32kXT0TEu8TklQGc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736155223; x=1736760023;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o+kXTplRVUCUvhEajnIjUGWu05VGVRRba7eVIYEAOuk=;
        b=iuH1I4rQTAG1K5p3EwWYkLkGAPdlIIx9boKDMteWtuBI37vadbMXpKTEa+8lqhuGOP
         xxRNYr4Jsr78EWWXdrEjkLpOAbb+xRA1z/38MUFufJhZZmhAt0U8sNGWaSRNSJxZohSP
         5PMIi+pG2e5IgdGPNPFtiPMDc53kOkVDh1rP/S1PT7a0KzS+bEM7mimCzZzr4Z8m6Unj
         c0HKoMK79yTSw9AIpepe0NAYvMj0r7BoYd3J2oC3W7+FSELeC+phlqxJ4ipKI0BUIMyP
         SYMoeqzwlp9OOyu8ADDf8JVB5U6NotLCKxbeYm+pz3EZyhPGtS/3z2WoGQmUSPrmSVP5
         XP3g==
X-Gm-Message-State: AOJu0Yw4BLACiHYpNWbrHv6Sz1jICBQuHiGfUuKfuSX9cNvNPH96F1Py
	G2h97q6ng6m8yDkVyELfmbAkylWNBNtxu/9dG4+kIsEm3JvE0kuqdRd68w9nyE+DCZTp51+qcdk
	GY4KrgHZrB9tZg6tpQsEYsPxWZKtt2lG7LV17eQ==
X-Gm-Gg: ASbGncvb9ccEfbB4O+k+2VVKG4SwIT8aXOUDydG5huttEtk8oW0JkNxmHSm04OyolHi
	/f/HsnGn3eyk4dyKFxdqzsKY72YTqLs4jVtdg8Q==
X-Google-Smtp-Source: AGHT+IFMoiDx9tYsZvAzwsQLuFo4tZf8mbHYDSph+NnYvFFu93YOSthJQQMdpRALAqIfhDSA6L6b0ppDlndvJRfxFHw=
X-Received: by 2002:a05:622a:2d6:b0:467:8017:4e85 with SMTP id
 d75a77b69052e-46a4a8cc57bmr998458531cf.19.1736155223020; Mon, 06 Jan 2025
 01:20:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <674d07d6.050a0220.ad585.0040.GAE@google.com>
In-Reply-To: <674d07d6.050a0220.ad585.0040.GAE@google.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 6 Jan 2025 10:20:12 +0100
Message-ID: <CAJfpegv3f0+BcZjyKUxQpaohSofCjSzOqwuTn9+0xdHzGda4ig@mail.gmail.com>
Subject: Re: [syzbot] [fuse?] KASAN: null-ptr-deref Read in fuse_copy_args
To: syzbot <syzbot+63ba511937b4080e2ff3@syzkaller.appspotmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

#syz dup: kernel BUG in iov_iter_revert (2)

