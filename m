Return-Path: <linux-fsdevel+bounces-66854-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 00244C2DB13
	for <lists+linux-fsdevel@lfdr.de>; Mon, 03 Nov 2025 19:34:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 42F374F1669
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Nov 2025 18:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F4A5267B90;
	Mon,  3 Nov 2025 18:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M7PnUwF1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D90145355
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Nov 2025 18:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762194675; cv=none; b=EeQ4h9lmMMJrT7S8vyRD8QMmlsRUo+ocV5DagF0oKBZtur90Gj3f3AJTtoN+QuAr4tXz08v5k8qvXXzZzTO7/74dX23Z6q+g6sS9CykQxAEkfjk/67r+9aaZvkF1l9HRHXJiiExYzbf9/iZNorbIsQnvXeJvgNuPN8IDJNNd7jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762194675; c=relaxed/simple;
	bh=OPGO/1H2iTCRxm8R4jukSNwSpZk/lyTqRp/oYOMPAJg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qPVbQgvPVdqDWqO7mwssew+dwFW0NLxrqBci8XZQ1yd26PeyLjvz1vNP8G8/qufR76lyfa9acpM7XIPI0/qJ4jn/41nAeZZRHj8tMqNOl44eRo7g0nTgTz7ic9fstgqrbvzx61OP3lcMU+A0kVvwRyKVoYJUS8NTA2kZjxI+7Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M7PnUwF1; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4e8a25d96ecso80327031cf.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Nov 2025 10:31:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762194672; x=1762799472; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lD7dMGvmXzUrTEuHDHSXB72jBP0Wp8AnuqrzmdlwiGE=;
        b=M7PnUwF1TAon+b0fbeZUBMw2FQMLP9rMt0mePBQs3UE0Ksg/bErEaf2DQr0THalR0C
         l5nvNpjfFot4T2PLnFHA6WK0IlN23CUq9gMXMdHRX/3ffkeiSe5ZgDMsHQUoX7V9YrvX
         uED+U8k6XwfzvIMLtmALuDD0Nkhtvdd2/l6OSI74sWpuRxtRpMk+sl80JF+TqS1QUH6W
         7wYymRVDGRACNIwo5COvtINSQvuAeFSQDJjwOVEIZzR/G9SFGooWy0BNMpHj2CsE/VKv
         7y9HYCcIFGdslePHAItU4UP3jJNRB/MaJxtuVJfKMHvcBZdOj9LJjVVKNeMvXkKO0pKz
         yg+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762194672; x=1762799472;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lD7dMGvmXzUrTEuHDHSXB72jBP0Wp8AnuqrzmdlwiGE=;
        b=hO6vtH/AgnN1NtwN0uSLAcCuo1iw4TWYsfvBI5odTfI8WetJcbqRFyG7LoAeo+jlmC
         6vxCOMuiKNDA7Hr2LKpBqSDYLtRBX0JhnIOqqnriFZnruIFLcKIlJa4Rs28En0NiWQbC
         X80S2l74Z98pBGRvMaPoZBTntVOJA3+3f8xbS4TROwl3bdKIm0m+yM0PMwVyJORTtcTw
         OOXoMnlhUy/SCKSSVjIIUfFzt9+/AD5YP9xcGh5JtGnw2Wxwo1o7pF5jl4VNJ8jHgcNR
         KHBM4yc5d9fQsWjalk31ap/JQ9VwYhViUQFzXzsQ+CKwppgSn1BSZ65ftnXyPeGuQrAz
         0jlg==
X-Forwarded-Encrypted: i=1; AJvYcCW9lUB08eUN83petCup1t5uN9jNXDE2rq9LhPFCj03EL3PfJfndxr9bx/nIlSpYiKnowFAriSWP5TMRfIVs@vger.kernel.org
X-Gm-Message-State: AOJu0Yxza68pAkrdt8mLoCRen36UO22xLXTKMS5akMbUStKuMZGtsQ1j
	MBU5TtdKtC54Rb+jKTfENYy4Zme9QXEeKWWv1NAnmwgvax0/sEurQMiOD+CYAHcjp2O2IyDunsM
	9pcZQHRtneBi1P56o4b5MAjzVdi2feyFtew==
X-Gm-Gg: ASbGncu5V25ltJeifP57t/gDAmOLToIGeSfS9w550QtC6NQVKFfN42ol62cN/4oJujG
	oIT74SuVRs9GnUDwmODWOZcmen09lOsSXnZV/rY8FpF95icsXSE0DWiM3lK91y01qI72tgkiVUs
	p7SdsQBZSGvC0gT7qO0DD9YqGTpoMBRE+68vc0G7sQMHL1vmvOlIULtePt7uZ404AkoFOZBm9nD
	osrcZgrEdVp4bP+ETNCYyb4z7siTj7X2RIgzXIQusaOoCyh2H/eyHxG89M0BqaXln8E5ZZpAMyX
	STWaz9PJHwccGIRn0qLWvGGVBGA2sroU
X-Google-Smtp-Source: AGHT+IEzEPHitXAFzxg9rQGY+E1yohbGccQhoZwxFWa0WKOj4yZLegW+WUEK9FGonURs5Mbl+6EzEe/cT7RjDPsX3cE=
X-Received: by 2002:ac8:5f91:0:b0:4e8:a97a:475 with SMTP id
 d75a77b69052e-4ed310aee0cmr190519601cf.79.1762194671771; Mon, 03 Nov 2025
 10:31:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <176169809222.1424347.16562281526870178424.stgit@frogsfrogsfrogs> <176169809317.1424347.1031452366030061035.stgit@frogsfrogsfrogs>
In-Reply-To: <176169809317.1424347.1031452366030061035.stgit@frogsfrogsfrogs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 3 Nov 2025 10:30:59 -0800
X-Gm-Features: AWmQ_bkn2X4Muwa5YDwL9Za-RiF_QHq0X864fEq-zu6JPdwBbWdf06tO9q6nfDs
Message-ID: <CAJnrk1ZgQy7osiYfb6_Ra=a4-G4nxiiFJZgNLLZYnGtL=a7QBg@mail.gmail.com>
Subject: Re: [PATCH 3/5] fuse: implement file attributes mask for statx
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: miklos@szeredi.hu, bernd@bsbernd.com, neal@gompa.dev, 
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index a8068bee90af57..8c47d103c8ffa6 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -140,6 +140,10 @@ struct fuse_inode {
>         /** Version of last attribute change */
>         u64 attr_version;
>
> +       /** statx file attributes */
> +       u64 statx_attributes;
> +       u64 statx_attributes_mask;
> +
>         union {
>                 /* read/write io cache (regular file only) */
>                 struct {
> @@ -1235,6 +1239,39 @@ void fuse_change_attributes_common(struct inode *inode, struct fuse_attr *attr,
>                                    u64 attr_valid, u32 cache_mask,
>                                    u64 evict_ctr);
>
> +/*
> + * These statx attribute flags are set by the VFS so mask them out of replies
> + * from the fuse server for local filesystems.  Nonlocal filesystems are
> + * responsible for enforcing and advertising these flags themselves.
> + */
> +#define FUSE_STATX_LOCAL_VFS_ATTRIBUTES (STATX_ATTR_IMMUTABLE | \
> +                                        STATX_ATTR_APPEND)

for STATX_ATTR_IMMUTABLE and STATX_ATTR_APPEND, I see in
generic_fill_statx_attr() that they get set if the inode has the
S_IMMUTABLE flag and the S_APPEND flag set, but I'm not seeing how
this is relevant to fuse. I'm not seeing anywhere in the vfs layer
that sets S_APPEND or STATX_ATTR_IMMUTABLE, I only see specific
filesystems setting them, which fuse doesn't do. Is there something
I'm missing?

Thanks,
Joanne

