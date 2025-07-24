Return-Path: <linux-fsdevel+bounces-55971-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E639AB111EC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jul 2025 21:56:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E70661CE623B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jul 2025 19:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D71CF211A11;
	Thu, 24 Jul 2025 19:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZLbTHi/m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32CE2E370F
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Jul 2025 19:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753386992; cv=none; b=uTsG7xPw91DN/afXLGj1ER3cjDVfZcsnz7WsoYVTGHu1dQ2qE4JvuQcQRB0lL72pfflNKQvN1KjHgbsacvNUQLLp0VdIvV5sepg7miPQiD6XFFxCP9SPwspNIzWaB23e6RXrImeZZUijKBf6mqDBS6SuMcpXRU/jx9TvEMWaczc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753386992; c=relaxed/simple;
	bh=VnbyZ9xXHh2Ns0vbe4JgsPCroB1YcgjBVnn/7n4zEKU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lmtM2MtvtX8Y9EbunAuFl/j9dlXk/kycyNIwfSsVe1EcbdK9s9BI/l/PLyZ7Aofh+FV/Tmvg+0FGTNHtPqcA2xXFpQjsk92ZuaLgfIvqgG+YBqnsvyYjB27f7oa7fXE3ImKx966q6f0iW8bClwf3/ybYgMr+g1O3c00AZtQVLSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZLbTHi/m; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ae6fa02d8feso208381366b.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Jul 2025 12:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753386989; x=1753991789; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tnxLi/A4WGhLJ8nJsa11ry05ir4Bo+rIsRkvpigVtBY=;
        b=ZLbTHi/mqvROTSN/bil5R28LDP/lloYIZUJn+qxiXcfMEixbch6/3V75Udvmo6b3xh
         2HYaZdWu6WUH8rGUjl9N1V0mweJi9SPnnIvOdg2fxz9IukRGweWoju7pin7W6yrjcx6a
         UFauJUDINVb9AJegD9fcu/8uJ/bqnLqANMMQyyHxfDx5bNQYUUy6jo8nSPtk4c+RvB4p
         rZ9COad7ELY8NleNzSesccg9fZgfrq1FU5W9WFnLGM/sbcc1rseFREo9I4s5pQWenHv+
         doIxAacYeTZCzDIQWka67A+zVwX8ux6CjH9x3Jl9RCdOF3+4A9IIrJzqnv2/9Mo+BcWq
         TQgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753386989; x=1753991789;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tnxLi/A4WGhLJ8nJsa11ry05ir4Bo+rIsRkvpigVtBY=;
        b=lgUQa8b/tmEj1hXVfW78XmPqir1ggK7xNeoyOTOMhirTLzNz6tltaRP3UPYyMyZEZ+
         AChUjGTZ2C+eLylI5yilRo6XWdb3ZFLb3KkX545GEtZE1u+JDpqkHv12TydfiwbAovR1
         0JEXVPZZohxyOluCduiWeOFF5lmCwN2O5nBlRdU8kOZaf/omDqxpx1cJvlf/C0l2CbVj
         bnlV/wXQzm666eDVPMqCYXjS52qUne0AxLEirrHFyaDENpq4TcuxQQNCHuXYSdjuZ2O4
         wmzaLnxWbwQviQMmF8kEhMmPji4VatnTqJkMM4YR8fh76BKht42FXVoYTd15I+xVolzI
         GhgA==
X-Forwarded-Encrypted: i=1; AJvYcCW8+JGxE0O5OJmxdrBrgoj1ecifD3bj2pLeQNPAEWzaAHzpCYucZ73NXeBvOrV72n1+LOIlciJkQ2DdMbkE@vger.kernel.org
X-Gm-Message-State: AOJu0YySYs1wFfEe9bo+yTZWL4bqS+QuzwLg98zfn2gffLvDhq+lxG7i
	pEfKhj8iv/AjGKv6MSCrNW3SQvzl0Ij6db9RyB3qGKlIdJcaoZq+BUJLduuRltpsRL835j4kHIe
	heUGN4bjHcpdEEaRrH/XY8jIbtJolCto=
X-Gm-Gg: ASbGnctTx9vQAIuNt6zF0t/lCPbEj18CCGqCkk4omh2D4oNn6gSh/ewsRkhc7uDl8V0
	79EuIIZ3p6S5p40PkRwrqRwmkDMpE1uUXDWFyNCilxbqf5+TGgBLSqn5atxMP0S2aJyc7uo2tv5
	oRdyRzQZahnd76BZdyJiGM/u3uhvFKsxUAgjx3uVy3KnUrlApSQGge+g4CVc9+tWFFsFCQOGDYM
	cu6U1A=
X-Google-Smtp-Source: AGHT+IGngRsdsV64vfAh+LUJKPA17hKG+2SEHSdjbbdMhZr6qi5a/a7r1x5EQFaScT3P4dORCPOMF0m9ImomgNdNQIc=
X-Received: by 2002:a17:907:da0:b0:af2:b9b5:1c06 with SMTP id
 a640c23a62f3a-af2f6c09406mr873988366b.14.1753386988663; Thu, 24 Jul 2025
 12:56:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <175279459673.714161.10658209239262310420.stgit@frogsfrogsfrogs>
 <175279459875.714161.9108157061004962886.stgit@frogsfrogsfrogs>
 <CAOQ4uxjRjssQr4M0JQShQHkDh_kh7Risj4BhkfTdfQuBVKY8LQ@mail.gmail.com>
 <20250718155514.GS2672029@frogsfrogsfrogs> <fa6b51a1-f2d9-4bf6-b20e-6ab4fd4fb3f0@ddn.com>
 <20250723175031.GJ2672029@frogsfrogsfrogs>
In-Reply-To: <20250723175031.GJ2672029@frogsfrogsfrogs>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 24 Jul 2025 21:56:16 +0200
X-Gm-Features: Ac12FXyv5OMzD0z7gTfbSsrBYgDOUzyRfGU38Vdgbbd1IBr3CMbPEqn95DGu_U4
Message-ID: <CAOQ4uxi8hTbhAB4a1z-Wsnp0px3HG4rM0j-Q7LTt_-zd1UsqeQ@mail.gmail.com>
Subject: Re: [PATCH 08/14] libfuse: connect high level fuse library to fuse_reply_attr_iflags
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Bernd Schubert <bschubert@ddn.com>, "John@groves.net" <John@groves.net>, 
	"joannelkoong@gmail.com" <joannelkoong@gmail.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "bernd@bsbernd.com" <bernd@bsbernd.com>, 
	"neal@gompa.dev" <neal@gompa.dev>, "miklos@szeredi.hu" <miklos@szeredi.hu>
Content-Type: text/plain; charset="UTF-8"

> > Also a bit surprising to see all your lowlevel work and then fuse high
> > level coming ;)
>
> Right now fuse2fs is a high level fuse server, so I hacked whatever I
> needed into fuse.c to make it sort of work, awkwardly.  That stuff
> doesn't need to live forever.
>
> In the long run, the lowlevel server will probably have better
> performance because fuse2fs++ can pass ext2 inode numbers to the kernel
> as the nodeids, and libext2fs can look up inodes via nodeid.  No more
> path construction overhead!
>

I was wondering how well an LLM would be in the mechanical task of
converting fuse2fs to a low level fuse fs, so I was tempted to try.

Feel free to use it or lose it or use as a reference, because at least
for basic testing it seems to works:
https://github.com/amir73il/e2fsprogs/commits/fuse4fs/

Thanks,
Amir.

