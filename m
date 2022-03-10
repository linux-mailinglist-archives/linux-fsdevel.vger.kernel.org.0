Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E66D34D455C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Mar 2022 12:10:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241211AbiCJLLs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Mar 2022 06:11:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233353AbiCJLLr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Mar 2022 06:11:47 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BADB513C9D5
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Mar 2022 03:10:46 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id hw13so10812896ejc.9
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Mar 2022 03:10:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dneg.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fwkGoCkG0C71fo1AtJVK+o7q5+K5z7/hkRewmRR47Cw=;
        b=Wr9uUhDQ8g9dqgW2R7cnvs7E3r2b56tEpqnTojPp1y9LUuscjmau1axLzyJNgrtKf2
         /RYXmgzw04/K93BtJbHCviyVP1Kms36mgdG3Q7dMPQZTMjP7jUDwDrWv0v4a/k7Swcdl
         g/ysQFNn1e3LIVecVSkWotubKzFFn+68CNDbsItvHBTCXjHYxLp3aSaNlb1H55LKuCuy
         dNy/JqZweDy4ZCyW3mBuYKb1DtSnDpDg88q3qQb2uzi96v/mJx+8yrGsZNAShi8UKSUZ
         WH7p4vqQN4jsViEg2sPeFjYJavM8Al8KE1PlAWqcIFU4NPXSelOpqhkq4oAWftJ7mkZH
         H8ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fwkGoCkG0C71fo1AtJVK+o7q5+K5z7/hkRewmRR47Cw=;
        b=ZoojqMw6PPLx00QRLIdPS/U/WgSj9OLA2noKGzRmFxKdu4NrhyR7h6rGVPenyWqGXf
         qeqFx4HdceDwZyTb5FyPMTGV1cuM1+pjeE/C4w+uF65EawYjC8k/r4/8ew6KAZH4V6Kg
         VXQk2LczNYEDoVCjpukimYso0r27y7iWTaPTJgFZHcJNlYkwVvPUdBcxMPaxAiT3FvYs
         7G4hTfZm726+ywD9p7kRavsrawVcjZbXp9MR2yQGIcNEycqtNPUDEtJFh/NEgGw5PLRG
         GWN33ytWsSrcc5EZ3NX3OV3Pu83reNmcdYMsSujBgKSZ0cvgk4BDiCbYTdurnVMSMiL1
         xMAQ==
X-Gm-Message-State: AOAM530cm1g7y7DflBUDKuItEstxf2Q8zQ2Tcu3vMCnqPZgglkJTMy7u
        QA8aD3rTq1UbiHrEWs84jSKnl6reHTk/OiP4mI8vcQ==
X-Google-Smtp-Source: ABdhPJyi4TFDbEcyXKH3iv9ZTrdqHN6gWkpXJe/mwRqm2YfFViKRQ5jOBKIIcEEcuK33ApxfzVaxv3IE+us0Da169vo=
X-Received: by 2002:a17:907:1c95:b0:6db:6b05:549c with SMTP id
 nb21-20020a1709071c9500b006db6b05549cmr3582753ejc.651.1646910645213; Thu, 10
 Mar 2022 03:10:45 -0800 (PST)
MIME-Version: 1.0
References: <164568221518.25116.18139840533197037520@noble.neil.brown.name>
 <893053D7-E5DD-43DB-941A-05C10FF5F396@dilger.ca> <20220224233848.GC8269@magnolia>
 <164600974741.15631.8678502963654197325@noble.neil.brown.name>
In-Reply-To: <164600974741.15631.8678502963654197325@noble.neil.brown.name>
From:   Daire Byrne <daire@dneg.com>
Date:   Thu, 10 Mar 2022 11:10:08 +0000
Message-ID: <CAPt2mGNkQFu=czuM+XO7aVF3AmbPoiq_SU72-Bgfax59JyMkdg@mail.gmail.com>
Subject: Re: [PATCH/RFC] VFS: support parallel updates in the one directory.
To:     NeilBrown <neilb@suse.de>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Andreas Dilger <adilger@dilger.ca>,
        Dave Chinner <david@fromorbit.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Just to add that I have also been testing this patch with heavy
production workloads over high latency NFS clients (200ms) and have
not seen any issues so far.

As the latency increases, parallel operations for multiple client
processes becomes ever more important for maintaining good aggregate
throughputs, be it reads, writes or metadata.

With 1000 client processes/threads we see the file creates per single
directory increase from 3 per second to 1200 per second with this
patch.

It solves a real world application for us (high latency NFS clients)
without having to redesign our workflows around deeper (hashed)
directory structures.

Much appreciated Neil.

Daire


On Mon, 28 Feb 2022 at 00:56, NeilBrown <neilb@suse.de> wrote:
>
> On Fri, 25 Feb 2022, Darrick J. Wong wrote:
> > On Thu, Feb 24, 2022 at 09:31:28AM -0700, Andreas Dilger wrote:
> > > On Feb 23, 2022, at 22:57, NeilBrown <neilb@suse.de> wrote:
> > > >
> > > > for i in {1..70}; do ( for j in {1000..8000}; do touch $j; rm -f $j ; done ) & done
> >
> > I think you want something faster here, like ln to hardlink an existing
> > file into the directory.
> >
>
> And probably written in C too..
>
>
> > (I am also not a fan of "PAR_UPDATE", since 'par' is already an English
> > word that doesn't mean 'parallel'.)
>
> :-)
> We already have DCACHE_PAR_LOOKUP for parallel lookups in a directory
> (though it is really a lock bit and I think should be named as soch).
> So it made sense to use DCACHE_PAR_UPDATE for parallel updates.
> And then S_PAR_UPDATE for the inode flag to enable this seemed logical.
>
> But I agree that these names are sub-par :-)
>
> NeilBrown
