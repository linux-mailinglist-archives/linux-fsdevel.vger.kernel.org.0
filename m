Return-Path: <linux-fsdevel+bounces-5126-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0581808325
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 09:37:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88461282ED8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 08:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CE94328DE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 08:37:01 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5FBF137;
	Wed,  6 Dec 2023 23:32:36 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
	id B952F227A87; Thu,  7 Dec 2023 08:32:32 +0100 (CET)
Date: Thu, 7 Dec 2023 08:32:32 +0100
From: Christoph Hellwig <hch@lst.de>
To: Theodore Ts'o <tytso@mit.edu>
Cc: Dave Chinner <david@fromorbit.com>, hch@lst.de,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] [RFC] iomap: Use FUA for pure data O_DSYNC DIO writes
Message-ID: <20231207073232.GA18798@lst.de>
References: <20180301014144.28892-1-david@fromorbit.com> <20231207065046.GA9663@mit.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231207065046.GA9663@mit.edu>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Dec 07, 2023 at 01:50:46AM -0500, Theodore Ts'o wrote:
> Today, ext4 does use iomap for DIO, but an experiment seems to
> indicate that something hasn't been wired up to enable FUA for O_DSYNC
> writes.  I've looked at fs/iomap/direct-io.c and it wasn't immediately
> obvious what I need to add to enable this feature.
> 
> I was wondering if you could me some quick hints about what and where
> I should be looking?

There isn't really anything strange going on.  First your device needs to
support it.  For NVMe the feature is mandatory, but we still disable it
globally for SATA, and second you need to remember FUA only makes sense
for O_DSYNC-style writes, not O_SYNC that also writes out the inode.

Then you need to make sure neither IOMAP_F_SHARED nor IOMAP_F_DIRTY
is set on the iomap. IOMAP_F_SHARED is never set by ext4, so if none
of the above is the culprit I'd loke into if IOMAP_F_DIRTY and up
beeing set for your test I/O.


