Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C126C411284
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Sep 2021 12:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235044AbhITKFC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Sep 2021 06:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234845AbhITKFB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Sep 2021 06:05:01 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3C5EC061762
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Sep 2021 03:03:34 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id b15so47054696lfe.7
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Sep 2021 03:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JsflVfkQxQB4N10JR68gBY89s+ETKAkmb+oupF+vnMo=;
        b=27IEOpveeqqFcAi832Br+8AG9JKChmAv7tTrVV950tvPtiqpC6Psrah4+xSVxUaJxd
         OOKtThwEUavPn3JhVr2Nbj+N8aBC33lIuEyu7BINU8GGBzDYDijug74t6wde0vhp211R
         nh8mUkfErVn8ZmBK+CwKhwa32vtsfl1O66XS3KXTuYhc7Z/bO5ah2+kW6ZGIZmrjVcuB
         ZbTp8f7Qn6ilulvkGgc6YeIJPW/u69ubD25NrfyFd4Ob2zZuG823H6yGMXImEd+b/4dx
         dK4EFgA73SkzK2t9nDI6500OlEpBG2oIGrQj15vChjV8Balbp1ESoqCBKzHTxKteSZ3g
         ERTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JsflVfkQxQB4N10JR68gBY89s+ETKAkmb+oupF+vnMo=;
        b=hxEslOQNH66DpfZZDaPVaf/O0+fsL5C1jcwPn02xg2hS/DNmDkihyRCy5laH9bfksr
         r+/ker4YN8PO069T9E5AF0jDiZYknRGZD7/uvaK42RJMGVbrZFB3Laat9JxmjbdPUmPN
         CDnyXFBQP111eseU2Vzeag3N8YwSH8iKT4qggIzHDeMP5RdzKiEf1p2EmIZz1B2C6TyP
         PUDgu/5AJjmFnmb4PEroRChyL9HKbYyTPwKq5HkJEHEpCeqSOgPprfYNJlBDsQpPcFBG
         aaU8cGbuGkpdbMOlVRXcyCylmzPHYIUL/u8Dbh9+OTXzs8IB4r8v7qYDdntXyFuND3HX
         kENQ==
X-Gm-Message-State: AOAM533s5EKchJ94en17nnf9v6EgN6tSUJjhrBxWFp8TWGadaW1GtguZ
        wkgYovgfxq1jOuhoEKWsfzxN1g==
X-Google-Smtp-Source: ABdhPJwWeA3bEQ95y2LO86pVxC5P5j6PanypuMtnhgm81tBPbpzuBTk2e2kpj/5MX7P31r1CnCOLUQ==
X-Received: by 2002:ac2:5d63:: with SMTP id h3mr18425134lft.278.1632132213126;
        Mon, 20 Sep 2021 03:03:33 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id i4sm1227194lfo.13.2021.09.20.03.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 03:03:32 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 7D479103053; Mon, 20 Sep 2021 13:03:32 +0300 (+03)
Date:   Mon, 20 Sep 2021 13:03:32 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Dave Chinner <david@fromorbit.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>
Subject: Re: Folio discussion recap
Message-ID: <20210920100332.gd4a2c3aza3rufk5@box.shutemov.name>
References: <YSPwmNNuuQhXNToQ@casper.infradead.org>
 <YTu9HIu+wWWvZLxp@moria.home.lan>
 <YUIT2/xXwvZ4IErc@cmpxchg.org>
 <20210916025854.GE34899@magnolia>
 <YUN2vokEM8wgASk8@cmpxchg.org>
 <20210917052440.GJ1756565@dread.disaster.area>
 <YUTC6O0w3j7i8iDm@cmpxchg.org>
 <20210917205735.tistsacwwzkcdklx@box.shutemov.name>
 <YUUhnHrWUeYebhPa@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YUUhnHrWUeYebhPa@cmpxchg.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 17, 2021 at 07:15:40PM -0400, Johannes Weiner wrote:
> The code I'm specifically referring to here is the conversion of some
> code that encounters both anon and file pages - swap.c, memcontrol.c,
> workingset.c, and a few other places. It's a small part of the folio
> patches, but it's a big deal for the MM code conceptually.

Hard to say without actually trying, but my worry here that this may lead
to code duplication to separate file and anon code path. I donno.

-- 
 Kirill A. Shutemov
