Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E92B1E0CEE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 May 2020 13:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390189AbgEYL1V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 May 2020 07:27:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:55170 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388696AbgEYL1V (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 May 2020 07:27:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 56CE8AE25;
        Mon, 25 May 2020 11:27:22 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 453CCDA728; Mon, 25 May 2020 13:26:22 +0200 (CEST)
Date:   Mon, 25 May 2020 13:26:22 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Johannes Thumshirn <jth@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Eric Biggers <ebiggers@google.com>,
        Richard Weinberger <richard@nod.at>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v3 3/3] btrfs: document btrfs authentication
Message-ID: <20200525112622.GP18421@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Eric Biggers <ebiggers@google.com>,
        Richard Weinberger <richard@nod.at>,
        Jonathan Corbet <corbet@lwn.net>
References: <20200514092415.5389-1-jth@kernel.org>
 <20200514092415.5389-4-jth@kernel.org>
 <20200524195513.GN18421@twin.jikos.cz>
 <SN4PR0401MB35983AAF3D05F84AACCF8CF59BB30@SN4PR0401MB3598.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN4PR0401MB35983AAF3D05F84AACCF8CF59BB30@SN4PR0401MB3598.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 25, 2020 at 10:57:13AM +0000, Johannes Thumshirn wrote:
> On 24/05/2020 21:56, David Sterba wrote:
> > On Thu, May 14, 2020 at 11:24:15AM +0200, Johannes Thumshirn wrote:
> > For metadata the per-transaction salt is inherently there as the hash is
> > calculated with the header included (containing the increasing
> > generation) and the filesystem UUID (available via blkid) or chunk tree
> > UUID (not so easy to user to read).
> > 
> > So there's an obvious discrepancy in the additional data besides the
> > variable contents of the data and metadata blocks.
> > 
> > The weakness of the data blocks may aid some attacks (I don't have a
> > concrete suggestion where and how exatly).
> 
> Yes but wouldn't this also need a hash that is prone to a known plaintext
> attack or that has known collisions? But it would probably help in 
> brute-forcing the key K of the filesystem. OTOH fsid, generation and the 
> chunk-tree UUID can be read in plaintext from the FS as well so this would
> only mitigate a rainbow table like attack, wouldn't it?

The goal here is to make attacks harder at a small cost.

> > Suggested fix is to have a data block "header", with similar contents as
> > the metadata blocks, eg.
> > 
> > struct btrfs_hash_header {
> > 	u8 fsid[BTRFS_FSID_SIZE];
> > 	u8 chunk_tree_uuid[BTRFS_UUID_SIZE];
> > 	__le64 generation;
> > };
> > 
> > Perhaps also with some extra item for future extensions, set to zeros
> > for now.
> 
> This addition would be possible, yes. But if we'd add this header to every
> checksum in the checksum tree it would be an incompatible on-disk format
> change.

No. It's only in-memory and is built from known pieces of information
exactly to avoid storing it on disk.
