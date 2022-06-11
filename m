Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50C245474D6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Jun 2022 15:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233674AbiFKNgV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 11 Jun 2022 09:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232660AbiFKNgV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 11 Jun 2022 09:36:21 -0400
X-Greylist: delayed 483 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 11 Jun 2022 06:36:19 PDT
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0EFF60C9
        for <linux-fsdevel@vger.kernel.org>; Sat, 11 Jun 2022 06:36:19 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 108)
        id 329A4C01A; Sat, 11 Jun 2022 15:28:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1654954093; bh=TGzmb/Iu7QpV6WSsoJdFI/dC7IRxWq/cmuz/luanVAc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dt2q9XUu9/oSr0PyKezWHmXLR7Rof7oltz6rhJ7Kh0KpuA6Rh3JiNTavmXcB6BjKo
         dlygBCddWdwMnciiM4uf/ZFxCRrtTWY3Ghf3+D5fNYlI2dcUXbeisd2ny59u4NxkWY
         FEP6SkAnlplQmRpa/rsrx0dwvI40J6QHwEGSuNAqFx85mqXR04W4JD3t+ByzSmSnS2
         LL2pY3ilI4ko3guXk5f4a3oPPwiZ7WzlnGMk7PBxxt4KJXsy1I0asc3at8ebQe4YsN
         AfyPZZcRF8Q+fkvobcX8w43WyNCx00TW5+dAsniSvXpgQdCbySAGX1am4Kr+czRpCt
         jJNiTuaOxZzDw==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id B5814C009;
        Sat, 11 Jun 2022 15:28:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1654954092; bh=TGzmb/Iu7QpV6WSsoJdFI/dC7IRxWq/cmuz/luanVAc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oBKAGwxwZjWU0vDddmpjSlML42V0uJgzRWo0YNv9mF6HRGaJ4rT/scSgW6gno069C
         UY31d5HdJOjDIKlJ7uB6CfgN1qvVbEMRxrQYArwlSW7DWns6pfAvML8NQ5hKD83FBv
         RuSNCS4itsT6tXloguYAQNetaD48+EDiNn+Qi3QhqXhT+5auTTuDOgLRsxX/RpX8bo
         ebS57Rm9aOHSuRo4E5YNYf2w2GbG5JM06h8v8f1oAfICX1LvwMcgLpGm/P2A/FnvQj
         InRpqVner+PJV0uZcFH8NVBmWM/iB5q3XZ/ZTFGtKUzhlFPlTFQvgkPLNEERqWEv6m
         /58ghFMxuoz/g==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id cdccf9d2;
        Sat, 11 Jun 2022 13:28:09 +0000 (UTC)
Date:   Sat, 11 Jun 2022 22:27:54 +0900
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, v9fs-developer@lists.sourceforge.net
Subject: Re: [RFC][CFT] handling Rerror without copy_from_iter_full()
Message-ID: <YqSYWgeQqenOYwVf@codewreck.org>
References: <YqDfWho8+f2AXPrj@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YqDfWho8+f2AXPrj@zeniv-ca.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Al Viro wrote on Wed, Jun 08, 2022 at 05:41:46PM +0000:
> 	As it is, p9_client_zc_rpc()/p9_check_zc_errors() is playing fast
> and loose with copy_from_iter_full().
> 
> 	Background: reading from file is done by sending Tread request.
> Response consists of fixed-sized header (including the amount of data
> actually read) followed by the data itself.
> 
> 	For zero-copy case we arrange the things so that the first 11
> bytes of reply go into the fixed-sized buffer, with the rest going
> straight into the pages we want to read into.

Ugh... zc really needs something like direct data placement NFS/RDMA has
been doing... (But that's just not possible without extending the
protocol)

> 	What makes the things inconvenient is that sglist describing
> what should go where has to be set *before* the reply arrives.  As
> the result, if reply is an error, the things get interesting.  Success
> is
> 	size[4] Rread tag[2] count[4] data[count]
> For error layout varies depending upon the protocol variant -
> in original 9P and 9P2000 it's
> 	size[4] Rerror tag[2] len[2] error[len]
> in 9P2000.U
> 	size[4] Rerror tag[2] len[2] error[len] errno[4]
> in 9P2000.L
> 	size[4] Rlerror tag[2] errno[4]
> 
> The last case is nice and simple - we have an 11-byte response that fits
> into the fixed-sized buffer we hoped to get an Rread into.  In other
> two, though, we get a variable-length string spill into the pages
> we'd prepared for the data to be read.

That makes me wonder just how much use we get for the legacy
protocols -- I guess we do have some but all the filesystem-y
implementations that I would expect to be main users for large
IOs/zc are 9P2000.L as far as I know -- especially considering
virtio is pretty much limited to qemu? Are there other 9p virtio
servers?

So would it make sense to just say "not .L? tough luck, no zc",
or am I just being lazy?

> Had that been in fixed-sized buffer (which is actually 4K), we would've
> dealt with that the same way we handle non-zerocopy case.  However,
> for zerocopy it doesn't end up there, so we need to copy it from
> those pages.
> 
> The trouble is, by the time we get around to that, the references to
> pages in question are already dropped.  As the result, p9_zc_check_errors()
> tries to get the data using copy_from_iter_full().  Unfortunately, the
> iov_iter it's trying to read from might *NOT* be capable of that.
> It is, after all, a data destination, not data source.  In particular,
> if it's an ITER_PIPE one, copy_from_iter_full() will simply fail.

Silly question, in case of a pipe we'll have written something we
shouldn't have, or is it not gone yet until we actually finish the IO
with iov_iter_advance?
(my understanding is that reader won't have anything to read until
someone else does the advance, and that someone else will have
overwritten the data with their own content so no garbage wlll be read)


> The thing is, in ->zc_request() itself we have those pages.  There it
> would be a simple matter of memcpy_from_page() into the fixed-sized
> buffer and it isn't hard to recognize the (rare) case when such
> copying is needed.  That way we get rid of p9_zc_check_errors() entirely
> - p9_check_errors() can be used instead both for zero-copy and non-zero-copy
> cases.
> 
> Do you see any problems with the variant below?

... With that said though your approach here definitely looks better
than what we currently have -- my main issue is that truncating is fine
for the original 9p2000 but for .U you'd be losing the ecode that we
currently trust for being errno-compatible.
It's *probably* not a problem in practice, but preserving that errno
would theorically make us look for the page where the last few bytes
went to and overwrite the end of the string with it but that's starting
to be ugly.

Anyway even not doing that is probably better than reading from
something we no longer own; but I'm still thinking just refusing non-.L
variants to zc calls is a better decision long term.

-- 
Dominique
