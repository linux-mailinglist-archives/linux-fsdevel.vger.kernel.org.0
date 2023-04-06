Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 925816D94F7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Apr 2023 13:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236044AbjDFLTo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Apr 2023 07:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237695AbjDFLTl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Apr 2023 07:19:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E55F9029;
        Thu,  6 Apr 2023 04:19:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B3AFA6461B;
        Thu,  6 Apr 2023 11:19:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3E30C433D2;
        Thu,  6 Apr 2023 11:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1680779944;
        bh=ReNRvDX76rkahPbHGeY6Mq+oz43WQ6EdFp4QHSNHf/c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MCS3C4pIZUkUAsBCgmvq1RJjWg0AXNn2hPLc4Psb9cPKgdrUYj0F4S9pmoxk0y/pi
         jGGjpZYQvEmyxINwKtmblsc/krvAWNcee6CZctCU0LKqfY7hIYw+eSCEK3+uckdkan
         2AlxiPLdNOCq60pqLOruZWqY41zhDSXnlrPH5jnE=
Date:   Thu, 6 Apr 2023 13:19:00 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     Yangtao Li <frank.li@vivo.com>, xiang@kernel.org, chao@kernel.org,
        huyue2@coolpad.com, jefflexu@linux.alibaba.com,
        damien.lemoal@opensource.wdc.com, naohiro.aota@wdc.com,
        jth@kernel.org, rafael@kernel.org, linux-erofs@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/3] erofs: convert to use kobject_is_added()
Message-ID: <2023040609-email-squad-25f5@gregkh>
References: <20230406093056.33916-1-frank.li@vivo.com>
 <20230406093056.33916-2-frank.li@vivo.com>
 <2023040635-duty-overblown-7b4d@gregkh>
 <cc219a52-e89c-b7e7-5bfd-0124f881a29f@linux.alibaba.com>
 <2023040654-protrude-unlucky-f164@gregkh>
 <589f6665-824f-bf08-3458-d3986d88f7fc@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <589f6665-824f-bf08-3458-d3986d88f7fc@linux.alibaba.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 06, 2023 at 06:55:40PM +0800, Gao Xiang wrote:
> 
> 
> On 2023/4/6 18:27, Greg KH wrote:
> > On Thu, Apr 06, 2023 at 06:13:05PM +0800, Gao Xiang wrote:
> > > Hi Greg,
> > > 
> > > On 2023/4/6 18:03, Greg KH wrote:
> > > > On Thu, Apr 06, 2023 at 05:30:55PM +0800, Yangtao Li wrote:
> > > > > Use kobject_is_added() instead of directly accessing the internal
> > > > > variables of kobject. BTW kill kobject_del() directly, because
> > > > > kobject_put() actually covers kobject removal automatically.
> > > > > 
> > > > > Signed-off-by: Yangtao Li <frank.li@vivo.com>
> > > > > ---
> > > > >    fs/erofs/sysfs.c | 3 +--
> > > > >    1 file changed, 1 insertion(+), 2 deletions(-)
> > > > > 
> > > > > diff --git a/fs/erofs/sysfs.c b/fs/erofs/sysfs.c
> > > > > index 435e515c0792..daac23e32026 100644
> > > > > --- a/fs/erofs/sysfs.c
> > > > > +++ b/fs/erofs/sysfs.c
> > > > > @@ -240,8 +240,7 @@ void erofs_unregister_sysfs(struct super_block *sb)
> > > > >    {
> > > > >    	struct erofs_sb_info *sbi = EROFS_SB(sb);
> > > > > -	if (sbi->s_kobj.state_in_sysfs) {
> > > > > -		kobject_del(&sbi->s_kobj);
> > > > > +	if (kobject_is_added(&sbi->s_kobj)) {
> > > > 
> > > > I do not understand why this check is even needed, I do not think it
> > > > should be there at all as obviously the kobject was registered if it now
> > > > needs to not be registered.
> > > 
> > > I think Yangtao sent a new patchset which missed the whole previous
> > > background discussions as below:
> > > https://lore.kernel.org/r/028a1b56-72c9-75f6-fb68-1dc5181bf2e8@linux.alibaba.com
> > > 
> > > It's needed because once a syzbot complaint as below:
> > > https://lore.kernel.org/r/CAD-N9QXNx=p3-QoWzk6pCznF32CZy8kM3vvo8mamfZZ9CpUKdw@mail.gmail.com
> > > 
> > > I'd suggest including the previous backgrounds at least in the newer patchset,
> > > otherwise it makes me explain again and again...
> > 
> > That would be good, as I do not think this is correct, it should be
> > fixed in a different way, see my response to the zonefs patch in this
> > series as a much simpler method to use.
> 
> Yes, but here (sbi->s_kobj) is not a kobject pointer (also at a quick
> glance it seems that zonefs has similar code), and also we couldn't
> just check the sbi is NULL or not here only, since sbi is already
> non-NULL in this path and there are some others in sbi to free in
> other functions.
> 
> s_kobj could be changed into a pointer if needed.  I'm all fine with
> either way since as you said, it's a boilerplate filesystem kobject
> logic duplicated from somewhere.  Hopefully Yangtao could help take
> this task since he sent me patches about this multiple times.

I made the same mistake with the zonefs code.  If the kobject in this
structure controls the lifespan of it (which makes it not a pointer, my
mistake), then that whole memory chunk can't be valid anymore if the
kobject registering function failed so you need to get rid of it then,
not later.

thanks,

greg k-h
