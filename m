Return-Path: <linux-fsdevel+bounces-9051-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A211783D7CB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 11:20:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35118298FEF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 10:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A719C4595E;
	Fri, 26 Jan 2024 09:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SIlzS1bh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30551B7F4;
	Fri, 26 Jan 2024 09:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706262590; cv=none; b=H7y7GSIPaS5LIsFHC7S2jS5H87J5UpLx896jQfGeR95oumyZ0P/fptdnzC87VstYrBWi0Fkz9GuphXqH/LxBm2NIkihushachtBSF1tMLKPgAl/SkALuhJzoRckcrBBhkGD4+Oyk755TNR/yd7uWYxNoHj58C72pPgiDQVStj6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706262590; c=relaxed/simple;
	bh=PPgG7drf9kCNNzh1htJ4AGBB18N7yncIxcDSWFLL728=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SMbj27kDJcN/bWo34ljL3d3QPerEahS8ZbJiidq8gqMgdf13KPRA+PFIvIjk84MP5PoDbMQx6sfSH1QtaSKSmcqf0q8xlujsSKobLh/COMbqwHbNcSkXTg2L3bOneFqFJC5wbsa9LZQUj3ScW82mWbFSwwsWxco1PKzQ3upP2CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SIlzS1bh; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5100fd7f71dso920621e87.1;
        Fri, 26 Jan 2024 01:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706262586; x=1706867386; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ptFTQQXSz+aL0eaWKXOJXvJWajvtj/+L68MiyW1Ryc4=;
        b=SIlzS1bh6xNhl4CZTu0DCNxZdvUroyYXxgtnOpTJDtsWMR5MrZ4z1ShjoclTto/+yq
         J9frYa6KTdmlrDBGzysPiuEKS1/+Ve6sJGnjR0t56wR261DO+HeBpGvMEVxbQF9oIfrM
         UuHcl1x3PHjW/g4zoomtfqmkgRCRHZdfi2jVzXss0X5t8SH/g0o6ogs+pv01dts44oiR
         bhuJT3kK5yUsnfBZ0IL4MCFwv6phLEiGv8jFihj8iSXUEIftdzqDVLpyfajNsiHOme60
         vclRDGWdU9Miq3eDKCiQBzHoRkIbsUfc4xBL7femSdYgAcgxC63ypVGumwSGhDVu7S/k
         hYWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706262586; x=1706867386;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ptFTQQXSz+aL0eaWKXOJXvJWajvtj/+L68MiyW1Ryc4=;
        b=kfD1cGw5pN5jid2G2UeszNlKgJyKoSLrl2m8493lrsY9H7mjrx80q19iAS3JmYOTx6
         VGWMNOuO/+PDXlMLsuYtDlgLMEOsryt431CassJc20J63tmnLy76zV5YDYI1NQmb45YL
         4gRMDkqPekQW47RrZBbYUobsWjMqt0BQFdtK1YIkk9PSLFtWiW0HYFWeNg2hA5cEy73U
         ChdY3E6EKUly63lfeM4fvOx9OiIG0KRkzbsX0od3U49bl51+r14mgLRimUdypWRoFl9J
         6I4e1HOwbMIjnbUaivKLk0o8+JMB56Y/jdxLPBQrQSQnZsZbHMEJxzC44ECfu7z/12zU
         UKyg==
X-Gm-Message-State: AOJu0YxJFGILEs1o9o1/5vm5cGsQHRMPNxHFBLMjJ+v77fzwwom1hTYX
	Sx8OorJ9c8/9Bppp9yqUFMaW5o/Y2rsBzMbTfSs6Jj0znDDQMpb7MCq10Xhx+6Yg2IfUvbsp1jK
	/yU/u94mlnC+AyL8uIsSHNcCX6so=
X-Google-Smtp-Source: AGHT+IEdQhrVqmM6vTIx80vQbNKtGUOsr4W2pIZnL2O1JX8ZzISg+Z4bWrn7fiFxFoLyYNcSEqwGCFDCzWyrrQn/OSQ=
X-Received: by 2002:ac2:51a5:0:b0:50e:71d4:a37f with SMTP id
 f5-20020ac251a5000000b0050e71d4a37fmr594147lfk.55.1706262585552; Fri, 26 Jan
 2024 01:49:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240125071901.3223188-1-zhaoyang.huang@unisoc.com>
 <CAGWkznGpW=bUxET8yZGu4dNTBfsj7n79yXsTD23fE5-SWkdjfA@mail.gmail.com>
 <ZbNziLeet7TbDKEl@casper.infradead.org> <CAGWkznGG1xLcPMsWbbXqO5iUWqC2UmyWwcJaFd4WBQ-aFE=-jA@mail.gmail.com>
 <ZbN9JDE50Th-dT3Y@casper.infradead.org>
In-Reply-To: <ZbN9JDE50Th-dT3Y@casper.infradead.org>
From: Zhaoyang Huang <huangzhaoyang@gmail.com>
Date: Fri, 26 Jan 2024 17:49:34 +0800
Message-ID: <CAGWkznGW+W+x0JCAmJJBYznSAWqnYDPTpe_p=8ubFx8C+V9oNQ@mail.gmail.com>
Subject: Re: [PATCHv3 1/1] block: introduce content activity based ioprio
To: Matthew Wilcox <willy@infradead.org>
Cc: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>, Yu Zhao <yuzhao@google.com>, 
	Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <niklas.cassel@wdc.com>, 
	"Martin K . Petersen" <martin.petersen@oracle.com>, Hannes Reinecke <hare@suse.de>, 
	Linus Walleij <linus.walleij@linaro.org>, linux-mm@kvack.org, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, steve.kang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 26, 2024 at 5:36=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Fri, Jan 26, 2024 at 05:28:58PM +0800, Zhaoyang Huang wrote:
> > On Fri, Jan 26, 2024 at 4:55=E2=80=AFPM Matthew Wilcox <willy@infradead=
.org> wrote:
> > >
> > > On Fri, Jan 26, 2024 at 03:59:48PM +0800, Zhaoyang Huang wrote:
> > > > loop more mm and fs guys for more comments
> > >
> > > I agree with everything Damien said.  But also ...
> > ok, I will find a way to solve this problem.
> > >
> > > > > +bool BIO_ADD_FOLIO(struct bio *bio, struct folio *folio, size_t =
len,
> > > > > +               size_t off)
> > >
> > > You don't add any users of these functions.  It's hard to assess whet=
her
> > > this is the right API when there are no example users.
> > Actually, the code has been tested on ext4 and f2fs by patchv2 on a
> > v6.6 6GB android system where I get the test result posted on the
> > commit message. These APIs is to keep block layer clean and wrap
> > things up for fs.
>
> well, where's patch v2?  i don't see it in my inbox.  i'm not going
> to go hunting around the email lists for it.  this is not good enough.
>
> > > why are BIO_ADD_PAGE and BIO_ADD_FOLIO so very different from each
> > > other?
> > These two API just repeat the same thing that bio_add_page and
> > bio_add_folio do.
>
> what?
>
> here's the patch you sent.  these two functions do wildly different
> things:
>
> +bool BIO_ADD_FOLIO(struct bio *bio, struct folio *folio, size_t len,
> +               size_t off)
> +{
> +       int class, level, hint, activity;
> +
> +       if (len > UINT_MAX || off > UINT_MAX)
> +               return false;
> +
> +       class =3D IOPRIO_PRIO_CLASS(bio->bi_ioprio);
> +       level =3D IOPRIO_PRIO_LEVEL(bio->bi_ioprio);
> +       hint =3D IOPRIO_PRIO_HINT(bio->bi_ioprio);
> +       activity =3D IOPRIO_PRIO_ACTIVITY(bio->bi_ioprio);
> +
> +       activity +=3D (bio->bi_vcnt + 1 <=3D IOPRIO_NR_ACTIVITY &&
> +                       PageWorkingset(&folio->page)) ? 1 : 0;
> +       if (activity >=3D bio->bi_vcnt / 2)
> +               class =3D IOPRIO_CLASS_RT;
> +       else if (activity >=3D bio->bi_vcnt / 4)
> +               class =3D max(IOPRIO_PRIO_CLASS(get_current_ioprio()), IO=
PRIO_CLASS_BE);
> +
> +       bio->bi_ioprio =3D IOPRIO_PRIO_VALUE_ACTIVITY(class, level, hint,=
 activity);
> +
> +       return bio_add_page(bio, &folio->page, len, off) > 0;
> +}
> +
> +int BIO_ADD_PAGE(struct bio *bio, struct page *page,
> +               unsigned int len, unsigned int offset)
> +{
> +       int class, level, hint, activity;
> +
> +       if (bio_add_page(bio, page, len, offset) > 0) {
> +               class =3D IOPRIO_PRIO_CLASS(bio->bi_ioprio);
> +               level =3D IOPRIO_PRIO_LEVEL(bio->bi_ioprio);
> +               hint =3D IOPRIO_PRIO_HINT(bio->bi_ioprio);
> +               activity =3D IOPRIO_PRIO_ACTIVITY(bio->bi_ioprio);
> +               activity +=3D (bio->bi_vcnt <=3D IOPRIO_NR_ACTIVITY && Pa=
geWorkingset(page)) ? 1 : 0;
> +               bio->bi_ioprio =3D IOPRIO_PRIO_VALUE_ACTIVITY(class, leve=
l, hint, activity);
> +       }
> +
> +       return len;
> +}
>
> did you change one and forget to change the other?
Sorry for missing you in the list. Please find below patchv2 where all
activity calculation is located within _bio_add_page which aims at
avoiding iterating the bio->bvec before submit_bio. This is rejected
by Jens as it introduces page operation in the block layer.

block/Kconfig               |  8 ++++++++
 block/bio.c                 | 10 ++++++++++
 block/blk-mq.c              | 21 +++++++++++++++++++++
 fs/buffer.c                 |  6 ++++++
 include/linux/buffer_head.h |  1 +
 include/uapi/linux/ioprio.h | 20 +++++++++++++++-----
 6 files changed, 61 insertions(+), 5 deletions(-)

diff --git a/block/Kconfig b/block/Kconfig
index f1364d1c0d93..8d6075575eae 100644
--- a/block/Kconfig
+++ b/block/Kconfig
@@ -228,6 +228,14 @@ config BLOCK_HOLDER_DEPRECATED
 config BLK_MQ_STACKING
        bool

+config CONTENT_ACT_BASED_IOPRIO
+       bool "Enable content activity based ioprio"
+       depends on LRU_GEN
+       default y
+       help
+       This item enable the feature of adjust bio's priority by
+       calculating its content's activity.
+
 source "block/Kconfig.iosched"

 endif # BLOCK
diff --git a/block/bio.c b/block/bio.c
index 816d412c06e9..1228e2a4940f 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -24,6 +24,7 @@
 #include "blk.h"
 #include "blk-rq-qos.h"
 #include "blk-cgroup.h"
+#include "blk-ioprio.h"

 #define ALLOC_CACHE_THRESHOLD  16
 #define ALLOC_CACHE_MAX                256
@@ -1069,12 +1070,21 @@ EXPORT_SYMBOL_GPL(bio_add_zone_append_page);
 void __bio_add_page(struct bio *bio, struct page *page,
                unsigned int len, unsigned int off)
 {
+       int class, level, hint, activity;
+
+       class =3D IOPRIO_PRIO_CLASS(bio->bi_ioprio);
+       level =3D IOPRIO_PRIO_LEVEL(bio->bi_ioprio);
+       hint =3D IOPRIO_PRIO_HINT(bio->bi_ioprio);
+       activity =3D IOPRIO_PRIO_ACTIVITY(bio->bi_ioprio);
+
        WARN_ON_ONCE(bio_flagged(bio, BIO_CLONED));
        WARN_ON_ONCE(bio_full(bio, len));

        bvec_set_page(&bio->bi_io_vec[bio->bi_vcnt], page, len, off);
        bio->bi_iter.bi_size +=3D len;
        bio->bi_vcnt++;
+       activity +=3D bio_page_if_active(bio, page, IOPRIO_NR_ACTIVITY);
+       bio->bi_ioprio =3D IOPRIO_PRIO_VALUE_ACTIVITY(class, level,
hint, activity);
 }
 EXPORT_SYMBOL_GPL(__bio_add_page);

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 1fafd54dce3c..05cdd3adde94 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2939,6 +2939,26 @@ static inline struct request
*blk_mq_get_cached_request(struct request_queue *q,
        return rq;
 }

+#ifdef CONFIG_CONTENT_ACT_BASED_IOPRIO
+static void bio_set_ioprio(struct bio *bio)
+{
+       int class, level, hint, activity;
+
+       class =3D IOPRIO_PRIO_CLASS(bio->bi_ioprio);
+       level =3D IOPRIO_PRIO_LEVEL(bio->bi_ioprio);
+       hint =3D IOPRIO_PRIO_HINT(bio->bi_ioprio);
+       activity =3D IOPRIO_PRIO_ACTIVITY(bio->bi_ioprio);
+
+       if (activity >=3D bio->bi_vcnt / 2)
+               class =3D IOPRIO_CLASS_RT;
+       else if (activity >=3D bio->bi_vcnt / 4)
+               class =3D max(IOPRIO_PRIO_CLASS(get_current_ioprio()),
IOPRIO_CLASS_BE);
+
+       bio->bi_ioprio =3D IOPRIO_PRIO_VALUE_ACTIVITY(class, level,
hint, activity);
+
+       blkcg_set_ioprio(bio);
+}
+#else
 static void bio_set_ioprio(struct bio *bio)
 {
        /* Nobody set ioprio so far? Initialize it based on task's nice val=
ue */
@@ -2946,6 +2966,7 @@ static void bio_set_ioprio(struct bio *bio)
                bio->bi_ioprio =3D get_current_ioprio();
        blkcg_set_ioprio(bio);
 }
+#endif

 /**
  * blk_mq_submit_bio - Create and send a request to block device.
diff --git a/fs/buffer.c b/fs/buffer.c
index 12e9a71c693d..b15bff481706 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2832,6 +2832,12 @@ void submit_bh(blk_opf_t opf, struct buffer_head *bh=
)
 }
 EXPORT_SYMBOL(submit_bh);

+int bio_page_if_active(struct bio *bio, struct page *page, unsigned
short limit)
+{
+       return (bio->bi_vcnt <=3D limit && PageWorkingset(page)) ? 1 : 0;
+}
+EXPORT_SYMBOL(bio_page_if_active);
+
 void write_dirty_buffer(struct buffer_head *bh, blk_opf_t op_flags)
 {
        lock_buffer(bh);
diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index 44e9de51eedf..9a374f5965ec 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -248,6 +248,7 @@ int bh_uptodate_or_lock(struct buffer_head *bh);
 int __bh_read(struct buffer_head *bh, blk_opf_t op_flags, bool wait);
 void __bh_read_batch(int nr, struct buffer_head *bhs[],
                     blk_opf_t op_flags, bool force_lock);
+int bio_page_if_active(struct bio *bio, struct page *page, unsigned
short limit);

 /*
  * Generic address_space_operations implementations for buffer_head-backed
diff --git a/include/uapi/linux/ioprio.h b/include/uapi/linux/ioprio.h
index bee2bdb0eedb..d1c6081e796b 100644
--- a/include/uapi/linux/ioprio.h
+++ b/include/uapi/linux/ioprio.h
@@ -71,12 +71,18 @@ enum {
  * class and level.
  */
 #define IOPRIO_HINT_SHIFT              IOPRIO_LEVEL_NR_BITS
-#define IOPRIO_HINT_NR_BITS            10
+#define IOPRIO_HINT_NR_BITS            3
 #define IOPRIO_NR_HINTS                        (1 << IOPRIO_HINT_NR_BITS)
 #define IOPRIO_HINT_MASK               (IOPRIO_NR_HINTS - 1)
 #define IOPRIO_PRIO_HINT(ioprio)       \
        (((ioprio) >> IOPRIO_HINT_SHIFT) & IOPRIO_HINT_MASK)

+#define IOPRIO_ACTIVITY_SHIFT          (IOPRIO_HINT_NR_BITS +
IOPRIO_LEVEL_NR_BITS)
+#define IOPRIO_ACTIVITY_NR_BITS                7
+#define IOPRIO_NR_ACTIVITY             (1 << IOPRIO_ACTIVITY_NR_BITS)
+#define IOPRIO_ACTIVITY_MASK           (IOPRIO_NR_ACTIVITY - 1)
+#define IOPRIO_PRIO_ACTIVITY(ioprio)   \
+       (((ioprio) >> IOPRIO_ACTIVITY_SHIFT) & IOPRIO_ACTIVITY_MASK)
 /*
  * I/O hints.
  */
@@ -108,20 +114,24 @@ enum {
  * Return an I/O priority value based on a class, a level and a hint.
  */
 static __always_inline __u16 ioprio_value(int prioclass, int priolevel,
-                                         int priohint)
+                                         int priohint, int activity)
 {
        if (IOPRIO_BAD_VALUE(prioclass, IOPRIO_NR_CLASSES) ||
            IOPRIO_BAD_VALUE(priolevel, IOPRIO_NR_LEVELS) ||
-           IOPRIO_BAD_VALUE(priohint, IOPRIO_NR_HINTS))
+           IOPRIO_BAD_VALUE(priohint, IOPRIO_NR_HINTS) ||
+           IOPRIO_BAD_VALUE(activity, IOPRIO_NR_ACTIVITY))
                return IOPRIO_CLASS_INVALID << IOPRIO_CLASS_SHIFT;

        return (prioclass << IOPRIO_CLASS_SHIFT) |
+               (activity << IOPRIO_ACTIVITY_SHIFT) |
                (priohint << IOPRIO_HINT_SHIFT) | priolevel;
 }

 #define IOPRIO_PRIO_VALUE(prioclass, priolevel)                        \
-       ioprio_value(prioclass, priolevel, IOPRIO_HINT_NONE)
+       ioprio_value(prioclass, priolevel, IOPRIO_HINT_NONE, 0)
 #define IOPRIO_PRIO_VALUE_HINT(prioclass, priolevel, priohint) \
-       ioprio_value(prioclass, priolevel, priohint)
+       ioprio_value(prioclass, priolevel, priohint, 0)
+#define IOPRIO_PRIO_VALUE_ACTIVITY(prioclass, priolevel, priohint,
activity)   \
+       ioprio_value(prioclass, priolevel, priohint, activity)

 #endif /* _UAPI_LINUX_IOPRIO_H */


>
> > These white spaces are trimmed by vim, I will change them back in next =
version.
>
> vim doesn't do that by default.
>

