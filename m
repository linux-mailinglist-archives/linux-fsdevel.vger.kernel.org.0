Return-Path: <linux-fsdevel+bounces-47450-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A151A9DC58
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Apr 2025 18:57:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 174745A1FDB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Apr 2025 16:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6B3825D8E6;
	Sat, 26 Apr 2025 16:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Bo5B4yek"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A298E6FC5
	for <linux-fsdevel@vger.kernel.org>; Sat, 26 Apr 2025 16:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745686615; cv=none; b=dGECpu5RwwGItA1Q4A2tEqEK4A87ghjdUYojcBFMteeWXy4dZ7hwXDayrpnH/NJzpxiARJL8fTwNqP5evX9CGJrNIlgZpVdbgAFO+Cng07SR0z/bG7cOYgQkEQwNPglp5HfCvw/ACjYhBZkBucazrXI0O4FllEZiqNxMRqvV90Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745686615; c=relaxed/simple;
	bh=hVc53GkaWp8guAZtyjJGkUTbCiqvI//qAfPqEmrP2x4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YyIK+D3ejIsRYRFYN3BFll+Q1Pb1iMj4gSrp+YZNDEXMXMN0om3NCMd19xPUDeKJhQUysdNVdYPlPQVKcCxVyFCKyDEEWPvxL7FE6jHkHXMScRe3h3UE/XZnpGWrjCyCXUdM+KX4zPuZPceox+2iEAUcANmjhhbm3UOSF7Wj4Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Bo5B4yek; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e5372a2fbddso2870482276.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 26 Apr 2025 09:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1745686612; x=1746291412; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Qvcm4ZlifMLzpCFaQIQMUnlx9IKvnlCR33o+043/5o=;
        b=Bo5B4yekCk2tcK4dOxf/+wg4A4VOd4gaCE6gzZg6xNL6XwJrKJAUe7In9CT3jd/ByK
         3mFiuKQ/kBqhhfXMD4x1XS89NAVFslk3eiJjrNO5SNQGPOmhi7stVQ+2jKWMWr8Tpb0N
         D8AVkZNls/GntEL9tX3TvVRNRu4i/zKQnIHOOvkP2ytxZvRHb4oFNuOgrowplqyyXhYh
         0E+RjuYs5HoEZkajw0Mnwq2Be1g5Iz7q/CpydrErAQM4PmWkd0a1wnbgsiqhmbj568qN
         TgXEbSeF9r6buPQkCIGL0TSuHfNOlH4yG1PYfAFPoqs/JD3l2rSjulgY2+k1of0+xAPo
         hWNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745686612; x=1746291412;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Qvcm4ZlifMLzpCFaQIQMUnlx9IKvnlCR33o+043/5o=;
        b=EoRVbtItB0X4SNBAm43Zr2PdwTyMvACVLrSDWU58dz7RhjJNs57bYRumrb3et73x6k
         8Cr3/iuPPK26MbH6v18U1FmWtg/SQa4SbLzCvyWPbDLgTs1Dz6zyZS46ocQtPBcwWLNY
         3jc3u7JgPQEOu1gOtVMli9jOslaLii3GDjqwOu5rnJgb8cORibgmxQ6kryTr4xua1CsW
         N6HKCwIh6iKPXpUSl6s7q4UKjgQT7JYHE/oSMR+6kAmf5kJHHhSALpKWEfMQBWBp8Zdx
         4bVzRX8FO91Dr+Vloy8vxSXbjTqel7Wffn8N2CD4ZMkMvGOix38tlt+2elg4UNMuARGj
         B5yw==
X-Forwarded-Encrypted: i=1; AJvYcCWk8n7UJ5Uzg0q6f+PcWdjQj/V39Tp+zJ1eM5h+Bca5mgQo809fu834RGsqz2u/k+dE+CGizVl8FBXV6zPV@vger.kernel.org
X-Gm-Message-State: AOJu0YwDwaFujnoAULiomQJaASsPNd+ZURhy4d8DAORh+DIgDdigSfkO
	boIoifo5vTlJJeub3KAK0VfVVG+MKjIh74SznMC73SjS3B3ZzP4jEUY3hoXPkeQlvvyWw9GxuRS
	xHJfyrFfU5OmOEBUHF7DP954BMYIS9I5ZKCD3
X-Gm-Gg: ASbGncvvg1xf62e2ZDNUcsFhwGk4G20P0JW/fJk/E8Xm5yDI3uuS2PT5qKgpzlqEqmf
	QnmRqXkTiwjGYx/n0poQeHX+R/sPQwxEa7d2gewO7uJrkj5o/wuGyhEZgWFwnp+nYpRskcbWwTb
	xr3y9XIzuXpl2W/uRv+sJBqA==
X-Google-Smtp-Source: AGHT+IE+1k4f+bo/fo02wyG4A49rhL7JuhfWYS6qNllUowtLP4beqhuLJsS4Vr/rE1m1d3RlfWQDKcP50bIe7h2CUvI=
X-Received: by 2002:a05:6902:158c:b0:e63:efca:6692 with SMTP id
 3f1490d57ef6-e732334565bmr4790627276.6.1745686612561; Sat, 26 Apr 2025
 09:56:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250424152822.2719-1-stephen.smalley.work@gmail.com>
 <20250425-einspannen-wertarbeit-3f0c939525dc@brauner> <CAEjxPJ4vntQ5cCo_=KN0d+5FDPRwStjXUimE4iHXJkz9oeuVCw@mail.gmail.com>
In-Reply-To: <CAEjxPJ4vntQ5cCo_=KN0d+5FDPRwStjXUimE4iHXJkz9oeuVCw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Sat, 26 Apr 2025 12:56:41 -0400
X-Gm-Features: ATxdqUEbSGq7jI0-7V0Nbdw0096xjbVILUivTxTYtxScdYz_SrmH_Xrk5Jt5Gbk
Message-ID: <CAHC9VhSOqvKm5wNPp_7O+cayMf3gopeLu=uDoP5kmfvqtp40WQ@mail.gmail.com>
Subject: Re: [PATCH] fs/xattr.c: fix simple_xattr_list to always include
 security.* xattrs
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, omosnace@redhat.com, selinux@vger.kernel.org, 
	linux-security-module@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 25, 2025 at 11:14=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Fri, Apr 25, 2025 at 5:20=E2=80=AFAM Christian Brauner <brauner@kernel=
.org> wrote:
> > On Thu, Apr 24, 2025 at 11:28:20AM -0400, Stephen Smalley wrote:

...

> > > +     if (err < 0)
> > > +             return err;
> > > +
> > > +     if (buffer) {
> > > +             if (remaining_size < err)
> > > +                     return -ERANGE;
> > > +             buffer +=3D err;
> > > +     }
> > > +     remaining_size -=3D err;
> >
> > Really unpleasant code duplication in here. We have xattr_list_one() fo=
r
> > that. security_inode_listxattr() should probably receive a pointer to
> > &remaining_size?
>
> Not sure how to avoid the duplication, but willing to take it inside
> of security_inode_listsecurity() and change its hook interface if
> desired.

We talked about moving to xattr_list_one() in the other RFC thread
earlier this week and as previously mentioned I think it's the right
thing to do.  However, considering the issue with the new coreutils
release, I think it's best to keep this patch limited to the fixes
necessary to restore the desired behavior with the recent coreutils;
this should make life easier for distro and stable backports.  We can
address the LSM hook cleanup/rework in a second patch{set} afterwards.

--
paul-moore.com

