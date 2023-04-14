Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 478086E2AC2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Apr 2023 21:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbjDNTtK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Apr 2023 15:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbjDNTtI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Apr 2023 15:49:08 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1476A49F7
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Apr 2023 12:49:07 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id r184so4112853ybc.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Apr 2023 12:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681501746; x=1684093746;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ued8RPGYYYnTKpEa2LQkIv8m2xddx8+vhFWcpImfwlQ=;
        b=tFpwAcRuO/oWarfIbQRGNUHywoAJAdE9Xr73K/XoYX/+lNNn90EfAngAnAUgZsn6K6
         qqlnwgtqd4LExnuakpYn63uO+fhrxTuyWr64ifHof0eLfAnMocwgHB8vuefYoby+u8fg
         BdeArXXzre+hm9KxIuaqyLhxfYpgUfp0h69B16oTP3FM5+oE/i9CmSfv6S2NK1u7L+EG
         OTBmnQDRZLFAUumpp2AV1kYLnHuEKLls9qwqjESqhSvYrUrQiTMrhyTTeaDlrm5j8wL0
         41rEK1DT0Ue4LSFHEvGsQQXGWnSdzqYM283OSgJMi10XGPXIrBPMSkI56q/Y8y+Pbf5U
         11QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681501746; x=1684093746;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ued8RPGYYYnTKpEa2LQkIv8m2xddx8+vhFWcpImfwlQ=;
        b=FnY0ZTb8WDDcvvhI8dd+MUSAzkBmmKxPBuquGqjXhUUrXoLTCLrZCnUmJvkGZJ6o8v
         wxiF6yjQmtBZv59OGZ1Tg1OSh84+NJ+zpSmXfW4asK3AbSwV/TNFLD7bEy/RrpOFuIpd
         H0NkIITfs0fK5v7Q4A1b+cg7j8dEEYSEyvFfNMlGvvH1aFackx/c0YvJNi9u3DAJRDKF
         SQjXqpS9vjX4+f0tF0wxVIKWyf03ADqUQ0pXoq9CShxtyZrz2RMvKbhzExj/o4DJHujE
         mzdQ8uKoDX40vYswd0RYAPT/WSE+Ikut9GVNAldQzv0HHTnq5Iwi9XfN6w1HHbvjgDlb
         No2g==
X-Gm-Message-State: AAQBX9flzquKkAXj4dyzXPCBJW4MroSoDw23/+nDxftpsZkPHmT3V/Pa
        OEgrUafFIYD2mt2rSIHSmY+mDvJLVuoX7PNwLs561A==
X-Google-Smtp-Source: AKy350bcXIOSLr/r2359jbDN5GOP5UXH4qto8PUFwqeUA+xt82gxkvE3IT8IM15dZAvOWwSCO2EtaPkwUH3+8tAqCWI=
X-Received: by 2002:a25:d057:0:b0:b8f:5c64:cc2e with SMTP id
 h84-20020a25d057000000b00b8f5c64cc2emr3418935ybg.12.1681501746075; Fri, 14
 Apr 2023 12:49:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230414180043.1839745-1-surenb@google.com> <ZDmetaUdmlEz/W8Q@casper.infradead.org>
In-Reply-To: <ZDmetaUdmlEz/W8Q@casper.infradead.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 14 Apr 2023 12:48:54 -0700
Message-ID: <CAJuCfpFPNiZmqQPP+K7CAuiFP5qLdd6W9T84VQNdRsN-9ggm1w@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm: handle swap page faults if the faulting page can
 be locked
To:     Matthew Wilcox <willy@infradead.org>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@suse.com,
        josef@toxicpanda.com, jack@suse.cz, ldufour@linux.ibm.com,
        laurent.dufour@fr.ibm.com, michel@lespinasse.org,
        liam.howlett@oracle.com, jglisse@google.com, vbabka@suse.cz,
        minchan@google.com, dave@stgolabs.net, punit.agrawal@bytedance.com,
        lstoakes@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 14, 2023 at 11:43=E2=80=AFAM Matthew Wilcox <willy@infradead.or=
g> wrote:
>
> On Fri, Apr 14, 2023 at 11:00:43AM -0700, Suren Baghdasaryan wrote:
> > When page fault is handled under VMA lock protection, all swap page
> > faults are retried with mmap_lock because folio_lock_or_retry
> > implementation has to drop and reacquire mmap_lock if folio could
> > not be immediately locked.
> > Instead of retrying all swapped page faults, retry only when folio
> > locking fails.
>
> Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Thank you for the reviews!

>
> Let's just review what can now be handled under the VMA lock instead of
> the mmap_lock, in case somebody knows better than me that it's not safe.
>
>  - We can call migration_entry_wait().  This will wait for PG_locked to
>    become clear (in migration_entry_wait_on_locked()).  As previously
>    discussed offline, I think this is safe to do while holding the VMA
>    locked.
>  - We can call remove_device_exclusive_entry().  That calls
>    folio_lock_or_retry(), which will fail if it can't get the VMA lock.
>  - We can call pgmap->ops->migrate_to_ram().  Perhaps somebody familiar
>    with Nouveau and amdkfd could comment on how safe this is?
>  - I believe we can't call handle_pte_marker() because we exclude UFFD
>    VMAs earlier.
>  - We can call swap_readpage() if we allocate a new folio.  I haven't
>    traced through all this code to tell if it's OK.
>
> So ... I believe this is all OK, but we're definitely now willing to
> wait for I/O from the swap device while holding the VMA lock when we
> weren't before.  And maybe we should make a bigger deal of it in the
> changelog.
>
> And maybe we shouldn't just be failing the folio_lock_or_retry(),
> maybe we should be waiting for the folio lock with the VMA locked.

Wouldn't that cause holding the VMA lock for the duration of swap I/O
(something you said we want to avoid in the previous paragraph) and
effectively undo d065bd810b6d ("mm: retry page fault when blocking on
disk transfer") for VMA locks?

>
