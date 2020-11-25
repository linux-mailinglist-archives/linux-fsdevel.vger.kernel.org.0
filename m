Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B64F12C36EF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Nov 2020 03:53:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbgKYCut (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Nov 2020 21:50:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726805AbgKYCus (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Nov 2020 21:50:48 -0500
Received: from mail-oo1-xc43.google.com (mail-oo1-xc43.google.com [IPv6:2607:f8b0:4864:20::c43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BFEAC061A4D
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2020 18:50:48 -0800 (PST)
Received: by mail-oo1-xc43.google.com with SMTP id t142so149869oot.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2020 18:50:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=pZ7yTwzr1UVwX/XHITOiHT7kma/jH9EnOU7ZqW6Z6RM=;
        b=YNeYz6LI+AghX3JPBap3pd8R8Wf7R6RrNw+OuCNiN3m2v7471fhM7exG1z8l5JdDZ/
         8+rsMtZGSKl2fFNdrgvHD4gOjGJUyJsuRrOudh6i1n3gUvyMRrXpvcyWiy9vIuQDRZEX
         ewvy4j+tDRAv3H1CXZeToi1EmLi4/OKLrEf4Iq70Lqd8bpsWgntjXnByE8058UnRXadh
         6Fdsy/f9CENebsk93jgPNyv6ygZ1/HR941IUBWEKpDrh3buU/jGVO4ZhZM9fWWw+D6rx
         Yu7TW7AiuFf3KAbyEoND/GNS5mycj2rTkSnVOBa0YxKUqoFiIFwwyC3E73VvdwZnHKdw
         UJvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=pZ7yTwzr1UVwX/XHITOiHT7kma/jH9EnOU7ZqW6Z6RM=;
        b=LdkkTRvUoytDw2XPi16dGltfAawyzph6DIR5V40Ant3XoJAOw1fHhoTySDyUtI9j0/
         RnoGr8IyvIyjadFMWnLgE/r6yUdW2XRNK1kF4fSSyaVAhkC7UhR85YNSpBoRJ/JpkIFd
         386o+8J9PLyGKVL8KddhW3VfVWsmhQHLzi3gQ+2V7UtoCsIfWdn4a9OOh9NwQkKkh4k+
         d6Wuhj48j0cuGCwgAHvBr7GvAnXZjg8kMASMJrLrW4rTlt6+xUC566+sc/JhhIknHnx7
         aMQsgC0BleX01/a7svjcAjPFnHa235GhOYdfU1xfUiL3JhxBInJBd+aXJVVnKQBIY6tL
         xRaw==
X-Gm-Message-State: AOAM530sqZika/9xFqd2aFOFyMD8pxqZmbQvMpgfoGVfN6Uby8dxmxm1
        llr0isS+WQXXgRD0x7uq8W+Oqw==
X-Google-Smtp-Source: ABdhPJxw3Cv2mCf5NBEDJPNiP7e1tx/wj45SOuv55MJID8vu6pXCZY7IXdHyeknTPg8OEVnf9b95Pg==
X-Received: by 2002:a4a:764e:: with SMTP id w14mr1208367ooe.56.1606272647591;
        Tue, 24 Nov 2020 18:50:47 -0800 (PST)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id l7sm522243oth.73.2020.11.24.18.50.45
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Tue, 24 Nov 2020 18:50:46 -0800 (PST)
Date:   Tue, 24 Nov 2020 18:50:32 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Matthew Wilcox <willy@infradead.org>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, hch@lst.de,
        hannes@cmpxchg.org, yang.shi@linux.alibaba.com,
        dchinner@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 00/16] Overhaul multi-page lookups for THP
In-Reply-To: <20201125023234.GH4327@casper.infradead.org>
Message-ID: <alpine.LSU.2.11.2011241838400.3026@eggly.anvils>
References: <20201112212641.27837-1-willy@infradead.org> <alpine.LSU.2.11.2011160128001.1206@eggly.anvils> <20201117153947.GL29991@casper.infradead.org> <alpine.LSU.2.11.2011170820030.1014@eggly.anvils> <20201117191513.GV29991@casper.infradead.org>
 <20201117234302.GC29991@casper.infradead.org> <20201125023234.GH4327@casper.infradead.org>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 25 Nov 2020, Matthew Wilcox wrote:
> On Tue, Nov 17, 2020 at 11:43:02PM +0000, Matthew Wilcox wrote:
> > On Tue, Nov 17, 2020 at 07:15:13PM +0000, Matthew Wilcox wrote:
> > > I find both of these functions exceptionally confusing.  Does this
> > > make it easier to understand?
> > 
> > Never mind, this is buggy.  I'll send something better tomorrow.
> 
> That took a week, not a day.  *sigh*.  At least this is shorter.

Thanks, I'll give it a try (along with the other 4, on top of the 12:
maybe on -rc5, maybe on today's mmotm, I'll decide that later).

Shorter you say, that's good: I was disheartened by the way it got
more complicated, after your initial truncate_inode_partial_page()
neatness.  Any hints on what was wrong with my simple fixup to that?
(But I didn't spend any more time trying to prove or disprove it.)

Hugh
