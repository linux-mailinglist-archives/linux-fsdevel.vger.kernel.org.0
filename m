Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4D56704306
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 May 2023 03:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbjEPBnI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 May 2023 21:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjEPBnI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 May 2023 21:43:08 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C26346B4;
        Mon, 15 May 2023 18:43:07 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id af79cd13be357-7590aa05af6so577289985a.0;
        Mon, 15 May 2023 18:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684201386; x=1686793386;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PYuCufuUbqg1yC376K0mBdw1imA+vLUuGUVBA9oZ0d8=;
        b=W13eJeX2q/mX0gqq7Uj8HLHaeNuSjL+vzm7yEvo/zhyXdS4jXjf0sU1t4ivbvantKJ
         gZtRNn/LDwTAWBDFevVfXSdKsYyj3rvapl/oNMl/t5g9trv9gGWP8mTL69NjuuGdbJbV
         NmvhS4NcqmxTB1pWY1iEB2/67E5CqKJ2EhrChwncEoBEtVzLwrPysuGi339cHuR6y88N
         XnqvrjGAb0t7GyWID138apzDb83AYJtesPBiZpZS8PXJ+rf080hgaD5BCbbb23Q8A1DG
         /apvbO4jaPMPu9wNpVLRUwOmdQvaYHjWm2HRitIf/DLZLene/g0v1l1Of8OSPzkAB5mL
         vUUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684201386; x=1686793386;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PYuCufuUbqg1yC376K0mBdw1imA+vLUuGUVBA9oZ0d8=;
        b=giFlnRftSNsc4DjaCEfzDudD3uDgrgFGDu1Q+Ff+wkEcgQIoXS0bZzQoub9CtoAdGi
         4sxxrjrCZru2lv7J7uctAyc7OPbzYCyEA0gVqjAj577LZmbqQopYLM9L47y3UkAOR5cE
         Qqb9VEVKvTcuJ6aZBeitzORAXeYyrXhmJL4poZZGCUxl1U9Sfe+ZXTUAjd/DwJiZ2G//
         Vp80dvb4l2oSzUJZ2zgGsHnwnboW0T3c6/GkBSHmksC3L5LgKbPXLnnP4d/oF3XM3sxO
         JJZZl3i6LjkJ++Be7sP0G2FlsvGW+5GxGfMS/zPOcv2kTFulhtCDdiRYx7Ihbu/VcJ0i
         fGjg==
X-Gm-Message-State: AC+VfDxuqzAeid7WYCRP/PuKwv2ilkRXHPkr3N7X3H4e9hRPRfGSeQ2J
        s2dgaFPcL496xg1xsnCW5g==
X-Google-Smtp-Source: ACHHUZ4XOIQXyL0Nz5lOoCiEQ8/rWmcYTRiOoPCtyMBxoIMLICiVPx7Bu79c33fFVwHryoKKLIEtTA==
X-Received: by 2002:a05:622a:1495:b0:3e6:2bba:87f3 with SMTP id t21-20020a05622a149500b003e62bba87f3mr62529651qtx.47.1684201386028;
        Mon, 15 May 2023 18:43:06 -0700 (PDT)
Received: from [192.168.75.138] (c-68-32-72-208.hsd1.mi.comcast.net. [68.32.72.208])
        by smtp.gmail.com with ESMTPSA id fw6-20020a05622a4a8600b003f4e18bfa06sm4348835qtb.60.2023.05.15.18.43.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 18:43:05 -0700 (PDT)
Message-ID: <b5359d06a57541accbe09172b77b8107678769c0.camel@gmail.com>
Subject: Re: [PATCH v2 4/4] NFSD: handle GETATTR conflict with write
 delegation
From:   Trond Myklebust <trondmy@gmail.com>
To:     Jeff Layton <jlayton@kernel.org>,
        Chuck Lever III <chuck.lever@oracle.com>,
        Dai Ngo <dai.ngo@oracle.com>,
        Olga Kornievskaia <aglo@umich.edu>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Date:   Mon, 15 May 2023 21:43:04 -0400
In-Reply-To: <927e6aaab9e4c30add761ac6754ba91457c048c7.camel@kernel.org>
References: <1684110038-11266-1-git-send-email-dai.ngo@oracle.com>
         <1684110038-11266-5-git-send-email-dai.ngo@oracle.com>
         <CAN-5tyH0GM8xOnLVDMQMn-tmoE-w_7N9ARmcwHq6ocySeoA1MQ@mail.gmail.com>
         <392379f7-4e28-fae5-a799-00b4e35fe6fd@oracle.com>
         <5318a050cbe6e89ae0949c654545ae8998ff7795.camel@kernel.org>
         <CAN-5tyFE3=DF+48SBGrC2u3y-MNr+1nM+xFM4CXaYv23AMZvew@mail.gmail.com>
         <30df13a02cbe9d7c72d0518c011e066e563bcbc8.camel@kernel.org>
         <17E187C9-60D6-4882-B928-E7826AA68F45@oracle.com>
         <927e6aaab9e4c30add761ac6754ba91457c048c7.camel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1 (3.48.1-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2023-05-15 at 18:53 -0400, Jeff Layton wrote:
>=20
> Isn't CB_GETATTR the main benefit of a write delegation in the first
> place? A write deleg doesn't really give any benefit otherwise, as
> you
> can buffer writes anyway without one.
>=20
> AIUI, the point of a write delegation is to allow other clients (and
> potentially the server) to get up to date information on file sizes
> and
> change attr when there is a single, active writer.
>=20
> Without CB_GETATTR, your first stat() against the file will give you
> fairly up to date info (since you'll have to recall the delegation),
> but
> then you'll be back to the server just reporting the size and change
> attr that it has at the time.
>=20

The only advantage of CB_GETATTR is that it allows you to determine
whether or not the client holding the delegation is also holding cached
writes. Since we pretty much always rely on close-to-open semantics
anyway, the benefit of implementing it is pretty marginal.

Personally, I see CB_GETATTR as being more useful once servers start
implementing the timestamp/attribute delegations as per
https://datatracker.ietf.org/doc/draft-ietf-nfsv4-delstid/=C2=A0
Since those delegations allow the client to be authoritative for the
atime and mtime timestamps, and to also cache those, then CB_GETATTR
becomes a necessity in order to correctly timestamp writes that have
already been committed to the file.

--=20
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trond.myklebust@hammerspace.com


