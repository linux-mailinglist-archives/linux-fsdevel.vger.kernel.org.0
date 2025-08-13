Return-Path: <linux-fsdevel+bounces-57797-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A416DB2563F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 00:03:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEA51565590
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 22:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D5422BDC2B;
	Wed, 13 Aug 2025 22:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FkyDKc5v"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4F33009DA
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Aug 2025 22:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755122599; cv=none; b=Cr9qX1B2yepY1Pz646wAURzq7d2sSpy1nqab+HyNVRcb9AIUEeY+ejshLOEyeuZRTBOsMcqGmEe5D/BPeN9lTC4caC2bXg2o4vBcFNXzw7yWrmr/+bDlRNPF2n1vNwa97z80hEnp+0ioCGmimdz/OqZa0BDJJLyrJ2Xd94uV+V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755122599; c=relaxed/simple;
	bh=kyq9yo0MXfpOrzqj+endN1GoKCtTgcykAtgBOd8EPQM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YQeDJ8i9ZICAk8SeS14KpvH8ed79q18S7pepMXfvOTAX1AGSfBZe3ULzseHCLCLtEY6+WkxS+Ggp6teZALBWXOKbqmEvO5kCV+FQIWM2DelXdu+QMPZynuZ6wMrGALfXFNQwNcNl5V/YrpNoQOhwhkMGx2Xgdj8K4IP9Me0eqS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FkyDKc5v; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4b109ae67fdso4895661cf.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Aug 2025 15:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755122597; x=1755727397; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kyq9yo0MXfpOrzqj+endN1GoKCtTgcykAtgBOd8EPQM=;
        b=FkyDKc5v+FoVCLEjtJ7olLg1b+NEc3HWsWOUya9n0OL/FOy4986Yy+sxfNawib5NNJ
         8pEKja3xWIukoFztlGhuEluUSYQtY6JGiTlQwyIhACd5Zbi/2/KKjHuC+zKMbElE2P8k
         J/68Itc03BR9F/k3hIAI2lwA4qbtPYu4L3Zr22pobnsPfVM/Bje5A5LadgNgOlIdfQKH
         B5PxJBK0uclxZAmQcOUNOoVhVd7g8C1go1FHm+FTEMfKj05pfzs9ottSiIswYABD76WT
         VbpuCXypGNDfaeE0vnh07z/PjgwSDG3lncgWW5DCU0CN4R/dL9KJ2G/cglWb/UK/7rI4
         aBOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755122597; x=1755727397;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kyq9yo0MXfpOrzqj+endN1GoKCtTgcykAtgBOd8EPQM=;
        b=I2T9N5+GF+rHrFNfW0hZBbBR1Eu/7PZvFLgADAy+TsU6k1gaDXvG/trZxKRbx5UOzL
         ttAaxyhtgUI8NmHFrSJtihSNbi8Ie61Ew66KYbi3gzRuiDWsZbvzKtYq5QSsvOJ217ps
         z3id54KPXUbl8lb9dKLZi1SeMSc36svdwm1LQJ+JI/xxLzWRYkWGLQnpaO4rqOkOqpcY
         4Xg37A6Av4jwExQg/ATpxVZtNX3vjFWI9xVNee5qOa2zSKrVWqPgjDY83xMXq/WbVFrM
         Ro1MtEZOTaElrfbfE+EAlwLyAVwKtxtaawErcVaFyRyN/UuuG4sJGs7am117Pq74y2NM
         ccqQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9NueMUWh0SwNAys6tHoF0DFz1AW3G749MQV4YPeF1XP3fOpnc89Hy46D2Ylk/0H5LFXLD6jRPLkkwjZvz@vger.kernel.org
X-Gm-Message-State: AOJu0YxLiCkrGNITInKvhHbLYXxow667/Pj2dCFKocL47HqI2+8P/HHy
	ZHm1+dN4psboM4U/2D8REMKaAkv0lPyX46mpbLuhk6DLGk5XqA3zY21pI9Rkzobhc0fv2PSB+yW
	lyzGpEHvuC9Pb4uy38mHfhoT+McCPA9M=
X-Gm-Gg: ASbGnct5KglnaCM18ZLQst4UaSPymh5NCaaiCV6z5HGNtW94ffLHdW0A8UXEpEWMPid
	wzVST0SzQO3flGJJO/lXq1QVREkyKQEZmN1GAjzVR/yGjjVuQV4i5LpytIioZ7lsSSRgLUJzepO
	pp4t8wXJEFqlT14nWN/H0Wv+WWy5xfMFKWiqyfhw2TtE8I8s7WyaoMSMRYNeIEV3UBKTiKEW2me
	diQdEKX
X-Google-Smtp-Source: AGHT+IHJxHxj3Ac7tWubJShJXGK2CcyuwC336JwgwnqUtbLQjYPCHQAnYM9BRWX5ucHSkgF0a+u5iX1WESLxzgtlSDc=
X-Received: by 2002:a05:622a:17c7:b0:4b0:8e0a:f095 with SMTP id
 d75a77b69052e-4b10a9b9e4amr13619821cf.26.1755122596778; Wed, 13 Aug 2025
 15:03:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250801002131.255068-1-joannelkoong@gmail.com>
 <20250801002131.255068-11-joannelkoong@gmail.com> <aJr4D9ec7XG92G--@infradead.org>
 <CAJnrk1aLAPqpZZJ9TLBhceVQ2-ZzDGY8qv5_bX2rt5XA5T9QTA@mail.gmail.com>
In-Reply-To: <CAJnrk1aLAPqpZZJ9TLBhceVQ2-ZzDGY8qv5_bX2rt5XA5T9QTA@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 13 Aug 2025 15:03:05 -0700
X-Gm-Features: Ac12FXwh9jEKYJ553fL2_do8VzdYgYiCjErR3whJjtdZ88-ia-FLAeyu-s6fzXY
Message-ID: <CAJnrk1b=3S5YrR_wnHSuUzWHmYdY7o1Savi1DKi=GdJvQySMAw@mail.gmail.com>
Subject: Re: [RFC PATCH v1 10/10] iomap: add granular dirty and writeback accounting
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-mm@kvack.org, brauner@kernel.org, willy@infradead.org, jack@suse.cz, 
	djwong@kernel.org, linux-fsdevel@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 12, 2025 at 6:10=E2=80=AFPM Joanne Koong <joannelkoong@gmail.co=
m> wrote:
>
> I need to look more into whether readahead/read_folio and writeback
> run concurrently or not but if not, maybe read_bytes_pending and
> write_bytes_pending could be consolidated together.

Nvm, that doesn't work. read_folio() can still get called for a folio
that's under writeback if it's not fully up to date.

