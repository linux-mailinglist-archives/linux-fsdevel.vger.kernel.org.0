Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB1C14AB81
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jan 2020 22:18:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbgA0VSG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Jan 2020 16:18:06 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:31884 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725955AbgA0VSG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Jan 2020 16:18:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580159884;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ECEJfILwgikmyqfw3um95+F+o87qw50+mv0dxtlShCU=;
        b=GG1039YegPBRMU+WMTsOOO0N6rjuJ3XTm0WBiTTdWXYlHwBtQeUFl+QN5PNNmnEy5ULd7w
        vIhbImS1z2uwmJypb1vSjLIUEGU08QmR8rPF6DNKzpF3XjDONCXkEUnGiOcTS0gTgTLUBX
        YMzRux4I5XqW9ZioJJJJh1QQbBLjxW0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-349-BWxdSX66P6-zzMT7n_XQCQ-1; Mon, 27 Jan 2020 16:18:00 -0500
X-MC-Unique: BWxdSX66P6-zzMT7n_XQCQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5A8F710054E3;
        Mon, 27 Jan 2020 21:17:59 +0000 (UTC)
Received: from pick.fieldses.org (ovpn-116-168.phx2.redhat.com [10.3.116.168])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0715060BF4;
        Mon, 27 Jan 2020 21:17:59 +0000 (UTC)
Received: by pick.fieldses.org (Postfix, from userid 2815)
        id 5AD831201BA; Mon, 27 Jan 2020 16:17:57 -0500 (EST)
Date:   Mon, 27 Jan 2020 16:17:57 -0500
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] exportfs: fix handling of rename race in reconnect_one()
Message-ID: <20200127211757.GA122687@pick.fieldses.org>
References: <20200126220800.32397-1-amir73il@gmail.com>
 <20200127173002.GD115624@pick.fieldses.org>
 <CAOQ4uxhqO5DtSwAtO950oGcnWVaVG+Vcdu6TYDfUKawVNGWEiA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhqO5DtSwAtO950oGcnWVaVG+Vcdu6TYDfUKawVNGWEiA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 27, 2020 at 08:38:00PM +0200, Amir Goldstein wrote:
> > > Commit 909e22e05353 ("exportfs: fix 'passing zero to ERR_PTR()'
> > > warning") changes this behavior from always returning success,
> > > regardless if dentry was reconnected by somoe other task, to always
> > > returning a failure.
> >
> > I wonder whether it might be safest to take the out_reconnected case on
> > any error, not just -ENOENT.
> >
> 
> I wondered that as well, but preferred to follow the precedent.

I can live with that.

> > There's not much value in preserving the error as exportfs_decode_fh()
> > ends up turning everything into ENOMEM or ESTALE for some reason.
> >
> 
> You signed up on this reason...

Hah, I forgot that one.

--b.
> 
> Thanks,
> Amir.
> 
> commit 09bb8bfffd29c3dffb72bc2c69a062dfb1ae624c
> Author: NeilBrown <neilb@suse.com>
> Date:   Thu Aug 4 10:19:06 2016 +1000
> 
>     exportfs: be careful to only return expected errors.
> 
>     When nfsd calls fh_to_dentry, it expect ESTALE or ENOMEM as errors.
>     In particular it can be tempting to return ENOENT, but this is not
>     handled well by nfsd.
> 
>     Rather than requiring strict adherence to error code code filesystems,
>     treat all unexpected error codes the same as ESTALE.  This is safest.
> 
>     Signed-off-by: NeilBrown <neilb@suse.com>
>     Signed-off-by: J. Bruce Fields <bfields@redhat.com>
> 

