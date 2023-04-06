Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE4B6D93F8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Apr 2023 12:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236543AbjDFK1f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Apr 2023 06:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235933AbjDFK1e (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Apr 2023 06:27:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACE4C1721;
        Thu,  6 Apr 2023 03:27:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3C12160B4C;
        Thu,  6 Apr 2023 10:27:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C02DC4339B;
        Thu,  6 Apr 2023 10:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1680776851;
        bh=2I1CdpyLXu6CoUaYPP0j1AjlhRFqWROonYBrtW7gQeo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W6ejsOyMYFneGRNKAuwdNh/Nzyau/DK+D4hbt9CUY3WC7Qy+mkBsD3SS9efS2k4A2
         Jz2+dw96XmkymLxPrhTcZd1/XpLDrefy//S2kdIlgssz5LPo3hdxiH/QUam95+Tt+T
         Udc7Mb22gMr99CXcr5M6Zb/Nifcjh31P1n/afIcg=
Date:   Thu, 6 Apr 2023 12:27:29 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     Yangtao Li <frank.li@vivo.com>, xiang@kernel.org, chao@kernel.org,
        huyue2@coolpad.com, jefflexu@linux.alibaba.com,
        damien.lemoal@opensource.wdc.com, naohiro.aota@wdc.com,
        jth@kernel.org, rafael@kernel.org, linux-erofs@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/3] erofs: convert to use kobject_is_added()
Message-ID: <2023040654-protrude-unlucky-f164@gregkh>
References: <20230406093056.33916-1-frank.li@vivo.com>
 <20230406093056.33916-2-frank.li@vivo.com>
 <2023040635-duty-overblown-7b4d@gregkh>
 <cc219a52-e89c-b7e7-5bfd-0124f881a29f@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc219a52-e89c-b7e7-5bfd-0124f881a29f@linux.alibaba.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 06, 2023 at 06:13:05PM +0800, Gao Xiang wrote:
> Hi Greg,
> 
> On 2023/4/6 18:03, Greg KH wrote:
> > On Thu, Apr 06, 2023 at 05:30:55PM +0800, Yangtao Li wrote:
> > > Use kobject_is_added() instead of directly accessing the internal
> > > variables of kobject. BTW kill kobject_del() directly, because
> > > kobject_put() actually covers kobject removal automatically.
> > > 
> > > Signed-off-by: Yangtao Li <frank.li@vivo.com>
> > > ---
> > >   fs/erofs/sysfs.c | 3 +--
> > >   1 file changed, 1 insertion(+), 2 deletions(-)
> > > 
> > > diff --git a/fs/erofs/sysfs.c b/fs/erofs/sysfs.c
> > > index 435e515c0792..daac23e32026 100644
> > > --- a/fs/erofs/sysfs.c
> > > +++ b/fs/erofs/sysfs.c
> > > @@ -240,8 +240,7 @@ void erofs_unregister_sysfs(struct super_block *sb)
> > >   {
> > >   	struct erofs_sb_info *sbi = EROFS_SB(sb);
> > > -	if (sbi->s_kobj.state_in_sysfs) {
> > > -		kobject_del(&sbi->s_kobj);
> > > +	if (kobject_is_added(&sbi->s_kobj)) {
> > 
> > I do not understand why this check is even needed, I do not think it
> > should be there at all as obviously the kobject was registered if it now
> > needs to not be registered.
> 
> I think Yangtao sent a new patchset which missed the whole previous
> background discussions as below:
> https://lore.kernel.org/r/028a1b56-72c9-75f6-fb68-1dc5181bf2e8@linux.alibaba.com
> 
> It's needed because once a syzbot complaint as below:
> https://lore.kernel.org/r/CAD-N9QXNx=p3-QoWzk6pCznF32CZy8kM3vvo8mamfZZ9CpUKdw@mail.gmail.com
> 
> I'd suggest including the previous backgrounds at least in the newer patchset,
> otherwise it makes me explain again and again...

That would be good, as I do not think this is correct, it should be
fixed in a different way, see my response to the zonefs patch in this
series as a much simpler method to use.

thanks,

greg k-h
