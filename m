Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4FB511859B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2019 11:53:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbfLJKx5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Dec 2019 05:53:57 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58673 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726574AbfLJKxz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Dec 2019 05:53:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575975234;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=ocGRK8h1NQXFNyCMiAAP4zFHg5s4LXaOutodSTptU/Q=;
        b=KOQC3kLeLiKKWPpgtfNkUA/akKsrEVSLF71UVUC1X1QGvX/VGaD70p8I2vYJSIeWVlLzN7
        y8kr5jrymezrGPRf+7z2zaFCVv+ab4qfAkopFFSy9WH2vpokj2UwdwmnUR8xky7BVMVKpl
        uwP/4FDNhpbcd4VLmAbWYPSokgA2tB0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-15-iR-WknWROmib5kX_WZIkhQ-1; Tue, 10 Dec 2019 05:53:50 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E00441856A6A;
        Tue, 10 Dec 2019 10:53:47 +0000 (UTC)
Received: from [10.36.117.222] (ovpn-117-222.ams2.redhat.com [10.36.117.222])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 11AAF60BF3;
        Tue, 10 Dec 2019 10:53:44 +0000 (UTC)
Subject: Re: [PATCH v1 2/3] fs/proc/page.c: allow inspection of last section
 and fix end detection
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-fsdevel@vger.kernel.org
References: <20191209174836.11063-3-david@redhat.com>
 <201912100809.P9SHh5Nz%lkp@intel.com>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
Organization: Red Hat GmbH
Message-ID: <bc3eedd4-77bc-4168-2a59-6ea5a67ba53e@redhat.com>
Date:   Tue, 10 Dec 2019 11:53:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <201912100809.P9SHh5Nz%lkp@intel.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: iR-WknWROmib5kX_WZIkhQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10.12.19 02:04, kbuild test robot wrote:
> Hi David,
>=20
> I love your patch! Yet something to improve:
>=20
> [auto build test ERROR on linus/master]
> [also build test ERROR on linux/master v5.5-rc1 next-20191209]
> [cannot apply to mmotm/master]
> [if your patch is applied to the wrong git tree, please drop us a note to=
 help
> improve the system. BTW, we also suggest to use '--base' option to specif=
y the
> base tree in git format-patch, please see https://stackoverflow.com/a/374=
06982]
>=20
> url:    https://github.com/0day-ci/linux/commits/David-Hildenbrand/mm-fix=
-max_pfn-not-falling-on-section-boundary/20191210-071011
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t 6794862a16ef41f753abd75c03a152836e4c8028
> config: i386-defconfig (attached as .config)
> compiler: gcc-7 (Debian 7.5.0-1) 7.5.0
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=3Di386=20
>=20
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
>=20
> All errors (new ones prefixed by >>):
>=20
>    In file included from include/asm-generic/bug.h:19:0,
>                     from arch/x86/include/asm/bug.h:83,
>                     from include/linux/bug.h:5,
>                     from include/linux/mmdebug.h:5,
>                     from include/linux/mm.h:9,
>                     from include/linux/memblock.h:13,
>                     from fs/proc/page.c:2:
>    fs/proc/page.c: In function 'kpagecount_read':
>>> fs/proc/page.c:32:55: error: 'PAGES_PER_SECTION' undeclared (first use =
in this function); did you mean 'PAGE_KERNEL_IO'?
>      const unsigned long max_dump_pfn =3D round_up(max_pfn, PAGES_PER_SEC=
TION);
>                                                           ^
>    include/linux/kernel.h:62:46: note: in definition of macro '__round_ma=
sk'
>     #define __round_mask(x, y) ((__typeof__(x))((y)-1))
>                                                  ^
>    fs/proc/page.c:32:37: note: in expansion of macro 'round_up'
>      const unsigned long max_dump_pfn =3D round_up(max_pfn, PAGES_PER_SEC=
TION);
>                                         ^~~~~~~~
>    fs/proc/page.c:32:55: note: each undeclared identifier is reported onl=
y once for each function it appears in
>      const unsigned long max_dump_pfn =3D round_up(max_pfn, PAGES_PER_SEC=
TION);
>                                                           ^
>    include/linux/kernel.h:62:46: note: in definition of macro '__round_ma=
sk'
>     #define __round_mask(x, y) ((__typeof__(x))((y)-1))
>                                                  ^
>    fs/proc/page.c:32:37: note: in expansion of macro 'round_up'
>      const unsigned long max_dump_pfn =3D round_up(max_pfn, PAGES_PER_SEC=
TION);
>                                         ^~~~~~~~
>    fs/proc/page.c: In function 'kpageflags_read':
>    fs/proc/page.c:212:55: error: 'PAGES_PER_SECTION' undeclared (first us=
e in this function); did you mean 'PAGE_KERNEL_IO'?
>      const unsigned long max_dump_pfn =3D round_up(max_pfn, PAGES_PER_SEC=
TION);
>                                                           ^
>    include/linux/kernel.h:62:46: note: in definition of macro '__round_ma=
sk'
>     #define __round_mask(x, y) ((__typeof__(x))((y)-1))
>                                                  ^
>    fs/proc/page.c:212:37: note: in expansion of macro 'round_up'
>      const unsigned long max_dump_pfn =3D round_up(max_pfn, PAGES_PER_SEC=
TION);
>                                         ^~~~~~~~
>=20

So PAGES_PER_SECTION only applies to CONFIG_SPARSEMEM. Some local function
that messes with that should do the trick. Allows us to add a comment as
well :)

diff --git a/fs/proc/page.c b/fs/proc/page.c                               =
                                                                           =
                                                                           =
           =20
index e40dbfe1168e..2984df28ccea 100644                                    =
                                                                           =
                                                                           =
           =20
--- a/fs/proc/page.c                                                       =
                                                                           =
                                                 =20
+++ b/fs/proc/page.c                                                       =
                                                                           =
                                                 =20
@@ -21,6 +21,21 @@                                                         =
                                                                           =
                                         =20
 #define KPMMASK (KPMSIZE - 1)                                             =
                                                                           =
                                                                           =
           =20
 #define KPMBITS (KPMSIZE * BITS_PER_BYTE)                                 =
                                                                           =
                                                                           =
           =20
                                                                           =
                                                =20
+static inline unsigned long get_max_dump_pfn(void)                        =
                                                                           =
                                                                           =
           =20
+{                                                                         =
                                                    =20
+#ifdef CONFIG_SPARSEMEM                                                   =
                                                                           =
                                                                 =20
+       /*                                                                 =
                                                                           =
         =20
+        * The memmap of early sections is completely populated and marked =
                                                                           =
                                                                           =
           =20
+        * online even if max_pfn does not fall on a section boundary -    =
                                                                           =
                                                                           =
           =20
+        * pfn_to_online_page() will succeed on all pages. Allow inspecting=
                                                                           =
                                                                           =
           =20
+        * these memmaps.                                                  =
                                                                           =
                                                                     =20
+        */                                                                =
                                                                           =
             =20
+       return round_up(max_pfn, PAGES_PER_SECTION);                       =
                                                                           =
                                                                           =
           =20
+#else                                                                     =
                                                                    =20
+       return max_pfn;                                                    =
                                                                           =
                                                             =20
+#endif                                                                    =
                                                                        =20
+}                                                                         =
                                                    =20
+                                                                          =
                                                =20
 /* /proc/kpagecount - an array exposing page counts                       =
                                                                           =
                                                                           =
           =20
  *                                                                        =
                                                        =20
  * Each entry is a u64 representing the corresponding                     =
                                                                           =
                                                                           =
           =20
@@ -29,6 +44,7 @@                                                          =
                                                                           =
                                     =20
 static ssize_t kpagecount_read(struct file *file, char __user *buf,       =
                                                                           =
                                                                           =
           =20
                             size_t count, loff_t *ppos)                   =
                                                                           =
                                                                           =
           =20
 {                                                                         =
                                                    =20
+       const unsigned long max_dump_pfn =3D get_max_dump_pfn();
        u64 __user *out =3D (u64 __user *)buf;
        struct page *ppage;
        unsigned long src =3D *ppos;
@@ -37,9 +53,11 @@ static ssize_t kpagecount_read(struct file *file, char _=
_user *buf,
        u64 pcount;
=20
        pfn =3D src / KPMSIZE;
-       count =3D min_t(size_t, count, (max_pfn * KPMSIZE) - src);
        if (src & KPMMASK || count & KPMMASK)
                return -EINVAL;
+       if (src >=3D max_dump_pfn * KPMSIZE)
+               return 0;
+       count =3D min_t(unsigned long, count, (max_dump_pfn * KPMSIZE) - sr=
c);
=20
        while (count > 0) {
                /*
@@ -208,6 +226,7 @@ u64 stable_page_flags(struct page *page)
 static ssize_t kpageflags_read(struct file *file, char __user *buf,
                             size_t count, loff_t *ppos)
 {
+       const unsigned long max_dump_pfn =3D get_max_dump_pfn();
        u64 __user *out =3D (u64 __user *)buf;
        struct page *ppage;
        unsigned long src =3D *ppos;
@@ -215,9 +234,11 @@ static ssize_t kpageflags_read(struct file *file, char=
 __user *buf,
        ssize_t ret =3D 0;
=20
        pfn =3D src / KPMSIZE;
-       count =3D min_t(unsigned long, count, (max_pfn * KPMSIZE) - src);
        if (src & KPMMASK || count & KPMMASK)
                return -EINVAL;
+       if (src >=3D max_dump_pfn * KPMSIZE)
+               return 0;
+       count =3D min_t(unsigned long, count, (max_dump_pfn * KPMSIZE) - sr=
c);
=20
        while (count > 0) {
                /*
@@ -253,6 +274,7 @@ static const struct file_operations proc_kpageflags_ope=
rations =3D {
 static ssize_t kpagecgroup_read(struct file *file, char __user *buf,
                                size_t count, loff_t *ppos)
 {
+       const unsigned long max_dump_pfn =3D get_max_dump_pfn();
        u64 __user *out =3D (u64 __user *)buf;
        struct page *ppage;
        unsigned long src =3D *ppos;
@@ -261,9 +283,11 @@ static ssize_t kpagecgroup_read(struct file *file, cha=
r __user *buf,
        u64 ino;
=20
        pfn =3D src / KPMSIZE;
-       count =3D min_t(unsigned long, count, (max_pfn * KPMSIZE) - src);
        if (src & KPMMASK || count & KPMMASK)
                return -EINVAL;
+       if (src >=3D max_dump_pfn * KPMSIZE)
+               return 0;
+       count =3D min_t(unsigned long, count, (max_dump_pfn * KPMSIZE) - sr=
c);
=20
        while (count > 0) {
                /*
--=20
2.21.0


--=20
Thanks,

David / dhildenb

