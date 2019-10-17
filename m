Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E667DABC9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2019 14:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393226AbfJQMNC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Oct 2019 08:13:02 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:55323 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731634AbfJQMNC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Oct 2019 08:13:02 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-98.corp.google.com [104.133.0.98] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x9HCCqag024199
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Oct 2019 08:12:53 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 13A9E420458; Thu, 17 Oct 2019 08:12:52 -0400 (EDT)
Date:   Thu, 17 Oct 2019 08:12:52 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Wang Shilong <wangshilong1991@gmail.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Li Xi <lixi@ddn.com>, Wang Shilong <wshilong@ddn.com>
Subject: Re: [Project Quota]file owner could change its project ID?
Message-ID: <20191017121251.GB25548@mit.edu>
References: <CAP9B-QmQ-mbWgJwEWrVOMabsgnPwyJsxSQbMkWuFk81-M4dRPQ@mail.gmail.com>
 <20191013164124.GR13108@magnolia>
 <CAP9B-Q=SfhnA6iO7h1TWAoSOfZ+BvT7d8=OE4176FZ3GXiU-xw@mail.gmail.com>
 <20191016213700.GH13108@magnolia>
 <648712FB-0ECE-41F4-B6B8-98BD3168B2A4@dilger.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <648712FB-0ECE-41F4-B6B8-98BD3168B2A4@dilger.ca>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 16, 2019 at 06:28:08PM -0600, Andreas Dilger wrote:
> I don't think that this is really "directory quotas" in the end, since it
> isn't changing the semantics that the same projid could exist in multiple
> directory trees.  The real difference is the ability to enforce existing
> project quota limits for regular users outside of a container.  Basically,
> it is the same as regular users not being able to change the UID of their
> files to dump quota to some other user.
> 
> So rather than rename this "dirquota", it would be better to have a
> an option like "projid_enforce" or "projid_restrict", or maybe some
> more flexibility to allow only users in specific groups to change the
> projid like "projid_admin=<gid>" so that e.g. "staff" or "admin" groups
> can still change it (in addition to root) but not regular users.  To
> restrict it to root only, leave "projid_admin=0" and the default (to
> keep the same "everyone can change projid" behavior) would be -1?

I'm not sure how common the need for restsrictive quota enforcement is
really going to be.  Can someone convince me this is actually going to
be a common use case?

We could also solve the problem by adding an LSM hook called when
there is an attempt to set the project ID, and for people who really
want this, they can create a stackable LSM which enforces whatever
behavior they want.

If we think this going to be an speciality request, this might be the
better way to go.

						- Ted
