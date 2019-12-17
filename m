Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38D6E12230A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2019 05:17:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727707AbfLQERe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Dec 2019 23:17:34 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:37756 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727506AbfLQERe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Dec 2019 23:17:34 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ih4Id-0007Wf-6Z; Tue, 17 Dec 2019 04:17:31 +0000
Date:   Tue, 17 Dec 2019 04:17:31 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 12/12] vfs: don't parse "silent" option
Message-ID: <20191217041731.GV4203@ZenIV.linux.org.uk>
References: <20191128155940.17530-1-mszeredi@redhat.com>
 <20191128155940.17530-13-mszeredi@redhat.com>
 <20191217033721.GS4203@ZenIV.linux.org.uk>
 <CAJfpegtnyjm_qbfMo0neAvqdMymTPHxT2NZX70XnK_rD5xtKYw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegtnyjm_qbfMo0neAvqdMymTPHxT2NZX70XnK_rD5xtKYw@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 17, 2019 at 05:12:05AM +0100, Miklos Szeredi wrote:
> On Tue, Dec 17, 2019 at 4:37 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > On Thu, Nov 28, 2019 at 04:59:40PM +0100, Miklos Szeredi wrote:
> > > While this is a standard option as documented in mount(8), it is ignored by
> > > most filesystems.  So reject, unless filesystem explicitly wants to handle
> > > it.
> > >
> > > The exception is unconverted filesystems, where it is unknown if the
> > > filesystem handles this or not.
> > >
> > > Any implementation, such as mount(8), that needs to parse this option
> > > without failing can simply ignore the return value from fsconfig().
> >
> > Unless I'm missing something, that will mean that having it in /etc/fstab
> > for a converted filesystem (xfs, for example) will fail when booting
> > new kernel with existing /sbin/mount.  Doesn't sound like a good idea...
> 
> Nope, the mount(2) case is not changed (see second hunk).

How would mounting XFS end up calling legacy_parse_param(), rather than
the expected generic_parse_monolithic() -> vfs_parse_fs_string() ->
vfs_parse_fs_param() -> xfs_fc_parse_param()?
