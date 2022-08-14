Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB1B75925E0
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Aug 2022 19:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239867AbiHNR5h (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 14 Aug 2022 13:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiHNR5g (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 14 Aug 2022 13:57:36 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF13723BD8
        for <linux-fsdevel@vger.kernel.org>; Sun, 14 Aug 2022 10:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XGBBkRgnuvMaFljZfdPXcERGsQEtzrec5H/qoAIVEvM=; b=jhZcLue5RmvPZhmrYYkpxMgJSw
        BHE6IS2mB89Yt2V8sa205bOBDXVlzpqRXSJ9csYSFqW/xaBb9xshbQM93DqGXepglBfJKxLTZfbpP
        +FSKt0lhA2Cd/uqvtLstfv9jJpl4slR5qhMajEoE9TgSztXznYzdDad8/LjYdBj5DSRNEyAt51IE/
        ivLjK/zOZ1a/1haJQi4zYvkzPFAsO3Kxmzph9ot80obfZkqbuItkbV1Gqhdex1rBdgl2RgjTFudvm
        Lon7tSirHg5s6woIiAwdme8lqXJZ8KhLwUNFHKYMO1NEDktcwfb0suKrNBbxFRSEd8jzJQYgdhY05
        USI0ejoQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oNHrY-004JN1-6c;
        Sun, 14 Aug 2022 17:57:24 +0000
Date:   Sun, 14 Aug 2022 18:57:24 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] locks: fix TOCTOU race when granting write lease
Message-ID: <Yvk3hPpCsX4H2/MR@ZenIV>
References: <20220814152322.569296-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220814152322.569296-1-amir73il@gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Aug 14, 2022 at 06:23:22PM +0300, Amir Goldstein wrote:
> Thread A trying to acquire a write lease checks the value of i_readcount
> and i_writecount in check_conflicting_open() to verify that its own fd
> is the only fd referencing the file.
> 
> Thread B trying to open the file for read will call break_lease() in
> do_dentry_open() before incrementing i_readcount, which leaves a small
> window where thread A can acquire the write lease and then thread B
> completes the open of the file for read without breaking the write lease
> that was acquired by thread A.
> 
> Fix this race by incrementing i_readcount before checking for existing
> leases, same as the case with i_writecount.
> 
> Use a helper put_file_access() to decrement i_readcount or i_writecount
> in do_dentry_open() and __fput().
> 
> Fixes: 387e3746d01c ("locks: eliminate false positive conflicts for write lease")
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

Looks sane; I'd probably collapsed cleanup_file and cleanup_all while we are
at it, but then I can do that in a followup as well.

> +static inline void put_file_access(struct file *file)
> +{
> +	if ((file->f_mode & (FMODE_READ | FMODE_WRITE)) == FMODE_READ) {
> +		i_readcount_dec(file->f_inode);
> +	} else if (file->f_mode & FMODE_WRITER) {
> +		put_write_access(file->f_inode);
> +		__mnt_drop_write(file->f_path.mnt);
> +	}
> +}

What's the point of having it in linux/fs.h instead of internal.h?
