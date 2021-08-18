Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F21383F0DA6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Aug 2021 23:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234207AbhHRVrF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Aug 2021 17:47:05 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:51944 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234083AbhHRVrF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Aug 2021 17:47:05 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id BEC421FD35;
        Wed, 18 Aug 2021 21:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1629323188; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EgHjDINeg2XxswsLMKYY8ZYuGYfWFxsr/oizjLTGkDI=;
        b=m+0f9bZAyBHdJsXm1OkOfyvu516lqC/mc9IjlxxzKON9hVJFV/XJNw3erhe4jsSQTai0jF
        Yzl4FYW5INAZ8AjDOs56/rv+GI+g8RlfugzB9XQvWIoNzOFkfoTn43BXLnVQbCXdKRQ35n
        AMq6MDvlK9nO/2z06ZJvzXrvmgr0E9E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1629323188;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EgHjDINeg2XxswsLMKYY8ZYuGYfWFxsr/oizjLTGkDI=;
        b=LrX1ws6muGBnWTia7XCdv35pvSAvSnCNEnEn0qFFMYpgvOoW/F1f2SFXi3tgQGDlzr5oUv
        GDPZCQVkvJYWFQCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 91E3213DD5;
        Wed, 18 Aug 2021 21:46:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id suahE7F/HWFwXwAAMHmgww
        (envelope-from <neilb@suse.de>); Wed, 18 Aug 2021 21:46:25 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Wang Yugui" <wangyugui@e16-tech.com>
Cc:     "Christoph Hellwig" <hch@infradead.org>,
        "Josef Bacik" <josef@toxicpanda.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        "Chuck Lever" <chuck.lever@oracle.com>, "Chris Mason" <clm@fb.com>,
        "David Sterba" <dsterba@suse.com>,
        "Alexander Viro" <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] VFS/BTRFS/NFSD: provide more unique inode number for btrfs export
In-reply-to: <20210818225454.9558.409509F4@e16-tech.com>
References: <162742539595.32498.13687924366155737575.stgit@noble.brown>,
 <162881913686.1695.12479588032010502384@noble.neil.brown.name>,
 <20210818225454.9558.409509F4@e16-tech.com>
Date:   Thu, 19 Aug 2021 07:46:22 +1000
Message-id: <162932318266.9892.13600254282844823374@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 19 Aug 2021, Wang Yugui wrote:
> Hi,
> 
> We use  'swab64' to combinate 'subvol id' and 'inode' into 64bit in this
> patch.
> 
> case1:
> 'subvol id': 16bit => 64K, a little small because the subvol id is
> always increase?
> 'inode':	48bit * 4K per node, this is big enough.
> 
> case2:
> 'subvol id': 24bit => 16M,  this is big enough.
> 'inode':	40bit * 4K per node => 4 PB.  this is a little small?

I don't know what point you are trying to make with the above.

> 
> Is there a way to 'bit-swap' the subvol id, rather the current byte-swap?

Sure:
   for (i=0; i<64; i++) {
        new = (new << 1) | (old & 1)
        old >>= 1;
   }

but would it gain anything significant?

Remember what the goal is.  Most apps don't care at all about duplicate
inode numbers - only a few do, and they only care about a few inodes.
The only bug I actually have a report of is caused by a directory having
the same inode as an ancestor.  i.e.  in lots of cases, duplicate inode
numbers won't be noticed.

The behaviour of btrfs over NFS RELIABLY causes exactly this behaviour
of a directory having the same inode number as an ancestor.  The root of
a subtree will *always* do this.  If we JUST changed the inode numbers
of the roots of subtrees, then most observed problems would go away.  It
would change from "trivial to reproduce" to "rarely happens".  The patch
I actually propose makes it much more unlikely than that.  Even if
duplicate inode numbers do happen, the chance of them being noticed is
infinitesimal.  Given that, there is no point in minor tweaks unless
they can make duplicate inode numbers IMPOSSIBLE.

> 
> If not, maybe it is a better balance if we combinate 22bit subvol id and
> 42 bit inode?

This would be better except when it is worse.  We cannot know which will
happen more often.

As long as BTRFS allows object-ids and root-ids combined to use more
than 64 bits there can be no perfect solution.  There are many possible
solutions that will be close to perfect in practice.  swab64() is the
simplest that I could think of.  Picking any arbitrary cut-off (22/42,
24/40, ...) is unlikely to be better, and could is some circumstances be
worse.

My preference would be for btrfs to start re-using old object-ids and
root-ids, and to enforce a limit (set at mkfs or tunefs) so that the
total number of bits does not exceed 64.  Unfortunately the maintainers
seem reluctant to even consider this.

NeilBrown
