Return-Path: <linux-fsdevel+bounces-46482-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA45A89E1D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 14:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 897C37AB9BA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 12:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECB5A292920;
	Tue, 15 Apr 2025 12:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="Ayh5tFyz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC9E22F01
	for <linux-fsdevel@vger.kernel.org>; Tue, 15 Apr 2025 12:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744720216; cv=none; b=GmNkRoEdvDwjNMcj8ipRYzbZsc52AhiL7oEMzvuFl+qBMVRy+2ee3qZkDkwTl2VpYatBBtkXMlXBb3Yv9nEuYibaAwO6slyc9w4/oZU/Xqt8Ym8ncaS7WOs7dmj75VDnvQYoTO808qi8NBhObzq8k1KrOXIJ+y1MhnjO3ritEDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744720216; c=relaxed/simple;
	bh=N06fROz6Ok1kuegcnIMVvugNkjBdbvxUIGHUg0+HexQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aqfayeDAmZt3exxcDwqlyDqnrlFV/6MyCy424MOVB5kgyaqZ3laetewEUh9187v1x57n3hjyI1V81YzfQPwii7X4f2vzKGFChrNjI9cLELTlVZF7kqnqlyhsiylhtnIxUiT8vO8IpeXzbNvWIRVn6+WFkscgVK4nZNbcSXRtKnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=Ayh5tFyz; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4774ce422easo56596541cf.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Apr 2025 05:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1744720213; x=1745325013; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jgprtSV+BJkEJMMAOIzfg6zQLECGpJ2SvAFR9W9HkH4=;
        b=Ayh5tFyz45ph27n2XZMnVvL/6TmFiEOi7uQEnHvxmicAEav4PpEerW5D9pxE4T+9oU
         OIuqZr60g74f9Zc/S7/+cjxv6Iq3fvCwUdB1WOtfXFcNtyn7AOnrInmPwGithPPtJGog
         sRTCdYpwwm4VtKwMNA7VlrLJWIptDdvzVma8c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744720213; x=1745325013;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jgprtSV+BJkEJMMAOIzfg6zQLECGpJ2SvAFR9W9HkH4=;
        b=tEtfGIXbxHv4Ri8qiKYImz2VLelo87qYHfawpxzBSlfoG01jhKweq7LmpX4PZ5xMdN
         ia7LkvspFMBYlks4Ub3m/gsASYHPB42wvGeS6b2aIUuZoF6YCMHBX0tgr31MSkwN56BN
         8j/oq0XckseA+KTEx/Lw1yokP34vyQCcsEKMUltfbtBoJftbREXgdsxwyt0jIBL/j+Jr
         uDVZn8MDllOef/Hab3nzTjCVRFMB4MXcHkhXQ36X1e25A+qjWoCSxtpsh6oPle8mdohy
         kNOCFLU6kah7NudIZd41bBxL1eywrucP20ADAnOjvTkJoOmKAMWDpz7XJvz78USTLITA
         5IzQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBqwUafNOlkRXEVmBzq4nX/FvTXJ66KEEIR61o6ojQHP6hYqyllYHs9nD/Mu6RnaR5T0qlwP4Xgy+wnjkQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo3mCWDAy2gfaRGxIJPyj/zajtsfp9xzrHCq72+UogD7aAa9Dk
	VWjjDEPJvmyUutb5wa0ck8PQRtQexc+jMw4KPsjTV9S2+eRUrt7Icra4MJjenEkSgYKy9kLdKWt
	TnHs36goDSlOBCUpsKGruMv9J/BGV6M/F7XuB2w==
X-Gm-Gg: ASbGncvn8yJE0EGZsr/7dw2WvYmyH4wjNddXn6gogvVTVqKrKgTl2VyZtaE7NCZQPZM
	Y6xZIftYx0I7bhf9215o8KtzkjaOt2/npyl8b4Ez44QRRNJzKsDtxZaSHSBMx9iLZZKdUUfgSet
	Cpr8DaBbOeubM/9jrqaPmj
X-Google-Smtp-Source: AGHT+IGxeLReHK9HZ8TC1wyenUzEx+m3Zwjzv3iQP+TrQpgr3GHGOj902AYQm2lBTXplWa38bpRQfYYQrtFdt5TeExQ=
X-Received: by 2002:ac8:7d44:0:b0:476:955f:91e2 with SMTP id
 d75a77b69052e-47977554b57mr208287501cf.29.1744720213631; Tue, 15 Apr 2025
 05:30:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250414222210.3995795-1-joannelkoong@gmail.com>
In-Reply-To: <20250414222210.3995795-1-joannelkoong@gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 15 Apr 2025 14:30:02 +0200
X-Gm-Features: ATxdqUGzJsLM4X_o2K9iXrOPRRmQQu4-hQtk607MMuOcVIvDsvxWd9-MDSrEqp8
Message-ID: <CAJfpegveOFoL-XzDKQZZ4U6UF_AetNwTUDbfmf7rdJasRFm3xA@mail.gmail.com>
Subject: Re: [PATCH v8 0/2] fuse: remove temp page copies in writeback
To: Joanne Koong <joannelkoong@gmail.com>
Cc: akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, jefflexu@linux.alibaba.com, shakeel.butt@linux.dev, 
	david@redhat.com, bernd.schubert@fastmail.fm, ziy@nvidia.com, 
	jlayton@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 15 Apr 2025 at 00:22, Joanne Koong <joannelkoong@gmail.com> wrote:
>
> The purpose of this patchset is to help make writeback in FUSE filesystems as
> fast as possible.

Applied.  Thanks for seeing this through.


Miklos

