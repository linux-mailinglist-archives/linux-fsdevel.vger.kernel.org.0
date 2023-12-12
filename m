Return-Path: <linux-fsdevel+bounces-5690-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B6280EE5E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 15:06:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B043281450
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 14:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B429473177;
	Tue, 12 Dec 2023 14:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="LSiRXK6k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18E1D10C
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Dec 2023 06:06:22 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-a1db6c63028so653500566b.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Dec 2023 06:06:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1702389980; x=1702994780; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=T9PLSAQZI0NwJjMZpWWj+Z6fnoMkBkiiBjHJ6/wdc/w=;
        b=LSiRXK6kE0wff9TtR4ohY8tS0/Zy/UqXFKOfcOcx1wPn6h9v1RH/maMdnoh4avG0t5
         kng3TtyPsvggSzqerYS0RbE90eXrgK+XBXDubtQcA7Neh+GZlX/EGUUV1sxFIvvEW7uQ
         YUJNgDoE+L0XTHltv7bPzlvAAaLrHeTp5HKlE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702389980; x=1702994780;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T9PLSAQZI0NwJjMZpWWj+Z6fnoMkBkiiBjHJ6/wdc/w=;
        b=LkFVVwnJVwZnA3p8Jfwq1YCnSFY9oU/0aCdvvTYqxMEKxeexiStMhGdelV0WxP04dv
         jRRmAuhvtupeJvqGEW1VUPchlurbo4J2Ba+5D+euPEIM7buxO/QD0rjk8HAH7JdYiF9V
         XIji6xZYsgFppAmcaL0yDdLPxeZZjluM8gGC99LJGWzu8UM+DBkOahn7I7IxwAidDibq
         fgCr0q6gC5AVm1748irr/wjvkJVCKRZX3TN0QVa96MRa5rpYUHjSjz2MYFZMvU3JzgZQ
         P5R5lmGF7eLa8Fn9G/+Hy7x4KCzi+ZLKBLMiRqMurNRAVkUacVjAUDMw/n5s4cPxl1Ir
         LoiQ==
X-Gm-Message-State: AOJu0Yya6Y1PqIuxwHXyl8SU5xMoRWrdcSLeC+p8QmNI0Bjxv6e0NTVA
	keXhlYhnPoECoWRbge+AZuyCw6YbEHA0FjDh/Gz5HQ==
X-Google-Smtp-Source: AGHT+IE8/unfFBGUsACmdLQl4gCXwGjqPvgH1AmcsYVBiGEGVrWOObehrOvHzO7IJQO6G0O0LiBXAwjjrTZXhmAQHs0=
X-Received: by 2002:a17:906:6a29:b0:a18:9ac9:27c2 with SMTP id
 qw41-20020a1709066a2900b00a189ac927c2mr3527206ejc.53.1702389980291; Tue, 12
 Dec 2023 06:06:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <170233878712.12910.112528191448334241@noble.neil.brown.name>
 <20231212000515.4fesfyobdlzjlwra@moria.home.lan> <170234279139.12910.809452786055101337@noble.neil.brown.name>
 <ZXf1WCrw4TPc5y7d@dread.disaster.area> <CAOQ4uxiQcOk1Kw1JX4602vjuWNfL=b_A3uB1FJFaHQbEX6OOMA@mail.gmail.com>
 <2810685.1702372247@warthog.procyon.org.uk> <20231212-ablauf-achtbar-ae6e5b15b057@brauner>
 <CAJfpegvL9kV+06v2W+5LbUk0eZr1ydfT1v0P-Pp_KexLNz=Lfg@mail.gmail.com>
 <20231212-sechzehn-hausgemacht-6eb61150554e@brauner> <CAJfpegshsEWtm-dcdUy2w9_ic0Ag7GXpA2yRWGR+LD2T37odGQ@mail.gmail.com>
 <20231212-kahlschlag-abtropfen-51dc89b9ac11@brauner>
In-Reply-To: <20231212-kahlschlag-abtropfen-51dc89b9ac11@brauner>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 12 Dec 2023 15:06:07 +0100
Message-ID: <CAJfpegu3uwAjMQd2jrBty0Lx-oHOczF0x6xNkyqcT4MBqyJo7Q@mail.gmail.com>
Subject: Re: file handle in statx (was: Re: How to cope with subvolumes and
 snapshots on muti-user systems?)
To: Christian Brauner <brauner@kernel.org>
Cc: David Howells <dhowells@redhat.com>, Amir Goldstein <amir73il@gmail.com>, 
	Dave Chinner <david@fromorbit.com>, NeilBrown <neilb@suse.de>, 
	Kent Overstreet <kent.overstreet@linux.dev>, Donald Buczek <buczek@molgen.mpg.de>, 
	linux-bcachefs@vger.kernel.org, Stefan Krueger <stefan.krueger@aei.mpg.de>, 
	linux-fsdevel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
	linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 12 Dec 2023 at 14:48, Christian Brauner <brauner@kernel.org> wrote:

> Exposing the subvolume id in statx() is still fine imho. It's a concept
> shared between btrfs and bcachefs and it's pretty useful for interested
> userspace that wants to make use of these apis.

Exposing subvolume ID should be okay, as long as it's not advertised
as a way to uniquely identify an inode.   Its use should be limited to
finding subvolume boundaries.

> > It might help to have the fh in statx, since that's easier on the
> > userspace programmer than having to deal with two interfaces (i_ino
> > won't go away for some time, because of backward compatibility).
> > OTOH I also don't like the way it would need to be shoehorned into
> > statx.
>
> No, it really doesn't belong into statx().
>
> And besides, the file handle apis name_to_handle_at() are already
> in wider use than a lot of people think. Not just for the exportfs case
> but also for example, cgroupfs uses file handles to provide unique
> identifiers for cgroups that can be compared.

The issue with name_to_handle_at() is its use of the old, non-unique
mount ID.  Yes, yes, we can get away with

 fd = openat(dfd, path, O_PATH);
 name_to_handle_at(fd, "", ..., AT_EMPTY_PATH);
 statx(fd, "", AT_EMPTY_PATH, STATX_MNT_ID_UNIQUE, ...);
 close(fd);

But that's *four* syscalls instead of one...

Thanks,
Miklos

