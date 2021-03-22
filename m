Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FCD9343A2A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Mar 2021 08:03:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbhCVHDL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Mar 2021 03:03:11 -0400
Received: from zeniv-ca.linux.org.uk ([142.44.231.140]:47100 "EHLO
        zeniv-ca.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbhCVHC4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Mar 2021 03:02:56 -0400
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lOEaT-00852M-Ht; Mon, 22 Mar 2021 07:02:53 +0000
Date:   Mon, 22 Mar 2021 07:02:53 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Namjae Jeon <namjae.jeon@samsung.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-cifs@vger.kernel.org,
        linux-cifsd-devel@lists.sourceforge.net, smfrench@gmail.com,
        senozhatsky@chromium.org, hyc.lee@gmail.com, hch@lst.de,
        hch@infradead.org, ronniesahlberg@gmail.com,
        aurelien.aptel@gmail.com, aaptel@suse.com, sandeen@sandeen.net,
        dan.carpenter@oracle.com, colin.king@canonical.com,
        rdunlap@infradead.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steve French <stfrench@microsoft.com>
Subject: Re: [PATCH 3/5] cifsd: add file operations
Message-ID: <YFhBHScj4QxLl/Ef@zeniv-ca.linux.org.uk>
References: <20210322051344.1706-1-namjae.jeon@samsung.com>
 <CGME20210322052207epcas1p3f0a5bdfd2c994a849a67b465479d0721@epcas1p3.samsung.com>
 <20210322051344.1706-4-namjae.jeon@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210322051344.1706-4-namjae.jeon@samsung.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 22, 2021 at 02:13:42PM +0900, Namjae Jeon wrote:

> +static struct ksmbd_file *__ksmbd_lookup_fd(struct ksmbd_file_table *ft,
> +					    unsigned int id)
> +{
> +	bool unclaimed = true;
> +	struct ksmbd_file *fp;
> +
> +	read_lock(&ft->lock);
> +	fp = idr_find(ft->idr, id);
> +	if (fp)
> +		fp = ksmbd_fp_get(fp);
> +
> +	if (fp && fp->f_ci) {
> +		read_lock(&fp->f_ci->m_lock);
> +		unclaimed = list_empty(&fp->node);
> +		read_unlock(&fp->f_ci->m_lock);
> +	}
> +	read_unlock(&ft->lock);
> +
> +	if (fp && unclaimed) {
> +		atomic_dec(&fp->refcount);
> +		return NULL;
> +	}

Can that atomic_dec() end up dropping the last remaining reference?
If not, what's to prevent that?
