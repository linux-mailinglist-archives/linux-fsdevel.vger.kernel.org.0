Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 269AB4697BA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Dec 2021 15:05:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245083AbhLFOI0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Dec 2021 09:08:26 -0500
Received: from verein.lst.de ([213.95.11.211]:50605 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244907AbhLFOIY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Dec 2021 09:08:24 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 49AB068AFE; Mon,  6 Dec 2021 15:04:51 +0100 (CET)
Date:   Mon, 6 Dec 2021 15:04:51 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Amit Daniel Kachhap <amit.kachhap@arm.com>
Cc:     linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Vincenzo Frascino <Vincenzo.Frascino@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        kexec <kexec@lists.infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>, x86 <x86@kernel.org>
Subject: Re: [RFC PATCH 01/14] fs/proc/vmcore: Update read_from_oldmem()
 for user pointer
Message-ID: <20211206140451.GA4936@lst.de>
References: <20211203104231.17597-1-amit.kachhap@arm.com> <20211203104231.17597-2-amit.kachhap@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211203104231.17597-2-amit.kachhap@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 03, 2021 at 04:12:18PM +0530, Amit Daniel Kachhap wrote:
> +	return read_from_oldmem_to_kernel(buf, count, ppos,
> +					  cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT));

Overly long line.

> +ssize_t read_from_oldmem(char __user *ubuf, char *kbuf, size_t count,
> +			 u64 *ppos, bool encrypted)
>  {
>  	unsigned long pfn, offset;
>  	size_t nr_bytes;
> @@ -156,19 +163,27 @@ ssize_t read_from_oldmem(char *buf, size_t count,
>  		/* If pfn is not ram, return zeros for sparse dump files */
>  		if (!pfn_is_ram(pfn)) {
>  			tmp = 0;
> -			if (!userbuf)
> -				memset(buf, 0, nr_bytes);
> -			else if (clear_user(buf, nr_bytes))
> +			if (kbuf)
> +				memset(kbuf, 0, nr_bytes);
> +			else if (clear_user(ubuf, nr_bytes))
>  				tmp = -EFAULT;

This looks like a huge mess.  What speak against using an iov_iter
here?
