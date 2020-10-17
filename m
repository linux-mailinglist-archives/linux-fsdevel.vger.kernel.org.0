Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFBB729143E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Oct 2020 22:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439692AbgJQULE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 17 Oct 2020 16:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439688AbgJQULE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 17 Oct 2020 16:11:04 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A4E6C061755;
        Sat, 17 Oct 2020 13:11:04 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id q9so8250878iow.6;
        Sat, 17 Oct 2020 13:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PD5epUb/EZWtl+iEKstEUTgpv3g/Q5MUxAonVyQITN4=;
        b=TBHfeIb/+RA8PlzGusuS5N+TtLo1A6If92F/tA6aQmMFf5BskXxxNqV5Ju0xRPRR6w
         qoThI8TbAToZgUA33wOTRyVKoGdzLrsribkySiPBZUA6DsHGULjxlRNqK1mTq+lFAFQz
         /fu4DHa6EEyZoltGqbyFicMeHe9lPjr7FvL4mbEM9uDZurByZBDhQ2EnMiag7KmPRWD4
         QdPOsZmJKFgCJtq8DYEHhBd/tOVHVFKnyVb/5Q6ix3watIUYb7lKhMmNCe+ofLcTYbeu
         OBcAi4beIvGLqV6ruWFfRmY7N3DI0j7Nn8uf/eFVk5JKqQ6Me0Gn4HL6ohNH/Xdp1cgF
         vWlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PD5epUb/EZWtl+iEKstEUTgpv3g/Q5MUxAonVyQITN4=;
        b=gvJkmCPRZXwO4TcabztHDFM9QOiG07ptVuSYAuBmQUxATfwIoKqwSUqib19S4g9Oxk
         WOJe8CfapDl1HlkYhvC98/I0dWwfkpNzT69QBGCPHKvsZ7VIwLH5jhBBm4qaWlY3m3N9
         681bhyQqQkOf5vG7Pet7h4JTgDU28/0JDmfg93UZEUOBIa0MMk+Ho1ogiZcUbItwsavx
         wvUSigx955xkZoxOJ1NS/INxsdYpMj26J10jrQv+Lh6bukaEEZ+woM5SUGeRM8TTZtnM
         DfVIt4RDGWcUXsMdMC+qoEcJ4PF1CgpHClUFPYZNHLMdjj92jeJKETfAuUWYDsDvqJjh
         disQ==
X-Gm-Message-State: AOAM533q/Whpo3Y9nCPwCww5P+BZje9snhRfp67s4vjVCS8r5eILLTx/
        E3qZ3X6HFa4+THVKRY5oynBorIwnFA==
X-Google-Smtp-Source: ABdhPJyBa1CV3I9/TT+8bGPPR13VvvQT+GbeALryn9+U5nIPgMHNz+Uo/1QuA13o3ySkvSShvaydGQ==
X-Received: by 2002:a6b:4e0b:: with SMTP id c11mr6345201iob.68.1602965463098;
        Sat, 17 Oct 2020 13:11:03 -0700 (PDT)
Received: from zaphod.evilpiepirate.org ([2601:19b:c500:a1:d1eb:cfce:9b0b:f9e0])
        by smtp.gmail.com with ESMTPSA id e204sm5583483iof.16.2020.10.17.13.11.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2020 13:11:02 -0700 (PDT)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        akpm@linux-foundation.org
Cc:     Kent Overstreet <kent.overstreet@gmail.com>, willy@infradead.org
Subject: [PATCH 0/2] generic_file_buffered_read() refactoring, perf improvements
Date:   Sat, 17 Oct 2020 16:10:53 -0400
Message-Id: <20201017201055.2216969-1-kent.overstreet@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Rebased this patchset onto 5.9, I'd like to finally get this because
generic_file_buffered_read() has turned into a real monstrosity to work with.
And it's a major performance improvement, for both small random and large
sequential reads. On my test box, 4k buffered random reads go from ~150k to
~250k iops, and the improvements to big sequential reads are even bigger.

This incorporates the fix for IOCB_WAITQ handling that Jens just posted as well,
also factors out lock_page_for_iocb() to improve handling of the various iocb
flags.

Kent Overstreet (2):
  fs: Break generic_file_buffered_read up into multiple functions
  fs: generic_file_buffered_read() now uses find_get_pages_contig

 mm/filemap.c | 563 ++++++++++++++++++++++++++++++---------------------
 1 file changed, 328 insertions(+), 235 deletions(-)

-- 
2.28.0

