Return-Path: <linux-fsdevel+bounces-33367-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE6079B8306
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Oct 2024 20:04:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9492B1F22914
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Oct 2024 19:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD50E1C9DFC;
	Thu, 31 Oct 2024 19:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="S2U3nhsr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76F680BF8
	for <linux-fsdevel@vger.kernel.org>; Thu, 31 Oct 2024 19:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730401478; cv=none; b=IZ+GDiNlEqRT9EnEvNHh+sucrxnLTWb15h3GjICyy+4A/kGscFm5QV/uTkkRzQC3uVYLQNcwYLfkR3cvDdtDidOZhdsJY7HXYnB/ub1TyGI70Z0yiDe1u/fD2sH35XGgvvkxbD/RtAaRX82H8NShfE1AzipilbNK0fFfif5TN/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730401478; c=relaxed/simple;
	bh=M0UgJlzg7nkwCodG/cwFh4U0GEJHkuiArThQ06qRmw0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EKaiVggGImzigeIHf5FO4yCHEw2VHMwx5cXRbHDiVmQGpo1EROPkU0jjIAAggRKjBHbu1OWVYWjAZ4R0VGcxDLV4M9dCgVSwNTVQYs4asnEncT6/h5PAQ1AbS4ucoPO41PnbcVBXh/JtPIAduYRZCNXAUNozmfcF4ArjQ0BO4Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=S2U3nhsr; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a86e9db75b9so170405866b.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 31 Oct 2024 12:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1730401474; x=1731006274; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UecBPu19lLQYJ6H0+KnEk0iDFuBWtuoKzFymrXleIsc=;
        b=S2U3nhsr2BT7ikF9MElrcvPw+TOf6oNa96W7SD3FYE87L5BynYd3y5DhddTcbnC7Gi
         +A9gkWzL3YCyGYIk8LllFMQjqWasxMOvKWq+Dd0B35QobI6+JCyqzL38ZUYQC9x8hsEc
         t64+S1TuzDXFDJquzwl1Gyv+6iwurU0TPicZY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730401474; x=1731006274;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UecBPu19lLQYJ6H0+KnEk0iDFuBWtuoKzFymrXleIsc=;
        b=frekI0LyrGAAshffzsna6IZ8hT5fHDPGkhmprPs2uP9tHGsYPoa0tbb39LVUK+39uD
         58VVEfyFxRMBTOpDcOptcCZqmRhGJ//Wctr0u3PpvAN8hfz57Dq+67nNJQu7QcdM2qjk
         2pECufGHV5JBufNBr8UZ0G98G5mTwXMjXTGIC/PRJQpAAe0YZ+r5RpcxtQsfSnVSQ8hl
         1ElIqKeGPwS+Z2lt5ZICnS+JLNplMjtirsE5ZTVtnz1TEcXqAJu64rQ+6SR3vWfpnX+A
         vKhF2jU1/ezKSfQ/c3Ry0W2WB6lzK0IM+A3HUYhV63RrefSTptzEIPev7FXnWOWrZ81P
         wFIw==
X-Forwarded-Encrypted: i=1; AJvYcCVx14OO2/I7sRMiH+80UL/kEGO+79qAiQoyatpNVG1S1p6spgofUzAQ0UVNPe42ibvARLyZy5JuNpOP9vgp@vger.kernel.org
X-Gm-Message-State: AOJu0YyRIZxpfxb7m6v0Q3S0P8bKSe5pVsf9Jb637dKVoL0B6unJg4cj
	MYpftnSnC7mR67Aubh+E0/vXIfCniRk2NSpR4PQb0WGSoXkp9MOOvCLpCQsgUgJFA0kMbwJMqMB
	Uiwc=
X-Google-Smtp-Source: AGHT+IERQ2cFddCM31/AQaT1G1/B9cTSJF6CG7XF+XHemBnzkab0467wwC6YM9TwNX+i3RB02j3bOQ==
X-Received: by 2002:a17:907:6d11:b0:a99:5f16:3539 with SMTP id a640c23a62f3a-a9e505ceefcmr404353666b.0.1730401473730;
        Thu, 31 Oct 2024 12:04:33 -0700 (PDT)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9e565e08c2sm96246266b.141.2024.10.31.12.04.32
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Oct 2024 12:04:33 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a9a6b4ca29bso141075166b.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 31 Oct 2024 12:04:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUEHNfNz3vxxjn+4JjtP5dYMgf9mEzIuzdw7qlsDzSdiZ3Qi0iMIZGCto5oqS8D4sSKN3B5dF0oq6ShK33N@vger.kernel.org
X-Received: by 2002:a17:906:c113:b0:a9a:6bd:95dc with SMTP id
 a640c23a62f3a-a9e50b56a13mr449024166b.46.1730401472624; Thu, 31 Oct 2024
 12:04:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=whJgRDtxTudTQ9HV8BFw5-bBsu+c8Ouwd_PrPqPB6_KEQ@mail.gmail.com>
 <20241031-klaglos-geldmangel-c0e7775d42a7@brauner>
In-Reply-To: <20241031-klaglos-geldmangel-c0e7775d42a7@brauner>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 31 Oct 2024 09:04:15 -1000
X-Gmail-Original-Message-ID: <CAHk-=wjwNkQXLvAM_CKn2YwrCk8m4ScuuhDv2Jzr7YPmB8BOEA@mail.gmail.com>
Message-ID: <CAHk-=wjwNkQXLvAM_CKn2YwrCk8m4ScuuhDv2Jzr7YPmB8BOEA@mail.gmail.com>
Subject: Re: generic_permission() optimization
To: Christian Brauner <brauner@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 31 Oct 2024 at 03:07, Christian Brauner <brauner@kernel.org> wrote:
>
> > It's all really just "acl_permission_check()" and that code is
> > actually fairly optimized, except that the whole
> >
> >         vfsuid = i_uid_into_vfsuid(idmap, inode);
> >
> > to check whether we're the owner is *not* cheap. It causes a call to
> > make_vfsuid(), and it's just messy.
>
> I assume you ran your benchmark on baremetal so no containers or
> idmappings? I find this somewhat suprising.

Yes, I did too, this is the "simple" case for the whole uid mapping
case, and I didn't expect it to be noticeable.

That said, that function is just called a *LOT*. It's not just for
each file opened, it's called for each path component as part of
filename lookup, for that may_lookup_inode_permission ->
do_inode_permission -> generic_permission -> acl_permission_check
path.

>          One thing to optimize here
> independent of your proposal would be to try and __always_inline
> make_vfsuid().

Maybe. Part of the cost seems to be the call, but a bigger part seems
to be the memory accesses around it with that whole
inode->i_sb->s_user_ns chain to load it, and then current->cred->fsuid
to compare against the result.

Anyway, I'll play around with this a bit more and try to get better profiles.

                Linus

