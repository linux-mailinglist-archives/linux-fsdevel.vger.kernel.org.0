Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A1DF542C97
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jun 2022 12:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235929AbiFHKG1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jun 2022 06:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235955AbiFHKFy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jun 2022 06:05:54 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C217B195963
        for <linux-fsdevel@vger.kernel.org>; Wed,  8 Jun 2022 02:48:46 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id c4so318104lfj.12
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Jun 2022 02:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5MvY63O3iyeaaPn7WOTZgHkmdRzYMjvv3hE09dOL+Gs=;
        b=aDdFeOalLJRdk974RqBFZCt/aGIz6OTFkU1EfmKmg3+DCKrvmizFq1y5rRLL00DzAo
         uritWCbqCrrKyBWizZFThI2okQ71zzav0Ub+WD55/DNSc8ocIBXENgvCICCPSNNjU8n+
         mLiJddfojWkw8RMg7J0xmTZPFTzemDsWa5p2X5Um2Z0FzsFigh5xySBU+KwG+Rax95A/
         YPbHKdtRedeiY5HXZOItVa59sxn2njgIqo+fRl0EEu8dQG7sV9KIMOVX9olaG0xhJCG3
         J9uulOx7MV5yKIUDgIqe2qCH/6GfiyGSTVkY778sk11QVQyYuct9wtO+lKbc1kJN0wlu
         Voqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5MvY63O3iyeaaPn7WOTZgHkmdRzYMjvv3hE09dOL+Gs=;
        b=dziRKbARUxypSztfpFlt1XYisgnFopSJPBbCZ67Df7gt/DHrDNxk6gJjsaNYnVeKH0
         KTRM2RpDtX0ZlbwFEsv4/dchDqOf7D3OOJj0n/eqmcHTrw84aGqung3w6ztVfcJOrCkZ
         RvCxtIl1ziBzYXOjCf/9hthzja/5ssISh+uIA4uzpJPsqwVnZDHUFu+wey5S6g2YZPaq
         XMeQ0NFMCq9JjD9W+17zMtp17YQvl0iqNqS4qKW8mrSjfIodNkKYgD55g3waJk2lZ3X7
         kbtu+zwSiq1cCpftoHn1rFuBVlREYZ6XlYqyTFEkiTCS59MCSgDn/KBC/xa1xYfMepCD
         Pykg==
X-Gm-Message-State: AOAM533nufroU0qUHo+D5mRZGqO89oiVoQgBLXbaWqtH8op1VuxZFFWX
        dM69P/dq3f3+9m8VMpQ5W/GPOtMrSLTjHvkJOxRD9dASs/jOaQ==
X-Google-Smtp-Source: ABdhPJyUy/6a6Vs+4wJzmXfn/97Cj83Ra0FDJvbPQVaApebiu/YzvTAlBuMGpc5MIJKwBAe+nneYoF5et1TbZ693EZk=
X-Received: by 2002:a05:6512:138d:b0:478:b72a:d66d with SMTP id
 p13-20020a056512138d00b00478b72ad66dmr44899362lfa.641.1654681724895; Wed, 08
 Jun 2022 02:48:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220507041033.9588-1-lchen@localhost.localdomain> <YoT49tEhHu8uMUt2@infradead.org>
In-Reply-To: <YoT49tEhHu8uMUt2@infradead.org>
From:   Liang Chen <liangchen.linux@gmail.com>
Date:   Wed, 8 Jun 2022 17:48:33 +0800
Message-ID: <CAKhg4t+XiEoKF6-_duA5jgfp7P_C-6JWhFZDTmeo0=oxd99Xow@mail.gmail.com>
Subject: Re: [PATCH v2] fs: Fix page cache inconsistency when mixing buffered
 and AIO DIO for bdev
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, jmoyer@redhat.com, jack@suse.cz,
        lczerner@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 18, 2022 at 9:47 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Sat, May 07, 2022 at 12:10:33PM +0800, Liang Chen wrote:
> > From: Liang Chen <liangchen.linux@gmail.com>
> >
> > As pointed out in commit 332391a, mixing buffered reads and asynchronous
> > direct writes risks ending up with a situation where stale data is left
> > in page cache while new data is already written to disk. The same problem
> > hits block dev fs too. A similar approach needs to be taken here.
>
> What is the real issue here?  If you mix direct and buffered I/O
> you generally get what you pay for.  Even more so on block devices that
> don't even follow Posix file system semantics.

Sorry, missed your reply.
You are right. The problem was manifested when mixing direct and
buffered I/O, and can be avoided by not doing so.
I tried to bring block device direct IO onto one of the generic DIO
paths, but it resulted in some noticeable performance degradation.
So I would rather leave it as is, since as you mentioned block devices
don't even follow Posix file system semantics.

Thanks,
Liang
