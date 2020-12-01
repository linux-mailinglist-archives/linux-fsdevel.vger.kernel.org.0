Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B141C2CAFF1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Dec 2020 23:27:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbgLAW10 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Dec 2020 17:27:26 -0500
Received: from sandeen.net ([63.231.237.45]:59158 "EHLO sandeen.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726921AbgLAW1Z (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Dec 2020 17:27:25 -0500
Received: from liberator.sandeen.net (liberator.sandeen.net [10.0.0.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by sandeen.net (Postfix) with ESMTPSA id 6BAEE1171F;
        Tue,  1 Dec 2020 16:26:28 -0600 (CST)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Dave Chinner <david@fromorbit.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Eric Sandeen <sandeen@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Ira Weiny <ira.weiny@intel.com>,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        xfs <linux-xfs@vger.kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Xiaoli Feng <xifeng@redhat.com>
References: <e388f379-cd11-a5d2-db82-aa1aa518a582@redhat.com>
 <05a0f4fd-7f62-8fbc-378d-886ccd5b3f11@redhat.com>
 <20201201173905.GI143045@magnolia>
 <20201201205243.GK2842436@dread.disaster.area>
 <9ab51770-1917-fc05-ff57-7677f17b6e44@sandeen.net>
 <CAHk-=wjymrd42E6XfiXwR3NF5Fs4EhTzhUukCojEWpz0Vagvtw@mail.gmail.com>
From:   Eric Sandeen <sandeen@sandeen.net>
Subject: Re: [PATCH 2/2] statx: move STATX_ATTR_DAX attribute handling to
 filesystems
Message-ID: <15fd1754-371d-88ff-c60b-6635a2da0b13@sandeen.net>
Date:   Tue, 1 Dec 2020 16:26:43 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wjymrd42E6XfiXwR3NF5Fs4EhTzhUukCojEWpz0Vagvtw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/1/20 4:12 PM, Linus Torvalds wrote:
> On Tue, Dec 1, 2020 at 2:03 PM Eric Sandeen <sandeen@sandeen.net> wrote:
>>
>> That's why I was keen to just add DAX unconditionally at this point, and if we want
>> to invent/refine meanings for the mask, we can still try to do that?
> 
> Oh Gods.  Let's *not* make this some "random filesystem choice" where
> now semantics depends on what some filesystem decided to do, and
> different filesystems have very subtly different semantics.

Well, I had hoped that refinement might start with the interface
documentation, I'm certainly not suggesting every filesystem should go
its own way.
> This all screams "please keep this in the VFS layer" so that we at
> least have _one_ place where these kinds of decisions are made.

Making the "right decision" depends on what the mask actually means,
I guess.

Today we set a DAX attribute in statx which is not set in the mask.
That seems clearly broken.

We can either leave that as it is, set DAX in the mask for everyone in
the VFS, or delegate that mask-setting task to the individual filesystems
so that it reflects <something>, probably "can this inode ever be in dax
mode?"

I honestly don't care if we keep setting the attribute itself in the VFS;
if that's the right thing to do, that's fine.  (If so, it seems like
IS_IMMUTABLE -> STATX_ATTR_IMMUTABLE etc could be moved there, too.)

-Eric
