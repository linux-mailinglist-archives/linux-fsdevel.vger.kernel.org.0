Return-Path: <linux-fsdevel+bounces-50773-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F183ACF636
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 20:09:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C0F7189D668
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 18:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 725BC27A123;
	Thu,  5 Jun 2025 18:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WtsPRP/G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6588B4400;
	Thu,  5 Jun 2025 18:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749146973; cv=none; b=EL07srfrUb3xpiTgRviwT1d66VoRauf3Thjwha0TqgOGwjcjrWoPeLzRbH9wFhSD+Ko46Hzz2ZmsMCjDWkL+Ms2iJHyPeHeV+f3piSl7XGzfuPBPJvfv7i4hsTGrKXsWPUt36kuohMsP4ehoeus4ryQS9uiM2pmSumNaUPg5q2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749146973; c=relaxed/simple;
	bh=hCpEyHqiBnpT85ZnAEXBHJnsThLhlMdygvzgkhGSFk8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aeMh+0gGSFUF/MbqyFxhA+zE4LY5yUhdVZG6NpW/vhHC34e0d4dfZb/bfP9ObavvPK4+FwI9jV3gKMHiNBpw2gIt0DCtIN65Mn/wkvEaEFt/wlK3aLQgOIGdbuSEkEHjapqG97NGWEccqF4/aB0iDq/N+eCj0xwML7yL9XJxTNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WtsPRP/G; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-311ef4fb43dso1105688a91.3;
        Thu, 05 Jun 2025 11:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749146969; x=1749751769; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8luWUuoNqYwTjrcszSVsilqxBIhH6lfcQzMovWFpql4=;
        b=WtsPRP/GRKTTOUzfitkWz4r/zGvTK5a7mR1rBQFamekzeErRYpJGWepLDCkm7SgKDl
         ETCS5EoSZkdvQYDzRhPexFEQn7KLNeMhV/gHCZPc5F7hUkM8kIS6JrBRppuFJUa8F7e7
         9cTkjrW1Vxpb0Bj2WnVhiw6xSDOIPlhvEyujDk1dlQvLF61hLGCWl0iHr74/xFVPS0iK
         ZKLv/n9O6X1kLNAR339eiicHq9qWvW+4sQck3qdGrrctIKqVi8GNxOlJOPcMz5GAYG19
         lHE0Yk61GtUU7S/IRlxYfWf92Tkl5AKNL0Lg41SraiL1FJt6t40sD8HaYbhIBMiLlFkz
         CB2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749146969; x=1749751769;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8luWUuoNqYwTjrcszSVsilqxBIhH6lfcQzMovWFpql4=;
        b=ULsrSkWWAHITxsj9GMbS6dZPvyegiKLcx9elOEvXWDYxr7FUP/9qYuZP8g/tKxUWhD
         8IMCOCFCnsiuU4jn2pPyZH04+dx7wGvyqKnB7mATfZJUl/iFlOq23v2Nl3HsP1JllPqQ
         VcumTM/klDXEI5PxrjsEA40a6Zk2hjkZZ6BkUykx0kExE6R+MCL8aifV7Q1lc8FXhuFU
         dr1hUZ7MWUtjeRgO95PoTxbMHsNVrDv3ixOxMd4YBGmz4VCzK8cYm7SwJnXTWhI/TOqA
         ZGh5JUVCpVTWOZaWif5oRa3NmhvmwnhwN202Y/Olzq250kL73P8ITxA9yL/SCTjJOdsd
         Yxrw==
X-Forwarded-Encrypted: i=1; AJvYcCUDBkUv90W1901JtUbbTam+IiAsfq2F+qJoFVRckGA/V9CW9+56BLondgx/V1E8RfeKrh70n+182YLZ744NqyjfbUgjJqRR@vger.kernel.org, AJvYcCUTidintgYT2RSZ9xfrjcfLWYP7/Zokl981bcZLI5RgiZNdprWbw7lZe7a1qpkaIgn4FXNyztzm@vger.kernel.org, AJvYcCVCUuXHIQDloGo9T8sYQdLvKcSoT2kjNpWpVMwfvpLguvtb4P4EPZ5kA5OX2FgKWom+k7n8VOhCOFYu@vger.kernel.org, AJvYcCWSlOtFXKmnhI3XN6AG+OkbK+MioG3OVOViTWdAQRA2KGXfVCnX9c20KKIhp8iwZsqOuUDXYNCUm19Qo1IQ@vger.kernel.org, AJvYcCWikBPWjVI4ySsDV+wqdW2petOYuF5fMocmGl54WcGWD0kulX0FPzVxXSTEDJgsaEZCzNUQQmg4p/OcVbo0@vger.kernel.org, AJvYcCX0wOQcC3rMLgMZL4Z0746woHJf930s6StAbOrYsO9ATi+eFM8zlbPf/zXoHXU/tJaxc6uZ+deuHA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzJhjyV52lblP9kpK9TrTQOvC8gnIqv4zIIn8XONDpC8vaoDB/H
	gWgn/wtQ5jeeSktcp01lQxKdDK7BxmjjRPFYnMwZltK8kYfIQWblXOVZO+/pz++WKDvBOMc3bTR
	r21l8uLpd3e2F24L73/Ex2HcRi2Ke5u4=
X-Gm-Gg: ASbGncuWBm/+335WMR9/vk8ke1FsjJNzza4uwfopS7+Wry7TT40+1MkImyQb2CXgkGo
	gYzT9EQmdssh6tXW8EMuVd+UheUnZj7/FkIdvou8u3CEhR8n7FBKI8qcEsON8hX4AtXusnCaH/y
	Ej/8CraJcUtiXyRNi3Vlx2itVCK73Gf+cX
X-Google-Smtp-Source: AGHT+IFip/lShvRWllilwhcL8Ol8PacwWwmFAaam0lqLm+JyQwZMflMxpqN8f8m/6W1ii3AUdmKnFhSBfa79vqtPCVA=
X-Received: by 2002:a17:90b:2fc4:b0:311:ae39:3dad with SMTP id
 98e67ed59e1d1-31347696706mr809115a91.30.1749146969467; Thu, 05 Jun 2025
 11:09:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250428195022.24587-2-stephen.smalley.work@gmail.com> <CAHC9VhQfrMe7EY3_bvW6PcLdaW7tPMgv6WZuePxd1RrbhyZv-g@mail.gmail.com>
In-Reply-To: <CAHC9VhQfrMe7EY3_bvW6PcLdaW7tPMgv6WZuePxd1RrbhyZv-g@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 5 Jun 2025 14:09:17 -0400
X-Gm-Features: AX0GCFvSHOanjqux2hTZnx--qeaWrQ1aQE-CbC_PtPMv61y7GT38kV1BQ65yzOA
Message-ID: <CAEjxPJ5CSUEsXGT5e9KKXvdWpetm=v8iWc9jKvUMFub30w9KqA@mail.gmail.com>
Subject: Re: [PATCH v2] security,fs,nfs,net: update security_inode_listsecurity()
 interface
To: Paul Moore <paul@paul-moore.com>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Eric Dumazet <edumazet@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, 
	Ondrej Mosnacek <omosnace@redhat.com>, Casey Schaufler <casey@schaufler-ca.com>, linux-nfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 29, 2025 at 7:35=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Mon, Apr 28, 2025 at 4:15=E2=80=AFPM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > Update the security_inode_listsecurity() interface to allow
> > use of the xattr_list_one() helper and update the hook
> > implementations.
> >
> > Link: https://lore.kernel.org/selinux/20250424152822.2719-1-stephen.sma=
lley.work@gmail.com/
> >
> > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > ---
> > This patch is relative to the one linked above, which in theory is on
> > vfs.fixes but doesn't appear to have been pushed when I looked.
> >
> >  fs/nfs/nfs4proc.c             | 10 ++++++----
> >  fs/xattr.c                    | 19 +++++++------------
> >  include/linux/lsm_hook_defs.h |  4 ++--
> >  include/linux/security.h      |  5 +++--
> >  net/socket.c                  | 17 +++++++----------
> >  security/security.c           | 16 ++++++++--------
> >  security/selinux/hooks.c      | 10 +++-------
> >  security/smack/smack_lsm.c    | 13 ++++---------
> >  8 files changed, 40 insertions(+), 54 deletions(-)
>
> Thanks Stephen.  Once we get ACKs from the NFS, netdev, and Smack
> folks I can pull this into the LSM tree.

Note that this will need to have a conflict resolved with:
https://lore.kernel.org/selinux/20250605164852.2016-1-stephen.smalley.work@=
gmail.com/

Fortunately it should be straightforward - just delete the line added
by that patch since this patch fixes the security_inode_listsecurity()
hook interface to return 0 or -errno itself.

>
> --
> paul-moore.com

