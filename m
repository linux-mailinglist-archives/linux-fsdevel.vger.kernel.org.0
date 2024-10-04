Return-Path: <linux-fsdevel+bounces-30959-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 016E7990163
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 12:34:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20B041C221AC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 10:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21CF4155C98;
	Fri,  4 Oct 2024 10:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jgol1Z69"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35BE146A6B
	for <linux-fsdevel@vger.kernel.org>; Fri,  4 Oct 2024 10:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728037958; cv=none; b=IfFF64xW4IqMk+JR8++HZ+ocqoqIqdxo/qBDKc7ujnQpxXYlI8v0r3+sxyhSJbwoOuM3Np4VgxOaMeqjN7tCA8qT/uDd8l0JkGdWIzgw4VaMJZjCO8hHuPT35MsUUM88yev9YGwhmF6bJABPtm1wDV38zSvVxn718cPvB/ZMwsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728037958; c=relaxed/simple;
	bh=p4+0Bsu5Ye2C+58U3fZq6HpxRm5PScajGWHa32SPTpQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CnEEZHVHWYE76S20TFmsDppjlQHlq0M7mX4KlbS+x5aYG4SHZ6EA8eAIkJoePPWnfGr1Ok7XpMHzJIllM6QB2giNM+TGQhVDHeYPukRlbbsx4dX2LlZNl/0viE4RFkpXVUqBVSAz3WJbJBGeCiq2lOvmpqNXWVLBzzXOogek7CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jgol1Z69; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e25d11cc9f0so1582244276.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 04 Oct 2024 03:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728037955; x=1728642755; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9vMiOudyD+AU2THZNyhvEo2X6Dz8ozteMJBeRoB0YOE=;
        b=Jgol1Z69BxLKz0N7GYHxiuESJC2vMstPRUJVvOMchAbwn0bxHGxHPSLKhWvP+KWj+b
         zqAcwze/RK6K979QQW9e+qnN9A3yNk8ss+/Y8xzCijgIBCuzc1Ds2r9C8cTcgA7Zpaup
         Hpc+GXSkAz0CiqUsz9jtXCfT5lk0C8dzF8+rsIMzn+0+2BvZ5MuHmu5JUzx2Wym6DeWJ
         JrfMxXn0ooy7qGPo7AtjGrUVgOPWaF0v9fIYzeFeoxe7dOaDSNflUHi29dYyrQWcGw0S
         Xvee62i8vaBDjO9CYKNqJb3wNevOy4A26gcK/H0npb9fOI+AnzQ/kXSqA28MuKN0OZlc
         GP2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728037955; x=1728642755;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9vMiOudyD+AU2THZNyhvEo2X6Dz8ozteMJBeRoB0YOE=;
        b=Nf0rbplIzWvWzxGLb4B74orlEX557WjNOps9vQspfp1m3vMS6P/Y9ekOGshZj29swy
         PM6L6Wj6r5NODsinFBwz1hnzTgMRf6KdBWHl9M1JhyQNX9RdeFLQLXCHbAWHGLf+SXtD
         QAYh9GSOgckRkyVMkUfn0sVV/hVOyoDLudN7gyrydgr3n17IfRsyHDCzG92Z7VFgZFIP
         WcZF56gZaF7L47tisrp561UFGCmKCuviyH96TqT83QHB49wI/rDQ1dKTBn6gEtAbkOjx
         YuP2Q3UtQK9pciQpnhHDvnfs9lXajLMBO+cmtago2COriORV7LaxR42GnMuH18BvzYrX
         OkMg==
X-Gm-Message-State: AOJu0YydL63mZvlPWL+1XZCI8AXz/ZdIgvWlLY3vm5hbgqzfkx3OzqWx
	1bG7/vK7ZnrEiN0ohRwYnWuWZthGNBDMSc1/HtSS0pLMLAZ86gtrVgX6A0V7ugX2Jgqog46VGDL
	tjJ4Qsi24kS0LxgVEM3snzP6U+6Q=
X-Google-Smtp-Source: AGHT+IEYOwjqpbIhyPx7jGr6m+TXqBRjUwKldJdmOWddZKry3sp0fPuswqr4LOMCpp4IYP5RVMa9K2QKa8E6kxBO5tc=
X-Received: by 2002:a05:6902:2102:b0:e26:122d:907 with SMTP id
 3f1490d57ef6-e28936d6362mr1346570276.24.1728037955388; Fri, 04 Oct 2024
 03:32:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241003234534.GM4017910@ZenIV>
In-Reply-To: <20241003234534.GM4017910@ZenIV>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 4 Oct 2024 12:32:23 +0200
Message-ID: <CAOQ4uxgJchTvdMAvpS6X_ioEYLzU8ZoHVThsNeWB_eaBbSTgOg@mail.gmail.com>
Subject: Re: [RFC][PATCHES] struct fderr
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, 
	Jan Kara <jack@suse.cz>, Miklos Szeredi <miklos@szeredi.hu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 4, 2024 at 1:45=E2=80=AFAM Al Viro <viro@zeniv.linux.org.uk> wr=
ote:
>
>         overlayfs uses struct fd for the things where it does not quite
> fit.  There we want not "file reference or nothing" - it's "file referenc=
e
> or an error".  For pointers we can do that by use of ERR_PTR(); strictly
> speaking, that's an abuse of C pointers, but the kernel does make sure
> that the uppermost page worth of virtual addresses never gets mapped
> and no architecture we care about has those as trap representations.
> It might be possible to use the same trick for struct fd; however, for
> most of the regular struct fd users that would be a pointless headache -
> it would pessimize the code generation for no real benefit.  I considered
> a possibility of using represenation of ERR_PTR(-EBADF) for empty struct
> fd, but that's far from being consistent among the struct fd users and
> that ends up with bad code generation even for the users that want to
> treat empty as "fail with -EBADF".
>
>         It's better to introduce a separate type, say, struct fderr.
> Representable values:
>         * borrowed file reference (address of struct file instance)
>         * cloned file reference (address of struct file instance)
>         * error (a small negative integer).
>
>         With sane constructors we get rid of the field-by-field mess in
> ovl_real_fdget{,_meta}() and have them serve as initializers, always
> returning a valid struct fderr value.
>
>         That results in mostly sane code; however, there are several
> places where we run into an unpleasant problem - the intended scope
> is nested inside inode_lock()/inode_unlock(), with problematic gotos.
>
>         Possible solutions:
> 1) turn inode_lock() into guard-based thing.  No, with the side of
> "fuck, no".  guard() has its uses, but
>         * the area covered by it should be _very_ easy to see
>         * it should not be mixed with gotos, now *OR* later, so
> any subsequent changes in the area should remember not to use those.
>         * it should never fall into hands of Markus-level entities.
> inode_lock fails all those; guard-based variant _will_ be abstracted
> away by well-meaning folks, and it will start spreading.  And existing
> users are often long, have non-trivial amounts of goto-based cleanups
> in them and lifetimes of the objects involved are not particularly
> easy to convert to __cleanup-based variants (to put it very mildly).
>
> We might eventually need to reconsider that, but for now the only sane
> policy is "no guard-based variants of VFS locks".
>
> 2) turn the scopes into explicit compound statements.
>
> 3) take them into helper functions.

4) Get rid of the cloned real file references

I was going to explain what I mean, but it was easier to write patches:

https://lore.kernel.org/linux-fsdevel/20241004102342.179434-1-amir73il@gmai=
l.com/

(also at https://github.com/amir73il/linux/commits/ovl_real_file/)

After my patches, there is no longer any use for CLONED_FDERR()
in overlayfs code and there is no need for guarded real fd in
overlayfs file methods, so the value of this work for overlayfs is
reduced.

I have no objection to the fderr abstraction, but I don't think
that it will improve overlayfs code after my change. WDYT?

Thanks,
Amir.

