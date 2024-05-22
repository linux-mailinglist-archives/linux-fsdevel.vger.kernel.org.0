Return-Path: <linux-fsdevel+bounces-19998-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8445C8CC220
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2024 15:29:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AC621F238AA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2024 13:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58D801411C5;
	Wed, 22 May 2024 13:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="eNfUi+JD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2AA140E30
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 May 2024 13:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716384557; cv=none; b=X1M+gPO0ZdxhzFsDJ2iOFvE06F0GgkWPrcg0/S4zZ/I3LdIon1bbazSxCf6qYq7DY/TiFpFd2OcSDHirP55PCCKLbUYy003OHQpF2p2f1e2BP5nG/Flv/JXHq8OpDhlyLder2rPaaHqG093TQFYMIew5nl5wlCb8Emj9HD5Jz/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716384557; c=relaxed/simple;
	bh=61mO5+snMGsz2ee+TFdxLBoONuQxJeAcSO8S6crnAK8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=HcjpfKBDuhf6XuOC9qb0X2NfhqPXSr0Ezt9B3eZTUHq5+e+50J7OK6LNFOzZGy283iRqG88Fq1sdpUdMrc8yc7jgINov9UPYlVagxrApcnOQX1ZUBsDASoIIBu2mqgrTYZ0mznNRArs/SpvjfS86wwIkKCCn0cLWtM1EQnB8qdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=eNfUi+JD; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-572af0b12b8so9974256a12.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 May 2024 06:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1716384554; x=1716989354; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fcAnLjMIMbITY++kSDoM1eUoNeGeLxhIN5O6O+u3md8=;
        b=eNfUi+JD5hCg56yJHaoYPZ74COFIf6NnI0qH9nL6BI8IxXaugOw9AW3WDE/g7eQcPq
         RTx94BQ/2OyeqmBZKoYXaGYV3g5OCVoTPNNg3hzW4oFWz36j3evrjcYaF7mINHHgHdPo
         0/kzMaf4396YboZdIHbbKGcEAJW0lSVIbfk00=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716384554; x=1716989354;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fcAnLjMIMbITY++kSDoM1eUoNeGeLxhIN5O6O+u3md8=;
        b=igWUDwrpTG6Ja1LJm9ROOr1zfY+1BKQK5P5cCgAyC6/GOMD0709bdtrdFCpEyG9Tu+
         9ny+fE7V34qMDRlcoPXMVZIgLzgMpGoMBkjTkbutVCMD9I267rlV4uc4gG+VmxLXv8Od
         g+eG1PZoxxPLNnIjkpEHGorslhUybKIvWoqrPjZ9qoRRV4iwf3FVOdHekWPWd6ucGCXA
         cqhSMgXnqZH9xU2NvURErKl5kBbkXAdLjdwZeZtX+Gnuzp7tNebz8QHt1DQU5ODL9T1d
         QgTRdBDG822QcSgmTztJ1pJics7DrVWgJBlrJHg4uKekoBz2GLiIiPYlt6fxDLSVWoXq
         Se/w==
X-Forwarded-Encrypted: i=1; AJvYcCVWNst8IlKydVYBwR5PU3cVUh4lBP7rght0EffJxy/8nq00WOi+N2FNJofeVIroU8ldHRYetKZoBV/2BjUeccb9NB2rr6TJAMLr8ho3JQ==
X-Gm-Message-State: AOJu0YywjTlbgY+qIaibAJzN2uT0h562M7O0amrzCCu2Yf+qVsR40rvy
	SsT57E+WLtyceZpgjJG65hidtjKO0ShFUT9pmn8XbnEhjr3044rJdZ0YQdUE2H/L29MELpHJHtu
	RFIOI897zuSmXAjytcLWzVaaKJyV7enQ+etzpyRdCDLUtZ5cBYiM=
X-Google-Smtp-Source: AGHT+IEkcTSyEUkeYpXWY+h3epaoj2bcPKEEthTvq9ZR3Kgjf4O9kooRyINxL3rDCrzwmh3KjLFlaI17FCigLPEni+M=
X-Received: by 2002:a17:906:6884:b0:a59:9e01:e787 with SMTP id
 a640c23a62f3a-a62280a0e9emr136501566b.34.1716384554522; Wed, 22 May 2024
 06:29:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 22 May 2024 15:29:02 +0200
Message-ID: <CAJfpegu93nZEeEJhepnDhzHO7khEmXkP1UssKNErqXFFUw-8uA@mail.gmail.com>
Subject: [GIT PULL] overlayfs update for 6.10
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: overlayfs <linux-unionfs@vger.kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from:

git://git.kernel.org/pub/scm/linux/kernel/git/overlayfs/vfs.git
tags/ovl-update-6.10

- Add tmpfile support

- Clean up include

Thanks,
Miklos

---
Miklos Szeredi (2):
      ovl: implement tmpfile
      ovl: remove upper umask handling from ovl_create_upper()

Thorsten Blum (1):
      ovl: remove duplicate included header

---
 fs/backing-file.c            |  23 +++++++
 fs/internal.h                |   3 +
 fs/namei.c                   |   6 +-
 fs/overlayfs/dir.c           | 152 ++++++++++++++++++++++++++++++++++++-------
 fs/overlayfs/file.c          |   3 -
 fs/overlayfs/inode.c         |   1 -
 fs/overlayfs/overlayfs.h     |   3 +
 include/linux/backing-file.h |   3 +
 8 files changed, 165 insertions(+), 29 deletions(-)

