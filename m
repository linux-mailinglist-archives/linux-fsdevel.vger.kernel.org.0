Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6A21AF8B3
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Apr 2020 10:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725923AbgDSIT3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Apr 2020 04:19:29 -0400
Received: from verein.lst.de ([213.95.11.211]:35777 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725446AbgDSIT3 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Apr 2020 04:19:29 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5319B68BEB; Sun, 19 Apr 2020 10:19:26 +0200 (CEST)
Date:   Sun, 19 Apr 2020 10:19:26 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jeremy Kerr <jk@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>,
        linuxppc-dev@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: remove set_fs calls from the exec and coredump code v2
Message-ID: <20200419081926.GA12539@lst.de>
References: <20200414070142.288696-1-hch@lst.de> <87r1wl68gf.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r1wl68gf.fsf@x220.int.ebiederm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 17, 2020 at 05:41:52PM -0500, Eric W. Biederman wrote:
> > this series gets rid of playing with the address limit in the exec and
> > coredump code.  Most of this was fairly trivial, the biggest changes are
> > those to the spufs coredump code.
> >
> > Changes since v1:
> >  - properly spell NUL
> >  - properly handle the compat siginfo case in ELF coredumps
> 
> Quick question is exec from a kernel thread within the scope of what you
> are looking at?
> 
> There is a set_fs(USER_DS) in flush_old_exec whose sole purpose appears
> to be to allow exec from kernel threads.  Where the kernel threads
> run with set_fs(KERNEL_DS) until they call exec.

This series doesn't really look at that area.  But I don't think exec
from a kernel thread makes any sense, and cleaning up how to set the
initial USER_DS vs KERNEL_DS state is something I'll eventually get to,
it seems like a major mess at the moment.
