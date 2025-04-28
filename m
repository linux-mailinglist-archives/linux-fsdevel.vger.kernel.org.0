Return-Path: <linux-fsdevel+bounces-47527-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BFB4A9F5B0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 18:24:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 765F018939ED
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 16:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6547427A93B;
	Mon, 28 Apr 2025 16:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S3xmTi2e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5448810785;
	Mon, 28 Apr 2025 16:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745857411; cv=none; b=A8MkmM8lFaX8YAepA5K3jNyWTZURiVNF+kA3nTraHbANpjyZbLkZSq5udlhFqjwN03o/s+CZT3wC8Artd9AW1/Reu2wLvSyqL6K8o2qmIKSFsRaEn+89aQ5NSzHj0eXd5xrCcXOjT/T9K4ZCfKJjXJ8VEat29xZ7R7T/KfEdaqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745857411; c=relaxed/simple;
	bh=5qPKUfvfWBm6GDPq3AacRMyFRllAqsEUiTvBhrcqlew=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MUIm+mnco1WILdZlMuA1PV0jZDqNK5CxZLFMDkn46Rg4AVmB+Pk/ANtj4GuC42yi8bKvcJWQClkAjYFQRZxIP1k1pPzc2ui8kzsqUand94U4ZRZBJ1wkKlaI7W3HVcq4q3v4oGlj2HpTj+jvcGOXMy4se4cU6XueLSNqqlpZ6Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S3xmTi2e; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b0b2ce7cc81so5016096a12.3;
        Mon, 28 Apr 2025 09:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745857409; x=1746462209; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IikIezFwS89Wg3f8ZovJv1bvPqR36SxG1IC6QNm/m7U=;
        b=S3xmTi2emi2uVV73vzqgGrjtJ6y2RC1pII6vtVpfegMArXE9bEPY/2TrV0kTRE/OVL
         Bu1S14DqYsatljZNDmWU6SCvRrSM2i0oz/5vZnBxcpa7CCp4tk5vIrTqqd84vsQ/oS3o
         EJkrZfzsFpECFqmNEx+spEpHtvDIKoer1YhvaJBlgFQoqdYyvbhNDCRTCPB3p9Od6zEZ
         q4cJZvbbK3yTKnOvnBVSgrfGs+vby+dGJV2bp++HDxw4BkpBilWN6eIGC2AVCdpIO+pN
         1m8RTlukxs9NCZ16lW6Vvh74KBwUkult/DMsylgxygiyvo9npPOqPUrO9NwklWcQncIr
         ZcVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745857409; x=1746462209;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IikIezFwS89Wg3f8ZovJv1bvPqR36SxG1IC6QNm/m7U=;
        b=m6XT8sYzUbJnz7uWqO67B44+M+ooY+8shyKBMOQ5V+7f1pzGMFYvO1OlKOnaV4jT1w
         9s4NSe+J1pJl2rXibRufDcvQW0CkI2N7pyi2AgkYQ4RkEygdnHkQ6fQKDyXsaRpsF9KZ
         v/yDPBbshWecHkJdc3BlRqHOKqtuxbI7JoS8tfuip8ywf40m3Zk7pv/nJo6pwPeGEVl9
         NVHILCSrWoEdFVIHwB29goYDFJkPoC20yOsVMbNWrqF1IWCpFPoqQNYpXvG5lvcf9d3k
         E6b9tLf1I6Q1x94W074DfRcBql4uO5ZoUjFNW72a/IHMVhsrQ7GuQPdpkPLfMjXxDeYg
         AbLA==
X-Forwarded-Encrypted: i=1; AJvYcCVB+nzLjgkROz1cOkXbWWmdvnb5Z5RLGXvwq9ptWZf8Qof4Xek66FpoG6crl5AqK9Xgy2y7pMOeDLCy@vger.kernel.org, AJvYcCVmwVncjIzyJIVk1Pk3pVWt34a5tpfxPlu4APcYpTkW4OOxDmzOHhtvZris3AR/Eshn2MM15RUVYsA/VSlQ@vger.kernel.org, AJvYcCVqFfbHV76jKHZ0wzdJC52kJ77SYd+FiInjY8WrVddqKNyHeYy9C7Lz6QAzQ9JssEZsEk/DCFnStBkFNUwEXOjo36hugEQn@vger.kernel.org, AJvYcCWGWdRVOdw0e////aMYvIIvYp7P1DxJEg5p9gk+X5RFXqoOpZLSo6YOuHM7emo+FW2g0/I3Ctva@vger.kernel.org, AJvYcCWOWbuVsSMXIecWqrQ7M3PJr0X7QEwvBcDb1hgX6H0Vul2P5P4fJO/vT4TtRpNgnmv8Y7oXGNAhxA==@vger.kernel.org, AJvYcCXYGO6f+Y68yswdb7loflPqcp1X0abZyiVE8+2NA+on0CEecTYD5/mvMCKZuxLSx4j7XR3v9bRPHqAZK5Rw@vger.kernel.org
X-Gm-Message-State: AOJu0YwU8gQBZElx2Ru4zUHgwdl/otVvfC1bbkM2PKRAYQkJsvJN8iau
	WsSGDPg32GfjmIJxUEZk+j/YRezN+h5erCRmBT4fqBGswJrhczhraPezS7Wsc9Yc4tdVw/TtOss
	Uot3ii5cmKure33H6S7icqQeTsVc=
X-Gm-Gg: ASbGncurJHmTwT5vHo/pZUjqd9NPlrx+VjrD6+iT0SXTH1nlgxOtkB46bEiBlpDWx96
	H5tAIzgoru/PwiMP6PSYx2PMK5tD3TLKs1hsFeLfZ+fuJZjYiT7co5RiX4Fjh2eiPguRowkmIMS
	EAGp2EQ/Nm2hdb2WUDdhWhAg==
X-Google-Smtp-Source: AGHT+IGzIEjc2lvkceZlDKdm2qY/zCu5A+pl3TXC8mVuaushCwPL9MM4wk7xfNznoiPPQU3PG4rSQ+WeKOpp8Qro3dI=
X-Received: by 2002:a17:90b:2652:b0:2ee:53b3:3f1c with SMTP id
 98e67ed59e1d1-30a21546d64mr698661a91.5.1745857409488; Mon, 28 Apr 2025
 09:23:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250428155535.6577-2-stephen.smalley.work@gmail.com> <988adabb-4236-4401-9db1-130687b0d84f@schaufler-ca.com>
In-Reply-To: <988adabb-4236-4401-9db1-130687b0d84f@schaufler-ca.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 28 Apr 2025 12:23:17 -0400
X-Gm-Features: ATxdqUGDgVX_7NlepqnAy9kBPPKZopkYefb_TkriK5U4tyArOVv0xUT4dPx2siw
Message-ID: <CAEjxPJ66vErSdqaMkdx8H2xcYXQ1hrscLpkWDSQ906q8c2VTFQ@mail.gmail.com>
Subject: Re: [PATCH] security,fs,nfs,net: update security_inode_listsecurity() interface
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: paul@paul-moore.com, Trond Myklebust <trondmy@kernel.org>, 
	Anna Schumaker <anna@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Eric Dumazet <edumazet@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, 
	Ondrej Mosnacek <omosnace@redhat.com>, linux-nfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 28, 2025 at 12:17=E2=80=AFPM Casey Schaufler <casey@schaufler-c=
a.com> wrote:
>
> On 4/28/2025 8:55 AM, Stephen Smalley wrote:
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
>
> > diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_def=
s.h
> > index bf3bbac4e02a..3c3919dcdebc 100644
> > --- a/include/linux/lsm_hook_defs.h
> > +++ b/include/linux/lsm_hook_defs.h
> > @@ -174,8 +174,8 @@ LSM_HOOK(int, -EOPNOTSUPP, inode_getsecurity, struc=
t mnt_idmap *idmap,
> >        struct inode *inode, const char *name, void **buffer, bool alloc=
)
> >  LSM_HOOK(int, -EOPNOTSUPP, inode_setsecurity, struct inode *inode,
> >        const char *name, const void *value, size_t size, int flags)
> > -LSM_HOOK(int, 0, inode_listsecurity, struct inode *inode, char *buffer=
,
> > -      size_t buffer_size)
> > +LSM_HOOK(int, 0, inode_listsecurity, struct inode *inode, char **buffe=
r,
> > +      ssize_t *remaining_size)
>
> How about "rem", "rsize" or some other name instead of the overly long
> "remaining_size_"?

I don't especially care either way but was just being consistent with
the xattr_list_one() code.

