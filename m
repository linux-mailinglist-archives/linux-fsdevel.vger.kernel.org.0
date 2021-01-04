Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD4B2E9E0A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Jan 2021 20:18:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbhADTR4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Jan 2021 14:17:56 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:57610 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726338AbhADTR4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Jan 2021 14:17:56 -0500
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 104JH589020547
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 4 Jan 2021 14:17:05 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 37C9B15C3530; Mon,  4 Jan 2021 14:17:05 -0500 (EST)
Date:   Mon, 4 Jan 2021 14:17:05 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Andres Freund <andres@anarazel.de>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: fallocate(FALLOC_FL_ZERO_RANGE_BUT_REALLY) to avoid unwritten
 extents?
Message-ID: <X/NpsZ8tSPkCwsYE@mit.edu>
References: <20201230062819.yinrrp6uwfegsqo3@alap3.anarazel.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201230062819.yinrrp6uwfegsqo3@alap3.anarazel.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 29, 2020 at 10:28:19PM -0800, Andres Freund wrote:
> 
> Would it make sense to add a variant of FALLOC_FL_ZERO_RANGE that
> doesn't convert extents into unwritten extents, but instead uses
> blkdev_issue_zeroout() if supported?  Mostly interested in xfs/ext4
> myself, but ...

One thing to note is that there are some devices which support a write
zeros operation, but where it is *less* performant than actually
writing zeros via DMA'ing zero pages.  Yes, that's insane.
Unfortunately, there are a insane devices out there....

This is not hypothetical; I know this because we tried using write
zeros in mke2fs, and I got regression complaints where
mke2fs/mkfs.ext4 got substantially slower for some devices.

That doesn't meant that your proposal shouldn't be adopted.  But it
would be a good idea to have some kind of way to either allow some
kind of tuning knob to disable the user of zeroout (either in the
block device, file system, or in userspace), and/or some kind of way
to try to automatically figure out whether using zeroout is actually a
win, since most users aren't going to be up to adjusting a manual
tuning knob.

					- Ted
