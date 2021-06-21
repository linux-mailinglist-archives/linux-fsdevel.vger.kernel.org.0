Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4259B3AEBA8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jun 2021 16:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbhFUOsz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Jun 2021 10:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbhFUOsy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Jun 2021 10:48:54 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41B2CC061574;
        Mon, 21 Jun 2021 07:46:40 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvLC9-00ArRc-HB; Mon, 21 Jun 2021 14:46:37 +0000
Date:   Mon, 21 Jun 2021 14:46:37 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Vivek Goyal <vgoyal@redhat.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, virtio-fs@redhat.com
Subject: Re: [PATCH 1/2] init: split get_fs_names
Message-ID: <YNCmTSTcubslmj7k@zeniv-ca.linux.org.uk>
References: <20210621062657.3641879-1-hch@lst.de>
 <20210621062657.3641879-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210621062657.3641879-2-hch@lst.de>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 21, 2021 at 08:26:56AM +0200, Christoph Hellwig wrote:
> Split get_fs_names into one function that splits up the command line
> argument, and one that gets the list of all registered file systems.

> +static void __init get_all_fs_names(char *page)
> +{
> +	int len = get_filesystem_list(page);
> +	char *s = page, *p, *next;
> +
> +	page[len] = '\0';
> +	for (p = page - 1; p; p = next) {
> +		next = strchr(++p, '\n');
> +		if (*p++ != '\t')
> +			continue;
> +		while ((*s++ = *p++) != '\n')
> +			;
> +		s[-1] = '\0';
>  	}
> +
>  	*s = '\0';
>  }

TBH, I would rather take that one into fs/filesystems.c.  Rationale:
get_filesystem_list(), for all its resemblance to /proc/filesystems
contents, is used only by init/*.c and it's not a big deal to make
it

int __init get_filesystem_list(char *buf, bool is_dev)
{
	int f = is_dev ? FS_REQUIRES_DEV : 0;
        int left = PAGE_SIZE, count = 0;
        struct file_system_type *p;

        read_lock(&file_systems_lock);
	for (p = file_systems; p; p = p->next) {
		if ((p->fs_flags & FS_REQUIRES_DEV) == f) {
			size_t len = strlen(p->name) + 1;
			if (len > left)
				break;
			memcpy(buf, p->name, len);
			buf += len;
			left -= len;
			count++;
		}
	}
        read_unlock(&file_systems_lock);
	return count;
}

Generates NUL-separated list, returns the number of list elements,
the second argument is "what kind do you want"...
