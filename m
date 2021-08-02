Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 908613DD11D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Aug 2021 09:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232428AbhHBHZy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Aug 2021 03:25:54 -0400
Received: from luna.lichtvoll.de ([194.150.191.11]:36381 "EHLO
        mail.lichtvoll.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231649AbhHBHZx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Aug 2021 03:25:53 -0400
X-Greylist: delayed 630 seconds by postgrey-1.27 at vger.kernel.org; Mon, 02 Aug 2021 03:25:53 EDT
Received: from ananda.localnet (unknown [IPv6:2001:a62:1a6e:4000:77e0:fef8:7961:c8ea])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.lichtvoll.de (Postfix) with ESMTPSA id AB4A9298406;
        Mon,  2 Aug 2021 09:15:10 +0200 (CEST)
From:   Martin Steigerwald <martin@lichtvoll.de>
To:     Miklos Szeredi <miklos@szeredi.hu>, NeilBrown <neilb@suse.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Josef Bacik <josef@toxicpanda.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>, linux-fsdevel@vger.kernel.org,
        Linux NFS list <linux-nfs@vger.kernel.org>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: A Third perspective on BTRFS nfsd subvol dev/inode number issues.
Date:   Mon, 02 Aug 2021 09:15:09 +0200
Message-ID: <3318968.VgehHcluNF@ananda>
In-Reply-To: <162787790940.32159.14588617595952736785@noble.neil.brown.name>
References: <162742539595.32498.13687924366155737575.stgit@noble.brown> <CAJfpegub4oBZCBXFQqc8J-zUiSW+KaYZLjZaeVm_cGzNVpxj+A@mail.gmail.com> <162787790940.32159.14588617595952736785@noble.neil.brown.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Authentication-Results: mail.lichtvoll.de;
        auth=pass smtp.auth=martin2 smtp.mailfrom=martin@lichtvoll.de
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Neil!

Wow, this is a bit overwhelming for me. However, I got a very specific 
question for userspace developers in order to probably provide valuable 
input to the KDE Baloo desktop search developers:

NeilBrown - 02.08.21, 06:18:29 CEST:
> The "obvious" choice for a replacement is the file handle provided by
> name_to_handle_at() (falling back to st_ino if name_to_handle_at isn't
> supported by the filesystem).  This returns an extensible opaque
> byte-array.  It is *already* more reliable than st_ino.  Comparing
> st_ino is only a reliable way to check if two files are the same if
> you have both of them open.  If you don't, then one of the files
> might have been deleted and the inode number reused for the other.  A
> filehandle contains a generation number which protects against this.
> 
> So I think we need to strongly encourage user-space to start using
> name_to_handle_at() whenever there is a need to test if two things are
> the same.

How could that work for Baloo's use case to see whether a file it 
encounters is already in its database or whether it is a new file.

Would Baloo compare the whole file handle or just certain fields or make a 
hash of the filehandle or what ever? Could you, in pseudo code or 
something, describe the approach you'd suggest. I'd then share it on:

Bug 438434 - Baloo appears to be indexing twice the number of files than 
are actually in my home directory

https://bugs.kde.org/438434

Best,
-- 
Martin


