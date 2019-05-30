Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FF012FA99
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2019 13:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbfE3LAa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 May 2019 07:00:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:50354 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726359AbfE3LA3 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 May 2019 07:00:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8A629AEB8;
        Thu, 30 May 2019 11:00:27 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 928B31E3C08; Thu, 30 May 2019 13:00:24 +0200 (CEST)
Date:   Thu, 30 May 2019 13:00:24 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Ian Kent <raven@themaw.net>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-api@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        keyrings@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH 0/7] Mount, FS, Block and Keyrings notifications
Message-ID: <20190530110024.GB29237@quack2.suse.cz>
References: <155905930702.7587.7100265859075976147.stgit@warthog.procyon.org.uk>
 <CAOQ4uxjC1M7jwjd9zSaSa6UW2dbEjc+ZbFSo7j9F1YHAQxQ8LQ@mail.gmail.com>
 <20190529142504.GC32147@quack2.suse.cz>
 <CAOQ4uxjLzURf8c1UH_xCJKkuD2es8i-=P-ZNM=t3aFcZLMwXEg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjLzURf8c1UH_xCJKkuD2es8i-=P-ZNM=t3aFcZLMwXEg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 29-05-19 18:53:21, Amir Goldstein wrote:
> > > David,
> > >
> > > I am interested to know how you envision filesystem notifications would
> > > look with this interface.
> > >
> > > fanotify can certainly benefit from providing a ring buffer interface to read
> > > events.
> > >
> > > From what I have seen, a common practice of users is to monitor mounts
> > > (somehow) and place FAN_MARK_MOUNT fanotify watches dynamically.
> > > It'd be good if those users can use a single watch mechanism/API for
> > > watching the mount namespace and filesystem events within mounts.
> > >
> > > A similar usability concern is with sb_notify and FAN_MARK_FILESYSTEM.
> > > It provides users with two complete different mechanisms to watch error
> > > and filesystem events. That is generally not a good thing to have.
> > >
> > > I am not asking that you implement fs_notify() before merging sb_notify()
> > > and I understand that you have a use case for sb_notify().
> > > I am asking that you show me the path towards a unified API (how a
> > > typical program would look like), so that we know before merging your
> > > new API that it could be extended to accommodate fsnotify events
> > > where the final result will look wholesome to users.
> >
> > Are you sure we want to combine notification about file changes etc. with
> > administrator-type notifications about the filesystem? To me these two
> > sound like rather different (although sometimes related) things.
> >
> 
> Well I am sure that ring buffer for fanotify events would be useful, so
> seeing that David is proposing a generic notification mechanism, I wanted
> to know how that mechanism could best share infrastructure with fsnotify.
> 
> But apart from that I foresee the questions from users about why the
> mount notification API and filesystem events API do not have better
> integration.
> 
> The way I see it, the notification queue can serve several classes
> of notifications and fsnotify could be one of those classes
> (at least FAN_CLASS_NOTIF fits nicely to the model).

I agree that for some type of fsnotify uses a ring buffer would make sense.
But for others - such as permission events or unlimited queues - you cannot
really use the ring buffer and I don't like the idea of having different
ways of passing fsnotify events to userspace based on notification group
type...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
