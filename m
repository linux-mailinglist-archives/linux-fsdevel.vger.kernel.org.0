Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4E763B5F4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Nov 2022 00:32:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234709AbiK1Xcr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Nov 2022 18:32:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234712AbiK1Xcl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Nov 2022 18:32:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE5BD60C1;
        Mon, 28 Nov 2022 15:32:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 71E3BB8103F;
        Mon, 28 Nov 2022 23:32:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1801AC433C1;
        Mon, 28 Nov 2022 23:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669678358;
        bh=nhzT3y8ECc0SM21u2kRL+g3RxzJpgEVvUa1o+ZAysIg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FM+zDegQkndaejyfC/Pw0kByEiz8hd1zlGhElcy0NsHeEm/jITQZDs+eoaBfL/YiN
         uQwnRCGHtz6CxzGfz8l1gMsi501ScGPcDTGYZPgCqkoewVwsAFWDtWEqhUye7OUkDz
         jZR9shAQ6cW+qmJ5RNGBmDje5iWBRxkzMmL5A9C97kVMdtZQx4ilbvo8LbQUAwClAL
         WFfYNJddlYY1l2j3Qmhs7V3h99abwYqh2CMTJdzqjwj2kMHJOaGtuCsWpyh1m1/uCS
         0up4dVWOBfGM6MOvencqoCJguaAIzelAMtsaDXrPeRfAbBBZAt6lm8Mv8jdzK6SPBH
         +cMrbDmD7VZIA==
Date:   Tue, 29 Nov 2022 07:22:46 +0800
From:   Jisheng Zhang <jszhang@kernel.org>
To:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] coredump: fix compile warning when ELF_CORE=n while
 COREDUMP=y
Message-ID: <Y4VCxuC5UgY80R3t@xhacker>
References: <20221128135056.325-1-jszhang@kernel.org>
 <20221128145956.6rgswicmtsuxxhdt@riteshh-domain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221128145956.6rgswicmtsuxxhdt@riteshh-domain>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 28, 2022 at 08:29:56PM +0530, Ritesh Harjani (IBM) wrote:
> On 22/11/28 09:50PM, Jisheng Zhang wrote:
> > fix below build warning when ELF_CORE=n while COREDUMP=y:
> >
> > fs/coredump.c:834:12: warning: ‘dump_emit_page’ defined but not used [-Wunused-function]
> >   834 | static int dump_emit_page(struct coredump_params *cprm, struct
> >       page *page)
> >       |            ^~~~~~~~~~~~~~
> 
> Fixes: 06bbaa6dc53c: "[coredump] don't use __kernel_write() on kmap_local_page()"
> 
> >
> > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > ---
> >  fs/coredump.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/fs/coredump.c b/fs/coredump.c
> > index 7bad7785e8e6..8663042ebe9c 100644
> > --- a/fs/coredump.c
> > +++ b/fs/coredump.c
> > @@ -831,6 +831,7 @@ static int __dump_skip(struct coredump_params *cprm, size_t nr)
> >  	}
> >  }
> >
> > +#ifdef CONFIG_ELF_CORE
> 
> Instead of this ^^^, we could even move the definition of dump_emit_page() in
> the same #ifdef as of dump_user_range(). Since dump_user_range() is the only
> caller of dump_emit_page().
> 
> #ifdef CONFIG_ELF_CORE
> [here]
> int dump_user_range(struct coredump_params *cprm, unsigned long start,
> 		    unsigned long len)
> {..}
> #endif
> 

I planed to patch like this, but I saw the final patch diffstat was
a bit more. I'll send out a v2.

Thanks

> But I guess that's just a nitpick. Feel free to add:
> 
> Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> 
> -ritesh
> 
> >  static int dump_emit_page(struct coredump_params *cprm, struct page *page)
> >  {
> >  	struct bio_vec bvec = {
> > @@ -863,6 +864,7 @@ static int dump_emit_page(struct coredump_params *cprm, struct page *page)
> >
> >  	return 1;
> >  }
> > +#endif
> >
> >  int dump_emit(struct coredump_params *cprm, const void *addr, int nr)
> >  {
> > --
> > 2.37.2
> >
