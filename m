Return-Path: <linux-fsdevel+bounces-41712-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC03A35B27
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2025 11:06:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCDC21892831
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2025 10:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06CCE2580D6;
	Fri, 14 Feb 2025 10:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="eEaOnbWG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9617422CBDC
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Feb 2025 10:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739527598; cv=none; b=DfS8uuqw6U3udZe5evGP4dXfHqoeDYkqyk0A1QA7epHsBd9+sB1rPK+SKvVNYaWTZzvA++81Ls4M+g7ARsEGpEZukdxrBJvu+IkOFlFcPX1MTHdPewQtbch5vAEhSy5XXI//JR2cIS7dFQuk75Uw5Rit56dIgNVPx4My5ZWkmrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739527598; c=relaxed/simple;
	bh=Z2hQWnMO/cuxNXqdnzJgv5SA+gYsgmkuptio2Sc8Dsk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PHyUnrHiRaDvhOBr2ef90mKZPepwqi4RvJ4dVb3V9MpLceNfIHCP5aZPLkAnoFjV4V2gx2HPpXjIFYGWhdHcaXeZak/pwImekwyxbtUBojFMBi9GLmP9FfrSLIMdnCBLmPuCIMozRaWOMJxiNWvftDC7JxAx+SVXZEKFI5aHgrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=eEaOnbWG; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-471d1af90a0so2997341cf.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Feb 2025 02:06:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1739527595; x=1740132395; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xfcGPvuK2E3K4HbGI9BW41bEoS/vaYyRr9Y0bgqZ6+Y=;
        b=eEaOnbWGnIbQZ+8puvWVrdyteUQ+ux3kYU1f9OSReQFDaVlB1kHZz5DphAyniDgp6S
         S2mrSFq+xOoF3xp/lfz4c671W1Yr/F8MKtAeUZkOKGBFUbsd6F3rdLrTr10FnCoNudaB
         NdguVfvQ+qZ24MXqsNIi1bjkQy0BrKX7RpHrQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739527595; x=1740132395;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xfcGPvuK2E3K4HbGI9BW41bEoS/vaYyRr9Y0bgqZ6+Y=;
        b=Evvs/n/jpecvvnEKnR08LGbVNvDazAbdud2+pTDQmazOWjNWrvgZLSYOg0uPkTJ0On
         N2qNiYNx9cXfd/KaDhHSN7ZZ4Hk99+RBmlnynPO2sNqVYcTSIWSrfeS7xbxQyfMNRGkQ
         U9/USV/UztWFTXpPPuvXiFcg2qg54b04pNQrBA2xXGwjFXiIJpLboDd9FqYfRGUS4I34
         FwW0KCB1Lje8Ku9evPobQuQSDPUQGZVR+NbRnVsvJhhNAYD5tWpYm+AxBIGt+sZe3CkM
         2TlBEsIRCDrKd8X/qJyyJDo1KLY6dhrR35M8009/O1CJ/yNuI00Vg68MIwoBm0mJu16M
         YqvA==
X-Gm-Message-State: AOJu0YzCQGMHFxt6eiMzDlKgX60WWUPJlIJMFFBU8Rpc/khqLkiwBrCv
	skytpuylrEGyvE6F8FAvWruHqQr7UfaHGEMQ2NZIaH33aBQvvK34VRwosRL09WYyz7gE0+oRQM6
	xnEK/LzB6g8XPLkkGrf65ggdjxXCdovvP6uQMi8JVWY01HmKGUK0=
X-Gm-Gg: ASbGncvzFZoC2loAyI/m0U71vz5LFiZ3pCgZIsSQT0SWhOeJpBTSz/Vfjaz4rYqe3Uz
	M/5APYvCdXUAHYQkFJhf2EBS7UTJQ5tPjeu8wKNSdeFO0RfHohfgAKpZzrSpSi8pL/Wg3byQ=
X-Google-Smtp-Source: AGHT+IH9BCwJnBeiCDLpxtUf5qtu9S16bi3Qw6Q24rvoCdQf88eD1AI68lvaUEv+O10sqGS29QN5psqb0ylEQE11ETo=
X-Received: by 2002:a05:622a:164a:b0:471:a31b:2ed4 with SMTP id
 d75a77b69052e-471afef63bfmr167397611cf.52.1739527595439; Fri, 14 Feb 2025
 02:06:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250214-fuse-link-eperm-v1-1-8c241d987008@codeconstruct.com.au>
In-Reply-To: <20250214-fuse-link-eperm-v1-1-8c241d987008@codeconstruct.com.au>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 14 Feb 2025 11:06:24 +0100
X-Gm-Features: AWEUYZn7zwQ3shb9JZW2YLtEOBEI_Vd7AFYLazyP6GrkLTYJdws2jLrohVwysU8
Message-ID: <CAJfpegv0NfbLNcRaJP4Te8XX+EoKdA1z7i0CpeuE8Yc5r8f18Q@mail.gmail.com>
Subject: Re: [PATCH] fuse: Return EPERM rather than ENOSYS from link()
To: Matt Johnston <matt@codeconstruct.com.au>
Cc: linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 14 Feb 2025 at 02:18, Matt Johnston <matt@codeconstruct.com.au> wrote:
>
> link() is documented to return EPERM when a filesystem doesn't support
> the operation, return that instead.

Applied, thanks.

Also added the following optimization patch if link is not supported.

Thanks,
Miklos

From 150b838b03e887f4e5ffdadcffafef698e34c619 Mon Sep 17 00:00:00 2001
From: Miklos Szeredi <mszeredi@redhat.com>
Date: Fri, 14 Feb 2025 11:00:53 +0100
Subject: [PATCH] fuse: optmize missing FUSE_LINK support

If filesystem doesn't support FUSE_LINK (i.e. returns -ENOSYS), then
remember this and next time return immediately, without incurring the
overhead of a round trip to the server.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fuse/dir.c    | 9 ++++++++-
 fs/fuse/fuse_i.h | 3 +++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index f07ccaefd1ec..589e88822368 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1123,6 +1123,9 @@ static int fuse_link(struct dentry *entry,
struct inode *newdir,
        struct fuse_mount *fm = get_fuse_mount(inode);
        FUSE_ARGS(args);

+       if (fm->fc->no_link)
+               goto out;
+
        memset(&inarg, 0, sizeof(inarg));
        inarg.oldnodeid = get_node_id(inode);
        args.opcode = FUSE_LINK;
@@ -1138,7 +1141,11 @@ static int fuse_link(struct dentry *entry,
struct inode *newdir,
                fuse_invalidate_attr(inode);

        if (err == -ENOSYS)
-               err = -EPERM;
+               fm->fc->no_link = 1;
+out:
+       if (fm->fc->no_link)
+               return -EPERM;
+
        return err;
 }

diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index fee96fe7887b..3ad5d4b8f7c5 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -867,6 +867,9 @@ struct fuse_conn {
        /* Use pages instead of pointer for kernel I/O */
        unsigned int use_pages_for_kvec_io:1;

+       /* Is link not implemented by fs? */
+       unsigned int no_link:1;
+
        /* Use io_uring for communication */
        unsigned int io_uring;

-- 
2.48.1

