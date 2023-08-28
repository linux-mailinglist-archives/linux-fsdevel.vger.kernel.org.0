Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 372AE78B33F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Aug 2023 16:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231504AbjH1OhO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Aug 2023 10:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbjH1Ogn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Aug 2023 10:36:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 868E7CC
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Aug 2023 07:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693233356;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fseQpsy0VfGLC0oUmmsTYhYRD4hK2JRI8+6aM8OkWNM=;
        b=HyLv2NzubMPB29JhtECRSM44Y2oTFntCeAmv6wOcRFGQkxWJrhMFS8HK2XJuIFZn2xG3Ig
        4pskyn9ha346nL3sXfFfZKAcew+X3f9sVexqdwEFTPeVbZEQxQftln48PEzJerebZldj+V
        uhInDSfhXrPLmM5Wxxyc3PYC8c1KZI0=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-119-MzruOSxLMJiK83Lo0cGjSw-1; Mon, 28 Aug 2023 10:35:41 -0400
X-MC-Unique: MzruOSxLMJiK83Lo0cGjSw-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-26d269dc983so2680446a91.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Aug 2023 07:35:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693233340; x=1693838140;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fseQpsy0VfGLC0oUmmsTYhYRD4hK2JRI8+6aM8OkWNM=;
        b=cPCpoScceN/WjS4iy7RBGfTsEwZAwxDiMcJioN0EyhWYxfnuCNDcHunY0MocgtrD7o
         gnEaAk5Bg4lxob9cfYoYbFdO8yV8FfGO0bMIgRFT8GOwxDHVtSlHA8jREyDvmI+otKgF
         W8yqMU73kxb7qW7iLbFt0dpDpry0UFWWCeWrk4Vm5x1d5+UQ6MOe9pwiuqYCSOBPKBEH
         97+SmxRT2QsyfGvDc5VghPG2xKmg4H/ebeXYPuTe7dBT/9oPooJ/fh93qAd07+Qdxbwn
         H6Mda3sXlGvJBMutNdOM6UNyRtKoKu7Bz7xjMBS/PV5IrLhu+Nl5KBcfocbZQrGwS9VE
         yh/w==
X-Gm-Message-State: AOJu0YzbC2fCJd6wl5mS7mE6tf8VR0eCZ+IbCKQ1XmlkF6uLsfBlvv3D
        Rt3s0p2ve2UissDu2++nco4wIXNJ0FQxeK+Ny33RPKmM9/Ft57mSerjX6+/6oTGsumIWyRtrOO9
        qaZ2VNXicU/6pglyLRrzfN4BGBQ==
X-Received: by 2002:a17:90b:4a02:b0:26b:5205:525e with SMTP id kk2-20020a17090b4a0200b0026b5205525emr17869140pjb.42.1693233340065;
        Mon, 28 Aug 2023 07:35:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEVbS19uRYDlaiiPTcaLBl0QGZmCnV0XyUvmfp20Gbl9HdoVcc6Bml998WVwCap7gkYsRIoKA==
X-Received: by 2002:a17:90b:4a02:b0:26b:5205:525e with SMTP id kk2-20020a17090b4a0200b0026b5205525emr17869121pjb.42.1693233339747;
        Mon, 28 Aug 2023 07:35:39 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 20-20020a17090a199400b00268238583acsm9670672pji.32.2023.08.28.07.35.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 07:35:39 -0700 (PDT)
Date:   Mon, 28 Aug 2023 22:35:35 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH fstests v2 2/3] generic/513: limit to filesystems that
 support capabilities
Message-ID: <20230828143535.6x3duax7g43vhg5k@zlang-mailbox>
References: <20230824-fixes-v2-0-d60c2faf1057@kernel.org>
 <20230824-fixes-v2-2-d60c2faf1057@kernel.org>
 <20230825141123.wexv7kuxk75gr5os@zlang-mailbox>
 <a93ba004a46177c213159878a51c7378536f33ad.camel@kernel.org>
 <20230827124512.23qnfe3keedrf4a2@zlang-mailbox>
 <45e9152ccb8afdced1c1f6887368fec59804c6d9.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45e9152ccb8afdced1c1f6887368fec59804c6d9.camel@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Aug 27, 2023 at 09:43:41AM -0400, Jeff Layton wrote:
> On Sun, 2023-08-27 at 20:45 +0800, Zorro Lang wrote:
> > On Fri, Aug 25, 2023 at 11:02:40AM -0400, Jeff Layton wrote:
> > > On Fri, 2023-08-25 at 22:11 +0800, Zorro Lang wrote:
> > > > On Thu, Aug 24, 2023 at 12:44:18PM -0400, Jeff Layton wrote:
> > > > > This test requires being able to set file capabilities which some
> > > > > filesystems (namely NFS) do not support. Add a _require_setcap test
> > > > > and only run it on filesystems that pass it.
> > > > > 
> > > > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > > > ---
> > > > >  common/rc         | 13 +++++++++++++
> > > > >  tests/generic/513 |  1 +
> > > > >  2 files changed, 14 insertions(+)
> > > > > 
> > > > > diff --git a/common/rc b/common/rc
> > > > > index 5c4429ed0425..33e74d20c28b 100644
> > > > > --- a/common/rc
> > > > > +++ b/common/rc
> > > > > @@ -5048,6 +5048,19 @@ _require_mknod()
> > > > >  	rm -f $TEST_DIR/$seq.null
> > > > >  }
> > > > >  
> > > > > +_require_setcap()
> > > > > +{
> > > > > +	local testfile=$TEST_DIR/setcaptest.$$
> > > > > +
> > > > > +	touch $testfile
> > > > > +	$SETCAP_PROG "cap_sys_module=p" $testfile > $testfile.out 2>&1
> > > > 
> > > > Actually we talked about the capabilities checking helper last year, as below:
> > > > 
> > > > https://lore.kernel.org/fstests/20220323023845.saj5en74km7aibdx@zlang-mailbox/
> > > > 
> > > > As you bring this discussion back, how about the _require_capabilities() in
> > > > above link?
> > > > 
> > > 
> > > I was testing a similar patch, but your version looks better. Should I
> > > drop mine and you re-post yours?
> > 
> > Actually we decided to use `_require_attrs security`, rather than a new
> > _require_capabilities() helper. We need a chance/requirement to add
> > that helper (when a test case really need it).
> > 
> > So I hope know is `_require_attrs security` enough for you? Or you really
> > need a specific _require_capabilities helper?
> > 
> > Thanks,
> > Zorro
> > 
> > 
> 
> 
> Yeah, it looks like that should work:
> 
>     generic/513       [not run] attr namespace security not supported by this filesystem type: nfs
> 
> I'll plan to respin this patch to add that instead.

Thanks:) I saw you've sent a V3:
[PATCH fstests v3 0/2] fstests: add appropriate checks for fs features for some tests

so will you sent a V4 contains 3 patches?

Thanks,
Zorro

> 
> Thanks!
> -- 
> Jeff Layton <jlayton@kernel.org>
> 

