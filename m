Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC33930739D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jan 2021 11:23:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232256AbhA1KWq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Jan 2021 05:22:46 -0500
Received: from mail-ot1-f44.google.com ([209.85.210.44]:46845 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232167AbhA1KWa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Jan 2021 05:22:30 -0500
Received: by mail-ot1-f44.google.com with SMTP id d1so4656563otl.13;
        Thu, 28 Jan 2021 02:22:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HDfQ7EgSz4He6IVrUzqy89nGy356H19n/4Ap6Knawyw=;
        b=ap5O9cqTcOiSHFhFdbRrv53BN6XowdeTuBT1GP9VPeY+ZNabvIwActdIi7PQ47tvbV
         /YDmcZ+nY6gZKcmfEaLUvP6zF6DoF1yYK3FCj3QG/gKoALMMKIy966Veb/uk7vYW16fe
         A5piiN825Sk5u/MZFMC+Q9bVHmuGzttXQUFPZPzhWtx6wXVGJJeeIXY8y3/pdvX4ASAC
         lFXndUvDktmKSbPDzPVRRCO6XTv9Ru1uvOG1CM3k7qDJSNoXw30rxMqWmpPywwOSDUMA
         Oer+6NQ9jcBMfpHHEuzTOSlweRtKkArqFojZ1wjhJUdrcBNk8C6H/obzrnzVdQ3/xqrM
         GGyw==
X-Gm-Message-State: AOAM532mflGamN0r49fluHL4KmEJBqCZzAZg4X2HpYsQuGNmRcMFBLrj
        OfxVkla/cS6HJNSzKNMFeC7s4Ouy8mfgNCp43XNiwJSLdck=
X-Google-Smtp-Source: ABdhPJwJviHVEMHN6dwg9pHl9sFzPeOTWi/Tyw7MUMRzUkqGbWVHXybuLc31QSYFbmu849bxozre+7WWIBRJddZRpNc=
X-Received: by 2002:a05:6830:2313:: with SMTP id u19mr11117098ote.321.1611829309173;
 Thu, 28 Jan 2021 02:21:49 -0800 (PST)
MIME-Version: 1.0
References: <20210128071133.60335-1-chaitanya.kulkarni@wdc.com> <20210128071133.60335-30-chaitanya.kulkarni@wdc.com>
In-Reply-To: <20210128071133.60335-30-chaitanya.kulkarni@wdc.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 28 Jan 2021 11:21:36 +0100
Message-ID: <CAJZ5v0h01e4LgV0c5FxLorcc6iFW2LVzC=hJcd7LNAJ6D0E8jg@mail.gmail.com>
Subject: Re: [RFC PATCH 29/34] power/swap: use bio_new in hib_submit_io
To:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        drbd-dev@lists.linbit.com, xen-devel@lists.xenproject.org,
        linux-nvme <linux-nvme@lists.infradead.org>,
        "open list:TARGET SUBSYSTEM" <linux-scsi@vger.kernel.org>,
        target-devel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        jfs-discussion@lists.sourceforge.net, linux-nilfs@vger.kernel.org,
        ocfs2-devel@oss.oracle.com, Linux PM <linux-pm@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Jens Axboe <axboe@kernel.dk>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        roger.pau@citrix.com, Minchan Kim <minchan@kernel.org>,
        ngupta@vflare.org,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Al Viro <viro@zeniv.linux.org.uk>, "Ted Ts'o" <tytso@mit.edu>,
        jaegeuk@kernel.org, Eric Biggers <ebiggers@kernel.org>,
        djwong@kernel.org, shaggy@kernel.org, konishi.ryusuke@gmail.com,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>, damien.lemoal@wdc.com,
        naohiro.aota@wdc.com, jth@kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hannes Reinecke <hare@suse.de>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Takashi Iwai <tiwai@suse.de>,
        Alex Shi <alex.shi@linux.alibaba.com>, asml.silence@gmail.com,
        Ming Lei <ming.lei@redhat.com>, Tejun Heo <tj@kernel.org>,
        osandov@fb.com, Bart Van Assche <bvanassche@acm.org>,
        jefflexu@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 28, 2021 at 8:21 AM Chaitanya Kulkarni
<chaitanya.kulkarni@wdc.com> wrote:
>

Please explain in the changelog why making this change is a good idea.

> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> ---
>  kernel/power/swap.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/power/swap.c b/kernel/power/swap.c
> index c73f2e295167..e92e36c053a6 100644
> --- a/kernel/power/swap.c
> +++ b/kernel/power/swap.c
> @@ -271,13 +271,12 @@ static int hib_submit_io(int op, int op_flags, pgoff_t page_off, void *addr,
>                 struct hib_bio_batch *hb)
>  {
>         struct page *page = virt_to_page(addr);
> +       sector_t sect = page_off * (PAGE_SIZE >> 9);
>         struct bio *bio;
>         int error = 0;
>
> -       bio = bio_alloc(GFP_NOIO | __GFP_HIGH, 1);
> -       bio->bi_iter.bi_sector = page_off * (PAGE_SIZE >> 9);
> -       bio_set_dev(bio, hib_resume_bdev);
> -       bio_set_op_attrs(bio, op, op_flags);
> +       bio = bio_new(hib_resume_bdev, sect, op, op_flags, 1,
> +                     GFP_NOIO | __GFP_HIGH);
>
>         if (bio_add_page(bio, page, PAGE_SIZE, 0) < PAGE_SIZE) {
>                 pr_err("Adding page to bio failed at %llu\n",
> --
> 2.22.1
>
