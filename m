Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 454E6417E08
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Sep 2021 01:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345939AbhIXXGo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Sep 2021 19:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343550AbhIXXGn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Sep 2021 19:06:43 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6EB2C061613
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Sep 2021 16:05:09 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id b15so45631428lfe.7
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Sep 2021 16:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QeB/QlIkVc1HaPnxXOxXzZA9RrsagX4tww0bEUkv5O4=;
        b=QHFaZY0zUtpimbNKGHO1HkSh2M2muQMq1XJ3mPWhBKWPCmDd0eRiRNkYay1Zi1Qgc7
         bYf4q/QP1eziQ3PbH1gXrdHcCpGYyU3NyphmUMGtZ5fzJRZY8LbC7Tlf3GN02I+iSAOZ
         PtKM2w1HHSMoyL13G4mqrbVzviCP+S42UYrIQ4bf5HsOpLFIB1t0Kg6NlFVd+o2SRqPW
         rWbJ8aIdU56Jpz/4sWJoM2P485ppEfhJOnoh2bynyWNYJUDIQzYYG7rENC7ux7JygphD
         SPHR9WxqgEJrK+vA3fYQQHCvgf/adfSv4O1QifhO+ii2WZ7rzcnpn3vmERRux1tjcjO9
         a8zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QeB/QlIkVc1HaPnxXOxXzZA9RrsagX4tww0bEUkv5O4=;
        b=4FZ0wEQt5ITRKMwPA5TnDbuKJVsi2B+T8hmxVpz1E/d/poMT9WkNb31AKKW8JNGTlX
         epds5EpOM4aJrijSKMsUiN9k65zka0wl3g81Re23VSCwyl9WyCMM3XAYwW+BOvtkLh6j
         Ad7Z/XlwwF5epfDHZVnZjUHo3Pdcjtmiew197vtlW+GmJNqkEpoSXvMMDzi4Tpa8UDPh
         2kmcFnodJnBGIMv58W3lJV7NXBPctirz78Dl4whNTzDnKmzAN/3mkF5RF/XL9EQB6MUj
         bjaXEdI2TfCKREQyqmsS9kQVB8f+JSCiiq11HUfr1Tr+e7zbuOajzasX/i1CxusIyYJU
         yR+A==
X-Gm-Message-State: AOAM533CiYhPaw2hvGDQhc7clqhDOdIs6frpWGCPrBDNN56RdVhYr8Vw
        nTyb5OQAZK83gyQyo4S3Ota+KQ==
X-Google-Smtp-Source: ABdhPJyABEn2XeZ/MdEk0AnHAYoFB7lLkWh75SgVQ/M/bCH1ThvH6y+h6j84xhJLr4fbYzmt8DXaoQ==
X-Received: by 2002:a2e:9e4c:: with SMTP id g12mr13602346ljk.433.1632524708253;
        Fri, 24 Sep 2021 16:05:08 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id s7sm964001lfi.130.2021.09.24.16.05.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 16:05:07 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 7CDA6102FC4; Sat, 25 Sep 2021 02:05:05 +0300 (+03)
Date:   Sat, 25 Sep 2021 02:05:05 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Hugh Dickins <hughd@google.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Johannes Weiner <hannes@cmpxchg.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: Mapcount of subpages
Message-ID: <20210924230505.vlql2mdjfcotkuqj@box.shutemov.name>
References: <YUvWm6G16+ib+Wnb@moria.home.lan>
 <YUvzINep9m7G0ust@casper.infradead.org>
 <YUwNZFPGDj4Pkspx@moria.home.lan>
 <YUxnnq7uFBAtJ3rT@casper.infradead.org>
 <20210923124502.nxfdaoiov4sysed4@box.shutemov.name>
 <72cc2691-5ebe-8b56-1fe8-eeb4eb4a4c74@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72cc2691-5ebe-8b56-1fe8-eeb4eb4a4c74@google.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 23, 2021 at 02:10:13PM -0700, Hugh Dickins wrote:
> But you have a different point in mind when you refer to superfluous
> CoW and GUP: I don't know the score there (and I think we are still in
> that halfway zone, since pte CoW was changed to depend on page_count,
> but THP CoW still depending on mapcount).

I didn't pay enough attention to the topic when the change to depend on
page_count was made. I need to catch up.

I look at what direction Andrea went in his patchset and so far I *feel*
he has a point[1]. I have not read the whole thing yet and I don't have a
firm position here, but maybe we need to get to the bottom of the topic
before considering ditching per-subpage mapcount.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/andrea/aa.git/tree/mm/memory.c?h=mapcount_deshare&id=e1cb3108d4131c2a7da03fbd37c3230cf082bfd9#n3153

-- 
 Kirill A. Shutemov
