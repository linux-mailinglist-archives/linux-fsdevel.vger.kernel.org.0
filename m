Return-Path: <linux-fsdevel+bounces-62582-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36190B9A1FC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 15:56:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24FE2162528
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 13:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF1D6306B0C;
	Wed, 24 Sep 2025 13:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="GGCoI3BU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2159E3054EB
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Sep 2025 13:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758722164; cv=none; b=luKF0j0wWC0SYwUqTXhnwRSplIuggrlu5A76vL/9cLs+TqtlhlHWjO1t1mFwwX1hfaEVI2oIdDCMEFtAGxghWBBqBstg0Tz27zQHEVPeDYdcgx+Nu5j0DsFqPoZLiWN61+sXPs/1Y0dAkEqVJBG00TjiW+9wZF3el+MrpDCtVNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758722164; c=relaxed/simple;
	bh=k5jiYphASrpiuHZbsIKQFRdaVX4q1TDbuhWEHUv7zP4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XJzVOQ6kD8ASMq71TA3YonV6rnZByI+I8mN1rZkNXTIzU4fH38Svl63BYzD/KRotMIYoUyKj48f1C5xwuJxv0jEF+CvWf+M2zYkiEeDqFbrp8FcjDyic5qflKA8vYPd2H2a3HAl72dM+OpCC97Iq0QNSJFapsoAl13iQ29Soj1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=GGCoI3BU; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-855733c47baso173011185a.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Sep 2025 06:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1758722160; x=1759326960; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rjt+Jgy4/Srswaflv9pOT4BZWehQ/Es2ibOd98UdDXM=;
        b=GGCoI3BUfOV+nhCqz7f0sB9iHlwu82/RvsXFuwzholzHCwfs5IBmdEU/of5N3c9e5u
         WRseJ7L+K0AG8OYAOKAK5QXwFbcOiPFgbYids8IQX58Er/KXH9ynLE166SoclokyhvXs
         oaiAhClYbAGdhIswVFs9oS7chp3hJsHobL1JA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758722160; x=1759326960;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rjt+Jgy4/Srswaflv9pOT4BZWehQ/Es2ibOd98UdDXM=;
        b=rfmFU8SpvsrCKFs++WkUBYvWG6OAML7NS0Idqvd7j42AjvD7nPuCdsGygO6vSndkHO
         YUlBQUNM3LduIK99Jnm/kpeEMSEJUp5HRnI7lpM1XqEvG0sDc7sO48iQPPL+3EftqDZ5
         jOwpMTtYac34jAa0uzh4ApOcYsOKZ7NAL39/kXcV3UNTpYwSVNUWiAYcEFS0ieEpo/HV
         3eS2FH129McLKpowKlE0NknbVQZqlPLSlHrpOHG+D/XuJzDZ94858XvrwSJUrGjrXQSo
         t2e75ICMLhAEjAPldgM5fAoUbU8TvOHibcQ/ey8Vg5niTd3qJQVIOQXUdeA3XILdIOnQ
         necw==
X-Forwarded-Encrypted: i=1; AJvYcCVnBYHbxt+3WAhaRgJ81k31E74JZcQHPiXxF4tC7aUBIkfZkN+JxTmWBbHfMn3prlEXayCkn/mZl+y8Ia14@vger.kernel.org
X-Gm-Message-State: AOJu0YyQ7hME7uByCdNJ71Sd78OxIDOOR2aq596gqCH7eEHw2hfxMlOn
	UPHwnZrSNaHEjxzt+OgSAmtttzg3COX9sFPIF2Tx0zvz4j5GUv0NCkyFzBHGOh1KFUvMApXdoYB
	deG9FH5T10KoDAfMSWBwRJ4G5qr1rQFCNDQZFpx5Tbg==
X-Gm-Gg: ASbGncsrk7PctUoq1Je89pEKvQpFO4C96ZNvzCyQWJ6oIvVGXN1Wo7QNkjPioCAsvvq
	I/RzTmQ8yKcp/ctztEvn9TSIPX/fy+93Uzv1yxuAG4jvDFy3P/kPrSxHvLPgycO7MJ0jkvv3Lw4
	aPcHtl0i6qAbkDprKM4lvyem64wYKYxgVtNcBTFnJ4zobnkflFV8sQuIUiY9gLRbFb/86sbotHA
	br7MCltzxkjdDM/nWdI9c5t0NsjtczFhnAk0Mc=
X-Google-Smtp-Source: AGHT+IEkU5UZp6STKf+1Cg4IwYZaEgbuC48/cRqtVthYajqkZpyDIRgjdk9b8chkuqsa8N3Tn0+O8lyN4RYewU3aHis=
X-Received: by 2002:a05:620a:4005:b0:7e6:98be:ee33 with SMTP id
 af79cd13be357-8516ab05228mr882474885a.14.1758722159966; Wed, 24 Sep 2025
 06:55:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <175798149979.381990.14913079500562122255.stgit@frogsfrogsfrogs>
 <175798150113.381990.4002893785000461185.stgit@frogsfrogsfrogs>
 <CAJnrk1YWtEJ2O90Z0+YH346c3FigVJz4e=H6qwRYv7xLdVg1PA@mail.gmail.com>
 <20250918165227.GX8117@frogsfrogsfrogs> <CAJfpegt6YzTSKBWSO8Va6bvf2-BA_9+Yo8g-X=fncZfZEbBZWw@mail.gmail.com>
 <20250919175011.GG8117@frogsfrogsfrogs> <CAJfpegu3+rDDxEtre-5cFc2n=eQOYbO8sTi1+7UyTYhhyJJ4Zw@mail.gmail.com>
 <20250923205143.GH1587915@frogsfrogsfrogs>
In-Reply-To: <20250923205143.GH1587915@frogsfrogsfrogs>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 24 Sep 2025 15:55:48 +0200
X-Gm-Features: AS18NWDqKwpelXJanZ8RGJIghS6kjgcZNrZJyvbde88yrp9KsKF7zcg7QnohVz4
Message-ID: <CAJfpeguq-kyMVoc2-zxHhwbxAB0g84CbOKM-MX3geukp3YeYuQ@mail.gmail.com>
Subject: Re: [PATCH 4/8] fuse: signal that a fuse filesystem should exhibit
 local fs behaviors
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Joanne Koong <joannelkoong@gmail.com>, bernd@bsbernd.com, linux-xfs@vger.kernel.org, 
	John@groves.net, linux-fsdevel@vger.kernel.org, neal@gompa.dev
Content-Type: text/plain; charset="UTF-8"

On Tue, 23 Sept 2025 at 22:51, Darrick J. Wong <djwong@kernel.org> wrote:

> Oh, ok.  I can do that.  Just to be clear about what I need to do for
> v6:
>
> * fuse_conn::is_local goes away
> * FUSE_I_* gains a new FUSE_I_EXCLUSIVE flag
> * "local" operations check for FUSE_I_EXCLUSIVE instead of local_fs
> * fuseblk filesystems always set FUSE_I_EXCLUSIVE

Not sure if we want to touch fuseblk, as that carries a risk of regressions.

> * iomap filesystems (when they arrive) always set FUSE_I_EXCLUSIVE

Yes.

Thanks,
Miklos

