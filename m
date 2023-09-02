Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74CA979050C
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Sep 2023 06:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351509AbjIBEoW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 2 Sep 2023 00:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351477AbjIBEoV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 2 Sep 2023 00:44:21 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41E0C10F8;
        Fri,  1 Sep 2023 21:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jZEmoopfjFAadS37fL5Ohwd3FkpsxLZbrexmwjaT+jI=; b=T+Ak+8mknlf10plUIf8cqsZHYT
        Hg/jAlgEkRr5Sz7ydWcfTVC1vmPXaNFtla9tmSsHcPbSnJ9Jw6nfEzIwSfj05ridaggvrDJvMPZ/r
        Qrk1HiNzp+/cOUnUIk1RjKU0Do84Os+H7z4LvGUSIY9O+7QNZgDO1jSBN8ffJ7wgaCEPWw1hMCDae
        btCN/lhV1hmg9QJjiXwQZE+9gDRViUuWHPodrOlFX1kXdtL2GkyQNuETbziCmksUXyHEBJqtE7FGh
        mGQ1eU0yZvqgxdyX1TNZEG9PqTcK4uE7jsPLgaigyR4qKzzWgL3oPLVjr5mctPGk/3nEln0guwAel
        QiB7hSkw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qcIUV-002kR1-1A;
        Sat, 02 Sep 2023 04:44:11 +0000
Date:   Sat, 2 Sep 2023 05:44:11 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Seth Forshee <sforshee@kernel.org>,
        linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] file: always lock position
Message-ID: <20230902044411.GI3390869@ZenIV>
References: <20230724-vfs-fdget_pos-v1-1-a4abfd7103f3@kernel.org>
 <CAHk-=whfJhag+iEscftpVq=dHTeL7rQopCvH+Pcs8vJHCGNvXQ@mail.gmail.com>
 <20230724-scheren-absegnen-8c807c760ba1@brauner>
 <CAHk-=whwUTsixPwyBiuA25F2mAzARTU_-BijfmJ3MzkKLOYDmA@mail.gmail.com>
 <CAHk-=whtPzpL1D-VMHU9M6jbwSqFuXsc5u_6ePanVkBCNAYjMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whtPzpL1D-VMHU9M6jbwSqFuXsc5u_6ePanVkBCNAYjMQ@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 24, 2023 at 09:51:05AM -0700, Linus Torvalds wrote:
> On Mon, 24 Jul 2023 at 09:36, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > There are magic rules with "total_refs == inflight_refs", and that
> > total_refs thing is very much the file count, ie
> >
> >                 total_refs = file_count(u->sk.sk_socket->file);
> >
> > where we had some nasty bugs with files coming back to life.
> 
> Ok, I don't think this is an issue here. It really is that "only
> in-flight refs remaining" that is a special case, and even
> pidfd_getfd() shouldn't be able to change that.
> 
> But the magic code is all in fget_task(), and those need to be checked.
> 
> You can see how proc does things properly: it does do "fget_task()",
> but then it only uses it to copy the path part, and just does fput()
> afterwards.
> 
> The bpf code does something like that too, and seems ok (ie it gets
> the file in order to copy data from it, not to install it).

Aside of fget_task() use, it has this:
        rcu_read_lock();
        for (;; curr_fd++) {
                struct file *f;
                f = task_lookup_next_fd_rcu(curr_task, &curr_fd);
                if (!f)
                        break;
                if (!get_file_rcu(f))
                        continue;

                /* set info->fd */
                info->fd = curr_fd;
                rcu_read_unlock();
                return f;
        }

curr_task is not cached current here - it can be an arbitrary thread.
And what we do to the file reference we get here is

        ctx.meta = &meta;
        ctx.task = info->task;
        ctx.fd = info->fd;
        ctx.file = file;
        return bpf_iter_run_prog(prog, &ctx);

I think it can't be used to shove it into any descriptor table, but
then there's forming an SCM_RIGHTS datagram and sending it, etc. -
it might be worth looking into.
