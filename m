Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D07059A899
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Aug 2022 00:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242899AbiHSWgi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Aug 2022 18:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239270AbiHSWgf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Aug 2022 18:36:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8666A10C83D
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Aug 2022 15:36:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 13B60617F0
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Aug 2022 22:36:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E384C433C1;
        Fri, 19 Aug 2022 22:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660948593;
        bh=kpK5eC8bTRHQNDpZySZTMewfQlwFe4s77+Dm8dzizJM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SCx44mu5hKk00BK3uwf0FoDeHM87V/ahSAmRx8/yzU1OJqF6KaYGyfA9CGMseZzse
         5VPOUzUXq+kXd5uQWOEyYS8BJn6oaiQkWgPpKIKx4qCukbSHj2qZmkcTRoIiMxwX11
         yN0ycIWRBR/jnZOii6Sh+DVfp2Stsr597R9GIXbFZxCpxyiDGgimVV28rRG6kt2rFR
         DJGyv/3EqF3HVe5g0D8aciApXQvCNClUB/uYuQYMTdv6RIrfBO0VG3n4CDIJvLi8B0
         kKpULZTFTzv8I4rdVSQ268mlV121+/PXTjKKSs3vr3PuATdDsmvUJFmVKHKEqFhilP
         X3fwG42pnMZhA==
Date:   Fri, 19 Aug 2022 15:36:31 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] f2fs: use memcpy_{to,from}_page() where possible
Message-ID: <YwAQb2GQ4GFl3mvz@sol.localdomain>
References: <20220818225450.84090-1-ebiggers@kernel.org>
 <4743896.GXAFRqVoOG@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4743896.GXAFRqVoOG@localhost.localdomain>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 19, 2022 at 01:11:41PM +0200, Fabio M. De Francesco wrote:
> > -	src_addr = inline_data_addr(inode, ipage);
> > -	dst_addr = kmap_atomic(page);
> > -	memcpy(dst_addr, src_addr, MAX_INLINE_DATA(inode));
> > +	memcpy_to_page(page, 0, inline_data_addr(inode, ipage),
> > +		       MAX_INLINE_DATA(inode));
> >  	flush_dcache_page(page);
> 
> flush_dcache_page() is redundant here. memcpy_to_page() takes care to call it.

Done in v2.

> > -		kaddr = kmap_atomic(page);
> > -		memcpy(kaddr + offset, data, tocopy);
> > -		kunmap_atomic(kaddr);
> > +		memcpy_to_page(page, offset, data, tocopy);
> >  		flush_dcache_page(page);
> 
> Same here.

Likewise.

> 
> It looks like you forgot a conversion from kmap_atomic() in fs/f2fs/inline.c 
> at line 266.

Also done in v2.  I think I had skipped that one intentionally, but I must not
have looked closely because it converts just fine.  Thanks!

- Eric
