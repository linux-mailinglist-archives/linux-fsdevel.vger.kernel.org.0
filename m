Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9BC130DF7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2020 08:25:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbgAFHZW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Jan 2020 02:25:22 -0500
Received: from mail-wm1-f45.google.com ([209.85.128.45]:50551 "EHLO
        mail-wm1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726488AbgAFHZV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Jan 2020 02:25:21 -0500
Received: by mail-wm1-f45.google.com with SMTP id a5so14006990wmb.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 05 Jan 2020 23:25:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=Udr2VC/34D/ej3jNtnHKlwamBndRUt0c7YEySUS9AYk=;
        b=tegvSo1+pMilhE+TKyGCXpLfcr2ODsbxMl4yqS/RBIwjBmObGk5V7Hyd0urVNdFLnB
         yQ73s0FwM6SUJrkJlTTktD3/gtYciOXhdbQWvGSAFbHeYV28hL9nWgYcRlLJVwA7V4Ro
         XIzEtrlAvMe8SU1nDN+TTLbUF9Jv0kAOBK0uf/WcqRhLHdJ3fnm1fjNH6IyVV5j37ZbH
         IKnvFgpKB6Jb0ecXrjOMc/VuDJYeK+wVNks/6U28GleSvOVoiCQoCkJE0zVT0+/F2KCf
         vR1AMHYqjumz2LALhQKob6jv4FkpAgGZhJFj1Nk0OnebgUqh9J53aiYkKIkRc7RTq7NA
         sxGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=Udr2VC/34D/ej3jNtnHKlwamBndRUt0c7YEySUS9AYk=;
        b=O9PWUQryuvaS48G9091RbMGvTBQPWArAF+h5cylRX8L3cfPBEpMW28Qk33fTg+8pZz
         YJjYG/hYXGb/2G36l/xEW7DfvSmSdaWZ/FyNACbOC8CW+1dVbhqxZaKek9o9myqpppvW
         GmiZCVckdpcXdZQPLN3jmvkSTjJkH4eplPnTzvTSODkoPnaLAmXy88/NgvaHTSvnvDax
         aIgbzsYxdKnczy7csOh5XlBInouWrV9/5MO1/BJ16qW46qq/G1siQDq3rkEG6SfK8l7I
         lzEW3CPZBr1FuJZRGje6M0NSW/N72ZWVFH7ZZhIUWuatNcr9rzhrNJeY+SgQ2araIeWQ
         8h2A==
X-Gm-Message-State: APjAAAVIqXh9x/9QZtYZfkCpSvXnHT+J8E16/1CYhlXk6Fj/FtAoFNnj
        IhIL5sZyWEfEPGIJAqFmMLP/BwlKhQNYTfz+VPAcs+xP
X-Google-Smtp-Source: APXvYqzMJzPVQb+2OubA1+n6rTS2XW/hj8N9D8QR/FDNAtBI9HFXoweWM3Vp0FVaLWgqUQHcuPVmsDt/qrVp2/AGKsY=
X-Received: by 2002:a1c:3d07:: with SMTP id k7mr34811380wma.79.1578295519286;
 Sun, 05 Jan 2020 23:25:19 -0800 (PST)
MIME-Version: 1.0
From:   Sitsofe Wheeler <sitsofe@gmail.com>
Date:   Mon, 6 Jan 2020 07:24:53 +0000
Message-ID: <CALjAwxi3ZpRZLS9QaGfAqwAVST0Biyj_p-b22f=iq_ns4ZQyiA@mail.gmail.com>
Subject: Questions about filesystems from SQLite author presentation
To:     linux-fsdevel@vger.kernel.org
Cc:     drh@sqlite.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

At Linux Plumbers 2019 Dr Richard Hipp presented a talk about SQLite
(https://youtu.be/-oP2BOsMpdo?t=5525 ). One of the slides was titled
"Things to discuss"
(https://sqlite.org/lpc2019/doc/trunk/slides/sqlite-intro.html/#6 )
and had a few questions:

1. Reliable ways to discover detailed filesystem properties
2. fbarrier()
3. Notify the OS about unused regions in the database file

For 1. I think Jan Kara said that supporting it was undesirable for
details like just how much additional fsync were needed due to
competing constraints (https://youtu.be/-oP2BOsMpdo?t=6063 ). Someone
mentioned there was a
patch for fsinfo to discover if you were on a network filesystem
(https://www.youtube.com/watch?v=-oP2BOsMpdo&feature=youtu.be&t=5525
)...
For 2. there was a talk by MySQL dev Sergei Golubchik (
https://youtu.be/-oP2BOsMpdo?t=1219 ) talking about how barriers had
been taken out and was there a replacement. In
https://youtu.be/-oP2BOsMpdo?t=1731 Chris Mason(?) seems to suggest
that the desired effect could be achieved with io_uring chaining.
For 3. it sounded like Jan Kara was saying there wasn't anything at
the moment (hypothetically you could introduce a call that marked the
extents as "unwritten" but it doesn't sound like you can do that
today) and even if you wanted to use something like TRIM it wouldn't
be worth it unless you were trimming a large (gigabytes) amount of
data (https://youtu.be/-oP2BOsMpdo?t=6330 ).

However, there were even more questions in the briefing paper
(https://sqlite.org/lpc2019/doc/trunk/briefing.md and search for '?')
that couldn't be asked due to limited time. Does anyone know the
answer to the extended questions and whether the the above is right
deduction for the questions that were asked?

-- 
Sitsofe | http://sucs.org/~sits/
