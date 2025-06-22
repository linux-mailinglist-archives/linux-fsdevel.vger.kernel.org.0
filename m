Return-Path: <linux-fsdevel+bounces-52419-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 654D2AE3245
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Jun 2025 23:15:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA3F918907C5
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Jun 2025 21:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DF021F7910;
	Sun, 22 Jun 2025 21:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b="NAoP+O+S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30847219A8D
	for <linux-fsdevel@vger.kernel.org>; Sun, 22 Jun 2025 21:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750626906; cv=none; b=L8f9z3PKteRnLoQ/SmhtZ6X/Zt6P4oRfFqjSvZ6IO9ldSoe39ZT3T9qrZP5hlow8fKogmbmkoboc5X9TfcN63xfeLaWpDHNEmWS7NclBREH+PQkbwHJ7BCsqj9ad7ZHEeqjkb/g+t9dzfm/+eFbXsdiH8R6+/SwVnLbhEegVVqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750626906; c=relaxed/simple;
	bh=2Hw/TBlC+21fi7s/iIkJBUwFZuN5UzQE762vafypzk8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SEC7lyy51A397bL+lGCgCmjMtNWJT1l+1Ya/a8eYhvzx1rBziy487iaUIq3KX14DZq1UWLuWRiG7QIAB2YOpIeNsynmRZmV4upA0GVAf6NcE+KpSPlrcb2hiqIEnOj5i7hkDxN6z8TY4GsiP46JIdVVheKVn1lvnsFrZH9ND45w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com; spf=pass smtp.mailfrom=mihalicyn.com; dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b=NAoP+O+S; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mihalicyn.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-32b435ef653so31876261fa.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 22 Jun 2025 14:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn; t=1750626903; x=1751231703; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KZJ2TlmDWwd3bmEt6QO/ggXCRxB9+Zi9/fKXRAjgEsQ=;
        b=NAoP+O+SNbVOVZRii/d4Pmj3nrLxr8GkKdMavTtOI1vCB3x6kaHVEDgH6jAt5KfXKe
         6kj5/4LTno8HSdu2ooJ/AOKJMilQCyijlDo6xid3EZpNcYyBTkmCFsNKnxGgiKsO9FJS
         l9XYhmMM0CiTF8pr2PveOaLcD7M29AlvNVJCI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750626903; x=1751231703;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KZJ2TlmDWwd3bmEt6QO/ggXCRxB9+Zi9/fKXRAjgEsQ=;
        b=N3V00I+VlXQ/17RerVGTvzyrn38+HbTCI+JJyLv3B094OPqv9kVpYr3qQJ6c/YPVye
         ZCJZt3nCT/F4w0NThdidS4de+QL6f2fR9oTPpOqFc1U73yoQorNG0uqN7ENyxxgWPs6O
         f++NuakMhi97HWRIF9iO4WvbcOVTmrpbc7kAhsbOV2pPxm5erKGU7CHLcjbh25gt2s9u
         m7QxUMIs6k53PXd6l3nSUuuqdRLW2K/uv5H1n6fmdx3y2ap3F1UqQb+Z4eRFf4YE0Ih3
         nveockv5jk1Rp8qCzA/vRs8xB933CpBle/Uuf5RyNuVXrskuJz069Ex65f0D4OE2WkQx
         koRw==
X-Gm-Message-State: AOJu0YxZQCw/OE5sbIj6XCwbqA4BRa+dtkRBJnG5WofX6MySixaaJqwR
	04ngXFaa9QjI64gfBQfjETPFE19jVwRYVzUgut8X672sD3a2Rca93xQ5uWkdVqJd2U5gJGdeKuf
	LOMCa4dlzRvL4wYFLj7/9IILey21U4X7h21DKmNzE5w==
X-Gm-Gg: ASbGncsFu/sIMy7p4ZRHBeWldHgfMa3OprLQynh7TZrB4uYiEcOEldJGzTBNGAPZ5pD
	/CqoaixNFhRubGCj3ZqnWag6Uhf7c9Cz4TTQKuvCp72HPgGIAug+CXPjg6QH8NfNkBIBr7v7cLp
	oGLPr5Ap9iqvrBRXPhmqZzsExx2AAQWnnEDowRMverQcAf
X-Google-Smtp-Source: AGHT+IGj/wXAi9xrtUad6vAiZ/vk/iKr2DjrgyGeUm8VGTbUXPIobl/fQ9vqrnb/hIGCuLP3VKkzyNvM7OtcigeioaA=
X-Received: by 2002:a05:651c:b8e:b0:32b:7389:583 with SMTP id
 38308e7fff4ca-32b98f0cf46mr21631921fa.17.1750626903039; Sun, 22 Jun 2025
 14:15:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250618-work-pidfs-persistent-v2-0-98f3456fd552@kernel.org> <20250618-work-pidfs-persistent-v2-11-98f3456fd552@kernel.org>
In-Reply-To: <20250618-work-pidfs-persistent-v2-11-98f3456fd552@kernel.org>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Sun, 22 Jun 2025 23:14:51 +0200
X-Gm-Features: Ac12FXwi8-_iQnm0EGJxRv-LQ-eSMmqljLyRmm-qOZkG7YKlOb4566z75PjXXV4
Message-ID: <CAJqdLrpx-oR-VGd=0yL-b_cQxuPqYafMJhjMNiK+Y85vvcoMWw@mail.gmail.com>
Subject: Re: [PATCH v2 11/16] pidfs: make inodes mutable
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>, 
	Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>, 
	Daan De Meyer <daan.j.demeyer@gmail.com>, Lennart Poettering <lennart@poettering.net>, 
	Mike Yuan <me@yhndnzj.com>, =?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>
Content-Type: text/plain; charset="UTF-8"

Am Mi., 18. Juni 2025 um 22:54 Uhr schrieb Christian Brauner
<brauner@kernel.org>:
>
> Prepare for allowing extended attributes to be set on pidfd inodes by
> allowing them to be mutable.
>
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>

> ---
>  fs/pidfs.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/fs/pidfs.c b/fs/pidfs.c
> index ec375692a710..df5bc69ea1c0 100644
> --- a/fs/pidfs.c
> +++ b/fs/pidfs.c
> @@ -827,6 +827,8 @@ static int pidfs_init_inode(struct inode *inode, void *data)
>
>         inode->i_private = data;
>         inode->i_flags |= S_PRIVATE | S_ANON_INODE;
> +       /* We allow to set xattrs. */
> +       inode->i_flags &= ~S_IMMUTABLE;
>         inode->i_mode |= S_IRWXU;
>         inode->i_op = &pidfs_inode_operations;
>         inode->i_fop = &pidfs_file_operations;
>
> --
> 2.47.2
>

