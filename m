Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D6E13DB06F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jul 2021 02:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232725AbhG3A5R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Jul 2021 20:57:17 -0400
Received: from zeniv-ca.linux.org.uk ([142.44.231.140]:42938 "EHLO
        zeniv-ca.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbhG3A5P (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Jul 2021 20:57:15 -0400
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m9Gpn-0053HG-6t; Fri, 30 Jul 2021 00:57:07 +0000
Date:   Fri, 30 Jul 2021 00:57:07 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        hch@lst.de, virtio-fs@redhat.com,
        v9fs-developer@lists.sourceforge.net, stefanha@redhat.com,
        miklos@szeredi.hu
Subject: Re: [PATCH v3 3/3] fs: simplify get_filesystem_list /
 get_all_fs_names
Message-ID: <YQNOY9H/6mJMWRNN@zeniv-ca.linux.org.uk>
References: <20210714202321.59729-1-vgoyal@redhat.com>
 <20210714202321.59729-4-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210714202321.59729-4-vgoyal@redhat.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 14, 2021 at 04:23:21PM -0400, Vivek Goyal wrote:

> +static int __init split_fs_names(char *page, char *names)
>  {
> +	int count = 0;
> +	char *p = page;
>  
> +	strcpy(p, root_fs_names);
> +	while (*p++) {
> +		if (p[-1] == ',')
> +			p[-1] = '\0';
>  	}
> +	*p = '\0';
> +
> +	for (p = page; *p; p += strlen(p)+1)
> +		count++;
>  
> +	return count;
>  }

Ummm....  The last part makes no sense - it counts '\0' in the array
pointed to be page, until the first double '\0' in there.  All of
which had been put there by the loop immediately prior to that one...

Incidentally, it treats stray ,, in root_fs_names as termination;
is that intentional?
