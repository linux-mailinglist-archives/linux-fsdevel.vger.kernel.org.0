Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AECE35A146
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Apr 2021 16:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234011AbhDIOjU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Apr 2021 10:39:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:39786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232990AbhDIOjT (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Apr 2021 10:39:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CD77B61008;
        Fri,  9 Apr 2021 14:39:04 +0000 (UTC)
Date:   Fri, 9 Apr 2021 16:39:01 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: fsnotify path hooks
Message-ID: <20210409143901.pksgu6apbll7q3lt@wittgenstein>
References: <CAOQ4uxjOyuvpJ7Tv3cGmv+ek7+z9BJBF4sK_-OLxwePUrHERUg@mail.gmail.com>
 <CAOQ4uxhWE9JGOZ_jN9_RT5EkACdNWXOryRsm6Wg_zkaDNDSjsA@mail.gmail.com>
 <20210401102947.GA29690@quack2.suse.cz>
 <CAOQ4uxjHFkRVTY5iyTSpb0R5R6j-j=8+Htpu2hgMAz9MTci-HQ@mail.gmail.com>
 <CAOQ4uxjS56hjaXeTUdce2gJT3tTFb2Zs1_PiUJZzXF9i-SPGkw@mail.gmail.com>
 <20210408125258.GB3271@quack2.suse.cz>
 <CAOQ4uxhrvKkK3RZRoGTojpyiyVmQpLWknYiKs8iN=Uq+mhOvsg@mail.gmail.com>
 <20210409100811.GA20833@quack2.suse.cz>
 <CAOQ4uxi5Njbp-yd_ohNbuxdbeLsYDYaqooYeTp+LpaSnxs2r4A@mail.gmail.com>
 <YHBk9f6aQ/TMsj5n@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YHBk9f6aQ/TMsj5n@zeniv-ca.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 09, 2021 at 02:30:13PM +0000, Al Viro wrote:
> On Fri, Apr 09, 2021 at 04:22:58PM +0300, Amir Goldstein wrote:
> 
> > But we are actually going in cycles around the solution that we all want,
> > but fear of rejection. It's time to try and solicit direct feedback from Al.
> > 
> > Al,
> > 
> > would you be ok with passing mnt arg to vfs_create() and friends,
> > so that we can pass that to fsnotify_create() (and friends) in order to
> > be able to report FAN_CREATE events to FAN_MARK_MOUNT listeners?
> 
> I would very much prefer to avoid going that way.

Fwif and if I understand this correctly then this would mostly matter
for stacking filesystems or filesystems that already have access to the
relevant struct vfsmount they need to talk about anyway. It's not about
passing struct vfsmount into inode methods themselves which would be a
bad idea.  Meaning Amir's change would not require or cause vfsmounts
to be made accessible where they arent't already.
