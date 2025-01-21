Return-Path: <linux-fsdevel+bounces-39769-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18EDFA17D81
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jan 2025 13:07:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EF2A16B7AC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jan 2025 12:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE0AA1F1902;
	Tue, 21 Jan 2025 12:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="K1JNRrfd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3585C219E0
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jan 2025 12:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737461272; cv=none; b=iNlYCwtemMDCtohhQ2EZU0B9y31djctG56v1RQAw0efsvwzHbsaSJQCmGsQ9mzpsQUeQLDY7qWeMiiv4THJ50eJeo69x8yl3xf5Osf3OwXhEkuMXgjmVFGV9f2/BtkVXKANpg3aUM6ubtEO3XOXf2W4vMuK+g/FRvzHL1LFP3zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737461272; c=relaxed/simple;
	bh=LyeCGga5mFiOTeKMNJd54mF2vFHyUNSbrw5kiar1daE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hLume1zGjXKcy2ZScb22xPxE0izPB/Izaqi9kZRSzbfVpIfGO8VdXDsV/+XM1czUqrro5GR+WMOmVae3i21nlbJzP71muajJ2RWmNLKTseyIAVt8DTblVlhFB9S0lHyMLj8JIB7WLsl0kU8g3ZDVUxviPpn4VkHawKwf69f2xCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=K1JNRrfd; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-467bc28277eso47851101cf.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jan 2025 04:07:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1737461269; x=1738066069; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ALusIztD91eWA27jWtx8UKeHq3oU3JooAPr/0Pdlaag=;
        b=K1JNRrfdiWut5WraxX/SsH/fSk3mwVWNkl5nSnUkAP1HpWDUav+PnhsXQPy/qG/B1s
         xa7/evO8kgtkulft087+1DRDkW3fB/FcYnT2MMkGsulxk89fWtIZYe4FEJ5KpkgzMloO
         AqwuCg9uw+GqBb1uL1IhkB9jT9PvDOEaowSkI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737461269; x=1738066069;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ALusIztD91eWA27jWtx8UKeHq3oU3JooAPr/0Pdlaag=;
        b=e8PBjGCoJDvgotyWTnferJSxR9f6HcfQO6PVo9nPEpqKInFYZqVclEcsy0mqP2XPxy
         jY8bsNPa0RAfxoHRheViWaEWZjpELQApGYa4RxflmXwNV2z5FIy7O6LztkK7o61l25dD
         nx1m6FansJBr5DyFEjiJXkFSj3mTbNQMP8FpTVPvegV98DcJfB7M3widcerHawEjbxuC
         6Sg+CIe+Bc9qp8wqATUV+zzLkEnoIymgeZfbtHaodQrhe7O3RBwszeDsTRgXbDZhsNF3
         Mkx6LsiUdPcxIiWql2AICMZfgrXrBisIVOj/Sv5QKzXpYC+IfOgeXvZexGxTiRH76lN0
         sj5w==
X-Gm-Message-State: AOJu0Yzh14bMQ0uy4ETKZvJDmzeoiLVOTCHsVsuF4Uo9ePNomcz0YLX1
	d1w+X5o6uFHp5h81WxB2HHnrzKYjnEmUoh1P4UtviU1C0jW7cXWSUIqnIpt/zTmyKIEvzWRZgLx
	XZnHLLKZ3nqljhw7KnzRiT7k8t45tDuaGPTC7uQ==
X-Gm-Gg: ASbGnct+u24u9VcgZUOJ0hcAXCOe75V+UPfoBfvV9ptI7QyDppSagV8QR0YAJBd+D51
	DfI7RT1QErtOeVSTGv3OYvVq1eb3Suf6klIoOdF3Qz5m4NwvA8Hs=
X-Google-Smtp-Source: AGHT+IGovuN9Kh3r84i3WVXRHrWeDqWRbbGUGz97SmGRnq4bnqBOfUs3U58Gwdwd6IQ9D+EKY33Szn1MEw0VOg2tDSI=
X-Received: by 2002:ac8:538d:0:b0:46e:25ed:1601 with SMTP id
 d75a77b69052e-46e25ed17cbmr137410741cf.14.1737461268992; Tue, 21 Jan 2025
 04:07:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250119053956.GX1977892@ZenIV>
In-Reply-To: <20250119053956.GX1977892@ZenIV>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 21 Jan 2025 13:07:38 +0100
X-Gm-Features: AbW1kvYZTvh6KANjtK43ZF8p3FKtbeJRYesjO2s1ckbH0bZiwRverz-tb3X_UPQ
Message-ID: <CAJfpegtxKLYe_-mkv31Ww_PD984YZyPsDuwS=46gbmEKq4-5yg@mail.gmail.com>
Subject: Re: [RFC] EOPENSTALE handling in path_openat()
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 19 Jan 2025 at 06:40, Al Viro <viro@zeniv.linux.org.uk> wrote:

> Miklos, could you recall what was the original intent of that?
> Do we want to keep that logics there, or should it just turn into
> "map -ENOPENSTALE to -ESTALE??

I think the intent was to prevent a full LOOKUP_REVAL if this happened
on the first try in do_filp_open().  I still think that makes sense,
but needs a comment since it's not obvious.

Thanks,
Miklos

