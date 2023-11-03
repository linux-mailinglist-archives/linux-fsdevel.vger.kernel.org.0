Return-Path: <linux-fsdevel+bounces-1906-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C68BA7DFFA5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Nov 2023 09:14:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1BC6B21365
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Nov 2023 08:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A38258470;
	Fri,  3 Nov 2023 08:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07F18460
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Nov 2023 08:14:10 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A05EA1B9;
	Fri,  3 Nov 2023 01:14:08 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 15F8B68AA6; Fri,  3 Nov 2023 09:14:06 +0100 (CET)
Date: Fri, 3 Nov 2023 09:14:05 +0100
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>
Cc: Chandan Babu R <chandanbabu@kernel.org>, Jan Kara <jack@suse.cz>,
	"Darrick J. Wong" <djwong@kernel.org>, viro@zeniv.linux.org.uk,
	axboe@kernel.dk, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	dchinner@fromorbit.com, Christoph Hellwig <hch@lst.de>
Subject: Re: [BUG REPORT] next-20231102: generic/311 fails on XFS with
 external log
Message-ID: <20231103081405.GC16854@lst.de>
References: <87bkccnwxc.fsf@debian-BULLSEYE-live-builder-AMD64> <20231102-teich-absender-47a27e86e78f@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231102-teich-absender-47a27e86e78f@brauner>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Nov 02, 2023 at 03:54:48PM +0100, Christian Brauner wrote:
> So you'll see EBUSY because the superblock was already frozen when the
> main block device was frozen. I was somewhat expecting that we may run
> into such issues.
> 
> I think we just need to figure out what we want to do in cases the
> superblock is frozen via multiple devices. It would probably be correct
> to keep it frozen as long as any of the devices is frozen?

As dave pointed out I think we need to bring back / keep the freeze
count.

