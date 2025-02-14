Return-Path: <linux-fsdevel+bounces-41711-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B144FA35AC9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2025 10:49:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D87207A49D5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2025 09:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21CE625A64D;
	Fri, 14 Feb 2025 09:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="QYT4nrEd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0325625A2AD
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Feb 2025 09:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739526521; cv=none; b=XkNec723ijr34ewAV3bx194JwdHyHUqYkCTBYPnx0KMEfH1eQhYE6iNQ5SDbWwOsslq45hoRSvypHO2pAJwR0o007gkD/b6yqJKfl8NNP4O4OdGTnZGsTFeVuUIB1hT5PP1AUQJEBeqnGgJsxoJ+FINJVhp+Rm18/EiUOmK+onQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739526521; c=relaxed/simple;
	bh=KE/1PS8bSk4dH0R2K60/pmTjlC5i51phdJ5NWCLMzN0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L+n9FeYcFwmKl2YapCNCW4w2Fxc4HgPUW5N+yFQGfiKkf9fk+x1RX747tCbHwaybLrW/QHHEutH00vxQ98/fGBobl267i8zRuQzia6dHlg7qUpoq1TEi/uHdCk/yGuVXVUQny8emXLw4Xw0rJpRgdPTX+mOFLFb3LMg2+Vv5fac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=QYT4nrEd; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-471d1af90a0so2876921cf.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Feb 2025 01:48:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1739526518; x=1740131318; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MDr4jsMykS2/ggucs0AcLI/tKQzpn55xwyUNyvWALTY=;
        b=QYT4nrEdOPWxvCEE7dk0xSkC0VkmKFlVurzHzDGB8XaeZCciACCLQdg+xtXbPgj/My
         199RhFB16sD1A6q+SPkQ7t2UEnlf+qjxeiHQvi6qleDy7ptoPsMDPisxS/m0euzAh0qN
         UJ6WKSa0xmSunLQWF/EJjHMFQUJLnAIfw7rY4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739526518; x=1740131318;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MDr4jsMykS2/ggucs0AcLI/tKQzpn55xwyUNyvWALTY=;
        b=mprLjyQ08eCUP7VgxffoqzZnBnbhWbEHu5Ew0jZuZG7kb+AK/IiFsD1pPeRUbLKwfS
         FW93QL3gaTN3p5+/6sDwVsgvHvDB0pB7pyVRkGZkns/lLCmextPST5PORfxNX25lXUr+
         1juMHZkx40Ebjb5HnN0BQa4WAdEDm0t5EDT7gajERgJ74jgkg9Mc/Ah+Wv2pxuj5vCgg
         nsUNOgFlYW+ZPWEsR7PwobJ1+wxkrI6xxucicG6/T1vSXhpLt4X/hIQ45MBD1UlYGRkW
         +uDxqnM+wiAJbEPqPNfT5AFS+ZGlL4piyxCbhT5d21iAfELt9MyibxdXi/VkbAP6ygoo
         XDgw==
X-Forwarded-Encrypted: i=1; AJvYcCVTBndYvaOXBNSU2GCEeBXCimFd80i1+iIiMNsXrCktjpWm95Z2d80UgDG+RE/vNlbx8c1NxjbrvLgbDuD8@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo2fhL1OBB1WHSRAHR+OtWxUL+Pxs40LOQtlcK+EgLUgh/pnFl
	7gOX/CTM5zKnwkby6WsvcBVlDIvLiNj8/8mi+ft3sItjOKLK2SY1NLkvgeAKyWr6tSVkiryuL7c
	Gyng+UVr/dracH3NuUyOXGlcU2gk+bXuCiC9sbA==
X-Gm-Gg: ASbGncu3vH8MbN7Il9zhVgrUkpR89UdJhZhzuvgVvF+lFn+coytari/lyXaENNcmM6C
	y340MklqtItOGr471ABunuKgsYd+keM/zELtZB+jraT6Z33PBXH/BzYwZY0/7GWLZ212Glew=
X-Google-Smtp-Source: AGHT+IGuB62P59Ol+6vxloURqcamERa0qYdF0pLayov3aelu2QkTJBkViDqxaan7Awl6SY9eZnVYSryW0tCpG8J74gQ=
X-Received: by 2002:a05:622a:593:b0:461:22f0:4f83 with SMTP id
 d75a77b69052e-471afef5585mr160384561cf.43.1739526517753; Fri, 14 Feb 2025
 01:48:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250207133502.24209-1-luis@igalia.com>
In-Reply-To: <20250207133502.24209-1-luis@igalia.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 14 Feb 2025 10:48:27 +0100
X-Gm-Features: AWEUYZnbRxMitMiVBkeyxPOZvfKFE0ntNolS4pNWHZK8u6Gg05D8SwmA8SFkAbc
Message-ID: <CAJfpegsymDHQj800wtD6Tq9fSOHjJ+UJ7dhvPf9Ut0LT71us4g@mail.gmail.com>
Subject: Re: [PATCH] fuse: removed unused function fuse_uring_create() from header
To: Luis Henriques <luis@igalia.com>
Cc: Bernd Schubert <bschubert@ddn.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 7 Feb 2025 at 14:35, Luis Henriques <luis@igalia.com> wrote:
>
> Function fuse_uring_create() is used only from dev_uring.c and does not
> need to be exposed in the header file.  Furthermore, it has the wrong
> signature.
>
> While there, also remove the 'struct fuse_ring' forward declaration.

Applied, thanks.

Miklos

