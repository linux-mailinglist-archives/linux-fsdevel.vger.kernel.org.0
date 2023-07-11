Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA17774F87F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jul 2023 21:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbjGKTnA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jul 2023 15:43:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjGKTm7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jul 2023 15:42:59 -0400
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com [IPv6:2607:f8b0:4864:20::a35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 546CE19B;
        Tue, 11 Jul 2023 12:42:56 -0700 (PDT)
Received: by mail-vk1-xa35.google.com with SMTP id 71dfb90a1353d-47e4521e5baso2333340e0c.1;
        Tue, 11 Jul 2023 12:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689104575; x=1691696575;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dqxaqXmw1tu3QWdtuOVOPVnF0rhjoVkY2FJ4msGP/FE=;
        b=WCXxjiX35VIFpR0nhf5xN1cKqwvEe0aVJDmIXwy5y293z47OG3Hx8HJlUrAFw/hjFN
         pOr8FVTMdX0qwE6i7UKoJ1bVn+fqYysno/V/wnLgh3aFLVP7TKFvo/5IyX+FG3nEX16+
         OBFdpHvbfxXtTQjgmUngDLNjEL3u4KZnbVOntpXvaVf3OpH19Zex/xseSnpZAwbay+yL
         thSo1fZ6zUGGJ4TDftaPNHW5df4OCCTf/o+J5S5lRPYdBfJeRceJdqr0mU4KAD4eO7rr
         GmwZbjcRsrAqUpmh5C2uVP4CA74PUA/Silw7HAREHHV7vWJTbneD0/BHcOgkaYlVISEv
         STvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689104575; x=1691696575;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dqxaqXmw1tu3QWdtuOVOPVnF0rhjoVkY2FJ4msGP/FE=;
        b=U6pxITtXDdxn+yXvK3d09+hhk2qRqEnkGs7apWYfFHNhCrkBdqACk+jMEr3FQa/1a6
         leSMFcrPT/5lr2IQXaAO7ppto69wi6c3pfn6lvZc04R8grfxHWlWdInZttKernkiCw/h
         IsysD3ZxIw5iquwHfVeerUJRUhGcvykJgX5ZpYFC4PfqKlV2xavCCx1trqQjQT/ZyLDX
         McRrolmkHbechzDIHnlAsU69k2hejGGn4+56vgt+2fzNW6iHOxfP/nz83RGOx+Y/3E5m
         4UVj7b9ZKUAMOyppd6AuTDAMLFj8GObAheoLOk1Czg9pT5rSt05ySKjekwKobOUzZl1J
         npmQ==
X-Gm-Message-State: ABy/qLaQLiisTAb2t/uBgGjK+2b8PVTy5KD7LqbWBW9nKsYvJLovFayF
        5S83nNnhskKSaWq38wY2t8PjeO9QKFyp56SmmQo=
X-Google-Smtp-Source: APBJJlFESZwse+XBzfdEG7gPgKtm+dr9PqBvDRHkx0QyDpPtucriutBokoi6nHj9mpK7MC+ZT1zx1fvPJQ5h6dotD6o=
X-Received: by 2002:a1f:5842:0:b0:476:3544:773 with SMTP id
 m63-20020a1f5842000000b0047635440773mr8354569vkb.11.1689104575315; Tue, 11
 Jul 2023 12:42:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230711125241.1587820-1-usama.anjum@collabora.com> <20230711125241.1587820-3-usama.anjum@collabora.com>
In-Reply-To: <20230711125241.1587820-3-usama.anjum@collabora.com>
From:   Andrei Vagin <avagin@gmail.com>
Date:   Tue, 11 Jul 2023 12:42:44 -0700
Message-ID: <CANaxB-zvYpKw-aeF8nd_spARdkV29H7ZJDDhusnmqOPZX1xXtw@mail.gmail.com>
Subject: Re: [PATCH v24 2/5] fs/proc/task_mmu: Implement IOCTL to get and
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
        Greg KH <gregkh@linuxfoundation.org>, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 11, 2023 at 5:53=E2=80=AFAM Muhammad Usama Anjum
<usama.anjum@collabora.com> wrote:

<snip>

> +static int pagemap_scan_pte_hole(unsigned long addr, unsigned long end,
> +                                int depth, struct mm_walk *walk)
> +{
> +       unsigned long n_pages =3D (end - addr)/PAGE_SIZE;
> +       struct pagemap_scan_private *p =3D walk->private;
> +       struct vm_area_struct *vma =3D walk->vma;
> +       int ret =3D 0;
> +
> +       if (!vma)
> +               return 0;
> +
> +       if (IS_PM_SCAN_GET(p->flags)) {
> +               if (n_pages > p->max_pages - p->found_pages)
> +                       n_pages =3D p->max_pages - p->found_pages;
> +
> +               ret =3D pagemap_scan_output(PM_SCAN_FLAGS(false, false, f=
alse,
> +                                         false, false), p, addr, n_pages=
);

Why do we report holes unconditionally?

> +       }
> +
> +       if (IS_PM_SCAN_WP(p->flags) &&
> +           uffd_wp_range(vma, addr, end - addr, true) < 0)
> +               ret =3D -EINVAL;
> +
> +       return ret;
> +}

Thanks,
Andrei
