Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1C87BF7D1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2019 19:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727751AbfIZRqP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Sep 2019 13:46:15 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35286 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727707AbfIZRqO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Sep 2019 13:46:14 -0400
Received: by mail-pf1-f194.google.com with SMTP id 205so2259206pfw.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Sep 2019 10:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=flT9fBZ3P9UgjuIhDnrmFe1JBs07Z3/pZQTsLWyd9cQ=;
        b=hEt+uhNndXeewILcwlsE0TLOnrSKZMugFJU1eiZSqB+9MpBdP1TNUXRaQk4MKDMVZe
         l+iETQcCMKckv0by/kdrKrx5vgnqqAZ1eY2VCLlixwoZVvUIevQPtFgpPcp5qEmvG9OS
         zr+j9hKna+ZSWp20G79kebYIopAXtWbAlN3lMtavfj1eybsIK1XWtGc03ZQVYq+IDa28
         oPZAIzblukGGNl7tqEemMXQE1FkI8q8Lq16TRLnolZXgKovKmHQ7pBZ0LidOlaMomb8A
         UqgkOIbb/y/meCLWSxqb6JZPpJNWCfx9mCbOGGOlqZr5XT+7vjocl5+tG5ronTksUcpp
         GwDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=flT9fBZ3P9UgjuIhDnrmFe1JBs07Z3/pZQTsLWyd9cQ=;
        b=hE0VPZctYSUAwrnd1sUXsQ2bFbUfrS/HfZt4YqbyQ7JgHNTkSjrBbh4K7Tn6mf9sRl
         YlfTNyXbihBEnLH22lP6TlJuz7k3QM/pa5ohgoQKrPvpcRXqhcqPxFWje3ZnjF6iTPfH
         0NaPFlBsH3xIGiKg75GJUkT/TrHxCeL8i34aoI+kAOWgcb9wztaiwybpf5tKmAjTQgJJ
         0qRWprlRndUYUlCyvsAdb5BB6fImMEYuFWvP+IXi7dmBDQMBFc/n8Lk13G3ta5Cta/WK
         RYtQIvOf203AEFONtvf6HQfZZ83uyQQF77XywxWIu1ebLZwqG6Zb1uINkzdctZKy6kbP
         ggsw==
X-Gm-Message-State: APjAAAVIZ46d0zH4zgLlc8fn3s4f84EKU7cD9IRYT1vSWGqGIWV0bEta
        njjZlJjY/ZR0WO3hYghZ5tphWw==
X-Google-Smtp-Source: APXvYqwikFaK5XBjZGwGMstfgfcvJbjtYSKlxkonOjE0aRskm6PvRu3wUykQUKZN0mIO/lfXIu2qNA==
X-Received: by 2002:a17:90a:3748:: with SMTP id u66mr4906667pjb.4.1569519973085;
        Thu, 26 Sep 2019 10:46:13 -0700 (PDT)
Received: from vader ([2620:10d:c090:200::e132])
        by smtp.gmail.com with ESMTPSA id w189sm3852504pfw.101.2019.09.26.10.46.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2019 10:46:12 -0700 (PDT)
Date:   Thu, 26 Sep 2019 10:46:09 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Colin Walters <walters@verbum.org>
Cc:     Chris Mason <clm@fb.com>, Dave Chinner <david@fromorbit.com>,
        Jann Horn <jannh@google.com>, Aleksa Sarai <cyphar@cyphar.com>,
        Jens Axboe <axboe@kernel.dk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [RFC PATCH 2/3] add RWF_ENCODED for writing compressed data
Message-ID: <20190926174609.GA18238@vader>
References: <cover.1568875700.git.osandov@fb.com>
 <230a76e65372a8fb3ec62ce167d9322e5e342810.1568875700.git.osandov@fb.com>
 <CAG48ez2GKv15Uj6Wzv0sG5v2bXyrSaCtRTw5Ok_ovja_CiO_fQ@mail.gmail.com>
 <20190924171513.GA39872@vader>
 <20190924193513.GA45540@vader>
 <CAG48ez1NQBNR1XeVQYGoopEk=g_KedUr+7jxLQTaO+V8JCeweQ@mail.gmail.com>
 <20190925071129.GB804@dread.disaster.area>
 <60c48ac5-b215-44e1-a628-6145d84a4ce3@www.fastmail.com>
 <FF3F534F-B40D-4D7D-956B-F1B63C4751CC@fb.com>
 <4e6e03c1-b2f4-4841-99af-cbb75f33c14d@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e6e03c1-b2f4-4841-99af-cbb75f33c14d@www.fastmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 26, 2019 at 08:17:12AM -0400, Colin Walters wrote:
> 
> 
> On Wed, Sep 25, 2019, at 10:56 AM, Chris Mason wrote:
> 
> > The data is verified while being decompressed, but that's a fairly large 
> > fuzzing surface (all of zstd, zlib, and lzo).  A lot of people will 
> > correctly argue that we already have that fuzzing surface today, but I'd 
> > rather not make a really easy way to stuff arbitrary bytes through the 
> > kernel decompression code until all the projects involved sign off.
> 
> Right.  So maybe have this start of as a BTRFS ioctl and require
> privileges?   I assume that's sufficient for what Omar wants.

That was the first version of this series, but Dave requested that I
make it generic [1].

> (Are there actually any other popular Linux filesystems that do transparent compression anyways?)

A scan over the kernel tree shows that a few other filesystems do
compression:

- jffs2
- pstore (if you can call that a filesystem)
- ubifs
- cramfs (read-only)
- erofs (read-only)
- squashfs (read-only)

None of the "mainstream" general-purpose filesystems have support, but
that was also the case for reflink/dedupe before XFS added support.

1: https://lore.kernel.org/linux-fsdevel/20190905021012.GL7777@dread.disaster.area/
