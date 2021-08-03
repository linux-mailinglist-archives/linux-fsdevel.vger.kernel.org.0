Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0775A3DF15F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Aug 2021 17:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236695AbhHCP05 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Aug 2021 11:26:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236685AbhHCP0s (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Aug 2021 11:26:48 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45FAFC061757;
        Tue,  3 Aug 2021 08:26:25 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id m9so28614206ljp.7;
        Tue, 03 Aug 2021 08:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CmOw+Pm/mK8de7PtTygDQNxjNMTGWeUADUOs/i9z3yo=;
        b=Nz5QHhuS6VsUmzHCAfGeFGjXP6SkzoVYLbb38gtZBotiggF4JkvHe9033bl2PAgQwI
         6EcYcEhi6E9jlrXEYa8Xz492YUCzZqtC9gRdGlF4JhEj+c3H7+KewvaVU97xZsxSQJHf
         swtHpQq1309Fqz7c0rBFTM3yvdVrcEyyH0lZ+RkzXgQYQQTIMDLenxY2S6SPP+Ve57tn
         zKtm4/3jvI6vrGRGMKtXPTvN5XptOH4rAEgz9ZszbbOSf7YPjunRgus3az+b8gbyn9gp
         BvNmw3y1a7Mac1l4mlVkqfjIhYEtBkxDIPiMK4xtkf1t4+BLonHJGj8tvYPZoDGQfVoq
         7CTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CmOw+Pm/mK8de7PtTygDQNxjNMTGWeUADUOs/i9z3yo=;
        b=kLBVEUpPFVAHUHSHbq01lKEZLp2jVpxGZiIFH/2gZqXbA6HLrU/VCL4kf/JXMS8IRm
         prbo1MSlFv+xc1oMTIgaL5KhblGpRyTy9jY/AKMvdjoJjfYibzuLNdDLnr1z/FFPcYhm
         n732jqUnMKoEenq7zpUhDX33FtbFiY1YGyTlaBmhgPWNaFJpEEQzKJLnkFpHTmmrflVm
         Uf15+t3JaN11I8LwhsqiYKubEDRiO5Gd36WliCpMMgnr6lIJ4WRVvfnBUMMMY7Xvxt4M
         sML2Ry0EfJAWpQL8cUwQrjOuXkH2BLuhpEtD7u7TaabTLHO0pKto7GuLFsx3l8uXyaGQ
         MA7Q==
X-Gm-Message-State: AOAM5302WkAlSf1lDNf5sVVl/SUEYtCOkHwwkR1n2FMMQosE+Pc8d8Lh
        OMqiPvFowbfuyv67vS8qHMA=
X-Google-Smtp-Source: ABdhPJziKtAoeu6dr48FWx+DCgCfalfKAiDyCq2XTpF8hkV+E3yReb62TWggUf95J/UkHGR6mP+9kA==
X-Received: by 2002:a05:651c:1072:: with SMTP id y18mr15617802ljm.306.1628004382224;
        Tue, 03 Aug 2021 08:26:22 -0700 (PDT)
Received: from kari-VirtualBox (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
        by smtp.gmail.com with ESMTPSA id t17sm1095313ljk.102.2021.08.03.08.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 08:26:21 -0700 (PDT)
Date:   Tue, 3 Aug 2021 18:26:19 +0300
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, pali@kernel.org, dsterba@suse.cz,
        aaptel@suse.com, willy@infradead.org, rdunlap@infradead.org,
        joe@perches.com, mark@harmstone.com, nborisov@suse.com,
        linux-ntfs-dev@lists.sourceforge.net, anton@tuxera.com, hch@lst.de,
        ebiggers@kernel.org, andy.lavr@gmail.com, oleksandr@natalenko.name
Subject: Re: [PATCH] Restyle comments to better align with kernel-doc
Message-ID: <20210803152619.hva737erzqnksfxu@kari-VirtualBox>
References: <20210729134943.778917-1-almaz.alexandrovich@paragon-software.com>
 <20210803115709.zd3gjmxw7oe6b4zk@kari-VirtualBox>
 <20210803133833.GL25548@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210803133833.GL25548@kadam>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 03, 2021 at 04:38:33PM +0300, Dan Carpenter wrote:
> Missing subsystem prefix in the subject.

Yeah. I was not sure what to do here because it is patch to patch. I
will do this in the future.

> On Tue, Aug 03, 2021 at 02:57:09PM +0300, Kari Argillander wrote:
> > Capitalize comments and end with period for better reading.
> > 
> > Also function comments are now little more kernel-doc style. This way we
> > can easily convert them to kernel-doc style if we want. Note that these
> > are not yet complete with this style. Example function comments start
> > with /* and in kernel-doc style they start /**.
> > 
> > Use imperative mood in function descriptions.
> > 
> > Change words like ntfs -> NTFS, linux -> Linux.
> > 
> > Use "we" not "I" when commenting code.
> 
> These are all nonsense style guidelines that you invented yourself.  We
> already have too much pointless bureaucracy.  If you can't understand
> the documentation or if there are typos then, sure, fix that.  But let's
> not invent new rules.

You are correct that I "invent" these. My whole point was just make
ntfs3 constant about these rules. I also notice that I didn't make that
clear at patch message and that was huge mistake from my part.

Now in ntfs3 there is mixing commenting styles and I was just trying to make
these nice before merging. I have no preference but it is nice if example one
driver keep things constant.

I would not even try to make these kind of changes if ntfs3 patch series
was already merged to kernel. But probably I will try to bring kernel doc
style funtion comments in future when ntfs3 gets merged.

> (Also it annoys me when people pretend to be stupid "I can't understand
> what a NULL deference is.  Ohhh...  You mean a NULL *pointer*
> dereference!  You left out the word *pointer* so I didn't understand!")

