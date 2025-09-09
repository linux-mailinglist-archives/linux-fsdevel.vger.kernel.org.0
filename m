Return-Path: <linux-fsdevel+bounces-60656-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E796B4AA26
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 12:18:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDFF14E1110
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 10:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 588D131AF15;
	Tue,  9 Sep 2025 10:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="blIsjtyN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144DE3148DE
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Sep 2025 10:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757412899; cv=none; b=l3sW0MxXB6PAbhbPH9DRW6+D3VCanRX9oIfgBEO/76l1qUjtdyrJLpX7CKl16hqUHQBpySNfuERsYf1oacAKCnDJRy139095W03M3GQuuT6tQsH6gQOdo0pO7o81HqZdo0ZVW0K433XYHA2Eu0xZci5iVRXSGgyowElfxdXDEGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757412899; c=relaxed/simple;
	bh=7+BKR/YiZDgO2+K9+o1l7kI7VEX7nJPrRZ/V78kHI5M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zeuz0YqKCrA/spFwo6XpkaFtBkaRp5kVGiXInxtlrqE0Z8b5sZNhdV77Dl3MvfUyMdNhngjIicI6QVATUVMBAxyuaNauErpEvvC2/H6uhC0VnZO1O/BLzTINoWwhMenflwhTau2H7nByhKlSODxWfUd9xGq37nCKTbH8vDXictU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=blIsjtyN; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4b34066b52eso52457681cf.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Sep 2025 03:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1757412895; x=1758017695; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=trd5emPo+HlVsYN0vUIy9FtYIJMXc61Ws1CJwyPKLrA=;
        b=blIsjtyNp99P/PFKw0hdZGmXVEg4Dv6Dn1PSDeSQ0tAZwYRlA/AKEc6hPznn30IbOf
         FCnstER1Vf3iDORuRE3C1EVpwY9HJYmYPtJ7qgSsobUh387b8tY3St0dnoreoqU/73t7
         YVhrjbYMlcm6K3rKqbffWTZPKl4hppidCVMZc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757412895; x=1758017695;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=trd5emPo+HlVsYN0vUIy9FtYIJMXc61Ws1CJwyPKLrA=;
        b=iEIOMopGPkEVKTYXk1CP4/q2/Tjd8hCo79LDwri1rFbxrPt5N7Hglp6ISJqFY0Zq/5
         JxY7/rt3EltF0C+dY/5vROSyuWpfnWhs2n5LEH8rhgCPA4z6VR89gD3gdWKZZ82RE6Q5
         LajkdY0NukufHzKd1KilA8P+d8g6I8n5pTv37TcnJjsSufQR58z3wJylkwUqqyesfBws
         tGA4fuy7o1MWyJCjJ8hF4sbsiXfxxfYWhQeohPWPqwspIHS01YY/RH2rIbD+/e/Al0/5
         Wth8VOXA6+5mXMLL0/8UNKl6zAFQJaGkJ4/+bPtTPWD38qqng6XzyPITBifqMlCzlCy2
         ugJA==
X-Gm-Message-State: AOJu0YwASd6uVEj1iBSZdX/Kp0yVo0QohWJoHkaQ5fCeny28O/3LCZ8c
	qdDOtMAANhIu/f7naTkAbmLmwDwh/ErjCt9itEbGUNwlDvVmiAHNhLiaWKu1Y1mtdNiaPJEUPTM
	xzfeD9p8JhUntwmyHjfJrvzpZjPukkOaRcQagdkjTTw==
X-Gm-Gg: ASbGncsq+Ot/lfrpd+rWrFlsb9JwnmqB4lZbapuHCcUVf1sdzSccpQlunWXTWH0VXn0
	eLiw9DO1L6JynALG6sqYSMz8RQyhiJ2yszgMvxYK6VClSrihmgUlexFEIvs8aWSiiSlQ/ip/RD5
	hgYNfxAvR9XwRpypy7RKRYwWRkZfHnI0Dg/5ZX9MtrjiDeQHz1aCAfJSayo9nnL7rKyeYKJNk5P
	1cV23y0/akkRgGRqfpB+zjB+VOL9qxMg5KqkKaFXSsH0CuzNwOd
X-Google-Smtp-Source: AGHT+IG/AJuvu4vnGfxes+LvOQgIJba1gfoc7lEPVLab1sR9m+HJCOS7MKfx4daIJeXKeOXFGyNQJzrAR3CScCwD5qE=
X-Received: by 2002:a05:622a:347:b0:4b5:f7ea:948d with SMTP id
 d75a77b69052e-4b5f8390089mr140472431cf.19.1757412894793; Tue, 09 Sep 2025
 03:14:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4a599306-5ef1-4531-b733-4984d09b97a1@ddn.com>
In-Reply-To: <4a599306-5ef1-4531-b733-4984d09b97a1@ddn.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 9 Sep 2025 12:14:43 +0200
X-Gm-Features: Ac12FXyF2bB0YVwmoCnif-61h2GIXoZzJtpGYk2ok8GTEq0Jq8So1hs_XHgZejY
Message-ID: <CAJfpegs2YGe=C_xEoMEQOfJcLU3qVz-2A=1Pr0v=gA=TXrzQAg@mail.gmail.com>
Subject: Re: [PATCH] fs/fuse: fix potential memory leak from fuse_uring_cancel
To: Jian Huang Li <ali@ddn.com>
Cc: linux-fsdevel@vger.kernel.org, mszeredi@redhat.com, bschubert@ddn.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 9 Sept 2025 at 11:50, Jian Huang Li <ali@ddn.com> wrote:
>
> fuse: fix potential memory leak from fuse_uring_cancel
>
> If umount or fuse daemon quits at early stage, could happen all ring queues
> have already stopped and later some FUSE_IO_URING_CMD_REGISTER commands get
> canceled, that leaves ring entities in ent_in_userspace list and will not
> be freed by fuse_uring_destruct.
> Move such ring entities to ent_canceled list and ensure fuse_uring_destruct
> frees these ring entities.

Thank you for the report.

Do you have a reproducer?

> Fixes: b6236c8407cb ("fuse: {io-uring} Prevent mount point hang on
> fuse-server termination")
> Signed-off-by: Jian Huang Li <ali@ddn.com>
> ---
>   fs/fuse/dev_uring.c   | 13 +++++++++++--
>   fs/fuse/dev_uring_i.h |  6 ++++++
>   2 files changed, 17 insertions(+), 2 deletions(-)
>
> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> index 249b210becb1..db35797853c1 100644
> --- a/fs/fuse/dev_uring.c
> +++ b/fs/fuse/dev_uring.c
> @@ -203,6 +203,12 @@ void fuse_uring_destruct(struct fuse_conn *fc)
>                 WARN_ON(!list_empty(&queue->ent_commit_queue));
>                 WARN_ON(!list_empty(&queue->ent_in_userspace));
>
> +               list_for_each_entry_safe(ent, next, &queue->ent_canceled,
> +                                        list) {
> +                       list_del_init(&ent->list);
> +                       kfree(ent);
> +               }

Instead of introducing yet another list, we could do the same
iterate/free on the ent_in_userspace list?

Thanks,
Miklos

