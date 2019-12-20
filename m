Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11665127AD4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2019 13:16:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727335AbfLTMQW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Dec 2019 07:16:22 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35663 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727197AbfLTMQV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Dec 2019 07:16:21 -0500
Received: by mail-wr1-f65.google.com with SMTP id g17so9223519wro.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Dec 2019 04:16:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=agoLDBhJR59GTTSs+ez/Yrhh73k6oloZGrgz5Rsg0gM=;
        b=avEhe0h/Y5RzW/XaZZS0w+OJNrTSQRaj1ODufA74IXVLKtT4JSSrhOZptONbWS/7be
         PjiBYEjKUg6j99+8UCQe9dN9GIufg8pWG9zZmUYi6KBawfAdk4t8KuBq/VVJjLszIvnU
         EGwPEX41dSoeDEOmIZ3BcqkAzxBJwWP4HN+lM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=agoLDBhJR59GTTSs+ez/Yrhh73k6oloZGrgz5Rsg0gM=;
        b=Lt9qnMHVqHOcMKk5ZRXwBSGWt6m13e2xGDje13UhYHoHDSQY22aYX4+sSBRsjubeNI
         vVVQ1CzdDJl8Pq9Z/eBCfzmCwgXAidwElpWFl/Kv1//lDE50SWYx5vQnKhTMhNEnAcpk
         g+lGQJ5osZpJ5WSUenTitKxWn3jAS5AxRwe6KJD31efaxE79unYe5ZSadHFnfgrdOlyE
         ANh8bm1Oakd4mBbPF9cMwC7azM7SuzyoiVf6di3lXsWQbiekrPAyfqOMvuGk6D5X5PiC
         RWqLFlPMPYF9XbysYkG8H9HM/EEfofDHX44BtjKLNS5ndJ3rytt7LntGPJEGct3bSOFh
         BEDA==
X-Gm-Message-State: APjAAAVKWKTqBwAjEqXREPwOAKwMzBhkiTiWNadqEQcs5mWS7+V3C74B
        9oWPzKid50LfomgfLwwq+vVrBA==
X-Google-Smtp-Source: APXvYqxAEMCXkgpMdwF7gD4TxOUEgEjETCC6n0O8uBTNO+16VnxTE8nv1F7hfNRT+M1CW97N312/NA==
X-Received: by 2002:a5d:4983:: with SMTP id r3mr15186247wrq.134.1576844179206;
        Fri, 20 Dec 2019 04:16:19 -0800 (PST)
Received: from localhost ([2a01:4b00:8432:8a00:63de:dd93:20be:f460])
        by smtp.gmail.com with ESMTPSA id k7sm9289854wmi.19.2019.12.20.04.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2019 04:16:16 -0800 (PST)
Date:   Fri, 20 Dec 2019 12:16:15 +0000
From:   Chris Down <chris@chrisdown.name>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, kernel-team@fb.com,
        Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [PATCH] fs: inode: Reduce volatile inode wraparound risk when
 ino_t is 64 bit
Message-ID: <20191220121615.GB388018@chrisdown.name>
References: <20191220024936.GA380394@chrisdown.name>
 <CAOQ4uxjqSWcrA1reiyit9DRt+aq2tXBxLdPE31RrYw1yr=4hjg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjqSWcrA1reiyit9DRt+aq2tXBxLdPE31RrYw1yr=4hjg@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Amir,

Thanks for getting back, I appreciate it.

Amir Goldstein writes:
>How about something like this:
>
>/* just to explain - use an existing macro */
>shmem_ino_shift = ilog2(sizeof(void *));
>inode->i_ino = (__u64)inode >> shmem_ino_shift;
>
>This should solve the reported problem with little complexity,
>but it exposes internal kernel address to userspace.

One problem I can see with that approach is that get_next_ino doesn't 
discriminate based on the context (for example, when it is called for a 
particular tmpfs mount) which means that eventually wraparound risk is still 
pushed to the limit on such machines for other users of get_next_ino (like 
named pipes, sockets, procfs, etc). Granted then the space for collisions 
between them is less likely due to their general magnitude of inodes at one 
time compared to some tmpfs workloads, but still.

>Can we do anything to mitigate this risk?
>
>For example, instead of trying to maintain a unique map of
>ino_t to struct shmem_inode_info * in the system
>it would be enough (and less expensive) to maintain a unique map of
>shmem_ino_range_t to slab.
>The ino_range id can then be mixes with the relative object index in
>slab to compose i_ino.
>
>The big win here is not having to allocate an id every bunch of inodes
>instead of every inode, but the fact that recycled (i.e. delete/create)
>shmem_inode_info objects get the same i_ino without having to
>allocate any id.
>
>This mimics a standard behavior of blockdev filesystem like ext4/xfs
>where inode number is determined by logical offset on disk and is
>quite often recycled on delete/create.
>
>I realize that the method I described with slab it crossing module layers
>and would probably be NACKED.

Yeah, that's more or less my concern with that approach as well, hence why I 
went for something that seemed less intrusive and keeps with the current inode 
allocation strategy :-)

>Similar result could be achieved by shmem keeping a small stash of
>recycled inode objects, which are not returned to slab right away and
>retain their allocated i_ino. This at least should significantly reduce the
>rate of burning get_next_ino allocation.

While this issue happens to present itself currently on tmpfs, I'm worried that 
future users of get_next_ino based on historic precedent might end up hitting 
this as well. That's the main reason why I'm inclined to try and improve 
get_next_ino's strategy itself.

>Anyway, to add another consideration to the mix, overlayfs uses
>the high ino bits to multiplex several layers into a single ino domain
>(mount option xino=on).
>
>tmpfs is a very commonly used filesystem as overlayfs upper layer,
>so many users are going to benefit from keeping the higher most bits
>of tmpfs ino inodes unused.
>
>For this reason, I dislike the current "grow forever" approach of
>get_next_ino() and prefer that we use a smarter scheme when
>switching over to 64bit values.

By "a smarter scheme when switching over to 64bit values", you mean keeping 
i_ino as low magnitude as possible while still avoiding simultaneous reuse, 
right?

To that extent, if we can reliably and expediently recycle inode numbers, I'm 
not against sticking to the existing typing scheme in get_next_ino. It's just a 
matter of agreeing by what method and at what level of the stack that should 
take place :-)

I'd appreciate your thoughts on approaches forward. One potential option is to 
reimplement get_next_ino using an IDA, as mentioned in my patch message. Other 
than the potential to upset microbenchmarks, do you have concerns with that as 
a patch?

Thanks,

Chris
