Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5F6345D019
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Nov 2021 23:31:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344901AbhKXWfI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Nov 2021 17:35:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:41904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242784AbhKXWfI (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Nov 2021 17:35:08 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 156826108B;
        Wed, 24 Nov 2021 22:31:55 +0000 (UTC)
Date:   Wed, 24 Nov 2021 22:31:52 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Will Deacon <will@kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/3] Avoid live-lock in fault-in+uaccess loops with
 sub-page faults
Message-ID: <YZ69WNNKKNE2hAzB@arm.com>
References: <20211124192024.2408218-1-catalin.marinas@arm.com>
 <20211124133600.94f0b9a6c611ee663c9a8d6d@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211124133600.94f0b9a6c611ee663c9a8d6d@linux-foundation.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 24, 2021 at 01:36:00PM -0800, Andrew Morton wrote:
> On Wed, 24 Nov 2021 19:20:21 +0000 Catalin Marinas <catalin.marinas@arm.com> wrote:
> > There are a few places in the filesystem layer where a uaccess is
> > performed in a loop with page faults disabled, together with a
> > fault_in_*() call to pre-fault the pages. On architectures like arm64
> > with MTE (memory tagging extensions) or SPARC ADI, even if the
> > fault_in_*() succeeded, the uaccess can still fault indefinitely.
> > 
> > In general this is not an issue since such code restarts the
> > fault_in_*() from where the uaccess failed, therefore guaranteeing
> > forward progress. The btrfs search_ioctl(), however, rewinds the
> > fault_in_*() position and it can live-lock. This was reported by Al
> > here:
> 
> Btrfs livelock on some-of-arm sounds fairly serious.

Luckily not much btrfs use on Arm mobile parts.

> Should we
> backport this?  If so, a48b73eca4ce ("btrfs: fix potential deadlock in
> the search ioctl") appears to be a suitable Fixes: target?

This should be a suitable target together with a Cc stable to v4.4
(that's what the above commit had). Of course, the other two patches
need backporting as well and they won't apply cleanly.

Once we agreed on the fix, I'm happy to do the backports and send them
all to stable.

-- 
Catalin
