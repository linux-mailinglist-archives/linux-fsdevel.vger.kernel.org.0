Return-Path: <linux-fsdevel+bounces-5853-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDA808112EE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 14:31:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9095282287
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 13:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 280082D60F;
	Wed, 13 Dec 2023 13:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="YTgQ262h"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E817CAB;
	Wed, 13 Dec 2023 05:31:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=SXfH8Llt0jxmPv2myg0rD8VmQvDP6rhPvEfTH/AwkCE=; b=YTgQ262hq3ggMN7vyDDIz8Eqtu
	ikkWyXyLiN2Uhbg+PRQ+hN11PbOPCm+x3g4mCaGBn7A9NVYOXrAzzL8jZ4agYKKkqMzp9dae1YolE
	TBFLyY7o2DtammUpBSJY+o9yAx6QKcNZ3SaImPXjDOEEAu6dDTiiP10Y5J129WNNV39iJq7eb8zmT
	6Kx7l1fE5YiVAwxiL+Yp09DvTvuXIlMwdrwgMhc9dNtGyi+54Hj6n4n+PSHn6JEnW1XRMofwxMeRO
	BKywIExN6rudbNMrUmDUucuOF/XIXS4LKB08O4YFByoC/fIzP3LSrGPtQ/VaJkS5CWV5VD0CrVboW
	2Cgyl4Xg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rDPKQ-00BmIC-0J;
	Wed, 13 Dec 2023 13:31:10 +0000
Date: Wed, 13 Dec 2023 13:31:10 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
	jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
	brauner@kernel.org, dchinner@redhat.com, jack@suse.cz,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
	linux-scsi@vger.kernel.org, ming.lei@redhat.com,
	jaswin@linux.ibm.com, bvanassche@acm.org,
	Prasad Singamsetty <prasad.singamsetty@oracle.com>
Subject: Re: [PATCH v2 05/16] fs: Add RWF_ATOMIC and IOCB_ATOMIC flags for
 atomic write support
Message-ID: <20231213133110.GL1674809@ZenIV>
References: <20231212110844.19698-1-john.g.garry@oracle.com>
 <20231212110844.19698-6-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212110844.19698-6-john.g.garry@oracle.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Dec 12, 2023 at 11:08:33AM +0000, John Garry wrote:

> Add file mode flag FMODE_CAN_ATOMIC_WRITE, so files which do not have the
> flag set will have RWF_ATOMIC rejected and not just ignored.
> 
> Signed-off-by: Prasad Singamsetty <prasad.singamsetty@oracle.com>
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>  include/linux/fs.h      | 8 ++++++++
>  include/uapi/linux/fs.h | 5 ++++-
>  2 files changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 70329c81be31..d725c194243c 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -185,6 +185,9 @@ typedef int (dio_iodone_t)(struct kiocb *iocb, loff_t offset,
>  /* File supports async nowait buffered writes */
>  #define FMODE_BUF_WASYNC	((__force fmode_t)0x80000000)
>  
> +/* File supports atomic writes */
> +#define FMODE_CAN_ATOMIC_WRITE	((__force fmode_t)0x100000000)

Have you even tried to compile that on e.g. arm?

