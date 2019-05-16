Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6106D20D0D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2019 18:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbfEPQbg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 May 2019 12:31:36 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:59076 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726449AbfEPQbg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 May 2019 12:31:36 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hRJI2-0003d6-Oy; Thu, 16 May 2019 16:31:30 +0000
Date:   Thu, 16 May 2019 17:31:30 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     David Howells <dhowells@redhat.com>
Cc:     torvalds@linux-foundation.org,
        Christian Brauner <christian@brauner.io>,
        Arnd Bergmann <arnd@arndb.de>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] uapi, vfs: Change the mount API UAPI [ver #2]
Message-ID: <20190516163130.GC17978@ZenIV.linux.org.uk>
References: <155800752418.4037.9567789434648701032.stgit@warthog.procyon.org.uk>
 <20190516162259.GB17978@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190516162259.GB17978@ZenIV.linux.org.uk>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 16, 2019 at 05:22:59PM +0100, Al Viro wrote:
> On Thu, May 16, 2019 at 12:52:04PM +0100, David Howells wrote:
> > 
> > Hi Linus, Al,
> > 
> > Here are some patches that make changes to the mount API UAPI and two of
> > them really need applying, before -rc1 - if they're going to be applied at
> > all.
> 
> I'm fine with 2--4, but I'm not convinced that cloexec-by-default crusade
> makes any sense.  Could somebody give coherent arguments in favour of
> abandoning the existing conventions?

To elaborate: existing syscalls (open, socket, pipe, accept, epoll_create,
etc., etc.) are not cloexec-by-default and that's not going to change,
simply because it would be break the living hell out of existing userland
code.

IOW, the userland has to worry about leaking stuff over sensitive execve(),
no matter what.  All this change does is complicate things for userland
programmer - which syscall belongs to which class.

Where's the benefit?  I could buy an argument about gradually changing
over to APIs that are cloexec-by-default across the board, except for
the obvious fact that it's not going to happen; not with the things
like open() involved.
