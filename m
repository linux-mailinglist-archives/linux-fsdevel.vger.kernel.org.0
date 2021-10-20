Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C18AB4343BB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Oct 2021 05:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbhJTDNn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Oct 2021 23:13:43 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:37608 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229715AbhJTDNn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Oct 2021 23:13:43 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 19K3BCiq013315
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Oct 2021 23:11:12 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 00A2415C00CA; Tue, 19 Oct 2021 23:11:11 -0400 (EDT)
Date:   Tue, 19 Oct 2021 23:11:11 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Jan Kara <jack@suse.cz>, jack@suse.com, amir73il@gmail.com,
        djwong@kernel.org, david@fromorbit.com, dhowells@redhat.com,
        khazhy@google.com, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-api@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH v8 30/32] ext4: Send notifications on error
Message-ID: <YW+Iz82Tug5a2wbL@mit.edu>
References: <20211019000015.1666608-1-krisman@collabora.com>
 <20211019000015.1666608-31-krisman@collabora.com>
 <20211019154426.GR3255@quack2.suse.cz>
 <20211019160152.GT3255@quack2.suse.cz>
 <87o87lnee4.fsf@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o87lnee4.fsf@collabora.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 19, 2021 at 01:54:59PM -0300, Gabriel Krisman Bertazi wrote:
> >
> > E.g. here you pass the 'error' to fsnotify. This will be just standard
> > 'errno' number, not ext4 error code as described in the documentation. Also
> > note that frequently 'error' will be 0 which gets magically transformed to
> > EFSCORRUPTED in save_error_info() in the ext4 error handling below. So
> > there's clearly some more work to do...
> 
> The many 0 returns were discussed before, around v3.  You can notice one
> of my LTP tests is designed to catch that.  We agreed ext4 shouldn't be
> returning 0, and that we would write a patch to fix it, but I didn't
> think it belonged as part of this series.

The fact that ext4 passes 0 into __ext4_error() to mean EFSCORRUPTED
is an internal implementation detail, and as currently implemented it
is *not* a bug.  It was just a convenience to minimize the number of
call sites that needed to be modified when we added the feature of
storing the error code to be stored in the superblock.

So I think this is something that should be addressed in this
patchset, and it's pretty simple to do so.  It's just a matter of
doing something like this:

      fsnotify_sb_error(sb, NULL, error ? error : EFSCORRUPTED);


> You are also right about the EXT4_ vs. errno.  the documentation is
> buggy, since it was brought from the fs-specific descriptor days, which
> no longer exists.  Nevertheless, I think there is a case for always
> returning file system specific errors here, since they are more
> descriptive.

So the history is that ext4 specific errors were used because we were
storing them in the superblock --- and so we need an architecture
independent way of storing the error codes.  (Errno codes are not
stable across architectures; and consider what might happen if we had
error codes written on an say, an ARM platform, and then that disk is
attached to an Alpha, S390, or Power system?)

> Should we agree to follow the documentation and return FS specific
> errors instead of errno, then?

I disagree.  We should use errno's, for a couple of reasons.  First of
all, users of fsnotify shouldn't need to know which file system to
interpret the error codes.

Secondly, the reason why ext4 has file system specific error cdoes is
because those codes are written into the superblock, and errno's are
not stable across different architectures.  So for ext4, we needed to
worry what might happen if the error code was written while the file
system was mounted on say, an ARM-64 system, and then storage device
might get attached to a S390, Alpha, or PA-RISC system.  This is not a
problem that the fsnotify API needs to worry about.

Finally, the error codes that we used for the ext4 superblock are
*not* more descriptive than errno's --- we only have 16 ext4-specific
error codes, and there are far more errno values.

Cheers,

					- Ted
