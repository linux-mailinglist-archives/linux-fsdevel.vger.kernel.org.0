Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5486C4A6E2C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Feb 2022 10:54:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbiBBJyH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Feb 2022 04:54:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiBBJyG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Feb 2022 04:54:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAE86C061714;
        Wed,  2 Feb 2022 01:54:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 79CC761347;
        Wed,  2 Feb 2022 09:54:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EBC3C004E1;
        Wed,  2 Feb 2022 09:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643795645;
        bh=ymx4fVg2b8Cf9MLrfn/D1ufiCS9ewfVqV7L5onrPKoM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D3WXDw3ey3xl3Pf4AwGt9UQDfHPDqlMuMHtsmtuXCRX7uouPZtnpEOnH7Q2cvlcCz
         CmNocV4fVh9rVZxjqApwffQMvmQyBT0pH+MHMfYwjowKJTu/3fdN0QAk1Wz6h/yet9
         w0exBriYqTLG8CQcJITmBk0YRjooL27xnUoYrYsL4/89zjICrykFuR8F+1b0cIfVca
         JBfi9csOgUYIYFjrI1p1Usoo8n5lDRWPfzf6VaLZkeAxg3ZS+GvB06spxcVkNWbKGJ
         7o6SyQoi88f27fS5Gkw0+TVqDzrj1yFuDbhvi/Y8+l56Yc/w7jXtAlcfCvX7Rhg6ed
         I3g5+x4f+lmog==
Date:   Wed, 2 Feb 2022 10:53:58 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     Eryu Guan <guan@eryu.me>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        Ariadne Conill <ariadne@dereferenced.org>,
        Kees Cook <keescook@chromium.org>,
        Rich Felker <dalias@libc.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH] generic/633: adapt execveat() invocations
Message-ID: <20220202095358.gz6pjczalzpluxvh@wittgenstein>
References: <20220131171023.2836753-1-brauner@kernel.org>
 <08ff2c7dd57449a7ae9de70ba007c5fd@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <08ff2c7dd57449a7ae9de70ba007c5fd@AcuMS.aculab.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 02, 2022 at 08:36:05AM +0000, David Laight wrote:
> From: Christian Brauner
> > Sent: 31 January 2022 17:10
> > 
> > There's a push by Ariadne to enforce that argv[0] cannot be NULL. So far
> > we've allowed this. Fix the execveat() invocations to set argv[0] to the
> > name of the file we're about to execute.
> > 
> ...
> >  src/idmapped-mounts/idmapped-mounts.c | 16 ++++++++--------
> >  1 file changed, 8 insertions(+), 8 deletions(-)
> > 
> > diff --git a/src/idmapped-mounts/idmapped-mounts.c b/src/idmapped-mounts/idmapped-mounts.c
> > index 4cf6c3bb..76b559ae 100644
> > --- a/src/idmapped-mounts/idmapped-mounts.c
> > +++ b/src/idmapped-mounts/idmapped-mounts.c
> > @@ -3598,7 +3598,7 @@ static int setid_binaries(void)
> >  			NULL,
> >  		};
> >  		static char *argv[] = {
> > -			NULL,
> > +			"",
> >  		};
> 
> Isn't that just plain wrong?
> argv[] needs to be terminated by a NULL so you need to add the ""
> before the NULL not replace the NULL by it.
> 
> Quite how this matches the patch description is another matter...

Bah, braino. I fired that too quickly.
