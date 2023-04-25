Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67C036EE242
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Apr 2023 14:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233886AbjDYM4R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Apr 2023 08:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233800AbjDYM4Q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Apr 2023 08:56:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E6B3D307
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Apr 2023 05:56:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1A52261646
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Apr 2023 12:56:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41545C433D2;
        Tue, 25 Apr 2023 12:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682427374;
        bh=gVGfA5ZlFxWtmoGDNRKOJuot728x2y0cce+aV9eRCr8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=enNPdstcCR1OaTU62ObPEv1xx9KkVtuqL3DglGygH/RA8UgdxPFBCDaQk9SLrPvC9
         XsVsHVfmuPWDnoP+jxvhLgS6gRelh9TthWhmNjWdk1w6SF2QbobfVp3VVijgGEqOJx
         XjKySR1cF1KI5RVToMpd0GB4JaGxQ0IBjAMFRXTdZ3EBo78NerKHRRfTyYGueOrxcr
         Ve7rFZxpbK5ktZ7McseQVjavds9gxEgT7G72FWhbNSnqqA7twRlDkXI/2ePUr6XM0X
         ki/YrXumqYAr54c/pRHiR7VTWdNgMGbLqyYWQ529jbi+vbWM9uBGfsjEwqSym+WQOd
         RPA1t0gfKppDg==
Date:   Tue, 25 Apr 2023 14:56:10 +0200
From:   Carlos Maiolino <cem@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     hughd@google.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, djwong@kernel.org
Subject: Re: [PATCH V3 6/6] Add default quota limit mount options
Message-ID: <20230425125610.xjbkxlozfvio2ihh@andromeda>
References: <20230420080359.2551150-7-cem@kernel.org>
 <20230425115725.2913656-1-cem@kernel.org>
 <TKImHxraRSMubDtoPH1UEQ_fhD7pIJaiCnH3Am2xGlnJsjVV3h1sAxBQuF_M17myRFCD5e1n8bMFL_4ro5w_uw==@protonmail.internalid>
 <20230425123042.ja6oab6yhtzqnwyl@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230425123042.ja6oab6yhtzqnwyl@quack3>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 25, 2023 at 02:30:42PM +0200, Jan Kara wrote:
> On Tue 25-04-23 13:57:25, cem@kernel.org wrote:
> > From: Lukas Czerner <lczerner@redhat.com>
> >
> > Allow system administrator to set default global quota limits at tmpfs
> > mount time.
> >
> > Signed-off-by: Lukas Czerner <lczerner@redhat.com>
> > Signed-off-by: Carlos Maiolino <cmaiolino@redhat.com>
> ...
> > @@ -224,6 +233,29 @@ static int shmem_acquire_dquot(struct dquot *dquot)
> >  	return ret;
> >  }
> >
> > +static bool shmem_is_empty_dquot(struct dquot *dquot)
> > +{
> > +	struct shmem_sb_info *sbinfo = dquot->dq_sb->s_fs_info;
> > +	qsize_t bhardlimit;
> > +	qsize_t ihardlimit;
> > +
> > +	if (dquot->dq_id.type == USRQUOTA) {
> > +		bhardlimit = sbinfo->qlimits.usrquota_bhardlimit;
> > +		ihardlimit = sbinfo->qlimits.usrquota_ihardlimit;
> > +	} else if (dquot->dq_id.type == GRPQUOTA) {
> > +		bhardlimit = sbinfo->qlimits.usrquota_bhardlimit;
> > +		ihardlimit = sbinfo->qlimits.usrquota_ihardlimit;
> 
> There should be grpquota in the above two lines. Otherwise the patch looks
> good to me.

Uff, sorry, copy/paste mistake. Can I add your RwB once I fix it? Or do you want
me to send a V4?


> 
> 								Honza
> 
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

-- 
Carlos Maiolino
