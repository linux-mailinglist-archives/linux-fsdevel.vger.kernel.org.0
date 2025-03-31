Return-Path: <linux-fsdevel+bounces-45395-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F20EFA77172
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Apr 2025 01:42:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AB023AAF99
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Mar 2025 23:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E328121CA17;
	Mon, 31 Mar 2025 23:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Reugdmz5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E131A3BD7
	for <linux-fsdevel@vger.kernel.org>; Mon, 31 Mar 2025 23:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743464548; cv=none; b=Zg1ZnUpfYQeHQruygDUCLP96+lbrxxYaj5PRKIkzjzssZZonsfER59PjTIEjdqFbpu6LFAXj9JJVeEnjdC2TFO1h0X4s55hwIqqjfwGgI5wnCgI1YEcIrefwk54De/JebVXWcy2SdalXu0+sJ3/mkwnLYqgIn6arQXq8iTv6Sxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743464548; c=relaxed/simple;
	bh=zUG1pDytIa3Xkrsgx5HyK/XS6po48aL0/RJZlqGKUrI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t3Yve7BCRgqaMV3sGkcKSMGF2XK6jvBnkhyVtQkEWZ2V2Kg4286EDdhFBGAXj4r/1/zmYJVq+NPlofrSAZfaQgk6xYS388rgpLH5atU7vjPwq8MT07A8D5yLPgm9LO+WikUZ+lWQWZ4W0vMLIATXF3ZjR7GRN1/etNGt1UHpDVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Reugdmz5; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7c5b8d13f73so527710985a.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Mar 2025 16:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743464546; x=1744069346; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MEhfVpzMDyeVM6fphyoH75923AvR3cvn19kuNAHXWto=;
        b=Reugdmz5u8ZGc9MZ7C99UMolM1D/3QKqnxmANBFrMQziPJfGlsg0tTp7P77vWZ3tW0
         VAtkAvRcgp/ljOeqQjyuOqi+4y2hfGzYeheB2wIU2UqrRGJZez0CnOJySrct8IsXFTPK
         8lhsD7WTnaUDdzEyuFIvbDLiPr7M6B0uyVyPm39LYf+EYZUijbFRmoQyOGS8z8ZJWVKE
         mXYUI9dfWq7/rHdoYkziFfhazDwwA/ObodWN/JiPrWZv76UGgjb59eLWIupcQIdgQt/9
         k9vfIx+gEb7O1Hq/umJaaarjr6+BjJwUF76GphV9xzEUcT85NLWhDTDNfNXPr9z8Bm+S
         2XyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743464546; x=1744069346;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MEhfVpzMDyeVM6fphyoH75923AvR3cvn19kuNAHXWto=;
        b=fCR0/LRIAgp5bNpOleJvZBskiVlwtT5brWstTRRwIKMIk+eGB6sjBIQvkVNXSlhpRw
         JlUxrFd4HaKJu2VrQMFCT5mIFyWeN9zc7VSbct/WPcRI5Nyo7VeiIY4fKFUM5IMmzMCf
         rW8cwv2iQc7OpREsVhw2+FFd1QbKmZHhBf9RB1SJoOCZksGLMwsspKHHTndvaz0EpRt4
         p77HH5R/UEHD8hCZ9428xEaY6SWvJ67JrecW7VEh843HpCjan/Tr4R2ZFFFCxO0zBb3v
         EZHCeksPe10FNWsRwS/HkWGoxwjITU9OI51xD/QxRWDvJK7ZQ79aIxzr7Ob4ig5/2AZn
         HTOA==
X-Forwarded-Encrypted: i=1; AJvYcCXoXFYXt6Ok41y7/3XP4mS0OiLoUj2EKElzrtzgd/guNqswqRqrYSd5UQAR6TjrSgd2Ejo2qRn4bnjmIPmQ@vger.kernel.org
X-Gm-Message-State: AOJu0YyOl+TiV59D5TjA268jzgzH+LBv4KomE0wmFlwjWOQs+8k4MG7G
	LbMHFs2lt5j3WnNXnS3iVE5vfdR/b05RKTEmjejsEjMPh/HX5vFX3DhZiMpDSLwRK3MhukDzqfq
	1Q/I/bLxiPEtB168IWml7DhtrGF8=
X-Gm-Gg: ASbGncu25sPFmM2puVFAnYfm/XIWTRFSK/ijLgFKWBEvFNnaiZ+NJoAekVkEK5h3RDp
	REuem3Rf+yaKsByVB3VVxOTPVeIQv9Xj8acoe3uSpjC7ubbshdI7W/VhLcyWQk4xBUq78o8jOfZ
	Shq/9qW4LSb6ZWrkudr4HzVNeArQA=
X-Google-Smtp-Source: AGHT+IHs2PTbmn/mg8sw/AgHrtpy+3MvDUyv+Jv1ew0n+NlGPvjY5uuLdhgADvLK5w0h7Cx33TyT3UI8QnqFGshdsF8=
X-Received: by 2002:a05:620a:4445:b0:7c0:7c8f:c3a9 with SMTP id
 af79cd13be357-7c6862e7948mr1511765285a.1.1743464545816; Mon, 31 Mar 2025
 16:42:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250331205709.1148069-1-joannelkoong@gmail.com>
In-Reply-To: <20250331205709.1148069-1-joannelkoong@gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 31 Mar 2025 16:42:14 -0700
X-Gm-Features: AQ5f1Jrx2sB3IYOhAVTTYtp4lmhxKUA2ENzcHAoxDd40GDTctHGH8H6yfqKGtxI
Message-ID: <CAJnrk1a4fzz=Z+yTtGXFUyWqkEhbfO1UjxcSk1t5sA7tr8Z-nw@mail.gmail.com>
Subject: Re: [PATCH v1] fuse: add numa affinity for uring queues
To: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org
Cc: bernd.schubert@fastmail.fm, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 31, 2025 at 1:57=E2=80=AFPM Joanne Koong <joannelkoong@gmail.co=
m> wrote:
>
> There is a 1:1 mapping between cpus and queues. Allocate the queue on
> the numa node associated with the cpu to help reduce memory access
> latencies.
>
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  fs/fuse/dev_uring.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> index accdce2977c5..0762d6229ac6 100644
> --- a/fs/fuse/dev_uring.c
> +++ b/fs/fuse/dev_uring.c
> @@ -256,7 +256,7 @@ static struct fuse_ring_queue *fuse_uring_create_queu=
e(struct fuse_ring *ring,
>         struct fuse_ring_queue *queue;
>         struct list_head *pq;
>
> -       queue =3D kzalloc(sizeof(*queue), GFP_KERNEL_ACCOUNT);
> +       queue =3D kzalloc_node(sizeof(*queue), GFP_KERNEL_ACCOUNT, cpu_to=
_node(qid));
>         if (!queue)
>                 return NULL;
>         pq =3D kcalloc(FUSE_PQ_HASH_SIZE, sizeof(struct list_head), GFP_K=
ERNEL);

On the same note I guess we should also allocate pq on the
corresponding numa node too.
> --
> 2.47.1
>

