Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BBF034147A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Mar 2021 06:04:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233681AbhCSFDu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Mar 2021 01:03:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23235 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231787AbhCSFDn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Mar 2021 01:03:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616130222;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LXR7KUdiD2nZ60gkCrtJLv9zSRNsS39j5/g+KI/hLgM=;
        b=gAqPdL+z8ZfNFs7j7duzC/CfbyZ8eXQPKiuPH7PjyBndb5vZTiOqDgTecx7bWTeUyfc8ZC
        7np90hk4UkEGSmNx+1U/RnrRqNqU7c5hp8gs7htWLlb2deaQB8lLXoSHmc+5mLtZ9bLqEV
        uT2ydxbwjgGnwLIGkA0fO6UU6rCzoaU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-113-XWXX7RjiMQ2qbI4jqnTOJw-1; Fri, 19 Mar 2021 01:03:41 -0400
X-MC-Unique: XWXX7RjiMQ2qbI4jqnTOJw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8DD0080D6A8;
        Fri, 19 Mar 2021 05:03:39 +0000 (UTC)
Received: from [10.72.12.240] (ovpn-12-240.pek2.redhat.com [10.72.12.240])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9DF015D761;
        Fri, 19 Mar 2021 05:03:37 +0000 (UTC)
Subject: Re: [PATCH 1/2] ceph: don't clobber i_snap_caps on non-I_NEW inode
To:     Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org,
        idryomov@gmail.com
Cc:     linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk
References: <20210315180717.266155-1-jlayton@kernel.org>
 <20210315180717.266155-2-jlayton@kernel.org>
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <e70eb841-5669-83e0-4c61-ec8153cc5a9b@redhat.com>
Date:   Fri, 19 Mar 2021 13:03:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210315180717.266155-2-jlayton@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2021/3/16 2:07, Jeff Layton wrote:
> We want the snapdir to mirror the non-snapped directory's attributes for
> most things, but i_snap_caps represents the caps granted on the snapshot
> directory by the MDS itself. A misbehaving MDS could issue different
> caps for the snapdir and we lose them here.
>
> Only reset i_snap_caps when the inode is I_NEW.
>
> Reported-by: Al Viro <viro@zeniv.linux.org.uk>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>   fs/ceph/inode.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
> index 26dc7a296f6b..fc7f4bf63306 100644
> --- a/fs/ceph/inode.c
> +++ b/fs/ceph/inode.c
> @@ -101,12 +101,13 @@ struct inode *ceph_get_snapdir(struct inode *parent)
>   	inode->i_atime = parent->i_atime;
>   	inode->i_op = &ceph_snapdir_iops;
>   	inode->i_fop = &ceph_snapdir_fops;
> -	ci->i_snap_caps = CEPH_CAP_PIN; /* so we can open */
> -	ci->i_rbytes = 0;
>   	ci->i_btime = ceph_inode(parent)->i_btime;
> +	ci->i_rbytes = 0;
>   

Hi Jeff,

BTW, why we need to set other members here if the i_state is not I_NEW ?

Are they necessary ?

> -	if (inode->i_state & I_NEW)
> +	if (inode->i_state & I_NEW) {
> +		ci->i_snap_caps = CEPH_CAP_PIN; /* so we can open */
>   		unlock_new_inode(inode);
> +	}
>   
>   	return inode;
>   }


