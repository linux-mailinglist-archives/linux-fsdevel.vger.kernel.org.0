Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF08836D8E7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Apr 2021 15:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238737AbhD1Nv4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Apr 2021 09:51:56 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:59229 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S239013AbhD1Nvz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Apr 2021 09:51:55 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 13SDourD012532
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Apr 2021 09:50:56 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 3A78115C3C3D; Wed, 28 Apr 2021 09:50:56 -0400 (EDT)
Date:   Wed, 28 Apr 2021 09:50:56 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Shreeya Patel <shreeya.patel@collabora.com>,
        Matthew Wilcox <willy@infradead.org>, fstests@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, krisman@collabora.com,
        preichl@redhat.com, kernel@collabora.com
Subject: Re: [PATCH] generic/453: Exclude filenames that are not supported by
 exfat
Message-ID: <YIloQDGP+0mRQdbP@mit.edu>
References: <20210425223105.1855098-1-shreeya.patel@collabora.com>
 <20210426003430.GH235567@casper.infradead.org>
 <a49ecbfb-2011-0c7c-4405-b4548d22389d@collabora.com>
 <20210426123734.GK235567@casper.infradead.org>
 <bc7a33e8-7e9c-8045-e90e-bb53ec4f2c61@collabora.com>
 <20210427181116.GH3122235@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210427181116.GH3122235@magnolia>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 27, 2021 at 11:11:16AM -0700, Darrick J. Wong wrote:
> 
> TBH I think these tests (g/453 and g/454) are probably only useful for
> filesystems that allow unrestricted byte streams for names.

I'm actually a little puzzled about why these tests should exist:

# Create a directory with multiple filenames that all appear the same
# (in unicode, anyway) but point to different inodes.  In theory all
# Linux filesystems should allow this (filenames are a sequence of
# arbitrary bytes) even if the user implications are horrifying.

Why do we care about testing this?  The assertion "In all theory all
Linux filesystems should allow this" is clearly not true --- if you
enable unicode support for ext4 or f2fs, this will no longer be true,
and this is considered by some a _feature_ not a bug --- precisely
_because_ the user implications are horrifying.

So why does these tests exist?  Darrick, I see you added them in 2017
to test whether or not xfs_scrub will warn about confuable names, if
_check_xfs_scrub_does_unicode is true.  So we already understand that
it's possible for a file system checker to complain that these file
names are bad.

It's not at all clear to me that asserting that all Linux file systems
_must_ treat file names as "bag of bits" and not apply any kind of
unicode normalization or strict unicode validation is a valid thing to
test for in 2021.

					- Ted
