Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED19774809
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Aug 2023 21:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234206AbjHHTYo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Aug 2023 15:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231809AbjHHTYb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Aug 2023 15:24:31 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 272F016D0F2;
        Tue,  8 Aug 2023 12:21:28 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-d5eeb722a82so143040276.0;
        Tue, 08 Aug 2023 12:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691522487; x=1692127287;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=diySgYB/+o5ldcXShApfWPeWlXdCLBpgzXr+03nag2s=;
        b=aI86kVcP5RX4GTYucp3JU2R1gispSFteGcvwqhB5v+uYh7lcaprwx/MvsiOux+7dVV
         FFTmPer/GsrHdWL9j/bC/KWEeoGTrZpUO47fwt/mV+10/Hu3EKMNvfEBqSbXbB00sYoR
         hRX5bHwEgspX/uOCtN77niYpyyOiMriJM0k5xj+6ISQ3+EXFKDYoML2VRJ1K4vfPoP85
         BSEDZ7jJ2ZRd1COxOLZZ9aTxlVrNmDjU7uJ7dYXmEyYsU5u8s79gWzDLoFdCjAfDOJwq
         PO6pjyJaiVBjmwDI63B0SRwDiN/KKCjI8gtWXmhsACnd6YuRIplqMyjIm3yJMQzZz+YL
         e6LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691522487; x=1692127287;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=diySgYB/+o5ldcXShApfWPeWlXdCLBpgzXr+03nag2s=;
        b=GmbKAGog9a3FtxS35aPx1HGMUtiUeYhBqb75eikpgEPjGuvacKtkfY2cZ8DjDWkApa
         AKb5g5n863fJ8Kvve3U9rIjnuQ6xgRYWqvH4y4kN4PUQC9y+oQvrHLcWie08f3AZJPUq
         eCHgONeIY2OwLusi/4eSWK00d/ADVeuu86s06Pwitqwi27Vhinm1uHdiIm37GrogT4sn
         qUQzJjU9RonkUkwhFPTu/IRjOKCSwerlIwvkWdHaw0rKSYWMsFIcnGgRYtQB9u9F4PJO
         uUIo9XEJ8zLYjSZG/WIi6pqJp8JsVurbTGVpRQWSpp8GTmDZ5COcwNpTK3Z5fyWL9pqh
         JSdQ==
X-Gm-Message-State: AOJu0YwEWrzG6rtEJWUnF63B7B4CPFUxJCL2SVOQvdRF+RB8YJPj756j
        tNRpLnHZrTB8k4T8LKOFACpzrTtBbcl406CkJ6w=
X-Google-Smtp-Source: AGHT+IG5d90bapjIOlJBGA8irxOFPeCaIv3uCJP0B3jPOYPbIPyqiMre2cM/diK+xvgImaerO4LitHR/iRqNuHbzkeQ=
X-Received: by 2002:a25:aaaa:0:b0:d43:a0d8:8db4 with SMTP id
 t39-20020a25aaaa000000b00d43a0d88db4mr11596435ybi.11.1691522486684; Tue, 08
 Aug 2023 12:21:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230808104309.357852-1-usama.anjum@collabora.com> <20230808104309.357852-3-usama.anjum@collabora.com>
In-Reply-To: <20230808104309.357852-3-usama.anjum@collabora.com>
From:   Andrei Vagin <avagin@gmail.com>
Date:   Tue, 8 Aug 2023 12:21:10 -0700
Message-ID: <CANaxB-ww6AcO4QThubYw62Mdeid4e3FOQAXvA_GZ=wu4J60-AQ@mail.gmail.com>
Subject: Re: [PATCH v27 2/6] fs/proc/task_mmu: Implement IOCTL to get and
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

On Tue, Aug 8, 2023 at 3:43=E2=80=AFAM Muhammad Usama Anjum
<usama.anjum@collabora.com> wrote:

....

> +static int pagemap_scan_output(unsigned long categories,
> +                              struct pagemap_scan_private *p,
> +                              unsigned long addr, unsigned long *end)
> +{
> +       unsigned long n_pages, total_pages;
> +       int ret =3D 0;
> +
> +       if (!p->vec_buf)
> +               return 0;
> +
> +       categories &=3D p->arg.return_mask;
> +
> +       n_pages =3D (*end - addr) / PAGE_SIZE;
> +       if (check_add_overflow(p->found_pages, n_pages, &total_pages) || =
//TODO

Need to fix this TODO.

> +           total_pages > p->arg.max_pages) {
> +               size_t n_too_much =3D total_pages - p->arg.max_pages;
> +               *end -=3D n_too_much * PAGE_SIZE;
> +               n_pages -=3D n_too_much;
> +               ret =3D -ENOSPC;
> +       }
> +
> +       if (!pagemap_scan_push_range(categories, p, addr, *end)) {
> +               *end =3D addr;
> +               n_pages =3D 0;
> +               ret =3D -ENOSPC;
> +       }
> +
> +       p->found_pages +=3D n_pages;
> +       if (ret)
> +               p->walk_end_addr =3D *end;
> +
> +       return ret;
> +}
> +

...

> +static long do_pagemap_scan(struct mm_struct *mm, unsigned long uarg)
> +{
> +       struct mmu_notifier_range range;
> +       struct pagemap_scan_private p;
> +       unsigned long walk_start;
> +       size_t n_ranges_out =3D 0;
> +       int ret;
> +
> +       memset(&p, 0, sizeof(p));
> +       ret =3D pagemap_scan_get_args(&p.arg, uarg);
> +       if (ret)
> +               return ret;
> +
> +       p.masks_of_interest =3D MASKS_OF_INTEREST(p.arg);
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
> +       walk_start =3D p.arg.start;
> +       for (; walk_start < p.arg.end; walk_start =3D p.arg.walk_end) {
> +               int n_out;
> +
> +               if (fatal_signal_pending(current)) {
> +                       ret =3D -EINTR;
> +                       break;
> +               }
> +
> +               ret =3D mmap_read_lock_killable(mm);
> +               if (ret)
> +                       break;
> +               ret =3D walk_page_range(mm, walk_start, p.arg.end,
> +                                     &pagemap_scan_ops, &p);
> +               mmap_read_unlock(mm);
> +
> +               n_out =3D pagemap_scan_flush_buffer(&p);
> +               if (n_out < 0)
> +                       ret =3D n_out;
> +               else
> +                       n_ranges_out +=3D n_out;
> +
> +               if (ret !=3D -ENOSPC || p.arg.vec_len - 1 =3D=3D 0 ||
> +                   p.found_pages =3D=3D p.arg.max_pages) {
> +                       p.walk_end_addr =3D p.arg.end;

You should not change p.walk_end_addr If ret is ENOSPC. Pls add a test
case to check this.

> +                       break;
> +               }
> +       }
> +
> +       if (p.cur_buf.start !=3D p.cur_buf.end) {
> +               if (copy_to_user(p.vec_out, &p.cur_buf, sizeof(p.cur_buf)=
))
> +                       ret =3D -EFAULT;
> +               else
> +                       ++n_ranges_out;
> +       }
> +
> +       /* ENOSPC signifies early stop (buffer full) from the walk. */
> +       if (!ret || ret =3D=3D -ENOSPC)
> +               ret =3D n_ranges_out;
> +
> +       p.arg.walk_end =3D p.walk_end_addr ? p.walk_end_addr : walk_start=
;
> +       if (pagemap_scan_writeback_args(&p.arg, uarg))
> +               ret =3D -EFAULT;
> +
> +       if (p.arg.flags & PM_SCAN_WP_MATCHING)
> +               mmu_notifier_invalidate_range_end(&range);
> +
> +       kfree(p.vec_buf);
> +       return ret;
> +}

Thanks,
Andrei
