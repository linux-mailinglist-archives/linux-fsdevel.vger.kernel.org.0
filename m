Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 805D336EC6F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Apr 2021 16:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240469AbhD2OdR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Apr 2021 10:33:17 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:35550 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237338AbhD2OdO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Apr 2021 10:33:14 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 395D01F432F8
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Matthew Wilcox <willy@infradead.org>, fstests@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, preichl@redhat.com,
        kernel@collabora.com
Subject: Re: [PATCH] generic/453: Exclude filenames that are not supported
 by exfat
Organization: Collabora
References: <20210425223105.1855098-1-shreeya.patel@collabora.com>
        <20210426003430.GH235567@casper.infradead.org>
        <a49ecbfb-2011-0c7c-4405-b4548d22389d@collabora.com>
        <20210426123734.GK235567@casper.infradead.org>
        <bc7a33e8-7e9c-8045-e90e-bb53ec4f2c61@collabora.com>
        <20210427181116.GH3122235@magnolia> <YIloQDGP+0mRQdbP@mit.edu>
        <20210429003726.GG1251862@magnolia>
Date:   Thu, 29 Apr 2021 10:32:23 -0400
In-Reply-To: <20210429003726.GG1251862@magnolia> (Darrick J. Wong's message of
        "Wed, 28 Apr 2021 17:37:26 -0700")
Message-ID: <87eeet6u14.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

"Darrick J. Wong" <djwong@kernel.org> writes:

> On Wed, Apr 28, 2021 at 09:50:56AM -0400, Theodore Ts'o wrote:
>> On Tue, Apr 27, 2021 at 11:11:16AM -0700, Darrick J. Wong wrote:
>> > 
>> > TBH I think these tests (g/453 and g/454) are probably only useful for
>> > filesystems that allow unrestricted byte streams for names.
>> 
>> I'm actually a little puzzled about why these tests should exist:
>> 
>> # Create a directory with multiple filenames that all appear the same
>> # (in unicode, anyway) but point to different inodes.  In theory all
>> # Linux filesystems should allow this (filenames are a sequence of
>> # arbitrary bytes) even if the user implications are horrifying.
>> 
>> Why do we care about testing this?  The assertion "In all theory all
>> Linux filesystems should allow this" is clearly not true --- if you
>> enable unicode support for ext4 or f2fs, this will no longer be true,
>> and this is considered by some a _feature_ not a bug --- precisely
>> _because_ the user implications are horrifying.
>> 
>> So why does these tests exist?  Darrick, I see you added them in 2017
>> to test whether or not xfs_scrub will warn about confuable names, if
>> _check_xfs_scrub_does_unicode is true.  So we already understand that
>> it's possible for a file system checker to complain that these file
>> names are bad.
>
> Yes, that's exactly why this test (and generic/454) were created -- as a
> functional test for xfs_scrub's unicode checking.
>
>> It's not at all clear to me that asserting that all Linux file systems
>> _must_ treat file names as "bag of bits" and not apply any kind of
>> unicode normalization or strict unicode validation is a valid thing to
>> test for in 2021.
>
> Perhaps not.  These two tests do have the interesting side effect of
> catching filesystems that don't hew to the "names are bytestreams"
> philosophy.  In 2017, fstests usage seemed like it pretty narrowly
> included only the big three filesystems, so it amuses me to no end that
> four years went by before this discussion started. :P
>
> Nowadays with wider testing of other filesystems (thanks, Red Hat!) we
> should hide these behind _require_names_are_bytes or move them to
> tests/xfs/.
>
> Question -- the unicode case folding doesn't apply to xattr names,
> right?

No, they don't apply to xattr name in ext4 and f2fs.

-- 
Gabriel Krisman Bertazi
