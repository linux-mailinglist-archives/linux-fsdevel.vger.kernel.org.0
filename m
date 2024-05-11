Return-Path: <linux-fsdevel+bounces-19294-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA198C2F29
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 May 2024 04:54:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F103F1F22826
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 May 2024 02:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 417E122626;
	Sat, 11 May 2024 02:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Elj7JVjj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8D23BB21
	for <linux-fsdevel@vger.kernel.org>; Sat, 11 May 2024 02:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715396052; cv=none; b=kHL0axnfXIQM5v0cO+bPyuADrP8wuOBILxbiR01d8JKIXb+GN6hEswfLYJfAoEcILDOHtDRUWI+lvhr3GDuNqMIrlLpvh0C4CLXrmhYMBhQUQl4b67tBqEGLWfaePPRKh2g3R/gi9VOp6nVLl+hm0mpZ4jXE6xf5ot3CyoqVi9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715396052; c=relaxed/simple;
	bh=id44E801zgAH3sN0vJLEImYtE0eEyuh46SWZ1bDO6s0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T/duXAwXeE7UGfz3XGKNsdkzccqU+RuYKvelQmdILMy6Awv0vF5iI1QpOHVypNdFb0uIENKcA1p3ZI4Kn0uA+N6pmGxfbZfVPq5zvUqqO7+QyYHlSfWD5crqmsRuLntJqxraP0I9WRsv7qU4u4qAm+xqlqYbPyFu9r4TGk7fWtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Elj7JVjj; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2e5218112a6so16045781fa.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 May 2024 19:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1715396048; x=1716000848; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uJGkHmSHocvGMhcEph7Jgp+kV1solT4ESqwFZxa39oI=;
        b=Elj7JVjj94LZF+Kl+l6fHEoypPg3kLmQouNTnxvT8m7g507my2W8/tB7QcIamvZk2B
         UFSkpRGVOSuPnGGKwJHNYls0uuOkDBDJ462UaL+euDvzLtykqvS5CmxpgP37/2vyX5w9
         3U4lG5BII7AJeAWsOhCigSOwSdT9LFmfy9Zk0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715396048; x=1716000848;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uJGkHmSHocvGMhcEph7Jgp+kV1solT4ESqwFZxa39oI=;
        b=WkRyxVQtb7UZjnQ4CloCbm3F7rZSakwSocvYB1igeb96W4jknkBNadCyls8veFm7M6
         Vf1yafD+oqzE6E1+RgKavNYAme3Y9NpYJyqMQadfzIdKfkEzgDYSjruTJiu4Oy+mJnw7
         26H1UUHVQ57ZgSq1TQ2lWS9ZIRqyBSQPhjuxPQr31K88E29GaSb0LJRlBFlh4ITkeAO4
         06Q6D4VHfDgvio8tw40IYlJMArEVFZKbfRjhz9xcLfuumDtAdjAcYYHrQORA/jXEz1Qa
         OoRmSMsqJh6bdkzx7mWKMNV0Iq6GRC7qG5l86AViHnjGK0J///CTl0h+PgORP8SzZBcc
         R4eA==
X-Forwarded-Encrypted: i=1; AJvYcCXL0VX4Bv15XK6//6QKhCrNPhsjLe63CpLt6/+QV2YDe5OEFG+qz+G9bq+w/gMxZk0nnmKAA0wkcK2MdnKpujfzkPO9VEjbRB2aR9JiYQ==
X-Gm-Message-State: AOJu0Yzdikopn/GhRMizkYY0ezvVDDPlIo/N9DooKEgAMnmUCIoU9TLR
	zzfdeGrdEGaC34+CZD8Id563wuMxkhAdgq/d0F8flsKywHBs5FP0ZRNaFx+76+ukNMfu0Mh64Ur
	bkz821w==
X-Google-Smtp-Source: AGHT+IGqywU2s5QY7c/0autAJnHK8QLmHcxKHj8lf8raWCzy7inRFzvdlMjp314r+ybyrOFfbzcbmQ==
X-Received: by 2002:a05:6512:4016:b0:51b:5490:1b3a with SMTP id 2adb3069b0e04-522105792ebmr3850374e87.53.1715396048192;
        Fri, 10 May 2024 19:54:08 -0700 (PDT)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com. [209.85.221.42])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5733c322ad9sm2601088a12.81.2024.05.10.19.54.06
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 May 2024 19:54:07 -0700 (PDT)
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-34dc129accaso1879768f8f.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 May 2024 19:54:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVi9ekCobmPhV6YK38lnvWV5h8wrFsfNRWm+T7YNtHzhrGiNWxw1kWYsb42FhO0gCPguFLPKROR7wb45GHGWTCQFNGlIdKrhFyPHvUcbA==
X-Received: by 2002:adf:eb12:0:b0:347:9bec:9ba3 with SMTP id
 ffacd0b85a97d-3504aa64997mr3112605f8f.66.1715396046498; Fri, 10 May 2024
 19:54:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240511022729.35144-1-laoar.shao@gmail.com>
In-Reply-To: <20240511022729.35144-1-laoar.shao@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 10 May 2024 19:53:49 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjs8MYigx695jk4dvF2vVPQa92K9fW_e6Li-Czt=wEGYw@mail.gmail.com>
Message-ID: <CAHk-=wjs8MYigx695jk4dvF2vVPQa92K9fW_e6Li-Czt=wEGYw@mail.gmail.com>
Subject: Re: [RFC PATCH] fs: dcache: Delete the associated dentry when
 deleting a file
To: Yafang Shao <laoar.shao@gmail.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, Wangkai <wangkai86@huawei.com>, 
	Colin Walters <walters@verbum.org>, Waiman Long <longman@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 10 May 2024 at 19:28, Yafang Shao <laoar.shao@gmail.com> wrote:
>
> We've devised a solution to address both issues by deleting associated
> dentry when removing a file.

This patch is buggy. You are modifying d_flags outside the locked region.

So at a minimum, the DCACHE_FILE_DELETED bit setting would need to
just go into the

        if (dentry->d_lockref.count == 1) {

side of the conditional, since the other side of that conditional
already unhashes the dentry which makes this all moot anyway.

That said, I think it's buggy in another way too: what if somebody
else looks up the dentry before it actually gets unhashed? Then you
have another ref to it, and the dentry might live long enough that it
then gets re-used for a newly created file (which is why we have those
negative dentries in the first place).

So you'd have to clear the DCACHE_FILE_DELETED if the dentry is then
made live by a file creation or rename or whatever.

So that d_flags thing is actually pretty complicated.

But since you made all this unconditional anyway, I think having a new
dentry flag is unnecessary in the first place, and I suspect you are
better off just unhashing the dentry unconditionally instead.

IOW, I think the simpler patch is likely just something like this:

  --- a/fs/dcache.c
  +++ b/fs/dcache.c
  @@ -2381,6 +2381,7 @@ void d_delete(struct dentry * dentry)

        spin_lock(&inode->i_lock);
        spin_lock(&dentry->d_lock);
  +     __d_drop(dentry);
        /*
         * Are we the only user?
         */
  @@ -2388,7 +2389,6 @@ void d_delete(struct dentry * dentry)
                dentry->d_flags &= ~DCACHE_CANT_MOUNT;
                dentry_unlink_inode(dentry);
        } else {
  -             __d_drop(dentry);
                spin_unlock(&dentry->d_lock);
                spin_unlock(&inode->i_lock);
        }

although I think Al needs to ACK this, and I suspect that unhashing
the dentry also makes that

                dentry->d_flags &= ~DCACHE_CANT_MOUNT;

pointless (because the dentry won't be reused, so DCACHE_CANT_MOUNT
just won't matter).

I do worry that there are loads that actually love our current
behavior, but maybe it's worth doing the simple unconditional "make
d_delete() always unhash" and only worry about whether that causes
performance problems for people who commonly create a new file in its
place when we get such a report.

IOW, the more complex thing might be to actually take other behavior
into account (eg "do we have so many negative dentries that we really
don't want to create new ones").

Al - can you please step in and tell us what else I've missed, and why
my suggested version of the patch is also broken garbage?

             Linus

