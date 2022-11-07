Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8683361F31B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Nov 2022 13:27:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232195AbiKGM1P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Nov 2022 07:27:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232245AbiKGM1N (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Nov 2022 07:27:13 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 430036402
        for <linux-fsdevel@vger.kernel.org>; Mon,  7 Nov 2022 04:27:12 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id r14so17285140edc.7
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Nov 2022 04:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Spa9i7ZZi/PqL0mkZcklMgIzofmfvMGIgf+WKCkXIMQ=;
        b=jLvnLgvlxGE5ngnjopyA4a2yysB33if8in8kuEiUGZz0XMRPhT3N3XX2UU0Z02SjJa
         FE7atSEyVzKKdtrwY0PVb8zYTIeaOgJnpezWILnMIUcd6Q6BvMdB5Blys/Sk+si0wdoi
         cxJWltzEJODEgrR6eSFlCqNwS9ZFIsMPbmeuGAi4XjatM6S9lPMiOqDUaJXOEPV65I5q
         6nYIe3M7IkieIO++K+hxKwvxBHwyObk4oDxX+GtHhKVKU5ifHEuRcpYBBaF/NJWhWQo2
         wxtsM5/WVBHfJTmKg1iAMoZWyNIEo94nUZkVDFxVJGHi00fgYNWEYCMAvqPlT6szNE4i
         pocw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Spa9i7ZZi/PqL0mkZcklMgIzofmfvMGIgf+WKCkXIMQ=;
        b=BtxXsZNb2bNT+t/J9mUR4/J/HI3qJFZRmPYhOL5APPj9a65HuMteKyasll15i+FVvo
         rmP40nDpRHpo8NQ32KaFxb7tgAVJM+x/UCUU4ZaUZB5Ih/d43bB+hxof4wPDG7C+tczB
         H8cjKMQtpePK+v7kQGkcQaJknUtSPYz85dZMdyw8c/tQ2LKBd2GXFEF8TQyBL81iw+vl
         2YZ2UlCiRLI/RD+hC91WM3RQ4JKpsER3b0oZ/XgLnNDa/6qGlSCwqjagWigvtKln7hqv
         Tw4lSkLScSCfIMZjnxkx5o2JVhQyjraaxqxMweZhrtBQwrEonNAlZsJ7+LGCBCKYIs+W
         U9zw==
X-Gm-Message-State: ACrzQf32S+7ZU31RYHx/2YhL4KLoaErI00VKupBjryUm0GH/yMZx0l+H
        wQra8dhwz0fxiREKo75IHWBHiUG1schIZ/Q/AJeciA==
X-Google-Smtp-Source: AMsMyM6P4MUoGjkj6W0BuOtOqQhVLj9fCKtgk0YVH9i2+0GMg02EXI0DnuuovMLuo6xJlqXa24LIp4zGDBEoY6Qo63g=
X-Received: by 2002:a05:6402:386:b0:463:c43f:6628 with SMTP id
 o6-20020a056402038600b00463c43f6628mr32856779edv.53.1667824030610; Mon, 07
 Nov 2022 04:27:10 -0800 (PST)
MIME-Version: 1.0
References: <20221103145353.3049303-1-usama.anjum@collabora.com> <20221103145353.3049303-3-usama.anjum@collabora.com>
In-Reply-To: <20221103145353.3049303-3-usama.anjum@collabora.com>
From:   =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>
Date:   Mon, 7 Nov 2022 13:26:59 +0100
Message-ID: <CABb0KFFaYZG62TS+iM3Y92+hDyB35XR8dTX-5hDgWrXCcDQx7Q@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] fs/proc/task_mmu: Implement IOCTL to get and/or
 the clear info about PTEs
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     Andrei Vagin <avagin@gmail.com>,
        Danylo Mocherniuk <mdanylo@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Christian Brauner <brauner@kernel.org>,
        Peter Xu <peterx@redhat.com>, Yang Shi <shy828301@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Zach O'Keefe" <zokeefe@google.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>, kernel@collabora.com,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        David Hildenbrand <david@redhat.com>,
        Peter Enderborg <peter.enderborg@sony.com>,
        "open list : KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list : PROC FILESYSTEM" <linux-fsdevel@vger.kernel.org>,
        "open list : MEMORY MANAGEMENT" <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 3 Nov 2022 at 15:54, Muhammad Usama Anjum
<usama.anjum@collabora.com> wrote:
> This IOCTL, PAGEMAP_SCAN can be used to get and/or clear the info about
> page table entries. The following operations are supported in this ioctl:
> - Get the information if the pages are soft-dirty, file mapped, present
>   or swapped.
> - Clear the soft-dirty PTE bit of the pages.
> - Get and clear the soft-dirty PTE bit of the pages.
>
> Only the soft-dirty bit can be read and cleared atomically. struct
> pagemap_sd_args is used as the argument of the IOCTL. In this struct:
> - The range is specified through start and len.
> - The output buffer and size is specified as vec and vec_len.
> - The optional maximum requested pages are specified in the max_pages.
> - The flags can be specified in the flags field. The PAGEMAP_SD_CLEAR
>   and PAGEMAP_SD_NO_REUSED_REGIONS are supported.
> - The masks are specified in rmask, amask, emask and return_mask.
[...]
> --- a/include/uapi/linux/fs.h
> +++ b/include/uapi/linux/fs.h
> @@ -305,4 +305,57 @@ typedef int __bitwise __kernel_rwf_t;
>  #define RWF_SUPPORTED  (RWF_HIPRI | RWF_DSYNC | RWF_SYNC | RWF_NOWAIT |\
>                          RWF_APPEND)
>
> +/* PAGEMAP IOCTL */
> +#define PAGEMAP_SCAN   _IOWR('f', 16, struct pagemap_scan_arg)
> +
> +/* Bits are set in the bitmap of the page_region and masks in pagemap_sd=
_args */
> +#define PAGE_IS_SD     (1 << 0)

Can we name it PAGE_IS_SOFTDIRTY? "SD" can mean so many things.

> +#define PAGE_IS_FILE   (1 << 1)
> +#define PAGE_IS_PRESENT        (1 << 2)
> +#define PAGE_IS_SWAPED (1 << 3)

PAGE_IS_SWAPPED?

> +
> +/*
> + * struct page_region - Page region with bitmap flags
> + * @start:     Start of the region
> + * @len:       Length of the region
> + * bitmap:     Bits sets for the region
> + */
> +struct page_region {
> +       __u64 start;
> +       __u64 len;
> +       __u32 bitmap;
> +       __u32 __reserved;

"u64 flags"? If an extension is needed it would already require a new
ioctl or something in the `arg` struct.

> +
> +/*
> + * struct pagemap_scan_arg - Soft-dirty IOCTL argument

Since this is no longer a soft-dirty-specific call, it might be better
to describe it as "VM scan ioctl" or similar. BTW, the implementation
is currently guarded by CONFIG_MEM_SOFT_DIRTY, but CRIU doesn't need
that but needs the other bits handling.

> + * @start:             Starting address of the region
> + * @len:               Length of the region (All the pages in this lengt=
h are included)
> + * @vec:               Address of page_region struct array for output
> + * @vec_len:           Length of the page_region struct array
> + * @max_pages:         Optional max return pages (It must be less than v=
ec_len if specified)

I think we discussed that this is not counting the same things as
vec_len, so there should not be a reference between the two. The limit
is whatever fits under both conditions (IOW: n_vecs <=3D vec_len &&
(!max_pages || n_pages <=3D max_pages).

> + * @flags:             Special flags for the IOCTL

Just "Flags for the IOCTL".

> + * @rmask:             Required mask - All of these bits have to be set =
in the PTE
> + * @amask:             Any mask - Any of these bits are set in the PTE
> + * @emask:             Exclude mask - None of these bits are set in the =
PTE

It might be easier for developers if those were named e.g.
"required_mask", "anyof_mask", "excluded_mask".

> + * @return_mask:       Bits that have to be reported to the user in page=
_region

"Bits that are to be reported in page_region"?

> + */
> +struct pagemap_scan_arg {
> +       __u64 start;
> +       __u64 len;
> +       __u64 vec;
> +       __u64 vec_len;
> +       __u32 max_pages;
> +       __u32 flags;
> +       __u32 rmask;
> +       __u32 amask;
> +       __u32 emask;
> +       __u32 return_mask;
> +};
> +
> +/* Special flags */
> +#define PAGEMAP_SD_CLEAR               (1 << 0)

SD -> SOFTDIRTY

> +/* Check the individual pages if they are soft-dirty to find dirty pages=
 faster. */
> +#define PAGEMAP_NO_REUSED_REGIONS      (1 << 1)

Please include the description from commitmsg of what this flag does
(i.e. how the behaviour differs because of the flag). I'd drop the
part about it being faster, as if so - why have the flag at all
instead of just always using the faster way?

(I only reviewed the API now. The implementation I think could be
simpler, but let's leave that to after the API is agreed on.)

Best Regards
Micha=C5=82 Miros=C5=82aw
