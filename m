Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20216142E76
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2020 16:11:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729080AbgATPLY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jan 2020 10:11:24 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33663 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbgATPLV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jan 2020 10:11:21 -0500
Received: by mail-wr1-f65.google.com with SMTP id b6so29996384wrq.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jan 2020 07:11:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fpFQ1fEPd0yd6/Fy18DraiEyPGTTtIbb9sRJOIkGs+o=;
        b=MlG60/Pjxo9rE2vXGmlDoYw5RKWpmvGa+soqFJ7dW2eRzq+T9rENvcZmWbcZl6uzwh
         z41+vpmQZ3IvNUtv0zeGZ1Beb9xhC7Hlphqnrho0nhPivDtyewP1yOx/zDB2UjoMUl5U
         LT68YwyROGqrbxDvcCE7zmcicSS1FZ193iqTQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fpFQ1fEPd0yd6/Fy18DraiEyPGTTtIbb9sRJOIkGs+o=;
        b=fpacaQ55ucR8eqdbcLWhnN1kgz4z8QaQh8oro87dvYsrls1bFAJoiUPrG9dYFJmsjl
         pFo9ICBEYN7viHezmwMTofQIVGobztBPOp+NRKkrzv1Bt+xC6DGtFIt3CLwwb183jXtP
         NrrlQfKraehvR1kbrFaDFTf+eBfYN9bWGEzYpHN2J/zKlczYfyKzfnzAcZL6SD6rlLDl
         Zeyx/5tTmwypKaE8LBAFkUt1cGasUiE1cZ/NL0g0NoQqxfhsexwl+xvjcGjV/aEc0w/a
         jcy8d+HepvzxJX3tCZ8xwE7joCf4257WqzflirfRFCeJNc0YDCZApyqRHrDuM9CK7GRx
         eawA==
X-Gm-Message-State: APjAAAVxU3EaaR2At80gfZCKZtK8Th9/My/0cmPblJvLy7Xbz5iQ83OI
        PXkj93XFTkAO3QY7EP272Now0A==
X-Google-Smtp-Source: APXvYqyWKGmCoy+9bvGRA2RniQZCgf4tZzcO38mWdEPr54brhtY82T71lmAyTZO6n140BPQ4R1vXQw==
X-Received: by 2002:adf:ea05:: with SMTP id q5mr15043wrm.48.1579533079122;
        Mon, 20 Jan 2020 07:11:19 -0800 (PST)
Received: from localhost ([2620:10d:c092:180::1:251f])
        by smtp.gmail.com with ESMTPSA id q15sm47977328wrr.11.2020.01.20.07.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2020 07:11:18 -0800 (PST)
Date:   Mon, 20 Jan 2020 15:11:17 +0000
From:   Chris Down <chris@chrisdown.name>
To:     Hugh Dickins <hughd@google.com>
Cc:     Dave Chinner <david@fromorbit.com>, Chris Mason <clm@fb.com>,
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
Message-ID: <20200120151117.GA81113@chrisdown.name>
References: <20200107001643.GA485121@chrisdown.name>
 <20200107003944.GN23195@dread.disaster.area>
 <CAOQ4uxjvH=UagqjHP_71_p9_dW9wKqiaWujzY1xKe7yZVFPoTA@mail.gmail.com>
 <alpine.LSU.2.11.2001070002040.1496@eggly.anvils>
 <CAOQ4uxiMQ3Oz4M0wKo5FA_uamkMpM1zg7ydD8FXv+sR9AH_eFA@mail.gmail.com>
 <20200107210715.GQ23195@dread.disaster.area>
 <4E9DF932-C46C-4331-B88D-6928D63B8267@fb.com>
 <alpine.LSU.2.11.2001080259350.1884@eggly.anvils>
 <20200110164503.GA1697@chrisdown.name>
 <alpine.LSU.2.11.2001122259120.3471@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.2001122259120.3471@eggly.anvils>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Hugh,

Sorry this response took so long, I had some non-work issues that took a lot of 
time last week.

Hugh Dickins writes:
>On Fri, 10 Jan 2020, Chris Down wrote:
>> Hugh Dickins writes:
>> > Dave, Amir, Chris, many thanks for the info you've filled in -
>> > and absolutely no need to run any scan on your fleet for this,
>> > I think we can be confident that even if fb had some 15-year-old tool
>> > in use on its fleet of 2GB-file filesystems, it would not be the one
>> > to insist on a kernel revert of 64-bit tmpfs inos.
>> >
>> > The picture looks clear now: while ChrisD does need to hold on to his
>> > config option and inode32/inode64 mount option patch, it is much better
>> > left out of the kernel until (very unlikely) proved necessary.
>>
>> Based on Mikael's comment above about Steam binaries, and the lack of
>> likelihood that they can be rebuilt, I'm inclined to still keep inode{64,32},
>> but make legacy behaviour require explicit opt-in. That is:
>>
>> - Default it to inode64
>> - Remove the Kconfig option
>> - Only print it as an option if tmpfs was explicitly mounted with inode32
>>
>> The reason I suggest keeping this is that I'm mildly concerned that the kind
>> of users who might be impacted by this change due to 32-bit _FILE_OFFSET_BITS
>> -- like the not-too-uncommon case that Mikael brings up -- seem unlikely to
>> be the kind of people that would find it in an rc.
>
>Okay.  None of us are thrilled with it, but I agree that
>Mikael's observation should override our developer's preference.
>
>So the "inode64" option will be accepted but redundant on mounting,
>but exists for use as a remount option after mounting or remounting
>with "inode32": allowing the admin to switch temporarily to mask off
>the high ino bits with "inode32" when needing to run a limited binary.
>
>Documentation and commit message to alert Andrew and Linus and distros
>that we are risking some breakage with this, but supplying the antidote
>(not breakage of any distros themselves, no doubt they're all good;
>but breakage of what some users might run on them).

Sounds good.

>>
>> Other than that, the first patch could be similar to how it is now,
>> incorporating Hugh's improvements to the first patch to put everything under
>> the same stat_lock in shmem_reserve_inode.
>
>So, I persuaded Amir to the other aspects my version, but did not
>persuade you?  Well, I can live with that (or if not, can send mods
>on top of yours): but please read again why I was uncomfortable with
>yours, to check that you still prefer it (I agree that your patch is
>simpler, and none of my discomfort decisive).

Hmm, which bit were you thinking of? The lack of batching, shmem_encode_fh(), 
or the fact that nr_inodes can now be 0 on non-internal mounts?

For batching, I'm neutral. I'm happy to use the approach from your patch and 
integrate it (and credit you, of course).

For shmem_encode_fh, I'm not totally sure I understand the concern, if that's 
what you mean.

For nr_inodes, I agree that intentional or unintentional, we should at least 
handle this case for now and can adjust later if the behaviour changes.

Thanks again,

Chris
