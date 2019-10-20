Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03520DE0E2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2019 00:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbfJTWZl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 20 Oct 2019 18:25:41 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:59696 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726537AbfJTWZl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 20 Oct 2019 18:25:41 -0400
Received: from callcc.thunk.org (pool-72-93-95-157.bstnma.fios.verizon.net [72.93.95.157])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x9KMPTNs021897
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 20 Oct 2019 18:25:30 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 43099420458; Sun, 20 Oct 2019 18:25:29 -0400 (EDT)
Date:   Sun, 20 Oct 2019 18:25:29 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Wang Shilong <wangshilong1991@gmail.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Li Xi <lixi@ddn.com>, Wang Shilong <wshilong@ddn.com>
Subject: Re: [Project Quota]file owner could change its project ID?
Message-ID: <20191020222529.GA6799@mit.edu>
References: <CAP9B-QmQ-mbWgJwEWrVOMabsgnPwyJsxSQbMkWuFk81-M4dRPQ@mail.gmail.com>
 <20191013164124.GR13108@magnolia>
 <CAP9B-Q=SfhnA6iO7h1TWAoSOfZ+BvT7d8=OE4176FZ3GXiU-xw@mail.gmail.com>
 <20191016213700.GH13108@magnolia>
 <648712FB-0ECE-41F4-B6B8-98BD3168B2A4@dilger.ca>
 <20191017121251.GB25548@mit.edu>
 <6F46FB6C-D1E3-4BB8-B150-B229801EE13B@dilger.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6F46FB6C-D1E3-4BB8-B150-B229801EE13B@dilger.ca>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Oct 20, 2019 at 02:19:19PM -0600, Andreas Dilger wrote:
> > We could also solve the problem by adding an LSM hook called when
> > there is an attempt to set the project ID, and for people who really
> > want this, they can create a stackable LSM which enforces whatever
> > behavior they want.
> 
> So, rather than add a few-line change that decides whether the user
> is allowed to change the projid for a file, we would instead add *more*
> lines to add a hook, then have to write and load an LSM that is called
> each time?  That seems backward to me.

I'm just not sure we've necessarily gotten the semantics right.  For
example, I could easily see someone else coming out of the woodwork
saying that The Right Model (tm) is one where users belong to a number
of projects (much like supplementary group ID's) and you should be
able to set the project of any file that you own to a project.

Or perhaps the policy is that you can only change the project ID if
the project ID has a non-zero project quota.  etc.

> > If we think this going to be an speciality request, this might be the
> > better way to go.
> 
> I don't see how this is more "speciality" than regular quota enforcement?
> Just like we impose limits on users and groups, it makes sense to impose
> a limit on a project, instead of just tracking it and then having to add
> extra machinery to impose the limit externally.

We *do* have regular quota enforcement.  The question here has nothing
to do with how quota tracking or enforcement work.  The question is
about what are the authorization checks and policy surrounding when
the project ID can modified.

Right now the policy is "the owner of the file can set the project ID
to any integer if it is issued from the initial user namespace;
otherwise, no changes to the project ID or the PROJINHERIT flag is
allowed".

Making it be "only root in the inital user namespace is allowed change
project ID or PROJINHERIT flag" is certain an alternate policy.  Are
we sure those are the only two possible policies that users might ask
for?

					- Ted
