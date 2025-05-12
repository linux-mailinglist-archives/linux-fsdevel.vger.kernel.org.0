Return-Path: <linux-fsdevel+bounces-48705-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01D92AB3192
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 May 2025 10:27:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9627C18921F6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 May 2025 08:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B93A258CCA;
	Mon, 12 May 2025 08:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="Oe5ACETo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24AEE2512E2
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 May 2025 08:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747038452; cv=none; b=XbMQj+QxOYJlpi8jjz1HZucck7JXiVy60F2oArfjs7UUejRh+B9gj6H3/Q8PUHHPLzC2DSYOf5N3IyYTUiZZvp7bAZc1PghXtCl81+JXu+sOtkVbijfv87pQCcSoYUaExiVzDin+SF5pwnzTk8PsYaM+mpJm6k+9melwMjFedU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747038452; c=relaxed/simple;
	bh=KpI2Ldw9Q5XCynekX7E8uDM8g2s+AhFWPW0rqHWZVJE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qIu9LT9vKc8ue8d0woXO7YgN45F17euVu7B8Z9QNzaNJ7LwUsby8OklUCRHf98YrVTAJwgAZ5/NJIvfPlSSMonN9150tXTYPqbgxhvIbRTJtwJBPNhR8RSsyPmtzGH73F42CWaH4Rwkpbou8gM8wmH00bZHy93+DUNkSu1XX/Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=Oe5ACETo; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-47691d82bfbso76055191cf.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 May 2025 01:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1747038450; x=1747643250; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WZSshcLUS/dyVyuovWTzmyTQWV68KoRHYV2oCPryNnw=;
        b=Oe5ACETodc5JhgxEMq2DUl8Bzgse8j9F1smCzTYEgEraAUVU+2sV615yAXjqdm3oac
         OwyJ8n0UhloUMPILO+o9Pfvtgk1wi0/ihTxlR/eZKx65D/oq8KzCsdktvfazGQqSXy1P
         91Fkxa3uqeN586rTPEmA6MmBl16uE/1fw3OrI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747038450; x=1747643250;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WZSshcLUS/dyVyuovWTzmyTQWV68KoRHYV2oCPryNnw=;
        b=BbFSN5i7PO9q81sySs1c7JDyR+nv8/XZrqW+hjmr0/pWuWy41Bf2NBDnXR9VIcgCMR
         NSNua+oZfL/qLZyd+DnTo5bJCcP2q/YtuFEhCVx0HEKqQWQNgDHIknuGi6kiMf6tv4YI
         rp0M6nznFzvkZ14W6UNF4MMlBF97nubOaDaTyLcPg3xivDY66/dZnXPVy+RvMA+vVdNP
         CC/Icv9bX6o1GamFLmylP/7cuaKDjVgqybeXLLIorK3wxx8WBalXDw6F832Cd5epENOJ
         ppiAjNhk2ran/Jp5dvEfmDepsEV1tdqUNHFl4AULfmETE3hu296Ad5euNJ5OI9H7uZrD
         GluA==
X-Forwarded-Encrypted: i=1; AJvYcCWlb5VEUNxPfvCt1qGf5x72mA/6kYl16K0RmniIE/b7e3DBvg9CxEiIWoX+Qa32m1nfnyFmdpscALWtTa/H@vger.kernel.org
X-Gm-Message-State: AOJu0YzXbt9S+FVDVLiKGOJuLl0iYtETWu66ynLMUMZsNQpWRgZADTxi
	iQUmXJ4di4U6fryCzse4y9KSMW8BvyKps6MwNaQ7WH862leGpqEoqtw9ExIYK13hVwP9DgM198v
	BdQ4Iy6cAfbgDCME0F/LXmjEjB4VXasTpxwWXNh+tZTYnsry6
X-Gm-Gg: ASbGnctL/9Kpal/DyTrF29tQwo8tylEojvKfjRvQE2hsBgtMCsFjeJ1Z8+rQqjCmjE5
	tcbDjIzooOrJzDB4QWsl9RSsYZhi+cquZBwHu6jJumUTuBKd7kFOgRA7+AvkYfVO8LGe+3pRHTi
	lfXGe2E8EUhCr3HMY7tBFYziDJ9btNE3u8w0c=
X-Google-Smtp-Source: AGHT+IGtNC1aUdyyeI43+8U+artHWY9OR/1bTof+TWdQENJAoLSWoxq+eX3iik65c/E4tn4ZjidjqLC0YPMRryXIc58=
X-Received: by 2002:ac8:578c:0:b0:480:9ba4:3022 with SMTP id
 d75a77b69052e-4945273580cmr175507551cf.17.1747038449952; Mon, 12 May 2025
 01:27:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250509-fusectl-backing-files-v3-0-393761f9b683@uniontech.com>
 <20250509-fusectl-backing-files-v3-2-393761f9b683@uniontech.com>
 <CAJfpegvhZ8Pts5EJDU0efcdHRZk39mcHxmVCNGvKXTZBG63k6g@mail.gmail.com>
 <CAC1kPDPeQbvnZnsqeYc5igT3cX=CjLGFCda1VJE2DYPaTULMFg@mail.gmail.com>
 <CAJfpegsTfUQ53hmnm7192-4ywLmXDLLwjV01tjCK7PVEqtE=yw@mail.gmail.com> <CAC1kPDPWag5oaZH62YbF8c=g7dK2_AbFfYMK7EzgcegDHL829Q@mail.gmail.com>
In-Reply-To: <CAC1kPDPWag5oaZH62YbF8c=g7dK2_AbFfYMK7EzgcegDHL829Q@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 12 May 2025 10:27:19 +0200
X-Gm-Features: AX0GCFu5sfhVzUqTe5y8_c4SjL32Qv9LBh40xP-R3ct5pAFtrxq8WNsBOYRC3vs
Message-ID: <CAJfpegu59imrvXSbkPYOSkn0k_FrE6nAK1JYWO2Gg==Ozk9KSg@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] fs: fuse: add backing_files control file
To: Chen Linxuan <chenlinxuan@uniontech.com>
Cc: Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 11 May 2025 at 11:56, Chen Linxuan <chenlinxuan@uniontech.com> wrote:

> I noticed that the current extended attribute names already use the
> namespace.value format.
> Perhaps we could reuse this naming scheme and extend it to support
> features like nested namespaces.

Right.  Here's a link to an old and long thread about this:

   https://lore.kernel.org/all/YnEeuw6fd1A8usjj@miu.piliscsaba.redhat.com/#r

>
> For instance, in a situation like this:
>
> A fixed file 0 in an io_uring is a FUSE fd.
> This FUSE fd belongs to FUSE connection 64.
> This FUSE fd has a backing file.
> This backing file is actually provided by mnt_id=36.
>
> Running getfattr -m '-' /proc/path/to/the/io_uring/fd could return
> something like:
>
> io_uring.fixed_files.0.fuse.conn="64"
> io_uring.fixed_files.0.fuse.backing_file.mnt_id="36"
> io_uring.fixed_files.0.fuse.backing_file.path="/path/to/real/file"

Yeah, except listxattr wouldn't be able to properly work in such
cases: it lacks support for hierarchy.

The proposed solution was something like making getxattr on the
"directory" return a listing of child object names.

I.e. getxattr("/proc/123/fd/12", "io_uring.fixed_files.") would return
the list of instantiated fixed file slots, etc...

Thanks,
Miklos

