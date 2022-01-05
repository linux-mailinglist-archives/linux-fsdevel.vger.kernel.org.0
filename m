Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D12634859D0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jan 2022 21:10:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243882AbiAEUKy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jan 2022 15:10:54 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:40776 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243875AbiAEUKx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jan 2022 15:10:53 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 96C7921117;
        Wed,  5 Jan 2022 20:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1641413452; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DyWt1G495VFeKjaC/pvT63EifJLiD3d3EYcDijVDLAI=;
        b=iTPfnt5Z3E+Mpp3QF36vdxNoL383jGjG0E6HoLxJKLXLmEaYVooU2p+zFjtAR/jcS7xWTZ
        BcYTlINkNuD9CqcVyKUUqLicnnbQwZ8tQTB6mW3+PR0mmHAQvmU0n3JJc4Q99SXOVUw+hP
        OBfhVeDpVk08xalZMRuWUg37pX+Iix0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1641413452;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DyWt1G495VFeKjaC/pvT63EifJLiD3d3EYcDijVDLAI=;
        b=3GeMv2N2/sO/6Nd1bvkjYwqleJ8sEQZu9Hx2KzxHZI0eskO7myfVyvDTBmWUlSF1Xlo2Ul
        CUr/9QZ6u3XNeKDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6F3FF13C0A;
        Wed,  5 Jan 2022 20:10:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 92jLGUz71WFeZAAAMHmgww
        (envelope-from <ddiss@suse.de>); Wed, 05 Jan 2022 20:10:52 +0000
Date:   Wed, 5 Jan 2022 21:10:51 +0100
From:   David Disseldorp <ddiss@suse.de>
To:     linux-fsdevel@vger.kernel.org
Cc:     Martin Wilck <mwilck@suse.com>, viro@zeniv.linux.org.uk,
        willy@infradead.org
Subject: Re: [PATCH v5 2/5] initramfs: add INITRAMFS_PRESERVE_MTIME Kconfig
 option
Message-ID: <20220105211051.7c1c5ab9@suse.de>
In-Reply-To: <20211213232007.26851-3-ddiss@suse.de>
References: <20211213232007.26851-1-ddiss@suse.de>
        <20211213232007.26851-3-ddiss@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 14 Dec 2021 00:20:05 +0100, David Disseldorp wrote:

> --- a/init/initramfs.c
> +++ b/init/initramfs.c
> @@ -17,6 +17,8 @@
...
> -static void __init dir_add(const char *name, time64_t mtime)
> -{
> -	struct dir_entry *de = kmalloc(sizeof(struct dir_entry), GFP_KERNEL);
> -	if (!de)
> -		panic_show_mem("can't allocate dir_entry buffer");
> -	INIT_LIST_HEAD(&de->list);
> -	de->name = kstrdup(name, GFP_KERNEL);
> -	de->mtime = mtime;
> -	list_add(&de->list, &dir_list);
> -}
...
> --- /dev/null
> +++ b/init/initramfs_mtime.h
...
> +static void __init dir_add(const char *name, time64_t mtime)
> +{
> +	struct dir_entry *de = kmalloc(sizeof(struct dir_entry), GFP_KERNEL);
> +	if (!de)
> +		panic("can't allocate dir_entry buffer");
> +	INIT_LIST_HEAD(&de->list);
> +	de->name = kstrdup(name, GFP_KERNEL);
> +	de->mtime = mtime;
> +	list_add(&de->list, &dir_list);
> +}

I might as well fix the unhandled kstrdup() failure, rather than copying
it here. I'll post another round which allocates the "name" buffer via
the dir_entry kmalloc() call.
