Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C95566D8EA5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Apr 2023 07:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234979AbjDFFD3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Apr 2023 01:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234949AbjDFFD1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Apr 2023 01:03:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7A228A6F
        for <linux-fsdevel@vger.kernel.org>; Wed,  5 Apr 2023 22:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680757361;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PqCIoTjskUFCsaWO0NwsbyWLuR/Gu7pPO1hvXt7JTC0=;
        b=canmXD/nAHnNDbLFmfR4famtATDv30qnEPsA7s5oHZQ2LtAEYt6sOTWi1GqnHOdsidrNKe
        ikJcwkyRTMX/Vd77bRLnM5oj7Wz/+h0d0BGgL/FH/UhJUy6uI1Y4fG24I+cDW/EPj+vwa/
        w1c3CznZ1SX9VsYF64YwjMnivz+MbUI=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-363-PRN9_5YEO-21o7kYv-xooQ-1; Thu, 06 Apr 2023 01:02:34 -0400
X-MC-Unique: PRN9_5YEO-21o7kYv-xooQ-1
Received: by mail-pl1-f198.google.com with SMTP id c8-20020a170902d48800b001a1e0fd4085so22615804plg.20
        for <linux-fsdevel@vger.kernel.org>; Wed, 05 Apr 2023 22:02:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680757353;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PqCIoTjskUFCsaWO0NwsbyWLuR/Gu7pPO1hvXt7JTC0=;
        b=UkzLLOIk1lsotKoFGwU0l5mjT9YQhIh++P/L9grC8pMiaIuhmqeexG0GtmU6xOmHJO
         lTjszaTBolwyRF4dxeHayUcALuGmZUC4JA0KOfYjnEs6rnHlclbLOZAFGSd197aw3NAd
         AKtHijDNmAQoq44+axSI9H2RXH8NI70/KljFNswoEvl7qkfeDRA0Vf3eyPTGisActWlI
         T7H1akxNjor45/bML9fjuZd+nqMiJ1TJHpuw/jDGtLzIDxb4mTl+ik5a64wLch7l3QkW
         rUkxGBP40ZNoAUQvImAl4iFFMBfPT7yJDJSbYq5lyaQ+bA41lxCWnUmWXt/FMV9S4yIg
         oPDw==
X-Gm-Message-State: AAQBX9faAJTITSFxUB5+wqui4JAbNki/8Ej/h4ZJgC+J1wENC2asiydG
        cWvIvqrG5cm88EUW9KMffetSBMZckc2e1xPuSFYzK4nif2WlPDSUlwrC5rMgKiGTVP3UmI7Ewd0
        emU1BueoOSPRNPcldZa1yforSVA==
X-Received: by 2002:a17:90b:4c0a:b0:23f:1210:cea4 with SMTP id na10-20020a17090b4c0a00b0023f1210cea4mr9703900pjb.18.1680757353255;
        Wed, 05 Apr 2023 22:02:33 -0700 (PDT)
X-Google-Smtp-Source: AKy350Zf19cjvyIcJ4uQD1BsrXEt+GMHe0xQGp8F3SkTT4F4OA14phVoFQMkrcnZoSqp3f92WI+dZQ==
X-Received: by 2002:a17:90b:4c0a:b0:23f:1210:cea4 with SMTP id na10-20020a17090b4c0a00b0023f1210cea4mr9703872pjb.18.1680757352886;
        Wed, 05 Apr 2023 22:02:32 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id n32-20020a17090a2ca300b00227223c58ecsm258992pjd.42.2023.04.05.22.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 22:02:32 -0700 (PDT)
Date:   Thu, 6 Apr 2023 13:02:28 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 4/5] fstests/MAINTAINERS: add some specific reviewers
Message-ID: <20230406050228.5ujhuamrqqdjqu77@zlang-mailbox>
References: <20230404171411.699655-1-zlang@kernel.org>
 <20230404171411.699655-5-zlang@kernel.org>
 <20230405-idolisieren-sperren-3c7042b9ed1f@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230405-idolisieren-sperren-3c7042b9ed1f@brauner>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 05, 2023 at 09:47:55AM +0200, Christian Brauner wrote:
> On Wed, Apr 05, 2023 at 01:14:10AM +0800, Zorro Lang wrote:
> > Some people contribute to someone specific fs testing mostly, record
> > some of them as Reviewer.
> > 
> > Signed-off-by: Zorro Lang <zlang@kernel.org>
> > ---
> > 
> > If someone doesn't want to be in cc list of related fstests patch, please
> > reply this email, I'll remove that reviewer line.
> > 
> > Or if someone else (who contribute to fstests very much) would like to a
> > specific reviewer, nominate yourself to get a review.
> > 
> > Thanks,
> > Zorro
> > 
> >  MAINTAINERS | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 620368cb..0ad12a38 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -108,6 +108,7 @@ Maintainers List
> >  	  or reviewer or co-maintainer can be in cc list.
> >  
> >  BTRFS
> > +R:	Filipe Manana <fdmanana@suse.com>
> >  L:	linux-btrfs@vger.kernel.org
> >  S:	Supported
> >  F:	tests/btrfs/
> > @@ -137,16 +138,19 @@ F:	tests/f2fs/
> >  F:	common/f2fs
> >  
> >  FSVERITY
> > +R:	Eric Biggers <ebiggers@google.com>
> >  L:	fsverity@lists.linux.dev
> >  S:	Supported
> >  F:	common/verity
> >  
> >  FSCRYPT
> > +R:	Eric Biggers <ebiggers@google.com>
> >  L:      linux-fscrypt@vger.kernel.org
> >  S:	Supported
> >  F:	common/encrypt
> >  
> >  FS-IDMAPPED
> 
> I'd just make this VFS since src/vfs/ covers generic vfs functionality.
> 
> But up to you,

Sure, it can be "VFS". I didn't use "VFS" directly due to vfs is larger, current
src/vfs only tests a small part of it, more tests are under tests/generic directory.
And we don't have many vfs tests, e.g. we don't test new mount API in fstests.

We need a way to sort out "VFS" only files/tests (e.g. group tag), and if we use
"VFS" at here, would you like to be a reviewer of all vfs tests?

Thanks,
Zorro

> 
> Acked-by: Christian Brauner <brauner@kernel.org>
> 
> > +R:	Christian Brauner <brauner@kernel.org>
> >  L:	linux-fsdevel@vger.kernel.org
> >  S:	Supported
> >  F:	src/vfs/
> > @@ -163,6 +167,7 @@ S:	Supported
> >  F:	tests/ocfs2/
> >  
> >  OVERLAYFS
> > +R:	Amir Goldstein <amir73il@gmail.com>
> >  L:	linux-unionfs@vger.kernel.org
> >  S:	Supported
> >  F:	tests/overlay
> > @@ -174,6 +179,7 @@ S:	Supported
> >  F:	tests/udf/
> >  
> >  XFS
> > +R:	Darrick J. Wong <djwong@kernel.org>
> >  L:	linux-xfs@vger.kernel.org
> >  S:	Supported
> >  F:	common/dump
> > -- 
> > 2.39.2
> > 
> 

