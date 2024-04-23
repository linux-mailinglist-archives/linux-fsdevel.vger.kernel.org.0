Return-Path: <linux-fsdevel+bounces-17490-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B708AE30A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 12:53:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99971B23D51
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 10:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56B1113C67A;
	Tue, 23 Apr 2024 10:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="kIdMng6M"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A5B13BAF6
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Apr 2024 10:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713869223; cv=none; b=ZgSPifYNEdDzaEYGgK2Ntp54ty+sP5P6PogdEub0lEVYhMHvOWCCrAFJwynG5IUPRy529qfLG2/ljrImH1yGWjk8NmyJo+hK5aMs7Z7VYfWTHlyhznbb6gZGpCjGJ99yUcYS+AGqEd4srakbVaDMfy2Gca9fb3B/Aq3UfPn02C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713869223; c=relaxed/simple;
	bh=bnm9dAp7zsP62Q4SrXjZMFaEimKjtBUye+SOW2gIPfg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g40qrw+jK+ArYpTsVlWzaKW6OLwFhTOn2+1bUXU3NQmWKaF/xXu3UMWw36IDbnxVrWgz5vfPjpy30NN+QwQogPTD0Fb/EsVMHMHtFKNLE/lRGtH1RbdEdbpZPkMmajE96/YWVpG8+8169ZFUBBEouHIhY+znYkZGmVLtyV2o0wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=kIdMng6M; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5709cb80b03so6229512a12.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Apr 2024 03:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1713869220; x=1714474020; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=p4hx2jeGPwUIetmjrHLnRDMD/4WfNg0/i9D9VT9diok=;
        b=kIdMng6MbZpzp5ry43b4ujvYAUh7dKybxGw6UX6ZMHLffNmbHDGNozWbTHh0sLz3jj
         eWvE2TLsjnCI7m43uqYUDJoCUqHDVG1KkuuNPvaZErr7JWDZUmI4+uNN9CWp/vSONav5
         AdSWzXS3hii/giVvHgDKm91k+IhtsgeYAugbQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713869220; x=1714474020;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p4hx2jeGPwUIetmjrHLnRDMD/4WfNg0/i9D9VT9diok=;
        b=VIm1hDh5aBP8Rf3s7XV4EchPkoIJ84XzLxm9AX2egyJBBvGHIYwWv3m0BOnI9oba5J
         7QIofU7u0wU8HixtpmPFXVJqQa5e2i8OhFY4kMjLZJTk1I0wdaiRugePWVVv4H2MlOU2
         IIVYDvSexwD/0z7wkErHyukV2OW3Gjx5igTOMWGPFJONMYuOLgE8ZL46+SoY/G1781kP
         bX2swf08IkbgrU+pC3msYl34Zc2rVvWk7xOpY255/XW0OY7wnotxmIaWyxB/IY6cdlk0
         VJK8ZJFGdwe8HER6R9Nq7jBSYo9mjU7k+GyyDkbt3s127yAV41zsvSwbf10e0JibddUC
         5vPQ==
X-Gm-Message-State: AOJu0YxJcEh6dBp8oL/RJlorw1N8YBa8334GxhJPTm6k+jow4DvAc3uo
	pbcUMZOyiQ44MbLSHCmi3NqQIPZEAQ1gVozUHUEVztuQvJN88dmJ7+rlcfJIbZ4ezUh3NoOopoA
	64eMwZ6dZ0BumV5tKPLXWpkFDb6jfIRZ0JjvOpg==
X-Google-Smtp-Source: AGHT+IFYvKKPaOgyHpltF5qE2KV2mnsMTiyUJu9fbaILAgTcUloENQDdYsc53DJ4Rpo2rmi20LxEQItBhd9FTQSnOfo=
X-Received: by 2002:a17:906:f757:b0:a58:72ae:722c with SMTP id
 jp23-20020a170906f75700b00a5872ae722cmr1842645ejb.29.1713869220047; Tue, 23
 Apr 2024 03:47:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <b923f900-3e09-4c6e-a199-05053376d7c2@fastmail.fm>
In-Reply-To: <b923f900-3e09-4c6e-a199-05053376d7c2@fastmail.fm>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 23 Apr 2024 12:46:48 +0200
Message-ID: <CAJfpegtQ9tFH=7vUtG+UCZnABYkhmHBRgWazrKGfGtYatHUvOw@mail.gmail.com>
Subject: Re: fuse: Avoid fuse_file_args null pointer dereference
To: Bernd Schubert <bernd.schubert@fastmail.fm>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, Amir Goldstein <amir73il@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 22 Apr 2024 at 19:40, Bernd Schubert <bernd.schubert@fastmail.fm> wrote:
>
> The test for NULL was done for the member of union fuse_file_args,
> but not for fuse_file_args itself.
>
> Fixes: e26ee4efbc796 ("fuse: allocate ff->release_args only if release is needed")
> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
>
> ---
> I'm currently going through all the recent patches again and noticed
> in code review. I guess this falls through testing, because we don't
> run xfstests that have !fc->no_opendir || !fc->no_open.
>
> Note: Untested except that it compiles.
>
> Note2: Our IT just broke sendmail, I'm quickly sending through thunderbird,
> I hope doesn't change the patch format.
>
>   fs/fuse/file.c |    7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index b57ce4157640..0ff865457ea6 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -102,7 +102,8 @@ static void fuse_release_end(struct fuse_mount *fm, struct fuse_args *args,
>   static void fuse_file_put(struct fuse_file *ff, bool sync)
>   {
>         if (refcount_dec_and_test(&ff->count)) {
> -               struct fuse_release_args *ra = &ff->args->release_args;
> +               struct fuse_release_args *ra =
> +                       ff->args ? &ff->args->release_args : NULL;

While this looks like a NULL pointer dereference, it isn't, because
&foo->bar is just pointer arithmetic, and in this case the pointers
will be identical.  So it will work, but the whole ff->args thing is a
bit confusing.   Not sure how to properly clean this up, your patch
seems to be just adding more obfuscation.

Thanks,
Miklos

