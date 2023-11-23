Return-Path: <linux-fsdevel+bounces-3553-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6210D7F64F7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Nov 2023 18:13:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D82D281BBA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Nov 2023 17:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A0653FE43;
	Thu, 23 Nov 2023 17:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="k5omMfob"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88096D42;
	Thu, 23 Nov 2023 09:13:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=1PVt9jFHLZyJOvNOweTTAr+mfv0r2vN5F3uo83rFOeM=; b=k5omMfobXlbs3nKnm6Y7p5XpTM
	BbyEoJZsEdpf6Kz2bX5ZuyivItc5gUHlbKeRuBPxRO6awg9VMR0KlhgNIfKsRKR/UzRSe/bCClLGL
	AGcVIHz8vx+E1GluuVF3yiR6oPl5HdWKA3vhlEmuK8jEgrwlQFsFLUbRtnDmoq8sD94sQkGIg9GmC
	DJg6ZPMC81fe7N8opXMUOA/asv/ZkU4HWTbr250Yb5sF57EqKRbDD0ioVXWfwm6gkHLjL+uZQ3rWx
	ge51hByqQ+JJaHZeNDYzTBJtG8IbmXbnj/HEEhi81q1VkMk9z1xB/7FcvPIWTJHhPGnvU1ezScJIc
	43XIg4vQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r6DG3-002Air-1I;
	Thu, 23 Nov 2023 17:12:55 +0000
Date: Thu, 23 Nov 2023 17:12:55 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Gabriel Krisman Bertazi <gabriel@krisman.be>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>, tytso@mit.edu,
	linux-f2fs-devel@lists.sourceforge.net, ebiggers@kernel.org,
	linux-fsdevel@vger.kernel.org, jaegeuk@kernel.org,
	linux-ext4@vger.kernel.org
Subject: Re: [f2fs-dev] [PATCH v6 0/9] Support negative dentries on
 case-insensitive ext4 and f2fs
Message-ID: <20231123171255.GN38156@ZenIV>
References: <20230816050803.15660-1-krisman@suse.de>
 <20231025-selektiert-leibarzt-5d0070d85d93@brauner>
 <655a9634.630a0220.d50d7.5063SMTPIN_ADDED_BROKEN@mx.google.com>
 <20231120-nihilismus-verehren-f2b932b799e0@brauner>
 <CAHk-=whTCWwfmSzv3uVLN286_WZ6coN-GNw=4DWja7NZzp5ytg@mail.gmail.com>
 <20231121022734.GC38156@ZenIV>
 <20231122211901.GJ38156@ZenIV>
 <CAHk-=wh5WYPN7BLSUjUr_VBsPTxHOcMHo1gOH2P4+5NuXAsCKA@mail.gmail.com>
 <87o7fkihst.fsf@>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o7fkihst.fsf@>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Nov 23, 2023 at 10:57:22AM -0500, Gabriel Krisman Bertazi wrote:
> Linus Torvalds <torvalds@linux-foundation.org> writes:
> 
> > Side note: Gabriel, as things are now, instead of that
> >
> >         if (!d_is_casefolded_name(dentry))
> >                 return 0;
> >
> > in generic_ci_d_revalidate(), I would suggest that any time a
> > directory is turned into a case-folded one, you'd just walk all the
> > dentries for that directory and invalidate negative ones at that
> > point. Or was there some reason I missed that made it a good idea to
> > do it at run-time after-the-fact?
> >
> 
> The problem I found with that approach, which I originally tried, was
> preventing concurrent lookups from racing with the invalidation and
> creating more 'case-sensitive' negative dentries.  Did I miss a way to
> synchronize with concurrent lookups of the children of the dentry?  We
> can trivially ensure the dentry doesn't have positive children by
> holding the parent lock, but that doesn't protect from concurrent
> lookups creating negative dentries, as far as I understand.

AFAICS, there is a problem with dentries that never came through
->lookup().  Unless I'm completely misreading your code, your
generic_ci_d_revalidate() is not called for them.  Ever.

Hash lookups are controlled by ->d_op of parent; that's where ->d_hash()
and ->d_compare() come from.  Revalidate comes from *child*.  You need
->d_op->d_revalidate of child dentry to be set to your generic_ci_d_revalidate().

The place where it gets set is generic_set_encrypted_ci_d_ops().  Look
at its callchain; in case of ext4 it gets called from ext4_lookup_dentry(),
which is called from ext4_lookup().  And dentry passed to it is the
argument of ->lookup().

Now take a look at open-by-fhandle stuff; all methods in there
(->fh_to_dentry(), ->fh_to_parent(), ->get_parent()) end up
returning d_obtain_alias(some inode).

We *do* call ->lookup(), all right - in reconnect_one(), while
trying to connect those suckers with the main tree.  But the way
it works is that d_splice_alias() in ext4_lookup() moves the
existing alias for subdirectory, connecting it to the parent.
That's not the dentry ext4_lookup() had set ->d_op on - that's
the dentry that came from d_obtain_alias().  And those do not
have ->d_op set by anything in your tree.

That's the problem I'd been talking about - there is a class of situations
where the work done by ext4_lookup() to set the state of dentry gets
completely lost.  After lookup you do have a dentry in the right place,
with the right name and inode, etc., but with NULL ->d_op->d_revalidate.

