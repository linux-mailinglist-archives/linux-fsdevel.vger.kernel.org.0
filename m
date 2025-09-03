Return-Path: <linux-fsdevel+bounces-60174-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D384AB4266E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 18:16:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E09A3B15BC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 16:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F36C6285C8D;
	Wed,  3 Sep 2025 16:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="EB+IDjSA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8412C0282
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Sep 2025 16:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756916145; cv=none; b=PhBjEkpKeLO3VOomX8SmdW44C0Ax9v1OV7S/1kf7ChTRmNlAqnv8XWA6UYsPJLO90Of/OqvkVldxkUkWHGQu/ou/s21g5IJbvOhJrJYvHIt/CPUJjH9sBi4nxi80r9/FxzW0VzG3JmXmSODI3YWPGYcbqioizfEpHeQR5Wvo890=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756916145; c=relaxed/simple;
	bh=J83SPmA9b5ebB/mNlmCdHUootQ8W9ndiIYGLByEfeHs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LWCbq7+KAGHVXz15WPnI02q+i5aIg/jbtm4vGZOorSkuehOJ962+ExZy6LKo+Iws82taEjGjE4WYcpGMdAidbPnNO8Gihc4k7ey4/aKKa6a+2qxTalVuEEi/RzzmRipcHEnqrjz2HsyM8OcWKoBrPZZXeltqfEHYkn0K4GwouAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=EB+IDjSA; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4b2fa418ef3so1164311cf.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Sep 2025 09:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1756916142; x=1757520942; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Wt6NdcxQOeA3NBRvQhHqX8Eqt7Kxq4sTeDFU38FbkqM=;
        b=EB+IDjSAj9GQ/BbGrm9/B0TFjOO8cD+Ik+Xfq9fhe4qWpFoUEP7ChsGjjHWkEd2CD0
         ErBlH8OUEaLxOWbKnyvGryZTr/ps2SnZxbtF9W1y7tVG/eWxPYdkODPs4RXrNi+BTHHT
         OEBLaHyvM1ulJ45VUtyY6C/1RrIPzdEK+NOZE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756916142; x=1757520942;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wt6NdcxQOeA3NBRvQhHqX8Eqt7Kxq4sTeDFU38FbkqM=;
        b=dGBqV/VUlJZ8BzqJ6iafZ4dr1RXa0ell/cBjTdxt/1CEDIbv92s5ChTrxZ6ijxxuVj
         /Dn9NCiofG+ybqdiXSMZYNkVXML/bGy+5lOIKbqgnxFct6OylRprYHyQFMmAD82I/ekT
         cInG5M+tR7CU7kcPtuPjpF+ybRxETR3DxuvEW0Ltj817Mqa1VSBolCQobd0yEofcoc4R
         3BEAZjvvq2o20Z6973TlKFM2Pd+uQV2zSH8huE08Vy6uxsRnt/UW/7gYIBzGSeGChZ41
         DinfB21P2c3CSHdCo3AlNA9Ex1JyjtajJuQeaNyG0x+MZm9wtv5fqfQ0oUiHSWN+CtA0
         XsDg==
X-Forwarded-Encrypted: i=1; AJvYcCXgmxMCUuiZt8S9w2MaUK8f2zVCh6o1JZ2KgwcVeHiqoqdUEww+rx9nkaIHMjqw9nOmHtRigvN1lbASFEha@vger.kernel.org
X-Gm-Message-State: AOJu0YzORAFvpoQqe1VgnBQAdNXtoT8nYBEzPxmktM5KlZdwr/aAGlpN
	H+Y3VEn7oczb0vgQYwCIpQ0PWmE/7FZzF8z49hPjdzt7nvUmFjyAYkiV0LDtcCwkrYwnw2ZjIt1
	YqaWRUqf4DTKn51z9BE592U7p8uXYmL58u+1g8etBVg==
X-Gm-Gg: ASbGncsre2rqJuOahQDmeiSGbVrik9xkqr8yvOlu5OVC1rVOv/uZUm7tHNf4jvn01q3
	5uFxKb4UCSDH095/0/Gip2m0qV6xX1pVZZ9wYraHedIiJn5xJRCxQpj5pAEGEQ3bMBzptzq2nPq
	aOtYMfibt+cysWnVr9jJ6pUXCZtbzRkOeG/4W+XUujnurLrBFmFqG5BunA4kh5J0pvnxFWU5xh3
	vG3zMGY1g==
X-Google-Smtp-Source: AGHT+IGcR2cazB9ptNommZkAmyAPJbmMXyf6ic96bB2dFeQ/pblUr5rk6uuI8s6L8/lHyqPpps5d57ZWuec7JWACrp0=
X-Received: by 2002:ac8:6f15:0:b0:4b3:ca6b:fbaa with SMTP id
 d75a77b69052e-4b3ca6c1957mr62157031cf.4.1756916142023; Wed, 03 Sep 2025
 09:15:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <175573708506.15537.385109193523731230.stgit@frogsfrogsfrogs> <175573708671.15537.10523102978043581580.stgit@frogsfrogsfrogs>
In-Reply-To: <175573708671.15537.10523102978043581580.stgit@frogsfrogsfrogs>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 3 Sep 2025 18:15:30 +0200
X-Gm-Features: Ac12FXzZblCqJX4j-odxo2SSbZsVTgZ_t_Of9YfvzaofmKdUONNasDiZb8UBV7w
Message-ID: <CAJfpegvmXnZc=nC4UGw5Gya2cAr-kR0s=WNecnMhdTM_mGyuUg@mail.gmail.com>
Subject: Re: [PATCH 6/7] fuse: propagate default and file acls on creation
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: bernd@bsbernd.com, neal@gompa.dev, John@groves.net, 
	linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 21 Aug 2025 at 02:52, Darrick J. Wong <djwong@kernel.org> wrote:
>
> From: Darrick J. Wong <djwong@kernel.org>
>
> Propagate the default and file access ACLs to new children when creating
> them, just like the other kernel filesystems.

Another problem of this and the previous patch is being racy.  Not
"real" filesystems like fuse2fs, but this is going to trip network fs
up badly, where such races would be really difficult to test.

We could add a new feature flag, but we seem to have proliferation of
this sort.  We have default_permissions, then handle_killpriv, then
handle_killpriv_v2.  Seems like we need a flag to tell the kernel to
treat this as a local fs, where it can do all the local fs'y things
without fear of breaking remote fs.

Does that make sense?

Thanks,
Miklos

