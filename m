Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D81E344962
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Mar 2021 16:37:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbhCVPgq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Mar 2021 11:36:46 -0400
Received: from zeniv-ca.linux.org.uk ([142.44.231.140]:52274 "EHLO
        zeniv-ca.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbhCVPgf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Mar 2021 11:36:35 -0400
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lOMZO-008CS3-Es; Mon, 22 Mar 2021 15:34:18 +0000
Date:   Mon, 22 Mar 2021 15:34:18 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] buffer: a small optimization in grow_buffers
Message-ID: <YFi4+ojoqo4+n1EV@zeniv-ca.linux.org.uk>
References: <alpine.LRH.2.02.2103221002360.19948@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.02.2103221002360.19948@file01.intranet.prod.int.rdu2.redhat.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 22, 2021 at 10:05:05AM -0400, Mikulas Patocka wrote:
> This patch replaces a loop with a "tzcnt" instruction.
> 
> Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> 
> Index: linux-2.6/fs/buffer.c
> ===================================================================
> --- linux-2.6.orig/fs/buffer.c
> +++ linux-2.6/fs/buffer.c
> @@ -1020,11 +1020,7 @@ grow_buffers(struct block_device *bdev,
>  	pgoff_t index;
>  	int sizebits;
>  
> -	sizebits = -1;
> -	do {
> -		sizebits++;
> -	} while ((size << sizebits) < PAGE_SIZE);
> -
> +	sizebits = PAGE_SHIFT - __ffs(size);
>  	index = block >> sizebits;
>  
>  	/*

Applied.
