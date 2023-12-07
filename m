Return-Path: <linux-fsdevel+bounces-5175-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C8DC809058
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 19:43:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB99328175D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 18:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DD694F5F7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 18:43:32 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C14C4122;
	Thu,  7 Dec 2023 09:44:30 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 74937227A87; Thu,  7 Dec 2023 18:44:27 +0100 (CET)
Date: Thu, 7 Dec 2023 18:44:27 +0100
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Daejun Park <daejun7.park@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v5 02/17] fs: Move enum rw_hint into a new header file
Message-ID: <20231207174427.GB31184@lst.de>
References: <20231130013322.175290-1-bvanassche@acm.org> <20231130013322.175290-3-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130013322.175290-3-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Nov 29, 2023 at 05:33:07PM -0800, Bart Van Assche wrote:
> Move enum rw_hint into a new header file to prepare for using this data
> type in the block layer. Add the attribute __packed to reduce the space
> occupied by instances of this data type from four bytes to one byte.
> Change the data type of i_write_hint from u8 into enum rw_hint. Change
> the RWH_* constants into literal constants to prevent that
> <uapi/linux/fcntl.h> would have to be included.

If we split the definitions we need a conversion function.  That
might just have a bunch of BUILD_BUG_ON/static_asserts to check
the values are the same and otherwise do nothing, but we can't really
be sloppy here.


