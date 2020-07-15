Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8922204EE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jul 2020 08:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728662AbgGOG1P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jul 2020 02:27:15 -0400
Received: from verein.lst.de ([213.95.11.211]:57655 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725823AbgGOG1P (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jul 2020 02:27:15 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 15E5467357; Wed, 15 Jul 2020 08:27:12 +0200 (CEST)
Date:   Wed, 15 Jul 2020 08:27:11 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Song Liu <song@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-raid@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 17/23] initramfs: switch initramfs unpacking to struct
 file based APIs
Message-ID: <20200715062711.GA21447@lst.de>
References: <20200714190427.4332-1-hch@lst.de> <20200714190427.4332-18-hch@lst.de> <CAHk-=whDbHL7x5Jx-CSz97=nVg4V_q45DsokX+X-Y-yZV4rPvw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whDbHL7x5Jx-CSz97=nVg4V_q45DsokX+X-Y-yZV4rPvw@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 14, 2020 at 12:31:01PM -0700, Linus Torvalds wrote:
> That "vcollected" is ugly and broken, and seems oh-so-wrong.
> 
> Because it's only use is:
> 
> 
> > -               ksys_close(wfd);
> > +               fput(wfile);
> >                 do_utime(vcollected, mtime);
> >                 kfree(vcollected);
> 
> which should just have done the exact same thing that you did with
> vfs_chown() and friends: we already have a "utimes_common()" that
> takes a path, and it could have been made into "vfs_utimes()", and
> then this whole vcollected confusion would go away and be replaced by
> 
>         vfs_truncate(&wfile->f_path, mtime);
> 
> (ok, with all the "timespec64 t[2]" things going on that do_utime()
> does now, but you get the idea).
> 
> Talk about de-crufting that initramfs unpacking..
> 
> But I don't hate this patch, I'm just pointing out that there's room
> for improvement.

I'll send another series to clean this up.  I had a few utimes related
patch in a later series and this fits in pretty well with those.
