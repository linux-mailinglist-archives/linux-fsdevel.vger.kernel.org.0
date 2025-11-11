Return-Path: <linux-fsdevel+bounces-67971-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41362C4F025
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 17:21:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FCB03B72E9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 16:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4780536C5AB;
	Tue, 11 Nov 2025 16:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bXWWicQC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27366364E9A
	for <linux-fsdevel@vger.kernel.org>; Tue, 11 Nov 2025 16:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762878060; cv=none; b=A8wVzXlk+YQeIUezS68Q2+AFIvh91WFNc3xssB1Ffd4VzN6f21p7J4smIU4ihDHUEa0AcwLWVdlTmM7zXKwj9Bxq7INnLX0kShcd35OxPoLvh24Ro/IXZJmFErVYMueNlxV7aTxa8NBzCFCPxK7ec4nilNUr9cmfFwCVtPkX/4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762878060; c=relaxed/simple;
	bh=3ucEiOfLKgb7okcKL0HP1li5Wut0HDdF9YfITezYGeQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ftj7COXoytmtOBZaJgehPDlrgA9N+hA9lPuYr0xXgo1zTkMQsAPLSFZt//qXMTU16wJsGUwUL+o4l3Cf4Enmd/F2bk8qVhyIqFl6ycBL7RrRgoYPmJcdLzpVYvSwsW3BZ9+BjFKVn0I0LVS3exEq+MS80/tCOoyGhaXCUgGPQGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bXWWicQC; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-431d824c8cbso199075ab.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Nov 2025 08:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762878058; x=1763482858; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0lujxXLJQIs/1fMr9wnpYhmMZiP7/CAmNV72V4s+rx0=;
        b=bXWWicQCCI1NVuvdpiXUJFgSi/2S3dliDDXf2zGoRQBszb9bpL36H/8ctkOqC1g7QR
         g2zja7KuDFb/qUbgYAVvYLMPttGbvfEMORLpPZezgGpw0mChhjgGfKopaAo2+pAf/K9r
         kHhxo281biegGH888D//9xxiUT0YEI6tCSpVYu0XIdYBIzSyA+jIv7C2nIASMWYFxgLl
         /ZsW3xigz5t8KKeqHdnCrzq07a2XE5nlrK8K8WsPa9fZidZIWt+T8wtUBCZV6ZvZsZ42
         /7pt7f+T4BKtukMGJTC3lnO758ygQn0MWOoLswoi1JmBxx+8blJe6rFsQpOXvCTVyYCV
         9z9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762878058; x=1763482858;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0lujxXLJQIs/1fMr9wnpYhmMZiP7/CAmNV72V4s+rx0=;
        b=e46B2qc7riAmgCKQddDi21ECp7xkaudm2ook69icDd973D9OC7Izv8P17k2vS1WDAb
         O+X1Pl7AGec1xfdayvnOVmYjN6/V2kbBb+6WMpDtPCyxmbPbu1IRRW/107yEcSoCwjsv
         lWxNrlFVaJzEIBQHOdo/9WOwHCDkfZFcAwQFYCBbTapsR+pOh7FWf05Z5FNsy1SfS453
         ThuRJ8/z5VYhPkOtV1EWVWWrehtW+6oWwFL6d1QHi4o7tZ5oX3XzcmqE0+9regzy8nm6
         fIhjV1On3nW9FpnZFESBZu+pRl02a6qt+o/e1fNk981Pkr/7p4tjYb9PdQkVoyMQ4K9L
         ymAA==
X-Forwarded-Encrypted: i=1; AJvYcCVC1aZmZN14RG3buUnZAHZZ+V3C7SQCqlj3BRhVSjFHXZuExAkLkezEqsR8wFdmGuORmRrpYRYf9ME9rVgQ@vger.kernel.org
X-Gm-Message-State: AOJu0YyyklvWHpHLiUGT8Rqr7ZB6Th/vqdAK+0HniFIS/TaKeqHlaVC0
	qB4ZYG1yoq/bNzNRdZd38bE17pblzYZsoQGpKVBbuRhjyncaL0DBD4X6MAuT0ifBKuDO+RLWZKM
	0oe3F5juRNv/c9TOYJzRj4odZttpdJpx79VPRxXaL
X-Gm-Gg: ASbGncuf6FLZlLHLmpQ3BkmcVxp0Uc47FWuq3QKUuSCxZYiqbIEis2VbqOqX9CWHEYf
	Lsof5oVkcJ2x/e6XP0wAo8XbqjJkJRsc09T83FMbBmCfs7si3fcGGsHx8TsMBLPFdr7Nue/C/Q8
	eul7d9n3JzMb+ZIEmwcNJPNCACeAKik/SYPuzkuDyp1/qlMuSqr8cQYT9Tyq62txlYkgzpDPPlD
	hvFoYnGr6HOnT8GSBf161wdNkoXj6KmCz+DiJYqfxAB7VY8Blex7cTyGPZjypswaPRbPXtc5YIm
	qyXZF3c=
X-Google-Smtp-Source: AGHT+IHurGNVVBdU/NzdCYlOb6sZVxCFf3XJcmvsONpMJvPgax03NCfmaJXep8GUrwJthMRwu/u8+YkBRZaU5SmPgJw=
X-Received: by 2002:a05:6e02:3289:b0:433:138:eb18 with SMTP id
 e9e14a558f8ab-433be4aa427mr7299635ab.9.1762878058046; Tue, 11 Nov 2025
 08:20:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251111062815.2546189-1-avagin@google.com> <20251111-umkleiden-umgegangen-c19ef83823c1@brauner>
In-Reply-To: <20251111-umkleiden-umgegangen-c19ef83823c1@brauner>
From: Andrei Vagin <avagin@google.com>
Date: Tue, 11 Nov 2025 08:20:46 -0800
X-Gm-Features: AWmQ_bkLiXV5lJ6MfoofQgJ668iYrumTv_Un2FnwFwIhq_aBfOusso0zufkwo_Y
Message-ID: <CAEWA0a5ZjWuyFM9b6076GT6yEn0jYZu06C=huPxpqyxWQiM7QA@mail.gmail.com>
Subject: Re: [PATCH] fs/namespace: correctly handle errors returned by grab_requested_mnt_ns
To: Christian Brauner <brauner@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

)

On Tue, Nov 11, 2025 at 1:13=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Tue, Nov 11, 2025 at 06:28:15AM +0000, Andrei Vagin wrote:
> > grab_requested_mnt_ns was changed to return error codes on failure, but
> > its callers were not updated to check for error pointers, still checkin=
g
> > only for a NULL return value.
> >
> > This commit updates the callers to use IS_ERR() or IS_ERR_OR_NULL() and
> > PTR_ERR() to correctly check for and propagate errors.
> >
> > Fixes: 7b9d14af8777 ("fs: allow mount namespace fd")
> > Cc: Christian Brauner <brauner@kernel.org>
> > Signed-off-by: Andrei Vagin <avagin@google.com>
> > ---
>
> Thanks. I've folded the following diff into the patch to be more in line
> with our usual error handling:

The diff looks good, thanks. I have another question regarding
7b9d14af8777 ("fs: allow mount namespace fd"). My understanding is that
the intention was to allow using mount namespace file descriptors
(req->spare) for the statmount and listmounts syscalls. If this is
correct and I haven't missed anything, we need to make one more change:

diff --git a/fs/namespace.c b/fs/namespace.c
index 9124465dca556..3250cadde6fc4 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -5738,7 +5738,7 @@ static int copy_mnt_id_req(const struct
mnt_id_req __user *req,
        ret =3D copy_struct_from_user(kreq, sizeof(*kreq), req, usize);
        if (ret)
                return ret;
-       if (kreq->spare !=3D 0)
+       if (kreq->spare !=3D 0 && kreq->mnt_ns_id !=3D 0)
                return -EINVAL;
        /* The first valid unique mount id is MNT_UNIQUE_ID_OFFSET + 1. */
        if (kreq->mnt_id <=3D MNT_UNIQUE_ID_OFFSET)
@@ -5755,9 +5755,6 @@ static struct mnt_namespace
*grab_requested_mnt_ns(const struct mnt_id_req *kreq
 {
        struct mnt_namespace *mnt_ns;

-       if (kreq->mnt_ns_id && kreq->spare)
-               return ERR_PTR(-EINVAL);
-
        if (kreq->mnt_ns_id) {
                mnt_ns =3D lookup_mnt_ns(kreq->mnt_ns_id);
                return mnt_ns ? : ERR_PTR(-ENOENT);

Thanks,
Andrei

