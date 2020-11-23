Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32DA02C11A8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Nov 2020 18:16:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732649AbgKWRKW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Nov 2020 12:10:22 -0500
Received: from mx2.suse.de ([195.135.220.15]:45532 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388125AbgKWRKV (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Nov 2020 12:10:21 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0CF62AC82;
        Mon, 23 Nov 2020 17:10:20 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B5416DA818; Mon, 23 Nov 2020 18:08:31 +0100 (CET)
Date:   Mon, 23 Nov 2020 18:08:31 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Jann Horn <jannh@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>, linux-api@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH v6 04/11] btrfs: fix btrfs_write_check()
Message-ID: <20201123170831.GH8669@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Omar Sandoval <osandov@osandov.com>,
        linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>, Jann Horn <jannh@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>, linux-api@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1605723568.git.osandov@fb.com>
 <b096cecce8277b30e1c7e26efd0450c0bc12ff31.1605723568.git.osandov@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b096cecce8277b30e1c7e26efd0450c0bc12ff31.1605723568.git.osandov@fb.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 18, 2020 at 11:18:11AM -0800, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> btrfs_write_check() has two related bugs:
> 
> 1. It gets the iov_iter count before calling generic_write_checks(), but
>    generic_write_checks() may truncate the iov_iter.
> 2. It returns the count or negative errno as a size_t, which the callers
>    cast to an int. If the count is greater than INT_MAX, this overflows.
> 
> To fix both of these, pull the call to generic_write_checks() out of
> btrfs_write_check(), use the new iov_iter count returned from
> generic_write_checks(), and have btrfs_write_check() return 0 or a
> negative errno as an int instead of the count. This rearrangement also
> paves the way for RWF_ENCODED write support.
> 
> Fixes: f945968ff64c ("btrfs: introduce btrfs_write_check()")

This patch is still in misc-next and the commit id is unstable, so this
would rather be folded to the patch.
