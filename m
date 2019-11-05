Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD5F2F02BA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Nov 2019 17:31:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390158AbfKEQbJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Nov 2019 11:31:09 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:48257 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2390106AbfKEQbI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Nov 2019 11:31:08 -0500
Received: from callcc.thunk.org (ip-12-2-52-196.nyc.us.northamericancoax.com [196.52.2.12])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id xA5GSvB6019764
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 5 Nov 2019 11:28:58 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 26537420311; Tue,  5 Nov 2019 11:28:55 -0500 (EST)
Date:   Tue, 5 Nov 2019 11:28:55 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Matthew Bobrowski <mbobrowski@mbobrowski.org>
Cc:     jack@suse.cz, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, riteshh@linux.ibm.com
Subject: Re: [PATCH v7 11/11] ext4: introduce direct I/O write using iomap
 infrastructure
Message-ID: <20191105162855.GK28764@mit.edu>
References: <cover.1572949325.git.mbobrowski@mbobrowski.org>
 <e55db6f12ae6ff017f36774135e79f3e7b0333da.1572949325.git.mbobrowski@mbobrowski.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e55db6f12ae6ff017f36774135e79f3e7b0333da.1572949325.git.mbobrowski@mbobrowski.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 05, 2019 at 11:02:39PM +1100, Matthew Bobrowski wrote:
> +	ret = iomap_dio_rw(iocb, from, &ext4_iomap_ops, &ext4_dio_write_ops,
> +			   is_sync_kiocb(iocb) || unaligned_aio || extend);
> +
> +	if (extend)
> +		ret = ext4_handle_inode_extension(inode, offset, ret, count);
> +

Can we do a slight optimization here like this?

	ret = iomap_dio_rw(iocb, from, &ext4_iomap_ops, &ext4_dio_write_ops,
			   is_sync_kiocb(iocb) || unaligned_aio || extend);

	if (extend && ret != -EBIOCQUEUED)
		ret = ext4_handle_inode_extension(inode, offset, ret, count);


If iomap_dio_rw() returns -EBIOCQUEUED, there's no need to do any of
the ext4_handle_inode_extension --- in particular, there's no need to
call ext4_truncate_failed_write(), which has a bunch of extra
overhead, including taking and releasing i_data_sem.

	  	    	       		 - Ted
