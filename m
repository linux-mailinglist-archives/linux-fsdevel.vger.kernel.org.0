Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68C1A243CA4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Aug 2020 17:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbgHMPh0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Aug 2020 11:37:26 -0400
Received: from verein.lst.de ([213.95.11.211]:46752 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726249AbgHMPhZ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Aug 2020 11:37:25 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id C439A68AFE; Thu, 13 Aug 2020 17:37:22 +0200 (CEST)
Date:   Thu, 13 Aug 2020 17:37:22 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     hch@lst.de, viro@ZenIV.linux.org.uk, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, kernel-team@fb.com,
        willy@infradead.org
Subject: Re: [PATCH][v2] proc: use vmalloc for our kernel buffer
Message-ID: <20200813153722.GA13844@lst.de>
References: <20200813145305.805730-1-josef@toxicpanda.com> <20200813153356.857625-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200813153356.857625-1-josef@toxicpanda.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 13, 2020 at 11:33:56AM -0400, Josef Bacik wrote:
> Since
> 
>   sysctl: pass kernel pointers to ->proc_handler
> 
> we have been pre-allocating a buffer to copy the data from the proc
> handlers into, and then copying that to userspace.  The problem is this
> just blind kmalloc()'s the buffer size passed in from the read, which in
> the case of our 'cat' binary was 64kib.  Order-4 allocations are not
> awesome, and since we can potentially allocate up to our maximum order,
> use vmalloc for these buffers.
> 
> Fixes: 32927393dc1c ("sysctl: pass kernel pointers to ->proc_handler")
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
> v1->v2:
> - Make vmemdup_user_nul actually do the right thing...sorry about that.
> 
>  fs/proc/proc_sysctl.c  |  6 +++---
>  include/linux/string.h |  1 +
>  mm/util.c              | 27 +++++++++++++++++++++++++++
>  3 files changed, 31 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
> index 6c1166ccdaea..207ac6e6e028 100644
> --- a/fs/proc/proc_sysctl.c
> +++ b/fs/proc/proc_sysctl.c
> @@ -571,13 +571,13 @@ static ssize_t proc_sys_call_handler(struct file *filp, void __user *ubuf,
>  		goto out;
>  
>  	if (write) {
> -		kbuf = memdup_user_nul(ubuf, count);
> +		kbuf = vmemdup_user_nul(ubuf, count);

Given that this can also do a kmalloc and thus needs to be paired
with kvfree shouldn't it be kvmemdup_user_nul?
