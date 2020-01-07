Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4B75132177
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2020 09:35:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbgAGIfe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jan 2020 03:35:34 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:37046 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726485AbgAGIfe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jan 2020 03:35:34 -0500
Received: by mail-il1-f196.google.com with SMTP id t8so45062179iln.4;
        Tue, 07 Jan 2020 00:35:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r5CoQbT5gUaezb0Iibah3TtEqMoCcxCaRycqJenLuLI=;
        b=TF+eB2GSDXJhF/T59OQ+iy9T+Zc9WjCFPfDt84dzanWVAuGQo1Zlzac9s1+ure2PrC
         Zr6QhNoL6zQSpEpxk5dzYbcxz89HW30+qjOiGDQ+DIIbdy4bz610hIt3kz2Dic8vAFpD
         jykyVpRxnC1LGEcxHkS6wpLOP2g2qFfvpBrXao+c7TpdM91H3ucryMcWzzgzbro4/uoW
         7wvZZMhL5BCOu/8JXC6WqR0s1d+t54oJehDQmyjJ512li1ARK8i2xeAlnxQHfkWuWuLW
         dPCqUuqIAcui9J8dYX8xNvfcPXHFEERrWXg32hpbfdbiUkTx8QR1yWTIVkvQWySPPUjA
         5/Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r5CoQbT5gUaezb0Iibah3TtEqMoCcxCaRycqJenLuLI=;
        b=gl2TewGmJsBHF3OUDhRHcMS40sV8+bFro02AGWSMSdMs59gk7MLW+lwreTMatBz1jk
         uL2O8S2PKDhIRBEz5z1LK7HBOprSR7oYXVn4J3BKZ4iuLeBmxi5BCLU2A/3+ucyWhVBr
         CC4Gtfw0vJKm3J6c0p+VcpeUP+FCz61QlJiwyMdcs/s60n5h1jRzQoF7VyzCTt/ULyDO
         miwHnweqxu4pwKc/NKbVj7jzwPZ6037+buQusjIO6u4EXkYYqY/XOVKeQCB650JZbsMJ
         I0Gmm1SROLdv9L/zGOOcpdPk1E2MWNQtzsPAxtf7WCK/IcdmT033YdmQGY8AHo9d+5ea
         HjIQ==
X-Gm-Message-State: APjAAAUjokOxU7nRpqnJf47ueHpp7bR3RIVFd6pg72sDYSoMmtKsc81r
        6fTNB13KTcWPkoJvAlEpT9Nn7y2BkhWu1sqdq3k=
X-Google-Smtp-Source: APXvYqwZ0/67PFrgvxaSPV2Zn/WpieHVE9mDArG9ZypU/RctWuftoA1HuKBAViM3JUXgxussr9iLd0lj+SSrAKpYXBA=
X-Received: by 2002:a92:5c8a:: with SMTP id d10mr94970292ilg.137.1578386133561;
 Tue, 07 Jan 2020 00:35:33 -0800 (PST)
MIME-Version: 1.0
References: <cover.1578225806.git.chris@chrisdown.name> <91b4ed6727712cb6d426cf60c740fe2f473f7638.1578225806.git.chris@chrisdown.name>
 <4106bf3f-5c99-77a4-717e-10a0ffa6a3fa@huawei.com> <CAOQ4uxijrY7mRkAW1OEym7Xi=v6+fDjhAVBfucwtWPx6bokr5Q@mail.gmail.com>
 <alpine.LSU.2.11.2001062304500.1496@eggly.anvils>
In-Reply-To: <alpine.LSU.2.11.2001062304500.1496@eggly.anvils>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 7 Jan 2020 10:35:22 +0200
Message-ID: <CAOQ4uxj_rLeQY4VXzRbM78T8O=b36-Jrh4C-jdQx_6Aiy=D1BA@mail.gmail.com>
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

> Chris, Amir, thank you both for all the work you have been putting
> into this over the holiday.  I'm only now catching up, sorry.
>
> It appears that what you are ending up with above is very close to
> the patch Google has been using for several years.  I'm glad Chris
> has explored some interesting options, disappointed that you had no
> more success than I had in trying to solve it efficiently with 32-bit
> inos, agree with the way in which Amir cut it back.  That we've come to
> the same conclusions independently is good confirmation of this approach.
>

Indeed :)

> Only yesterday did I get to see that Amir had asked to see my patch on
> the 27th: rediffed against 5.5-rc5, appended now below.  I'm showing it,
> though it's known deficient in three ways (not to mention lack of config
> or mount options, but I now see Dave Chinner has an interesting take on
> those) - better make it visible to you now, than me delay you further.
>
> It does indicate a couple of improvements to Chris's current patch:
> reducing use of stat_lock, as Amir suggested (in both nr_inodes limited
> and unlimited cases); and need to fix shmem_encode_fh(), which neither
> of us did yet.  Where we should go from here, fix Chris's or fix mine,
> I've not decided.
>

I vote in favor or best of both patches to result in a simpler outcome:
1. use inop approach from Hugh's patch
2. use get_next_ino() instead of per-sb ino_batch for kern_mount

Hugh, do you have any evidence or suspect that shmem_file_setup()
could be contributing to depleting the global get_next_ino pool?
Do you have an objection to the combination above?

> From: Hugh Dickins <hughd@google.com>
> Date: Fri, 7 Aug 2015 20:08:53 -0700
> Subject: [PATCH] tmpfs: provide 64-bit inode numbers
>
> Some programs (including ld.so and clang) try to deduplicate opened
> files by comparing st_dev and st_ino, which breaks down when two files
> on the same tmpfs have the same inode number: we are now hitting this
> problem too often.  J. R. Okajima has reported the same problem with
> backup tools.
>
> tmpfs is currently sharing the same 32-bit get_next_ino() pool as
> sockets, pipes, ramfs, hugetlbfs etc.  It delivers 32-bit inos even
> on a 64-bit kernel for one reason: because if a 32-bit executable
> compiled without _FILE_OFFSET_BITS=64 tries to stat a file with an
> ino which won't fit in 32 bits, glibc fails that with EOVERFLOW.
> glibc is being correct, but unhelpful: so 2.6.22 commit 866b04fccbf1
> ("inode numbering: make static counters in new_inode and iunique be
> 32 bits") forced get_next_ino() to unsigned int.
>
> But whatever the upstream need to avoid surprising a mis-built
> 32-bit executable, Google production can be sure of the 64-bit
> environment, and any remaining 32-bit executables built with
> _FILE_OFFSET_BITS=64 (our files are sometimes bigger than 2G).
>
> So, leave get_next_ino() as it is, but convert tmpfs to supply
> unsigned long inos, and let each superblock keep its own account:
> it was weird to be sharing a pool with such disparate uses before.
>
> shmem_reserve_inode() already provides a good place to do this;
> and normally it has to take stat_lock to update free_inodes, so
> no overhead to increment its next_ino under the same lock.  But
> if it's the internal shm_mnt, or mounted with "nr_inodes=0" to
> increase scalability by avoiding that stat_lock, then use the
> same percpu batching technique as get_next_ino().
>
> Take on board 4.2 commit 2adc376c5519 ("vfs: avoid creation of
> inode number 0 in get_next_ino"): for safety, skip any ino whose
> low 32 bits is 0.
>
> Upstream?  That's tougher: maybe try to upstream this as is, and
> see what falls out; maybe add ino32 or ino64 mount options before
> trying; or maybe upstream has to stick with the 32-bit ino, and a
> scheme more complicated than this be implemented for tmpfs.
>
> Not-Yet-Signed-off-by: Hugh Dickins <hughd@google.com>
>
> 1) Probably needs minor corrections for the 32-bit kernel: I wasn't
>    worrying about that at the time, and expect some "unsigned long"s
>    I didn't need to change for the 64-bit kernel actually need to be
>    "u64"s or "ino_t"s now.
> 2) The "return 1" from shmem_encode_fh() would nowadays be written as
>    "return FILEID_INO32_GEN" (and overlayfs takes particular interest
>    in that fileid); yet it already put the high 32 bits of the ino into
>    the fh: probably needs a different fileid once high 32 bits are set.

Nice spotting, but this really isn't a problem for overlayfs.
I agree that it would be nice to follow the same practice as xfs with
XFS_FILEID_TYPE_64FLAG, but as one can see from the private
flag, this is by no means a standard of any sort.

As the name_to_handle_at() man page says:
"Other than the use of the handle_bytes field, the caller should treat the
 file_handle structure as an opaque data type: the handle_type and f_handle
 fields are needed only by a  subsequent call to open_by_handle_at()."

It is true that one of my initial versions was checking value returned from
encode_fh, but Miklos has pointed out to me that this value is arbitrary
and we shouldn't rely on it.

In current overlayfs, the value FILEID_INO32_GEN is only used internally
to indicate the case where filesystem has no encode_fh op (see comment
above ovl_can_decode_fh()).  IOW, only the special case of encoding
by the default export_encode_fh() is considered a proof for 32bit inodes.
So tmpfs has never been considered as a 32bit inodes filesystem by
overlayfs.

Thanks,
Amir.
