Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A947C13423C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2020 13:51:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728228AbgAHMvv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jan 2020 07:51:51 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:42899 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727119AbgAHMvu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jan 2020 07:51:50 -0500
Received: by mail-il1-f193.google.com with SMTP id t2so2530051ilq.9;
        Wed, 08 Jan 2020 04:51:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KoaIDjMtfMx7iFf4ZorB4WtDFR0gr8MkRHrKgJexWwg=;
        b=hLiKPkUtFn1/5/lLfRIcy+j7HXeYe8a3o7U70uqmxm3E1ayJmz04/apx3Te5JbTq0G
         AJVA7tExTtt3emwiSBxIkKVrYlJgINpP4RMjNbD1Oiy69SF7W2NdMLQXIYki40v8dSqW
         ZjkwfyWLL6lQJcussns3YaLVR9XSADmnRvZeTfNIWxhRrHRdsXG2mIFlICY23lyilkwQ
         IHapSxcMC6oeQ0f2B2j4blc8vasFA+l64xiB2Gl4oZ7tMFynrAJNcMjRrgwnEXmjExl3
         2gH+MJfAm3v/T+jFPbRbuxMOg6e2oG+f9wOO++RA5DopewXV3rXBQfd9GOgJNPv3/Bv3
         h3Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KoaIDjMtfMx7iFf4ZorB4WtDFR0gr8MkRHrKgJexWwg=;
        b=GS+VGKIiYE02OU0+ya0TZDRrOG8f2MqdqSXkmCWX0zy5jAIAq0t/SiCIc/UPHqSEhQ
         FcCuoEuXmf67EQF3QsAMtG1wNHkMRftJ/YdR0fkzzTfpfKuw1ms/AY2FWwDKYlsIgAJi
         HO82GDkgOKktizFKGRxPjN9jVmquJgvQP+p7qERBhhp3jz60Niv290eLXwOiCuhAj2t3
         uOf+MnjyPVzpJrJBpYXootZ3m+yJyT86VkkPhwXOVP4Gi4Hytw+FI4aYcGDqi9LBpauH
         9wKuucuLw/0RlWhF1ICSDdwqr0INOgL6s9575TpTvREryXDcbj1SipXoHJSKddiRirum
         tydQ==
X-Gm-Message-State: APjAAAVJc6VHCdCyMxi91OJOGBBk9Fzkne8xqiuf2QYrhAJFByz9jg69
        Bh5bejIRX1MxLDT00JLMAunYP2vh/oBOavZUIV0=
X-Google-Smtp-Source: APXvYqyVxXdQ4lE11VQNXo9UW7yajcdnsw/GN2pOs7RWOiS1vc7hOFZMtg2HZIEG/W6sdMncglvNtiNeRgmOE2Vihys=
X-Received: by 2002:a92:1711:: with SMTP id u17mr3759500ill.72.1578487910040;
 Wed, 08 Jan 2020 04:51:50 -0800 (PST)
MIME-Version: 1.0
References: <cover.1578225806.git.chris@chrisdown.name> <91b4ed6727712cb6d426cf60c740fe2f473f7638.1578225806.git.chris@chrisdown.name>
 <4106bf3f-5c99-77a4-717e-10a0ffa6a3fa@huawei.com> <CAOQ4uxijrY7mRkAW1OEym7Xi=v6+fDjhAVBfucwtWPx6bokr5Q@mail.gmail.com>
 <alpine.LSU.2.11.2001062304500.1496@eggly.anvils> <CAOQ4uxj_rLeQY4VXzRbM78T8O=b36-Jrh4C-jdQx_6Aiy=D1BA@mail.gmail.com>
 <alpine.LSU.2.11.2001080206390.1884@eggly.anvils>
In-Reply-To: <alpine.LSU.2.11.2001080206390.1884@eggly.anvils>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 8 Jan 2020 14:51:38 +0200
Message-ID: <CAOQ4uxi2kAnX4+iy2=XXEXDB=zhsCcd8smAh7DvSGbR34k7eww@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] tmpfs: Add per-superblock i_ino support
To:     Hugh Dickins <hughd@google.com>
Cc:     Chris Down <chris@chrisdown.name>,
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 8, 2020 at 12:59 PM Hugh Dickins <hughd@google.com> wrote:
>
> On Tue, 7 Jan 2020, Amir Goldstein wrote:
> >
> > I vote in favor or best of both patches to result in a simpler outcome:
> > 1. use inop approach from Hugh's patch
> > 2. use get_next_ino() instead of per-sb ino_batch for kern_mount
> >
> > Hugh, do you have any evidence or suspect that shmem_file_setup()
> > could be contributing to depleting the global get_next_ino pool?
>
> Depends on what the system is used for: on one system, it will make
> very little use of that pool, on another it will be one of the major
> depleters of the pool.  Generally, it would be kinder to the other
> users of the pool (those that might also care about ino duplication)
> if shmem were to cede all use of it; but a bigger patch, yes.
>
> > Do you have an objection to the combination above?
>
> Objection would be too strong: I'm uncomfortable with it, and not
> tempted to replace our internal implementation by one reverting to
> use get_next_ino(); but not as uncomfortable as I am with holding
> up progress on the issue.
>
> Uncomfortable because of the "depletion" you mention.  Uncomfortable
> because half the reason for ever offering the unlimited "nr_inodes=0"
> mount option was to avoid stat_lock overhead (though, for all I know,
> maybe nobody anywhere uses that option now - and I'll be surprised if
> 0-day uses it and reports any slowdown).
>
> Also uncomfortable because your (excellent, and I'd never thought
> about it that way) argument that the shm_mnt objects are internal
> and unstatable (that may not resemble how you expressed it, I've not
> gone back to search the mails to find where you made the point), is
> not entirely correct nowadays - memfd_create()d objects come from
> that same shm_mnt, and they can be fstat()ed.  What is the
> likelihood that anything would care about duplicated inos of
> memfd_create()d objects?  Fairly low, I think we'll agree; and
> we can probably also say that their inos are an odd implementation
> detail that no memfd_create() user should depend upon anyway.  But
> I mention it in case it changes your own feeling about the shm_mnt.
>

I have no strong feeling either. I just didn't know how intensive its use
is. You have provided sufficient arguments IMO to go with your version
of the patch.

> > > Not-Yet-Signed-off-by: Hugh Dickins <hughd@google.com>
> > >
> > > 1) Probably needs minor corrections for the 32-bit kernel: I wasn't
> > >    worrying about that at the time, and expect some "unsigned long"s
> > >    I didn't need to change for the 64-bit kernel actually need to be
> > >    "u64"s or "ino_t"s now.
> > > 2) The "return 1" from shmem_encode_fh() would nowadays be written as
> > >    "return FILEID_INO32_GEN" (and overlayfs takes particular interest
> > >    in that fileid); yet it already put the high 32 bits of the ino into
> > >    the fh: probably needs a different fileid once high 32 bits are set.
> >
> > Nice spotting, but this really isn't a problem for overlayfs.
> > I agree that it would be nice to follow the same practice as xfs with
> > XFS_FILEID_TYPE_64FLAG, but as one can see from the private
> > flag, this is by no means a standard of any sort.
> >
> > As the name_to_handle_at() man page says:
> > "Other than the use of the handle_bytes field, the caller should treat the
> >  file_handle structure as an opaque data type: the handle_type and f_handle
> >  fields are needed only by a  subsequent call to open_by_handle_at()."
> >
> > It is true that one of my initial versions was checking value returned from
> > encode_fh, but Miklos has pointed out to me that this value is arbitrary
> > and we shouldn't rely on it.
> >
> > In current overlayfs, the value FILEID_INO32_GEN is only used internally
> > to indicate the case where filesystem has no encode_fh op (see comment
> > above ovl_can_decode_fh()).  IOW, only the special case of encoding
> > by the default export_encode_fh() is considered a proof for 32bit inodes.
> > So tmpfs has never been considered as a 32bit inodes filesystem by
> > overlayfs.
>
> Thanks, you know far more about encode_fh() than I ever shall, so for
> now I'll take your word for it that we don't need to make any change
> there for this 64-bit ino support.  One day I should look back, go
> through the encode_fh() callsites, and decide what that "return 1"
> really ought to say.
>

TBH, I meant to say that return 1 shouldn't matter functionally,
but it would be much nicer to change it to FILEID_INO64_GEN
and define that as 0x81 in include/linux/exportfs.h and actually
order the gen word after the inode64 words.

But that is independent of the per-sb ino change, because the
layout of the file handle has always been [gen,inode64] and never
really matched that standard of FILEID_INO32_GEN.

I may send a patch to later on to change that.

Thanks,
Amir.
