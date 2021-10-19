Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF1B433BD0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Oct 2021 18:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233481AbhJSQOV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Oct 2021 12:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233463AbhJSQOU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Oct 2021 12:14:20 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E6F6C06161C
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Oct 2021 09:12:07 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id i189so21047527ioa.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Oct 2021 09:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=BIWUFrRMKGp0hlgWWgUXH8sUg0ZxvXookYdn3OXVDqc=;
        b=RNQff9dVmEDLoSXcW5IBXnvQQlhtur5i7XA8KSHKk7epCbL15kj2S6riqt+6oY/BMZ
         abzeLM2zUW6AVNZUsw54B8kR56Xa5fVghdOd6POzXN0fj1DPquHsFZDgPo/XXHA+ejN6
         5AkTNzoTo8DT1CP+2vYaU7mP5xjJhq/fHSL61cQAqEeMDODEpalVhUH60kV6mw4nZ2YQ
         fMOVdAs80s423xLYpISw9PjuZFJRbJMxgwB2yXXv3R/guacNgx7JYur66TY7dA0KUqDh
         pKiMR9k0JVkuQnZXlfMTq0GgvpYA4wYXFnI5maOvPawd5BQkQzwC9Rob6qahnVlqynIz
         UXdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=BIWUFrRMKGp0hlgWWgUXH8sUg0ZxvXookYdn3OXVDqc=;
        b=TWBD2jiTQW/uf/g6F/vME+WlbcQlJRXTUWGO6fnnoPG4oT5IEaZVTsnwKr5i61Hq+/
         /6e+Ztn/mjwrTdk/vN++dq3xRkEYL0hat4SgytWbVwlKyb5Qikz8IeVTo6v7hYJftNhR
         IQIm1tx+8uNnF2HjaGOMnCfgiPLfael219XmfVC8UK4845arhVl4yF43ciNl264vG2xc
         GqK9bHqACvV2mNvUShAYi7BGHenmv7iJ1QmS0VlwpbFBmxGDENKy0g5bM7Jdn8xRpDbN
         OUCxI1QP89Y3KaeGBBxldz9bMeVEBTmaW9LXY6t3DhdPJGQW9U47sXA1uMt+UcQwGv3T
         92Rw==
X-Gm-Message-State: AOAM530ymRZzUsCo8YPBTxA37386DZ33xHQ9PXKTO+jABU+Hth3jgdjX
        5zP+1AK4L9QmwbJbeWgnPPhcfreNBb7azQK+Mjes3AWGU9Y=
X-Google-Smtp-Source: ABdhPJydRbj+9La/NaG8HiZdNOkSjkPlLzHfrYhWW7HNoQm9depgjZdfKaOskVQRzr11AJJrwXGtYG19NU2HV2kau14=
X-Received: by 2002:a05:6638:39c:: with SMTP id y28mr4884039jap.47.1634659926772;
 Tue, 19 Oct 2021 09:12:06 -0700 (PDT)
MIME-Version: 1.0
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 19 Oct 2021 19:11:55 +0300
Message-ID: <CAOQ4uxiJrEOHyHeY49dLMaJ4-8=RCGc+oawyWPrkuP28NRsT3Q@mail.gmail.com>
Subject: [RFC] Optional FUSE flush-on-close
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Miklos,

We have a use case where fuse_sync_writes() is disruptive
to the workload.

Some applications, which are not under our control do
open(O_RDONLY);fstat();close() and are made to block waiting on writes
that they are not responsible for.

Looking at other network filesystems, cifs and nfs only flush on close
for FMODE_WRITE files.
Some older SMB flavors (smb1, smb2) do also flush on RDONLY files.

In particular, our FUSE filesystem does not even implement FLUSH
and it has writeback caching disabled, so the value of flush on close
is even more questionable.

Would you be willing to consider a patch that makes flush-on-close
behavior optional for RDONLY files?
If so, should I make this option available only when filesystem
does not implement FLUSH or independent?
Should I make an option to completely disable flush-on-close
(i.e. like most disk filesystems)?

Thanks,
Amir.
