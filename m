Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D56F735B005
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Apr 2021 21:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234911AbhDJTLT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 10 Apr 2021 15:11:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:45068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234768AbhDJTLS (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 10 Apr 2021 15:11:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BC6966113A;
        Sat, 10 Apr 2021 19:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618081863;
        bh=rBfw+r2um68UpFbzVkxVlHHyJ+hgFPf/zBrFYQw7TNI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CIhhz328zzet5a/BvXZzSs9qZeOvsRmdTIQX8oHvPt4oPq31f6SdMiRQlV3wwxeNa
         GmirfKbnBbXy13rC5mPC5X4IYTxOrbfSp201pVc2ivwXNFWXhMjpUUd6Z3P6GdAypc
         hXQbk3jNgzXE4abVKr5LlTbMx3yus3tJYykOkPF4g5QUy/4sEmN3QnSl1XUTyImSG8
         +nrIDp4z3hEGajjGuvQYOwmAvld9GZf6ZqRXKlZ6kJNOxc2eYZ8HIjAVZ3TijeONug
         5j3gyVLCEPaB6nGAjThA9V1IH5nKdc2cpKmOF0OJJIEPxgrvw2FaG4CSqtEAVnEU7R
         BXNDi+Akq/Lhw==
Received: by mail-ot1-f47.google.com with SMTP id k14-20020a9d7dce0000b02901b866632f29so8973160otn.1;
        Sat, 10 Apr 2021 12:11:03 -0700 (PDT)
X-Gm-Message-State: AOAM531Gu7ZroMfzZPVK+zswSeVKSRAt6gNScNWY7toYwzv0pgTbqngs
        YoYRoVagkOv02V8N9BihJZYRoDdswmEDZttOAdg=
X-Google-Smtp-Source: ABdhPJy5fKRN+b0N+vdm7HuaN0voD9Ksx0FbjR4NiXXEFlqO3Rbtb6TftW/JNl1MSl+hXOUABL/gf3HkAiDbD0wFK7g=
X-Received: by 2002:a05:6830:148c:: with SMTP id s12mr17843523otq.251.1618081863076;
 Sat, 10 Apr 2021 12:11:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210409185105.188284-3-willy@infradead.org> <202104100656.N7EVvkNZ-lkp@intel.com>
 <20210410024313.GX2531743@casper.infradead.org>
In-Reply-To: <20210410024313.GX2531743@casper.infradead.org>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Sat, 10 Apr 2021 21:10:47 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3uEGaEN-p06vFP+jwbFt3P=Bx4=aRN+kUyB4PcFPxLRg@mail.gmail.com>
Message-ID: <CAK8P3a3uEGaEN-p06vFP+jwbFt3P=Bx4=aRN+kUyB4PcFPxLRg@mail.gmail.com>
Subject: Re: Bogus struct page layout on 32-bit
To:     Matthew Wilcox <willy@infradead.org>
Cc:     kernel test robot <lkp@intel.com>, Linux-MM <linux-mm@kvack.org>,
        kbuild-all@lists.01.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Apr 10, 2021 at 4:44 AM Matthew Wilcox <willy@infradead.org> wrote:
> +                       dma_addr_t dma_addr __packed;
>                 };
>                 struct {        /* slab, slob and slub */
>                         union {
>
> but I don't know if GCC is smart enough to realise that dma_addr is now
> on an 8 byte boundary and it can use a normal instruction to access it,
> or whether it'll do something daft like use byte loads to access it.
>
> We could also do:
>
> +                       dma_addr_t dma_addr __packed __aligned(sizeof(void *));
>
> and I see pahole, at least sees this correctly:
>
>                 struct {
>                         long unsigned int _page_pool_pad; /*     4     4 */
>                         dma_addr_t dma_addr __attribute__((__aligned__(4))); /*     8     8 */
>                 } __attribute__((__packed__)) __attribute__((__aligned__(4)));
>
> This presumably affects any 32-bit architecture with a 64-bit phys_addr_t
> / dma_addr_t.  Advice, please?

I've tried out what gcc would make of this:  https://godbolt.org/z/aTEbxxbG3

struct page {
    short a;
    struct {
        short b;
        long long c __attribute__((packed, aligned(2)));
    } __attribute__((packed));
} __attribute__((aligned(8)));

In this structure, 'c' is clearly aligned to eight bytes, and gcc does
realize that
it is safe to use the 'ldrd' instruction for 32-bit arm, which is forbidden on
struct members with less than 4 byte alignment. However, it also complains
that passing a pointer to 'c' into a function that expects a 'long long' is not
allowed because alignof(c) is only '2' here.

(I used 'short' here because I having a 64-bit member misaligned by four
bytes wouldn't make a difference to the instructions on Arm, or any other
32-bit architecture I can think of, regardless of the ABI requirements).

      Arnd
