Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6370770B44
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Aug 2023 23:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbjHDVyE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Aug 2023 17:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjHDVyD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Aug 2023 17:54:03 -0400
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97920106;
        Fri,  4 Aug 2023 14:54:02 -0700 (PDT)
Received: by mail-vk1-xa2d.google.com with SMTP id 71dfb90a1353d-48716a85f16so712524e0c.3;
        Fri, 04 Aug 2023 14:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691186041; x=1691790841;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Esa07M2shux5azrFa7lTIRiE3FnlvA6v4xak5W6Yyjk=;
        b=lslOMdYCeC30UPvTIvI0aosjpBXGZn7sngPRuURDVQ39HLaBeQ6E/lkAuru/lXRBMz
         m73gHAIS54CrSn65n5Jchg0KoWL48g8oB7eYtld/P90faJs0n6W82Xe8Z0UlGTUmo5bb
         IvgYdyJQwcRUODos9vjSb7M54g/qLDb6w8KhKe35u9GAje0D1cR+kHcRQ239Ws+AEk03
         2nHILU3myArnRstOptus5JIOHmwCOFNth6EjpnvwSOZ6AuCPbBPzYG2GOgldSlizDSWx
         A61CryrSa7G3lGA/7I30HRvCkTrEuX8+ndwXYAXhGu5E9muo7ZFoxixnlI4Dp4Nb5n8+
         fKhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691186041; x=1691790841;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Esa07M2shux5azrFa7lTIRiE3FnlvA6v4xak5W6Yyjk=;
        b=WprTbY8wMpoNBqHN9Z3yJ+ZIRdOkbNev2GtGqXaaWELL7Yr950X2VwD2DL1ZJYUZGI
         AGP1hvQMvVBOshJY2aB1i33MfxCFMvoxQ+2FJ3XhYB9MwE2Krwl004tb/rln6U8ZQwov
         BfgD3z1TViicvoPorjtcVZLdO5b+IYbdIC5jnrhfXv2rS5w5T+z1oukKvPFu9hY8zjYP
         +sk8BWMsb/hnIuZI0Q6+YSZW21E/N8Kq6h7NE0rvcDcwHbEUY5wVGWIpqjW/n8VLislX
         sW218Z3dk+qynta6YEXxzyEZKX49HbNkdJ690GT3Uk75PsUowdH68XT9Fo0POpBGUAU6
         Zvng==
X-Gm-Message-State: AOJu0YwgP1NQLSM6m5A8Lm6OliPi5Q9AxQx035swA5IgsHS//8nT3roE
        VCBaKowlwhEdTcZdmXAiR6Yeup+Wi3V9u5r60w0=
X-Google-Smtp-Source: AGHT+IFahKpzpIJYaivvhmIRXbOcsGuHjA0b6V8skSUZy2IVPHamiQVkLgSl7ceD8hFW+TEIM7u0UyhOIYM9qK4nTCA=
X-Received: by 2002:a1f:5e04:0:b0:471:17be:ba8d with SMTP id
 s4-20020a1f5e04000000b0047117beba8dmr2417786vkb.3.1691186041493; Fri, 04 Aug
 2023 14:54:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230727093637.1262110-1-usama.anjum@collabora.com> <20230727093637.1262110-3-usama.anjum@collabora.com>
In-Reply-To: <20230727093637.1262110-3-usama.anjum@collabora.com>
From:   Andrei Vagin <avagin@gmail.com>
Date:   Fri, 4 Aug 2023 14:53:49 -0700
Message-ID: <CANaxB-zZFq7VD7tBBUmACUJPE9iVuTyQKfg4Jw82-U_1qw6ALg@mail.gmail.com>
Subject: Re: [PATCH v26 2/5] fs/proc/task_mmu: Implement IOCTL to get and
 optionally clear info about PTEs
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>,
        Danylo Mocherniuk <mdanylo@google.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Mike Rapoport <rppt@kernel.org>, Nadav Amit <namit@vmware.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Yang Shi <shy828301@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Yun Zhou <yun.zhou@windriver.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Alex Sierra <alex.sierra@amd.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>, kernel@collabora.com,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 27, 2023 at 2:37=E2=80=AFAM Muhammad Usama Anjum
<usama.anjum@collabora.com> wrote:
>

<snip>

> +static long do_pagemap_scan(struct mm_struct *mm, unsigned long uarg)
> +{
> +       unsigned long walk_start, walk_end;
> +       struct mmu_notifier_range range;
> +       struct pagemap_scan_private p;
> +       size_t n_ranges_out =3D 0;
> +       int ret;
> +
> +       memset(&p, 0, sizeof(p));
> +       ret =3D pagemap_scan_get_args(&p.arg, uarg);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D pagemap_scan_init_bounce_buffer(&p);
> +       if (ret)
> +               return ret;
> +
> +       /* Protection change for the range is going to happen. */
> +       if (p.arg.flags & PM_SCAN_WP_MATCHING) {
> +               mmu_notifier_range_init(&range, MMU_NOTIFY_PROTECTION_VMA=
, 0,
> +                                       mm, p.arg.start, p.arg.end);
> +               mmu_notifier_invalidate_range_start(&range);
> +       }
> +
> +       walk_start =3D walk_end =3D p.arg.start;
> +       for (; walk_end !=3D p.arg.end; walk_start =3D walk_end) {
> +               int n_out;
> +
> +               walk_end =3D min_t(unsigned long,
> +                                (walk_start + PAGEMAP_WALK_SIZE) & PAGEM=
AP_WALK_MASK,
> +                                p.arg.end);

This approach has performance implications. The basic program that scans
its address space takes around 20-30 seconds, but it has just a few
small mappings. The first optimization that comes to mind is to remove
the PAGEMAP_WALK_SIZE limit and instead halt walk_page_range when the
bounce buffer is full. After draining the buffer, the walk_page_range
function can be restarted.

The test program and perf data can be found here:
https://gist.github.com/avagin/c5a22f3c78f8cb34281602dfe9c43d10

> +
> +               ret =3D mmap_read_lock_killable(mm);
> +               if (ret)
> +                       break;
> +               ret =3D walk_page_range(mm, walk_start, walk_end,
> +                                     &pagemap_scan_ops, &p);
> +               mmap_read_unlock(mm);
> +
> +               n_out =3D pagemap_scan_flush_buffer(&p);
> +               if (n_out < 0)
> +                       ret =3D n_out;
> +               else
> +                       n_ranges_out +=3D n_out;
> +
> +               if (ret)
> +                       break;
> +       }
> +

Thanks,
Andrei
