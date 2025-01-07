Return-Path: <linux-fsdevel+bounces-38548-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85A76A038AD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 08:18:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 018293A45B9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 07:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34F2C1DE3D9;
	Tue,  7 Jan 2025 07:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dkaer1G8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD3017C9E8
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Jan 2025 07:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736234302; cv=none; b=hGko0ZtBwsmHq/HUKGTbcPcXrBXUy4HWnpyoqdMWg1igS7XmAshSGC7EEn/RrUlJiF48zPlis8k7VQggc8CWmvWJY91oBxWh11J0bZum4+vMJTmrvxO+g9vmgqr+/7oNdrDl9laSZlB8g84XGRBhIIIJI7JxAlRy2bRl7XiK19s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736234302; c=relaxed/simple;
	bh=Nn6ssU/gCuzRYJej1uDczGueu534Spol+jDKr7o9AXk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=emFoTar05ZFXoI+hMQ4dK+kliedNxmkzxdDPJcbxB3ZoYZV7Tl5XcFv1Y/MlJge0eBSp+8MPIMzrPqk+FWYhgPmpGTdJW6W+K9ZLX/fSrut0CJPM3ceNS+X7286NvoHVHbGxzv+sJXyLC+ApFjDrGGfBL4G4AfQ9njkNxeaZWUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dkaer1G8; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5d88c355e0dso8282407a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Jan 2025 23:18:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736234297; x=1736839097; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gN9aSPqNKUTtvc1NoggE14h34DUUmbAMsnVsk3sO0Qg=;
        b=Dkaer1G8ZXFhIa3YGrNZqTG/KlQ3bsgl8qGP0wji5pGXxu/QM5q5LzVT6tnR5RdAVa
         pR/+JLBZrao47yiu8WohT7YMCMpGeV75IPGJiceJQR+Jvdgh6d5EgIKcmL2Ag0vkK6xT
         N5EU6r/W4ChYeq9vNdEtH3JUPVPEPmAIxWUwK0aB0Q57rG6hZLPZdqRKzseAAjduNOcD
         X3wmcQi7DkiMCOXwIXZ9gw7XxHPfVqfuxxjwChJjZJX8u4l3W/M0eB3itpoEiLGWOIUg
         oCib1W+8eX5e5/FA99ku4eL5V7OyvwjUlYTOx+nMKfApW4UdGooun9AJTfN9FC2wzQmY
         toxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736234297; x=1736839097;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gN9aSPqNKUTtvc1NoggE14h34DUUmbAMsnVsk3sO0Qg=;
        b=Ry74Ea3tGUnKZ7UTStmPt68HO238iE8ug2cwmYX93TVT6XJhRTPm8i2aXi+iarVpA4
         JCy9PXcvvw21v+tROQQEQkwpTaESyqher/+FrC60M1gs834kK9mqZtMFnWzBhNzbQLWe
         os5keLlAE8ZNw+P1jBPydtW2vfqg2YY72413pJjBCcEDwefku3StGTT/bwohQxKOjir7
         krRbQhB8as5X/2N97ir3aFvB+iQ3ID3iBK7iJ7ag0TT9AmM+Omtvsx4wvV+a0B4KUML7
         GA+yQC68V+9FGM97WF26ivKh9zBRHhkjyn5J8QpnVpEyLGuQ3dORsVH8628G9jhZe/bc
         ZJ5g==
X-Forwarded-Encrypted: i=1; AJvYcCXcZmqwJCqKtvUCTUYhkk7+F+BPtPYkpMwC280XpKRx5X7nA8anmsgrlPPMBCpyml7f/Gr7V45lb7Tl1OjM@vger.kernel.org
X-Gm-Message-State: AOJu0YxYz+AwQd/gBDh/rTb5eYPtFAb1d2N9vbMzQXYYOrHyCUICgRCe
	Vh2TbHebYHM2gtdn+HeJtFCXn5ZFq5TZIYIJAIuWyWnyhRnVvy8VqSXVFZYtmgQ0hmKtDVjE4Oq
	Eer14ZxTKBhMfxpjv/8chU8Db1YM=
X-Gm-Gg: ASbGnctEWCiCLoVIljPc8g1KJJBw+lVzfRl0f1EvdYtFAt5/ij+yX/uoo6OsMVu/Maa
	IeLsIJQxFE5MIsuCr684rmj0wDzjn2ir7A1RsfyQ=
X-Google-Smtp-Source: AGHT+IF+5ME0ZlnKcFPwwoMZnK33B2H5urUU9dG8wPM4bAC38RgJdedldMscu25JDOAA6CZYI8YEJNBWErMCh5ZppAY=
X-Received: by 2002:a05:6402:35c2:b0:5cf:c33c:34cf with SMTP id
 4fb4d7f45d1cf-5d81dd99557mr50130786a12.15.1736234296402; Mon, 06 Jan 2025
 23:18:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250106162401.21156-1-jack@suse.cz> <b4a292ba5a33cc5d265a46824057fe001ed2ced6.camel@kernel.org>
 <20250106233112.GI6156@frogsfrogsfrogs>
In-Reply-To: <20250106233112.GI6156@frogsfrogsfrogs>
From: Cedric Blancher <cedric.blancher@gmail.com>
Date: Tue, 7 Jan 2025 08:17:00 +0100
Message-ID: <CALXu0UcWsAcDMZqAP=wM5mb9o0-T+sPyFxLcWpHZNbDWguLKEA@mail.gmail.com>
Subject: Re: [PATCH] sysv: Remove the filesystem
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"

I disagree with the removal.

This is still being used, but people running Debian will notice such
bugs only with the next stable release. Imagine their nasty xmas
present when SYSVFS support is gone for no reason.

Better add a test to CI

Ced

On Tue, 7 Jan 2025 at 00:31, Darrick J. Wong <djwong@kernel.org> wrote:
>
> On Mon, Jan 06, 2025 at 02:52:11PM -0500, Jeff Layton wrote:
> > On Mon, 2025-01-06 at 17:24 +0100, Jan Kara wrote:
> > > Since 2002 (change "Replace BKL for chain locking with sysvfs-private
> > > rwlock") the sysv filesystem was doing IO under a rwlock in its
> > > get_block() function (yes, a non-sleepable lock hold over a function
> > > used to read inode metadata for all reads and writes).  Nobody noticed
> > > until syzbot in 2023 [1]. This shows nobody is using the filesystem.
> > > Just drop it.
> > >
> > > [1] https://lore.kernel.org/all/0000000000000ccf9a05ee84f5b0@google.com/
> > >
> > > Signed-off-by: Jan Kara <jack@suse.cz>
> > > ---
> > >  What do people think about this? Or should we perhaps go through a (short)
> > >  deprecation period where we warn about removal?
> > >
> >
> > FWIW, it was orphaned in 2023:
> >
> >     commit a8cd2990b694ed2c0ef0e8fc80686c664b4ebbe5
> >     Author: Christoph Hellwig <hch@lst.de>
> >     Date:   Thu Feb 16 07:29:22 2023 +0100
> >
> >         orphan sysvfs
> >
> >         This code has been stale for years and I have no way to test it.
> >
> >
> > Given how long this was broken with no one noticing, and since it's not
> > being adequately tested, I vote we remove it.
>
> I concur, if someone really wants this we can always add it back (after
> making them deal with the bugs):
>
> Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
>
> --D
>
> >
> > Reviewed-by: Jeff Layton <jlayton@kernel.org>
> >
>


-- 
Cedric Blancher <cedric.blancher@gmail.com>
[https://plus.google.com/u/0/+CedricBlancher/]
Institute Pasteur

