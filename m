Return-Path: <linux-fsdevel+bounces-47649-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23914AA3C58
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 01:35:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13924463FC1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 23:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C1322DCB6E;
	Tue, 29 Apr 2025 23:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="QDm1WH5a"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDE62DAF8C
	for <linux-fsdevel@vger.kernel.org>; Tue, 29 Apr 2025 23:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745969711; cv=none; b=ly5PlHQFjCTZe76M4zn1aTC20yu6rpNdBTu5GZkJKmToG9jVEabigyQ5yHF55o17k4gUyywSToVgZOeM5SKciZGRZKMYgRPlpT6u1/MVYHvwgkjVTw5hFTdorNS02+jKiMXXUXnzK3fKTeXjhKHYrqGiKQfr0DDWBtnFbfUXNAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745969711; c=relaxed/simple;
	bh=rsEl9UaP3K3oS3AXEGJ4//+d9JcVZzKygP7EoztCreI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mWCP8odC2xhb+W5y4RVud/OHkd7ZdinT4oxl20hKEYmrGHvXNumaVqWAkfez4sYR/LbIf9d4sfMdHyW6noUKxxR0pNdFQeR7YsqKWcupDHlLDzwTSxfU49azRELv6CVnwQT0kCPfp/p0hVLTYxSnQNEyhL0/EKyK9qGhd1oluhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=QDm1WH5a; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e7387d4a334so822981276.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Apr 2025 16:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1745969708; x=1746574508; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RmnUMSIYfYwpn2HyiLKQyNsn7KSrfP3LbpSrKf+5Aoo=;
        b=QDm1WH5aDX3S3onHkINlqKhU3r9HLrw9D1iA4hyEWhENRuaD2NoLbOYORnp9+t083B
         2ZEG+KjLVuRtm8hoXk4HbUQXHgx+8/3YuC1MUHB0OOR8YumhPW3x93lR3uV7dh6TAJ1C
         Cg4Z53TupJMN7ljgn/spNJm2j6L6EQV2CMOHBEoDRkHyXWg8IADMRpxcZ1Q/6YcaWszZ
         xQQ8xpM3l//Dvo1h8453Bv0azTO8mUYPBv3lktXIg75qLusprpBitm76RUHAREgu2bHP
         RAr2MZ4YMrOhy3JzoxkSDgZ38hXSb0YTYXcIWZBqWyfh3MgB3P1ll09FlnC3C4fZqfNm
         rVZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745969708; x=1746574508;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RmnUMSIYfYwpn2HyiLKQyNsn7KSrfP3LbpSrKf+5Aoo=;
        b=ZNnL4hWJjabZcu3ThVyc8jdTfoAnmYcr2HAGVJWbnNQrvLpbbI5OgR/2y1vpsY8kQV
         Jl1O9IW0sAoFMiv4NEHzrhF1Ux1Yzl8eXlMC7dU/Li28Y/WygNUup3d8aJYXzXUcEDGX
         HEhJzv51PY9YuICIucEoC1C1iznPk7vX26P3AyCIEndGG8xn2M8f67bWTVVP/2yEMdER
         oVLKQAVGv/1V70FPn1yKbLlzCnPxz3wpO8JI5M8fvjzHBbuSV3L/VNFg1EtF2TO1L1wF
         0CHsrvDU12mPDP7+4S6kyaF/P/wCe9pi620idO0p3EgzbN7RTaxuWusl3b6La28btDtm
         sFoA==
X-Forwarded-Encrypted: i=1; AJvYcCXbiNWprnssQpn/eAoCwLOrSXRGYpHnmqbj8QUJU/qvjPwdf28CoF7oB08pkMxOnOIjN6sAilyJl6cOeUWT@vger.kernel.org
X-Gm-Message-State: AOJu0Yx29efEhaCIw9bZVv1pFBF+SLwh8qRbBpAIrnyntspnsYbuROIW
	PdYid1/5wYucTJeMU3TFxVuD+wnOWKnIgsWh7vnCdrByNDz9Afpg0pVlD5dRcZX+rCnfXkQIcaP
	Jg9iUvklp56R2IWpXXhR+xS+BaalYzX5+hx2H
X-Gm-Gg: ASbGncusmIzz9/DYS2WiXkuzgVZGm5S7+fOGtVj+wgML5ue+zNrWiEeYHavTPsZjANc
	MRHjuRAeHYH9rsfTlQI1PVyxw7hMipX3Rw4ESiexAicRUt4MGRqNDrLX/QcVRddEPTSXs/rS9h2
	EUThhhivUzF16xK+bczYRyOA==
X-Google-Smtp-Source: AGHT+IF/PA17pzv+wdeYWaRIlp9MG3hOQmLeL81RAcqY50BbqvkWNnzjIoFkoR7L0ftuH1lvEReltyIjrUvBDvzq1Oo=
X-Received: by 2002:a05:6902:18d0:b0:e6d:d996:d8e2 with SMTP id
 3f1490d57ef6-e73ea8e46c4mr1522551276.14.1745969708362; Tue, 29 Apr 2025
 16:35:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250428195022.24587-2-stephen.smalley.work@gmail.com>
In-Reply-To: <20250428195022.24587-2-stephen.smalley.work@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 29 Apr 2025 19:34:57 -0400
X-Gm-Features: ATxdqUErdvmLNdYZ_wWU2pMeCgVPQbMkXZvEOfiOk_QLBFdZZaZpYQrTWKeaZ3k
Message-ID: <CAHC9VhQfrMe7EY3_bvW6PcLdaW7tPMgv6WZuePxd1RrbhyZv-g@mail.gmail.com>
Subject: Re: [PATCH v2] security,fs,nfs,net: update security_inode_listsecurity()
 interface
To: Stephen Smalley <stephen.smalley.work@gmail.com>
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

On Mon, Apr 28, 2025 at 4:15=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> Update the security_inode_listsecurity() interface to allow
> use of the xattr_list_one() helper and update the hook
> implementations.
>
> Link: https://lore.kernel.org/selinux/20250424152822.2719-1-stephen.small=
ey.work@gmail.com/
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
> This patch is relative to the one linked above, which in theory is on
> vfs.fixes but doesn't appear to have been pushed when I looked.
>
>  fs/nfs/nfs4proc.c             | 10 ++++++----
>  fs/xattr.c                    | 19 +++++++------------
>  include/linux/lsm_hook_defs.h |  4 ++--
>  include/linux/security.h      |  5 +++--
>  net/socket.c                  | 17 +++++++----------
>  security/security.c           | 16 ++++++++--------
>  security/selinux/hooks.c      | 10 +++-------
>  security/smack/smack_lsm.c    | 13 ++++---------
>  8 files changed, 40 insertions(+), 54 deletions(-)

Thanks Stephen.  Once we get ACKs from the NFS, netdev, and Smack
folks I can pull this into the LSM tree.

--=20
paul-moore.com

