Return-Path: <linux-fsdevel+bounces-588-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DFC17CD4A2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 08:47:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CFE6B210FD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 06:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 928288F51;
	Wed, 18 Oct 2023 06:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5495E6AD6
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Oct 2023 06:46:51 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14C20B6;
	Tue, 17 Oct 2023 23:46:49 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5A68967373; Wed, 18 Oct 2023 08:46:46 +0200 (CEST)
Date: Wed, 18 Oct 2023 08:46:46 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>,
	Jan Kara <jack@suse.cz>, Denis Efremov <efremov@linux.com>,
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/5] block: move bdev_mark_dead out of
 disk_check_media_change
Message-ID: <20231018064646.GA18710@lst.de>
References: <20231017184823.1383356-1-hch@lst.de> <20231017184823.1383356-4-hch@lst.de> <ZS9ODABLaRVcI5iy@fedora>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZS9ODABLaRVcI5iy@fedora>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Oct 18, 2023 at 11:16:28AM +0800, Ming Lei wrote:
> On Tue, Oct 17, 2023 at 08:48:21PM +0200, Christoph Hellwig wrote:
> > disk_check_media_change is mostly called from ->open where it makes
> > little sense to mark the file system on the device as dead, as we
> > are just opening it.  So instead of calling bdev_mark_dead from
> > disk_check_media_change move it into the few callers that are not
> > in an open instance.  This avoid calling into bdev_mark_dead and
> > thus taking s_umount with open_mutex held.
> 
> ->open() is called when opening bdev every times, and there can be
> existed openers, so not sure if it makes little sense here.

Yes. It has to be a non-exclusive open, though, and how is that going
to help us with any general use case?  If we really want to make the
media change notifications any useful we'd better just do the work
straight from the workqueue that polls for it.


