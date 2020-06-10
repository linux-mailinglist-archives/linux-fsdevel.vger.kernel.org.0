Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BFBC1F4A4E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jun 2020 02:11:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725948AbgFJAKp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Jun 2020 20:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbgFJAKn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Jun 2020 20:10:43 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B03FC05BD1E;
        Tue,  9 Jun 2020 17:10:43 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id c14so410529qka.11;
        Tue, 09 Jun 2020 17:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XFLCZdE5vvLdiZqFWAjPf5wwSUfiIU/6H0OECncmJWY=;
        b=DH9f/24yL7hrjzsDEOLLogDEMuNcGjw3g2xf9FJDwAwSBeIiDS2EjRpcJowMT4Q2mG
         hqcmY+idwS5s8ZPKI0hkCh0wBe9vx4QFsNLV5JUCKwBjrxHlncsQ0XiQCTUkFdBqH+v8
         ctkBHHUz9K9TMJqMt3mDlUHxBg+oR+32DTv360E70nJ9DAV2o5+STSds/FnTN4Pu2CIm
         7712HDNJuNo59JvyrNwVE3hynng2GHDOx3LS9nrcw+MNVz8XLUvo/24LcNqsXUrNuLi6
         Dx3K70+dPRHr5rYGAtH6swOXJUQzTQ6NrpS7/058ZNaJiQIbfssyqRV4ifiI4Ecruv2p
         yJvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XFLCZdE5vvLdiZqFWAjPf5wwSUfiIU/6H0OECncmJWY=;
        b=D26T40/xqoMw+wQNeyVWvNUn0iNMaR4BjtQ2talqF0wo81ZtupHgvAdSx1WgdeR2bT
         ccOyDhXoUuagE21lE1tzwdfT1bc/TsgFmH2df5QFt8bb1G+8ZBUZ/bJCqOhcCUY9ewYh
         pU7NS+mpOdo+yMDocGgHwciGSgDK6veOKo4QMJs2zKFwcD4IPATXuGgy+BNTarKVcEh4
         z7CGkal1zUVrn7/8ywPZCUb2n2mNtWKh+c7vv6I/fuUyDe0g6VxlaAtGAPmnaxYS8uZ2
         Om+AlvS6WyJjxYaGPdocrsMeQYUs0l4Ht4T9aZN1zvoJtEoNbiunL6QBWYYXlaxQYiOw
         mgTQ==
X-Gm-Message-State: AOAM530cAjFAKGNmhoFMTtaihitLz5MTR1kBvc4caY9ZeubZLsB/tUc1
        gFHhZ4Lv8FXzL9P/HqzxvKZBUzw=
X-Google-Smtp-Source: ABdhPJzsMjjBQX2I2CRruAFtRqgWtzvKsXzY5QaMLocolCxEE9yCB5Rt8Zlx1wd5tyDQ295jrJ1X5A==
X-Received: by 2002:a05:620a:21cc:: with SMTP id h12mr525346qka.194.1591747841673;
        Tue, 09 Jun 2020 17:10:41 -0700 (PDT)
Received: from moria.home.lan ([2601:19b:c500:a1:7285:c2ff:fed5:c918])
        by smtp.gmail.com with ESMTPSA id c2sm1757836qkl.58.2020.06.09.17.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 17:10:40 -0700 (PDT)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        viro@zeniv.linux.org.uk, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Cc:     Kent Overstreet <kent.overstreet@gmail.com>
Subject: [PATCH 0/2] generic_file_buffered_read() refactoring & optimization
Date:   Tue,  9 Jun 2020 20:10:34 -0400
Message-Id: <20200610001036.3904844-1-kent.overstreet@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is a small patch series that's been in the bcachefs tree for awhile.

In the buffered read path, we look up a page in the page cache, then copy from
that page in a loop - i.e. mixing the data copies in between looking up each
individual page. When we're doing large reads from the page cache, this is some
pretty major overhead.

This just reworks generic_file_buffered_read() to use find_get_pages_contig()
and work on an array of pages. It's a pretty significant performance
improvement for large buffered reads, and doesn't regress performance on single
page reads.

As a bonus, generic_file_buffered_read() gets broken up into multiple functions
that are _somewhat_ easier to follow.

Kent Overstreet (2):
  fs: Break generic_file_buffered_read up into multiple functions
  fs: generic_file_buffered_read() now uses find_get_pages_contig

 mm/filemap.c | 486 +++++++++++++++++++++++++++++----------------------
 1 file changed, 273 insertions(+), 213 deletions(-)

-- 
2.27.0

