Return-Path: <linux-fsdevel+bounces-44435-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9306EA68BFF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 12:43:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CE4E18998AC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 11:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C400F254AFC;
	Wed, 19 Mar 2025 11:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="TYL/iQKn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE1D1AF0B4
	for <linux-fsdevel@vger.kernel.org>; Wed, 19 Mar 2025 11:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742384552; cv=none; b=Ol+JdiJhJTmC6druYOiu/YyI/BZE8K3pUxaH23QYvuYnIKuFVvmoTgbYb8dw0mozd9d6upQavmraB4/JHieuK1keRDbKlbjxxWcVrZCmjkJWxM81xjaLiXMl+KD3xxQvjpqkeFpWPRIIuf6wdJTLBhK/GyoVKoIHPYV/tUI3QSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742384552; c=relaxed/simple;
	bh=wy03s2OgBoYrwNwT4FnBPnVzFbiJFs13xg0ETtAqwsE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QTXhSmmnlebU8wv7IPBI34WPXxyKVPxKA0EMA4XxSGptgpXqozdqCJa2iYp1cGgE77hmJag//yF7IP8zxQdVVcNO1kmsOW8h5RtXBPxvzeX1EUMdCcRUSJUuowFWUESZp14pL8sjrka84XACtvI2iOxZRG5BHhcODsIBBG3KMAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=TYL/iQKn; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-476a1acf61eso50491301cf.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Mar 2025 04:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1742384547; x=1742989347; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eOeR3Iy7h+V2epQ8qxHvbKx6Ht0fk7KB7AjTlEBR60o=;
        b=TYL/iQKnHknrV21j42fXb59A9tOAvMVqFF1UAzzZTsT/GufjnuP1QLdBxMMW0lqfIT
         nvLHnas0xusGUE4u7jOv0zUhGmUJlrOQE0/Isqu5VtBeKuHabzCLEKg2EZCgPM6e3AMF
         /tNV/6c4GHy4HuChatIyvtILbPJGOX02mu7mk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742384547; x=1742989347;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eOeR3Iy7h+V2epQ8qxHvbKx6Ht0fk7KB7AjTlEBR60o=;
        b=SIrfWfzHyxeXTT0shvhNXkAXsUrMXX+6p5+4lmDUMnVRTigXAHJCFjMLrtlM0kM6MI
         KTnjNvUuhW3jdCxDWjr1bam6IjtJFjwj8x91HbRsuZ7kQU4o8cuZKpE9kQAUhFW6H3i1
         cVHB3g1EnxbZsPb9hV9C0P5qNIxqvWfQkwMCDSOCYu9WgC8kjBpF0m5OVYF43FCYGiIS
         Ct8vitMGEry6K4CErOeFmIxXcnW7MTBoOqHUFfQE+m//iyDRlfINRdUXD7fNkrzk6NZX
         lvyYv0hH0z4Pg5IneV1rDPr+R4Um1oiZegpmnnr0ZdjUynNNRkvaEadgFmOsrGgQeEwo
         oA6A==
X-Forwarded-Encrypted: i=1; AJvYcCWG5gX23MFTWYMX2TCwELcziC7oUAN9cM74ypzLN7rtVDnO4IZuZpxglQ3UKre6qrzrRpUSHZJGHajJNSft@vger.kernel.org
X-Gm-Message-State: AOJu0YzGnbvcTBvqKIMSlGcHqgioo3+A2gk4eifXlZ11ThGp4azQ8l1t
	v4DEzvsywpLy7Ek9AylPG/4tInoeak8wLBaNjjHBI8FIbYFtmSdUZvz6A2I+cONKr3suikwZoUA
	8LRCgtQmoKy25FzBG4++zrwjcBpUkR4WW4L6bkw==
X-Gm-Gg: ASbGncvOhgR41QxvXIHe8ZfELjS5T1AbyN05QBxZArsSGcg58kQw2zZ8lnZWQ5WTEXw
	S5P7R+LDm6W/zUMTsGGuHC9pInTrCzjPcW9GHXhwbXycdrvkQCeqO079G/ChfCs2qRp++mLQmbt
	fPYqKyrzG5Hr4a53HDDe825YXZUxwx9ak4+Dc=
X-Google-Smtp-Source: AGHT+IHie8Oo1ReBaAnAPNF9jllLcIOBAU6Ntk8TCDzcfQ3daa66B0dpqmWn7idz9zfkJmg4+xBXI1wsdTuJMGlOJTA=
X-Received: by 2002:a05:622a:590d:b0:476:79d2:af58 with SMTP id
 d75a77b69052e-47708333310mr37377541cf.23.1742384547394; Wed, 19 Mar 2025
 04:42:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250306111218.13734-1-luis@igalia.com>
In-Reply-To: <20250306111218.13734-1-luis@igalia.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 19 Mar 2025 12:42:16 +0100
X-Gm-Features: AQ5f1JrNYro7vkedzUsPpOQbvf49bp62EXZPULpL7sA54pVAkhVOczqb_j8Zhns
Message-ID: <CAJfpegu2ABH7dTWw4RuR79f3_e2u0D0YX8Mhjg5Gtni4PMJcMg@mail.gmail.com>
Subject: Re: [PATCH] fuse: fix possible deadlock if rings are never initialized
To: Christian Brauner <brauner@kernel.org>
Cc: Luis Henriques <luis@igalia.com>, Bernd Schubert <bernd@bsbernd.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-dev@igalia.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 6 Mar 2025 at 12:12, Luis Henriques <luis@igalia.com> wrote:
>
> When mounting a user-space filesystem using io_uring, the initialization
> of the rings is done separately in the server side.  If for some reason
> (e.g. a server bug) this step is not performed it will be impossible to
> unmount the filesystem if there are already requests waiting.
>
> This issue is easily reproduced with the libfuse passthrough_ll example,
> if the queue depth is set to '0' and a request is queued before trying to
> unmount the filesystem.  When trying to force the unmount, fuse_abort_conn()
> will try to wake up all tasks waiting in fc->blocked_waitq, but because the
> rings were never initialized, fuse_uring_ready() will never return 'true'.
>
> Fixes: 3393ff964e0f ("fuse: block request allocation until io-uring init is complete")
> Signed-off-by: Luis Henriques <luis@igalia.com>

Acked-by: Miklos Szeredi <mszeredi@redhat.com>

Christian, can you please pick this up as well for 6.14?

Thanks,
Miklos


> ---
>  fs/fuse/dev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index 7edceecedfa5..2fe565e9b403 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -77,7 +77,7 @@ void fuse_set_initialized(struct fuse_conn *fc)
>  static bool fuse_block_alloc(struct fuse_conn *fc, bool for_background)
>  {
>         return !fc->initialized || (for_background && fc->blocked) ||
> -              (fc->io_uring && !fuse_uring_ready(fc));
> +              (fc->io_uring && fc->connected && !fuse_uring_ready(fc));
>  }
>
>  static void fuse_drop_waiting(struct fuse_conn *fc)

