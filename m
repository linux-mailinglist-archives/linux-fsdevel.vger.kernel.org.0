Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B582F77B8CD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Aug 2023 14:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbjHNMjL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Aug 2023 08:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230418AbjHNMi6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Aug 2023 08:38:58 -0400
Received: from nov-007-i659.relay.mailchannels.net (nov-007-i659.relay.mailchannels.net [46.232.183.213])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 002BDE5B;
        Mon, 14 Aug 2023 05:38:53 -0700 (PDT)
X-Sender-Id: novatrend|x-authuser|juerg@bitron.ch
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id C1B086C0082;
        Mon, 14 Aug 2023 12:38:50 +0000 (UTC)
X-Sender-Id: novatrend|x-authuser|juerg@bitron.ch
X-MC-Relay: Neutral
X-MailChannels-SenderId: novatrend|x-authuser|juerg@bitron.ch
X-MailChannels-Auth-Id: novatrend
X-Cold-Shoe: 6263835827e2b840_1692016730527_1977572546
X-MC-Loop-Signature: 1692016730527:1089382471
X-MC-Ingress-Time: 1692016730527
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bitron.ch;
        s=default; h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
        In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=UnFq8cK/dpffTOxd/mAzwBFyBjuZ38mvKS1JaKUYa+Y=; b=LqKqitPka07ght4saTNSkUYEjR
        rq04ITnySzAE1qoVlKxNWbQTSAFZsi49hUVCXX8ECbwBKXLyKj+1boiHTDcUrvcIeF0d63c/JhpC7
        xxkcOBCd5/GyCpnMjp/NNZ/Ht;
Message-ID: <e7499d0942a4489086c803dcdf1a5bb4317e973e.camel@bitron.ch>
Subject: Re: [REGRESSION] fuse: execve() fails with ETXTBSY due to async
 fuse_flush
From:   =?ISO-8859-1?Q?J=FCrg?= Billeter <j@bitron.ch>
To:     Miklos Szeredi <miklos@szeredi.hu>,
        Bernd Schubert <bernd.schubert@fastmail.fm>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        regressions@lists.linux.dev
Date:   Mon, 14 Aug 2023 14:38:44 +0200
In-Reply-To: <CAJfpegtUVUDac5_Y7BMJvCHfeicJkNxca2hO1crQjCNFoM54Lg@mail.gmail.com>
References: <4f66cded234462964899f2a661750d6798a57ec0.camel@bitron.ch>
         <CAJfpeguG4f4S-pq+_EXHxfB63mbof-VnaOy-7a-7seWLMj_xyQ@mail.gmail.com>
         <da17987a-b096-9ebb-f058-8eb91f15b560@fastmail.fm>
         <CAJfpegtUVUDac5_Y7BMJvCHfeicJkNxca2hO1crQjCNFoM54Lg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1 
MIME-Version: 1.0
X-AuthUser: juerg@bitron.ch
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2023-08-14 at 14:28 +0200, Miklos Szeredi wrote:
> On Mon, 14 Aug 2023 at 14:07, Bernd Schubert=20
> > fuse: Avoid flush for O_RDONLY
> >=20
> > From: Bernd Schubert <bschubert@ddn.com>
> >=20
> > A file opened in read-only moded does not have data to be
> > flushed, so no need to send flush at all.
> >=20
> > This also mitigates -EBUSY for executables, which is due to
> > async flush with commit 5a8bee63b1.
>=20
> Does it?=C2=A0 If I read the bug report correctly, it's the write case th=
at
> causes EBUSY.

Indeed, I see this when trying to execute a file after a process wrote
to (created) that file. As far as I can tell, `ETXTBSY` can't happen on
exec without the file being opened for writing and thus, I don't see
this patch mitigating this bug.

J=C3=BCrg
