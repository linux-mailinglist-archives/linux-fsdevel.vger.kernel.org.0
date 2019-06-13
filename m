Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D389544500
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2019 18:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392639AbfFMQlK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jun 2019 12:41:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:59174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726959AbfFMQlJ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jun 2019 12:41:09 -0400
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E48E220644;
        Thu, 13 Jun 2019 16:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560444069;
        bh=C34ebvo6AEFxf3EflJEFb177I+rCto2FjRJcZW9t0Io=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I7fdzUpQNPCk2YfMQVrLWDVqmuu43ACjuslQSremYqJQYV4iZABsStKEgi+mQA5A1
         ykJh+be+IyEGMtFTcsz0+PwyXSpLqAN/s89hUbH5dSgiwrN87aS2d0L/nI5CRC7g8u
         8Tdr9FHQ7nY1S7pVnpQiX6aJ+xqIBFhfDsxFi8zk=
Date:   Thu, 13 Jun 2019 09:41:07 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     David Howells <dhowells@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vfs: fsmount: add missing mntget()
Message-ID: <20190613164107.GA686@sol.localdomain>
References: <20190610183031.GE63833@gmail.com>
 <20190612184313.143456-1-ebiggers@kernel.org>
 <20190613084728.GA32129@miu.piliscsaba.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190613084728.GA32129@miu.piliscsaba.redhat.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 13, 2019 at 10:47:28AM +0200, Miklos Szeredi wrote:
> On Wed, Jun 12, 2019 at 11:43:13AM -0700, Eric Biggers wrote:
> > From: Eric Biggers <ebiggers@google.com>
> > 
> > sys_fsmount() needs to take a reference to the new mount when adding it
> > to the anonymous mount namespace.  Otherwise the filesystem can be
> > unmounted while it's still in use, as found by syzkaller.
> 
> So it needs one count for the file (which dentry_open() obtains) and one for the
> attachment into the anonymous namespace.  The latter one is dropped at cleanup
> time, so your patch appears to be correct at getting that ref.

Yes.

> 
> I wonder why such a blatant use-after-free was missed in normal testing.  RCU
> delayed freeing, I guess?

It's because mount freeing is delayed by task_work_add(), so normally the refcnt
would be dropped to -1 when the file is closed without problems.  The problems
only showed up if you took another reference, e.g. by fchdir().

> 
> How about this additional sanity checking patch?

Seems like a good idea.  Without my fix, the WARNING is triggered by the
following program (no fchdir() needed):

	int main(void)
	{
		int fs;

		fs = syscall(__NR_fsopen, "ramfs", 0);
		syscall(__NR_fsconfig, fs, 6, 0, 0, 0);
		syscall(__NR_fsmount, fs, 0, 0);
	}

Can you send it as a formal patch?

- Eric
