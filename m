Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E427635A15C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Apr 2021 16:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233527AbhDIOq0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Apr 2021 10:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232884AbhDIOq0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Apr 2021 10:46:26 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D590C061760
        for <linux-fsdevel@vger.kernel.org>; Fri,  9 Apr 2021 07:46:13 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lUsOe-0042Ik-W4; Fri, 09 Apr 2021 14:46:09 +0000
Date:   Fri, 9 Apr 2021 14:46:08 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: fsnotify path hooks
Message-ID: <YHBosOH6Zju1oVPt@zeniv-ca.linux.org.uk>
References: <CAOQ4uxhWE9JGOZ_jN9_RT5EkACdNWXOryRsm6Wg_zkaDNDSjsA@mail.gmail.com>
 <20210401102947.GA29690@quack2.suse.cz>
 <CAOQ4uxjHFkRVTY5iyTSpb0R5R6j-j=8+Htpu2hgMAz9MTci-HQ@mail.gmail.com>
 <CAOQ4uxjS56hjaXeTUdce2gJT3tTFb2Zs1_PiUJZzXF9i-SPGkw@mail.gmail.com>
 <20210408125258.GB3271@quack2.suse.cz>
 <CAOQ4uxhrvKkK3RZRoGTojpyiyVmQpLWknYiKs8iN=Uq+mhOvsg@mail.gmail.com>
 <20210409100811.GA20833@quack2.suse.cz>
 <CAOQ4uxi5Njbp-yd_ohNbuxdbeLsYDYaqooYeTp+LpaSnxs2r4A@mail.gmail.com>
 <YHBk9f6aQ/TMsj5n@zeniv-ca.linux.org.uk>
 <20210409143901.pksgu6apbll7q3lt@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210409143901.pksgu6apbll7q3lt@wittgenstein>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 09, 2021 at 04:39:01PM +0200, Christian Brauner wrote:
> On Fri, Apr 09, 2021 at 02:30:13PM +0000, Al Viro wrote:
> > On Fri, Apr 09, 2021 at 04:22:58PM +0300, Amir Goldstein wrote:
> > 
> > > But we are actually going in cycles around the solution that we all want,
> > > but fear of rejection. It's time to try and solicit direct feedback from Al.
> > > 
> > > Al,
> > > 
> > > would you be ok with passing mnt arg to vfs_create() and friends,
> > > so that we can pass that to fsnotify_create() (and friends) in order to
> > > be able to report FAN_CREATE events to FAN_MARK_MOUNT listeners?
> > 
> > I would very much prefer to avoid going that way.
> 
> Fwif and if I understand this correctly then this would mostly matter
> for stacking filesystems or filesystems that already have access to the
> relevant struct vfsmount they need to talk about anyway. It's not about
> passing struct vfsmount into inode methods themselves which would be a
> bad idea.  Meaning Amir's change would not require or cause vfsmounts
> to be made accessible where they arent't already.

AFAICS, you are getting caught on mount marks semantics (or lack thereof).
It's _not_ "event happened to something visible here"; it's "event had
been requested by way that explicitly refers to that mount".

And that, IMO, pushes that crap from the places where the work is done
to the places where it had been requested.
