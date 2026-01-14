Return-Path: <linux-fsdevel+bounces-73762-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E97DD1FBFD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 16:30:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 27E683112E6E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 15:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19EAA399035;
	Wed, 14 Jan 2026 15:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="P7VmpZYe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE8739524D
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jan 2026 15:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768404199; cv=none; b=PyR4a203Oee4mkU2Rki/3HmCBd8ZIzdRq2MvQq+FPqz0tjObThUGnMprwePyp8Iv75WWlimrNGkLLuLP4akjb75loKdDuL0iSFibsc+oabsM8bJ3Sg+e4hCC0bhgtVw1ztju7gbmIqJ7c3VZCLCIq8mRGsN9BZn/ohW1V6znXPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768404199; c=relaxed/simple;
	bh=LvIHDIw3tGVPhlqpQEplDDfrrBikoo5Yhft+fju9D8Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hbUCEe0L2rPqH7R2dswz4M1zl6syqeGfUMssRYCEOwLnisgh41ep9kecv3OV8EjY4lk2JIgnaJRzz/n9Rn3TGUwGxgHPpODy2JUJFakAxlgNFxOL3KYPcIYeDaducG+osnv78MylQ7j6khzy3QfqGyTZ6mz1UhioJmttIihloK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=P7VmpZYe; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4ee257e56aaso11287161cf.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jan 2026 07:23:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1768404196; x=1769008996; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oyW+GT5tc517r9Y1yj/TSxRQgH25fLsbDOzF6uKatGQ=;
        b=P7VmpZYezNggeYK8LagcTLmGSFvvST/nTM0Zv+Zsm0EjsaUnAVjlEtFfnMH0x9sGYP
         oZmDcYMGOCEKJJt+wGNxsHbfhGgTBDIPIbksxFMf7iL2oBbtktpaNYs+cfpQgVHVR6Ae
         FIOdtXyW/9F76mAgInJmO/1gqPkTB5K64CysQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768404196; x=1769008996;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oyW+GT5tc517r9Y1yj/TSxRQgH25fLsbDOzF6uKatGQ=;
        b=hYAip4tPl/+UqU32604i5fk9ULX877MmFV73E8TBeOvlPL4WJsWuf6YbRe0ODZwQNO
         Yz+m/QoflcRX/1ZhqT98vMFRJ91pXPtlQH7iCfO2VLMIq0sHMTCLdNmJOhoLKQVGSoUs
         /c7sLZ77v+h9YhKLPKBNpLnjSPNTL+OHVAzQ+Ag8gUeZdT1149+Rkg3+RTuJtcy5AYAK
         Z5QhzFGG++sktWviSvv1jF8E/AVh1EOnXqzzfcMuVg4ULuZ7lhJbv2l54LwzJ7RKhU+/
         uZxdGdGNZ55n7xtdV043sqRMnbgy9aOqZZcjmgmdaOh+RJmW8PYPxR6AE+YwfpO5T4zG
         UP6w==
X-Forwarded-Encrypted: i=1; AJvYcCUkGqkCkfhySRmPT8JSLlvteH8WqKw+rdTbRAeOe5zeEydkxejW/Molr//shNpx8gvDpgp97QB8yBOB+Jfd@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5jSZ4uN9rsL3g95Su43R4yrRTarZjqqczcDp9YVfZv9UeppqE
	e5sID6x92XhGLRmzcFIAV9Jz0jotxmA3bYrWZRYzGK9wds+2fPpfcn9WnqMAzOiLCF2ea6rd8Rj
	2XMmsFJXlCB/m6tOdtGtevL+rbsuNK2h+56e3/Bla+Q==
X-Gm-Gg: AY/fxX5RFz79F0XdjEJqcr7xhKxY/eMlGoCuY6rnx3VNgmP63jjiN+Xgk3V7vDPQEvs
	WBRVIteFYNUji5dsMnuYvFefb3ZrtmtuAsNtb/zCwqjSy0DL0P6URuaipmnWA4it20mdB8Ji4Oc
	uM6fqulbR6DZITDZgjnNWLt4hbJdSq/6/Aag9fjNlkGqmmOXfwTIXemTh9PORxBLvwu6DReIYsr
	RrxGPhxpf/1xl2uw3L5dl6ic0pFva/kL27paJiLiyf9b6Mu9SnK7vh83iosOh9nqLGG/Ps=
X-Received: by 2002:ac8:7d94:0:b0:4f1:8bfd:bdc0 with SMTP id
 d75a77b69052e-501397f7cf8mr97081381cf.39.1768404196094; Wed, 14 Jan 2026
 07:23:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJfpegunwB28WKqxNWCQyd5zrMfSif_YmBFp+_m-ZsDap9+G7Q@mail.gmail.com>
 <CAHk-=wht097GMgEuH870PU4dMfBCinZ5_qvxpqK2Q9PP=QRdTA@mail.gmail.com>
 <20251206014242.GO1712166@ZenIV> <CAHk-=wg8KJbcPuoRBFmD9c42awaeb4anXsC4evEOj0_QVKg0QQ@mail.gmail.com>
 <20251206022826.GP1712166@ZenIV> <CAHk-=wgBU3MQniRBmbKi2yj0fRrWQjViViNvNJ6sqjEB-3r4XA@mail.gmail.com>
 <20251206035403.GR1712166@ZenIV> <20251206042242.GS1712166@ZenIV>
In-Reply-To: <20251206042242.GS1712166@ZenIV>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 14 Jan 2026 16:23:04 +0100
X-Gm-Features: AZwV_QhDobZRTM8acMVUQadhk0ivZk3t5rYM8YerLOR7FIvYElOEjYZWOyKIf4g
Message-ID: <CAJfpegtsDZW7v=YDhs+gPq25G+QOh-5mjiaXT04DDW=iU+R75A@mail.gmail.com>
Subject: Re: [GIT PULL] fuse update for 6.19
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 6 Dec 2025 at 05:22, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Sat, Dec 06, 2025 at 03:54:03AM +0000, Al Viro wrote:
> > On Fri, Dec 05, 2025 at 07:29:13PM -0800, Linus Torvalds wrote:
> > > On Fri, 5 Dec 2025 at 18:28, Al Viro <viro@zeniv.linux.org.uk> wrote:
> > > >
> > > > Sure, ->d_prune() would take it out of the rbtree, but what if it hits
> > >
> > > Ahh.
> > >
> > > Maybe increase the d_count before releasing that rbtree lock?
> > >
> > > Or yeah, maybe moving it to d_release. Miklos?
> >
> > Moving it to ->d_release() would be my preference, TBH.  Then
> > we could simply dget() the sucker under the lock and follow
> > that with existing dput_to_list() after dropping the lock...
>
> s/dget/grab ->d_lock, increment ->d_count if not negative,
> drop ->d_lock/ - we need to deal with the possibility of
> the victim just going into __dentry_kill() as we find it.
>
> And yes, it would be better off with something like
> lockref_get_if_zero(struct lockref *lockref)
> {
>         bool retval = false;
>         CMPXCHG_LOOP(
>                 new.count++;
>                 if (old_count != 0)
>                         return false;
>         ,
>                 return true;
>         );
>         spin_lock(&lockref->lock);
>         if (lockref->count == 0)
>                 lockref->count = 1;
>                 retval = true;
>         }
>         spin_unlock(&lockref->lock);
>         return retval;
> }
>
> with
>                 while (node) {
>                         fd = rb_entry(node, struct fuse_dentry, node);
>                         if (!time_after64(get_jiffies_64(), fd->time))
>                                 break;
>                         rb_erase(&fd->node, &dentry_hash[i].tree);
>                         RB_CLEAR_NODE(&fd->node);
>                         if (lockref_get_if_zero(&dentry->d_lockref))
>                                 dput_to_list(dentry);
>                         if (need_resched()) {
>                                 spin_unlock(&dentry_hash[i].lock);
>                                 schedule();
>                                 spin_lock(&dentry_hash[i].lock);
>                         }
>                         node = rb_first(&dentry_hash[i].tree);
>                 }

Posted a short patchset fixing this.

I really think there's no point in doing the get-ref, drop-ref dance.
 Retrieving the dentry from any source will require locking and that
needs to nest d_lock with or without the refcount manipulation.

So I kept the d_dispose_if_unused() API, but added a note to the
function doc that additional locking is necessary to prevent eviction.

Thanks,
Miklos

