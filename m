Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E45FD1E02A7
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 May 2020 21:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388186AbgEXT4M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 24 May 2020 15:56:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:54376 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388032AbgEXT4M (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 24 May 2020 15:56:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 2F79FADE2;
        Sun, 24 May 2020 19:56:13 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 4B354DA728; Sun, 24 May 2020 21:55:13 +0200 (CEST)
Date:   Sun, 24 May 2020 21:55:13 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <jth@kernel.org>
Cc:     David Sterba <dsterba@suse.cz>, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, Eric Biggers <ebiggers@google.com>,
        Richard Weinberger <richard@nod.at>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v3 3/3] btrfs: document btrfs authentication
Message-ID: <20200524195513.GN18421@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Johannes Thumshirn <jth@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Eric Biggers <ebiggers@google.com>,
        Richard Weinberger <richard@nod.at>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Jonathan Corbet <corbet@lwn.net>
References: <20200514092415.5389-1-jth@kernel.org>
 <20200514092415.5389-4-jth@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200514092415.5389-4-jth@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 14, 2020 at 11:24:15AM +0200, Johannes Thumshirn wrote:
> +User-data
> +~~~~~~~~~
> +
> +The checksums for the user or file-data are stored in a separate b-tree, the
> +checksum tree. As this tree in itself is authenticated, only the data stored
> +in it needs to be authenticated. This is done by replacing the checksums
> +stored on disk by the cryptographically secure keyed hash algorithm used for
> +the super-block and other meta-data. So each written file block will get
> +checksummed with the authentication key and without supplying the correct key
> +it is impossible to write data on disk, which can be read back without
> +failing the authentication test. If this test is failed, an I/O error is
> +reported back to the user.

With same key K and same contents of data block B, the keyed hash on two
different filesystems is the same. Ie. there's no per-filesystem salt
(like a UUID) or per-transaction salt (generation, block address).

For metadata the per-transaction salt is inherently there as the hash is
calculated with the header included (containing the increasing
generation) and the filesystem UUID (available via blkid) or chunk tree
UUID (not so easy to user to read).

So there's an obvious discrepancy in the additional data besides the
variable contents of the data and metadata blocks.

The weakness of the data blocks may aid some attacks (I don't have a
concrete suggestion where and how exatly).

Suggested fix is to have a data block "header", with similar contents as
the metadata blocks, eg.

struct btrfs_hash_header {
	u8 fsid[BTRFS_FSID_SIZE];
	u8 chunk_tree_uuid[BTRFS_UUID_SIZE];
	__le64 generation;
};

Perhaps also with some extra item for future extensions, set to zeros
for now.
