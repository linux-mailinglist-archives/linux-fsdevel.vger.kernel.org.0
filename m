Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5846421A6AF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jul 2020 20:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbgGISMa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Jul 2020 14:12:30 -0400
Received: from verein.lst.de ([213.95.11.211]:40401 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726684AbgGISMa (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Jul 2020 14:12:30 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2CC2968AEF; Thu,  9 Jul 2020 20:12:28 +0200 (CEST)
Date:   Thu, 9 Jul 2020 20:12:27 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Song Liu <song@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-raid@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 15/17] initramfs: switch initramfs unpacking to struct
 file based APIs
Message-ID: <20200709181227.GA20954@lst.de>
References: <20200709151814.110422-1-hch@lst.de> <20200709151814.110422-16-hch@lst.de> <CAHk-=whXq_149rcDv9ENkKeKpcEQ93MAvcmAOAbU8=bWG55X2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whXq_149rcDv9ENkKeKpcEQ93MAvcmAOAbU8=bWG55X2A@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 09, 2020 at 11:07:08AM -0700, Linus Torvalds wrote:
> On Thu, Jul 9, 2020 at 8:18 AM Christoph Hellwig <hch@lst.de> wrote:
> >
> > There is no good reason to mess with file descriptors from in-kernel
> > code, switch the initramfs unpacking to struct file based write
> > instead.  As we don't have nice helper for chmod or chown on a struct
> > file or struct path use the pathname based ones instead there.  This
> > causes additional (cached) lookups, but keeps the code much simpler.
> 
> This is the only one I'm not a huge fan of.
> 
> I agree about moving to 'struct file'. But then you could just do the
> chown/chmod using chown/chmod_common() on file->f_path.
> 
> That would keep the same semantics, and it feels like a more
> straightforward patch.
> 
> It would still remove the nasty ksys_fchmod/fchmod, it would just
> require our - already existing - *_common() functions to be non-static
> (and maybe renamed to "vfs_chown/chmod()" instead, that "*_common()"
> naming looks a bit odd compared to all our other "vfs_operation()"
> helpers).

Sure, we can do that.  It requires a little more boilerplate that I
thought we could just skip.
