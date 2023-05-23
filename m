Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 943D370E76F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 May 2023 23:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238626AbjEWVig (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 May 2023 17:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238613AbjEWVie (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 May 2023 17:38:34 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84295126
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 May 2023 14:38:33 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-64d722dac08so55111b3a.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 May 2023 14:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1684877913; x=1687469913;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y3hgiqpB5zVKDFFdyJMjJwHka3pMf+c6meTRxKFE5Y8=;
        b=HV0x7zMa3YUbocqLk9aQXetrr9ryZrB2RfV/YHAmZdFJpj+J580kbNoVs4yJlfTFah
         ckNKve4m5JHJM0d8z9nn7Yqv7jv5UBLUa+T+a8+ebv1Wsbais4D+qvWMEy2jRH4dil9G
         tJ7wy8o9Lz273r80L/Z1B57YiCRZwsGm+tYwKZyFWJwnBZuZthVeTePg7VZl6oiN2XJ2
         9GRQt0ScSnlnvSHgMNgKlnibVxl1CRc+bBWnxfS2cgidXqKhWTDIngNLnXI9LrKYMY1f
         4TvQMgtsNSNAKpHzNi22AtmTavnbUWPICiuWaY95rxXfeRRuU53lRjLfUDp61LpRkgnr
         H+Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684877913; x=1687469913;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y3hgiqpB5zVKDFFdyJMjJwHka3pMf+c6meTRxKFE5Y8=;
        b=HVgfdYblLGMyWO3Llj1NIjrbYMHxzUs7bduNnEEFv/YD0K6FWruHxlSD0QbIolNxpo
         i4HTyFgZQd7W1IxzDYQ/Y7QMb3Qo/+Ct3VSVLGVx7J81MVjredYxZvyXHsctf2SQI+4U
         GDZ2w/o+f23EYufaSwRqcQk+FeZSUNc9WjnxBbtTt3UiZYiwuAqX4SOz8fRZi3i4eBuf
         q/gm10ry6ekDYASg1KEMobldA7DVrBdEAwKvxu6Swa0itfiK1T+5ms7RlCFXVBNQNZX2
         f4U+9d/0lVMZMtVTJvL13VSbyiRWGSQ9yeu5vItWWFyzAayOf24CtKJP5+Ci5kFRdjhG
         7gmQ==
X-Gm-Message-State: AC+VfDwGl7PR0cu917+Kxr0FRZuVemZx9nC9txS9QhEVSTRImpdiXF/3
        nREXUAkdTYQpcs5/8W0VZcQB1g==
X-Google-Smtp-Source: ACHHUZ7ClhRNdRTJXLeQvAK7QipR6vjidsxzbsGyag+DC7WYvwlkS2VPbAibt93EUTxmMRNaSgC1/Q==
X-Received: by 2002:a05:6a20:7da6:b0:100:eb1e:3939 with SMTP id v38-20020a056a207da600b00100eb1e3939mr15611360pzj.1.1684877912960;
        Tue, 23 May 2023 14:38:32 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id j12-20020aa78dcc000000b0062de9ef6915sm6168473pfr.216.2023.05.23.14.38.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 14:38:32 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Christian Brauner <brauner@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Jason Gunthorpe <jgg@ziepe.ca>
In-Reply-To: <20230522205744.2825689-1-dhowells@redhat.com>
References: <20230522205744.2825689-1-dhowells@redhat.com>
Subject: Re: [PATCH v21 0/6] block: Use page pinning
Message-Id: <168487791137.449781.3170440352656135902.b4-ty@kernel.dk>
Date:   Tue, 23 May 2023 15:38:31 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-00303
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On Mon, 22 May 2023 21:57:38 +0100, David Howells wrote:
> This patchset rolls page-pinning out to the bio struct and the block layer,
> using iov_iter_extract_pages() to get pages and noting with BIO_PAGE_PINNED
> if the data pages attached to a bio are pinned.  If the data pages come
> from a non-user-backed iterator, then the pages are left unpinned and
> unref'd, relying on whoever set up the I/O to do the retaining.
> 
> This requires the splice-read patchset to have been applied first,
> otherwise reversion of the ITER_PAGE iterator can race with truncate and
> return pages to the allocator whilst they're still undergoing DMA[2].
> 
> [...]

Applied, thanks!

[1/6] iomap: Don't get an reference on ZERO_PAGE for direct I/O block zeroing
      commit: 9e73bb36b189ec73c7062ec974e0ff287c1aa152
[2/6] block: Fix bio_flagged() so that gcc can better optimise it
      commit: b9cc607a7f722c374540b2a7c973382592196549
[3/6] block: Replace BIO_NO_PAGE_REF with BIO_PAGE_REFFED with inverted logic
      commit: 100ae68dac60a0688082dcaf3e436606ec0fd51f
[4/6] block: Add BIO_PAGE_PINNED and associated infrastructure
      commit: 84d9fe8b7ea6a53fd93506583ff33a408f95ac60
[5/6] block: Convert bio_iov_iter_get_pages to use iov_iter_extract_pages
      commit: b7c96963925fe08d4ef175b7d438c0017155807c
[6/6] block: convert bio_map_user_iov to use iov_iter_extract_pages
      commit: 36b61bb07963b13de4cc03a945aa25b9ffc7d003

Best regards,
-- 
Jens Axboe



