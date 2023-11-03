Return-Path: <linux-fsdevel+bounces-1922-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4C357E0493
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Nov 2023 15:19:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5FC21C20D46
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Nov 2023 14:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A96D1A287;
	Fri,  3 Nov 2023 14:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A472819BCA
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Nov 2023 14:19:45 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CF2E1BD
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Nov 2023 07:19:44 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
	id A349E67373; Fri,  3 Nov 2023 15:19:40 +0100 (CET)
Date: Fri, 3 Nov 2023 15:19:40 +0100
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>
Cc: Dave Chinner <dchinner@redhat.com>, Christoph Hellwig <hch@lst.de>,
	Jan Kara <jack@suse.cz>, "Darrick J. Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	Chandan Babu R <chandanbabu@kernel.org>
Subject: Re: [PATCH] fs: handle freezing from multiple devices
Message-ID: <20231103141940.GA3732@lst.de>
References: <87bkccnwxc.fsf@debian-BULLSEYE-live-builder-AMD64> <20231103-vfs-multi-device-freeze-v1-1-fe922b30bfb6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231103-vfs-multi-device-freeze-v1-1-fe922b30bfb6@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Nov 03, 2023 at 02:52:27PM +0100, Christian Brauner wrote:
> Fix this by counting the number of block devices that requested the
> filesystem to be frozen in @bdev_count in struct sb_writers and only
> unfreeze once the @bdev_count hits zero. Survives fstests and blktests
> and makes the reproducer succeed.

Is there a good reason to not just refcount the freezes in general?


