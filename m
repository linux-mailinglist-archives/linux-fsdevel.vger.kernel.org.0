Return-Path: <linux-fsdevel+bounces-49262-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D884AB9D26
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 15:23:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22C379E0768
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 13:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 750941B808;
	Fri, 16 May 2025 13:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="L9EVjs88"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D16EEB3
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 May 2025 13:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747401778; cv=none; b=CE2sarQaNN6a+yPyWIScmxRnOGIOnQtTavsNlF6lGif4WGcCsvhfAnwok+5ny8IZt3lFYlTFjC+gMOjJmPev04/qN6Hc2ZlTyp8+03d9veg6LgNaSdsVbKABfYa/QY1fiboDynAUZzLcx++5mUY0niIVwgbmSIGPxbwW8MXFHZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747401778; c=relaxed/simple;
	bh=Mq6LaG0xBwjv9AjnUVCdQRAwR2DWeZ8fcyCh1PjYfE0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JplrsIB9d6IwPbGbVqFBCtxdIuflnhr6nu3+4KiFe46GHmzj5TvtHBMEETHFj0pSJ2l3T8a6Ck7noqfVP+LuTUd0eWIwsYn3SN4ULsCehs/XLSI908nUCcTXqGLBVAulilTz2imRmnyZK/6SFp/tHSW8ZIQZOBKS9tqvmHW7+6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=L9EVjs88; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4766cb762b6so24351861cf.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 May 2025 06:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1747401775; x=1748006575; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=f39oE0b2asrQ4dnW0vXfoFvu2HeI4aCcBfP7KjEzx4U=;
        b=L9EVjs88vO0z07dbQhKy84+J/bm+Zb0Jg2IlXWR9gwlMhqkDJnP28ujpYRaX3w8/7O
         fkzu0KWXKnYJxqQp6XYEk3pnmLDuc9G7Y6rJkmabd4bYwODhsIkzlTO4O+IYJ7CaPCyT
         xCtx3gvIG7Ij6QktTCpB+q7c9gGz74IqvWD4E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747401775; x=1748006575;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f39oE0b2asrQ4dnW0vXfoFvu2HeI4aCcBfP7KjEzx4U=;
        b=AYtghyelwSzFSaw19/ealpYvJP6qYCPuaAQySWEQWWIymqf5S9WSDgbOxkkWT12EfF
         Zy/RmBYz/Un6Sso69bYGg0iVlci5cbDn5VtPNaUKeUzBfCgLedPC5R+GMsdDhFD/P6bB
         k75Kg3YcAwMiZeVIIzAAvHXA97Np2ScTxCOEo2UjNLLPdrKWNW1iNg1OJWxSWPQ24T45
         R+CS8ar/pzHzt4VTVTJ6YISv+as1NBa68mFpsAzhWunqJM2sxtvdanrDXo6/Fr0SR/Bl
         icYyPnqWHtvb3ygXoKmWx4kuNE7txgqZbfMEg9LGeADV2e6BjS4qYmWQL1VIwms/UKM7
         OAwA==
X-Forwarded-Encrypted: i=1; AJvYcCW/IJVfGCJBP5ObxDKtWMCZ5zcXXMXrO2CMsD27ApRzzWeQjgvv1sLHVL3gX3cAdqwMka72jArTBZSWRvhR@vger.kernel.org
X-Gm-Message-State: AOJu0YysFocHyx5YKUaOTKx8MnzjFohu5n1DAwL61hCd5u/A/gX51ryw
	5vP3eQ6wAxRY4dUThUKDskVUzze7mCGfeOYEtGeU5HywFoQTyOBjB08Kv8zgEVT5bQnTTNwIChr
	55EJhA5yMeJevWHgbWocsbEAgXE2F5oxtW5gYAGRNcg==
X-Gm-Gg: ASbGncvzGVGzSj1x+14YDD02th4ZjxLfNhWe7+QhKP46vd/bdfrrIPi3RKbJLdPramQ
	cSR0kfKYAurvUHpPsv+RMsnsG3XNXLLjKN3dBZHDRAdPxoAanYyT77OXo/oaKd+pETicwDpiylr
	q6xV/F453NPMZmAkmb1PuB6nYLlREnAVU=
X-Google-Smtp-Source: AGHT+IEAvu9tpjtqXuDYr/81S7DdmO/50+Tpv7T1ApOme1g7g6uD55d8ZWkPlouEKTL4RfaeXIUVFoxmzhyH8GheyOs=
X-Received: by 2002:a05:622a:995:b0:494:93f6:8f8b with SMTP id
 d75a77b69052e-494ae4a266amr54604061cf.10.1747401774693; Fri, 16 May 2025
 06:22:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250419100657.2654744-1-amir73il@gmail.com> <20250419100657.2654744-3-amir73il@gmail.com>
In-Reply-To: <20250419100657.2654744-3-amir73il@gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 16 May 2025 15:22:44 +0200
X-Gm-Features: AX0GCFsPPiBKdqhMm6Ea7sHZuTGzr3VR_ZEJbQQUAOy1CExAMq1ZlIM2zji9lR8
Message-ID: <CAJfpeguGj0=SmmD3uLECgByh1rOHA+Gp3tbsxsga0K3ay2ML_Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] fanotify: support watching filesystems and mounts
 inside userns
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 19 Apr 2025 at 12:07, Amir Goldstein <amir73il@gmail.com> wrote:

> @@ -1987,12 +1988,27 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
>                 obj = inode;
>         } else if (obj_type == FSNOTIFY_OBJ_TYPE_VFSMOUNT) {
>                 obj = path.mnt;
> +               user_ns = real_mount(obj)->mnt_ns->user_ns;
>         } else if (obj_type == FSNOTIFY_OBJ_TYPE_SB) {
>                 obj = path.mnt->mnt_sb;
> +               user_ns = path.mnt->mnt_sb->s_user_ns;

The patch header notes that user_ns != &init_user_ns implies
FS_USERNS_MOUNT, but it'd be nice to document this with a WARN_ON() in
the code as well.

>         } else if (obj_type == FSNOTIFY_OBJ_TYPE_MNTNS) {
>                 obj = mnt_ns_from_dentry(path.dentry);
> +               user_ns = ((struct mnt_namespace *)obj)->user_ns;

It would be much more elegant if the type wasn't lost before this assignment.

Otherwise looks good:

Reviewed-by: Miklos Szeredi <mszeredi@redhat.com>

Thanks,
Miklos

