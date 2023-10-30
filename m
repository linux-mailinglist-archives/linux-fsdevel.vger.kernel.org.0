Return-Path: <linux-fsdevel+bounces-1594-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE247DC2FE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Oct 2023 00:12:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC7FE2815DC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Oct 2023 23:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE3B21865E;
	Mon, 30 Oct 2023 23:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="CGvpu934"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4641F182B3
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Oct 2023 23:12:40 +0000 (UTC)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2D62E8
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Oct 2023 16:12:37 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-5435336ab0bso1542765a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Oct 2023 16:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1698707556; x=1699312356; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=I9soNDg/CzKcFVIkPX7HzsMrN43wo2kJXg9OOVu3o/I=;
        b=CGvpu934Hc5hnmVyibq3Yt+N3cIVjGUC74iaGQXhaGVhpYXcbaEpQjmm6YaaE7u6PK
         sGq1J8qKYV9/oj+R9ZUR4dgplMYf4Q2WiGL3wsg2z1TxETPc8aVKISOz2YevZzxoMl4f
         nMSnnE2L34UlyBgEFgpnkSkXO09MffeKMxmzM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698707556; x=1699312356;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I9soNDg/CzKcFVIkPX7HzsMrN43wo2kJXg9OOVu3o/I=;
        b=hqm5u+YEYWWsKWGLzUjmpp3ahPqEh443B/KcmHUxSSL1kLA66izhGhr6lFOiI7DXpR
         0mGU4W68AFKUvg7hbqrM2sElIGpkL6t92cWP8TGdQdkkD5TsnkytoBleMmUg4xbl5NS6
         mrg2e7APTs1HMIIy8+crsWQiPur030G1b92kKtDUMPL/kzBEB1LcuVradCbj96gVpcec
         jit6QFQicc7T4T9IcfixM8MfYRNbd3WbpQhKltrVtV2qdIoJsc77Tz/oyKwJgVAWq5/H
         CW0ai+cKgOrwoOmwtvRSufKLJSQyat2XAdNt8c19omp3HyFK6QzDbxXmJ4A2soHFBsed
         5ajQ==
X-Gm-Message-State: AOJu0Yy2//6MRt3z5Q1urUEl100jS3gClW3c0jKp7ugff1AFGvunbeVa
	1WIyJbHdXEPHj0jsmZcIgYvFqj5YdvW2feGoYevQ/Q==
X-Google-Smtp-Source: AGHT+IHP+7BNMrAZpRlhZaC21cjv7l2YwEKVsS+1vsJgUdihyvrcSTJgSbWnIeEN6JEZCxym06alNg==
X-Received: by 2002:a17:907:608a:b0:9ae:74d1:4b45 with SMTP id ht10-20020a170907608a00b009ae74d14b45mr9548939ejc.65.1698707555979;
        Mon, 30 Oct 2023 16:12:35 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id a25-20020a1709066d5900b009b97aa5a3aesm25164ejt.34.2023.10.30.16.12.35
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Oct 2023 16:12:35 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-53db360294fso8545177a12.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Oct 2023 16:12:35 -0700 (PDT)
X-Received: by 2002:a17:907:25c4:b0:9ae:4776:5a3a with SMTP id
 ae4-20020a17090725c400b009ae47765a3amr9873098ejc.39.1698707534524; Mon, 30
 Oct 2023 16:12:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <61b32a4093948ae1ae8603688793f07de764430f.camel@kernel.org>
 <ZTcBI2xaZz1GdMjX@dread.disaster.area> <CAHk-=whphyjjLwDcEthOOFXXfgwGrtrMnW2iyjdQioV6YSMEPw@mail.gmail.com>
 <ZTc8tClCRkfX3kD7@dread.disaster.area> <CAOQ4uxhJGkZrUdUJ72vjRuLec0g8VqgRXRH=x7W9ogMU6rBxcQ@mail.gmail.com>
 <d539804a2a73ad70265c5fa599ecd663cd235843.camel@kernel.org>
 <ZTjMRRqmlJ+fTys2@dread.disaster.area> <2ef9ac6180e47bc9cc8edef20648a000367c4ed2.camel@kernel.org>
 <ZTnNCytHLGoJY9ds@dread.disaster.area> <6df5ea54463526a3d898ed2bd8a005166caa9381.camel@kernel.org>
 <ZUAwFkAizH1PrIZp@dread.disaster.area>
In-Reply-To: <ZUAwFkAizH1PrIZp@dread.disaster.area>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 30 Oct 2023 13:11:56 -1000
X-Gmail-Original-Message-ID: <CAHk-=wg4jyTxO8WWUc1quqSETGaVsPHh8UeFUROYNwU-fEbkJg@mail.gmail.com>
Message-ID: <CAHk-=wg4jyTxO8WWUc1quqSETGaVsPHh8UeFUROYNwU-fEbkJg@mail.gmail.com>
Subject: Re: [PATCH RFC 2/9] timekeeping: new interfaces for multigrain
 timestamp handing
To: Dave Chinner <david@fromorbit.com>
Cc: Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
	Kent Overstreet <kent.overstreet@linux.dev>, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, John Stultz <jstultz@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Stephen Boyd <sboyd@kernel.org>, 
	Chandan Babu R <chandan.babu@oracle.com>, "Darrick J. Wong" <djwong@kernel.org>, 
	"Theodore Ts'o" <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>, Chris Mason <clm@fb.com>, 
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, Hugh Dickins <hughd@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Jan Kara <jack@suse.de>, 
	David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org, linux-mm@kvack.org, 
	linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 30 Oct 2023 at 12:37, Dave Chinner <david@fromorbit.com> wrote:
>
> If XFS can ignore relatime or lazytime persistent updates for given
> situations, then *we don't need to make periodic on-disk updates of
> atime*. This makes the whole problem of "persistent atime update bumps
> i_version" go away because then we *aren't making persistent atime
> updates* except when some other persistent modification that bumps
> [cm]time occurs.

Well, I think this should be split into two independent questions:

 (a) are relatime or lazytime atime updates persistent if nothing else changes?

 (b) do atime updates _ever_ update i_version *regardless* of relatime
or lazytime?

and honestly, I think the best answer to (b) would be that "no,
i_version should simply not change for atime updates". And I think
that answer is what it is because no user of i_version seems to want
it.

Now, the reason it's a single question for you is that apparently for
XFS, the only thing that matters is "inode was written to disk" and
that "di_changecount" value is thus related to the persistence of
atime updates, but splitting di_changecount out to be a separate thing
from i_version seems to be on the table, so I think those two things
really could be independent issues.

> But I don't want to do this unconditionally - for systems not
> running anything that samples i_version we want relatime/lazytime
> to behave as they are supposed to and do periodic persistent updates
> as per normal. Principle of least surprise and all that jazz.

Well - see above: I think in a perfect world, we'd simply never change
i_version at all for any atime updates, and relatime/lazytime simply
wouldn't be an issue at all wrt i_version.

Wouldn't _that_ be the trule "least surprising" behavior? Considering
that nobody wants i_version to change for what are otherwise pure
reads (that's kind of the *definition* of atime, after all).

Now, the annoyance here is that *both* (a) and (b) then have that
impact of "i_version no longer tracks di_changecount".

So I don't think the issue here is "i_version" per se. I think in a
vacuum, the best option of i_version is pretty obvious.  But if you
want i_version to track di_changecount, *then* you end up with that
situation where the persistence of atime matters, and i_version needs
to update whenever a (persistent) atime update happens.

> So we really need an indication for inodes that we should enable this
> mode for the inode. I have asked if we can have per-operation
> context flag to trigger this given the needs for io_uring to have
> context flags for timestamp updates to be added.

I really think some kind of new and even *more* complex and
non-intuitive behavior is the worst of both worlds. Having atime
updates be conditionally persistent - on top of already being delayed
by lazytime/relatime - and having the persistence magically change
depending on whether something wants to get i_version updates - sounds
just completely crazy.

Particularly as *none* of the people who want i_version updates
actually want them for atime at all.

So I really think this all boils down to "is xfs really willing to
split bi_changecount from i_version"?

> I have asked if we can have an inode flag set by the VFS or
> application code for this. e.g. a flag set by nfsd whenever it accesses a
> given inode.
>
> I have asked if this inode flag can just be triggered if we ever see
> I_VERSION_QUERIED set or statx is used to retrieve a change cookie,
> and whether this is a reliable mechanism for setting such a flag.

See above: linking this to I_VERSION_QUERIED is horrific. The people
who set that bit do *NOT* want atime updates to change i_version under
any circumstances. It was always a mistake.

This really is all *entirely* an artifact of that "bi_changecount" vs
"i_version" being tied together. You did seem to imply that you'd be
ok with having "bi_changecount" be split from i_version, ie from an
earlier email in this thread:

 "Now that NFS is using a proper abstraction (i.e. vfs_statx()) to get
  the change cookie, we really don't need to expose di_changecount in
  i_version at all - we could simply copy an internal di_changecount
  value into the statx cookie field in xfs_vn_getattr() and there
  would be almost no change of behaviour from the perspective of NFS
  and IMA at all"

but while I suspect *that* part is easy and straightforward, the
problem then becomes one of "what about the persistence of i_version",
and then you'd need a new field for *that* anyway, and would want a
new on-disk format regardless.

           Linus

