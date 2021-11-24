Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB8E45CF1C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Nov 2021 22:36:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343873AbhKXVjN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Nov 2021 16:39:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:47886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229920AbhKXVjN (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Nov 2021 16:39:13 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7373461038;
        Wed, 24 Nov 2021 21:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1637789762;
        bh=1qxWEC18le/A8a+N+COfBev7NdB1IPDGt4hnJIvrNwg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=P8rTHiQ7DBWjiMEGFw33451N0sRxqPFqWieczHCkX39OnJt1bfR04SQCx6RSFGpf6
         iZPDUWsPtC46QiCzMnjhqucmerI0qtIJFG5RF0r6FSi2rKwoWEz25ZRPikr/diwjTX
         bLlVbbqKsSNKUYFowE542Io7+4i1PFNHCZ+sZNU8=
Date:   Wed, 24 Nov 2021 13:36:00 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
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
Message-Id: <20211124133600.94f0b9a6c611ee663c9a8d6d@linux-foundation.org>
In-Reply-To: <20211124192024.2408218-1-catalin.marinas@arm.com>
References: <20211124192024.2408218-1-catalin.marinas@arm.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 24 Nov 2021 19:20:21 +0000 Catalin Marinas <catalin.marinas@arm.com> wrote:

> Hi,
> 
> There are a few places in the filesystem layer where a uaccess is
> performed in a loop with page faults disabled, together with a
> fault_in_*() call to pre-fault the pages. On architectures like arm64
> with MTE (memory tagging extensions) or SPARC ADI, even if the
> fault_in_*() succeeded, the uaccess can still fault indefinitely.
> 
> In general this is not an issue since such code restarts the
> fault_in_*() from where the uaccess failed, therefore guaranteeing
> forward progress. The btrfs search_ioctl(), however, rewinds the
> fault_in_*() position and it can live-lock. This was reported by Al
> here:

Btrfs livelock on some-of-arm sounds fairly serious.  Should we
backport this?  If so, a48b73eca4ce ("btrfs: fix potential deadlock in
the search ioctl") appears to be a suitable Fixes: target?

