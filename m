Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32A0AFCB57
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2019 18:02:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbfKNRCN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Nov 2019 12:02:13 -0500
Received: from fieldses.org ([173.255.197.46]:44258 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726674AbfKNRCN (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Nov 2019 12:02:13 -0500
Received: by fieldses.org (Postfix, from userid 2815)
        id E4E4247F; Thu, 14 Nov 2019 12:02:12 -0500 (EST)
Date:   Thu, 14 Nov 2019 12:02:12 -0500
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org,
        linux-nfs@vger.kernel.org
Subject: Re: [RFC] is ovl_fh->fid really intended to be misaligned?
Message-ID: <20191114170212.GA18547@fieldses.org>
References: <20191114154723.GJ26530@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191114154723.GJ26530@ZenIV.linux.org.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 14, 2019 at 03:47:23PM +0000, Al Viro wrote:
> AFAICS, this
>         bytes = (fh->len - offsetof(struct ovl_fh, fid));
>         real = exportfs_decode_fh(mnt, (struct fid *)fh->fid,
>                                   bytes >> 2, (int)fh->type,
>                                   connected ? ovl_acceptable : NULL, mnt);
> in ovl_decode_real_fh() combined with
>                 origin = ovl_decode_real_fh(fh, ofs->lower_layers[i].mnt,
>                                             connected);
> in ovl_check_origin_fh(),
>         /* First lookup overlay inode in inode cache by origin fh */
>         err = ovl_check_origin_fh(ofs, fh, false, NULL, &stack);
> in ovl_lower_fh_to_d() and
>         struct ovl_fh *fh = (struct ovl_fh *) fid;
> ...
>                  ovl_lower_fh_to_d(sb, fh);
> in ovl_fh_to_dentry() leads to the pointer to struct fid passed to
> exportfs_decode_fh() being 21 bytes ahead of that passed to
> ovl_fh_to_dentry().  
> 
> However, alignment of struct fid pointers is 32 bits and quite a few
> places dealing with those (including ->fh_to_dentry() instances)
> do access them directly.  Argument of ->fh_to_dentry() is supposed
> to be 32bit-aligned, and callers generally guarantee that.  Your
> code, OTOH, violates the alignment systematically there - what
> it passes to layers' ->fh_to_dentry() (by way of exportfs_decode_fh())
> always has two lower bits different from what it got itself.
> 
> What do we do with that?  One solution would be to insert sane padding
> in ovl_fh, but the damn thing appears to be stored as-is in xattrs on
> disk, so that would require rather unpleasant operations reinserting
> the padding on the fly ;-/

Note that filehandles given to clients also have unlimited lifetimes, so
once we give them out we're committed to accepting them forever, at
least in theory.  The on-disk xattrs are probably the bigger deal,
though.

Would inserting the padding on the fly really be that bad?

> Another is to declare struct fid unaligned with explicit use of
> __aligned in declaration and let all code normally dealing with
> those pay the price.  Frankly, I don't like that - it's overlayfs
> mess, so penalizing the much older users doesn't sound like a good idea.
> Worse, any code that does (like overlayfs) cast the incoming
> struct fid * to a pointer to its own struct will still be in
> trouble - explicit cast is explicit cast, and it discards all
> alignment information (as yours has done).
> 
> BTW, your ->encode_fh() appears to report the length greater than
> the object it has returned...  Granted, the 3 overreported bytes
> will be right after the end of 4n+1-byte kmalloc'ed area, so they
> won't fall over the page boundary, but the values in those are left
> uninitialized.  And they are sent in over-the-wire representations;
> you ignore those on decode, but they are there.

So it's a minor information leak, at least.

--b.
