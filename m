Return-Path: <linux-fsdevel+bounces-59011-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C559EB33E7A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 13:55:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 151713A85BF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 11:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C2802E5437;
	Mon, 25 Aug 2025 11:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="A4faTD7l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EFF526B765
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Aug 2025 11:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756122907; cv=none; b=puKFBZFLhSQBjD6UJWnKrY/EO9+ML4FIuq+vo5hJzbob5GGS97v2qa0YOuI3GUa0ZINRI6A3ScK6xCIBeu32GXH5yDjFdDaQ2zD4gojp+w3IdVe6oBaYpbBMWNdGtK5wOjTe0yv3vWv+GsG+qFq2erSMdy1vyRuqn879H3IkhPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756122907; c=relaxed/simple;
	bh=99spx2sm3BCvKBTMSbWBPwLbsPis8CbtH66bNFz0EKI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qaB23DLKqXy29i81PgAVGywPeigGUkx4KmZCq/vsQByAJ6+2RRHUpCfOh+k+GmTajWbZ7hjjFyxO7fb24W95d/+ZROgYlasZU8SzZbDGu1PhsPCztbtiuk3jy62NKOWkKs352aUyM/GpdlgfItG5MTpJJ4p4Y/OQ9Wp7j2JVNv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=A4faTD7l; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-afcb6856dfbso790706266b.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Aug 2025 04:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1756122903; x=1756727703; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YxYgRpNWttBrFhhF+VQ1HY1PKweqtOc9jIbbRZXomY8=;
        b=A4faTD7lQkF//nulQgwGqdVIgd2WgePkjwYceXYEfWbe0BKHRrYlJlfrGRKo8FJQ2v
         obch/S1XT83rmQc3NScGjkRdI43QhbVme+SqiM/M0DV3w8LrTXN+U/IZ4/Q5Bi/zcqbc
         +7+L+4CrwKlYfIAQHPj6xEN3oWtJ8NzoMuF7U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756122903; x=1756727703;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YxYgRpNWttBrFhhF+VQ1HY1PKweqtOc9jIbbRZXomY8=;
        b=EExKUNWhhJRWnK5tHvFdUQZbjZ3B+Y/Gxdq5zSoR2Z/+m8VXI5drn52hU2vnZHRs8P
         c1VtjhDBA/3nu4S+5lr9Ebw+9SJGbnYJdy0RI/LwNXW+arxlz6mEJfpNupx6q3ij/A/7
         1qVS+mBxo0i1g8pc+ji0FAnGfNeeEjfHv/lwtKZQRh3LQPf9u0shAmCJseS9dafHEhaM
         TRUmQfDhFtwYRVTiNB2TV09+HVVN5Pk2SMV3Dh7y69BY8m+reRPDz4Pp/SawH55w94Qr
         dTMB9fKh3eYjUNLOMJknZLelScSoaoBmFbMDnWAgls/DRVkatp8j6VIETx9sRbl/ncv3
         zfQQ==
X-Gm-Message-State: AOJu0YxmfPY7bMtsXpFtpY+igmRHy3ANZ/ywMQNqtOxY5OLo3QegvQdr
	V7nD8MkrfkyR9wBWcKADwOKT+MU1epghZhfywHvMNRJdtLckNhOA2d7TUH7N3X5bCIKLhqH+bsy
	M3ZtgW0o=
X-Gm-Gg: ASbGnctI4vBQ0LaQB2UMKCyb5tKPfaFBh/IIREIDbYeNA+kwMphybnFTIxi3r/lxCKF
	AVnWxvU/NyMmUsS4nf50I8jePbD2oPeAxcWQi/k1k1dpM2x+mL9K03UwtXtlrgDe775HICOUO09
	ee98RtqJ7LCbajYvzFuGVqAnDhE7ti1vcNoUNkTvFiY/0F04ObjuB5x0Ta91004j3WHs9pc8rWN
	duuf5q5Xkc6Z+mfFEd6iSgKQONr4ApLXKxFvWYHLR9DrfzDHAezHhrhfwCF30MioEPsH2H2EXgl
	hFJecgDB6C/FbZxIo82hIw/Vh7MC9caRquLzBdUImNoplXvY02HvHfvaVhU78ukGwiQqhUMSjuP
	wWEC+5NlqsfsnHCeg6DKfM0CXHc0A0z2l+T5DVXPXjVqLFPH36Ijq1MtBjB/aD8XUx6IFE7LEXD
	SoFiWDYJg=
X-Google-Smtp-Source: AGHT+IEraah+/x8iDTWLoiN0mj3+uGCjQHAuDwn2W5sM+RziAqOKgZLxWyE6rzzAXEd/k7cUYEgyzQ==
X-Received: by 2002:a17:907:7f0c:b0:af6:2f1b:46a with SMTP id a640c23a62f3a-afe28fd043dmr1222217566b.6.1756122903054;
        Mon, 25 Aug 2025 04:55:03 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afe77f33f83sm263248066b.31.2025.08.25.04.55.01
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Aug 2025 04:55:02 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-61c30ceacdcso3279437a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Aug 2025 04:55:01 -0700 (PDT)
X-Received: by 2002:a05:6402:1650:b0:615:9247:e2fa with SMTP id
 4fb4d7f45d1cf-61c21345964mr6027320a12.8.1756122901451; Mon, 25 Aug 2025
 04:55:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250825044046.GI39973@ZenIV> <20250825044355.1541941-1-viro@zeniv.linux.org.uk>
 <20250825044355.1541941-13-viro@zeniv.linux.org.uk>
In-Reply-To: <20250825044355.1541941-13-viro@zeniv.linux.org.uk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 25 Aug 2025 07:54:45 -0400
X-Gmail-Original-Message-ID: <CAHk-=wh9H_EQZ+RH6POYvZBuGESa63-cn5yJHUD0CKEH7-=htw@mail.gmail.com>
X-Gm-Features: Ac12FXx_j9f5PdhHoUEKXmXXf4DWMtYVdIBSesLCMDBhM_W9nWpaPVSJNG78ww8
Message-ID: <CAHk-=wh9H_EQZ+RH6POYvZBuGESa63-cn5yJHUD0CKEH7-=htw@mail.gmail.com>
Subject: Re: [PATCH 13/52] has_locked_children(): use guards
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, brauner@kernel.org, jack@suse.cz
Content-Type: text/plain; charset="UTF-8"

[ diff edited to be just the end result ]

On Mon, 25 Aug 2025 at 00:44, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
>  bool has_locked_children(struct mount *mnt, struct dentry *dentry)
>  {
> +       scoped_guard(mount_locked_reader)
> +               return __has_locked_children(mnt, dentry);
>  }

So the use of scoped_guard() looks a bit odd to me. Why create a new
scope for when the existing scope is identical? It would seem to be
more straightforward to just do

        guard(mount_locked_reader);
        return __has_locked_children(mnt, dentry);

instead. Was there some code generation issue or other thing that made
you go the 'scoped' way?

There was at least one other patch that did the same pattern (but I
haven't gone through the whole series, maybe there are explanations
later).

               Linus

