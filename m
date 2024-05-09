Return-Path: <linux-fsdevel+bounces-19178-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 589458C109F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2024 15:47:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 861EF1C21D1E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2024 13:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2197F15B152;
	Thu,  9 May 2024 13:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="KS8Mmaop"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0E0152785
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 May 2024 13:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715262463; cv=none; b=lirVId/ccyLeomcRLn2DPFZwIO0dacpXqUsyBa/8ziFLsj3Mg6RCr38bpwB+HWtv7h85WTKQaK2T5bXdmfpsXkriuLJq+k8VCHduwQ7AUzjzvY26lIH1PEbX3bVJQEFLt588+eo9VbR0YGkKI40Yuh9NNr82B8f3q8AaqcZS6Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715262463; c=relaxed/simple;
	bh=RETi9g3+r5wXHI5l1JPoKKKaRBB9dOXDPB1Vwch6vbw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NYs6jQ/MRkLWnVjdnAnzu2c2x+fCOkZ670E9ATuTC1yF78mObzYcTJviioU8rAVSr/QdSQGiHYw7SJPbT5TsnNyE0bCmnzsys9W5v47UMvyXLSFuilZ0Y2AvOMqYEYcuuuVW7oJhLTsbnR9lt8IoP3emJesLw0JJGD9Biry11WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=KS8Mmaop; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-573137ba8d7so3712061a12.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 May 2024 06:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1715262459; x=1715867259; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=n24yA+2eOiAU6gH2a9RwXZeIZ19CI5VVzEp7nqGlmuw=;
        b=KS8MmaopLcJu2o+asN5NFQ++29lr1KuOfxDdnV/HCRBOZz+FR3wgnPWT4rENIX6RKl
         a9TTg27uLctD1TrIqXTTcAChHHYOERNNjGgH3khL2RKMMcAr/o4qm/IDd8t7Kz0k3+W2
         l6VHstSBux3Q0pYP3q4sumCCOXjw488SrvUTM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715262459; x=1715867259;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n24yA+2eOiAU6gH2a9RwXZeIZ19CI5VVzEp7nqGlmuw=;
        b=gc2EdmCa9wCeKZbRjFECwIgOtdJOvHpBlFkZ6f5csKF1Hx0roCs6DO1ZQjAfJYPumH
         QdLC+kGKdYM2siC9KHn+oZitfLXUnC88iqzrcn7EmErZZqv6UjaW8n9YHqXp18r2xeUi
         JdjyZDSPNoqcAHcFbiZBDvaGoFBQQYyeVmFKOnFpld+pFkSUhtRy5x7PiS/apqv/xHzA
         3sGpCHi44VRcswE7ob96wikkQ1k9rOs4SzOi1c//QNk7A21dJbz5UPaM/nMnCOAJPCtN
         mznEwOsDyFDJWrUSJUDD8u8RZQP0TgjcIYigCw3kLFluySNvAqSLueo6GwFraXfeiy/0
         NShA==
X-Forwarded-Encrypted: i=1; AJvYcCWacc/UdBm9MYSmz+6K0XvKoyyITqjmLFZVd/DU88MZ983EnYmkmh8hXzvuoa3rITsYcqf/mAz06SE1lszzQRL9cJL93/u8xwMCJBQt9g==
X-Gm-Message-State: AOJu0YzK3SddvF8PwC5celVGw9+hgBxnXRJr9+b60jjPS6R12S0lta5j
	bDTeTWypgtCJ698ZXOnooxdxsausS399PS65TdttSgEAMjaEzj3qQIBBnzoMA7gijt0AyBGgkgC
	7ANYXb6iIxyiDe6wE11QOjNa+0ENpNT5YNWC0LA==
X-Google-Smtp-Source: AGHT+IFRU2TN3cvYDm5UOElM1JrOzV2TUMhBcUkofqBRao5Djdi1wMhZy6Cx2xEAMbywxTGHlilCgw3VDtkuN8S1qG4=
X-Received: by 2002:a17:906:308d:b0:a59:76d5:3a14 with SMTP id
 a640c23a62f3a-a5a115be4c3mr207723066b.5.1715262459539; Thu, 09 May 2024
 06:47:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1553599.1715262072@warthog.procyon.org.uk>
In-Reply-To: <1553599.1715262072@warthog.procyon.org.uk>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 9 May 2024 15:47:27 +0200
Message-ID: <CAJfpegtJbDc=uqpP-KKKpP0da=vkxcCExpNDBHwOdGj-+MsowQ@mail.gmail.com>
Subject: Re: [PATCH] ext4: Don't reduce symlink i_mode by umask if no ACL support
To: David Howells <dhowells@redhat.com>
Cc: Max Kellermann <max.kellermann@ionos.com>, Jan Kara <jack@suse.com>, 
	Christian Brauner <brauner@kernel.org>, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 9 May 2024 at 15:41, David Howells <dhowells@redhat.com> wrote:

> diff --git a/fs/ext4/acl.h b/fs/ext4/acl.h
> index ef4c19e5f570..566625286442 100644
> --- a/fs/ext4/acl.h
> +++ b/fs/ext4/acl.h
> @@ -71,7 +71,8 @@ ext4_init_acl(handle_t *handle, struct inode *inode, struct inode *dir)
>         /* usually, the umask is applied by posix_acl_create(), but if
>            ext4 ACL support is disabled at compile time, we need to do
>            it here, because posix_acl_create() will never be called */
> -       inode->i_mode &= ~current_umask();
> +       if (!S_ISLNK(inode->i_mode))
> +               inode->i_mode &= ~current_umask();

I think this should just be removed unconditionally, since the VFS now
takes care of mode masking in vfs_prepare_mode().

Thanks,
Miklos

