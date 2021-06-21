Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E5793AEBC0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jun 2021 16:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbhFUOxl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Jun 2021 10:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbhFUOxl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Jun 2021 10:53:41 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2E57C061574;
        Mon, 21 Jun 2021 07:51:26 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvLGm-00ArVj-Ba; Mon, 21 Jun 2021 14:51:24 +0000
Date:   Mon, 21 Jun 2021 14:51:24 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Vivek Goyal <vgoyal@redhat.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, virtio-fs@redhat.com
Subject: Re: [PATCH 1/2] init: split get_fs_names
Message-ID: <YNCnbIpKeprhPfRO@zeniv-ca.linux.org.uk>
References: <20210621062657.3641879-1-hch@lst.de>
 <20210621062657.3641879-2-hch@lst.de>
 <YNCmTSTcubslmj7k@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNCmTSTcubslmj7k@zeniv-ca.linux.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 21, 2021 at 02:46:37PM +0000, Al Viro wrote:

> int __init get_filesystem_list(char *buf, bool is_dev)
> {
> 	int f = is_dev ? FS_REQUIRES_DEV : 0;
>         int left = PAGE_SIZE, count = 0;
>         struct file_system_type *p;
> 
>         read_lock(&file_systems_lock);
> 	for (p = file_systems; p; p = p->next) {
> 		if ((p->fs_flags & FS_REQUIRES_DEV) == f) {
> 			size_t len = strlen(p->name) + 1;
> 			if (len > left)
> 				break;
> 			memcpy(buf, p->name, len);
> 			buf += len;
> 			left -= len;
> 			count++;
> 		}
> 	}
>         read_unlock(&file_systems_lock);
> 	return count;
> }
> 
> Generates NUL-separated list, returns the number of list elements,
> the second argument is "what kind do you want"...

Actually, looking at the rest of the queue, that's only used for
!nodev ones, so might as well drop the flag here...
