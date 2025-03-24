Return-Path: <linux-fsdevel+bounces-44878-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E7290A6DF6F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Mar 2025 17:21:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8EBC37A2621
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Mar 2025 16:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D4FB263C77;
	Mon, 24 Mar 2025 16:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ZwJ6RZP/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54652638B0
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Mar 2025 16:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742833244; cv=none; b=UxkXuUnU5NydfAC+vYr9T5WNU66X5NzQ5IVR3xi3Si7hLKGibuzhQd1U9LiKc3vR7N5V4cd+lB5rQTah2Q0a8uV5fHPIwZutFzYNnpMn/UMP+Q/pgLXpgkapvNb/Ee9fPUESNWQArF0DAbthl+j2Zjc9+Pa9zcp3qx/2I+9cOlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742833244; c=relaxed/simple;
	bh=QEMyyGsi6pKVdO1NZX06aqp/5WGNOG/kiMBDZvItNyc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c5Pj61mmeSWU4zVSdyZBiaEe+reaquFaIJiZq+QYOOdgKucufKWz1T/40QmeWksDpqzaBqw/T6NhyyDBxjzsIEqVJwTK752+bC8JYEGyZz+0RaX7InKqj9UWcXPdie+CtH8alZQJjuFZhvXp1Jl85gnsNpFHaNCuvgO85NqA/mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ZwJ6RZP/; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5e614da8615so8418541a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Mar 2025 09:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1742833241; x=1743438041; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RvYPLpIx/vsSMNptY5I/a8vTPmXkTJh7cHFovrjH+zs=;
        b=ZwJ6RZP//we7OiBrbt0k6+LxpikEZvO5AMbM6H633EwfirkyajUD2n1q9uhMsD8n7u
         jRlrjfh9ycqQM0iLHoHK77Wv22egrF2JcjyHXPczozorDR4k5ZxoEZPq3zK7iIWUDT++
         lVr+xn2GJIHc8Wf2S/Nb/vKHTgJGN7RwnVM5A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742833241; x=1743438041;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RvYPLpIx/vsSMNptY5I/a8vTPmXkTJh7cHFovrjH+zs=;
        b=hFkzdA9yqZmnYMyYNpp1p6xfK5h7UNLMWOAcobccbfQfv7iCpjuVSxoCw4bL4n4GDz
         Mn8RKKdFHKFo2ZHWH4Cxs9NugUYsDirGIvmUwhBXDXaZVr2y1hIHrvSUVKWfo0Eh3sEX
         R/KZFVAPriMVYMR7dtN+ORLl7vmn4QHldj9j8Rj7IeftS8Q7q/D7x/kwoXCYm6jrh/Wk
         sHV/kOw1a69WSPnPBfeifsQiBANQZCOJXXCtYYUx1LnO/6lieUa3t9SDW7dz+XZ1NUcI
         7b2JJIjz8DHPTnWdOhxr+nIhCh1O5f+yUvKwweWaTMm8AideGQgjat+Rcfn7ZPXiAsIy
         tUcg==
X-Gm-Message-State: AOJu0Yx+Iifsql8eofbcOAZ39kat01zctWLjMCjbYezb9zX49xjsTMM1
	agUrBJcxK998b9xsaKB57/P59jkAU7wxWEAuAE1iHCB/tvZ0j95E+EHnXruhtxmiPRhwOfdiw2X
	hL+c=
X-Gm-Gg: ASbGncuWfoKe1Mg6PiDH8Hi5I5IaYqj2iBm2VMtuvuldTDzuqysCYblYdQc31NgfE6w
	FU2OQSvrXWxGYd5HSbs81tZIbjLPQgExaI+jLWH6MqEujSdlSxQK/x0oqxN68jUriP3rvjNirTT
	rwI2qGa1v5nat+WEVzBZx3BvlDM6tJeCHYMKsir3KTXCp0gK5rYG+zhGzPbWAsj2XKKFNxKIZHw
	YqEth/tHaKv73K6Fk/q1MDIsaYV8USZ7dzNiRLdrsEUruvweUKVpcqL3Wi+U9AVBaP68FUysq5b
	nXosR8C9gaEQ6bxAXyHL06Ps5xhPIj95cxdOg0K3Z57BAGbTDgudHF9Ye8kfEPyV7HSLhjWDkuF
	2spkM+Q705r3ym2K2Z5Dt1UNtZW4FYg==
X-Google-Smtp-Source: AGHT+IFvGZ8LCx2V8prIMthhBRxJv1VFp2Air02PE+Pnt7s5EKlBwt5fucpEDva1Prh4NWTSGUm1fw==
X-Received: by 2002:a05:6402:2691:b0:5eb:95aa:486 with SMTP id 4fb4d7f45d1cf-5ebccd32f66mr13111151a12.6.1742833240790;
        Mon, 24 Mar 2025 09:20:40 -0700 (PDT)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ebcd0dfe0esm6321920a12.75.2025.03.24.09.20.40
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Mar 2025 09:20:40 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ab771575040so1096614766b.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Mar 2025 09:20:40 -0700 (PDT)
X-Received: by 2002:a17:907:c23:b0:ac1:edc5:d73b with SMTP id
 a640c23a62f3a-ac3cdb96185mr1669224866b.8.1742833239650; Mon, 24 Mar 2025
 09:20:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250321-vfs-misc-77bd9633b854@brauner>
In-Reply-To: <20250321-vfs-misc-77bd9633b854@brauner>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 24 Mar 2025 09:20:22 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjNojYGmik93aB5UG1Nd5h2VHcVhKfBoYu9jVv_zh6Zng@mail.gmail.com>
X-Gm-Features: AQ5f1JowOKwVmnN0rwQkJkZQnbuG77xhgomiTzUPj4v6fu6nQxCSbS6hjKowXAw
Message-ID: <CAHk-=wjNojYGmik93aB5UG1Nd5h2VHcVhKfBoYu9jVv_zh6Zng@mail.gmail.com>
Subject: Re: [GIT PULL] vfs misc
To: Christian Brauner <brauner@kernel.org>, Mateusz Guzik <mjguzik@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 22 Mar 2025 at 03:13, Christian Brauner <brauner@kernel.org> wrote:
>
> Merge conflicts with mainline
> =============================
>
> This contains a minor merge conflict for include/linux/fs.h.

Hmm. My resolution here was to just take the plain VFS_WARN_ON_INODE()
side, which basically drops commit 37d11cfc6360 ("vfs: sanity check
the length passed to inode_set_cached_link()") entirely, because that
one had a "TODO" that implies it's now replaced by the new
VFS_WARN_ON_INODE() interface.

This is just a note to make sure that if anybody was expecting
something else, you can now speak up and say "can you please do X".

Or, better yet, send a patch.

                Linus

