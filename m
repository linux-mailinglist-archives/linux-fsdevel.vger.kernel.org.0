Return-Path: <linux-fsdevel+bounces-36367-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 530229E23C3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2024 16:42:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1808528745C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2024 15:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DED1205AA9;
	Tue,  3 Dec 2024 15:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="E8nTwZil"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A12204F78
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Dec 2024 15:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733240227; cv=none; b=BX3w0gL5nJI9CJ91WzAa3HB5qMDwTvg0aams1Y5XwKsXUZj4qoAQhzZgF4m1QEb+mHihcNklH8NA4nAjB/OTkWY9KiMz38Z3fXX3pgxgWshJ+l60XjNWcX740tct00xt1dmadCu7Uwq6sUhlk61uDR6bTsLtTpjR3EvbHZo2S5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733240227; c=relaxed/simple;
	bh=4wVfCguqrdWqBXAEz4ZHcmtSOxLUsDiwfTSEfuhFWjI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DXk5Cn0ueTB3uWTORBm8MY0aN45CcJvAafsf4YJdntJvyQYrIaCzJNn8M6BPR5BB7NC3vh9pJgsLLVonXkGK99S3kofcvczMj7jZ6dAV9NDAmiEGM6lDdSeQzS4OXAYMokNLlzvBacffVXKOVl84qtbhqAcZc9WL5seS6KLUEWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=E8nTwZil; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4667931f14bso56966071cf.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Dec 2024 07:37:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1733240223; x=1733845023; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7rz/swkd6wgpIBELDO/y+jOBNzes6ryd6W5fip1m+6M=;
        b=E8nTwZilqKJ3BcHzwfWP3MlsXZEOv+UBnaznTEwqTVghx3kL0oFbQaEJqsJVF0Tru3
         BSVlLSK4AA0Gk96UhYezWtPklTmSWXAN44OqNCs2SXzWU5K2z4+u8dAEpVR96E0bcBJ7
         ByejZZpAV/DmGoLo+8xSVCHHiv3vyayfpbn5M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733240223; x=1733845023;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7rz/swkd6wgpIBELDO/y+jOBNzes6ryd6W5fip1m+6M=;
        b=WCeLek4ekixxrGLFq79OBjGcFowbkYOxHlMDPfn1NIzmGeymkRm7ojU5JUKOrdd8Aq
         4N5/8HU7h7dAYara1UuhdRuZgDLvWXjE425YXRox+GehxHnPxayYE/so/okBV8Da8DMj
         Q/peRHLRVZ2zj3cENsIQsbcfTTC2a63F+XLR8yDNbeuiYbjFeaVbtwIG+E7ROo6Trz6g
         wQLsimqMwIEidT+ffbUJo1p/lHh6yLcQx4YXZv8URnIM97JcuYtLYpGNfdb9zFyJTqCz
         hcljRiL8IOwKyWNY+4U9FIQiyWWCwDDNTACb4PC6uUneDSDoRpAyTJhukHu8YNCErI8o
         hUfA==
X-Forwarded-Encrypted: i=1; AJvYcCWrNlXJnoXn0nqsqX1EohL0B9fiowSIVd9c7n6TzRET+Z5bBQW2DsNdG4mJCDnefMgSisZ03tCaAUIueNTL@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5dRe5aI8HksXls3f2hAqcqIgaupBeQfkH1f569iEA4mciTmqg
	Ue7ZzkhBv8XqkiCmiuzvZBDXvsMGX5I5Q1EnNV/CppmYCJOG72fIcd+GOzUeWmkad5r+0KpqD7u
	oIutivMZAR0mv+YMeqjna5jPDpSRU2gYQXdXh4A==
X-Gm-Gg: ASbGncsFh/k6t0Vjt7j6HNOgVRoxTDNf1wJb9eoJT96WGrTcBurLN0YBdLoEGVq2dGi
	c531ffaiX2fE80gVyU1xOA6WKlVpMQDo=
X-Google-Smtp-Source: AGHT+IEUum0ZndSVIMPqXbijEbyB0VTTc1ZOueQ809/udOOG1uhmvER8TVw9oYhIlrPJMH92NpvTCmrGlWBr1Z3Xz08=
X-Received: by 2002:a05:622a:11c1:b0:466:b382:a78a with SMTP id
 d75a77b69052e-4670c372edcmr39861541cf.29.1733240223089; Tue, 03 Dec 2024
 07:37:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241128144002.42121-1-mszeredi@redhat.com> <CAOQ4uxjAvpOnGp32OnsOKujivECgY1iV+UiBF_woDsxNSyJN_A@mail.gmail.com>
 <CAJfpegvaq5LAF+z9+AUXZiR5ZB4VOPTa0Svb33e-Y8Q=135h+A@mail.gmail.com> <CAOQ4uxhbW=r9dZtkAx1ogoEmEKQh9f3g_WLh8jf+0o-rURCprQ@mail.gmail.com>
In-Reply-To: <CAOQ4uxhbW=r9dZtkAx1ogoEmEKQh9f3g_WLh8jf+0o-rURCprQ@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 3 Dec 2024 16:36:51 +0100
Message-ID: <CAJfpegsKEZG+CJuaPkYipYZA0Jxzfk7Mz0h6S+Z3uAK6YD8MAg@mail.gmail.com>
Subject: Re: [RFC PATCH] fanotify: notify on mount attach and detach
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org, 
	Jan Kara <jack@suse.cz>, Karel Zak <kzak@redhat.com>, 
	Lennart Poettering <lennart@poettering.net>, Ian Kent <raven@themaw.net>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 29 Nov 2024 at 11:23, Amir Goldstein <amir73il@gmail.com> wrote:

> Currently, watching a sb/mount requires capable(SYS_ADMIN),
> but I have a pretty simple patchset [1] to require ns_capable(SYS_ADMIN).
> Thing is, I never got feedback from userspace that this is needed [2].
> Seeing that statmount/listmount() requires at most ns_capable(SYS_ADMIN),
> I am guessing that you would also want mount monitor to require
> at most ns_capable(SYS_ADMIN) rather than capable(SYS_ADMIN)?

Yes, allowing this to work in a userns makes sense.

> Option #1: do not allow setting FAN_MNT_ events on inode marks (for now)
> Option #2: apply the same requirement for sb mark from fanotify_userns patch
> to inode mark on group with FAN_REPORT_MNTID.

Let's go with #1, as that gives the simplest interface.  We can extend
that later if needed.

Thanks,
Miklos

