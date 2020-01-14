Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FC6613B2CE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2020 20:19:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728656AbgANTTJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jan 2020 14:19:09 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:44332 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726839AbgANTTJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jan 2020 14:19:09 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1irRiV-008EAO-3l; Tue, 14 Jan 2020 19:19:07 +0000
Date:   Tue, 14 Jan 2020 19:19:07 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: dcache: abstract take_name_snapshot() interface
Message-ID: <20200114191907.GC8904@ZenIV.linux.org.uk>
References: <20200114154034.30999-1-amir73il@gmail.com>
 <20200114162234.GZ8904@ZenIV.linux.org.uk>
 <CAOQ4uxjbRzuAPHbgyW+uGmamc=fZ=eT_p4wCSb0QT7edtUqu8Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjbRzuAPHbgyW+uGmamc=fZ=eT_p4wCSb0QT7edtUqu8Q@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 14, 2020 at 08:06:56PM +0200, Amir Goldstein wrote:
> > // NOTE: release_dentry_name_snapshot() will be needed for both copies.
> > clone_name_snapshot(struct name_snapshot *to, const struct name_snapshot *from)
> > {
> >         to->name = from->name;
> >         if (likely(to->name.name == from->inline_name)) {
> >                 memcpy(to->inline_name, from->inline_name,
> >                         to->name.len);
> >                 to->name.name = to->inline_name;
> >         } else {
> >                 struct external_name *p;
> >                 p = container_of(to->name.name, struct external_name, name[0]);
> >                 atomic_inc(&p->u.count);
> >         }
> > }
> >
> > and be done with that.  Avoids any extensions or tree-wide renamings, etc.
> 
> I started with something like this but than in one of the early
> revisions I needed
> to pass some abstract reference around before cloning the name into the event,
> but with my current patches I can get away with a simple:
> 
> if (data_type == FANOTIFY_EVENT_NAME)
>     clone_name_snapshot(&event->name, data);
> else if (dentry)
>     take_dentry_name_snapshot(&event->name, dentry);
> 
> So that simple interface should be good enough for my needs.

I really think it would be safer that way; do you want me to throw that into
vfs.git (#work.dcache, perhaps)?  I don't have anything going on in the
vicinity, so it's not likely to cause conflicts either way and nothing I'd
seen posted on fsdevel seems to be likely to step into it, IIRC, so...
Up to you.
