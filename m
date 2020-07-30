Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5AB8232BE8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jul 2020 08:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728752AbgG3GZ2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jul 2020 02:25:28 -0400
Received: from verein.lst.de ([213.95.11.211]:54692 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728548AbgG3GZ2 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jul 2020 02:25:28 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 19D0968AFE; Thu, 30 Jul 2020 08:25:25 +0200 (CEST)
Date:   Thu, 30 Jul 2020 08:25:24 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: add file system helpers that take kernel pointers for the init
 code v4
Message-ID: <20200730062524.GA17980@lst.de>
References: <20200728163416.556521-1-hch@lst.de> <20200729195117.GE951209@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200729195117.GE951209@ZenIV.linux.org.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 29, 2020 at 08:51:17PM +0100, Al Viro wrote:
> On Tue, Jul 28, 2020 at 06:33:53PM +0200, Christoph Hellwig wrote:
> > Hi Al and Linus,
> > 
> > currently a lot of the file system calls in the early in code (and the
> > devtmpfs kthread) rely on the implicit set_fs(KERNEL_DS) during boot.
> > This is one of the few last remaining places we need to deal with to kill
> > off set_fs entirely, so this series adds new helpers that take kernel
> > pointers.  These helpers are in init/ and marked __init and thus will
> > be discarded after bootup.  A few also need to be duplicated in devtmpfs,
> > though unfortunately.
> >
> > The series sits on top of my previous
> > 
> >   "decruft the early init / initrd / initramfs code v2"
> 
> Could you fold the fixes in the parent branch to avoid the bisect hazards?
> As it is, you have e.g. "initd: pass a non-f_pos offset to kernel_read/kernel_write"
> that ought to go into "initrd: switch initrd loading to struct file based APIs"...

I'm not a huge fan of rebasing after it has been out for a long time and
with pending other patches on top of it.  But at your request I've now
folded the fixes and force pushed it.
