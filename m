Return-Path: <linux-fsdevel+bounces-62502-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D8D6B9589D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Sep 2025 12:59:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D61919C165E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Sep 2025 10:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D58832144D;
	Tue, 23 Sep 2025 10:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="bFF1pL6T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE1960B8A
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Sep 2025 10:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758625144; cv=none; b=I/0A2sQghEZTWTN+GeTf4+/AUIbUBv1SAE6gfSy8Xt1171ddRJ5SDc9ptzcQqdlpMpVsN5Gm+/M1mSNZo80gDAz/Rn2KMAmweSELokd/4pdbusacp5XfAVTwkCESLO22Yy77WG2l1vNkns1ht0E74ISAzcZbXk0zbxFyPAAPIRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758625144; c=relaxed/simple;
	bh=JllJBNVkryNBCdrJQPmCJJebL4qgT+0NkNM1dIglkHM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NqwWzUbCnYjRGeby55XfKVm2Att4pMEwciEAJBHZWPv3f8IKGf/gvyyAVbJ2vE+wNmMw74LeQKlnT34Bg0ExI37xiMOtdUPlN/93vEbKNNOE3U16xq2XoZTJP7nj3ZHMxsk4HzJLV7RMeIp6YRhXZllMEcAQK09qBPUR7ypkF/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=bFF1pL6T; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4c7de9cc647so26277481cf.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Sep 2025 03:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1758625142; x=1759229942; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JllJBNVkryNBCdrJQPmCJJebL4qgT+0NkNM1dIglkHM=;
        b=bFF1pL6TV8vVkhQxmjXvPuIYhFk3EfIH2fIG0kCgZ7+T8VWHj1tEYSSlFQLAovR4rY
         fJkUMwm3t2wnBf2BoUrBNnQ4XrKi+uvUW59kOFLiOL7YQ8LltWhxx7y3dZG8UCcOxLjI
         VUNz0F2AAz+N2vFLy3ldnD4ku9s3UBUPT7Kus=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758625142; x=1759229942;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JllJBNVkryNBCdrJQPmCJJebL4qgT+0NkNM1dIglkHM=;
        b=WLEaAqypTf7oYi4ZLCFZeD+ODzHGdQCKjzCmEq/1ki+6Kroy0qcZMrvnXM/QSZX9cA
         rYDOPstwhRPjWcRRhhzNkRTnzuzfxFWHeh7qQWIXDy/mY/8leIctilM0m0F/eJt1rnVA
         6mox4nlAqgOcQ9IOLSfPriGljM3HwkS8CmqvSBS9EASHUn+/+w2wRL8bjgu6p+YIt6Bs
         bgTiv8NYCxQljDHfLPkfYn/0H1ykiZYR3+ib6g8DLkT1+4qhOwePFyAlMmrw+Tw1XfGR
         4uKg9pHYxj4b99GlR2+knX0GRQrwZqnRUQlm/YN3vQ4Ocx67p1KEVgHArcuO5YL9+L2D
         jwWw==
X-Forwarded-Encrypted: i=1; AJvYcCVhaaTymePKLGcodLduyTnboqfvCCNNP+j6+i8Kyn4+qB5hj+0VKoNLGA+BOeX2YAd1OrjB/enMiiBK0HUn@vger.kernel.org
X-Gm-Message-State: AOJu0YweXvvs3oFACPAvkCt8S7fZSkFEhM+kebU/6OoL15pfLNyDk43F
	qJicDKZksr3WkswynwHtLcAezo05AtEavVXMlVUFgsAYCAYmsfT0AWrkIP07YT4+3j6pLyrsQ4v
	+Q6lWHCtWozXoVg4vS0+GGqMqXts5vaa0j1P8/rnPww==
X-Gm-Gg: ASbGncuEIwl5PBo2C3RZ7JcYj+wg8A3FGc1vYz0YYDPeY41Vsy3kF3FKshEFa0zHRvL
	+pqz/q9DO+z80ztcC0jpvSZ+cqP8PnCXjgtV74iv28LhJBlGKAuh0p2VJJDeWmTRvcWQbx1VgOS
	L7GNtd+sNx8YLmqbc0tX3T4FyXWE8ubCrSjaRmKOmVTL8qPBLliyhsrTI/6QYLP9ZKNzLLt5wJ7
	oemXFNTEmyjXxMAmMkXCvaI8jVkLXkcFsynJn4=
X-Google-Smtp-Source: AGHT+IGVYXFgdT8RYP/th1Bh23LqAzV6VHWIO9kC7E6vKNdXOCdqI74v14xmoLK1WCY+JGm/7UIQQfhOLJ8Z3U9D8YA=
X-Received: by 2002:a05:622a:5a8b:b0:4cc:25b8:f1a with SMTP id
 d75a77b69052e-4d36fc02d66mr25346611cf.43.1758625141850; Tue, 23 Sep 2025
 03:59:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <175798149979.381990.14913079500562122255.stgit@frogsfrogsfrogs> <175798150199.381990.15729961810179681221.stgit@frogsfrogsfrogs>
In-Reply-To: <175798150199.381990.15729961810179681221.stgit@frogsfrogsfrogs>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 23 Sep 2025 12:58:50 +0200
X-Gm-Features: AS18NWAl-NDDKNv7TZPiJHjt5dfPYp31tw1Z8Xx012NqtqWC-lxHUdlrAfy00Ck
Message-ID: <CAJfpegvGY8HLEzJFX=j6Mk-hwyeaOBUkSnyEH21US+Xjud_2fw@mail.gmail.com>
Subject: Re: [PATCH 8/8] fuse: enable FUSE_SYNCFS for all fuseblk servers
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: bernd@bsbernd.com, linux-xfs@vger.kernel.org, John@groves.net, 
	linux-fsdevel@vger.kernel.org, neal@gompa.dev, joannelkoong@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 16 Sept 2025 at 02:26, Darrick J. Wong <djwong@kernel.org> wrote:
>
> From: Darrick J. Wong <djwong@kernel.org>
>
> Turn on syncfs for all fuseblk servers so that the ones in the know can
> flush cached intermediate data and logs to disk.
>
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>

Applied, thanks.

Miklos

