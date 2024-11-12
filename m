Return-Path: <linux-fsdevel+bounces-34424-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 88A349C53AA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 11:32:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E925B330DB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 10:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5CDB2141A8;
	Tue, 12 Nov 2024 10:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="AyxwY13p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75A120DD62
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2024 10:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731407098; cv=none; b=A/YHaNb9RLOL0+Lkpv9es7eT31er+82cXBqK1Izf8Kw/gZEbcrSuX/9z8+fCj3+PgfEUqUTd54NWjJ1tZ0u+x/sqmvo/cZtL4EquOT2Zp6RQ2I03dslHfW9UqjtgbbUQxOvsdHq/2lUQjoDAh4AYpKnTmUFHGf4ZhV3p9ht2FwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731407098; c=relaxed/simple;
	bh=WQQUT44UjxXUgprUStAKQO/otizjJ6Da/Qh8ynfnBrg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e4xU5/5KdiOuZ3sjvjhVCmHYuit5HHrgquGW8ki7po/QlJOemUMbKHN9TfKXITlKj9dggKPi1RkWLuf/koNIBLEKtSPu0OOy6EquFamLGMG7ku2f/nYD+v1hz5ShFaVDNrfxAWCju2fanGJgBWvmBdjSIj2b7t25qi3hgCmLCRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=AyxwY13p; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-460963d6233so35708171cf.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2024 02:24:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1731407096; x=1732011896; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mJC0T3leM1RsGI2PHFU8rlG1dXeseVERgANitDsC6e8=;
        b=AyxwY13pexkzdH7ZgaqwGG0csV5yNtfDkuZ5mGOEi4bzEhtckaA71HW29aOWKWxywK
         rzvHVdsKc35kp9F2wRuNRX92ExEGSvbnInomkZim/Hv9WjQCk6KgPh80gUVCW2++6Yty
         l0n39Syesa09z4eMR1BnzZcdNxIO5YklNqPcs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731407096; x=1732011896;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mJC0T3leM1RsGI2PHFU8rlG1dXeseVERgANitDsC6e8=;
        b=K21hp6Vq9axk4EQw9gAx8j+NzvhB6XITNSoi3LxYG6is8q0bi7mYyYXHxvM2Ji14gy
         3sBrnUPbTOgTK7v6iLNwUG5Vi1HMRUyaZ/JUhKVUMc6aC+XLxyPpdUxsxu2SluOSRdt+
         ArAyOKBu46Q3kCsIcYRODj1Dwhv5afIBHStypqKO9t3yCGsV/nCT0hnpsEUesdmpaFEI
         8P3WXKi+QUVJC9V5JmcdUKIxWYy0B28iUI4dhPIXSW5IMIWv54fzQgfukcNj0Ia4y1Iz
         Rf/eEC56pd5FVOraxIxatCRrFNyaeXVL59CsRumQc5bNrOWxDYbQOc4RNvl7YetkyDc9
         tE2w==
X-Forwarded-Encrypted: i=1; AJvYcCVuyrtwv2uH0en9AOzpUvErym7qutUMz8SFnY3BvBJI5IXX5FIBhIh5zmIcBm0TePon72CxbI2+5zxRmj+Z@vger.kernel.org
X-Gm-Message-State: AOJu0YwohgCaERy/CP4lj5YLvEm3NQ1/HpNUUCe9AL45TcgFbYmlfZ3t
	cqzANS191as0WNd1r8N0BdWK394H8Asp349s/aWMR1NXz9y5ymyPVNwOatTB8zwjzZp2miHqE35
	Po4hdQW81/IJ4rfS1PFXLm6co6jBo0pYlNTaaCA==
X-Google-Smtp-Source: AGHT+IE60bpraOC2/z/09KvLRtCZIybssRwBPUlMXCcrMSYq5u2VijkjLRayrx3X3m8NweVxSZBZLfzMXrIWRHnhLfc=
X-Received: by 2002:ac8:58d6:0:b0:460:e89d:897e with SMTP id
 d75a77b69052e-46309326052mr213609051cf.18.1731407095684; Tue, 12 Nov 2024
 02:24:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107-statmount-v3-0-da5b9744c121@kernel.org>
 <20241111-ruhezeit-renovieren-d78a10af973f@brauner> <5418c22b64ac0d8d469d8f9725f1b7685e8daa1b.camel@kernel.org>
 <20241112-vielzahl-grasen-51280e378f23@brauner>
In-Reply-To: <20241112-vielzahl-grasen-51280e378f23@brauner>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 12 Nov 2024 11:24:45 +0100
Message-ID: <CAJfpegs5t_ea5yEOAEbeq07i--VeoN6ZnvFyM=Tyxss7gtTZig@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] fs: allow statmount to fetch the subtype and devname
To: Christian Brauner <brauner@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, Karel Zak <kzak@redhat.com>, Ian Kent <raven@themaw.net>, 
	Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"

On Tue, 12 Nov 2024 at 10:42, Christian Brauner <brauner@kernel.org> wrote:
>
> On Mon, Nov 11, 2024 at 08:42:26AM -0500, Jeff Layton wrote:

> > It's error-prone and a pain to roll these yourself, and that would make
>
> As with most system calls.

Also couldn't the kernel tree have a man2 directory, where all the
syscall man pages could be maintained?   I think it would very much
make sense to update the man page together with the kernel API change.

Thanks,
Miklos

