Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39D47108AA5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2019 10:17:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbfKYJRg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Nov 2019 04:17:36 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45557 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726873AbfKYJRg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Nov 2019 04:17:36 -0500
Received: by mail-lj1-f193.google.com with SMTP id n21so14860069ljg.12
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Nov 2019 01:17:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZHZjuct0CLXN3AYcQ+YfYJz+luTtYA/oliVypF8e6hc=;
        b=Kv+a6C+O8YeU1QaBfhf0j35CEfH/LR23KqQcSQNZ8dEsGWE2Q23YPJVaSt1OOuaLbd
         5jBPpWKpaHfKNAEUsyutTc6kHaSoIg23DbBYqQy5weekxhj35gYoDoaifr46Yq7lW5RQ
         mO1FmglcYhLebSjuvQ6EwuP5ZB4NPus1UBDqlh3NXwcinyYbUY4541wS9uNzZXRax1lz
         lBxJCiPU1GZ2UM5E7rweB19wEagyR1dGyqpqvWo++g9AjoWy4VNJfxkbhzaFzDXPcaPv
         FL9wu6KlgjOU68rQLaWeTMflE/baiE/V+KVXwhMxvwy8Us681Uhnj9vpSVntW6kQ82FD
         c8TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZHZjuct0CLXN3AYcQ+YfYJz+luTtYA/oliVypF8e6hc=;
        b=XcchYHilMlLVE+UmCqvQM7rxZ28fT6T1gqrubba841uZPirNzIOUOGBNEV4Njvr2Mz
         v1zFei+WrbMarNA7IZAAr4TivTb7tnFPCRAjMCnrQmsW8frJ3H4+VyR+QL1vfaNyam3H
         VQrkGj843hZ2X48Yf9ums6+yZnFBQqJ+SI7XcGSd/X9qDn3jFWbSkzGDFyQTOgBpU7r1
         Gim8rYoRrH8p/RtBWQ9ori8ECjDRbbfroHO2soFgR3CwT17+I+7+mpIxtSOHSIgWwedN
         IGRLiHvNTFUOBoL0InFq6crkMEOEFDb337b0x4LcJIszqWzdcpVyxXaANnQ65Eyag1Ey
         N/0g==
X-Gm-Message-State: APjAAAWM0iv2g+Ai8FYPJiBRFzLdolBosr1OnYTykQBRkJ3cyhrDgkt9
        I/wznXhZSeOA6cNhH3OglLuX3Q==
X-Google-Smtp-Source: APXvYqxd5dos5A6z8ycGXVe7nHwhuoFOM7ml7F4GD0vhqjvmIeNnVd78WDsUG2ScyfwFJZNDkXJSMg==
X-Received: by 2002:a2e:760d:: with SMTP id r13mr20970401ljc.15.1574673453729;
        Mon, 25 Nov 2019 01:17:33 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id b3sm3238431lfq.10.2019.11.25.01.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 01:17:33 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id E895C1032C4; Mon, 25 Nov 2019 12:17:41 +0300 (+03)
Date:   Mon, 25 Nov 2019 12:17:41 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Johannes Weiner <hannes@cmpxchg.org>, cluster-devel@redhat.com,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Steve French <sfrench@samba.org>,
        Bob Peterson <rpeterso@redhat.com>
Subject: Re: [RFC PATCH 0/3] Rework the gfs2 read and page fault locking
Message-ID: <20191125091741.firh7stqcpniwvga@box>
References: <20191122235324.17245-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191122235324.17245-1-agruenba@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Nov 23, 2019 at 12:53:21AM +0100, Andreas Gruenbacher wrote:
> Hello,
> 
> this patch series moves the glock lock taking in gfs2 from the
> ->readpage and ->readpages inode operations to the ->read_iter file and
> ->fault vm operations.  To achieve that, we add flags to the
> generic_file_read_iter and filemap_fault generic helpers.
> 
> This proposal was triggered by the following discussion:
> 
> https://lore.kernel.org/linux-fsdevel/157225677483.3442.4227193290486305330.stgit@buzz/
> 
> In that thread, Linus argued that filesystems should make sure the inode
> size is sufficiently up-to-date before calling the generic helpers, and
> that filesystems can do it themselves if they want more than that.
> That's surely doable.  However, implementing those operations properly
> at the filesystem level quickly becomes complicated when it gets to
> things like readahead.  In addition, those slightly modified copies of
> those helpers would surely diverge from their originals over time, and
> maintaining them properly would become hard.  So I hope the relatively
> small changes to make the original helpers slightly more flexible will
> be acceptable instead.
> 
> With the IOCB_CACHED flag added by one of the patches in this series,
> the code that Konstantin's initial patch adds to
> generic_file_buffered_read could be made conditional on the IOCB_CACHED
> flag being cleared.  That way, it won't misfire on filesystems that
> allow a stale inode size.  (I'm not sure if any filesystems other than
> gfs2 are actually affected.)
> 
> Some additional explanation:
> 
> The cache consistency model of filesystems like gfs2 is such that if
> pages are found in an inode's address space, those pages as well as the
> inode size are up to date and can be used without taking any filesystem
> locks.  If a page is not cached, filesystem locks must be taken before
> the page can be read; this will also bring the inode size up to date.
> 
> Thus far, gfs2 has taken the filesystem locks inside the ->readpage and
> ->readpages address space operations.  A better approach seems to be to
> take those locks earlier, in the ->read_iter file and ->fault vm
> operations.  This would also avoid a lock inversion in ->readpages.
> 
> We obviously want to avoid taking the filesystem locks unnecessarily
> when the pages we are looking for are already cached; otherwise, we
> would cripple performance.  So we need to check if those pages are
> present first.  That's actually exactly what the generic_file_read_iter
> and filemap_fault helpers do already anyway, except that they will call
> into ->readpage and ->readpages when they find pages missing.  Instead
> of that, we'd like those helpers to return with an error code that
> allows us to retry the operation after taking the filesystem locks.

Do you see IOCB_CACHED/FAULT_FLAG_CACHED semantics being usable for
anyting beyond gfs2?

-- 
 Kirill A. Shutemov
