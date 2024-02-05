Return-Path: <linux-fsdevel+bounces-10322-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3698B849C3A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 14:52:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6BB2284D49
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 13:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 552D521379;
	Mon,  5 Feb 2024 13:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="NcuWp1nl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2EE210F0
	for <linux-fsdevel@vger.kernel.org>; Mon,  5 Feb 2024 13:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707141129; cv=none; b=OwJSGtx5/GEkHkK5A15xQsqfQx6hemVFvmekj1NvoH0jF+va+oVfg4RkuM3vH/N8FMfACE0lPFjBkC9XBgr1Eo/WRMioulX3C2if8/hCYUQTY+uDSC8cTqS7eEajMLru09per6BEGIp8txwr/I0RHoDyg7fWZP+3FV3MKSq8qWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707141129; c=relaxed/simple;
	bh=2Xv/TMPnZ6ACI/uw5nCEWZWMTiYPSRlxi3KzNmIW+M8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mXqnADBOZUmH5ZmcTy3ZXiizoK+poimBz9Yv0lld9RSuxI89dVkPpaAONiqyK+K6yhpz7yzmMYFVoO59bIHZkWKu1o8HcXVPFdUkWW2baPPib3jfovfQVkvwNgOn881Vir9su+xFezqm09e0L8kdYUm0rrr8ViDPL0XaCSkb8aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=NcuWp1nl; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-51117bfd452so7434920e87.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 05 Feb 2024 05:52:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1707141125; x=1707745925; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2Xv/TMPnZ6ACI/uw5nCEWZWMTiYPSRlxi3KzNmIW+M8=;
        b=NcuWp1nlWvOmKDC+Us3xfB23YsW8RgUJlLlIRMYExr0fBNaaUQJBoDuLQn6Hzgd7ux
         5mS8g5eqer8E27aG2gtEBQlGEYw6eCfqtfGJ/JcpLxVKxlgtFL5dNs41yfVDg7eHBsN6
         ziM2eIdru4OyBQneL4aO4SU8i+lLz0z5AlCvU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707141125; x=1707745925;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2Xv/TMPnZ6ACI/uw5nCEWZWMTiYPSRlxi3KzNmIW+M8=;
        b=BQas5DQujKIq20l6lkme7wVdit4GxgvVv6UHk4D3kwIt7BZinuJHUnxNG8ZVXz3wSM
         1XtUz9XIIkq7+h0PmcqMUtaB+neS3+tx103kcdmUle2aEXAtQ17oL5Strj4r0Pggjm0C
         Nwhyh9L2iEufHNN1Iip/CQly+g6icb6k/j0HOUSMlzy1JQKN5egny38cRyYI4/VMFidG
         RA2XHrg7Acrgj6wRrdsHhe7zQU2ybT3zu1kaJXLfDdmPkp9gd15dPnfHphv2Cre5cl0T
         7T9NvyomHSBGfcIFz4Uv1w4zdvAmaPbQw65knqricv0YBNIGyDPIJuf1IuECtCxiMvi6
         kvpA==
X-Gm-Message-State: AOJu0YzQ3x7fdij7Jd9NpBIUDqrpqwKA1NewCofeiGegimHmwZb1LRqP
	DOvsBYKSg/7UDOmaTFC1+3qwjhmxPfB9lEH0zfBGmijp5X9vnAca3Hsz/00frhpR2TfCGBweRQO
	OqeesxJfd7yrlcWnkPJaUS5196N4jpS4rkGTkyA==
X-Google-Smtp-Source: AGHT+IGCaEVVe6GrK1mvmKbk8cfbvkS3XUvRFFWxmUF4PfOm8rDUxdDRR8CpRP+LOC3U4ed7OovlnHoRwjwU+gtFl6o=
X-Received: by 2002:a05:6512:3b8b:b0:511:3e58:3cff with SMTP id
 g11-20020a0565123b8b00b005113e583cffmr6188837lfv.16.1707141125271; Mon, 05
 Feb 2024 05:52:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240204021436.GH2087318@ZenIV> <20240204021739.1157830-1-viro@zeniv.linux.org.uk>
 <20240204021739.1157830-11-viro@zeniv.linux.org.uk> <20240205-gesponnen-mahnmal-ad1aef11676a@brauner>
In-Reply-To: <20240205-gesponnen-mahnmal-ad1aef11676a@brauner>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 5 Feb 2024 14:51:53 +0100
Message-ID: <CAJfpegtJtrCTeRCT3w3qCLWsoDopePwUXmL5O9JtJfSJg17LNg@mail.gmail.com>
Subject: Re: [PATCH 11/13] fuse: fix UAF in rcu pathwalks
To: Christian Brauner <brauner@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, linux-ext4@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 5 Feb 2024 at 13:31, Christian Brauner <brauner@kernel.org> wrote:
>
> On Sun, Feb 04, 2024 at 02:17:37AM +0000, Al Viro wrote:
> > ->permission(), ->get_link() and ->inode_get_acl() might dereference
> > ->s_fs_info (and, in case of ->permission(), ->s_fs_info->fc->user_ns
> > as well) when called from rcu pathwalk.
> >
> > Freeing ->s_fs_info->fc is rcu-delayed; we need to make freeing ->s_fs_info
> > and dropping ->user_ns rcu-delayed too.
> >
> > Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> > ---
>
> Reviewed-by: Christian Brauner <brauner@kernel.org>

Acked-by: Miklos Szeredi <mszeredi@redhat.com>

