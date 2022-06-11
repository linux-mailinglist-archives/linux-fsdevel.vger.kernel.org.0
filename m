Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 954AF5477C0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Jun 2022 23:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbiFKVnl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 11 Jun 2022 17:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232310AbiFKVnb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 11 Jun 2022 17:43:31 -0400
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 196FD506DA
        for <linux-fsdevel@vger.kernel.org>; Sat, 11 Jun 2022 14:43:28 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 108)
        id 3BD9EC01C; Sat, 11 Jun 2022 23:43:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1654983807; bh=bvw6fpwdTV3SdbFGxdCekho4gJarBysiPQpYO63U+ic=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=klkPJAzqyXh5ZAezn1+VFT8MZz4cxq6FCS40pBqgoRVSEPqiSexELHNUwPNTO1jOn
         DEWT1O6oKdXw18ni5M3oiWwkNwkgRSoycXgrW+LaVu+n98QH99DlJruqXFSF87FROJ
         BQHF5O3Hlw1mek2QlCdRfHhfvPfpgAkBHgk0eP0xtHYhBTdkNTyljfpzcJCvHhGDGW
         9tn81/tacsM2SgX+o8dFp5E8n3ZWSz30wgmvql9eeoMhXS/CK1XUyOjp5pHSi8a9sG
         HPKWeoglXDAp0fFfczoAJ/s92RlkLwvJvHNC1l4TNVFxc4Qo5EtEvoY+I7yw+kbvlm
         8fZQ5j2TK8YJg==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id B96C7C009;
        Sat, 11 Jun 2022 23:43:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1654983797; bh=bvw6fpwdTV3SdbFGxdCekho4gJarBysiPQpYO63U+ic=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=v7JUyo/Bpzv7XK3Jrw4a717BWUdSVz7IoptGPFjYP9lJFNYPrkPwO/TvfKPD/U0D3
         B7rX7ik3Cz9RsJ2bW4iH3fmk4/tFC3TvHLnOvKKAIZgSjDHCfo7mHs27qFopVJNkig
         vrlhFJmHW1GX1G9Nz4XtD/BMnSYw1rxOr8VNTi5P4K+TbQ76S2O39xcnzYv2gc6Sum
         cEFQeFzsagw4/9kPpWjSuFltnhVfJIvbyZbUnnFowBAh2R5iF4ZA3RX/TyD9gVVjcD
         GCFMD984koaK6YNO6RQRzGWfjF32XrGcC8fGzTd/g6Fkbpds9UQnwvoq/lSBlXpW+g
         TAjFg+v4KqI4g==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id e7b3bd2d;
        Sat, 11 Jun 2022 21:43:13 +0000 (UTC)
Date:   Sun, 12 Jun 2022 06:42:58 +0900
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, v9fs-developer@lists.sourceforge.net
Subject: Re: [RFC][CFT] handling Rerror without copy_from_iter_full()
Message-ID: <YqUMYpqYiKOeEoha@codewreck.org>
References: <YqDfWho8+f2AXPrj@zeniv-ca.linux.org.uk>
 <YqSYWgeQqenOYwVf@codewreck.org>
 <YqSyaz0GNdZbu1bx@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YqSyaz0GNdZbu1bx@zeniv-ca.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Al Viro wrote on Sat, Jun 11, 2022 at 03:19:07PM +0000:
> > That makes me wonder just how much use we get for the legacy
> > protocols -- I guess we do have some but all the filesystem-y
> > implementations that I would expect to be main users for large
> > IOs/zc are 9P2000.L as far as I know -- especially considering
> > virtio is pretty much limited to qemu? Are there other 9p virtio
> > servers?
> 
> Client can trivially force its use - -o version=9p2000.u and there
> you go...

Well, yes, but qemu supports .L -- even if we arbitrarily decide .u
won't go through the zero-copy path it's not going to harm the VM case.

If zc had been a thing for e.g. trans_fd there are plenty of servers
that could still be only used with older variants, but I don't think we
have to try supporting 9p2000.u + zc if it's a burden in the code.

> > Silly question, in case of a pipe we'll have written something we
> > shouldn't have, or is it not gone yet until we actually finish the IO
> > with iov_iter_advance?
> > (my understanding is that reader won't have anything to read until
> > someone else does the advance, and that someone else will have
> > overwritten the data with their own content so no garbage wlll be read)
> 
> More than that, pipe is locked through ->read_iter(), so transient garbage
> in it doesn't matter - we will either advance it by zero (it's an error)
> or, with iov_iter_get_pages_alloc() switching to advancing variant,
> we'll revert by the amount it had reserved there (error is the same as
> extremely short read).

Ok, thanks

> > ... With that said though your approach here definitely looks better
> > than what we currently have -- my main issue is that truncating is fine
> > for the original 9p2000 but for .U you'd be losing the ecode that we
> > currently trust for being errno-compatible.
> 
> No, we wouldn't - this
>                 len = req->rc.size - req->rc.offset;
> 		if (len > (P9_ZC_HDR_SZ - 7)) {
> 			err = -EFAULT;
> 			goto out_err;
> 		}
> in p9_check_zc_errors() means that mainline won't even look at that value.
> And we'll get the same -EFAULT when we get to
>                 err = p9pdu_readf(&req->rc, c->proto_version, "s?d",
> 				  &ename, &ecode);
> in p9_check_errors() and see that the length of string is too large to
> fit into (truncated) reply.


Right, I forgot the string itself has a size, so we're not looking at
the last bytes but something that is no longer there and readf will
fail. Ok.

Sure, I don't see any other problem with this code.
I still think it's complexity we don't really need, but it's better than
what we have -- care to resend it as a real patch? and I'll apply/run
through some basic tests with qemu+2000u a bit.
(well, I don't have to wait to run the tests)

-- 
Dominique
