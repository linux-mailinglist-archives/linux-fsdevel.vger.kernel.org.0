Return-Path: <linux-fsdevel+bounces-12455-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED75D85F89C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 13:49:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 894501F21F5F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 12:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4257312E1DB;
	Thu, 22 Feb 2024 12:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="fll1RrOO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF92B46435
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Feb 2024 12:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708606140; cv=none; b=lD6hJ+fJYEzODqfkXGmYEZhkFQYBMPgiPntgQu8ik0UCQeAiWlI3ZfjauzFMveWs4cZTK+UDrBLxt1yfWPqkHz+NNYZuIpcGXIIMc5zITNWkTeQXxXL7U8yYpi8dXwe+6eWK6EWPK/6xAUYwSe0iVNI+gCAIZ50mdcMiBeKxl10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708606140; c=relaxed/simple;
	bh=IaZnxBsuLBFhLCtq4o+sFHyJl6jTMn3zf5TloDU0gxU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=URu3MoEA4cLksaG2e1PYZ242svylSbKtmn0rINnjIjiPKNKwBB2MSq35quVk7bipRviCYF45hb5sUi7k+EkUQGSUMcaBvz6m02LUHH0YwTsdpy7ySXr6T722KpiWSbtxBzEGqcg7KZzlU6HlPjByIfq8+VF+dkdltjMAo+9CstI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=fll1RrOO; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a3e6f79e83dso618002266b.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Feb 2024 04:48:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1708606137; x=1709210937; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IFwr9ha9a/GO5zeQAiQ5BbOipoVYz0stbyW2PYDXp3k=;
        b=fll1RrOO7XDrUfc5NNSLxz60HeekCbr1nrS34Ikie3pwl0++yp9qhLuyYzJYuYXNqI
         Uu+9xnchOtP9xOujSO3RFSI4ySdeN7GoYp8ycmSkWXcNPLwmd2f/ru2dTCB3mj01D8gE
         Nh25l644A0xVM2kBAwJR0PnomXBWj4u3Ss9j0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708606137; x=1709210937;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IFwr9ha9a/GO5zeQAiQ5BbOipoVYz0stbyW2PYDXp3k=;
        b=lAX7O9Gz7KNXI3lVkEeooTJzhgdiKuigtDrtf2Mb7SkrmciBO9luHBxX7DWRp7n4Ab
         a969cuw/GknBGAHG3XpAHUlXsP1e6DqYsZhkoMnY9aLDze5PUtMpOK35IHSvRhLafR5V
         gVLEbqkQAvsPYJijpXUNZG95I49SsWmDToxUwtvSdTJVvvaWcEMdCbHVrHnhjajOquZo
         B4xuTvnZjyGm73z2TU06Pe9eu3Y8o4VC0//ijKNf1WKt2x7Mvk2EoA8GIVXqcrI1NaPK
         cEQgOxJoVOkb6jb9cn/zSHHqb/IoahFee2bTXCH+tkmUDAyEwX4bD5dQWrg5BkF5MqSB
         adDw==
X-Forwarded-Encrypted: i=1; AJvYcCWgPu40tHhKMo/0+WENaJ12XLWOm0bYeuoD7i7zRiXD6ukfkna11bOJ1eJYDlQyb4ovHsVqNYtCW/QjHWohlL5lRATCpvoqaFxGO/T06w==
X-Gm-Message-State: AOJu0YzaqEwWEZgp1mXvteMB8wz3yyAWs27b+sXYGU4/FFWqRUab42/b
	a1ZEzae+7Fpl9P7Yzgq+XX5iT2zTBTNuiB6XdZc9zIlakj8TrU3xm0q9ALsealN7PKg7O1m3Hr5
	FOGYsJbkz9Nrr9PoAO2KbrWbOrXu++qv7m6jWgA==
X-Google-Smtp-Source: AGHT+IFcJq6G1W4GM/8Xx0ldjd6icR0JuT2f4svLMCyrSjNeTeZkiYryyGjJrI/Z7YxDp/vI8lMF+gdExOLZezH1T1w=
X-Received: by 2002:a17:906:c0a:b0:a3f:6513:1489 with SMTP id
 s10-20020a1709060c0a00b00a3f65131489mr2350336ejf.55.1708606137154; Thu, 22
 Feb 2024 04:48:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2uvhm6gweyl7iyyp2xpfryvcu2g3padagaeqcbiavjyiis6prl@yjm725bizncq>
 <CAJfpeguBzbhdcknLG4CjFr12_PdGo460FSRONzsYBKmT9uaSMA@mail.gmail.com>
 <20240221210811.GA1161565@perftesting> <CAJfpegucM5R_pi_EeDkg9yPNTj_esWYrFd6vG178_asram0=Ew@mail.gmail.com>
 <w534uujga5pqcbhbc5wad7bdt5lchxu6gcmwvkg6tdnkhnkujs@wjqrhv5uqxyx> <20240222110138.ckai4sxiin3a74ku@quack3>
In-Reply-To: <20240222110138.ckai4sxiin3a74ku@quack3>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 22 Feb 2024 13:48:45 +0100
Message-ID: <CAJfpegtUZ4YWhYqqnS_BcKKpwhHvdUsQPQMf4j49ahwAe2_AXQ@mail.gmail.com>
Subject: Re: [Lsf-pc] [LSF TOPIC] statx extensions for subvol/snapshot
 filesystems & more
To: Jan Kara <jack@suse.cz>
Cc: Kent Overstreet <kent.overstreet@linux.dev>, Josef Bacik <josef@toxicpanda.com>, 
	linux-kernel@vger.kernel.org, linux-bcachefs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, lsf-pc@lists.linux-foundation.org, 
	linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 22 Feb 2024 at 12:01, Jan Kara <jack@suse.cz> wrote:

> I think for "unique inode identifier" we don't even have to come up with
> new APIs. The file handle + fsid pair is an established way to do this,

Why not uuid?

fsid seems to be just a degraded uuid.   We can do better with statx
and/or statmount.

> fanotify successfully uses this as object identifier and Amir did quite
> some work for this to be usable for vast majority of filesystems (including

Vast majority != all.   Also even uuid is just a statistically unique
identifier, while st_dev was guaranteed to be unique (but not
persistent, like uuid).

If we are going to start fixing userspace, then we better make sure to
use the right interfaces, that won't have issues in the future.

Thanks,
Miklos

