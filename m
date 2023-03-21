Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ADC76C3C44
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Mar 2023 21:54:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbjCUUyl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Mar 2023 16:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbjCUUyk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Mar 2023 16:54:40 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A51053D9C;
        Tue, 21 Mar 2023 13:54:39 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id l27so6733513wrb.2;
        Tue, 21 Mar 2023 13:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679432078;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=36n+db1kX7z8fa60FDrINMxCjVwayNeaAfJ4998fhB0=;
        b=lKekWqTEnnL9WUbfLF6H6trNCIZVnKpoynvj8BOFaOFif9U+k8BNOn32nJAcmuAw0H
         mpipoVpLX16cSa4bmq8xfUuoVbuv3RzPUTkQPtGrVfif9+nnspnDj8dZoVItgxXN+rLs
         9W7acderdn4iMA6Dp4izlt8belJXPdrexPiHxUlWVYL+ecJe5625kcdoMeFgNtZlNrXs
         0yTi0d50npI72KPQAIwKaCBCgC0mwbr16XYFIa6Da2FD66g/gC34amQHguPdkz4zieUu
         Uvdu4ZNAGAqTC+FJpZoPi7bt/evaoYATfdP/cpobMwwA0vjT35vIWSKi4p641rmvEp+i
         /G3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679432078;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=36n+db1kX7z8fa60FDrINMxCjVwayNeaAfJ4998fhB0=;
        b=nW19dGFjqWaHZwt/RVOCxQdHoxtoFTzBijQkpPpW9XmAwa+IjRp77IEznPnoCzb0Pg
         ApayVO0+K4HL8cRj9Jq6nMJ5443Zhdu/55YsHdjIpnei5ggC6WoKQxFW9P/reg2bma1Z
         +rTTbkSybtV6eDIMdIiAO8Ih8GvB6jcHETOatTBVDoqQvQH0ZvB2VdrCTrh7Lie8SNx0
         Ub982f+kTRdq9veZrz7XqaLMEjewu1WYKIpvz+FVN7DsJ6euPuP+LI3VA8GfAsZRJL31
         eVTaqvu8sa6TYFzjc2Hi+SwI5tt63H3vKadnuZWNzjuynDCzEUAfiS4N5CLq4bxPWvmm
         sRPQ==
X-Gm-Message-State: AO0yUKUxjOUbnPurvqFed21BwC5XnVVQVvDi4lzp1o1wKskALNxRSMqj
        c2jdfWHDKSpPi1sbCRhZ9jI=
X-Google-Smtp-Source: AK7set/Sxj5SUVNX9MbVtbcFGvxNSLhcd0e+8lJ/DDA0/rA2xAijgYqmzqynBDmqpErowI5PCT3qmw==
X-Received: by 2002:adf:d4c5:0:b0:2cf:f3ea:533e with SMTP id w5-20020adfd4c5000000b002cff3ea533emr3778783wrk.63.1679432077719;
        Tue, 21 Mar 2023 13:54:37 -0700 (PDT)
Received: from lucifer.home (host86-146-209-214.range86-146.btcentralplus.com. [86.146.209.214])
        by smtp.googlemail.com with ESMTPSA id a8-20020a056000100800b002d8566128e5sm3744575wrx.25.2023.03.21.13.54.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 13:54:36 -0700 (PDT)
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Baoquan He <bhe@redhat.com>, Uladzislau Rezki <urezki@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Jiri Olsa <jolsa@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Lorenzo Stoakes <lstoakes@gmail.com>
Subject: [PATCH v4 0/4] convert read_kcore(), vread() to use iterators
Date:   Tue, 21 Mar 2023 20:54:29 +0000
Message-Id: <cover.1679431886.git.lstoakes@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

While reviewing Baoquan's recent changes to permit vread() access to
vm_map_ram regions of vmalloc allocations, Willy pointed out [1] that it
would be nice to refactor vread() as a whole, since its only user is
read_kcore() and the existing form of vread() necessitates the use of a
bounce buffer.

This patch series does exactly that, as well as adjusting how we read the
kernel text section to avoid the use of a bounce buffer in this case as
well.

This has been tested against the test case which motivated Baoquan's
changes in the first place [2] which continues to function correctly, as do
the vmalloc self tests.

[1] https://lore.kernel.org/all/Y8WfDSRkc%2FOHP3oD@casper.infradead.org/
[2] https://lore.kernel.org/all/87ilk6gos2.fsf@oracle.com/T/#u

v4:
- Fixup mistake in email client which orphaned patch emails from the
  cover letter.

v3:
- Revert introduction of mutex/rwsem in vmalloc
- Introduce copy_page_to_iter_atomic() iovec function
- Update vread_iter() and descendent functions to use only this
- Fault in user pages before calling vread_iter()
- Use const char* in vread_iter() and descendent functions
- Updated commit messages based on feedback
- Extend vread functions to always check how many bytes we could copy. If
  at any stage we are unable to copy/zero, abort and return the number of
  bytes we did copy.
https://lore.kernel.org/all/cover.1679354384.git.lstoakes@gmail.com/

v2:
- Fix ordering of vread_iter() parameters
- Fix nommu vread() -> vread_iter()
https://lore.kernel.org/all/cover.1679209395.git.lstoakes@gmail.com/

v1:
https://lore.kernel.org/all/cover.1679183626.git.lstoakes@gmail.com/


Lorenzo Stoakes (4):
  fs/proc/kcore: avoid bounce buffer for ktext data
  fs/proc/kcore: convert read_kcore() to read_kcore_iter()
  iov_iter: add copy_page_to_iter_atomic()
  mm: vmalloc: convert vread() to vread_iter()

 fs/proc/kcore.c         |  89 ++++++---------
 include/linux/uio.h     |   2 +
 include/linux/vmalloc.h |   3 +-
 lib/iov_iter.c          |  28 +++++
 mm/nommu.c              |  10 +-
 mm/vmalloc.c            | 234 +++++++++++++++++++++++++---------------
 6 files changed, 218 insertions(+), 148 deletions(-)

--
2.39.2
