Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 801C622E3B9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jul 2020 03:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbgG0Buo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Jul 2020 21:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726797AbgG0Buo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Jul 2020 21:50:44 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30E9DC0619D2;
        Sun, 26 Jul 2020 18:50:44 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jzsHm-003LpT-3z; Mon, 27 Jul 2020 01:50:38 +0000
Date:   Mon, 27 Jul 2020 02:50:38 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-kernel@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Song Liu <song@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-raid@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 12/23] initrd: switch initrd loading to struct file based
 APIs
Message-ID: <20200727015038.GA795125@ZenIV.linux.org.uk>
References: <20200714190427.4332-1-hch@lst.de>
 <20200714190427.4332-13-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200714190427.4332-13-hch@lst.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 14, 2020 at 09:04:16PM +0200, Christoph Hellwig wrote:

>  static int __init
> -identify_ramdisk_image(int fd, int start_block, decompress_fn *decompressor)
> +identify_ramdisk_image(struct file *file, int start_block,
> +		decompress_fn *decompressor)
>  {
....
> -	ksys_lseek(fd, start_block * BLOCK_SIZE, 0);
>  	kfree(buf);
>  	return nblocks;
>  }

You do realize that you've changed behaviour of that thing if start_block != 0?
Old one used to leave the things for subsequent reads to start at start_block * 512;
new one will ignore that.  So after

> -	nblocks = identify_ramdisk_image(in_fd, rd_image_start, &decompressor);
> +	nblocks = identify_ramdisk_image(in_file, rd_image_start, &decompressor);

you'll have in_file->f_pos left at 0 instead of rd_image_start * 512.

... affecting this

> -		if (crd_load(in_fd, out_fd, decompressor) == 0)
> +		if (crd_load(in_file, out_file, decompressor) == 0)


... and this

> -		ksys_read(in_fd, buf, BLOCK_SIZE);
> -		ksys_write(out_fd, buf, BLOCK_SIZE);
> +		kernel_read(in_file, buf, BLOCK_SIZE, &in_file->f_pos);
> +		kernel_write(out_file, buf, BLOCK_SIZE, &out_file->f_pos);

FWIW, I would suggest *not* bothering with ->f_pos and using two global
(well, file-static, obviously) variables instead.  And kill 'pos' in
identify_ramdisk_image() as well - use the in_pos instead.
