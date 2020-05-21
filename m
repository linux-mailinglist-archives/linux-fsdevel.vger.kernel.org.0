Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40B351DD55B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 May 2020 19:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729142AbgEUR5a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 May 2020 13:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727883AbgEUR5a (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 May 2020 13:57:30 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C6F5C061A0E;
        Thu, 21 May 2020 10:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YEGiyJ5J60rxwdmY4lT+xudS1/jh1/7YclIMmGnHZGE=; b=PIIXS+eC5DD7LBhbkxVl4hQbPo
        KRjVT1wOlcv35cRLz4KSRkcdxAS5QFauxquIwnF77pgAYeQAwr5G9x6ZulTl59oV242VgnCJgAdx0
        xP5uwShg7+UQFjaIY+1sW9kSBTIpUTBnHhghxcoW5tcRBKXOEMoBLTUnI6J8ulVjj/rEF6dKQgtsX
        pqplH781Rty/n4VXCJkoDhKtk6pFoaPtcrJv4oA8F4YRc3+SWs9fA6LkFWCbYZsUBKrtvBvpveVUo
        Dp9gte6FOWoXvyl1Sb4UDL7f48KfROIVbL5dx3qO8a7O0usw/DHcgSm21k+CZEem4Oic2oayY4cu6
        8YEwcOfg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jbpRh-0000m4-8s; Thu, 21 May 2020 17:57:29 +0000
Date:   Thu, 21 May 2020 10:57:29 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Eric Sandeen <sandeen@sandeen.net>
Cc:     Namjae Jeon <linkinjeon@kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org
Subject: Re: [PATCH v2] exfat: add the dummy mount options to be backward
 compatible with staging/exfat
Message-ID: <20200521175729.GE28818@bombadil.infradead.org>
References: <20200521140502.2409-1-linkinjeon@kernel.org>
 <eb8858fb-c3bc-3f8d-96c1-3b4082c14373@sandeen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb8858fb-c3bc-3f8d-96c1-3b4082c14373@sandeen.net>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 21, 2020 at 10:44:28AM -0500, Eric Sandeen wrote:
> On 5/21/20 9:05 AM, Namjae Jeon wrote:
> > As Ubuntu and Fedora release new version used kernel version equal to or
> > higher than v5.4, They started to support kernel exfat filesystem.
> > 
> > Linus Torvalds reported mount error with new version of exfat on Fedora.
> > 
> > 	exfat: Unknown parameter 'namecase'
> > 
> > This is because there is a difference in mount option between old
> > staging/exfat and new exfat.
> > And utf8, debug, and codepage options as well as namecase have been
> > removed from new exfat.
> > 
> > This patch add the dummy mount options as deprecated option to be backward
> > compatible with old one.
> 
> Wow, it seems wild that we'd need to maintain compatibility with options
> which only ever existed in a different codebase in a staging driver
> (what's the point of staging if every interface that makes it that far has
> to be maintained in perpetuity?)
> 
> Often, when things are deprecated, they are eventually removed.  Perhaps a
> future removal date stated in this commit, or in Documentation/..../exfat.txt
> would be good as a reminder to eventually remove this?

For NFS, 'intr' has been deprecated since December 2007 and has been
printing a warning since June 2008.  How long until we delete it?

> >  static const struct constant_table exfat_param_enums[] = {
> > @@ -223,6 +229,10 @@ static const struct fs_parameter_spec exfat_parameters[] = {
> >  	fsparam_enum("errors",			Opt_errors, exfat_param_enums),
> >  	fsparam_flag("discard",			Opt_discard),
> >  	fsparam_s32("time_offset",		Opt_time_offset),
> > +	fsparam_flag("utf8",			Opt_utf8),
> > +	fsparam_flag("debug",			Opt_debug),
> > +	fsparam_u32("namecase",			Opt_namecase),
> > +	fsparam_u32("codepage",			Opt_codepage),

	__fsparam(NULL, "utf8",		Opt_utf8, fs_param_deprecated, NULL),
	__fsparam(NULL, "debug",	Opt_debug, fs_param_deprecated, NULL),
	__fsparam(fs_param_is_u32, "namecase", Opt_namecase,
						fs_param_deprecated, NULL),
	__fsparam(fs_param_is_u32, "codepage", Opt_codepage,
						fs_param_deprecated, NULL),

> > @@ -278,6 +288,18 @@ static int exfat_parse_param(struct fs_context *fc, struct fs_parameter *param)
> >  			return -EINVAL;
> >  		opts->time_offset = result.int_32;
> >  		break;
> > +	case Opt_utf8:
> > +		pr_warn("exFAT-fs: 'utf8' mount option is deprecated and has no effect\n");
> > +		break;
> > +	case Opt_debug:
> > +		pr_warn("exFAT-fs: 'debug' mount option is deprecated and has no effect\n");
> > +		break;
> > +	case Opt_namecase:
> > +		pr_warn("exFAT-fs: 'namecase' mount option is deprecated and has no effect\n");
> > +		break;
> > +	case Opt_codepage:
> > +		pr_warn("exFAT-fs: 'codepage' mount option is deprecated and has no effect\n");
> > +		break;

and then you don't need this hunk because the fs parser will print the
deprecated message for you.
