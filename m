Return-Path: <linux-fsdevel+bounces-68424-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B5B7CC5BB37
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 08:13:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0851E4EC232
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 07:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C25B719F137;
	Fri, 14 Nov 2025 07:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="ZEGNGLmm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106A323184F
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Nov 2025 07:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763104190; cv=none; b=riDzUqnYkbDHAhNJ3RbFJ5cZBTkQrmw68Pi5/9uu+i7hMtlx5PSHZM5aIEjFynQUyJMRSEUrTspTIQ6sum/SfGLb3jc7VRizDm7imjAKygXhucT9GgysmJWGx0l+3/CZCGPbdAbGg/6u1f6kdBKVyPrWB8Zz+wVSnsuz07ZxukM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763104190; c=relaxed/simple;
	bh=E06eWH/B19XQlvXFz1DPzyDdhpFnpRK56zuzDqc3nDw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QwWAM/u5TRcDt9pbf0uz2HHba03tYE7SIM+A5d/ytN+hJKIjT9nydEFa6OhlweeDt3/qzX20u+A9wQuj66uJwyLbqXySakM8wofY4rE99X/GEXAUJMuIsp0btMHuEtE6j23ZkbqDyZ0ptzb7V6/BG9bPmNtg3aitNXQzHOW2JjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=ZEGNGLmm; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4ede6b5cad7so7849121cf.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Nov 2025 23:09:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1763104187; x=1763708987; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SyZzeGaFJhk0rTaUbsr78GBXbJj3F8nSjFa0Vp62350=;
        b=ZEGNGLmmrCFkPujjRkv6c7sIUGoJxCAtcWq2Ghn8xkxb6Rzh6B1MP3TbtHYSOBKllC
         pCvm0cZ84WjOuEYjsC2ctZNF606l5VCDdytMVY2t1oB2f++p14szVvL2TBeI/6hijUpP
         c/Z/tqTVSu48yhVHgXZtLsd8Px0j54BupxiTk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763104187; x=1763708987;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SyZzeGaFJhk0rTaUbsr78GBXbJj3F8nSjFa0Vp62350=;
        b=uD0OwncKOpGu8IAr0cB6oZt64qgUFazSSLwcvPf0NW05KZpReJ4/k972Kwc4Lkbk90
         XodQiZy3RtsZ08cSyUeRZ5L7pSlFfGsMIOj3k5djKfJ8kqlfUSiNU0V30YbjrVVsia/M
         oyOE2ulgQdcf6mFPRnpg73Hmq5x3XiY1XGTwaYYzniZmN/sqlrnYDkkMCB0MjEI8TTQy
         zfaL0D1J9/RYc6HQOZz2qHdrJdsaO5dGzmJdNPibpnIvCsFaIUjBdVinTAMw2EbNe4KC
         F684yqqJ68ysxN2gu7c9Ks+9v1bMlOPKsi/l9hxa1WO96qwX+TsxriHeKs0xmMILJn9D
         axDw==
X-Forwarded-Encrypted: i=1; AJvYcCU6d8N9ShXxOg3x69AXPpjX79Fjlz5YQY1aRNk3GoGmA2ztx03tc3Ag0hLbhVTeWcKJJysbiSfK0cpPs9gM@vger.kernel.org
X-Gm-Message-State: AOJu0YylYm/8KwC9OvKQM8wNyPaUl0oWyDEoG2rl4tGmm1SdgkpirRq4
	+fsVc8QOgp1HopMDIyPQqxtUUGVBIT65vvkZm8guUhCixkT7rC/1ZRZrxvRkyGpJVMIXgNzjJEE
	gHyFeK4Jbo9mw5EOqrbdvemiebpEYzbwdo6zX+1Tydw==
X-Gm-Gg: ASbGncvGiFWvPRba+RNP4DMeVcv+6u9RZ4IwBX7WuvPI2/7M6jZFSwQ1r5Gu4MA2hlE
	6H3C03bm1zb1Xe0B2kALy+sIljAsZ7VhobfIqVQGHSfVYOY5FRwZxm2IV1ZNQfA0GgCajk/5eQQ
	kUz9y1nGMrDXpZyrIiCZPMHR9DmZ9ChFB4AcePVNW+mekQsJsaTsn6/+dqX0SRFWMvj0Zx2cIYD
	IXFctpY9/3N5vgxZYO8C2R++xPh/91krbBH529tUto95+Swm+AqiJUVfA==
X-Google-Smtp-Source: AGHT+IFOSVJvXV1OcjbCp2tNCmKIqjhBe/HN4xDG2P/zX6+RE9u8PQoIv/hpBwulbdMxQR8y96wz/zC8GlmXCJvFWmQ=
X-Received: by 2002:ac8:5890:0:b0:4ed:b6aa:ee2b with SMTP id
 d75a77b69052e-4edf2063f39mr34591371cf.18.1763104186667; Thu, 13 Nov 2025
 23:09:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251113-work-ovl-cred-guard-v3-0-b35ec983efc1@kernel.org> <20251113-work-ovl-cred-guard-v3-3-b35ec983efc1@kernel.org>
In-Reply-To: <20251113-work-ovl-cred-guard-v3-3-b35ec983efc1@kernel.org>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 14 Nov 2025 08:09:35 +0100
X-Gm-Features: AWmQ_blmZknZYznECSy4HXGEdaW63w0Uq9RQ67Oq-ScGROKoZXIUAbDUXPVUGG0
Message-ID: <CAJfpegtLkj_+W_rZxoMQ3zO_ZYrcKstWHPaRd6BmD4j80+SCdA@mail.gmail.com>
Subject: Re: [PATCH v3 03/42] ovl: port ovl_create_or_link() to cred guard
To: Christian Brauner <brauner@kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 13 Nov 2025 at 22:32, Christian Brauner <brauner@kernel.org> wrote:

> @@ -641,23 +640,17 @@ static int ovl_create_or_link(struct dentry *dentry, struct inode *inode,
>                          * create a new inode, so just use the ovl mounter's
>                          * fs{u,g}id.
>                          */
> -               new_cred = ovl_setup_cred_for_create(dentry, inode, attr->mode,
> -                                                    old_cred);
> -               err = PTR_ERR(new_cred);
> -               if (IS_ERR(new_cred)) {
> -                       new_cred = NULL;
> -                       goto out_revert_creds;
> -               }
> +                       new_cred = ovl_setup_cred_for_create(dentry, inode, attr->mode, old_cred);
> +                       if (IS_ERR(new_cred))
> +                               return PTR_ERR(new_cred);

put_cred() doesn't handle IS_ERR() pointers, AFAICS.

