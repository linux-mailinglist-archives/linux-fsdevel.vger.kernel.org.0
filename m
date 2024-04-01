Return-Path: <linux-fsdevel+bounces-15846-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E91AC89480B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Apr 2024 01:52:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EA0D1C214E6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Apr 2024 23:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C2C56760;
	Mon,  1 Apr 2024 23:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="A2zGvvXj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B375A57306
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Apr 2024 23:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712015500; cv=none; b=Sk7Jje2byhbwyT3o3OG9VktuE5inaR6NBolAdHBcxQLofEwawM7k62LlP/AaBMQxBgVhhu6srqh2CNzJKH7eTAEg8fUnbNC0SU18QxMT369JZWSdAY0YDUBMNB9HzfrdcTrL31LNG2NiXNa/mh1EFqbKPhiLuIECUrNY1xZA8V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712015500; c=relaxed/simple;
	bh=NUXcjWxUuX7vkcNh1FOq4RbtcBJqY+Ke+I8InIKf/1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=swoz5/ugFVx4djdBXHShyNgIFqr8SwOxT3Z3q7Vsy66qjMKs3GnyiDKueyBqJ7ZiHVdxJcOweHCF4AfvAns9q5x9GMkqwua7ZgXtSf6O6zVFQioDMwKiK7C/fj+0LiOMJDC7AqRm1B7TzCddZt/sA+RzvxhjKwLhlmVAwaJ46q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=A2zGvvXj; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6e6b22af648so3925433b3a.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Apr 2024 16:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1712015498; x=1712620298; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dypD05vqJscyZPep9612GerlkxZnPH5jtGNdecLNetI=;
        b=A2zGvvXjEOyZN35akshg2azFhQ+JwUHU06ivK7OwxrqgM/9iA36pwyCYF23YGSHXzD
         X/ojQam08ESyDyQe4wdROS0gJPdG3wiwvNi6rUUyyuizNWYvh64IQsk2pkhiEGw6Xsa8
         eEcuSRGyNgJXWddHTm1KiVsxbU06Ma+ccfRc43IHyHTrgSju4UVTUDV3Lzo/O6CoiTzt
         AI4B4ZMnZb/UfvwX/6Fas2Tp8GLIZmxZRZ4icsSryZSm4BwUnGxew21xoyKLIL7Prn0h
         Enm8k9soC3dxrC3ToYDj80YNziPx2xVkpc7KxeyVIfniAV5746tgxV1TtDQgE7eC4uv+
         29jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712015498; x=1712620298;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dypD05vqJscyZPep9612GerlkxZnPH5jtGNdecLNetI=;
        b=ZDUluBpDJckrnxnVXyKPAXMkZZQBOMK35EgSUjmUcaPRBg1byaLnm+IopjwGZWfq7R
         ntDXziD5Z1yIZUebJtHOjaYGRcC/m/iZGmvzdDBiS97c9KsvQH4sKFI1DbvmL+Md9HF9
         ARzxFTjna3TbeMZvNfcqBOkZAy6lU8cm4Ot2h5CW7ndt3mLCl0dlkecuab87ZlAeGKHZ
         J5OTLpbNEy3qLAkBpRy8eHkMwBdOqP+WPmG3MrB+3MlQJMB7FzLVInevTT2KvUz4Hx2R
         Zb/uvtJpWppFXsmIUTzf71ngSza90N4/xW+rDuTiSci9A72j8jdMFKwIGRr5v0YVbvFj
         Vsug==
X-Gm-Message-State: AOJu0YwW+MZYf6EMK5yUPQMGaLtoxq7D8fi2RXOqf7RHkLwuWo3f3M55
	LUNq0gJlOoRKw+e2HLyLuRTZsGl5ntVPZWdHgcXgpZPCwIrS4QWfR1Q7Rk+Ko1wI4FHfU5ZY4qC
	T
X-Google-Smtp-Source: AGHT+IGZWM6RbUAJs73ve/aEhrHEufUoGvtC8r07VVx4+r+LWiQp4KUWD7TJt4AWQs2ETh1tSb7iTA==
X-Received: by 2002:a17:902:e5d0:b0:1e0:c88f:654f with SMTP id u16-20020a170902e5d000b001e0c88f654fmr20043674plf.33.1712015497856;
        Mon, 01 Apr 2024 16:51:37 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-56-237.pa.nsw.optusnet.com.au. [49.181.56.237])
        by smtp.gmail.com with ESMTPSA id u1-20020a170902e5c100b001e0b5eee802sm9535093plf.123.2024.04.01.16.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 16:51:37 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rrRR8-000j3e-3B;
	Tue, 02 Apr 2024 10:51:35 +1100
Date: Tue, 2 Apr 2024 10:51:34 +1100
From: Dave Chinner <david@fromorbit.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: RFC: asserting an inode is locked
Message-ID: <ZgtIhg7iZ5v0bMpU@dread.disaster.area>
References: <ZgTL4jrUqIgCItx3@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZgTL4jrUqIgCItx3@casper.infradead.org>

On Thu, Mar 28, 2024 at 01:46:10AM +0000, Matthew Wilcox wrote:
> 
> I have this patch in my tree that I'm thinking about submitting:
> 
> +static inline void inode_assert_locked(const struct inode *inode)
> +{
> +       rwsem_assert_held(&inode->i_rwsem);
> +}
> +
> +static inline void inode_assert_locked_excl(const struct inode *inode)
> +{
> +       rwsem_assert_held_write(&inode->i_rwsem);
> +}
> 
> Then we can do a whole bunch of "replace crappy existing assertions with
> the shiny new ones".
> 
> @@ -2746,7 +2746,7 @@ struct dentry *lookup_one_len(const char *name, struct den
> try *base, int len)
>         struct qstr this;
>         int err;
> 
> -       WARN_ON_ONCE(!inode_is_locked(base->d_inode));
> +       inode_assert_locked(base->d_inode);
> 
> for example.
> 
> But the naming is confusing and I can't think of good names.
> 
> inode_lock() takes the lock exclusively, whereas inode_assert_locked()
> only checks that the lock is held.  ie 1-3 pass and 4 fails.
> 
> 1.	inode_lock(inode);		inode_assert_locked(inode);
> 2.	inode_lock_shared(inode);	inode_assert_locked(inode);
> 3.	inode_lock(inode);		inode_assert_locked_excl(inode);
> 4.	inode_lock_shared(inode);	inode_assert_locked_excl(inode);
> 
> I worry that this abstraction will cause people to write
> inode_assert_locked() when they really need to check
> inode_assert_locked_excl().  We already had/have this problem:
> https://lore.kernel.org/all/20230831101824.qdko4daizgh7phav@f/

One small mistake in the middle of the major inode mutex -> rwsem
conversion that has no actual side effects other than a debug check
not being as strict as it could have been.

That's simply not something we should even be concerned about, let
alone have to jump through hand-wringing hoops of concern about how
to code specifically to avoid. It's just not going to be a
significant ongoing issue.

> So how do we make it that people write the right one?
> Renaming inode_assert_locked() to inode_assert_locked_shared() isn't
> the answer because it checks that the lock is _at least_ shared, it
> might be held exclusively.

I think you're getting yourself tied in knots here. The reason for
holding the lock -shared- is to ensure that the structure is
essentially in a read-only state and there are no concurrent
modifications taking place on the data that the lock protects.

If the caller holds the lock in exclusive mode, then we also have a
guarantee that there are no concurrent modifications taking place
because we own the structure entirely and hence it's still safe to
access the structure through read-only paths.

For example, there are lots of cases in XFS where the same code is
run by both read-only lookup and modification paths (e.g. in-memory
extent btrees). The only execution context difference is the lookup
runs with shared locking and the modification runs with exclusive
locking. IOWs, we can't use "assert lock is shared" or "assert lock
is excl" only in this path as both locking contexts are valid.

IOWs, what we are checking with this rwsem_assert_held() check is
there are -no concurrent modifications possible- at this point in
time and that means the lock simply needs to be held and it doesn't
matter how it is held.

Put simply: inode_assert_locked() doesn't assert that the lock
must be hold in shared mode, it is asserting that there are no
concurrent modifications taking place whilst we are running this
code.

From that perspective, the current name makes perfect sense and it
does not need changing at all. :)

> Rename inode_assert_locked() to inode_assert_held()?  That might be
> enough of a disconnect that people would not make bad assumptions.
> I don't have a good answer here, or I'd send a patch to do that.
> Please suggest something ;-)

Document what it checks and the context in which it gets used. It is
a context specific check to ensure there are no concurrent
modifications taking place, not a check on the exact mode the lock
is held.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

