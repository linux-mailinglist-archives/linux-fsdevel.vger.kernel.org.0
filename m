Return-Path: <linux-fsdevel+bounces-15916-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA29E895D33
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Apr 2024 21:58:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13FE0B25954
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Apr 2024 19:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A429A15CD7A;
	Tue,  2 Apr 2024 19:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="LNtqNNSK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3638B15CD52
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Apr 2024 19:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712087870; cv=none; b=l9Fh1tEsgnS3DP9/J8IxOXFFz2/rAP8k7YKggVbEsth4zBo5Ya476zLTbtz2vJUxeMWMBHzod42AG2eTSGBAYMkbwgQXuNYDMI8LzOwtqXp1eWUDxG/hIuUt8q2xRgzcg6Z7m+2ll/yGvtTMTj8qfPe6/Tfy5aKa9dnCot1S8f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712087870; c=relaxed/simple;
	bh=dktNbJSE4AMUUSXBqDMDbOSzD2AIdHi/2em6bOnXPak=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sLV/IfllqhI59XOI03WIRTqk6zmH6Y7+OG7ijEGJR3XJC1c2FljtiTf5xZwcOt3fXD1lSI/vOBTr//UHG32zo7czk1eAI0HPGL9r7iP9fpUHoz3TJ1VcWOmedphCZHTgqAAv/7jAhDB6j7yxKOaNClkXS27qWGMG75RTx0V7QNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=LNtqNNSK; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a4a3a5e47baso660225166b.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Apr 2024 12:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1712087866; x=1712692666; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xZSMPyJcLDwQQyPD929o3b508jAKY9ueBln0f3F7O4Q=;
        b=LNtqNNSK2bxx5ZBmRwBbbisytbYWfxwNUm4pCONxSDiyQA4x40LNM9pwUOlV9l6SBd
         dq3annfM35j9CkSniihaifFKA/I9XrLJv1LyYi9GqAKPmLaNy4iSI/Xcr8gfRZo5AXsE
         30yfgTyqewyZ1yQ9OivJubpMkTgvXkjWl0ff8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712087866; x=1712692666;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xZSMPyJcLDwQQyPD929o3b508jAKY9ueBln0f3F7O4Q=;
        b=ltgC70zi1IrJaEUt424YS+GflIGosEyJzIpTj8xxwV10Kfv1Rt08beyrr6FZglu9tq
         qPu6trikK+OngpfU+A8X5mPKKKRnVfaDnpwDAVWPXuQjVA3dl3ZT4gmlaPinlGgl61rf
         dRCEGuYxpqbxnQrkGrZVjr57TSmi8JmcpIjNmqqGl+f2rtXr4kHaW/rfOBC2KkE2brVO
         06VXvO6x2PxHuYvSj1ZBnsUooriqgKi+on+bPE3wWIzoar2u+epb8ZBRg4gKli+mhueR
         saoRGUD6UevcyxQXIz/d0OGHu+hjAMWmCvZLT5REPvB9FKf6zU9mFHXZfF3URCMFce1x
         bXDw==
X-Forwarded-Encrypted: i=1; AJvYcCXmLYT6RUnQim7KTnZEojNv0Z7kAhMi/epHooIZvHzyQpXj419GdO+jjHu6jtkY7RqH3lMJXtd3SdayzDsPkGbz3SnQVGklLBFDTGWDVw==
X-Gm-Message-State: AOJu0Yz7l/pE4owZtMMUbMpxl5OB1rTa63f4H3hZK2otKDEzL9PvW+ox
	pSXl5r+KjYoOw95d3sOvY3O66Cp/FoS1rLTGVqAZfym83LMQkIr6uCJ9BfCdJ5WIQAsG/JpHpo2
	88pk=
X-Google-Smtp-Source: AGHT+IGzbYGpzmshIafj42Ek1klIVBdCVrBfCbqREBI4Gaw4ZvG91cJFkhsWIqVC3ZGEeTxAKhA8GA==
X-Received: by 2002:a17:907:a46:b0:a4e:38c3:e06b with SMTP id be6-20020a1709070a4600b00a4e38c3e06bmr12174188ejc.73.1712087866275;
        Tue, 02 Apr 2024 12:57:46 -0700 (PDT)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id u7-20020a17090626c700b00a4735e440e1sm6945999ejc.97.2024.04.02.12.57.45
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Apr 2024 12:57:45 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a4a3a5e47baso660221766b.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Apr 2024 12:57:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWx/kNYV4vkQLkNmZ9YwUFT6tPQae1qwjkq3aFi23a+eZ0tH2uuC0mlDK5dRgj0fHgN+cPIyyFzkCGNcLh+vhPem8SI2KXuRouyCUcpew==
X-Received: by 2002:a17:906:5794:b0:a4e:7b8e:35ae with SMTP id
 k20-20020a170906579400b00a4e7b8e35aemr3749307ejq.38.1712087865212; Tue, 02
 Apr 2024 12:57:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240402141145.2685631-1-roberto.sassu@huaweicloud.com> <CAHk-=wgepVMJCYj9s7J50_Tpb5BWq9buBoF0J5HAa1xjet6B8A@mail.gmail.com>
In-Reply-To: <CAHk-=wgepVMJCYj9s7J50_Tpb5BWq9buBoF0J5HAa1xjet6B8A@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 2 Apr 2024 12:57:28 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjjx3oZ55Uyaw9N_kboHdiScLkXAu05CmPF_p_UhQ-tbw@mail.gmail.com>
Message-ID: <CAHk-=wjjx3oZ55Uyaw9N_kboHdiScLkXAu05CmPF_p_UhQ-tbw@mail.gmail.com>
Subject: Re: [GIT PULL] security changes for v6.9-rc3
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-cifs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 2 Apr 2024 at 12:39, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>

>    void security_path_post_mknod(struct mnt_idmap *idmap, struct dentry *dentry)
>    {
>   -     if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
>   +     struct inode *inode = d_backing_inode(dentry);
>   +     if (unlikely(!inode || IS_PRIVATE(inode)))
>                 return;
>         call_void_hook(path_post_mknod, idmap, dentry);

Hmm. We do have other hooks that get called for this case.

For fsnotify_create() we actually have a comment about this:

 * fsnotify_create - 'name' was linked in
 *
 * Caller must make sure that dentry->d_name is stable.
 * Note: some filesystems (e.g. kernfs) leave @dentry negative and instantiate
 * ->d_inode later

and audit_inode_child() ends up having a

        if (inode)
                handle_one(inode);

in it.

So in other cases we do handle the NULL, but it does seem like the
other cases actually do validaly want to deal with this (ie the
fsnotify case will say "the directory that mknod was done in was
changed" even if it doesn't know what the change is.

But for the security case, it really doesn't seem to make much sense
to check a mknod() that you don't know the result of.

I do wonder if that "!inode" test might also be more specific with
"d_unhashed(dentry)". But that would only make sense if we moved this
test from security_path_post_mknod() into the caller itself, ie we
could possibly do something like this instead (or in addition to):

  -     if (error)
  -             goto out2;
  -     security_path_post_mknod(idmap, dentry);
  +     if (!error && !d_unhashed(dentry))
  +             security_path_post_mknod(idmap, dentry);

which might also be sensible.

Al? Anybody?

                Linus

