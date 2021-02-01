Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A465430B3B0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Feb 2021 00:50:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbhBAXuU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Feb 2021 18:50:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbhBAXuL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Feb 2021 18:50:11 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C46E4C061573
        for <linux-fsdevel@vger.kernel.org>; Mon,  1 Feb 2021 15:49:31 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id t25so8032769otc.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Feb 2021 15:49:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=QlEj9g1yIeS16VhziCvptdvmC8+1zoXl7jigFBelNxE=;
        b=TVZTxErCt7V8fJg50gPtkN3JaWEOBIeqO+58QOHNY45kPHJm/N+wlxXF4EqxO2Y7oJ
         j/GIVhCQ5Hq7ghAanzx/lYbmWNDHOqpI5RRCcMgUyQulGuG+DfrQuh6L+1DN6mvCPVAI
         SmnkC/2RP8F8JrBZnzYYv5RThbxf+6a6sc6099A9PMDD/RJubB2x6WHvc9bJ4fnxeYZx
         IT7l2Y2kE9BL5wFjawK5WxBndUzVm3qhA4HI7Xqm2Sr4EUzTI89CudqS25THj1BHG94E
         /HnvOHzNWCxl48G1iruylPwnb2Ij+RGiLxNKvV1xS5fasoFCZ1bXNwMjw3jieIRy7Zw5
         7TZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=QlEj9g1yIeS16VhziCvptdvmC8+1zoXl7jigFBelNxE=;
        b=SzbqsBAFJoRRBYXLXrFEeXyYarBCF79rlVufEnAN5Vt38htwWvbIUXfeJMHwpSPWc5
         2GRbbv8fBsze+f533thl5xXclWUIrppkk8mkoZNBY3D9xy/nhnTlhYxZ8FKDijvzfkNm
         FCViBJr/0zHNOYVK6lfvSIf+IvKWSi2GmsNbCHIQVA/BCFglZppghGbYB2iloV3K6SRs
         CQS+3OckUo1fVOawbbBVQQLXXjcQkTbNJ0Y9UeZt5QMakHz93+kTHiCESCwzT/ld1+vA
         lMelQJJd7Y6yXFL1BmDVWuFYy23QczqZ3jhY1ilqUhAKTKMYXiQ4ZdRzZV/35ajIj6oX
         jvAA==
X-Gm-Message-State: AOAM531y6+N/Vp+LTqTBDkU/g+yMF0FkymwK0JWbhLqpsMxhz4BrJEA8
        wNirFvGV5p4P7en/EOaCj1Op/E4CnviIZQ4PpNcPvTLvW8v1fw==
X-Google-Smtp-Source: ABdhPJw5f0RhC+SlCveeyvKZjJ1ESANeMhmHqffri762j/S1oQlLZpZ18fgai+/HvOQdNN0GMF36uPwA5PtJi6aOSDo=
X-Received: by 2002:a05:6830:15c5:: with SMTP id j5mr13486151otr.185.1612223371122;
 Mon, 01 Feb 2021 15:49:31 -0800 (PST)
MIME-Version: 1.0
From:   Amy Parker <enbyamy@gmail.com>
Date:   Mon, 1 Feb 2021 15:49:20 -0800
Message-ID: <CAE1WUT63RUz0r2LaJZ7hvayzfLadEdsZjymg8UYU481de+6wLA@mail.gmail.com>
Subject: Using bit shifts for VXFS file modes
To:     linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello filesystem developers!

I was scouting through the FreeVXFS code, when I came across this in
fs/freevxfs/vxfs.h:

enum vxfs_mode {
        VXFS_ISUID = 0x00000800, /* setuid */
        VXFS_ISGID = 0x00000400, /* setgid */
        VXFS_ISVTX = 0x00000200, /* sticky bit */
        VXFS_IREAD = 0x00000100, /* read */
        VXFS_IWRITE = 0x00000080, /* write */
        VXFS_IEXEC = 0x00000040, /* exec */

Especially in an expanded form like this, these are ugly to read, and
a pain to work with.

An example of potentially a better method, from fs/dax.c:

#define DAX_SHIFT (4)
#define DAX_LOCKED (1UL << 0)
#define DAX_PMD (1UL << 1)
#define DAX_ZERO_PAGE (1UL << 2)
#define DAX_EMPTY (1UL << 3)

Pardon the space condensation - my email client is not functioning properly.

Anyways, I believe using bit shifts to represent different file modes
would be a much better idea - no runtime penalty as they get
calculated into constants at compile time, and significantly easier
for the average user to read.

Any thoughts on this?

Best regards,
Amy Parker
(she/her/hers)
