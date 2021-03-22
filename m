Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 062CF343BDE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Mar 2021 09:36:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbhCVIfv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Mar 2021 04:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbhCVIfg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Mar 2021 04:35:36 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E87E0C061574;
        Mon, 22 Mar 2021 01:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QoevHkEyhDjxsOKj6fJ4R4SgOfRQylQoV4S5iGinLZU=; b=D1nWnujJVHJ4MgUjzDSpImYZAf
        /0UT4qq4l0rO6u1vGolh/id2xfThwNNw5HdMWaZxUGPcTXKXqO1LDhF39j5rCORszzvOoltjdYdzi
        vdHViRlfbrRePQfgaOZCC0sekOtwgXBHtiMrNLHVCi1LdnOCUS1ybjRcqei7y1qQAOoLfxKMsYwW1
        GtrmEnJdbEh1Z0+7iF0yKKJTBLQh+IxCENArr9jqTOQebxFH9r5aSDx0/1efNNz0tdVOs54ENgh3q
        eDpsL/6Vn0RAcDq9U/SJnruG64G1sNujBf3bVTc6pEqv/tudiNTP1WTpcmuoBn5tUTKLWmOxk6VRB
        bCblmvMg==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lOG1N-008DOR-LV; Mon, 22 Mar 2021 08:34:55 +0000
Date:   Mon, 22 Mar 2021 08:34:45 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Namjae Jeon <namjae.jeon@samsung.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-cifs@vger.kernel.org,
        linux-cifsd-devel@lists.sourceforge.net, smfrench@gmail.com,
        senozhatsky@chromium.org, hyc.lee@gmail.com,
        viro@zeniv.linux.org.uk, hch@lst.de, hch@infradead.org,
        ronniesahlberg@gmail.com, aurelien.aptel@gmail.com,
        aaptel@suse.com, sandeen@sandeen.net, dan.carpenter@oracle.com,
        colin.king@canonical.com, rdunlap@infradead.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steve French <stfrench@microsoft.com>
Subject: Re: [PATCH 2/5] cifsd: add server-side procedures for SMB3
Message-ID: <20210322083445.GJ1719932@casper.infradead.org>
References: <20210322051344.1706-1-namjae.jeon@samsung.com>
 <CGME20210322052206epcas1p438f15851216f07540537c5547a0a2c02@epcas1p4.samsung.com>
 <20210322051344.1706-3-namjae.jeon@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210322051344.1706-3-namjae.jeon@samsung.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 22, 2021 at 02:13:41PM +0900, Namjae Jeon wrote:
> +++ b/fs/cifsd/mgmt/ksmbd_ida.c
> @@ -0,0 +1,69 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + *   Copyright (C) 2018 Samsung Electronics Co., Ltd.
> + */
> +
> +#include "ksmbd_ida.h"
> +
> +struct ksmbd_ida *ksmbd_ida_alloc(void)
> +{
> +	struct ksmbd_ida *ida;
> +
> +	ida = kmalloc(sizeof(struct ksmbd_ida), GFP_KERNEL);
> +	if (!ida)
> +		return NULL;
> +
> +	ida_init(&ida->map);
> +	return ida;
> +}

... why?  Everywhere that you call ksmbd_ida_alloc(), you would
be better off just embedding the struct ida into the struct that
currently has a pointer to it.  Or declaring it statically.  Then
you can even initialise it statically using DEFINE_IDA() and
eliminate the initialiser functions.

I'd remove the ksmbd_ida abstraction, although I like this wrapper:

> +int ksmbd_acquire_smb2_tid(struct ksmbd_ida *ida)
> +{
> +	int id;
> +
> +	do {
> +		id = __acquire_id(ida, 0, 0);
> +	} while (id == 0xFFFF);
> +
> +	return id;

Very clever, given your constraint.  I might do it as:

	int id = ida_alloc(ida, GFP_KERNEL);
	if (id == 0xffff)
		id = ida_alloc(ida, GFP_KERNEL);
	return id;

Although ...

> +	tree_conn = ksmbd_alloc(sizeof(struct ksmbd_tree_connect));
> +	if (!tree_conn) {
> +		status.ret = -ENOMEM;
> +		goto out_error;
> +	}
> +
> +	tree_conn->id = ksmbd_acquire_tree_conn_id(sess);
> +	if (tree_conn->id < 0) {
> +		status.ret = -EINVAL;
> +		goto out_error;
> +	}
> +
> +	peer_addr = KSMBD_TCP_PEER_SOCKADDR(sess->conn);
> +	resp = ksmbd_ipc_tree_connect_request(sess,
> +					      sc,
> +					      tree_conn,
> +					      peer_addr);
> +	if (!resp) {
> +		status.ret = -EINVAL;
> +		goto out_error;
> +	}
> +
> +	status.ret = resp->status;
> +	if (status.ret != KSMBD_TREE_CONN_STATUS_OK)
> +		goto out_error;
> +
> +	tree_conn->flags = resp->connection_flags;
> +	tree_conn->user = sess->user;
> +	tree_conn->share_conf = sc;
> +	status.tree_conn = tree_conn;
> +
> +	list_add(&tree_conn->list, &sess->tree_conn_list);

This is basically the only function which calls that, and this is a relatively
common anti-pattern when using the IDA -- you've allocated a unique ID,
but then you stuff the object in a list and ...

> +struct ksmbd_tree_connect *ksmbd_tree_conn_lookup(struct ksmbd_session *sess,
> +						  unsigned int id)
> +{
> +	struct ksmbd_tree_connect *tree_conn;
> +	struct list_head *tmp;
> +
> +	list_for_each(tmp, &sess->tree_conn_list) {
> +		tree_conn = list_entry(tmp, struct ksmbd_tree_connect, list);
> +		if (tree_conn->id == id)
> +			return tree_conn;
> +	}

... walk the linked list looking for an ID match.  You'd be much better
off using an allocating XArray:
https://www.kernel.org/doc/html/latest/core-api/xarray.html

Then you could lookup tree connections in O(log(n)) time instead of
O(n) time.
