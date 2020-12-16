Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 442512DBA12
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Dec 2020 05:34:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725710AbgLPEeJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Dec 2020 23:34:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725275AbgLPEeJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Dec 2020 23:34:09 -0500
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CE51C061794;
        Tue, 15 Dec 2020 20:33:28 -0800 (PST)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kpOV9-001a5W-HO; Wed, 16 Dec 2020 04:33:23 +0000
Date:   Wed, 16 Dec 2020 04:33:23 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Siddhesh Poyarekar <siddhesh@gotplt.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Florian Weimer <fweimer@redhat.com>
Subject: Re: [PATCH v2] proc: Escape more characters in /proc/mounts output
Message-ID: <20201216043323.GM3579531@ZenIV.linux.org.uk>
References: <20201215125318.2681355-1-siddhesh@gotplt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201215125318.2681355-1-siddhesh@gotplt.org>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 15, 2020 at 06:23:18PM +0530, Siddhesh Poyarekar wrote:

> +static char *copy_mount_devname(const void __user *data)
> +{
> +	char *p;
> +	long length;
> +
> +	if (data == NULL)
> +		return NULL;
> +
> +	length = strnlen_user(data, PATH_MAX);
> +
> +	if (!length)
> +		return ERR_PTR(-EFAULT);
> +
> +	if (length > PATH_MAX)
> +		return ERR_PTR(-EINVAL);
> +
> +	/* Ignore blank strings */
> +	if (length == 1)
> +		return NULL;
> +
> +	p = memdup_user(data, length);

Once more, with feeling: why bother?  What's wrong
with using the damn strndup_user() and then doing
whatever checks you want with the data already
copied, living in normal kernel memory, with all
string functions applicable, etc.?
