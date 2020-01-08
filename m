Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42E17133FC0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2020 11:59:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727337AbgAHK7P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jan 2020 05:59:15 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:44449 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726723AbgAHK7O (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jan 2020 05:59:14 -0500
Received: by mail-oi1-f195.google.com with SMTP id d62so2218065oia.11
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Jan 2020 02:59:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=MN2cXAliraNErMytcQEiHA1DpubOJVOt0C1yY2AdeAE=;
        b=wG3zHLtX0FTDuVGB48Ua3E3u7yYmSpghevtOvVV4FA5G/ldz3MPFPHyCjcCv1/DW1S
         3+m61Tuequ2T1V3Citkfi/5gMEZjU3FSI/Cci2kszcw6QFy99z5pYpSW4vLadxT4XBUq
         zK49Liv5klhkpMKtLP/+soDQNlmVQjvq+8yFvXjPui+S2cm0TxM+IT9iX6vW97BAuSzh
         h+14nlny/zZkyCVmKLQslRx2wFPnKGFagzWn/c/F6YJAQkCw3LA1bq7oNGbWl1lnBeNW
         8jTB+ryPX+AlQn50CSzsrJ/V2qa0wgZI5CHanL/68LDXJGdOrUVtOOTlpe8gX+M01BHa
         oeHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=MN2cXAliraNErMytcQEiHA1DpubOJVOt0C1yY2AdeAE=;
        b=o/LEGTHNKrke+26Skb7urUG7d7t0BYQPV2dFKWNgbkYrGcZXIY7MlFQI5PaLeKt+qi
         9ekSaghrs9EuGZibH0DES2oaYJLDKYXKy3hVfKF9iVOoOdVmSDRPXyt0B7P/vgZ7INKf
         93VXC7dUVKgRKjcTNQRxwzRewXm/pUS20Iw3ShCMXfVOoaZKqhNCFiHHdiKOPEK5SkjJ
         0lb//bEqkrlQJ3O29+i6c7wcSswd1rTAHOYo4qlY7EkPS+GjyLCV2gZQSjmPk27X9pop
         duEiO7HJdz+CGDTlXZospF4It76YyJwPs8c48hzK+O1t8TeLqeah3JETk/6xKZJFDo45
         NJtg==
X-Gm-Message-State: APjAAAXgXeYJI7A7vfFx18KiA1Pv0iaEtO5MOgpz7MDB/9t6L3Ngrdf/
        ZaMOPuh+VRDQDxWrc7MJc6XYcw==
X-Google-Smtp-Source: APXvYqyFnh2MaLwhOU5mivxTqJaVc4PKe1i0dmQjpA70sG1oTGcfsNkyCXb/a+kE/EWP0n7fQ1lYfA==
X-Received: by 2002:a05:6808:a11:: with SMTP id n17mr2484062oij.94.1578481153648;
        Wed, 08 Jan 2020 02:59:13 -0800 (PST)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id r205sm973416oih.54.2020.01.08.02.59.11
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 08 Jan 2020 02:59:12 -0800 (PST)
Date:   Wed, 8 Jan 2020 02:58:52 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Amir Goldstein <amir73il@gmail.com>
cc:     Hugh Dickins <hughd@google.com>, Chris Down <chris@chrisdown.name>,
        "zhengbin (A)" <zhengbin13@huawei.com>,
        "J. R. Okajima" <hooanon05g@gmail.com>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, kernel-team@fb.com
Subject: Re: [PATCH v5 1/2] tmpfs: Add per-superblock i_ino support
In-Reply-To: <CAOQ4uxj_rLeQY4VXzRbM78T8O=b36-Jrh4C-jdQx_6Aiy=D1BA@mail.gmail.com>
Message-ID: <alpine.LSU.2.11.2001080206390.1884@eggly.anvils>
References: <cover.1578225806.git.chris@chrisdown.name> <91b4ed6727712cb6d426cf60c740fe2f473f7638.1578225806.git.chris@chrisdown.name> <4106bf3f-5c99-77a4-717e-10a0ffa6a3fa@huawei.com> <CAOQ4uxijrY7mRkAW1OEym7Xi=v6+fDjhAVBfucwtWPx6bokr5Q@mail.gmail.com>
 <alpine.LSU.2.11.2001062304500.1496@eggly.anvils> <CAOQ4uxj_rLeQY4VXzRbM78T8O=b36-Jrh4C-jdQx_6Aiy=D1BA@mail.gmail.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 7 Jan 2020, Amir Goldstein wrote:
> 
> I vote in favor or best of both patches to result in a simpler outcome:
> 1. use inop approach from Hugh's patch
> 2. use get_next_ino() instead of per-sb ino_batch for kern_mount
> 
> Hugh, do you have any evidence or suspect that shmem_file_setup()
> could be contributing to depleting the global get_next_ino pool?

Depends on what the system is used for: on one system, it will make
very little use of that pool, on another it will be one of the major
depleters of the pool.  Generally, it would be kinder to the other
users of the pool (those that might also care about ino duplication)
if shmem were to cede all use of it; but a bigger patch, yes.

> Do you have an objection to the combination above?

Objection would be too strong: I'm uncomfortable with it, and not
tempted to replace our internal implementation by one reverting to
use get_next_ino(); but not as uncomfortable as I am with holding
up progress on the issue.

Uncomfortable because of the "depletion" you mention.  Uncomfortable
because half the reason for ever offering the unlimited "nr_inodes=0"
mount option was to avoid stat_lock overhead (though, for all I know,
maybe nobody anywhere uses that option now - and I'll be surprised if
0-day uses it and reports any slowdown).

Also uncomfortable because your (excellent, and I'd never thought
about it that way) argument that the shm_mnt objects are internal
and unstatable (that may not resemble how you expressed it, I've not
gone back to search the mails to find where you made the point), is
not entirely correct nowadays - memfd_create()d objects come from
that same shm_mnt, and they can be fstat()ed.  What is the
likelihood that anything would care about duplicated inos of
memfd_create()d objects?  Fairly low, I think we'll agree; and
we can probably also say that their inos are an odd implementation
detail that no memfd_create() user should depend upon anyway.  But
I mention it in case it changes your own feeling about the shm_mnt.

> > Not-Yet-Signed-off-by: Hugh Dickins <hughd@google.com>
> >
> > 1) Probably needs minor corrections for the 32-bit kernel: I wasn't
> >    worrying about that at the time, and expect some "unsigned long"s
> >    I didn't need to change for the 64-bit kernel actually need to be
> >    "u64"s or "ino_t"s now.
> > 2) The "return 1" from shmem_encode_fh() would nowadays be written as
> >    "return FILEID_INO32_GEN" (and overlayfs takes particular interest
> >    in that fileid); yet it already put the high 32 bits of the ino into
> >    the fh: probably needs a different fileid once high 32 bits are set.
> 
> Nice spotting, but this really isn't a problem for overlayfs.
> I agree that it would be nice to follow the same practice as xfs with
> XFS_FILEID_TYPE_64FLAG, but as one can see from the private
> flag, this is by no means a standard of any sort.
> 
> As the name_to_handle_at() man page says:
> "Other than the use of the handle_bytes field, the caller should treat the
>  file_handle structure as an opaque data type: the handle_type and f_handle
>  fields are needed only by a  subsequent call to open_by_handle_at()."
> 
> It is true that one of my initial versions was checking value returned from
> encode_fh, but Miklos has pointed out to me that this value is arbitrary
> and we shouldn't rely on it.
> 
> In current overlayfs, the value FILEID_INO32_GEN is only used internally
> to indicate the case where filesystem has no encode_fh op (see comment
> above ovl_can_decode_fh()).  IOW, only the special case of encoding
> by the default export_encode_fh() is considered a proof for 32bit inodes.
> So tmpfs has never been considered as a 32bit inodes filesystem by
> overlayfs.

Thanks, you know far more about encode_fh() than I ever shall, so for
now I'll take your word for it that we don't need to make any change
there for this 64-bit ino support.  One day I should look back, go
through the encode_fh() callsites, and decide what that "return 1"
really ought to say.

It's inconvenient, I'm sorry, but I shall have to go quiet again
for a few days - I'm here, but cannot afford to split my attention.

Hugh
