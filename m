Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CAC621145C4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2019 18:21:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730043AbfLERVg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Dec 2019 12:21:36 -0500
Received: from mx2.suse.de ([195.135.220.15]:55218 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726028AbfLERVg (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Dec 2019 12:21:36 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A0BB8B31B;
        Thu,  5 Dec 2019 17:21:33 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 0D3F8DA733; Thu,  5 Dec 2019 18:21:27 +0100 (CET)
Date:   Thu, 5 Dec 2019 18:21:27 +0100
From:   David Sterba <dsterba@suse.cz>
To:     David Howells <dhowells@redhat.com>
Cc:     torvalds@linux-foundation.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>, raven@themaw.net,
        Christian Brauner <christian@brauner.io>,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-block@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] pipe: Notification queue preparation
Message-ID: <20191205172127.GW2734@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, David Howells <dhowells@redhat.com>,
        torvalds@linux-foundation.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>, raven@themaw.net,
        Christian Brauner <christian@brauner.io>, keyrings@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-block@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20191205125826.GK2734@twin.jikos.cz>
 <31452.1574721589@warthog.procyon.org.uk>
 <1593.1575554217@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1593.1575554217@warthog.procyon.org.uk>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 05, 2019 at 01:56:57PM +0000, David Howells wrote:
> David Sterba <dsterba@suse.cz> wrote:
> 
> > [<0>] pipe_write+0x1be/0x4b0
> 
> Can you get me a line number of that?  Assuming you've built with -g, load
> vmlinux into gdb and do "i li pipe_write+0x1be".

I built it with -g (DEBUG_INFO) but there's no output for the command (gdb 8.2):

(gdb) i li pipe_write+0x1be
Function "pipe_write+0x1be" not defined.

But the address can tell something:

(gdb) l *(pipe_write+0x1be)
0xffffffff81390b8e is in pipe_write (fs/pipe.c:509).
warning: Source file is more recent than executable.
504                             kill_fasync(&pipe->fasync_readers, SIGIO, POLL_IN);
505                             do_wakeup = 0;
506                     }
507                     pipe->waiting_writers++;
508                     pipe_wait(pipe);
509                     pipe->waiting_writers--;
510             }
511     out:
512             __pipe_unlock(pipe);
513             if (do_wakeup) {

I rerun the test again (with a different address where it's stuck), there's
nothing better I can get from the debug info, it always points to pipe_wait,
disassembly points to:

   0xffffffff81390b71 <+417>:   jne    0xffffffff81390c23 <pipe_write+595>
   0xffffffff81390b77 <+423>:   test   %ecx,%ecx
   0xffffffff81390b79 <+425>:   jne    0xffffffff81390b95 <pipe_write+453>
   0xffffffff81390b7b <+427>:   addl   $0x1,0x110(%rbx)
   0xffffffff81390b82 <+434>:   mov    %rbx,%rdi
   0xffffffff81390b85 <+437>:   callq  0xffffffff813908c0 <pipe_wait>
   0xffffffff81390b8a <+442>:   subl   $0x1,0x110(%rbx)

(pipe_write+0x1ba == 0xffffffff81390b8a)
