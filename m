Return-Path: <linux-fsdevel+bounces-10013-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF30F847013
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 13:19:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 634B41F26AD1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 12:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61E0A14079D;
	Fri,  2 Feb 2024 12:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="FCnvynLb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB40E1419A2
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 Feb 2024 12:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706876388; cv=none; b=iXUXEXQbUlX4kSJB0jr1cg+hXHR2sIj9AMdA8gQi82m/F1zQchQxiJ7n8Ij3uSStzEZ4651v2mdmE5+20s5KlCsSSqUfLCjjZNVy9pTDQrJPD35iJVTdGgTSyZlJ6feXw9JVbHyW3iMxFFRpC6AIUttRCtVUqA5SZjJrTTf23c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706876388; c=relaxed/simple;
	bh=5hj8arzg/kd3VZoNZL5jFI8jc+DYOemsfmbYbJ/OykU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ddh458cbynynMZ9aJiJA/Co0iiI7yPxua3NaQV6egFRsPp/xz3DChav6Fj6Ys7UB27L7MiMG0PpyCVX0b2CLwYVT/sYoi0950b/FY5122A8g9joJlERu2iZPavMRzEHEQjuoqurVa6yqttLUvHVtIw6meC5a40/F76nRLpUajy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=FCnvynLb; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-557dcb0f870so2892258a12.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 02 Feb 2024 04:19:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1706876377; x=1707481177; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LFP84Zrmnc+wlMdD8DIoxjiCigtXFMKoOTPi2WgaEVI=;
        b=FCnvynLb2HfyZrMuxl7Ds9QkCMDQvBB5aIj1qY6beCYhJOh2i0pRnO4ifvYsPyCVpT
         7UWqgDljq7yHvF3dsqPBOZXtie1zOA185tfzRMwH7BC5wTsfE9BnZGsg1h0ekesRNtOx
         qsoz/saloZbH7AxJFxNTSq0JevzVkPoBNV9gM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706876377; x=1707481177;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LFP84Zrmnc+wlMdD8DIoxjiCigtXFMKoOTPi2WgaEVI=;
        b=oPSkBM35w3mbGQHjZI0Qi4lR6tKZex31dqohDORD/7Rkwtt82GiTyRL9g0BUf6DhYQ
         rcn2JIfe7PQOf+21I8RyTbHenmbv+GwVlp9eA46gX8psJK0116dExhYquDj3IyA5NgbQ
         FD3JN1FOEfaBDVVM4v8pDRUXQnWSc3oX4AZfQcFc3uCYJBOfIFDIMyD66DUXGdYO5JR9
         oOsz+ZdA8d1h/c/gevXAI5FyY8WH7TkWiI+9sXLleByHTNlVMduYBNv04AZ4jXi61YtS
         xG2if2HT6WROh7bH09s2Tl+b9gKvc1lZZ9jXkqI+kXmQrti3AvfeZaDh7JWc2zCJuoTd
         XdHg==
X-Gm-Message-State: AOJu0YwX/yV8tgyKZjDVmA2BN6ka57IOm3qFqhxk+QHM/Jkkn0rbYUt7
	zoejVnNT94CcMyR5JnVq/Ynj0U4dgO2U6Tj291noh4ByQ5nyYhma2a0pNl5ywb7COoMkA0+Vl+D
	YCdXJoZyY1QhWam7QHctaNvNX113OafzHwYVwIA==
X-Google-Smtp-Source: AGHT+IE0f2aO085cH3xmP9VanflnkDeHUQnAqufqusFiaFr70CRd6j+Bz+dipUFrBk+UzO7Pa5H1MDK+TckxWx/Siqo=
X-Received: by 2002:a17:906:f117:b0:a35:4ee9:7f12 with SMTP id
 gv23-20020a170906f11700b00a354ee97f12mr5466933ejb.50.1706876377331; Fri, 02
 Feb 2024 04:19:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202110132.1584111-1-amir73il@gmail.com> <20240202110132.1584111-3-amir73il@gmail.com>
In-Reply-To: <20240202110132.1584111-3-amir73il@gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 2 Feb 2024 13:19:25 +0100
Message-ID: <CAJfpeguhrTkNYny1xmJxwOg8m5syhti1FDhJmMucwiY6BZ6eLg@mail.gmail.com>
Subject: Re: [PATCH 2/2] fs: remove the inode argument to ->d_real() method
To: Amir Goldstein <amir73il@gmail.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Stefan Berger <stefanb@linux.ibm.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	linux-unionfs@vger.kernel.org, linux-integrity@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 2 Feb 2024 at 12:01, Amir Goldstein <amir73il@gmail.com> wrote:

> diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
> index d5bf4b6b7509..453039a2e49b 100644
> --- a/Documentation/filesystems/locking.rst
> +++ b/Documentation/filesystems/locking.rst
> @@ -29,7 +29,7 @@ prototypes::
>         char *(*d_dname)((struct dentry *dentry, char *buffer, int buflen);
>         struct vfsmount *(*d_automount)(struct path *path);
>         int (*d_manage)(const struct path *, bool);
> -       struct dentry *(*d_real)(struct dentry *, const struct inode *);
> +       struct dentry *(*d_real)(struct dentry *, int type);

Why not use the specific enum type for the argument?

Thanks,
Miklos

