Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 047A342EDE6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Oct 2021 11:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237552AbhJOJor (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Oct 2021 05:44:47 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:50156 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237422AbhJOJop (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Oct 2021 05:44:45 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5A20821A61;
        Fri, 15 Oct 2021 09:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1634290958; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3L8o92GY4rt3yc7E9r1s0mXlW35nTFkDiFbjTAzNEt8=;
        b=YIqwh0rXmDmk4nvozYp/bzxxUBVFkolaLh5qln9cvERtsxY7Rb4GsF+edQEvh8FMhoWdrv
        bogYTVcQQDwqWxHq3jBxnlZisfg38je2EROtzfzdx1FI0HJqkZpWuic2hO6v+Eolr8HSST
        5UW6WLSLfKlKYAYZGzUH2WVEnGc2zYI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 149B613B5A;
        Fri, 15 Oct 2021 09:42:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id VsBmAg5NaWH3OgAAMHmgww
        (envelope-from <nborisov@suse.com>); Fri, 15 Oct 2021 09:42:38 +0000
Subject: Re: [PATCH v11 07/14] btrfs: add definitions + documentation for
 encoded I/O ioctls
To:     Omar Sandoval <osandov@osandov.com>, linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
References: <cover.1630514529.git.osandov@fb.com>
 <5d861feadc7b8e029e6006489179f62bc7594d4e.1630514529.git.osandov@fb.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <62133e1e-bb29-7764-c5db-51d5bb0a1e63@suse.com>
Date:   Fri, 15 Oct 2021 12:42:37 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <5d861feadc7b8e029e6006489179f62bc7594d4e.1630514529.git.osandov@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 1.09.21 г. 20:01, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> In order to allow sending and receiving compressed data without
> decompressing it, we need an interface to write pre-compressed data
> directly to the filesystem and the matching interface to read compressed
> data without decompressing it. This adds the definitions for ioctls to
> do that and detailed explanations of how to use them.
> 
> Signed-off-by: Omar Sandoval <osandov@fb.com>

One minor nit below but otherwise LGTM:

Reviewed-by: Nikolay Borisov <nborisov@suse.com>

<snip>

> +struct btrfs_ioctl_encoded_io_args {
> +	/* Input parameters for both reads and writes. */
> +
> +	/*
> +	 * iovecs containing encoded data.
> +	 *
> +	 * For reads, if the size of the encoded data is larger than the sum of
> +	 * iov[n].iov_len for 0 <= n < iovcnt, then the ioctl fails with
> +	 * ENOBUFS.
> +	 *
> +	 * For writes, the size of the encoded data is the sum of iov[n].iov_len
> +	 * for 0 <= n < iovcnt. This must be less than 128 KiB (this limit may
> +	 * increase in the future). This must also be less than or equal to
> +	 * unencoded_len.
> +	 */
> +	const struct iovec __user *iov;
> +	/* Number of iovecs. */
> +	unsigned long iovcnt;
> +	/*
> +	 * Offset in file.
> +	 *
> +	 * For writes, must be aligned to the sector size of the filesystem.
> +	 */
> +	__s64 offset;
> +	/* Currently must be zero. */
> +	__u64 flags;
> +

nit: A comment stating that the output params begin here could be added.

> 
