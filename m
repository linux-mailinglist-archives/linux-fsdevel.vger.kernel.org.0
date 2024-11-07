Return-Path: <linux-fsdevel+bounces-33960-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92FDB9C0F70
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 20:55:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6FB81C229BF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 19:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2EFA217F3F;
	Thu,  7 Nov 2024 19:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="A/rcCLr0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6E6217F32
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 Nov 2024 19:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731009298; cv=none; b=I7XhfEA9wa65lQ1VlZvf2MiXD3H7rXMVNGAW/lPUgOzf8V/sZVlZqekuowL1Mwm/H2/wu0urhvNy53qNf1r/EU+OHV8zGJuUbMflpJRO9MXtireLbGcxm54j8DdLFkeMYoTKJzMP5LJsrOYISfTqsQSIcfTBXfAMCVHE3l3myuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731009298; c=relaxed/simple;
	bh=8jlKfNle1PirLOA1rXtML1lO7aicmkimyXsQSkhvFGw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NKznITNiQ7d/tIxzNa8KRMcl2hsvkvJ0dFgpDgMAjihglVS9jlm9rfjVNOAuVGx7aFh7ItyJivAIuJQMFVwsxJxkSJeUT2AIwaXkcEnnQ1UrGMa/igQQMWv6g2jQrz4wbnOo0sbbyvVJ15Taeg3JLwva0+DtKZdM+kW0uY7CFMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=A/rcCLr0; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a9ed0ec0e92so171568466b.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 Nov 2024 11:54:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1731009294; x=1731614094; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fis5P5M3PjXfHUQOqy1WBoPagUO8hb9u14cCMIgvOw0=;
        b=A/rcCLr0ZJDgqTqH09aZ4DknMmbFkcWDA6JrrgedN//tHq7pqC3n0Gy9CdVe0NNSYI
         MantkFYhdi9eRkD+ASFMsDqN/IPiMRK+RcEUiTFk1IIyPtYXZhhgariDbYLIfr46M/rA
         2vLpgPGDzE7hKtF8FCeHK8zZzPMoy4Un4dVtA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731009294; x=1731614094;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fis5P5M3PjXfHUQOqy1WBoPagUO8hb9u14cCMIgvOw0=;
        b=MJFjMp1fthBfVZN4VbFs+LzxO/O8lLvISNaUhkLR8u5dq8qvMdA1ZELwnV/w9jB92T
         atg9k8ZIDMhCaRVenKG+fmkwfi0RbiWKRmpjblvnoveGEai9LIxglOIqO3Iu0NkXUx7R
         us9Be+W17u1dc0VmGBrFSwNDnEeE8MM3HyapR5hmbCcyrM8Uc0g7j0rOpbrtgck9HSoU
         jKsVqDdXjpJjvc7lPmAWx6XV5IK1pEdb1EsdQfplrqwlwR85PAAnsI2qpRKpRAJJfn+a
         aRKXNHJviXGfFErbATvGEESXf/mlNm4JJglAoxe9sI5g+ozdsvlNYJVKyckuWoyoJeCD
         BOnQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0TGLfRlgH3rPQFUEXaTvr9iFVxdjsWJCfxDs9FEkKwMjf0c6VetVfz1ZJax8DZxybDEWRiPoOYKoU+cdI@vger.kernel.org
X-Gm-Message-State: AOJu0YwKeCpkNakzEFOYy6lJAj5Ab5IUbQnJnLjY00teMTk7oCsdbbQ7
	+4JsHY/mc3Pu/xIXV4rvyPj2kv8B4HYJRLvd4KKMtjnLSjG0Zk3KwGhIzshPIEhjXT0GLbxqe8U
	aPKOyYw==
X-Google-Smtp-Source: AGHT+IEmuj5pdiENIW0IsFasNKte57kWSsdWUd8Dk87J7Xvof5NYR2GfoQPmSWZneYJt2Q/qsoSyrg==
X-Received: by 2002:a17:907:7243:b0:a99:d797:c132 with SMTP id a640c23a62f3a-a9eefeeca0emr7513866b.16.1731009293876;
        Thu, 07 Nov 2024 11:54:53 -0800 (PST)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee1aa544asm131587966b.167.2024.11.07.11.54.53
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Nov 2024 11:54:53 -0800 (PST)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a9a628b68a7so221978866b.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 Nov 2024 11:54:53 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWrv/E4Z9i0UuuMzq4C3lGdqTvLBAdsCoKe3Rl/HD8WzGbnW6OQdq8VkNVca4YVw76Uuo9G16HdtP3uXD6e@vger.kernel.org
X-Received: by 2002:a17:907:7292:b0:a9e:1fc7:fc11 with SMTP id
 a640c23a62f3a-a9eeffeffb8mr5270666b.40.1731009292890; Thu, 07 Nov 2024
 11:54:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=whJgRDtxTudTQ9HV8BFw5-bBsu+c8Ouwd_PrPqPB6_KEQ@mail.gmail.com>
 <20241031-klaglos-geldmangel-c0e7775d42a7@brauner> <CAHk-=wjwNkQXLvAM_CKn2YwrCk8m4ScuuhDv2Jzr7YPmB8BOEA@mail.gmail.com>
 <CAHk-=wiKyMzE26G7KMa_D1KXa6hCPu5+3ZEPUN0zB613kc5g4Q@mail.gmail.com> <CAHk-=wiB6vJNexDzBhc3xEwPTJ8oYURvcRLsRKDNNDeFTSTORg@mail.gmail.com>
In-Reply-To: <CAHk-=wiB6vJNexDzBhc3xEwPTJ8oYURvcRLsRKDNNDeFTSTORg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 7 Nov 2024 09:54:36 -1000
X-Gmail-Original-Message-ID: <CAHk-=whSzc75TLLPWskV0xuaHR4tpWBr=LduqhcCFr4kCmme_w@mail.gmail.com>
Message-ID: <CAHk-=whSzc75TLLPWskV0xuaHR4tpWBr=LduqhcCFr4kCmme_w@mail.gmail.com>
Subject: Re: generic_permission() optimization
To: Christian Brauner <brauner@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

So I realize that Christian already applied my patch, but I'm coming
back to this because I figured out why it doesn't work as well as I
thought it would..

On Thu, 31 Oct 2024 at 12:31, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Added some stats, and on my load (reading email in the web browser,
> some xterms and running an allmodconfig kernel build), I get about a
> 45% hit-rate for the fast-case: out of 44M calls to
> generic_permission(), about 20M hit the fast-case path.

So the 45% hit rate really bothered me, because on the load I was
testing I really thought it should be 100%.

And in fact, sometimes it *was* 100% when I did profiles, and I never
saw the slow case at all. So I saw that odd bimodal behavior where
sometimes about half the accesses went through the slow path, and
sometimes none of them did.

It took me way too long to realize why that was the case:  the quick
"do we have ACL's" test works wonderfully well when the ACL
information is cached, but the cached case isn't always filled in.

For some unfathomable reason I just mindlessly thought that "if the
ACL info isn't filled in, and we will go to the slow case, it now
*will* be filled in, so next time around we'll have it in the cache".

But that was just silly of me. We may never call "check_acl()" at all,
because if we do the lookup as the owner, we never even bother to look
up any ACL information:

        /* Are we the owner? If so, ACL's don't matter */

So next time around, the ACL info *still* won't be filled in, and so
we *still* won't take the fastpath.

End result: that patch is not nearly as effective as I would have
liked. Yes, it actually gets reasonable hit-rates, but the
ACL_NOT_CACHED state ends up being a lot stickier than my original
mental model incorrectly throught it would be.

So the "45% hit rate" was actually on all the successful quick cases
for system directory traversal where I was looking at files as a
non-owner, but all my *own* files wouldn't hit the fast case.

So that old optimization where we don't even bother looking up ACL's
if we are the owner is actually hindering the new optimization from
being effective.

Very annoying. The "don't bother with ACL's if we are the owner" is
definitely a good thing, so I don't want to disable one optimization
just to enable another one.

(Side note: the reason I sometimes saw 100% hit rates on my test was
that a "make install" as root on my kernel tree *would* populate the
ACL caches because now that tree was looked at by a non-owner).

I'll think about this some more. And maybe somebody smarter than me
sees a good solution before I do.

                  Linus

