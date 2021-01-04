Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 547342E9D94
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Jan 2021 19:58:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728009AbhADS6J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Jan 2021 13:58:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728004AbhADS6J (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Jan 2021 13:58:09 -0500
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70343C061794;
        Mon,  4 Jan 2021 10:57:28 -0800 (PST)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kwV2c-006qul-06; Mon, 04 Jan 2021 18:57:18 +0000
Date:   Mon, 4 Jan 2021 18:57:17 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        sargun@sargun.me, amir73il@gmail.com, vgoyal@redhat.com
Subject: Re: [PATCH][RESEND] vfs: serialize updates to file->f_sb_err with
 f_lock
Message-ID: <20210104185717.GK3579531@ZenIV.linux.org.uk>
References: <20210104184347.90598-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210104184347.90598-1-jlayton@kernel.org>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 04, 2021 at 01:43:47PM -0500, Jeff Layton wrote:
> @@ -172,7 +172,12 @@ SYSCALL_DEFINE1(syncfs, int, fd)
>  	ret = sync_filesystem(sb);
>  	up_read(&sb->s_umount);
>  
> -	ret2 = errseq_check_and_advance(&sb->s_wb_err, &f.file->f_sb_err);
> +	if (errseq_check(&sb->s_wb_err, f.file->f_sb_err)) {
> +		/* Something changed, must use slow path */
> +		spin_lock(&f.file->f_lock);
> +		ret2 = errseq_check_and_advance(&sb->s_wb_err, &f.file->f_sb_err);
> +		spin_unlock(&f.file->f_lock);
> +	}

	Is there any point bothering with the fastpath here?
I mean, look at the up_read() immediately prior to that thing...
