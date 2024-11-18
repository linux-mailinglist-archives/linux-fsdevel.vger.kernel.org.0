Return-Path: <linux-fsdevel+bounces-35082-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 283ED9D0FAA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 12:28:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97687B27212
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 11:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46DE0198E8C;
	Mon, 18 Nov 2024 11:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="k4Bo7c+O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ADD5194151
	for <linux-fsdevel@vger.kernel.org>; Mon, 18 Nov 2024 11:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731929247; cv=none; b=Drj94d7Own0J1v2XxfO2xOuqX9/pETISNRORkz9kiESC94+HpflGALLMnQGXNzdnxBTqWMfFOxYSABI4yoSnOWqyIs8W6PcQ5VExH1FvYnvGNrItpk6Tww4FecdhbG7wVSNQetuoBQykrTaRHi/2uddT80UmN0j36at+J8UBYRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731929247; c=relaxed/simple;
	bh=K0mtCJd8nONGgt6SOnX6Hj0t2xm3Jj+RLlpEvfpZcnA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IwHzpJOgteqFFl2s4j8PYTyA3NWCmA4VdG9W9VSUmVeGnkT6QF8t/y9vAermRZKw8FvrV6uuJO0x7S39Xzyfx4bMXXvQxxxyw9jycIfplTagEO9N2wwVUuu2QSCPnSnpWmmMZkPHVEQyORzFxBGRB0g0Uu8RtDgSxrarvsGG2k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=k4Bo7c+O; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-460c316fc37so27969391cf.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Nov 2024 03:27:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1731929244; x=1732534044; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=J8PDxhzJH8B4AHfrqhqpoMvxGYTYu5oYrGO/Y3zylAg=;
        b=k4Bo7c+OP6Nj/f4WgD3U8MecnpoNUlBHxRdOZWo6uGI81SPL/oLUDBC1QJeq2INUNQ
         EsaIx8PtbjVY2MNRBmILjBfWvuxnn4JT8Xetc9kyD1Doh8m8+OZzpciqhCgJgMOEDE47
         RypSWu0KhdNhVPPZI7MZvN8FYUuBLNikzSJlE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731929244; x=1732534044;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J8PDxhzJH8B4AHfrqhqpoMvxGYTYu5oYrGO/Y3zylAg=;
        b=Isbl88P6UOwxPTThE04/Hz+NA4tV84QqNdWVVOna3bUGZHrtfpshRDIf8JPYCxE9ZK
         kX+ylQEdPjKWmi9OvpspHToNEdGQ0r+pTRfHYA+CR+H+y8IjvJRtEtebKDXfULXU5EoP
         uvW1nbddo1LX3QpdgECLfwIK6HKOXDuNr22XEl4bJezhJbPy8HasVAOwXni+r8GggcWe
         hFdeGBC0ZfDgS+3GgywiZ7AsLS3kUC6CTqIQnAvDHJ/ek54Dna3mHvJw5X7c8aXme9ei
         l0LinvVyM5MRxohDEviOwmWyujv7t3ttBabosCcKiTe+kFr5TQwrRgxsWFqsI0HV9Ckb
         rxGw==
X-Gm-Message-State: AOJu0YwEJjYMqomJENhHldpq7t5S/T0MOp5A+Y+RSv/jQtTqZRdzkdAF
	+xO8yF5Ox8lb7NvgduDo71eTfJzkaEYhcrzCCyIeJTmnwdDzE+C1r+IWwIuq8FR+5jhq6bTq/rD
	OXxseQS9PL8gj4uWqd/qIkuoNltGtHsQJEZiM9w==
X-Google-Smtp-Source: AGHT+IFWJDzka4etP4hQkOIhG/8fXDN0XadWOugrJhDu5wOtdftV/COxcRcK9v5OCrALx8GlCCgDNx7GbHQKZLToitE=
X-Received: by 2002:a05:622a:4b12:b0:461:1e88:595d with SMTP id
 d75a77b69052e-46363e11123mr147552981cf.21.1731929244054; Mon, 18 Nov 2024
 03:27:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241114070905.48901-1-zhangtianci.1997@bytedance.com>
 <CAJfpegsF9iYG04YkA0AOKvsrg0hua3JGw=Phq=qeOurgqk_OuA@mail.gmail.com> <CAP4dvseQoAohAZniZysw+gR=EGjMrKyyAOQ69-1FD7BOKS4VOQ@mail.gmail.com>
In-Reply-To: <CAP4dvseQoAohAZniZysw+gR=EGjMrKyyAOQ69-1FD7BOKS4VOQ@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 18 Nov 2024 12:27:13 +0100
Message-ID: <CAJfpegvxU2kd3Ux1PVei+PcRyy3Qum9MOrd_-pqbwL=aWD1e7w@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] fuse: check attributes staleness on fuse_iget()
To: Zhang Tianci <zhangtianci.1997@bytedance.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	xieyongji@bytedance.com, Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 18 Nov 2024 at 11:15, Zhang Tianci
<zhangtianci.1997@bytedance.com> wrote:

> > +       if (!evict_ctr || fi->attr_version || evict_ctr == fuse_get_evict_ctr(fc))
> > +               set_mask_bits(&fi->inval_mask, STATX_BASIC_STATS, 0);
>
> This check should be moved to before the initialization of fi->attr_version.

Well spotted.

> >         inode->i_ino     = fuse_squash_ino(attr->ino);
> >         inode->i_mode    = (inode->i_mode & S_IFMT) | (attr->mode & 07777);
>
> And I will send out the v2 patch later.

Thanks, applied and pushed.

Miklos

