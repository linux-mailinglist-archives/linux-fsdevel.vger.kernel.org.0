Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE68A4FCDD0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Apr 2022 06:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345874AbiDLE3G (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Apr 2022 00:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236318AbiDLE3D (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Apr 2022 00:29:03 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05F1832992
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Apr 2022 21:26:47 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id z6-20020a17090a398600b001cb9fca3210so1547285pjb.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Apr 2022 21:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UCrOTwn1Apaa4uQLVmk5UD3cOc527xiwJT4PNuBWV0U=;
        b=qj1azZVRiLRWoOmK62O5jlUS3eBsOBIqGZrTPkVTrhXug25XR9RPlwdGNSyUk6Cn4Q
         O2h7oNKaIwwR0F/KAXVsmKOmZQHsE4nq+VcPu6FVr2QkdlsNenKN4YVbKRVtAVD7u7b4
         I3TXIiz7RmEJHBwtR9BUhZjSikRfkKsP2qKeq9uIwnIe5tR2LVuM+/vMUI/GaRim758K
         qpLoQglwz9v9mBUy4ZF8OIj7vFFvKFSsACWjKZnX/zRinYHwXhHZ8rpo2gkwmxTBjBjs
         SyNSru4EiN82wpRW3gwhJCjwubkugBNJd5Ve8Thx53DS0elOAsHJVybqbBJhleyoy6f0
         XOqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UCrOTwn1Apaa4uQLVmk5UD3cOc527xiwJT4PNuBWV0U=;
        b=A+7mKg73nSFge28lz87AdP4/dpZ2pX6PTbFnRjSeSBPpH6btXf8GD27gMXT3Q0IvvF
         h3ourOXAjIEiDXD7/e2NWSfpNuj58oaL13BlwxWWG0t4fTgIylT3s5UQu2Om0lZRSUFv
         UtVDGG5Yg1aBomZgaEmyZ73StjPGRAuqZlgeJoeNt+9W2ncigmbCCKlHQYUqUxTG+08O
         nycF7qow+Jnwd0HmyGef/8cMFMD8ysflJ1w3MakCgmWIrBhH96shlknQbjWTUCQkYfgC
         9lJG4iJiujoDg1Gm6gElyvfEQuRfiM9fd4WGZRt70w5eDHdWhw5MCpUmP7WJ02BQ6W05
         iJ2w==
X-Gm-Message-State: AOAM533oWGp/EpDWhJwbfnzPEofBJJo2aYfLvE2Ovl5YYmmjvvJlYyyO
        8OYKkduXjtoHkCDWSWBGpefXscX7ytktLrJdSCwyji8s7r4=
X-Google-Smtp-Source: ABdhPJykgObq290XUnROGzq2QfTK7LzFthT5iMS5THy+7CybmACgJItes+F9wWuzrX+7pufyRJ0OO61OHh/NWBRaQSs=
X-Received: by 2002:a17:90b:1804:b0:1cb:82e3:5cd0 with SMTP id
 lw4-20020a17090b180400b001cb82e35cd0mr2859224pjb.8.1649737606512; Mon, 11 Apr
 2022 21:26:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220405194747.2386619-1-jane.chu@oracle.com> <20220405194747.2386619-6-jane.chu@oracle.com>
In-Reply-To: <20220405194747.2386619-6-jane.chu@oracle.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 11 Apr 2022 21:26:35 -0700
Message-ID: <CAPcyv4h4NGa7_mTrrY0EqXdGny5p9JtQZx+CVBcHxX6_ZuO9pg@mail.gmail.com>
Subject: Re: [PATCH v7 5/6] pmem: refactor pmem_clear_poison()
To:     Jane Chu <jane.chu@oracle.com>
Cc:     david <david@fromorbit.com>, "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        device-mapper development <dm-devel@redhat.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vivek Goyal <vgoyal@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>, X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 5, 2022 at 12:48 PM Jane Chu <jane.chu@oracle.com> wrote:
>
> Refactor the pmem_clear_poison() in order to share common code
> later.
>

I would just add a note here about why, i.e. to factor out the common
shared code between the typical write path and the recovery write
path.

> Signed-off-by: Jane Chu <jane.chu@oracle.com>
> ---
>  drivers/nvdimm/pmem.c | 78 ++++++++++++++++++++++++++++---------------
>  1 file changed, 52 insertions(+), 26 deletions(-)
>
> diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
> index 0400c5a7ba39..56596be70400 100644
> --- a/drivers/nvdimm/pmem.c
> +++ b/drivers/nvdimm/pmem.c
> @@ -45,10 +45,27 @@ static struct nd_region *to_region(struct pmem_device *pmem)
>         return to_nd_region(to_dev(pmem)->parent);
>  }
>
> -static void hwpoison_clear(struct pmem_device *pmem,
> -               phys_addr_t phys, unsigned int len)
> +static phys_addr_t to_phys(struct pmem_device *pmem, phys_addr_t offset)
>  {
> +       return (pmem->phys_addr + offset);

Christoph already mentioned dropping the unnecessary parenthesis.

> +}
> +
> +static sector_t to_sect(struct pmem_device *pmem, phys_addr_t offset)
> +{
> +       return (offset - pmem->data_offset) >> SECTOR_SHIFT;
> +}
> +
> +static phys_addr_t to_offset(struct pmem_device *pmem, sector_t sector)
> +{
> +       return ((sector << SECTOR_SHIFT) + pmem->data_offset);
> +}
> +
> +static void pmem_clear_hwpoison(struct pmem_device *pmem, phys_addr_t offset,
> +               unsigned int len)

Perhaps now is a good time to rename this to something else like
pmem_clear_mce_nospec()? Just to make it more distinct from
pmem_clear_poison(). While "hwpoison" is the page flag name
pmem_clear_poison() is the function that's actually clearing the
poison in hardware ("hw") and the new pmem_clear_mce_nospec() is
toggling the page back into service.

> +{
> +       phys_addr_t phys = to_phys(pmem, offset);
>         unsigned long pfn_start, pfn_end, pfn;
> +       unsigned int blks = len >> SECTOR_SHIFT;
>
>         /* only pmem in the linear map supports HWPoison */
>         if (is_vmalloc_addr(pmem->virt_addr))
> @@ -67,35 +84,44 @@ static void hwpoison_clear(struct pmem_device *pmem,
>                 if (test_and_clear_pmem_poison(page))
>                         clear_mce_nospec(pfn);
>         }
> +
> +       dev_dbg(to_dev(pmem), "%#llx clear %u sector%s\n",
> +               (unsigned long long) to_sect(pmem, offset), blks,
> +               blks > 1 ? "s" : "");

In anticipation of better tracing support and the fact that this is no
longer called from pmem_clear_poison() let's drop it for now.

>  }
>
> -static blk_status_t pmem_clear_poison(struct pmem_device *pmem,
> +static void pmem_clear_bb(struct pmem_device *pmem, sector_t sector, long blks)
> +{
> +       if (blks == 0)
> +               return;
> +       badblocks_clear(&pmem->bb, sector, blks);
> +       if (pmem->bb_state)
> +               sysfs_notify_dirent(pmem->bb_state);
> +}
> +
> +static long __pmem_clear_poison(struct pmem_device *pmem,
>                 phys_addr_t offset, unsigned int len)
>  {
> -       struct device *dev = to_dev(pmem);
> -       sector_t sector;
> -       long cleared;
> -       blk_status_t rc = BLK_STS_OK;
> -
> -       sector = (offset - pmem->data_offset) / 512;
> -
> -       cleared = nvdimm_clear_poison(dev, pmem->phys_addr + offset, len);
> -       if (cleared < len)
> -               rc = BLK_STS_IOERR;
> -       if (cleared > 0 && cleared / 512) {
> -               hwpoison_clear(pmem, pmem->phys_addr + offset, cleared);
> -               cleared /= 512;
> -               dev_dbg(dev, "%#llx clear %ld sector%s\n",
> -                               (unsigned long long) sector, cleared,
> -                               cleared > 1 ? "s" : "");
> -               badblocks_clear(&pmem->bb, sector, cleared);
> -               if (pmem->bb_state)
> -                       sysfs_notify_dirent(pmem->bb_state);
> +       phys_addr_t phys = to_phys(pmem, offset);
> +       long cleared = nvdimm_clear_poison(to_dev(pmem), phys, len);
> +
> +       if (cleared > 0) {
> +               pmem_clear_hwpoison(pmem, offset, cleared);
> +               arch_invalidate_pmem(pmem->virt_addr + offset, len);
>         }
> +       return cleared;
> +}
>
> -       arch_invalidate_pmem(pmem->virt_addr + offset, len);
> +static blk_status_t pmem_clear_poison(struct pmem_device *pmem,
> +               phys_addr_t offset, unsigned int len)
> +{
> +       long cleared = __pmem_clear_poison(pmem, offset, len);
>
> -       return rc;
> +       if (cleared < 0)
> +               return BLK_STS_IOERR;
> +
> +       pmem_clear_bb(pmem, to_sect(pmem, offset), cleared >> SECTOR_SHIFT);
> +       return (cleared < len) ? BLK_STS_IOERR : BLK_STS_OK;

I prefer "if / else" syntax instead of a ternary conditional.

>  }
>
>  static void write_pmem(void *pmem_addr, struct page *page,
> @@ -143,7 +169,7 @@ static blk_status_t pmem_do_read(struct pmem_device *pmem,
>                         sector_t sector, unsigned int len)
>  {
>         blk_status_t rc;
> -       phys_addr_t pmem_off = sector * 512 + pmem->data_offset;
> +       phys_addr_t pmem_off = to_offset(pmem, sector);
>         void *pmem_addr = pmem->virt_addr + pmem_off;
>
>         if (unlikely(is_bad_pmem(&pmem->bb, sector, len)))
> @@ -158,7 +184,7 @@ static blk_status_t pmem_do_write(struct pmem_device *pmem,
>                         struct page *page, unsigned int page_off,
>                         sector_t sector, unsigned int len)
>  {
> -       phys_addr_t pmem_off = sector * 512 + pmem->data_offset;
> +       phys_addr_t pmem_off = to_offset(pmem, sector);
>         void *pmem_addr = pmem->virt_addr + pmem_off;
>
>         if (unlikely(is_bad_pmem(&pmem->bb, sector, len))) {

With those small fixups you can add:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
