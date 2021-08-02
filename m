Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79EF43DE1C6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Aug 2021 23:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231782AbhHBVko (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Aug 2021 17:40:44 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:36938 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbhHBVkm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Aug 2021 17:40:42 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 071BC21ADD;
        Mon,  2 Aug 2021 21:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1627940431; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZaoW8ZjBkYswdMN0RjCXfMc5JKZhdW+ljJasal8djZU=;
        b=u65NS0zsVZhYk2KnafJsz7kdjahqqXJ3VjHvJ73W+wTLgIyhyHP3tqR5KMi0UQ/zau3Yjs
        djE+eMeo3q+2ZMQj0CHQ9xiPJLwpRadqnYpEQw3cZoiLTw6nnJh7x7lnlnXdhXie8voCwR
        3+nw96+pIL2hngGTzAVDeVUeQPkyxJM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1627940431;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZaoW8ZjBkYswdMN0RjCXfMc5JKZhdW+ljJasal8djZU=;
        b=lWQb8HsRoDv6kNAvRxEL7k/tWjty1J2k84zWoZvHbvVBbDGdPWroy42Cxs+Dq+2qLDpMKa
        xZh4EqMv4iZdw2AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8E62F13CAE;
        Mon,  2 Aug 2021 21:40:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id lAzDEktmCGHABwAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 02 Aug 2021 21:40:27 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Martin Steigerwald" <martin@lichtvoll.de>
Cc:     "Miklos Szeredi" <miklos@szeredi.hu>,
        "Al Viro" <viro@zeniv.linux.org.uk>,
        "Christoph Hellwig" <hch@infradead.org>,
        "Josef Bacik" <josef@toxicpanda.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        "Chuck Lever" <chuck.lever@oracle.com>, "Chris Mason" <clm@fb.com>,
        "David Sterba" <dsterba@suse.com>, linux-fsdevel@vger.kernel.org,
        "Linux NFS list" <linux-nfs@vger.kernel.org>,
        "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>
Subject: Re: A Third perspective on BTRFS nfsd subvol dev/inode number issues.
In-reply-to: <3318968.VgehHcluNF@ananda>
References: <162742539595.32498.13687924366155737575.stgit@noble.brown>,
 <CAJfpegub4oBZCBXFQqc8J-zUiSW+KaYZLjZaeVm_cGzNVpxj+A@mail.gmail.com>,
 <162787790940.32159.14588617595952736785@noble.neil.brown.name>,
 <3318968.VgehHcluNF@ananda>
Date:   Tue, 03 Aug 2021 07:40:24 +1000
Message-id: <162794042436.32159.11858951186865829131@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 02 Aug 2021, Martin Steigerwald wrote:
> Hi Neil!
> 
> Wow, this is a bit overwhelming for me. However, I got a very specific 
> question for userspace developers in order to probably provide valuable 
> input to the KDE Baloo desktop search developers:
> 
> NeilBrown - 02.08.21, 06:18:29 CEST:
> > The "obvious" choice for a replacement is the file handle provided by
> > name_to_handle_at() (falling back to st_ino if name_to_handle_at isn't
> > supported by the filesystem).  This returns an extensible opaque
> > byte-array.  It is *already* more reliable than st_ino.  Comparing
> > st_ino is only a reliable way to check if two files are the same if
> > you have both of them open.  If you don't, then one of the files
> > might have been deleted and the inode number reused for the other.  A
> > filehandle contains a generation number which protects against this.
> > 
> > So I think we need to strongly encourage user-space to start using
> > name_to_handle_at() whenever there is a need to test if two things are
> > the same.
> 
> How could that work for Baloo's use case to see whether a file it 
> encounters is already in its database or whether it is a new file.
> 
> Would Baloo compare the whole file handle or just certain fields or make a 
> hash of the filehandle or what ever? Could you, in pseudo code or 
> something, describe the approach you'd suggest. I'd then share it on:

Yes, the whole filehandle.

 struct file_handle {
        unsigned int handle_bytes; /* Size of f_handle [in, out] */
        int           handle_type;    /* Handle type [out] */
        unsigned char f_handle[0]; /* File identifier (sized by
                                     caller) [out] */
 };

i.e.  compare handle_type, handle_bytes, and handle_bytes worth of
f_handle.
This file_handle is local to the filesytem.  Two different filesystems
can use the same filehandle for different files.  So the identity of the
filesystem need to be combined with the file_handle.

> 
> Bug 438434 - Baloo appears to be indexing twice the number of files than 
> are actually in my home directory
> 
> https://bugs.kde.org/438434

This bug wouldn't be address by using the filehandle.  Using a
filehandle allows you to compare two files within a single filesystem.
This bug is about comparing two filesystems either side of a reboot, to
see if they are the same.

As has already been mentioned in that bug, statfs().f_fsid is the best
solution (unless comparing the mount point is satisfactory).

NeilBrown
