Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4D72C4774
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Nov 2020 19:18:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733062AbgKYSRN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Nov 2020 13:17:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:25528 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733005AbgKYSRN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Nov 2020 13:17:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606328232;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dEa9zY1JC2vSvxM6QWce76x1bj8BhcfNmh1K1toWIe0=;
        b=RC51FE5CpFAZ+bbTZFGHoTEungjX49QADhMED7oP6VU+38542s2sbhvI4qzsCon0bil5/U
        EFSa4j8XRygWQ+4tSj8r6TbiRgN4eQPjPFCQ8swiXfC2l5rQmej2lcN5Dno9j2B2KCVJbP
        uanaY0+XZrV/56ZJQhz0YqP4YGmEKLo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-92-zt45hPzPPFKNxhG0joqgBQ-1; Wed, 25 Nov 2020 13:17:08 -0500
X-MC-Unique: zt45hPzPPFKNxhG0joqgBQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8C85887308A;
        Wed, 25 Nov 2020 18:17:06 +0000 (UTC)
Received: from horse.redhat.com (ovpn-114-154.rdu2.redhat.com [10.10.114.154])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A3CB560854;
        Wed, 25 Nov 2020 18:17:05 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 0E3D122054F; Wed, 25 Nov 2020 13:17:05 -0500 (EST)
Date:   Wed, 25 Nov 2020 13:17:04 -0500
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     linux-unionfs@vger.kernel.org, miklos@szeredi.hu,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Amir Goldstein <amir73il@gmail.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Daniel J Walsh <dwalsh@redhat.com>,
        linux-fsdevel@vger.kernel.org, David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v1 2/3] overlay: Add the ability to remount volatile
 directories when safe
Message-ID: <20201125181704.GD3095@redhat.com>
References: <20201125104621.18838-1-sargun@sargun.me>
 <20201125104621.18838-3-sargun@sargun.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201125104621.18838-3-sargun@sargun.me>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 25, 2020 at 02:46:20AM -0800, Sargun Dhillon wrote:

[..]
> @@ -1125,16 +1183,19 @@ static int ovl_workdir_cleanup_recurse(struct path *path, int level)
>  			if (p->len == 2 && p->name[1] == '.')
>  				continue;
>  		} else if (incompat) {
> -			pr_err("overlay with incompat feature '%s' cannot be mounted\n",
> -				p->name);
> -			err = -EINVAL;
> -			break;
> +			err = ovl_check_incompat(ofs, p, path);
> +			if (err < 0)
> +				break;
> +			/* Skip cleaning this */
> +			if (err == 1)
> +				continue;
>  		}

Shouldn't we clean volatile/dirty on non-volatile mount. I did a 
volatile mount followed by a non-volatile remount and I still
see work/incompat/volatile/dirty and "trusted.overlay.volatile" xattr
on "volatile" dir. I would expect that this will be all cleaned up
as soon as that upper/work is used for non-volatile mount.


