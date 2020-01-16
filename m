Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C14B13D7C1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2020 11:16:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730921AbgAPKQQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jan 2020 05:16:16 -0500
Received: from verein.lst.de ([213.95.11.211]:55216 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729476AbgAPKQQ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jan 2020 05:16:16 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 116AA68B20; Thu, 16 Jan 2020 11:16:13 +0100 (CET)
Date:   Thu, 16 Jan 2020 11:16:12 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     David Howells <dhowells@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Problems with determining data presence by examining extents?
Message-ID: <20200116101612.GB16435@lst.de>
References: <4467.1579020509@warthog.procyon.org.uk> <00fc7691-77d5-5947-5493-5c97f262da81@gmx.com> <27181AE2-C63F-4932-A022-8B0563C72539@dilger.ca> <afa71c13-4f99-747a-54ec-579f11f066a0@gmx.com> <20200115133101.GA28583@lst.de> <C0F67EC5-7B5D-4179-9F28-95B84D9CC326@dilger.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C0F67EC5-7B5D-4179-9F28-95B84D9CC326@dilger.ca>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 15, 2020 at 12:48:44PM -0700, Andreas Dilger wrote:
> I don't think either of those will be any better than FIEMAP, if the reason
> is that the underlying filesystem is filling in holes with actual data
> blocks to optimize the IO pattern.  SEEK_HOLE would not find a hole in
> the block allocation, and would happily return the block of zeroes to
> the caller.  Also, it isn't clear if SEEK_HOLE considers an allocated but
> unwritten extent to be a hole or a block?

It is supposed to treat unwritten extents that are not dirty as holes.
Note that fiemap can't even track the dirty state, so it will always give
you the wrong answer in some cases.  And that is by design given that it
is a debug tool to give you the file system extent layout and can't be
used for data integrity purposes.
