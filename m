Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D256A26D03E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Sep 2020 02:54:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726098AbgIQAyp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Sep 2020 20:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbgIQAyo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Sep 2020 20:54:44 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BA9EC061756;
        Wed, 16 Sep 2020 17:54:43 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kIiC9-0005iJ-Ia; Thu, 17 Sep 2020 00:54:41 +0000
Date:   Thu, 17 Sep 2020 01:54:41 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, Daeho Jeong <daeho43@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] vfs: don't unnecessarily clone write access for
 writable fds
Message-ID: <20200917005441.GP3421308@ZenIV.linux.org.uk>
References: <20200611160534.55042-1-ebiggers@kernel.org>
 <20200629165014.GA20492@sol.localdomain>
 <20200916035914.GA825@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916035914.GA825@sol.localdomain>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 15, 2020 at 08:59:14PM -0700, Eric Biggers wrote:
> On Mon, Jun 29, 2020 at 09:50:14AM -0700, Eric Biggers wrote:
> > On Thu, Jun 11, 2020 at 09:05:34AM -0700, Eric Biggers wrote:
> > > From: Eric Biggers <ebiggers@google.com>
> > > 
> > > There's no need for mnt_want_write_file() to increment mnt_writers when
> > > the file is already open for writing, provided that
> > > mnt_drop_write_file() is changed to conditionally decrement it.
> > > 
> > > We seem to have ended up in the current situation because
> > > mnt_want_write_file() used to be paired with mnt_drop_write(), due to
> > > mnt_drop_write_file() not having been added yet.  So originally
> > > mnt_want_write_file() had to always increment mnt_writers.
> > > 
> > > But later mnt_drop_write_file() was added, and all callers of
> > > mnt_want_write_file() were paired with it.  This makes the compatibility
> > > between mnt_want_write_file() and mnt_drop_write() no longer necessary.

Umm...  That really needs to be put into D/f/porting; this kind of rule changes
(from "it used to work both ways" to "things quietly break if you use the
old variant") should come with explicit statement in there.

I'm certainly fine with unexporting mnt_clone_write() and making the damn
thing static, but as for the rest I would put an explicit "don't pair
mnt_drop_write() with mnt_want_write_file()" and wait for a cycle.
