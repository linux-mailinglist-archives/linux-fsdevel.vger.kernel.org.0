Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7CDA2B71F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2019 16:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbfE0OA3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 May 2019 10:00:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:38294 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726071AbfE0OA3 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 May 2019 10:00:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CDF5AAC3F;
        Mon, 27 May 2019 14:00:27 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id D3D2B1E3C2F; Mon, 27 May 2019 16:00:24 +0200 (CEST)
Date:   Mon, 27 May 2019 16:00:24 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, David Sterba <dsterba@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Joel Becker <jlbec@evilplan.org>,
        John Johansen <john.johansen@canonical.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v3 03/10] rpc_pipefs: call fsnotify_{unlink,rmdir}() hooks
Message-ID: <20190527140024.GF20440@quack2.suse.cz>
References: <20190526143411.11244-1-amir73il@gmail.com>
 <20190526143411.11244-4-amir73il@gmail.com>
 <20190527105357.GD20440@quack2.suse.cz>
 <CAOQ4uxgmoWPsEiOrdBE5sF8-b5Hhw91eWCwO=WKbXfjgpsmu_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxgmoWPsEiOrdBE5sF8-b5Hhw91eWCwO=WKbXfjgpsmu_w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 27-05-19 16:26:03, Amir Goldstein wrote:
> On Mon, May 27, 2019 at 1:54 PM Jan Kara <jack@suse.cz> wrote:
> >
> > On Sun 26-05-19 17:34:04, Amir Goldstein wrote:
> > > This will allow generating fsnotify delete events after the
> > > fsnotify_nameremove() hook is removed from d_delete().
> > >
> > > Cc: Trond Myklebust <trond.myklebust@hammerspace.com>
> > > Cc: Anna Schumaker <anna.schumaker@netapp.com>
> > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > ---
> > >  net/sunrpc/rpc_pipe.c | 4 ++++
> > >  1 file changed, 4 insertions(+)
> >
> > Hum, I don't think all __rpc_depopulate() calls are guarded by i_rwsem
> > (e.g. those in rpc_gssd_dummy_populate()). Why aren't we using
> > rpc_depopulate() in those cases? Trond, Anna?
> >
> 
> Do we care? For fsnotify hook, we should only care that
> d_parent/d_name are stable.
> They are stable because rpc_pipefs has no rename.

Yeah, good point. Probably we don't. I was just wondering...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
