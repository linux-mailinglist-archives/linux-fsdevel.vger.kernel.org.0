Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0749A559EF9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jun 2022 19:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbiFXREY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jun 2022 13:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiFXREX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jun 2022 13:04:23 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BB2F496A8;
        Fri, 24 Jun 2022 10:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+JlPblHj298RSV4RwpXuBx3bs2gJY9n03Wq3MnP3sxo=; b=Glcc6QI4RTFVLChQBAzIwvxaga
        8IcvcO23VhrBLWdVIIx3PNc/u+fImaWogffg4r1sGEQ3TlqQSJ5LM4TU6ncGQCHLSiyaT5zA66jSf
        MM3L3V2jZiHZBL9BhZBM5kyy13IBQaqwVXBStTFdyDmUq3fDE8Fqx8WFoYRvsWRc6UdOSLdUVPcD8
        rYutEHaIEYDzdK0UhHMSg12C8fiR9NKWGunpRqk+rnvfv49luzUzym/CK9ad4F37Vf2EUSXOdsafU
        iN9TkqMCtfrmOQHYbK6Ssa69qa4BIzbouCZyZ4Ylbx9MZy47LrY6k5ydTNc+VJIxJ8yx6UbU6n3w0
        0zRy4iRw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1o4mjD-0040SU-Mh;
        Fri, 24 Jun 2022 17:04:19 +0000
Date:   Fri, 24 Jun 2022 18:04:19 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/6] fs: clear FMODE_LSEEK if no llseek function
Message-ID: <YrXuk+zOt4xFRDMI@ZenIV>
References: <20220624165631.2124632-1-Jason@zx2c4.com>
 <20220624165631.2124632-4-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220624165631.2124632-4-Jason@zx2c4.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 24, 2022 at 06:56:28PM +0200, Jason A. Donenfeld wrote:
> This helps unify a longstanding wart where FMODE_LSEEK hasn't been
> uniformly unset when it should be.
> 
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
>  fs/file_table.c | 2 ++
>  fs/open.c       | 2 ++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/fs/file_table.c b/fs/file_table.c
> index 5424e3a8df5f..15700b2e1b53 100644
> --- a/fs/file_table.c
> +++ b/fs/file_table.c
> @@ -241,6 +241,8 @@ static struct file *alloc_file(const struct path *path, int flags,
>  	if ((file->f_mode & FMODE_WRITE) &&
>  	     likely(fop->write || fop->write_iter))
>  		file->f_mode |= FMODE_CAN_WRITE;
> +	if ((file->f_mode & FMODE_LSEEK) && !file->f_op->llseek)
> +		file->f_mode &= ~FMODE_LSEEK;

	Where would FMODE_LSEEK come from in this one?  ->f_mode is set
(in __alloc_file()) to OPEN_FMODE(flags); that does deal with FMODE_READ
and FMODE_WRITE, but FMODE_LSEEK will be clear...
