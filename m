Return-Path: <linux-fsdevel+bounces-38416-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 838DCA021F9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2025 10:35:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D92613A4131
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2025 09:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E45DA1D89FE;
	Mon,  6 Jan 2025 09:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="Cef+tCoE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4EFD19343B
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Jan 2025 09:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736156124; cv=none; b=Fan4l/Mv8fD7lYf/Q24FjegDDCeuPI8H9pDs/ym+KKXmBX+5nhqwdef9ZkfnHfTHMV3yUNuEE5mi7G4U1sVJFCx0Xd8032EO6pi/eW9/+03qXQKLzuzGOn6gKIhVdvr9rIy2nkAztdMfFWt8mt5GzLXNjLyXNmlOBC5y2G4qNgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736156124; c=relaxed/simple;
	bh=w63uveZeWBQD/HNPmKAva5GjzkovpK4A4siRrb12+hs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=beRulplgUrMZS8guBkZeJlKUeS+lO4rPiQH7cO5Roa3nnQIbEduRav/1DMYa3fJbj4AHloK06GHuFc7LLu+JcVm/r9F4ryomZPn+hUxePPbpr3tu05hzQNT1BfM1J776Me05bV7zdXTJ1B7EJv30GnCtz40zUkQuHUUIBQat7hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=Cef+tCoE; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-467918c360aso512251cf.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Jan 2025 01:35:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1736156122; x=1736760922; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3GT+fJuoyKmucOClKwSzufHgDCideXnmKzHy+MyLTE4=;
        b=Cef+tCoE7w2wRpcEJkyANpUv0+7vJrva/lhOscZss6E5CubSW2BI9roQ8NaG6pvPK4
         zq0a7vhn9W9eEvMAAkTO16BUPvqMc5O6Mg12PX/q8p9S684jecHJduQcZhrVMB1B+MD9
         BsaKsu5jZdIpjWVwtp2rH+QHrSXPIF6aZFGe0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736156122; x=1736760922;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3GT+fJuoyKmucOClKwSzufHgDCideXnmKzHy+MyLTE4=;
        b=SgEms0l7nniekS44L4hkcxrQ+ku+ds5CGyhadUVbpoW1XWrjLGzY+rh44PPKDZ0dkj
         bZr9V7lJV5bKq4ZjlJy1zcqCi442DgzYq02OY/p0uObR5iKByYskD+kFlC4Y0pLAbaaw
         K2PoG0ZkdxRRqaPoZ6fYvtaUbl3pKqVXzj+HutisAP7Ib1BbLL5WyHLWTtoR7sBb7tjm
         12i3ulFW3/89ZJlb5rIH5yAm9tUn5ECaZoTuDjMm8KT1xC155KCtbVyuQUT80XI3CiIH
         ylOX8TJdn7MBvWIYGzM/bLXIgzKxhHVYh1spmrzrFWQ1XwY4650PVKoXjKzgoaRwdZEX
         jJDg==
X-Forwarded-Encrypted: i=1; AJvYcCWkE6uTjXZbAExVXPTK49dQBaGPQD2oRZE+M6BfvBd6hI3vpN1s4bAOaJYnc/MoNZQ1KslUY45pUDzItr2M@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ4EYSwkAuy0Qx1yzzcb7Uin4iSfUlps0Wm4oLWssEgQsCGHn1
	SgBCWT0YeLrw80oy+31wPM8PewgYIHlzRwqEiK0CgG5uA9kxalWf3l0nM3GJNuY9Jlh54klZ0E5
	M3LjiMxEs8K8y3fKRylbn7nl31pvpCmqrrO+X8g==
X-Gm-Gg: ASbGncsvlL+4FBUOc3krZci91d8ssV30l9yFHuPY3GU5rrkL9tfyNFk2Nw5WKHStyHi
	q/FhxdAThMpeA42btcfdq1KiEb9gA/96nkRagTQ==
X-Google-Smtp-Source: AGHT+IE6irq48MUqci+6lf2d9Tj3o863iYnF7bkHlPT8ACSFD0adZ7g2KEl7i9cwVNjYclPa9C69jmvruAEeXESkB0A=
X-Received: by 2002:ac8:5a0a:0:b0:467:5711:bdb8 with SMTP id
 d75a77b69052e-46a4a9a34a6mr1082016191cf.46.1736156121895; Mon, 06 Jan 2025
 01:35:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203-fix-fuse_get_user_pages-v2-1-acce8a29d06b@ddn.com> <b92d40c3-920e-4b19-888b-fe4121865eed@linux.alibaba.com>
In-Reply-To: <b92d40c3-920e-4b19-888b-fe4121865eed@linux.alibaba.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 6 Jan 2025 10:35:11 +0100
Message-ID: <CAJfpegtE-D+68ee0XtBfxqiUS9GtJL7bvc+-YkFh748MRyzzjQ@mail.gmail.com>
Subject: Re: [PATCH v2] fuse: Set *nbytesp=0 in fuse_get_user_pages on
 allocation failure
To: Jingbo Xu <jefflexu@linux.alibaba.com>
Cc: Bernd Schubert <bschubert@ddn.com>, Joanne Koong <joannelkoong@gmail.com>, 
	Josef Bacik <josef@toxicpanda.com>, Christian Brauner <brauner@kernel.org>, 
	Nihar Chaithanya <niharchaithanya@gmail.com>, Miklos Szeredi <mszeredi@redhat.com>, 
	linux-fsdevel@vger.kernel.org, 
	syzbot+87b8e6ed25dbc41759f7@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 6 Jan 2025 at 02:58, Jingbo Xu <jefflexu@linux.alibaba.com> wrote:
>
> Hi Miklos and Christian,
>
> I find that these two fixes for 6.13 [1]:
>
> fuse: fix direct io folio offset and length calculation
> fuse: Set *nbytesp=0 in fuse_get_user_pages on allocation failure
>
> are still out of v6.13-rc6 mainline, neither are they in
> "linux-next/pending-fixes".  FYI in case of they got missed.

Thanks.  Will send a PR to Christian shortly.

Miklos

