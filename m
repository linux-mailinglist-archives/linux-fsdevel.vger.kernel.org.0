Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E39559807B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Aug 2022 11:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbiHRJDp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Aug 2022 05:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231552AbiHRJDo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Aug 2022 05:03:44 -0400
Received: from mta-01.yadro.com (mta-02.yadro.com [89.207.88.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CB8D31EF5;
        Thu, 18 Aug 2022 02:03:43 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id C6B044359E;
        Thu, 18 Aug 2022 09:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        in-reply-to:content-disposition:content-type:content-type
        :mime-version:references:message-id:subject:subject:from:from
        :date:date:received:received:received:received; s=mta-01; t=
        1660813419; x=1662627820; bh=EvJRcBqtaatj5e3YDV8BwcK+UfpGMNa+hDM
        f9JFpMj8=; b=Gfki9RlVP2inj/ynvwWAxPAlqN8LiWO4xevQ06KrZ9TjQ5MAn3v
        8foez+g1uiDb3c/jek0v/aLzo9pRPhCE+luVB6wtbbfKmoo8ri3Kr4awOYLFMoHe
        fKeJtaNFl64+jzEv/Rbuk3BM1p6h4Et8O/owtoXcXig58J/BGwPrfp3I=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 6Ze4dWDVFlB7; Thu, 18 Aug 2022 12:03:39 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 551D843592;
        Thu, 18 Aug 2022 12:03:39 +0300 (MSK)
Received: from T-EXCH-09.corp.yadro.com (172.17.11.59) by
 T-EXCH-02.corp.yadro.com (172.17.10.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.669.32; Thu, 18 Aug 2022 12:03:39 +0300
Received: from yadro.com (10.178.119.167) by T-EXCH-09.corp.yadro.com
 (172.17.11.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1118.9; Thu, 18 Aug
 2022 12:03:38 +0300
Date:   Thu, 18 Aug 2022 12:03:37 +0300
From:   Konstantin Shelekhin <k.shelekhin@yadro.com>
To:     Kees Cook <keescook@chromium.org>
CC:     <ojeda@kernel.org>, <boqun.feng@gmail.com>,
        <gregkh@linuxfoundation.org>, <jarkko@kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@lists.linux.dev>, <rust-for-linux@vger.kernel.org>,
        <torvalds@linux-foundation.org>
Subject: Re: [PATCH v9 01/27] kallsyms: use `sizeof` instead of hardcoded size
Message-ID: <Yv4AaeUToxSJZK/v@yadro.com>
References: <20220805154231.31257-2-ojeda@kernel.org>
 <Yu2cYShT1h8gquW8@yadro.com>
 <202208171235.52D14C2A@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <202208171235.52D14C2A@keescook>
X-Originating-IP: [10.178.119.167]
X-ClientProxiedBy: T-EXCH-02.corp.yadro.com (172.17.10.102) To
 T-EXCH-09.corp.yadro.com (172.17.11.59)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 17, 2022 at 12:36:33PM -0700, Kees Cook wrote:
> On Sat, Aug 06, 2022 at 01:40:33AM +0300, Konstantin Shelekhin wrote:
> > > diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
> > > index f18e6dfc68c5..52f5488c61bc 100644
> > > --- a/scripts/kallsyms.c
> > > +++ b/scripts/kallsyms.c
> > > @@ -206,7 +206,7 @@ static struct sym_entry *read_symbol(FILE *in)
> > >
> > >     rc = fscanf(in, "%llx %c %499s\n", &addr, &type, name);
> > >     if (rc != 3) {
> > > -           if (rc != EOF && fgets(name, 500, in) == NULL)
> > > +           if (rc != EOF && fgets(name, sizeof(name), in) == NULL)
> > >                     fprintf(stderr, "Read error or end of file.\n");
> > >             return NULL;
> > >     }
> >
> > Might be another nit, but IMO it's better to use ARRAY_SIZE() here.
> 
> I'm not sure I see a benefit for char arrays. It'll produce the same
> result, and the tradition for string functions is to use sizeof().
> *shrug*

ARRAY_SIZE() (though not this one) can catch this:

  - char array[16];
  + char *array;

Saves me some.
