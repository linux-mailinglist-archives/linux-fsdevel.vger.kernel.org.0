Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5D0035A1DD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Apr 2021 17:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234104AbhDIPUw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Apr 2021 11:20:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:57500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234076AbhDIPUv (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Apr 2021 11:20:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7A26160FE8;
        Fri,  9 Apr 2021 15:20:36 +0000 (UTC)
Date:   Fri, 9 Apr 2021 17:20:33 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: fsnotify path hooks
Message-ID: <20210409152033.gevjtxscobiksk6x@wittgenstein>
References: <20210401102947.GA29690@quack2.suse.cz>
 <CAOQ4uxjHFkRVTY5iyTSpb0R5R6j-j=8+Htpu2hgMAz9MTci-HQ@mail.gmail.com>
 <CAOQ4uxjS56hjaXeTUdce2gJT3tTFb2Zs1_PiUJZzXF9i-SPGkw@mail.gmail.com>
 <20210408125258.GB3271@quack2.suse.cz>
 <CAOQ4uxhrvKkK3RZRoGTojpyiyVmQpLWknYiKs8iN=Uq+mhOvsg@mail.gmail.com>
 <20210409100811.GA20833@quack2.suse.cz>
 <CAOQ4uxi5Njbp-yd_ohNbuxdbeLsYDYaqooYeTp+LpaSnxs2r4A@mail.gmail.com>
 <YHBk9f6aQ/TMsj5n@zeniv-ca.linux.org.uk>
 <20210409143901.pksgu6apbll7q3lt@wittgenstein>
 <YHBosOH6Zju1oVPt@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YHBosOH6Zju1oVPt@zeniv-ca.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 09, 2021 at 02:46:08PM +0000, Al Viro wrote:
> On Fri, Apr 09, 2021 at 04:39:01PM +0200, Christian Brauner wrote:
> > On Fri, Apr 09, 2021 at 02:30:13PM +0000, Al Viro wrote:
> > > On Fri, Apr 09, 2021 at 04:22:58PM +0300, Amir Goldstein wrote:
> > > 
> > > > But we are actually going in cycles around the solution that we all want,
> > > > but fear of rejection. It's time to try and solicit direct feedback from Al.
> > > > 
> > > > Al,
> > > > 
> > > > would you be ok with passing mnt arg to vfs_create() and friends,
> > > > so that we can pass that to fsnotify_create() (and friends) in order to
> > > > be able to report FAN_CREATE events to FAN_MARK_MOUNT listeners?
> > > 
> > > I would very much prefer to avoid going that way.
> > 
> > Fwif and if I understand this correctly then this would mostly matter
> > for stacking filesystems or filesystems that already have access to the
> > relevant struct vfsmount they need to talk about anyway. It's not about
> > passing struct vfsmount into inode methods themselves which would be a
> > bad idea.  Meaning Amir's change would not require or cause vfsmounts
> > to be made accessible where they arent't already.
> 
> AFAICS, you are getting caught on mount marks semantics (or lack thereof).
> It's _not_ "event happened to something visible here"; it's "event had
> been requested by way that explicitly refers to that mount".

Well yes, that's what mount marks are supposed to be afaict. I don't
think that's necessarily wrong though, at the least it can be quite
helpful.
