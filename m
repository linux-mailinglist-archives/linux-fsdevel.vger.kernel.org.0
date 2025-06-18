Return-Path: <linux-fsdevel+bounces-52112-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8936ADF724
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 21:47:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D0497AE3B9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 19:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E54C21CA03;
	Wed, 18 Jun 2025 19:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b="WfjvSMoe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD53521A459
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Jun 2025 19:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750275982; cv=none; b=NKDXMCbV8t/35P/lBXA5qgE/Sq9Mvq3k5AEqzojN5OBYqeBibMTZK+SyZjj4bVW9T9/XoWSVx0A/QyJaSkomQlSj7t8D10INYlzP5OPCiqQMsXe+Cmd48/l0HZrKwlByTPNhsaf0D0UU/I018xpX5E6PApM94vk+BE7QPMT5oOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750275982; c=relaxed/simple;
	bh=QBmnPCRRjK1jj6lCJOADn+yHPiZbEqEbv6+U/db+y9E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=egRxTS4BVhasAvrtEy/hESSNhKhg5VerZNr8Rz0DLCh32H0V7eqhYgXgHC9LC0oD/B4mre+JJeM7x9ZRhGe33Hm6qVIRS4pV/+ptHGgXK8Yi+tHdCSAkxgIhy3bv273ihNZNTF43L3LawsGfP4kMB5TnTQcMLmaeHhs8k82wnPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com; spf=pass smtp.mailfrom=mihalicyn.com; dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b=WfjvSMoe; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mihalicyn.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5533a86a134so6307032e87.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Jun 2025 12:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn; t=1750275979; x=1750880779; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=l4BfG1f7tJb2ZipJnEaZW+2wg9hljbXF3K3946DcZTQ=;
        b=WfjvSMoe9rx8wiB84g4fhnHIbWhNI8fSuQ6tOAqryENRQF7GcAm0ySP1rrRZ1R4mmM
         F3T27FfiP+dVxWYLsCy9kxlm1S8I9M8+jlc2r9zS/NVrwtbxT1mYViMRuKuVDB4YmVe2
         EhKr+sIzHht1kl/XKh1YRJy76iwnafvq6CZC8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750275979; x=1750880779;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l4BfG1f7tJb2ZipJnEaZW+2wg9hljbXF3K3946DcZTQ=;
        b=UB8PbZlIEgqzSo3nTOgq0cDlD53lnfkcXIZFhGcg14JSoSz5jZXBnNry67OhT0aUwx
         ywDEow7VpnFDBxh8Tf/xoAFGGn68Se43pMAKEtrlg/AjrzJMA74ZqwLodWojh70nlLuO
         xGctnqBi+Xr8wHN5ACF6bKSTu2oveR3aQ6nC27G+yClFdvD+wW/cJgulPnfmL2u242/8
         LA5ebxHphK5M5Oh0ZhPiaC8B4X4Xucn0FUQDuEpWVXAhxi0Uvk5ZyaX86elRw9tEbBbj
         tuL3+6ZtWm22xjqO5OUFio4bpus1rviphhTkxxIaEr4UaiAAkMvLSdrfkRYqWrOICoeo
         TJXg==
X-Gm-Message-State: AOJu0Yz785Ew/7T571ppguE2aMo1DH87tZG/vlKZLpFfGUcKujX/s6rc
	b70yQ4coTHmxNxHtKz4Q76/kw9XSR+aCRRzBVyMNWm73jWhb3XDpVI1tSAKu/HdQ68SrT9Wxp1+
	94Brz+apTwtoFSOVt0TjLJgmynMYS4Fjksa22E1QAww==
X-Gm-Gg: ASbGnctl92FKyk1hycRa+TNzMcF5zw5mCRgtmQcEXHu9rkoZiQClP5VqJ4Ob8ORv8i4
	PmyoywWPF1pTANFBFpjfeWm0TKRkFSyD7Wjq3GRosNPAQYf2cIPYsUWSHvVMnN90x2kKeJVycqZ
	NN21N2MK1DaSC9mb/Rl6sAwG13GEHw0Jam0ZbzpR82vuaG
X-Google-Smtp-Source: AGHT+IF3SkxrWR7Y171o0CmM/c/K7IPz+v1LhYaESm2bm2x4/dKi+lzv895Kq7Gug6ACWLVVvaXY0V8zDk/LX4CwpRE=
X-Received: by 2002:a05:6512:230b:b0:550:d4f3:84a6 with SMTP id
 2adb3069b0e04-553b6f2b8a6mr5387061e87.33.1750275978619; Wed, 18 Jun 2025
 12:46:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250617-work-pidfs-xattr-v1-0-d9466a20da2e@kernel.org> <20250617-work-pidfs-xattr-v1-3-d9466a20da2e@kernel.org>
In-Reply-To: <20250617-work-pidfs-xattr-v1-3-d9466a20da2e@kernel.org>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Wed, 18 Jun 2025 21:46:07 +0200
X-Gm-Features: Ac12FXxZbEyaLIgTd9TayWQt-2zrN5w5UuM-elHq0Ced6nZG3jLOFD8UK7Z1s68
Message-ID: <CAJqdLrr=9pjcgLNu_jiLeGXhqUioQs0r9+j6z5cL_gpKE0_ueg@mail.gmail.com>
Subject: Re: [PATCH RFC 3/7] pidfs: raise SB_I_NODEV and SB_I_NOEXEC
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>, 
	Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>, 
	Daan De Meyer <daan.j.demeyer@gmail.com>, Lennart Poettering <lennart@poettering.net>, 
	Mike Yuan <me@yhndnzj.com>, =?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>
Content-Type: text/plain; charset="UTF-8"

Am Di., 17. Juni 2025 um 17:45 Uhr schrieb Christian Brauner
<brauner@kernel.org>:
>
> Similar to commit 1ed95281c0c7 ("anon_inode: raise SB_I_NODEV and SB_I_NOEXEC"):
> it shouldn't be possible to execute pidfds via
> execveat(fd_anon_inode, "", NULL, NULL, AT_EMPTY_PATH)
> so raise SB_I_NOEXEC so that no one gets any creative ideas.
>
> Also raise SB_I_NODEV as we don't expect or support any devices on pidfs.
>
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>

> ---
>  fs/pidfs.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/fs/pidfs.c b/fs/pidfs.c
> index ca217bfe6e40..1343bfc60e3f 100644
> --- a/fs/pidfs.c
> +++ b/fs/pidfs.c
> @@ -959,6 +959,8 @@ static int pidfs_init_fs_context(struct fs_context *fc)
>         if (!ctx)
>                 return -ENOMEM;
>
> +       fc->s_iflags |= SB_I_NOEXEC;
> +       fc->s_iflags |= SB_I_NODEV;
>         ctx->ops = &pidfs_sops;
>         ctx->eops = &pidfs_export_operations;
>         ctx->dops = &pidfs_dentry_operations;
>
> --
> 2.47.2
>

