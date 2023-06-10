Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49A0D72AF84
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Jun 2023 00:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231781AbjFJWce (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 10 Jun 2023 18:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjFJWcd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 10 Jun 2023 18:32:33 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 698EA3589
        for <linux-fsdevel@vger.kernel.org>; Sat, 10 Jun 2023 15:32:32 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1b01d3bb571so14863075ad.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 10 Jun 2023 15:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1686436352; x=1689028352;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yIMevQtafEsanIaRpoX6Xg8apLrTfiAQUxFguirgsS4=;
        b=ZSWqsuDCkm85kpo25ZJDyW9qqRe+Bhjz7weXfYfE4wwpRDqIECq9Dc0d6IWh4NK2zb
         bfMiGXgn6IxFDrngUtiI6bl4D6cLDKAjdiKbfpichvHe1Mw6IJSYTT5NRnT21JLqH34f
         06tDZe1TOCnhJvsgMngvsHLQ7XCHkPXDS/0/+7Mt8BNXCyqae2LZs8zVp1aOrQmM7qpL
         JUc03DN44mfKkCudMfji15bkQYk26yGDLQ+l/cdei//8jfaDTIQ+Ax/myTJZ3rpeGMwv
         eUpwd6kqNs677UXDbSiwOUeTr703xjfsRQ6B2HqD5eHvKAh4HwB9PhlMZtXnBIxM3BTO
         ixqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686436352; x=1689028352;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yIMevQtafEsanIaRpoX6Xg8apLrTfiAQUxFguirgsS4=;
        b=CUdqCpNvA5lPkvAdgRiuvMoORCU6qDXoeJbt2eGZqSkGOPrMQ9h0wzLSqGtMKM2fJb
         0cymGcfrjATMZot2YVcmNHsvOauLLSeimoCZGF3Ixwl7KqpG3OegOCiXC9yNpM7zlHpW
         qVNEMEQb98TH392Uj3OfVNaR4oUhlQGwSkrNF47bZOVqhJwZPqXntqFfFWshtRUZgIdp
         2Ah0EfX0qYJK4k599Nl+6LqBH0ITagtxWJp6+tbhDd1FW61E76MwfDrfcCcCn6jHubuE
         aFIB8mes6bX62JR375H48ekgC2Y3uxYYR432KfwOZ4WJUU3e4PkLOOLPo91wsMZ4wn8F
         Fbuw==
X-Gm-Message-State: AC+VfDxnui778hIkrJHUbQQeRm5wpsxoF6nmwXByKDGfC0DSe4iGy8NM
        OQHUTDtbdw96msVRkjgAj8k0Sg==
X-Google-Smtp-Source: ACHHUZ5mQ6sKDWv4O3omCBMHc2v4zVRCVzstNuuujtL90nnc2U9ek4CLvI8yW5NButAum0FJ0vyzbg==
X-Received: by 2002:a17:902:7616:b0:1b0:7739:657a with SMTP id k22-20020a170902761600b001b07739657amr2674447pll.50.1686436351820;
        Sat, 10 Jun 2023 15:32:31 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-79-151.pa.nsw.optusnet.com.au. [49.179.79.151])
        by smtp.gmail.com with ESMTPSA id k1-20020a170902694100b00199203a4fa3sm5417299plt.203.2023.06.10.15.32.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jun 2023 15:32:31 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1q878G-00AFdI-1H;
        Sun, 11 Jun 2023 08:32:28 +1000
Date:   Sun, 11 Jun 2023 08:32:28 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Subject: Re: [PATCH] ovl: port to new mount api
Message-ID: <ZIT5/ChoiLPEz5o6@dread.disaster.area>
References: <20230605-fs-overlayfs-mount_api-v1-1-a8d78c3fbeaf@kernel.org>
 <CAOQ4uxhMwet9mO2RpsJn0CFGkqJZ-fTYvDFuV-rAD6xy9RZjkw@mail.gmail.com>
 <20230609-hufen-zensor-490247280b6c@brauner>
 <CAOQ4uxhzbAZLydw=eEH12XfR37LDV-E5SD9b_et5QsG+qyLu-Q@mail.gmail.com>
 <20230609-tasten-raumfahrt-7b8a499ef787@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230609-tasten-raumfahrt-7b8a499ef787@brauner>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 09, 2023 at 10:03:07AM +0200, Christian Brauner wrote:
> On Fri, Jun 09, 2023 at 10:38:15AM +0300, Amir Goldstein wrote:
> > On Fri, Jun 9, 2023 at 10:28 AM Christian Brauner <brauner@kernel.org> wrote:
> > > On Thu, Jun 08, 2023 at 09:29:39PM +0300, Amir Goldstein wrote:
> > > > >  fs/overlayfs/super.c | 896 ++++++++++++++++++++++++++++++++-------------------
> > > > >  1 file changed, 568 insertions(+), 328 deletions(-)
> > > > >
> > > >
> > > > Very big patch - Not so easy to review.
> > > > It feels like a large refactoring mixed with the api change.
> > > > Can it easily be split to just the refactoring patch
> > > > and the api change patch? or any other split that will be
> > > > easier to review.
> > >
> > > I don't really think so because you can't do a piecemeal conversion
> > > unfortunately. But if you have concrete ideas I'm happy to hear them.
> > >
> > 
> > To me it looks like besides using new api you changed the order
> > of config parsing to:
> > - fill ovl_config and sanitize path arguments
> >   (replacing string with path in case of upper/workdir)
> 
> Afaict this only makes sense if you cane have a sensible split between
> option parsing and superblock creation. While the new mount api does
> have that the old one doesn't. So ovl_fill_super() does option parsing,
> verification, and superblock creation.

This is the same problem we had with XFS and ext4 conversions, and
to a lesser extent all the other simpler ones that have been done.

There is no real intermediate step - the change from old parser to
new parser as an atomic unit of change comes down to a single large
patch. Yes, we whittled away at the edges to make it a bit smaller,
but in the end the core API changeover was still a single large
patch...

> So I honestly thing this might end up being churn for churn. But I'll do
> it if you insist.

Yup, based on the experience of converting other filesytsems, I
think it is largely a waste of time and effort to try to
significantly rework this into smaller chunks.  The bulk of the work
has been done, reworking individual patches doesn't change the end
result, so just review it as is, merge it and move on with more
important stuff....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
