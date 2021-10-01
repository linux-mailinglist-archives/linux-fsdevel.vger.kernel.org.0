Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2B5F41F51D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Oct 2021 20:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354452AbhJASnq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Oct 2021 14:43:46 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:35368 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231826AbhJASn2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Oct 2021 14:43:28 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 191IfVMf008675
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 1 Oct 2021 14:41:32 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id ABED215C34AA; Fri,  1 Oct 2021 14:41:31 -0400 (EDT)
Date:   Fri, 1 Oct 2021 14:41:31 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Shreeya Patel <shreeya.patel@collabora.com>
Cc:     viro@zeniv.linux.org.uk, adilger.kernel@dilger.ca,
        krisman@collabora.com, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH 2/2] fs: ext4: Fix the inconsistent name exposed by
 /proc/self/cwd
Message-ID: <YVdWW0uyRqYWSgVP@mit.edu>
References: <cover.1632909358.git.shreeya.patel@collabora.com>
 <8402d1c99877a4fcb152de71005fa9cfb25d86a8.1632909358.git.shreeya.patel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8402d1c99877a4fcb152de71005fa9cfb25d86a8.1632909358.git.shreeya.patel@collabora.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 29, 2021 at 04:23:39PM +0530, Shreeya Patel wrote:
> /proc/self/cwd is a symlink created by the kernel that uses whatever
> name the dentry has in the dcache. Since the dcache is populated only
> on the first lookup, with the string used in that lookup, cwd will
> have an unexpected case, depending on how the data was first looked-up
> in a case-insesitive filesystem.
> 
> Steps to reproduce :-
> 
> root@test-box:/src# mkdir insensitive/foo
> root@test-box:/src# cd insensitive/FOO
> root@test-box:/src/insensitive/FOO# ls -l /proc/self/cwd
> lrwxrwxrwx 1 root root /proc/self/cwd -> /src/insensitive/FOO
> 
> root@test-box:/src/insensitive/FOO# cd ../fOo
> root@test-box:/src/insensitive/fOo# ls -l /proc/self/cwd
> lrwxrwxrwx 1 root root /proc/self/cwd -> /src/insensitive/FOO
> 
> Above example shows that 'FOO' was the name used on first lookup here and
> it is stored in dcache instead of the original name 'foo'. This results
> in inconsistent name exposed by /proc/self/cwd since it uses the name
> stored in dcache.
> 
> To avoid the above inconsistent name issue, handle the inexact-match string
> ( a string which is not a byte to byte match, but is an equivalent
> unicode string ) case in ext4_lookup which would store the original name
> in dcache using d_add_ci instead of the inexact-match string name.

I'm not sure this is a problem.  /proc/<pid>/cwd just needs to point
at the current working directory for the process.  Why do we care
whether it matches the case that was stored on disk?  Whether we use
/src/insensitive/FOO, or /src/insensitive/Foo, or
/src/insensitive/foo, all of these will reach the cwd for that
process.

					- Ted
