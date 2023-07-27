Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 918357657EA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jul 2023 17:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233368AbjG0Pm2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jul 2023 11:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232010AbjG0Pm0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jul 2023 11:42:26 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B087B30D7;
        Thu, 27 Jul 2023 08:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
        bh=Y0oQzkTBDnWsaKK19nAfIE6C3CkuhjMs4L3G6ZUK24E=; b=J0B7aPIK8qyUGy2iroUIJgL8xn
        zMcJtMDdJqDRUSkw7z8QJKRvSkAWI4h+0m8Xiv4RHtzzwTgkGODjBhQV6dLcJNBRnSvKuDhOdiGdu
        26b0EVbTYIUIQ4nslsm/WRS34OovmpNcP+eCIia8DOaPCHbV0P2OPImS6E6DNw1KamhbmdYnT4aWb
        Hfg4834OJxQGSUaL8GaBqaLOu6ZoKUjmsmbSp7DBaoYLVimanoKw/wOHvfTUenIkLAepDpO2XBOwi
        MXrOD6L0+5YVr23FxkPlLs282bSKiuamxBRC3zKy9AOay9Nadwsrr1wwTKv4i+Ll9q5E6Zh5I4Viq
        S3pkA4aw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qP37q-00G2j4-34;
        Thu, 27 Jul 2023 15:42:02 +0000
Date:   Thu, 27 Jul 2023 08:42:02 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Joel Granados <j.granados@samsung.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, willy@infradead.org,
        josh@joshtriplett.org,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH 06/14] sysctl: Add size to register_sysctl
Message-ID: <ZMKQSqeKNcJCqkDB@bombadil.infradead.org>
References: <20230726140635.2059334-1-j.granados@samsung.com>
 <CGME20230726140659eucas1p2c3cd9f57dd13c71ddeb78d2480587e72@eucas1p2.samsung.com>
 <20230726140635.2059334-7-j.granados@samsung.com>
 <ZMFexmOcfyORkRRs@bombadil.infradead.org>
 <20230727122200.r5o2mj5qgah5yfwm@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230727122200.r5o2mj5qgah5yfwm@localhost>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 27, 2023 at 02:22:00PM +0200, Joel Granados wrote:
> On Wed, Jul 26, 2023 at 10:58:30AM -0700, Luis Chamberlain wrote:
> > On Wed, Jul 26, 2023 at 04:06:26PM +0200, Joel Granados wrote:
> > > In order to remove the end element from the ctl_table struct arrays, =
we
> > > replace the register_syctl function with a macro that will add the
> > > ARRAY_SIZE to the new register_sysctl_sz function. In this way the
> > > callers that are already using an array of ctl_table structs do not h=
ave
> > > to change. We *do* change the callers that pass the ctl_table array a=
s a
> > > pointer.
> >=20
> > Thanks for doing this and this series!
> >=20
> > > Signed-off-by: Joel Granados <j.granados@samsung.com>
> > > ---
> > > diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
> > > index 0495c858989f..b1168ae281c9 100644
> > > --- a/include/linux/sysctl.h
> > > +++ b/include/linux/sysctl.h
> > > @@ -215,6 +215,9 @@ struct ctl_path {
> > >  	const char *procname;
> > >  };
> > > =20
> > > +#define register_sysctl(path, table)	\
> > > +	register_sysctl_sz(path, table, ARRAY_SIZE(table))
> > > +
> > >  #ifdef CONFIG_SYSCTL
> >=20
> > Wasn't it Greg who had suggested this? Maybe add Suggested-by with him
> > on it.
> Yes. I mentioned him in the cover letter and did not add the tag because
> I had not asked for permission to use it. I'll drop him a mail and
> include the suggested-by if he agrees.

FWIW, I never ask, if they ask for it, clearly they suggested it.

> > Also, your cover letter and first few patches are not CC'd to the netdev
> > list or others. What you want to do is collect all the email addresses
> > for this small patch series and add them to who you email for your
> > entire series, otherwise at times they won't be able to properly review
> > or understand the exact context of the changes. You want folks to do le=
ss
> > work to review, not more.
> Here I wanted to avoid very big e-mail headers as I have received
> rejections from lists in the past. But I for this set, the number of
> e-mails is ok to just include everyone.

I hear that from time to time, if you have issues with adding folks on
the To address it may be an SMTP server issue, ie, corp email SMTP
server issues. To fix that I avoid corp email SMTP servers.

  Luis
