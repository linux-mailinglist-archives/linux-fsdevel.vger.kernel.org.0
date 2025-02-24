Return-Path: <linux-fsdevel+bounces-42410-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F545A4229E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 15:14:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 031D8189D4E7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 14:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6CCA154430;
	Mon, 24 Feb 2025 14:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="afE2I8IE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639C11369B6
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Feb 2025 14:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740406038; cv=none; b=eHPcIHuOIAgcEEwJT12D7PqenuX3zYmOmUoSJfSG3r1Cvq/kO7cW4jjqmFqVta1d1FKBuvgODmT0c7Zo9OJ0LJ8S8pKXGYKXL1oAa615rmoZiH6AJwfWiQtjMUvAy7QCI4BlozdRJMvYBm/CndppgbOj1YSE3Cmv2qIdlq6ys7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740406038; c=relaxed/simple;
	bh=kPpC/p0X4kDow8H58wZGIfgmU3maMWXOeIBh8Yo1yNM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KEpjyV2tNfaywT8jK+tYxt4mw7qA6k4PDGS1fs41QACOgECKLtqvH/Txs02PIA8tut0AVtFB6VCiO/MGJbq7eKB1+UbxSMMnYVDiyDhf01e55Va4rQ6QB2IxqFEj6mZXIcsgxgdc6yXO4z0z724dJHJ0NHajmvc3rl3/7uTGH3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=afE2I8IE; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-472049c72afso45575611cf.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Feb 2025 06:07:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1740406035; x=1741010835; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bu3BH5ESGKjhMMxMdQBiv+25Uu5LRpkWEksKFxFGPmk=;
        b=afE2I8IEIBOz7yRXq4tDz2T9jBrutIkcQ0r2ol8yMt+bkqlccm5etde2ILFRS31Wxk
         KrxMxq0y2yunCqsukZ6idoheIX0eRXvqO0wA8PImAb+t1r19k9RnvzeXKVtgQD0sEsbO
         YJQADVPAkEzi51JkUYQC7UfnjMJ3zSkvynyls=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740406035; x=1741010835;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bu3BH5ESGKjhMMxMdQBiv+25Uu5LRpkWEksKFxFGPmk=;
        b=j5aG/u+8xyVMPekWfBkR5CmuhqCfkCRfZn4P4kOxjqnHArED8G5Ke/RpFt2dWY6N+M
         Xv8ABwOjkkI3isLGd/Z2ym9rYnE3ZmoCTvCKV83TF5edmvoZuWlc2E8qX6NC/PDWCPF3
         SSAqQPtunc6EdOA39TFIQw31zIOh/fbwPfU5j2ozOE+PhQnq8mBkkm7bQMyq1uHqMs4v
         eYkzxhDLf7ePIbOdDM+vuCMmMpNbzlG32kTzD1GPleqz3jXAnKzweJQQZM5q68rAVhm1
         hEAxWNJH5P8vBBMPHFOYEQ+ekf4vaoKhq/NNQXitn2KOCiVUHwnqdtxtGF50dXEfAGf4
         gZPQ==
X-Gm-Message-State: AOJu0YxLC2Gm7e9nQ7K9ONWBVpnQZtpCbfbqiCVto+OhUBLAWhjLpnCe
	KaY2CXgEfo+bdHxD0O3uBGvTDOnb9B/+om+/XG4N/b9QT8+ZxsFcZstQ/qWH2/fvblpFzDsA5XC
	trNZ8aLELQneBuwLHKR0fW/PuJxAIZoDlbcLFEQ==
X-Gm-Gg: ASbGnctfGJ5ixFoeQmI5Vpj6oZZ3vveN23SI7eXePafo1Lgll6dCN9tmT3wyngvI2Np
	CcOUNG09YyN/u86hYoGr+B1UtArgur9DWc9HQKo0Rp05Kn370g9B7s0IBzDAnTugXSeoWZq+3pv
	yJgGbyFf/U
X-Google-Smtp-Source: AGHT+IF8HxWQUQnx61MshMWGfBc1ONBLqhSPF+wigfsKunU2OoTbGS7byj+J4MJ1bwZ0spkPthIrPAYWHpthrz/7R8o=
X-Received: by 2002:a05:622a:46:b0:471:db80:d51 with SMTP id
 d75a77b69052e-472228be4f0mr192827721cf.19.1740406035275; Mon, 24 Feb 2025
 06:07:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224010624.GT1977892@ZenIV>
In-Reply-To: <20250224010624.GT1977892@ZenIV>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 24 Feb 2025 15:07:03 +0100
X-Gm-Features: AWEUYZlVwYamswpz77zsQiYCIXMvKp9-8ynHc-9fiaS77vDRYt7JHyOFLqVdF_k
Message-ID: <CAJfpegtOWWQRgraMjQ_zGkN7MOtoATpVaoGjTYT7NntTsHPYxA@mail.gmail.com>
Subject: Re: [RFC] dentry->d_flags locking
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Neil Brown <neilb@suse.de>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"

On Mon, 24 Feb 2025 at 02:06, Al Viro <viro@zeniv.linux.org.uk> wrote:

> PS: turns out that set_default_d_op() is slightly more interesting
> than I expected - fuse has separate dentry_operations for its
> root dentry.  I don't see the point, TBH - the only difference is
> that root one lacks
>         * ->d_delete() (never even called for root dentry; it's
> only called if d_unhashed() is false)
>         * ->d_revalidate() (never called for root)
>         * ->d_automount() (not even looked at unless you have
> S_AUTOMOUNT set on the inode).
> What's wrong with using fuse_dentry_operations for root dentry?
> Am I missing something subtle here?  Miklos?

Looks like a historical accident:

 - initial version only had .d_revalidate and only set d_op in .loookup.
 - then it grew .d_init/.d_release
 - then, as a bugfix, the separate fuse_root_dentry_operations was added

Will fix.

Thanks,
Miklos

