Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51F1310C2AF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Nov 2019 04:06:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727303AbfK1DGQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Nov 2019 22:06:16 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36378 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727113AbfK1DGQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Nov 2019 22:06:16 -0500
Received: by mail-pl1-f193.google.com with SMTP id d7so10938179pls.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Nov 2019 19:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=nFJCJ5SIo3p9Jx2NXig3r4Tk0t2z15WotK9DXLBHJu4=;
        b=kOzM4GBPxqieO/FZ+Kl7+6YKGqI6sw6hSmzUx0PkcXgfB+/Hx2mwc2mVHZ9IBAHXoZ
         idrIzJmTfQrmaoza88doyvx1Ep876gFgIxl64RPfip2JqhYF9UNTTS+2Y2ywpBgADf/1
         Hx/yVBLoV7SHyiVXt1tRvBAIdHW2G7+XGbH/fg79IIRf1Dm3GnNVPVkocRJipmnowve+
         Ru4hOGo8i3zJyIB4S8oib1bBCMsaTGSyzd3y1YYqrY7zes05UWTYbM0CMuXlsrRUiQpT
         L/6SdxczY38ouLPJXEzzcw2pmLZvBC675IoA4TvVdKGR/A7T2CrJtD+YeH55piaZrAoo
         L8hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=nFJCJ5SIo3p9Jx2NXig3r4Tk0t2z15WotK9DXLBHJu4=;
        b=euzCAsQWiqxulylW+TTE7NHMa6csQxg9rHJNsrXvJTiJhA3zniJ04k6alRhY5qAM9A
         TbyAiJWfQkbsWyYin0XBrvTNo/HMxMZS4Sv10PWQMPVBTjMqC98USRl6NUKkixTzsh9O
         CTGquDxEnhUs3U1Ew2N1BQyrBhrdj/iAzYmIi8xNaD3lW+sm1vX0tvTX645Z6a74H4+6
         zQLCzmf3QiSNvsUdfHe45W9REK/hNDxw03/Rgg0I07GZtyJt2IvwsncKuQQreSvDC/Ws
         tX1g3i1JISOOYcXBQdMpsBMSr9TN7xEtxp96ShcBNuzC9KYU4WUBHmXOni2h/sChS1TN
         dB7A==
X-Gm-Message-State: APjAAAV//UAefCsw3bEiS1Wxi9r+a+jj6dxYRuHh4meE0w/1v5cVCVnZ
        ByX4b6odUtgsrBKzKJpBMTKo/A==
X-Google-Smtp-Source: APXvYqyz0MgyzHb3Q1OWlZcOBF+9VwXHOFIPqtW6eeZ/KjrlXD1ju4GZUXMcHHf24qYS0l3AFJB0gQ==
X-Received: by 2002:a17:90a:9604:: with SMTP id v4mr9847580pjo.105.1574910374131;
        Wed, 27 Nov 2019 19:06:14 -0800 (PST)
Received: from [100.112.92.218] ([104.133.9.106])
        by smtp.gmail.com with ESMTPSA id o8sm3559963pjo.7.2019.11.27.19.06.12
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 27 Nov 2019 19:06:13 -0800 (PST)
Date:   Wed, 27 Nov 2019 19:06:01 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Yang Shi <yang.shi@linux.alibaba.com>
cc:     "Kirill A. Shutemov" <kirill@shutemov.name>, hughd@google.com,
        kirill.shutemov@linux.intel.com, aarcange@redhat.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] mm: shmem: allow split THP when truncating THP
 partially
In-Reply-To: <14b7c24b-706e-79cf-6fbc-f3c042f30f06@linux.alibaba.com>
Message-ID: <alpine.LSU.2.11.1911271718130.652@eggly.anvils>
References: <1574471132-55639-1-git-send-email-yang.shi@linux.alibaba.com> <20191125093611.hlamtyo4hvefwibi@box> <3a35da3a-dff0-a8ca-8269-3018fff8f21b@linux.alibaba.com> <20191125183350.5gmcln6t3ofszbsy@box> <9a68b929-2f84-083d-0ac8-2ceb3eab8785@linux.alibaba.com>
 <14b7c24b-706e-79cf-6fbc-f3c042f30f06@linux.alibaba.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="0-183993477-1574910373=:652"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-183993477-1574910373=:652
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 26 Nov 2019, Yang Shi wrote:
> On 11/25/19 11:33 AM, Yang Shi wrote:
> > On 11/25/19 10:33 AM, Kirill A. Shutemov wrote:
> > > On Mon, Nov 25, 2019 at 10:24:38AM -0800, Yang Shi wrote:
> > > > On 11/25/19 1:36 AM, Kirill A. Shutemov wrote:
> > > > > On Sat, Nov 23, 2019 at 09:05:32AM +0800, Yang Shi wrote:
> > > > > > Currently when truncating shmem file, if the range is partial o=
f
> > > > > > THP
> > > > > > (start or end is in the middle of THP), the pages actually will
> > > > > > just get
> > > > > > cleared rather than being freed unless the range cover the whol=
e
> > > > > > THP.
> > > > > > Even though all the subpages are truncated (randomly or
> > > > > > sequentially),
> > > > > > the THP may still be kept in page cache.=C2=A0 This might be fi=
ne for
> > > > > > some
> > > > > > usecases which prefer preserving THP.
> > > > > >=20
> > > > > > But, when doing balloon inflation in QEMU, QEMU actually does h=
ole
> > > > > > punch
> > > > > > or MADV_DONTNEED in base page size granulairty if hugetlbfs is =
not
> > > > > > used.
> > > > > > So, when using shmem THP as memory backend QEMU inflation actua=
lly
> > > > > > doesn't
> > > > > > work as expected since it doesn't free memory.=C2=A0 But, the i=
nflation
> > > > > > usecase really needs get the memory freed.=C2=A0 Anonymous THP =
will not
> > > > > > get
> > > > > > freed right away too but it will be freed eventually when all
> > > > > > subpages are
> > > > > > unmapped, but shmem THP would still stay in page cache.
> > > > > >=20
> > > > > > To protect the usecases which may prefer preserving THP, introd=
uce
> > > > > > a
> > > > > > new fallocate mode: FALLOC_FL_SPLIT_HPAGE, which means spltting=
 THP
> > > > > > is
> > > > > > preferred behavior if truncating partial THP.=C2=A0 This mode j=
ust makes
> > > > > > sense to tmpfs for the time being.

Sorry, I haven't managed to set aside enough time for this until now.

First off, let me say that I firmly believe this punch-split behavior
should be the standard behavior (like in my huge tmpfs implementation),
and we should not need a special FALLOC_FL_SPLIT_HPAGE to do it.
But I don't know if I'll be able to persuade Kirill of that.

If the caller wants to write zeroes into the file, she can do so with the
write syscall: the caller has asked to punch a hole or truncate the file,
and in our case, like your QEMU case, hopes that memory and memcg charge
will be freed by doing so.  I'll be surprised if changing the behavior
to yours and mine turns out to introduce a regression, but if it does,
I guess we'll then have to put it behind a sysctl or whatever.

IIUC the reason that it's currently implemented by clearing the hole
is because split_huge_page() (unlike in older refcounting days) cannot
be guaranteed to succeed.  Which is unfortunate, and none of us is very
keen to build a filesystem on unreliable behavior; but the failure cases
appear in practice to be rare enough, that it's on balance better to give
the punch-hole-truncate caller what she asked for whenever possible.

> > > > > We need to clarify interaction with khugepaged. This implementati=
on
> > > > > doesn't do anything to prevent khugepaged from collapsing the ran=
ge
> > > > > back
> > > > > to THP just after the split.
> > > > Yes, it doesn't. Will clarify this in the commit log.
> > > Okay, but I'm not sure that documention alone will be enough. We need
> > > proper design.
> >=20
> > Maybe we could try to hold inode lock with read during collapse_file().=
 The
> > shmem fallocate does acquire inode lock with write, this should be able=
 to
> > synchronize hole punch and khugepaged. And, shmem just needs hold inode
> > lock for llseek and fallocate, I'm supposed they are should be called n=
ot
> > that frequently to have impact on khugepaged. The llseek might be often=
,
> > but it should be quite fast. However, they might get blocked by khugepa=
ged.
> >=20
> > It sounds safe to hold a rwsem during collapsing THP.

No, I don't think we want to take any more locks while collapsing THP,
but that wasn't really the point.  We're not concerned about a *race*
between splitting and khugepaged reassembling (I'm assuming that any
such race would already exist, and be well-guarded against by all the
refcount checks, punchhole not adding anything new here; but perhaps
I'm assuming too blithely, and it is worth checking over).

The point, as I see it anyway, is the contradiction in effort: the
caller asks for hole to be punched, we do that, then a few seconds
or minutes later, khugepaged comes along and fills in the hole (if
huge page availability and memcg limit allow it).

I agree that's not very satisfactory, but I think it's a side issue:
we don't have a good mechanism to tell khugepaged to keep off a range.
As it is, fallocate and ftruncate ought to do the job expected of them,
and khugepaged ought to do the job expected of it.  And in many cases,
the punched file will not even be mapped (visible to khugepaged), or
max_ptes_none set to exclude working on such holes.

Is khugepaged's action an issue for your QEMU case?

> >=20
> > Or we could set VM_NOHUGEPAGE in shmem inode's flag with hole punch and
> > clear it after truncate, then check the flag before doing collapse in
> > khugepaged. khugepaged should not need hold the inode lock during colla=
pse
> > since it could be released after the flag is checked.
>=20
> By relooking the code, it looks the latter one (check VM_NOHUGEPAGE) does=
n't
> make sense, it can't prevent khugepaged from collapsing THP in parallel.
>=20
> >=20
> > >=20
> > > > > > @@ -976,8 +1022,31 @@ static void shmem_undo_range(struct inode
> > > > > > *inode, loff_t lstart, loff_t lend,
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 }
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 unlock_page(page);
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > > > > +rescan_split:
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pa=
gevec_remove_exceptionals(&pvec);
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pa=
gevec_release(&pvec);
> > > > > > +
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (split && PageTr=
ansCompound(page)) {
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 /* The THP may get freed under us */
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 if (!get_page_unless_zero(compound_head(page)))
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto rescan_out;
> > > > > > +
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 lock_page(page);
> > > > > > +
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 /*
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 * The extra pins from page cache lookup have been
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 * released by pagevec_release().
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 */
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 if (!split_huge_page(page)) {
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unlock_page(page);
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 put_page(page);
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Re-look up page cache from current index =
*/
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto again;
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 }
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 unlock_page(page);
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 put_page(page);
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > > > > +rescan_out:
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 in=
dex++;
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > > > Doing get_page_unless_zero() just after you've dropped the pin fo=
r
> > > > > the
> > > > > page looks very suboptimal.
> > > > If I don't drop the pins the THP can't be split. And, there might b=
e
> > > > more
> > > > than one pins from find_get_entries() if I read the code correctly.=
 For
> > > > example, truncate 8K length in the middle of THP, the THP's refcoun=
t
> > > > would
> > > > get bumpped twice since=C2=A0 two sub pages would be returned.
> > > Pin the page before pagevec_release() and avoid get_page_unless_zero(=
).
> > >=20
> > > Current code is buggy. You need to check that the page is still belon=
g to
> > > the file after speculative lookup.

Yes indeed (I think you can even keep the page locked, but I may be wrong).

> >=20
> > Yes, I missed this point. Thanks for the suggestion.

The main problem I see is your "goto retry" and "goto again":
split_huge_page() may fail because a get_page() somewhere is holding
a transient reference to the page, or it may fail because there's a
GUP that holds a reference for days: you do not want to be stuck here
going round and around the loop waiting for that GUP to be released!

It's nice that we already have a trylock_page() loop followed by a
lock_page() loop.  When split_huge_page() fails, the trylock_page()
loop can simply move on to the next page (skip over the compound page,
or retry it subpage by subpage? I've forgotten the pros and cons),
and leave final resolution to the later lock_page() loop: which has to
accept when split_huge_page() failed, and fall back to clearing instead.

I would prefer a smaller patch than your RFC: making split the
default behavior cuts out a lot of it, but I think there's still
more that can be cut.  Here's the patch we've been using internally,
which deletes quite a lot of the old code; but you'll quickly notice
has a "Revisit later" hack in find_get_entries(), which I've not got
around to revisiting yet.  Please blend what you can from my patch
into yours, or vice versa.

Hugh

---

 mm/filemap.c |    3 +
 mm/shmem.c   |   86 +++++++++++++++++--------------------------------
 2 files changed, 34 insertions(+), 55 deletions(-)

--- v5.4/mm/filemap.c=092019-11-24 16:32:01.000000000 -0800
+++ linux/mm/filemap.c=092019-11-27 16:21:16.316801433 -0800
@@ -1752,6 +1752,9 @@ unsigned find_get_entries(struct address
 =09=09=09goto put_page;
 =09=09page =3D find_subpage(page, xas.xa_index);
=20
+=09=09/* Revisit later: make shmem_undo_range() easier for now */
+=09=09if (PageTransCompound(page))
+=09=09=09nr_entries =3D ret + 1;
 export:
 =09=09indices[ret] =3D xas.xa_index;
 =09=09entries[ret] =3D page;
--- v5.4/mm/shmem.c=092019-11-24 16:32:01.000000000 -0800
+++ linux/mm/shmem.c=092019-11-27 16:21:16.320801450 -0800
@@ -788,6 +788,20 @@ void shmem_unlock_mapping(struct address
 =09}
 }
=20
+static bool shmem_punch_compound(struct page *page, pgoff_t start, pgoff_t=
 end)
+{
+=09if (!PageTransCompound(page))
+=09=09return true;
+
+=09/* Just proceed to delete a huge page wholly within the range punched *=
/
+=09if (PageHead(page) &&
+=09    page->index >=3D start && page->index + HPAGE_PMD_NR <=3D end)
+=09=09return true;
+
+=09/* Try to split huge page, so we can truly punch the hole or truncate *=
/
+=09return split_huge_page(page) >=3D 0;
+}
+
 /*
  * Remove range of pages and swap entries from page cache, and free them.
  * If !unfalloc, truncate or punch hole; if unfalloc, undo failed fallocat=
e.
@@ -838,31 +852,11 @@ static void shmem_undo_range(struct inod
 =09=09=09if (!trylock_page(page))
 =09=09=09=09continue;
=20
-=09=09=09if (PageTransTail(page)) {
-=09=09=09=09/* Middle of THP: zero out the page */
-=09=09=09=09clear_highpage(page);
-=09=09=09=09unlock_page(page);
-=09=09=09=09continue;
-=09=09=09} else if (PageTransHuge(page)) {
-=09=09=09=09if (index =3D=3D round_down(end, HPAGE_PMD_NR)) {
-=09=09=09=09=09/*
-=09=09=09=09=09 * Range ends in the middle of THP:
-=09=09=09=09=09 * zero out the page
-=09=09=09=09=09 */
-=09=09=09=09=09clear_highpage(page);
-=09=09=09=09=09unlock_page(page);
-=09=09=09=09=09continue;
-=09=09=09=09}
-=09=09=09=09index +=3D HPAGE_PMD_NR - 1;
-=09=09=09=09i +=3D HPAGE_PMD_NR - 1;
-=09=09=09}
-
-=09=09=09if (!unfalloc || !PageUptodate(page)) {
-=09=09=09=09VM_BUG_ON_PAGE(PageTail(page), page);
-=09=09=09=09if (page_mapping(page) =3D=3D mapping) {
-=09=09=09=09=09VM_BUG_ON_PAGE(PageWriteback(page), page);
+=09=09=09if ((!unfalloc || !PageUptodate(page)) &&
+=09=09=09    page_mapping(page) =3D=3D mapping) {
+=09=09=09=09VM_BUG_ON_PAGE(PageWriteback(page), page);
+=09=09=09=09if (shmem_punch_compound(page, start, end))
 =09=09=09=09=09truncate_inode_page(mapping, page);
-=09=09=09=09}
 =09=09=09}
 =09=09=09unlock_page(page);
 =09=09}
@@ -936,43 +930,25 @@ static void shmem_undo_range(struct inod
=20
 =09=09=09lock_page(page);
=20
-=09=09=09if (PageTransTail(page)) {
-=09=09=09=09/* Middle of THP: zero out the page */
-=09=09=09=09clear_highpage(page);
-=09=09=09=09unlock_page(page);
-=09=09=09=09/*
-=09=09=09=09 * Partial thp truncate due 'start' in middle
-=09=09=09=09 * of THP: don't need to look on these pages
-=09=09=09=09 * again on !pvec.nr restart.
-=09=09=09=09 */
-=09=09=09=09if (index !=3D round_down(end, HPAGE_PMD_NR))
-=09=09=09=09=09start++;
-=09=09=09=09continue;
-=09=09=09} else if (PageTransHuge(page)) {
-=09=09=09=09if (index =3D=3D round_down(end, HPAGE_PMD_NR)) {
-=09=09=09=09=09/*
-=09=09=09=09=09 * Range ends in the middle of THP:
-=09=09=09=09=09 * zero out the page
-=09=09=09=09=09 */
-=09=09=09=09=09clear_highpage(page);
-=09=09=09=09=09unlock_page(page);
-=09=09=09=09=09continue;
-=09=09=09=09}
-=09=09=09=09index +=3D HPAGE_PMD_NR - 1;
-=09=09=09=09i +=3D HPAGE_PMD_NR - 1;
-=09=09=09}
-
 =09=09=09if (!unfalloc || !PageUptodate(page)) {
-=09=09=09=09VM_BUG_ON_PAGE(PageTail(page), page);
-=09=09=09=09if (page_mapping(page) =3D=3D mapping) {
-=09=09=09=09=09VM_BUG_ON_PAGE(PageWriteback(page), page);
-=09=09=09=09=09truncate_inode_page(mapping, page);
-=09=09=09=09} else {
+=09=09=09=09if (page_mapping(page) !=3D mapping) {
 =09=09=09=09=09/* Page was replaced by swap: retry */
 =09=09=09=09=09unlock_page(page);
 =09=09=09=09=09index--;
 =09=09=09=09=09break;
 =09=09=09=09}
+=09=09=09=09VM_BUG_ON_PAGE(PageWriteback(page), page);
+=09=09=09=09if (shmem_punch_compound(page, start, end))
+=09=09=09=09=09truncate_inode_page(mapping, page);
+=09=09=09=09else {
+=09=09=09=09=09/* Wipe the page and don't get stuck */
+=09=09=09=09=09clear_highpage(page);
+=09=09=09=09=09flush_dcache_page(page);
+=09=09=09=09=09set_page_dirty(page);
+=09=09=09=09=09if (index <
+=09=09=09=09=09    round_up(start, HPAGE_PMD_NR))
+=09=09=09=09=09=09start =3D index + 1;
+=09=09=09=09}
 =09=09=09}
 =09=09=09unlock_page(page);
 =09=09}
--0-183993477-1574910373=:652--
