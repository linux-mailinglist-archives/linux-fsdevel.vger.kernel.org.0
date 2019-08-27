Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0FBD9F2FB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2019 21:11:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730262AbfH0TLN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Aug 2019 15:11:13 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:46407 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728972AbfH0TLM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Aug 2019 15:11:12 -0400
Received: from mail-oi1-f200.google.com ([209.85.167.200])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <dann.frazier@canonical.com>)
        id 1i2gs2-0005Ee-LX
        for linux-fsdevel@vger.kernel.org; Tue, 27 Aug 2019 19:11:10 +0000
Received: by mail-oi1-f200.google.com with SMTP id s3so7389924oia.19
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Aug 2019 12:11:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=SjCk7qlDgWR4oNSO62cHvek4iHiNDzd95pZ8kBnxv7o=;
        b=ee2OoMST0YSX36qPA6PE4o2z24gLM+vQI/IbuOwnlukvSdX01346T30tmSuALz0V7c
         Rxuv3UcxUKq6x+HZe62yQfcnLyq1u3OUYg2JcTM9aU7BWG+n/hdRGHae1PITDu2RBF98
         oGZRoqBW+5T0sV5c5OJ3ekvF/G4IYNrSLaagK9XBpT8zS4uAK2Q+6waaxWbAYryySN0A
         ov6qP5NC8oSHd2OaJ062lWqQB4JgTObdXy5KPbus2NH8KjW9I39wjKKWnbymvrbMNVXp
         9E3c1pIn27bHQrppWNI2EyoXZRQ/3sFm2KIfaFclWjxJA1oslZLjK/0aG9MMpXa1KRuR
         BDLA==
X-Gm-Message-State: APjAAAWblCbVhw560RZ67UG/bUwVlMGF0dkv91HQbJ6sud6Uur+k613o
        nD4mBpG52iR7D1ZzveiXyWJ6I6cNnqvCezDd0fky2b2kl4K9I05fg0oMj7lvoGaYtGR+2dHhMiO
        Wj0S9jQ9AyUTxy7xgtY396zihxkaX7u9x0z/E5VNb4FhYFaEG1dQb77hVOJg=
X-Received: by 2002:aca:5f46:: with SMTP id t67mr199988oib.42.1566933069196;
        Tue, 27 Aug 2019 12:11:09 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwbP7F0llo6lb4f74MP8IAyd+qD0hM4P13sxRmlLdBA39Yeqmzb1rzJ4znSZos1XmJ9Ap11F+XNxWblOM7d6VY=
X-Received: by 2002:aca:5f46:: with SMTP id t67mr199961oib.42.1566933068789;
 Tue, 27 Aug 2019 12:11:08 -0700 (PDT)
MIME-Version: 1.0
From:   dann frazier <dann.frazier@canonical.com>
Date:   Tue, 27 Aug 2019 13:10:58 -0600
Message-ID: <CALdTtnuRqgZ=By1JQ0yJJYczUPxxYCWPkAey4BjBkmj77q7aaA@mail.gmail.com>
Subject: ext4 fsck vs. kernel recovery policy
To:     linux-fsdevel@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
        Jan Kara <jack@suse.com>
Cc:     Colin King <colin.king@canonical.com>,
        Ryan Harper <ryan.harper@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

hey,
  I'm curious if there's a policy about what types of unclean
shutdowns 'e2fsck -p' can recover, vs. what the kernel will
automatically recover on mount. We're seeing that unclean shutdowns w/
data=journal,journal_csum frequently result in invalid checksums that
causes the kernel to abort recovery, while 'e2fsck -p' resolves the
issue non-interactively.

Driver for this question is that some Ubuntu installs set fstab's
passno=0 for the root fs - which I'm told is based on the assumption
that both kernel & e2fsck -p have parity when it comes to automatic
recovery - that's obviously does not appear to be the case - but I
wanted to confirm whether or not that is by design.

  -dann
