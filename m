Return-Path: <linux-fsdevel+bounces-13323-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 080D286E7BD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 18:52:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 252FE1C22B7B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 17:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E083F12B72;
	Fri,  1 Mar 2024 17:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="PFjLRZ6n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E1A16FF5F
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 Mar 2024 17:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709315519; cv=none; b=YMNCXcURv2Bi6pxLpO/3jC0xFOZG+QbYpYiLFNiJnQZv3Jrtb9XG7f8FSPzPXtvNNj0TTGoKnNz/WP2eEbOgqS6vN13f/7vX/J1jWUSjpiDD11OCLWU+5tiB0fys3UwofvoiIQJ1WEcShiyE/tudf+AP/jMF0XwlOiLVZjPl6dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709315519; c=relaxed/simple;
	bh=49XDVc09oo1D7rxA4pKGXs7kZYjPBKw7n1z6bPxN2O4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W4ffaN4qWk7/dToqHOXifpSCXlk0r0Eu1iObcVOiun/Wn1PQxg2ier8YSfkJ8/N5VgAqgTbY+iSbQ90li1hAApnOXFQkZmXLFUCCQPCmd9v8D7WcaxYsXO7GYEUa76K1CAOx9Qz86aHLGrqvMAdmLOMUreq7HNmUVZv+n+VkVm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=PFjLRZ6n; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d094bc2244so32281641fa.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 01 Mar 2024 09:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1709315515; x=1709920315; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uzMbDkgTXsN2/951Q9RWiF9r9QR8HrSOWMnrlfRXcYc=;
        b=PFjLRZ6nGmqMCp8ZzmNjDoCM2t89j+RdR0Za/FRYNx0n9Gog1SVfOOh5jho4gBaxzQ
         J3Xe5bwHQ00wsEMVR+c2X7FnzrgIH6fuHO3WfSyWAmCC56vCzf5NCaEp3AQz5x2mtJHW
         sd9NKuUAxeEyPs/kfYMCZhuM6tcPaZW6tE2QQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709315515; x=1709920315;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uzMbDkgTXsN2/951Q9RWiF9r9QR8HrSOWMnrlfRXcYc=;
        b=fACtoheq/fJa06UrN9FwJrTYGEzmjnpR5BaF7ylENgl6odTl0WCp5mWzdJg4csp/nT
         RyYU4Iwdg85M/E4OcmkDldnQ72WhUTabxW6dROgldl2YxypZawDsFilsqkpNtnJdiGWa
         6t9h4qss4iQYy0Pdyy9tbhwRLJqkDjMOEsutUEieHOX2ErhZjYSr2uXefrgJ4IalHjvP
         tVmdn4ajkSMcX2zDii41szCHdE4RvT9gWpuBopMnEKOh+TJvKIVyfoQuRgm3/sLkKSZO
         u33XYK4TlRnXDoBCd104xgrnIjtyBIXnddYLvmHVxlkSPcLMrruuSIgCL0RMx1bhsBZT
         CvKw==
X-Forwarded-Encrypted: i=1; AJvYcCXVQnXrUfP1oKsF1/vLg4KGE74fnaubrXehO7MKeTsAJblnyqAOm+BHinxwjBE3cl05goohZCedcJ10loaH8COw50gYvv+HeQLeHJvzOA==
X-Gm-Message-State: AOJu0YxNCvgW2Oz2Hk1xNZKNf7W/eD2NBazN96bMazkW32c+7swMfaa9
	16ZSAZAVrmtXmiRDt9WSWwnC3dllfsCGG/ai/y/OS3q4d/EkGckwZo7Vd5yAr9AAcTtjpDmRr63
	sBsKumw==
X-Google-Smtp-Source: AGHT+IHQ6GCyM8oPzmCQqVsTulDa2OKsCTZsbfcdnrk1JODVJY6Q0PbgzRt/jn3nAJup27TcHejxFQ==
X-Received: by 2002:ac2:4897:0:b0:513:26e7:43ff with SMTP id x23-20020ac24897000000b0051326e743ffmr1649301lfc.32.1709315515581;
        Fri, 01 Mar 2024 09:51:55 -0800 (PST)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id v7-20020ac25927000000b0051313b48db9sm684298lfi.158.2024.03.01.09.51.55
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Mar 2024 09:51:55 -0800 (PST)
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d269b2ff48so26084781fa.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 01 Mar 2024 09:51:55 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVuML4owWLvTbN9p/Id5YQG+h75vMvkbzP+AjtivzQvqh5osrvugmcYhzP7y/hL8fX/L+PiZyokeBXPd8GRc3kzVco0q83Q8ljiCViA6w==
X-Received: by 2002:a17:906:5a9a:b0:a44:48db:9060 with SMTP id
 l26-20020a1709065a9a00b00a4448db9060mr1596114ejq.19.1709315494643; Fri, 01
 Mar 2024 09:51:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240301-slab-memcg-v1-0-359328a46596@suse.cz> <20240301-slab-memcg-v1-4-359328a46596@suse.cz>
In-Reply-To: <20240301-slab-memcg-v1-4-359328a46596@suse.cz>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 1 Mar 2024 09:51:18 -0800
X-Gmail-Original-Message-ID: <CAHk-=whgFtbTxCAg2CWQtDj7n6CEyzvdV1wcCj2qpMfpw0=m1A@mail.gmail.com>
Message-ID: <CAHk-=whgFtbTxCAg2CWQtDj7n6CEyzvdV1wcCj2qpMfpw0=m1A@mail.gmail.com>
Subject: Re: [PATCH RFC 4/4] UNFINISHED mm, fs: use kmem_cache_charge() in path_openat()
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Jeff Layton <jlayton@kernel.org>, 
	Chuck Lever <chuck.lever@oracle.com>, Kees Cook <kees@kernel.org>, 
	Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, 
	Joonsoo Kim <iamjoonsoo.kim@lge.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Shakeel Butt <shakeelb@google.com>, Muchun Song <muchun.song@linux.dev>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 1 Mar 2024 at 09:07, Vlastimil Babka <vbabka@suse.cz> wrote:
>
> This is just an example of using the kmem_cache_charge() API.  I think
> it's placed in a place that's applicable for Linus's example [1]
> although he mentions do_dentry_open() - I have followed from strace()
> showing openat(2) to path_openat() doing the alloc_empty_file().

Thanks. This is not the right patch,  but yes, patches 1-3 look very nice to me.

> The idea is that filp_cachep stops being SLAB_ACCOUNT. Allocations that
> want to be accounted immediately can use GFP_KERNEL_ACCOUNT. I did that
> in alloc_empty_file_noaccount() (despite the contradictory name but the
> noaccount refers to something else, right?) as IIUC it's about
> kernel-internal opens.

Yeah, the "noaccount" function is about not accounting it towards nr_files.

That said, I don't think it necessarily needs to do the memory
accounting either - it's literally for cases where we're never going
to install the file descriptor in any user space.

Your change to use GFP_KERNEL_ACCOUNT isn't exactly wrong, but I don't
think it's really the right thing either, because

> Why is this unfinished:
>
> - there are other callers of alloc_empty_file() which I didn't adjust so
>   they simply became memcg-unaccounted. I haven't investigated for which
>   ones it would make also sense to separate the allocation and accounting.
>   Maybe alloc_empty_file() would need to get a parameter to control
>   this.

Right. I think the natural and logical way to deal with this is to
just say "we account when we add the file to the fdtable".

IOW, just have fd_install() do it. That's the really natural point,
and also makes it very logical why alloc_empty_file_noaccount()
wouldn't need to do the GFP_KERNEL_ACCOUNT.

> - I don't know how to properly unwind the accounting failure case. It
>   seems like a new case because when we succeed the open, there's no
>   further error path at least in path_openat().

Yeah, let me think about this part. Becasue fd_install() is the right
point, but that too does not really allow for error handling.

Yes, we could close things and fail it, but it really is much too late
at this point.

What I *think* I'd want for this case is

 (a) allow the accounting to go over by a bit

 (b) make sure there's a cheap way to ask (before) about "did we go
over the limit"

IOW, the accounting never needed to be byte-accurate to begin with,
and making it fail (cheaply and early) on the next file allocation is
fine.

Just make it really cheap. Can we do that?

For example, maybe don't bother with the whole "bytes and pages"
stuff. Just a simple "are we more than one page over?" kind of
question. Without the 'stock_lock' mess for sub-page bytes etc

How would that look? Would it result in something that can be done
cheaply without locking and atomics and without excessive pointer
indirection through many levels of memcg data structures?

             Linus

