Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F06B76BBB47
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Mar 2023 18:48:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232648AbjCORsX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Mar 2023 13:48:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232646AbjCORr4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Mar 2023 13:47:56 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBF0E95E0F
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Mar 2023 10:47:41 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id f14so8175317iow.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Mar 2023 10:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1678902435; x=1681494435;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+lxfpdXXZwd5ObmwIUKYTvInLkSnJ3rTmk1dwfXuWn8=;
        b=j9zqC407ORD8JyCqubo5WPcomiRwRsgSCSSitJearydehrdb9JmZmX1rrAPvBarmDI
         APa7Mmkn0oYxgQl+hDgaAbnSf1Gfotr9lsBCqg8+KunkhVpQTNRE9c+Uc3o2y6Ki54zD
         9yMtnupZGdSKcH0Dh42IsgTI+f7K+gAsNZDJKHxvwoc1mgNszsufVoss9y9Kb4Yl/flK
         D4iOTC3S3GCxDs7oxdJdi9FhFA4/jU9D4EQfXvzEw8R69jZgFe/xYPMY61r9C9vHLDXf
         1+2m2A4MHtceKufCfJX4QnOXmFmWiTHIUgAOGbWOZZ7UtXPxRIvFDXRRYFhktW4goBQ8
         8Isg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678902435; x=1681494435;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+lxfpdXXZwd5ObmwIUKYTvInLkSnJ3rTmk1dwfXuWn8=;
        b=z8Qb0FARdCdaIgxrB93VlhxDKxVPBU5i7d3BCZUK27/z4tiZ+duavoCfH3iv25xLXb
         JTM/XP3AKHkUTpqG7CkapzYYy0S7qUY6xN7xuiSlmU7/ZVK/h0SFAVtsMRb5qTfflLkw
         TryxfptFcOxFWTRE/B5YCxL3gwnuw5KLAxuTgT34Wxrcn6Bpa+k7qkAkuuWQbw67IOXz
         nYGfEcemOEo01jro8TseY24KYz+ToLo8zqmFXW9OK6N5vzRHq07iCcr60mvv8O4wMzqf
         vTPcZPBoEy+JV09YidL930MaKe1x2KrLv2HIUIwFkvURgwec0Zijj9a2fObZJP8p04c9
         zt6g==
X-Gm-Message-State: AO0yUKWD80pAXsQim8m6dWI4loNWMWdWqeZjw4796qJGXQAC64K1eKvR
        wgBrLWNo+i/7/MpgLCKJCJozxw==
X-Google-Smtp-Source: AK7set8NaGAjOIa8kTwZzEhvCzFYesiBzdjCmPGndPULiKBjmur+M8FpGX8hzACaLs458oHc/KbObQ==
X-Received: by 2002:a6b:3c0a:0:b0:719:6a2:99d8 with SMTP id k10-20020a6b3c0a000000b0071906a299d8mr1919987iob.0.1678902435147;
        Wed, 15 Mar 2023 10:47:15 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id r14-20020a6b440e000000b00740710c0a65sm1811816ioa.47.2023.03.15.10.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 10:47:14 -0700 (PDT)
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
In-Reply-To: <20230315163549.295454-1-dhowells@redhat.com>
References: <20230315163549.295454-1-dhowells@redhat.com>
Subject: Re: [PATCH v19 00/15] splice, block: Use page pinning and kill
 ITER_PIPE
Message-Id: <167890243414.54517.7660243890362126266.b4-ty@kernel.dk>
Date:   Wed, 15 Mar 2023 11:47:14 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-2eb1a
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On Wed, 15 Mar 2023 16:35:34 +0000, David Howells wrote:
> The first half of this patchset kills off ITER_PIPE to avoid a race between
> truncate, iov_iter_revert() on the pipe and an as-yet incomplete DMA to a
> bio with unpinned/unref'ed pages from an O_DIRECT splice read.  This causes
> memory corruption[2].  Instead, we use filemap_splice_read(), which invokes
> the buffered file reading code and splices from the pagecache into the
> pipe; direct_splice_read(), which bulk-allocates a buffer, reads into it
> and then pushes the filled pages into the pipe; or handle it in
> filesystem-specific code.
> 
> [...]

Applied, thanks!

[01/15] splice: Clean up direct_splice_read() a bit
        commit: d187b44bc9404581bad8d006d80937d1b3a2b0c0
[02/15] splice: Make do_splice_to() generic and export it
        commit: 6dc39c2949ee71ee9996d6190d374512ecf44982
[03/15] shmem: Implement splice-read
        commit: b81d7b89beccbeebe347c21c004665ffe07e36bb
[04/15] overlayfs: Implement splice-read
        commit: f39de7bd1b5088241f0580b5fe5d76cc5569711f
[05/15] coda: Implement splice-read
        commit: f0daac2d4dcd286168d7c70d0495328c096d4d96
[06/15] tty, proc, kernfs, random: Use direct_splice_read()
        commit: 82ab8404c910d4aba33f55257c2bbc8ea9cfad3c
[07/15] splice: Do splice read from a file without using ITER_PIPE
        commit: 3eb3c59b128509a5e8a8349dafced64b9769438e
[08/15] cifs: Use generic_file_splice_read()
        commit: fa9a848ded4984a8c64d0d20c3a5b0aab97c7754
[09/15] iov_iter: Kill ITER_PIPE
        commit: a53f5dee3448a51e6602a7f98952abaf19049641
[10/15] iomap: Don't get an reference on ZERO_PAGE for direct I/O block zeroing
        commit: 2102c4e41418fb5c2cdf26bf2b97922190e38ba2
[11/15] block: Fix bio_flagged() so that gcc can better optimise it
        commit: caf8aae59a7b1f668a32f91115ed8be3aebaaa41
[12/15] block: Replace BIO_NO_PAGE_REF with BIO_PAGE_REFFED with inverted logic
        commit: e812d15adde4363c95f1743b7dd4946f1a550c5c
[13/15] block: Add BIO_PAGE_PINNED and associated infrastructure
        commit: b5596bf292996a5cd62f1fbc00c2c35f1a3faa12
[14/15] block: Convert bio_iov_iter_get_pages to use iov_iter_extract_pages
        commit: 648627d7077d4de810e5f4c09490cb993514a53f
[15/15] block: convert bio_map_user_iov to use iov_iter_extract_pages
        commit: d187b44bc9404581bad8d006d80937d1b3a2b0c0

Best regards,
-- 
Jens Axboe



