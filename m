Return-Path: <linux-fsdevel+bounces-21168-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F8C38FFDB2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 09:58:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7E021C234C2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 07:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DADE015AD9A;
	Fri,  7 Jun 2024 07:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D9b5ZjdP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B2815AADA;
	Fri,  7 Jun 2024 07:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717747063; cv=none; b=TqCe/YNlqZJUkcfEM58a9sv4kWV8c9GaKPImDYIR9MB1buUl0q0gM40xwEZU6dXn/YYdK7NbsbbITaknqVP4OnLAku0kU/d0uGWrK5URRllZ0BjSt4DtVpCb65RZr6HqesgIQjfkATPLzAu+tR1x7QLkhK0EYRtqPzY50I5J4Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717747063; c=relaxed/simple;
	bh=lMwvpyqFlkoLQX4gxE2izK0+kVB0w79f1YUni+oRgLU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uT/9myxNht19Oq3z7B8yPCQvpXvBMQPMkOjCRU1ad7RYUDI6OwLKMVXlqeb+oYfsG5Wvwv9FFULpVOZWxEQtS+Twwr65vfXLRR4UAIruU8V4FlnLE9bV92lAdBKHQx6tlp6yzPoKbVz/C8nYo7Wg7K3JvCKC50/mwsWluy2Msc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D9b5ZjdP; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-57a1fe639a5so2154266a12.1;
        Fri, 07 Jun 2024 00:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717747060; x=1718351860; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kFCVGUTflwOAzaBXwrowU2+pcF/OdGGLfxKkRblAmHY=;
        b=D9b5ZjdPg8HXMU0zpiQDUKy4vYzT5fTkW86pM3GZKLA0pNap0wVKVz6ZPvg/GVgyvS
         nOOikBzFmFeyei7miwRYEGAQCOoi5JYDV3xncL9K2wBJ2pruqn2gHjzYkk/yrMaLhnAY
         FXtDGkF+0swgAEqJ3dFiN7xPmxdBLa/6A28asQ1uxzc202031/DRxNTOpKiIeqtDQQgT
         ZeKxNlx9lgsqWgqWtppUNCS3p3SgfFVjAMWUOhtUWFq7M4AIxBmecCoTREXja0gQjbF4
         ndbNsIJbaq4lbfz7i5YZu/h5Pae9Jr6bTU9aZ6eUiHyarsKIuqpg4Eo5PDrM0csNoEcQ
         G/lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717747060; x=1718351860;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kFCVGUTflwOAzaBXwrowU2+pcF/OdGGLfxKkRblAmHY=;
        b=uO7HQEFXR+u0mWQ0ckGtRlvw32M5eNcCtfTj4/A53DGVGZuwdHEJfWNYgnFcWYcFQU
         cErG74ydiWfCmyxISdNXiU87jmRf8gixD7CEic3k2Js395iP3H1clHDKEahDfogSaYEI
         1OxUuskey0fqIP73wlVabAOpzjAWWJRTWguRuG0+h1rNAlDvwKdjMpySYRqqSk0k/3t7
         oQMwO4ekDP+umhufFD1B70/iVYfinsSD/ubV0Jfa2xJiG3HRlapitVXI570xhI3EamqU
         DLiRGeobow4f4EMRJPUGHwJsxUzvtMJDDm1KiTgBakGkudvZq0U9v3MZdiFs6jNAJgAe
         4YNg==
X-Forwarded-Encrypted: i=1; AJvYcCWCVtTJGi9wXoliEWlVwhxgB9UjsqX9ICYXPrPxEeVNeRLJDabju8igBp7McjV27TiIodPMjLvkewyVkuzbme3iTiVZtsHynEY7bqj6UQBTA9AFCe0txkpWy0px4a1ALqZdzAwXNnslQA==
X-Gm-Message-State: AOJu0Yw8wCfSnjgF+lej8aBR4S+tBksoQNXyimxs8UEeM+D9a+sesoQN
	7VPAI85pAF4ZCQ+VbbeimTpUNwBhnV1MApIpWbNjOCcjeJeD5PctRdXAuwwAKxvgiT+XIcttoxm
	laSMh/X23LBcG9VszeCuVNEgQlCM=
X-Google-Smtp-Source: AGHT+IFDHEmWnLtr/aeRFD2dr9nKgNqZIOz/bnD2AxIQBjJ4pzmBLM+p5LLnmIzVLvo/ho5eoOzicReoyKiIsP+iNmQ=
X-Received: by 2002:a50:c04e:0:b0:578:5771:dc2c with SMTP id
 4fb4d7f45d1cf-57c50883d41mr1077288a12.3.1717747059906; Fri, 07 Jun 2024
 00:57:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240527163616.1135968-1-hch@lst.de> <777517bda109f0e4a37fdd8a2d4d03479dfbceaf.camel@hammerspace.com>
 <20240531061443.GA18075@lst.de> <20240607052927.GA3442@lst.de>
In-Reply-To: <20240607052927.GA3442@lst.de>
From: Cedric Blancher <cedric.blancher@gmail.com>
Date: Fri, 7 Jun 2024 09:57:03 +0200
Message-ID: <CALXu0UcOE6U6iW6fVZ35-Vjyf4rdkBxKmuH6RM+5C4tkp25iQg@mail.gmail.com>
Subject: Re: support large folios for NFS
To: "hch@lst.de" <hch@lst.de>
Cc: Trond Myklebust <trondmy@hammerspace.com>, "anna@kernel.org" <anna@kernel.org>, 
	"willy@infradead.org" <willy@infradead.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 7 Jun 2024 at 07:29, hch@lst.de <hch@lst.de> wrote:
>
> On Fri, May 31, 2024 at 08:14:43AM +0200, hch@lst.de wrote:
> > On Wed, May 29, 2024 at 09:59:44PM +0000, Trond Myklebust wrote:
> > > Which tree did you intend to merge this through? Willy's or Anna and
> > > mine? I'm OK either way. I just want to make sure we're on the same
> > > page.
> >
> > I'm perfectly fine either way too.  If willy wants to get any other
> > work for generic_perform_write in as per his RFC patches the pagecache
> > tree might be a better place, if not maybe the nfs tree.
>
> That maintainer celebrity death match was a bit boring :)  Any takers?
>

As much as we like to see blood, gore, WH4K chainsawswords, ripped off
brains and ethernet cables, it would be easier (and less expensive) to
just apply the patch :)

Ced
-- 
Cedric Blancher <cedric.blancher@gmail.com>
[https://plus.google.com/u/0/+CedricBlancher/]
Institute Pasteur

