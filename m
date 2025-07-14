Return-Path: <linux-fsdevel+bounces-54870-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1CD6B04520
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 18:11:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFD114A234B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 16:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1504625FA05;
	Mon, 14 Jul 2025 16:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H9y+30kg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6CF25DB0B
	for <linux-fsdevel@vger.kernel.org>; Mon, 14 Jul 2025 16:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752509483; cv=none; b=nLxKPJXjJe7oNR3Lu7GYBvwk/aBaKzO5pUDl0LkUTsfKRZqnRNyfdStLLz74hA1tQONEZque4avaMq/aLtvEXgCNGOQmLryZw1AuJp+JwV6OABV7r70ttFJAt7VqRNltpskt31g9z1Qyi5HNEQ0m0H1jIlf0hfoVcFB1FNp44o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752509483; c=relaxed/simple;
	bh=vQjKQqQj7/0FRocDtrqvFlkmdQNJcoyjkB7/v8vcPLU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OaHw7ltk8mpzTL0hkCjo+OtnkYjBD09TA4TqtuD3GbvAjWCKmMDynwW4PNd2GFwQHqu/2ocB/CfDOjQof70fzstQUDbarp5+Y0T8LdJ4l33r1n28vbntmtNRtW3stFKOMlVKDc5V1KR52KJ3axw0K8VmwOMuTsYGjcrOa5MBRRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H9y+30kg; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-313cde344d4so4769060a91.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Jul 2025 09:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752509481; x=1753114281; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0TfSgDJeBP98iuDTDSKxBCCJTmDXTCi+E40UIkPN7us=;
        b=H9y+30kgZeQQxUjH6/JpblUyTnASYxvo8k91S12fRRhhx6qEDaE5kHbEH5LDjWc4E5
         SVKZDW8nhQDc7buUcZ3Xf1Sc0GQ2HNSXWKdbSixyw/AXYnoIYtHsBCeoU7TD+5n/YKUy
         7feN19M2KYTBNn2rqD74f1wDNZgd4wtWn5g0psc0snCrUnf0DyxGQznq7Fgp/w2fgvem
         AEZNAtQTIKxp7s6/fdlhLlWhHVc2AWxs5hcC1OpCg2Zonru6Mb2tJldLOA7iCvcX8np+
         oV6Zkoq8W/JESfGyKcIzAvZ/YqAM8t2S1YbUhdxDB4UHHjrpsNyhaP5z8Vg1Ii9n6v7X
         rROA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752509481; x=1753114281;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0TfSgDJeBP98iuDTDSKxBCCJTmDXTCi+E40UIkPN7us=;
        b=PYHJwhRCBqsGefNdH08l9759wrDgHkcQ9MJYEyq10RM2bdpi5AOnGFossYqDjSOqjr
         tCou3yxDfgqM3Wi8SJG0oE6DiZw8QfboGyYbDpUbKViC/yig0MP/7F+DSFKMkDLaQhR1
         gBBP4IJDB9nPGAW1RH6zoLze4y0N/1QC12x1b7ocDMiZ4IiuueN06jjP6A85Jimf3m+G
         d0lsK+rr/3jZxClnMmxPMfN/KB5Cz5KAobrMp2Oa5zh2xL0J0sJdfP8Ft0/KBr35BD7d
         YlkhXAb/yXGye+sBrS+/hQ6hLSD+6WOGqlUuAuRUIhX89H5Lj/Tw0qPzwRxLWnz1tgNc
         gwfQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+3UkuyENRd3jC1nygYJwoqDCe0gl1R8r+zRFPyU54N8y2cDAtRjHyqAAtAtsLmjGZUtAovUUi+c6PRLRS@vger.kernel.org
X-Gm-Message-State: AOJu0Yynd09oUwc3Z6YLVl2D6rzJBe7c/0hejbGMZYdOFKiCL+1YbRlq
	GtTCGYrCypfQcG5HN37q5IWEdz187UkOZkmARy/56z+7sO+l6eCdYXk0SLYUErp8VhsrUWvRHL0
	DzdfSfe2tLA/smN33B5iWVzuvUBWm1BC1sk5Jxd71
X-Gm-Gg: ASbGncsHD5vY6GhlFb5M6cQ9jxHDS0cnsxBHqe1rU6cRM4kfcPEkot7cx2OIICP/Apf
	DT7CGWG//bt3mMHkMW28eCjTRWNiUeE/m3cyMkTJVkrGtlc14Aie64GRFIAVnRj31YPVduW1Gsc
	XxCMtsjOZmuKP29rAZhVRUoVXgpM3KRFP34Ph3SgP1glrnZqPPnACAlS6seFh+qpe2q+3dTF7xq
	fdtTCmLjp0izch2hjZEF2UWYjUn5y04YcS0Gw==
X-Google-Smtp-Source: AGHT+IGi1lKzp97hb5nVKjsLp2Yc4PioYfFvtz13TEi2ODa2cHytGcZk5J9zzTFWV8PfG2ePjvzUGLBXY7BkNPMEZRY=
X-Received: by 2002:a17:90b:1d89:b0:31a:b92c:d679 with SMTP id
 98e67ed59e1d1-31c4f5e3054mr18709800a91.35.1752509481220; Mon, 14 Jul 2025
 09:11:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250712054157.GZ1880847@ZenIV> <20250712063901.3761823-1-kuniyu@google.com>
 <20250714-digital-tollwut-82312f134986@brauner> <20250714150412.GF1880847@ZenIV>
In-Reply-To: <20250714150412.GF1880847@ZenIV>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 14 Jul 2025 09:11:09 -0700
X-Gm-Features: Ac12FXxwA2_HHK63FHlPcihHW7Wr9zzuGKYWHs16ti9q29J1bNFJMl70wG0K_mo
Message-ID: <CAAVpQUBK5029mFoajUOYoL3aNTfJg0fqR7FSHViLvt-Ob4u0VA@mail.gmail.com>
Subject: Re: [PATCH][RFC] don't bother with path_get()/path_put() in unix_open_file()
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 14, 2025 at 8:04=E2=80=AFAM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
>
> On Mon, Jul 14, 2025 at 10:24:11AM +0200, Christian Brauner wrote:
> > On Sat, Jul 12, 2025 at 06:38:33AM +0000, Kuniyuki Iwashima wrote:
> > > From: Al Viro <viro@zeniv.linux.org.uk>
> > > Date: Sat, 12 Jul 2025 06:41:57 +0100
> > > > Once unix_sock ->path is set, we are guaranteed that its ->path wil=
l remain
> > > > unchanged (and pinned) until the socket is closed.  OTOH, dentry_op=
en()
> > > > does not modify the path passed to it.
> > > >
> > > > IOW, there's no need to copy unix_sk(sk)->path in unix_open_file() =
- we
> > > > can just pass it to dentry_open() and be done with that.
> > > >
> > > > Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> > >
> > > Sounds good.  I confirmed vfs_open() copies the passed const path ptr=
.
> > >
> > > Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
> >
> > I can just throw that into the SCM_PIDFD branch?
>
> Fine by me; the thing is, I don't have anything else in the area at the m=
oment
> (and won't until -rc1 - CLASS(get_unused_fd) series will stray there, but
> it's not settled enough yet, so it's definitely the next cycle fodder).
>
> So if you (or netdev folks) already have anything going on in the af_unix=
.c,
> I've no problem with that thing going there.

AFAIK, there's no conflicting changes around unix_open_file() in
net-next, and this is more of vfs stuff, so whichever is fine to me.

