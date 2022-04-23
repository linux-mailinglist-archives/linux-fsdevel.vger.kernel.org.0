Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC0CA50CCEA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Apr 2022 20:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236748AbiDWSns (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 23 Apr 2022 14:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236723AbiDWSnr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 23 Apr 2022 14:43:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4423473BC;
        Sat, 23 Apr 2022 11:40:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C663BB80CC7;
        Sat, 23 Apr 2022 18:40:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66F7DC385A0;
        Sat, 23 Apr 2022 18:40:44 +0000 (UTC)
Date:   Sat, 23 Apr 2022 19:40:40 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>, Will Deacon <will@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 0/3] Avoid live-lock in btrfs fault-in+uaccess loop
Message-ID: <YmRIKJSr0xSRHliN@arm.com>
References: <20220423100751.1870771-1-catalin.marinas@arm.com>
 <CAHk-=wgafGgBC9JEu397YxFD8o8qiCZHQS+f5i+BSXOkOFqX3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgafGgBC9JEu397YxFD8o8qiCZHQS+f5i+BSXOkOFqX3w@mail.gmail.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Apr 23, 2022 at 09:35:42AM -0700, Linus Torvalds wrote:
> On Sat, Apr 23, 2022 at 3:07 AM Catalin Marinas <catalin.marinas@arm.com> wrote:
> >
> > The series introduces fault_in_subpage_writeable() together with the
> > arm64 probing counterpart and the btrfs fix.
> 
> Looks fine to me - and I think it can probably go through the arm64
> tree since you'd be the only one really testing it anyway.

I'll queue it via arm64 then.

> I assume you checked that btrfs is the only one that uses
> fault_in_writeable() in this way? Everybody else updates to the right
> byte boundary and retries (or returns immediately)?

I couldn't find any other places (by inspection or testing). The
buffered file I/O can already make progress in current fault_in_*() +
copy_*_user() loops. O_DIRECT either goes via GUP (and memcpy() doesn't
fault) or, if the user buffer is not PAGE aligned, it may fall back to
buffered I/O. That's why I simplified the series, AFAICT it's only btrfs
search_ioctl() with this problem.

-- 
Catalin
