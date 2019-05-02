Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 384A211202
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2019 06:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725536AbfEBEDx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 May 2019 00:03:53 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:37379 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbfEBEDw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 May 2019 00:03:52 -0400
Received: by mail-qt1-f202.google.com with SMTP id o17so952348qtf.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 May 2019 21:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=7D6rluj2jPKwp8SrdptWjaLF0tMG7juzLeBXeCItIG0=;
        b=UGi7INU3LhReJsI9u+UhWXXhw8zPILk6dgA5DjX56l2wrtmJXqz/MpYMbwHpyFUwL1
         Y5HjPibbMXwDKBImEE4yLTaUtX46ACIIgglCrNS9wajNdk+1mDMxL3x51mll41tK1lQ4
         iV3PpnxGQeC68NshlaRfrLAYUAP01MFxvfWDU9tb3GBBOYGKmUyLqqghHEaDQLdieu+F
         GRT/aTRR49h77tQHdl8zGWBZzWSvrPH8zCQTXTguP4hRFzcMSi3U+hjBcgfAeZVCW5EY
         mrc4E8SaAQPe1gACtttmeaNgwVoAGhIPJXRsmnfTzSykGOSWBNfFv5QH8GWb3dSF2eob
         hMAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=7D6rluj2jPKwp8SrdptWjaLF0tMG7juzLeBXeCItIG0=;
        b=RV5VrJhvSD27GI4wubiEvA5/s8M2hxdV1NJbjONb9Zp/mGcHXOxNgsJvYqb146owaV
         BiGUhkELB3mlbKm8CEG/Ftv3ZoYaoOgzxHPP6ki+yFT46d9lSkG9UaMPHVHvpAVEPkJn
         xvoZZD4E2YIHYlRjvxl6czCra3hxSuD6Qr8G+8avRD85Tj8m+dHOaHp1mBnT/2fMy5qN
         G1QcWGrZA1rj7xhQzX7+Ur/lF16/+N/bLcLmU0Pg79bpc8Q3LPlkBRpkHbava2ojQSbG
         wKIj11tadOexW6dA+x6xBilL6oqa3nJ4DfoM0EWBFuiXcZRVBq7XSJBu6uPGhtiDqeWt
         pErg==
X-Gm-Message-State: APjAAAUqUeZIbf/rSGU31zzi9MEKfp0Yua/gLmOj3wPmWO9wf7QPhA89
        uTg3SMP4bkS+WH9/53TETqsBqPlOB7G2D9dM44DJZ1l5JTTXg1ZgEJdA0jdsXnnAzLoB1o6JThZ
        uPc7aLsCYfIeiysCYMh0nX1z//HjIqP0joS7a2DLsL1aKSqd22qLKBrRtSYRdJ4aJ3Zfrcd9M9G
        Y=
X-Google-Smtp-Source: APXvYqzFqg2yNUiah8169N3NW2zEH0OZhL8CdL6TGuipRd8arnK1rd1sXkYq7hZgDRBz8gndnC3hXn1RGjgQBQ==
X-Received: by 2002:ac8:309d:: with SMTP id v29mr1428785qta.195.1556769831831;
 Wed, 01 May 2019 21:03:51 -0700 (PDT)
Date:   Wed,  1 May 2019 21:03:25 -0700
Message-Id: <20190502040331.81196-1-ezemtsov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.593.g511ec345e18-goog
Subject: Initial patches for Incremental FS
From:   ezemtsov@google.com
To:     linux-fsdevel@vger.kernel.org, ezemtsov@google.com
Cc:     tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi All,

Please take a look at Incremental FS.

Incremental FS is special-purpose Linux virtual file system that allows
execution of a program while its binary and resource files are still being
lazily downloaded over the network, USB etc. It is focused on incremental
delivery for a small number (under 100) of big files (more than 10 megabyte=
s each).
Incremental FS doesn=E2=80=99t allow direct writes into files and, once loa=
ded, file
content never changes. Incremental FS doesn=E2=80=99t use a block device, i=
nstead it
saves data into a backing file located on a regular file-system.

What=E2=80=99s it for?

It allows running big Android apps before their binaries and resources are
fully loaded to an Android device. If an app reads something not loaded yet=
,
it needs to wait for the data block to be fetched, but in most cases hot bl=
ocks
can be loaded in advance and apps can run smoothly and almost instantly.

More details can be found in Documentation/filesystems/incremental.fs

Coming up next:
[PATCH 1/6] incfs: Add first files of incrementalfs
[PATCH 2/6] incfs: Backing file format
[PATCH 3/6] incfs: Management of in-memory FS data structures
[PATCH 4/6] incfs: Integration with VFS layer
[PATCH 5/6] incfs: sample data loader for incremental-fs
[PATCH 6/6] incfs: Integration tests for incremental-fs

Thanks,
Eugene.

