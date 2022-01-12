Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0BA248BEDB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jan 2022 08:11:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237480AbiALHLg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jan 2022 02:11:36 -0500
Received: from condef-02.nifty.com ([202.248.20.67]:50852 "EHLO
        condef-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237258AbiALHLf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jan 2022 02:11:35 -0500
X-Greylist: delayed 505 seconds by postgrey-1.27 at vger.kernel.org; Wed, 12 Jan 2022 02:11:35 EST
Received: from conssluserg-03.nifty.com ([10.126.8.82])by condef-02.nifty.com with ESMTP id 20C6vfAI019493
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Jan 2022 15:57:41 +0900
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 20C6vG0S003348;
        Wed, 12 Jan 2022 15:57:16 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 20C6vG0S003348
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1641970637;
        bh=i1PlQ/quVgHzU+uDRbIbEo3QNPjg7ooeaREp/ks6wOM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ICbm5xMSp2Rq1ZNEnqifbhpXLl/mBfaOCfaq8oby1oEnPzmGVnAMWazopuoTkAf6a
         hJar+E/+U1YL0+6vL9VXa5B09w6yh/AFG/dcCB5Hn9jgyC71gpB9yc34l1i+BHDopC
         bOHaNIZtKpMf229FSkIMd9A1yEEYUzmQ+PHVE/SJc8vs253VXDURmm7Rz07Z9LkDA0
         EHbSToLgDBuwYe4Y7M2QJiJlbXVHgz77y2Aoe1SfOt9qC5eWwExVAp3hEAp0nEFB8w
         J3yINjhDp6CEIdn1kde2TMxWmsbb6yh8PW+KCV4wWJzxPdqjVLakNYqEoQbPL6WGfj
         Dnkf/SfrbFsDQ==
X-Nifty-SrcIP: [209.85.216.46]
Received: by mail-pj1-f46.google.com with SMTP id o3so3041388pjs.1;
        Tue, 11 Jan 2022 22:57:16 -0800 (PST)
X-Gm-Message-State: AOAM530XgSZw2Ul6QqwESjU9+sUqHtBxDGXy2wMIowMb7pgzOyhpIF+d
        Jbk46IbfycTFgUFNrOEX1o2l+RQ8qgMDKiAFq4A=
X-Google-Smtp-Source: ABdhPJxeLBb7B/GCmOS/c/vzomfd/+R2HLi234h6SPu7Vtzuz0ghOnqw0U5tHKWS3/3pgg8evXBZKbvEF6DeKNeM0C0=
X-Received: by 2002:a17:90a:680a:: with SMTP id p10mr7196155pjj.144.1641970635971;
 Tue, 11 Jan 2022 22:57:15 -0800 (PST)
MIME-Version: 1.0
References: <20220112023416.215644-1-mcgrof@kernel.org> <3e721c69-afa9-6634-2e52-e9a9c2a89372@infradead.org>
In-Reply-To: <3e721c69-afa9-6634-2e52-e9a9c2a89372@infradead.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 12 Jan 2022 15:56:39 +0900
X-Gmail-Original-Message-ID: <CAK7LNARiDFpphJrhk5q00d5sSPWAQ2mMLu8Z2YP0Xwk=3WGt3w@mail.gmail.com>
Message-ID: <CAK7LNARiDFpphJrhk5q00d5sSPWAQ2mMLu8Z2YP0Xwk=3WGt3w@mail.gmail.com>
Subject: Re: [PATCH] firmware_loader: simplfy builtin or module check
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Borislav Petkov <bp@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 12, 2022 at 3:37 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
>
>
> On 1/11/22 18:34, Luis Chamberlain wrote:
> > The existing check is outdated and confuses developers. Use the
> > already existing IS_ENABLED() defined on kconfig.h which makes
> > the intention much clearer.
> >
> > Reported-by: Borislav Petkov <bp@alien8.de>
> > Reported-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
>
> Acked-by: Randy Dunlap <rdunlap@infradead.org>
>
> Thanks.
>
> > ---
> >  include/linux/firmware.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/include/linux/firmware.h b/include/linux/firmware.h
> > index 3b057dfc8284..fa3493dbe84a 100644
> > --- a/include/linux/firmware.h
> > +++ b/include/linux/firmware.h
> > @@ -34,7 +34,7 @@ static inline bool firmware_request_builtin(struct firmware *fw,
> >  }
> >  #endif
> >
> > -#if defined(CONFIG_FW_LOADER) || (defined(CONFIG_FW_LOADER_MODULE) && defined(MODULE))
>
> The "defined(MODULE)" part wasn't needed here. :)



It _is_ needed.

This seems to be equivalent to IS_REACHABLE(CONFIG_FW_LOADER),
not IS_ENABLE(CONFIG_FW_LOADER).



>
> > +#if IS_ENABLED(CONFIG_FW_LOADER)
> >  int request_firmware(const struct firmware **fw, const char *name,
> >                    struct device *device);
> >  int firmware_request_nowarn(const struct firmware **fw, const char *name,
>
> --
> ~Randy



-- 
Best Regards
Masahiro Yamada
