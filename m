Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA2476D9A7A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Apr 2023 16:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239231AbjDFOf7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Apr 2023 10:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239226AbjDFOfp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Apr 2023 10:35:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3DD4CA13;
        Thu,  6 Apr 2023 07:33:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2C9E7648A1;
        Thu,  6 Apr 2023 14:31:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12E1AC4339C;
        Thu,  6 Apr 2023 14:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1680791487;
        bh=XeI9KfiYdDhLQo7ETsetlFQttpL3vF0ZQRlL4DrjO94=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kIoXODhPxDBIJeLdJ53pjgicprZj+Q4MZ9pJlpKxGHW//XKTtdP3WoW0DpEm1ZgMJ
         mjc5yPJj26Xm03Kdfrc+NQfnVusWWRsJ25te7hsy2Q/Lwt+8qdqKX5cRBTQErBDdhx
         14GL7sjuTczZYdD73fKJ+57w5AfueFBtoY8hSByo=
Date:   Thu, 6 Apr 2023 16:31:24 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     chao@kernel.org, damien.lemoal@opensource.wdc.com,
        huyue2@coolpad.com, jefflexu@linux.alibaba.com, jth@kernel.org,
        linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, naohiro.aota@wdc.com,
        rafael@kernel.org, xiang@kernel.org
Subject: Re: [PATCH 2/3] erofs: convert to use kobject_is_added()
Message-ID: <2023040602-stack-overture-d418@gregkh>
References: <2023040635-duty-overblown-7b4d@gregkh>
 <20230406120716.80980-1-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230406120716.80980-1-frank.li@vivo.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 06, 2023 at 08:07:16PM +0800, Yangtao Li wrote:
> > Meta-comment, we need to come up with a "filesystem kobject type" to get
> > rid of lots of the boilerplate filesystem kobject logic as it's
> > duplicated in every filesystem in tiny different ways and lots of times
> > (like here), it's wrong.
> 
> Can we add the following structure?
> 
> struct filesystem_kobject {
>         struct kobject kobject;
>         struct completion unregister;
> };

Ah, no, I see the problem.

The filesystem authors are treating the kobject NOT as the thing that
handles the lifespan of the structure it is embedded in, but rather as
something else (i.e. a convient place to put filesystem information to
userspace.)

That isn't going to work, and as proof of that, the release callback
should be a simple call to kfree(), NOT as a completion notification
which then something else will go off and free the memory here.  That
implies that there are multiple reference counting structures happening
on the same structure, which is not ok.

Either we let the kobject code properly handle the lifespan of the
structure, OR we pull it out of the structure and just let it hang off
as a separate structure (i.e. a pointer to something else.)

As the superblock lifespan rules ALREADY control the reference counting
logic of the filesystem superblock structure, let's stick with that and
just tack-on the kobject as a separate structure entirely.

Does that make sense?  Let me do a quick pass at this for zonefs as
that's pretty simple to show you what I mean...

thanks,

greg k-h
