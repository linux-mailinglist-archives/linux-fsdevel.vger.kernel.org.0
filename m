Return-Path: <linux-fsdevel+bounces-58727-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 749CAB30A6E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 02:34:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 592861C2092D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 00:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DD85537E9;
	Fri, 22 Aug 2025 00:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IEH3T+qo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D44322E
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 Aug 2025 00:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755822835; cv=none; b=m2XRzZHhVX4Qpxun6ImTS8ei7+HATZ8oNdEJGdOagmEuphvHmZbUQAixrkqcwvlGIKrwyBSDbm6ZXD5iVs+34S5DnwcM1oHBbupR9X8NSzkXM31KKMjsW+ADJ6DD80AzIHg2kibbN3xEPfzTtnWhzC4pWvLIxxGx7mO8ImUZ6L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755822835; c=relaxed/simple;
	bh=Z0RYZ+LbH99IsmxpBI7Gm30d9WPKg1J5GiI4CdC/RTA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XrgZ4F9lSHpo2dFe4OPP5e6XpQZooSkBo9C0u0XFhlBS7SKsdrxPKuq68eig+NWuqYw+0S6FD83urnGX0rpRhSHAdtTHIJlTuRxTmCHWog8iLfAS4QsYBYNXYpTwRSn1fRy6xdYRe2JWlKoEbKqxGQ1EMIE5l3MfECdNuhxwvlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IEH3T+qo; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4b134a5b217so17109701cf.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 17:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755822833; x=1756427633; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EdkiKwT3nchw+jKprCT43tfSAjmY8AdZZpGNc9mgd6o=;
        b=IEH3T+qoi+rNEnfUPqcYbTKnxzGaQRZRvnPDhfd93uUhxWFlSMyzeTx2PlrA+tt4XS
         G6/nCtoK79RiYfdnAL7Wg7aMeejW/8D2BZrXCoBUYcgLGLbstu5bCYOWXqKNjqs7GKe0
         RqUuy2TdRxxP07nRDVUK2S1GVQc1J7Hf1xT9hdbLdDTNOjGtaRbFH2J8fZIU6u1Easzp
         qWuq3iT4f936Q6iD3r9wM4u0LeRs9lbquF3ETl1ta3QRmwETqLFCAjPZDvjqVyOBVCOJ
         VDXLQRqOExU70jN7U6HXNxGvZvZ8rDlcdHJNAXwmaU/aUvapKoyIwMWAOKCdvUiUqkLw
         CsvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755822833; x=1756427633;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EdkiKwT3nchw+jKprCT43tfSAjmY8AdZZpGNc9mgd6o=;
        b=X2VOvJdMhWpOu1iv/+7pT8NhLBdEb6tr0WHTm4EzVLc4HMQEufyzwtP/QA5WRUw4pX
         fbzs+ffzktHvOPSWk2INgJdtZv770wGN4nxEqAmyEipHJMlfEfF2DxadkXmMDsMToZmq
         PqppV1InqRqRUl14xgMxE9MzZvF+JZ6qga1wgfL/y3CaORXMSJ3lDh6n3KPzYgeKqB6Q
         v1/tm0JxMMrXaJdEIVfafcw+Bic5dAoSxyhwqMeZYkzFaR+YXMq4htJqrnno9H5ImPYi
         SVbftrzSxJGXTNetr/oxQhxMcJcUaW9MQPN3PTL5ymOYBvqEiV2/ZBr1VGaXhWKPtHIR
         bOHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUueEQiztyTO/ODmYlTcBEOUnrdtGHj6baQ5PimjBwirqzPH0BYi3J7BjEMeXJmXfx1Ma9K6zqqQ7oQlEYE@vger.kernel.org
X-Gm-Message-State: AOJu0YyoemmhD97fhkXH+zBPENCdIX4efeq6BkomZUt0d8b7ytQs8dcg
	5iwR7yOZZ8uVBuH66Bm+9oI3a3RlHZ7j5bcyMgnyRf0N6WVCZCmPkI8IhJolHb0MeKTOzevP7i/
	eQIPkGjdR6N4lE84Djjo63qbeDblpsWw=
X-Gm-Gg: ASbGncud98E1du1f8P+1cN6yfSvXJgR5jTVcgLjh38E/H8Zzv+pNFRGNZjUR/Lt+THg
	7A5HHJZgQvlD4Wy4zkchpDlrkCjsPsrZ2O+PM+v4JdQ0Fglz+aXPxpF3uhmoYxWIxOoEyQjRZK3
	/3NwTxCR5NjWnth5l4dXSH2Nf2s9shDGecmCBFdSv7rARDwk4bcS8kzbV5e3zyiQnIoClP77Bpx
	Qvf9Tyx
X-Google-Smtp-Source: AGHT+IEt+aOndu3yBBycbA/5ON34SmcDymdAvy0dRde13WgU+B+fHKZcxLYHqo7fLL87iZOczXAZ7XFw7WQwowbFPSI=
X-Received: by 2002:a05:622a:5ca:b0:4b1:d6f:f97b with SMTP id
 d75a77b69052e-4b2aab0d437mr16859281cf.61.1755822832852; Thu, 21 Aug 2025
 17:33:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <175573710975.19062.7329425679466983566.stgit@frogsfrogsfrogs> <175573710994.19062.1523403126247996321.stgit@frogsfrogsfrogs>
In-Reply-To: <175573710994.19062.1523403126247996321.stgit@frogsfrogsfrogs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 21 Aug 2025 17:33:42 -0700
X-Gm-Features: Ac12FXySfG0EWt0MmEG3bSe98HAp_9XveOXZky164QW4ra34HvFGkzcZceAhef0
Message-ID: <CAJnrk1Y-eEeJySHL5sYMTphUnApbK2hZpDjDh3qEmsa_f146tw@mail.gmail.com>
Subject: Re: [PATCH 1/1] libfuse: don't put HAVE_STATX in a public header
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: bschubert@ddn.com, John@groves.net, bernd@bsbernd.com, 
	linux-fsdevel@vger.kernel.org, miklos@szeredi.hu, neal@gompa.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 20, 2025 at 6:01=E2=80=AFPM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> From: Darrick J. Wong <djwong@kernel.org>
>
> fuse.h and fuse_lowlevel.h are public headers, don't expose internal
> build system config variables to downstream clients.  This can also lead
> to function pointer ordering issues if (say) libfuse gets built with
> HAVE_STATX but the client program doesn't define a HAVE_STATX.
>
> Get rid of the conditionals in the public header files to fix this.
>
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
>  include/fuse.h           |    2 --
>  include/fuse_lowlevel.h  |    2 --
>  example/memfs_ll.cc      |    2 +-
>  example/passthrough.c    |    2 +-
>  example/passthrough_fh.c |    2 +-
>  example/passthrough_ll.c |    2 +-
>  6 files changed, 4 insertions(+), 8 deletions(-)
>
>
> diff --git a/include/fuse.h b/include/fuse.h
> index 06feacb070fbfb..209102651e9454 100644
> --- a/include/fuse.h
> +++ b/include/fuse.h
> @@ -854,7 +854,6 @@ struct fuse_operations {
>          */
>         off_t (*lseek) (const char *, off_t off, int whence, struct fuse_=
file_info *);
>
> -#ifdef HAVE_STATX
>         /**
>          * Get extended file attributes.
>          *
> @@ -865,7 +864,6 @@ struct fuse_operations {
>          */
>         int (*statx)(const char *path, int flags, int mask, struct statx =
*stxbuf,
>                      struct fuse_file_info *fi);
> -#endif
>  };

Are we able to just remove this ifdef? Won't this break compilation on
old systems that don't recognize "struct statx"?

Thanks,
Joanne

