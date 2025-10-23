Return-Path: <linux-fsdevel+bounces-65395-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 065FBC03DFE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 01:44:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C32CA4EBCC5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 23:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67B022E266C;
	Thu, 23 Oct 2025 23:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UGkgBn+B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488F52D3204
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Oct 2025 23:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761263078; cv=none; b=pm2dDlgWX1yk2Wgn3tNmsWxyu4YW1O2BfU0qPpekDEXjnhi283xJ6AJVt8yT5viv5xixyRZ3LsmQBr+2HZPG/1OsCT8Cw4seud8bXpQG2yCmK69LjP5x+tHhYdZZ1Xzd09mua0ZdiiCG79EXwzzAEux9lJJb41zZ5tYFkutXBkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761263078; c=relaxed/simple;
	bh=+73TE0LUJk3EHBZtSrvfA2iuWg7yqVR6IZtWQcGL0sI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B6XIvEcu45f8yWbDK942POmAQ1k0HeyEAYXjqAzAnQfTodelNWW7Op2fYAz4FgCFKndaR4rpmZFSkhN7+W7+EWYPH95gYzU57Ox2UehrCVDzrQJu0mM0TYReBGWG+EF9DAdVtKwtvNod/5ZjdHF2bferMo9g/Wq45hVfj+JPrdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UGkgBn+B; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4eb7f0b9041so10467781cf.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Oct 2025 16:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761263076; x=1761867876; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UXqCBtIeIyeVeN+++avkFc9AmHHco/PM3jJYvlfy7IY=;
        b=UGkgBn+BOgtP0aoMJ7v4elUL+o1mZIqqduaHtLNVltus8AoKgRbFBBlgxfinwICTgc
         p/U8TZPt+KZfG8QCDnhIinoBdafU9qENVQi0i24NeqahgbdPLCBgNZ3n9/iMCH984yKW
         LwAODBzsBT6R+r7sTyX2PskgppZ/b+m0t2zs1qHJ0AcsVMxuPVifrA9aNHGTn4KWupW8
         HdV3XoUOcXNg7Vk88VKXBvhGUQISTLnfNhLgYJ1N3bWHhO9evr4zTRNMATo19qEy3lU/
         06HsMToYE9Fn1ANXTCMtlomO4652coyOfXQs05NY4qIASN3wmo4XkOGv9VZJnS3r5Y9h
         5UWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761263076; x=1761867876;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UXqCBtIeIyeVeN+++avkFc9AmHHco/PM3jJYvlfy7IY=;
        b=IedPNf9Vb4B33dnkbMAixkHhb3RRq4HCl2SxanJfZ2lOziYMGVbLNjVlfZsCFgR9mf
         ydT6y0hYkxVywlBYMUa/YnGoJL2Om6hOGxmpmD2WKfkEe8KM1LTWf6E4OLHG3mJ34V9w
         S4SNZydQtNoJvf+p5JT2x8KNaabzMmEr5lVrphk/YPqrVz4kJqDAtiNqYyp2h3R+TxZL
         EY4qBuErIey/IwGBwwozzLvhOHTzHl/ftLL1WXoZCn0tQLIHZW1Dj3IQthdULeinPPGi
         zORDTeubVUw4hHoFTFuqnRWwYLZ8y62MlO8DuMbkc7uKox5vHpr6S6AHT8ExWC9vh52+
         +e5A==
X-Gm-Message-State: AOJu0YzhTFPKEhZA6qBhaDXy5XKKD+P2lVRIevlNjdxtspyxY4ss0p9u
	qCymYUNihczz14mw40ajxYIfypkjQQsvghGA5gB5AvMOO8vJNpUJc8E/lAEAnwFVFDUhc2Y2Mei
	rOSRuG0xyc6cuCHHMcM+P63hnYgiPAFA=
X-Gm-Gg: ASbGnctEAUZoAFucA/tLMGmhVLe3gEBgPbALUG/7uxmAOAuPW+EarA6s4rZQVh+SU07
	I3KQhZKiIFgB8MoN1uyPP6c5MEnm07IeXWTO8T9zybTgz6qpNnluR6uxi3NbBEQXu3w494tsKW0
	VeGRFIZBQUFeU8N/FQ++xFMppfhn6abORiPaEWpIhiIFWfWrsLtpk7stV3+4/B+J5aLLJs0zffq
	NCT/aYNinzuxdLLRN58nmlppNkTR7s2sXis4X6ZK2tr4VyILFp+1mRn0PAKxAK0uYKjDM9jV0Or
	HnHh4djpx57nmrXu1QYbOVVF2Q==
X-Google-Smtp-Source: AGHT+IFfKFcBw3GFrPn9bPh8oDexYFhT6MlUZOifmThWFzTuYEuhqR/yL3g28XjR2Rdspj+zz/eGO0LoM7bALqdbCfY=
X-Received: by 2002:a05:622a:4cb:b0:4c3:7101:8861 with SMTP id
 d75a77b69052e-4e89d20d74fmr245657381cf.15.1761263075982; Thu, 23 Oct 2025
 16:44:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022202021.3649586-1-joannelkoong@gmail.com> <20251022202021.3649586-3-joannelkoong@gmail.com>
In-Reply-To: <20251022202021.3649586-3-joannelkoong@gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 23 Oct 2025 16:44:25 -0700
X-Gm-Features: AS18NWCUeOyyQYcs_PpyeP_rFldTQGSoTEysf2geuIz4a2-n3KFNW91U42vYFHw
Message-ID: <CAJnrk1Y9KjhchEMqb7cb6gBBFKs-vcxp1LSAL9_jP+8WaJFnmw@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] fuse: support io-uring registered buffers
To: miklos@szeredi.hu, axboe@kernel.dk
Cc: linux-fsdevel@vger.kernel.org, bschubert@ddn.com, asml.silence@gmail.com, 
	io-uring@vger.kernel.org, xiaobing.li@samsung.com
Content-Type: text/plain; charset="UTF-8"

> diff --git a/fs/fuse/dev_uring_i.h b/fs/fuse/dev_uring_i.h
> index 51a563922ce1..748c87e325f5 100644
> --- a/fs/fuse/dev_uring_i.h
> +++ b/fs/fuse/dev_uring_i.h
> @@ -38,9 +38,20 @@ enum fuse_ring_req_state {
>
>  /** A fuse ring entry, part of the ring queue */
>  struct fuse_ring_ent {
> -       /* userspace buffer */
> -       struct fuse_uring_req_header __user *headers;
> -       void __user *payload;
> +       /* True if daemon has registered its buffers ahead of time */
> +       bool is_fixed_buffer;
> +       union {
> +               /* userspace buffer */
> +               struct {
> +                       struct fuse_uring_req_header __user *headers;
> +                       void __user *payload;
> +               } user;
> +
> +               struct {
> +                       struct iov_iter payload_iter;
> +                       struct iov_iter headers_iter;
> +               } fixed_buffer;
> +       };

The iters need to be reconstructed instead of recycling the same one
since the buffer could be unregistered by userspace even while the
server is running, even if libfuse doesn't do that. I'll account for
this in v2.

Thanks,
Joanne

>
>         /* the ring queue that owns the request */
>         struct fuse_ring_queue *queue;
> --
> 2.47.3
>

