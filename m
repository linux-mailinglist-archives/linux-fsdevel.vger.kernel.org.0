Return-Path: <linux-fsdevel+bounces-34582-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F34BE9C6658
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 01:58:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB8D71F22305
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 00:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1006313AF2;
	Wed, 13 Nov 2024 00:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="RMChi8OW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9427E2F5A
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Nov 2024 00:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731459510; cv=none; b=Ou+ukUovqPY9qA5lh/VAgH3eqc1HwRaDhpzjZ9Sh+Awv2vjmhgxI69P7IShhtH+G+/UJ9OxHCpOTQ+smdqNAj3LdraaQXS7iCaClsRL+BKapV1BvZ+UgyPPw8ktUosrvIqrszUPj7q6sr1xfTp8p76pzInr3Rg97yMEgh3sTFFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731459510; c=relaxed/simple;
	bh=n3j6hYJca3iK+8w4R60+GpDVT4tBx8PgHWEo86e/9FM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gjHEcYPAoMTPmb1+2/NElaDemPEZ9sW0RgxCMjBFEetWm77pjRTcznX23m8NNeX20grGRbgXf43QJ9+m5TEdoLnww7iDE4fe+znhMBRiCmjfEXkISx3ecSp/PGbJQpWKNIHzbadxeZVoOOJWuw2gG0zyfJxbJm7umsmCStbD6Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=RMChi8OW; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a9f1d76dab1so503112166b.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2024 16:58:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1731459505; x=1732064305; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5tJ813zBq+G2Ew0iXW8JEVhQMVvtnrBGzEzzKoVgMoc=;
        b=RMChi8OW/1Vy6bsK3yi0qk7kBNFAd3stwE+DcWK8limrrf5Nh45ka1cI3GyawVGg1Z
         EIge1O+lRa5eZoqvK/ofELDWi7Kxc511tDaS5rDvRzX3wmumibbrfxyQ2j67lK8kIIr0
         0KQUW+VSIV0EPBnHG2yKdX2NvQPGVc/o4qRIc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731459505; x=1732064305;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5tJ813zBq+G2Ew0iXW8JEVhQMVvtnrBGzEzzKoVgMoc=;
        b=jrojRvLvvyOQx+QexocHmksUqcjAcAyFNKYnFQuSV41gGmZywT1SCuLloIbUjbZBhX
         KYnEO+V0xDr/6rCACG360hHKKTvtOsgbrkvOb576LmS+zi2fE6FxLSZVCSoF+U/dC7ux
         bU9GnS/cwJMtuLXQtdINLTSHBiIWciHqUC4lzPHWH/VW3XVBn6Ijl+UEstpDVdNZISwM
         +BXfKAZHhNuZ5YpUTShZ8nJGSuomLUf5EcXl1SUuOZvbNkd+fff6lcMR/qRZXxMOGGEh
         Rzqi0ylb2V76a+PCMwnRWOfe2W3oJWgcnSsAtB6xY/nz0Xdepd3tEr0Epz2tV9ZkDsfk
         hmDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXPlXtJaq8miTr4r7+kna+YUSHdSJ93WbofEdprWZdGou8xN5cSzE3q+ZPuso6xdLp9wKT5Jaty0pYBWGRv@vger.kernel.org
X-Gm-Message-State: AOJu0YzlfD3wM8tu8noxXoXYsW61YPmdA+16+wOlK2Mk3iOzgvBYQMZ2
	UKcQFm2G6tJJDxrRmI8ho7mMzibMM6vr4GZoI9y/jviTeVShjgQH4Gu2OAkLDRhRF738gE5CwyS
	bI/8hZQ==
X-Google-Smtp-Source: AGHT+IE38Sh1GcxP29g3Zw7jEFMO37NgVKD6UuzqXhmUCJfTBnMFTwiDysQGZfLlqBfvdfncJabDVw==
X-Received: by 2002:a17:907:1b2a:b0:a99:89e9:a43d with SMTP id a640c23a62f3a-aa1c57ae52emr511047066b.39.1731459504595;
        Tue, 12 Nov 2024 16:58:24 -0800 (PST)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0a4a9b1sm787436266b.52.2024.11.12.16.58.22
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2024 16:58:22 -0800 (PST)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a9f1d76dab1so503107366b.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2024 16:58:22 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXhbCiYHDP4Z2SPRJIUoFBDOqbzmLsaTKTUe/bp9gAfQqa60HSjfG//GriwlfBZ+4Aa39hJvz/6goJT2B6u@vger.kernel.org
X-Received: by 2002:a17:907:1c11:b0:a9e:b08e:3de1 with SMTP id
 a640c23a62f3a-aa1b10a9779mr425956266b.36.1731459502310; Tue, 12 Nov 2024
 16:58:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1731433903.git.josef@toxicpanda.com> <60a2309da948dc81e4c66b9e5fe3f1e2faa2010e.1731433903.git.josef@toxicpanda.com>
 <CAHk-=wgNFNYinkWCUvT2UnH2E2K_qPexEPgrm-xgr68YXnEQ_g@mail.gmail.com> <CAOQ4uxgakk8pW39JkjL1Up-dGZtTDn06QAQvX8p0fVZksCzA9Q@mail.gmail.com>
In-Reply-To: <CAOQ4uxgakk8pW39JkjL1Up-dGZtTDn06QAQvX8p0fVZksCzA9Q@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 12 Nov 2024 16:58:06 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiMy72pfXi7SQZoth5tY9bkXaA+_4vpoY_tOhqAmowvBw@mail.gmail.com>
Message-ID: <CAHk-=wiMy72pfXi7SQZoth5tY9bkXaA+_4vpoY_tOhqAmowvBw@mail.gmail.com>
Subject: Re: [PATCH v7 07/18] fsnotify: generate pre-content permission event
 on open
To: Amir Goldstein <amir73il@gmail.com>
Cc: Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com, linux-fsdevel@vger.kernel.org, 
	jack@suse.cz, brauner@kernel.org, linux-xfs@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, linux-mm@kvack.org, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 12 Nov 2024 at 15:41, Amir Goldstein <amir73il@gmail.com> wrote:
>
> You wrote it should be called "in the open path" - that is ambiguous.
> pre-content hook must be called without sb_writers held, so current
> (in linux-next) location of fsnotify_open_perm() is not good in case of
> O_CREATE flag, so I am not sure where a good location is.
> Easier is to drop this patch.

Dropping that patch obviously removes my objection.

But since none of the whole "return errors" is valid with a truncate
or a new file creation anyway, isn't the whole thing kind of moot?

I guess do_open() could do it, but only inside a

        if (!error && !do_truncate && !(file->f_mode & FMODE_CREATED))
                error = fsnotify_opened_old(file);

kind of thing. With a big comment about how this is a pre-read hook,
and not relevant for a new file or a truncate event since then it's
always empty anyway.

But hey, if you don't absolutely need it in the first place, not
having it is *MUCH* preferable.

It sounds like the whole point was to catch reads - not opens. So then
you should catch it at read() time, not at open() time.

                Linus

