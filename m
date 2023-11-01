Return-Path: <linux-fsdevel+bounces-1767-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 364E27DE6B2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Nov 2023 21:11:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1A512817C8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Nov 2023 20:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A67F91B27B;
	Wed,  1 Nov 2023 20:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="SXyYzxp8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FBD719BC0
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Nov 2023 20:10:55 +0000 (UTC)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46E8818D
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Nov 2023 13:10:45 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2c50d1b9f22so2548721fa.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Nov 2023 13:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1698869443; x=1699474243; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NBWFFWWFL2IpGLUFcCc1X6zcQFWEtkQQEaX3iixgj/k=;
        b=SXyYzxp8gd70+wOka2N7MlQPugrq/l1Y1NAu89XkfaR02c7Nw9r1J6RVtmeDX/vu3G
         SBT/O58os/JXeRRMltFQLZolKfXM9Vcm88XSAA2YOykS8ajUe7fxh3ovvR7zjEZY2QBR
         5uYF5EB8vLYWuRiDLZ5lF8Ufr7aJHPmWhDbRY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698869443; x=1699474243;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NBWFFWWFL2IpGLUFcCc1X6zcQFWEtkQQEaX3iixgj/k=;
        b=iDdzDkgoaLrcL5r7UIzttyQfPZg0e2KOUox0IKMKZ849ZkMS/I06DWKg29MGUTiQ3D
         WDpE3Yq7PYKyAs0xZOZPdi+k89HInnu3UqZqfFdAQ7e4voHT4Cj7B70McioLzHXwp+4n
         BZGaKK0DOoEZLhgQ1OtfQmEbjUn046YK5V4DQM40FC3sgr3Y8CazJiFrxC4ktlXWi1OV
         wN8AdMfRF3n/m9BfKDxv5EtXSmmcTHk2Q7vqMCCXOSP894bY0qZIpRckew160bk43yGB
         pS/aUQnotyTgDozMBKcjxZqHNoQkSm8PQq2kHs5mioa1bue6psm/mNEEoCvwFQNeBBzm
         JX1g==
X-Gm-Message-State: AOJu0YxRv8NxDdDrmrFIBkBa4hYbAFL9S2VmHN7jv29m8SzM34PElx6d
	W14wY5TIWtG9ig+JFnMUucBN5TYx7VzYa1aPAuPaQw==
X-Google-Smtp-Source: AGHT+IHlZejJ856jpgLaF0NCg+tZLfFbEtC6LbkWV1DUbxy1jjHBa6800av5ZCcTldTDOn/QlTizDg==
X-Received: by 2002:a05:651c:1988:b0:2c5:2506:c80a with SMTP id bx8-20020a05651c198800b002c52506c80amr9108646ljb.44.1698869443296;
        Wed, 01 Nov 2023 13:10:43 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id r8-20020a2e8e28000000b002b47a15a2eesm281068ljk.45.2023.11.01.13.10.42
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Nov 2023 13:10:42 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2c4fdf94666so2286321fa.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Nov 2023 13:10:42 -0700 (PDT)
X-Received: by 2002:a17:907:25c6:b0:9b2:82d2:a2db with SMTP id
 ae6-20020a17090725c600b009b282d2a2dbmr2496156ejc.28.1698869421474; Wed, 01
 Nov 2023 13:10:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZTjMRRqmlJ+fTys2@dread.disaster.area> <2ef9ac6180e47bc9cc8edef20648a000367c4ed2.camel@kernel.org>
 <ZTnNCytHLGoJY9ds@dread.disaster.area> <6df5ea54463526a3d898ed2bd8a005166caa9381.camel@kernel.org>
 <ZUAwFkAizH1PrIZp@dread.disaster.area> <CAHk-=wg4jyTxO8WWUc1quqSETGaVsPHh8UeFUROYNwU-fEbkJg@mail.gmail.com>
 <ZUBbj8XsA6uW8ZDK@dread.disaster.area> <CAOQ4uxgSRw26J+MPK-zhysZX9wBkXFRNx+n1bwnQwykCJ1=F4Q@mail.gmail.com>
 <3d6a4c21626e6bbb86761a6d39e0fafaf30a4a4d.camel@kernel.org>
 <ZUF4NTxQXpkJADxf@dread.disaster.area> <20231101101648.zjloqo5su6bbxzff@quack3>
In-Reply-To: <20231101101648.zjloqo5su6bbxzff@quack3>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 1 Nov 2023 10:10:03 -1000
X-Gmail-Original-Message-ID: <CAHk-=wj6wy6tNUQm6EtgxfE_J229y1DthpCguqQfTej71yiJXw@mail.gmail.com>
Message-ID: <CAHk-=wj6wy6tNUQm6EtgxfE_J229y1DthpCguqQfTej71yiJXw@mail.gmail.com>
Subject: Re: [PATCH RFC 2/9] timekeeping: new interfaces for multigrain
 timestamp handing
To: Jan Kara <jack@suse.cz>
Cc: Dave Chinner <david@fromorbit.com>, Jeff Layton <jlayton@kernel.org>, 
	Amir Goldstein <amir73il@gmail.com>, Kent Overstreet <kent.overstreet@linux.dev>, 
	Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@linutronix.de>, Stephen Boyd <sboyd@kernel.org>, 
	Chandan Babu R <chandan.babu@oracle.com>, "Darrick J. Wong" <djwong@kernel.org>, 
	"Theodore Ts'o" <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>, Chris Mason <clm@fb.com>, 
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, Hugh Dickins <hughd@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Jan Kara <jack@suse.de>, 
	David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org, linux-mm@kvack.org, 
	linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 1 Nov 2023 at 00:16, Jan Kara <jack@suse.cz> wrote:
>
> OK, but is this compatible with the current XFS behavior? AFAICS currently
> XFS sets sb->s_time_gran to 1 so timestamps currently stored on disk will
> have some mostly random garbage in low bits of the ctime.

I really *really* don't think we can use ctime as a "i_version"
replacement. The whole fine-granularity patches were well-intentioned,
but I do think they were broken.

Note that we can't use ctime as a "i_version" replacement for other
reasons too - you have filesystems like FAT - which people do want to
export - that have a single-second (or is it 2s?) granularity in
reality, even though they report a 1ns value in s_time_gran.

But here's a suggestion that people may hate, but that might just work
in practice:

 - get rid of i_version entirely

 - use the "known good" part of ctime as the upper bits of the change
counter (and by "known good" I mean tv_sec - or possibly even "tv_sec
/ 2" if that dim FAT memory of mine is right)

 - make the rule be that ctime is *never* updated for atime updates
(maybe that's already true, I didn't check - maybe it needs a new
mount flag for nfsd)

 - have a per-inode in-memory and vfs-internal (entirely invisible to
filesystems) "ctime modification counter" that is *NOT* a timestamp,
and is *NOT* i_version

 - make the rule be that the "ctime modification counter" is always
zero, *EXCEPT* if
    (a) I_VERSION_QUERIED is set
   AND
    (b) the ctime modification doesn't modify the "known good" part of ctime

so how the "statx change cookie" ends up being "high bits tv_sec of
ctime, low bits ctime modification cookie", and the end result of that
is:

 - if all the reads happen after the last write (common case), then
the low bits will be zero, because I_VERSION_QUERIED wasn't set when
ctime was modified

 - if you do a write *after* a modification, the ctime cookie is
guaranteed to change, because either the known good (sec/2sec) part of
ctime is new, *or* the counter gets updated

 - if the nfs server reboots, the in-memory counter will be cleared
again, and so the change cookie will cause client cache invalidations,
but *only* for those "ctime changed in the same second _after_
somebody did a read".

 - any long-time caches of files that don't get modified are all fine,
because they will have those low bits zero and depend on just the
stable part of ctime that works across filesystems. So there should be
no nasty thundering herd issues on long-lived caches on lots of
clients if the server reboots, or atime updates every 24 hours or
anything like that.

and note that *NONE* of this requires any filesystem involvement
(except for the rule of "no atime changes ever impact ctime", which
may or may not already be true).

The filesystem does *not* know about that modification counter,
there's no new on-disk stable information.

It's entirely possible that I'm missing something obvious, but the
above sounds to me like the only time you'd have stale invalidations
is really the (unusual) case of having writes after cached reads, and
then a reboot.

We'd get rid of "inode_maybe_inc_iversion()" entirely, and instead
replace it with logic in inode_set_ctime_current() that basically does

 - if the stable part of ctime changes, clear the new 32-bit counter

 - if I_VERSION_QUERIED isn't set, clear the new 32-bit counter

 - otherwise, increment the new 32-bit counter

and then the STATX_CHANGE_COOKIE code basically just returns

   (stable part of ctime << 32) + new 32-bit counter

(and again, the "stable part of ctime" is either just tv_sec, or it's
"tv_sec >> 1" or whatever).

The above does not expose *any* changes to timestamps to users, and
should work across a wide variety of filesystems, without requiring
any special code from the filesystem itself.

And now please all jump on me and say "No, Linus, that won't work, because XYZ".

Because it is *entirely* possible that I missed something truly
fundamental, and the above is completely broken for some obvious
reason that I just didn't think of.

             Linus

