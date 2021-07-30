Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 996573DB053
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jul 2021 02:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235461AbhG3Aes (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Jul 2021 20:34:48 -0400
Received: from zeniv-ca.linux.org.uk ([142.44.231.140]:42802 "EHLO
        zeniv-ca.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbhG3Aer (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Jul 2021 20:34:47 -0400
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m9GTw-00530D-VC; Fri, 30 Jul 2021 00:34:33 +0000
Date:   Fri, 30 Jul 2021 00:34:32 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     NeilBrown <neilb@suse.de>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Josef Bacik <josef@toxicpanda.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>, linux-fsdevel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 05/11] VFS: new function: mount_is_internal()
Message-ID: <YQNJGHXvWiBD7US0@zeniv-ca.linux.org.uk>
References: <162742539595.32498.13687924366155737575.stgit@noble.brown>
 <162742546552.32498.14429836898036234922.stgit@noble.brown>
 <YQC99cfMkbGz3u1q@zeniv-ca.linux.org.uk>
 <162744316594.21659.15176398691432709276@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162744316594.21659.15176398691432709276@noble.neil.brown.name>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 28, 2021 at 01:32:45PM +1000, NeilBrown wrote:
> On Wed, 28 Jul 2021, Al Viro wrote:
> > On Wed, Jul 28, 2021 at 08:37:45AM +1000, NeilBrown wrote:
> > > This patch introduces the concept of an "internal" mount which is a
> > > mount where a filesystem has create the mount itself.
> > > 
> > > Both the mounted-on-dentry and the mount's root dentry must refer to the
> > > same superblock (they may be the same dentry), and the mounted-on dentry
> > > must be an automount.
> > 
> > And what happens if you mount --move it?
> > 
> > 
> If you move the mount, then the mounted-on dentry would not longer be an
> automount (....  I assume???...) so it would not longer be
> mount_is_internal().
> 
> I think that is reasonable.  Whoever moved the mount has now taken over
> responsibility for it - it no longer is controlled by the filesystem.
> The moving will have removed the mount from the list of auto-expire
> mounts, and the mount-trap will now be exposed and can be mounted-on
> again.
> 
> It would be just like unmounting the automount, and bind-mounting the
> same dentry elsewhere.

Once more, with feeling: what happens to your function if it gets called during
mount --move?

What locking environment is going to be provided for it?  And what is going
to provide said environment?
