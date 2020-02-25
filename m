Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F83016F313
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2020 00:14:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729078AbgBYXO3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Feb 2020 18:14:29 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43820 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728865AbgBYXO3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Feb 2020 18:14:29 -0500
Received: by mail-pf1-f194.google.com with SMTP id s1so372488pfh.10
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Feb 2020 15:14:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=ik1zuiqE8i76YJubrnNTmer8KABpIWbp2agVMhEd0M4=;
        b=mGnOqthEowg2FBXNkXluMN/hRl1lQRj0tN9t5NB1i2gWmfosFiPkJONAvhfT1xHrpU
         oFKHf+ib2VqZgZN1/abWJvJ5NkBYY9WoXLPdrL45U4fjYYOF390hDPCIo0cwMj9846xy
         qb1tnlwKk8nzmFrJmtCs1aI5w/oJWQOhdTJb4L0Sv/zqZNUccZUWdoAFMVc61Xtizm0H
         THNvtbfv35/H2buOTn1Rtq1VkI/BbGTr6Jo15myWk9gRq4BEhEjRnEytFdJ6mue3jSfz
         L50sbyM4EuxkZKY0mm9oU8CcZyDzDRL8IvLxS+ejiqSOVUAOA+f1/c74w7XTKaooSDh1
         VAog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=ik1zuiqE8i76YJubrnNTmer8KABpIWbp2agVMhEd0M4=;
        b=jwql/FOUaTQATgkXcatDWC0cJXXw2VmEOa1RnXCfAMYKzl5ceGrAMJnKHk9MGF7Jkk
         gfwfgQKn2xns3OStgyJWTST3ZMsmpgjcNLM3N+D/6BJ1jBUeRcwO8nhvfitmu719FRoo
         5MjkIpKn5ehjxmr1s69l/HRO4bdHPuJtH6ELA8euJHDSQh8n0J442ng4vo6VeaOGl5Jp
         v3DDF1+GEnZQvGIWVT/c1q1ODoiWGEq0DVSjpKt/AyoGFyIV1+xTlWqpHYLPMbTeGxN7
         rMue9oK/TGX+oJ7txfjHCayLoLaUhXF4mDeU9jdIOS1WGhsQxm70dOcWt5xr+/yVYAPF
         n5eA==
X-Gm-Message-State: APjAAAXhN1pVi4bg0IZcEj8G2ntJg0ptBuabGmTMtqlIXiTIM2eCQiVB
        hP2j78ABs+D/GnEI5Re8ZYMwjg==
X-Google-Smtp-Source: APXvYqwDkSgemuveBIsYIy/dIT5xtOS3wUx5uGf0cTYtvCxSEWAdnhLqNQZgETOPI9K2NzHT19/+Ug==
X-Received: by 2002:a62:3892:: with SMTP id f140mr1097196pfa.190.1582672467127;
        Tue, 25 Feb 2020 15:14:27 -0800 (PST)
Received: from [100.112.92.218] ([104.133.9.106])
        by smtp.gmail.com with ESMTPSA id w8sm134400pfn.186.2020.02.25.15.14.25
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 25 Feb 2020 15:14:26 -0800 (PST)
Date:   Tue, 25 Feb 2020 15:14:05 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Chris Down <chris@chrisdown.name>
cc:     Hugh Dickins <hughd@google.com>,
        Dave Chinner <david@fromorbit.com>, Chris Mason <clm@fb.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>,
        Mikael Magnusson <mikachu@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH v5 2/2] tmpfs: Support 64-bit inums per-sb
In-Reply-To: <20200120151117.GA81113@chrisdown.name>
Message-ID: <alpine.LSU.2.11.2002251422370.8029@eggly.anvils>
References: <20200107001643.GA485121@chrisdown.name> <20200107003944.GN23195@dread.disaster.area> <CAOQ4uxjvH=UagqjHP_71_p9_dW9wKqiaWujzY1xKe7yZVFPoTA@mail.gmail.com> <alpine.LSU.2.11.2001070002040.1496@eggly.anvils> <CAOQ4uxiMQ3Oz4M0wKo5FA_uamkMpM1zg7ydD8FXv+sR9AH_eFA@mail.gmail.com>
 <20200107210715.GQ23195@dread.disaster.area> <4E9DF932-C46C-4331-B88D-6928D63B8267@fb.com> <alpine.LSU.2.11.2001080259350.1884@eggly.anvils> <20200110164503.GA1697@chrisdown.name> <alpine.LSU.2.11.2001122259120.3471@eggly.anvils>
 <20200120151117.GA81113@chrisdown.name>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 20 Jan 2020, Chris Down wrote:
> Hi Hugh,
> 
> Sorry this response took so long, I had some non-work issues that took a lot
> of time last week.

No, clearly it's I who must apologize to you for very slow response.

> 
> Hugh Dickins writes:
> > 
> > So the "inode64" option will be accepted but redundant on mounting,
> > but exists for use as a remount option after mounting or remounting
> > with "inode32": allowing the admin to switch temporarily to mask off
> > the high ino bits with "inode32" when needing to run a limited binary.
> > 
> > Documentation and commit message to alert Andrew and Linus and distros
> > that we are risking some breakage with this, but supplying the antidote
> > (not breakage of any distros themselves, no doubt they're all good;
> > but breakage of what some users might run on them).
> 
> Sounds good.
> 
> > > 
> > > Other than that, the first patch could be similar to how it is now,
> > > incorporating Hugh's improvements to the first patch to put everything
> > > under
> > > the same stat_lock in shmem_reserve_inode.
> > 
> > So, I persuaded Amir to the other aspects my version, but did not
> > persuade you?  Well, I can live with that (or if not, can send mods
> > on top of yours): but please read again why I was uncomfortable with
> > yours, to check that you still prefer it (I agree that your patch is
> > simpler, and none of my discomfort decisive).
> 
> Hmm, which bit were you thinking of? The lack of batching, shmem_encode_fh(),
> or the fact that nr_inodes can now be 0 on non-internal mounts?

I was uncomfortable with tmpfs depleting get_next_ino()'s pool in some
configurations, and wanted the (get_next_ino-like) per-cpu but per-sb
batching for nr_inodes=0, to minimize its stat_lock contention.

I did not have a patch to shmem_encode_fh(), had gone through thinking
that 64-bit inos made an additional fix there necessary; but Amir then
educated us that it is safe as is, though could be cleaned up later.

nr_inodes can be 0 on non-internal mounts, for many years.

> 
> For batching, I'm neutral. I'm happy to use the approach from your patch and
> integrate it (and credit you, of course).

Credit not important, but you may well want to blame me for that
complication :)

> 
> For shmem_encode_fh, I'm not totally sure I understand the concern, if that's
> what you mean.

My concern had been that shmem_encode_fh() builds up an fh from i_ino
and more, looks well prepared for a 64-bit ino, but appeared to be
announcing a 32-bit ino in its return value: Amir reassures us that
that return value does not matter.

> 
> For nr_inodes, I agree that intentional or unintentional, we should at least
> handle this case for now and can adjust later if the behaviour changes.

nr_inodes=0 is an intentional configuration (but 0 denoting infinity:
not very clean, and I've sometimes regretted that choice).

If there's any behavior change, that's a separate matter from these
64-bit ino patches; maybe I mentioned it in passing and confused us -
that we seem to have recently allowed a remounting limited<->unlimited
that was not permitted before, and might or might not need a fix patch.

Sorry again for delaying you, Chris: not at all what I'd wanted to do.
Hugh
