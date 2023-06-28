Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8FDC741437
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jun 2023 16:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231594AbjF1OuM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 10:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231768AbjF1Otq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 10:49:46 -0400
Received: from todd.t-8ch.de (unknown [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F01842127;
        Wed, 28 Jun 2023 07:49:04 -0700 (PDT)
Date:   Wed, 28 Jun 2023 16:48:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1687963729; bh=HoX5J3D8ZBsoaEAB7nN7zJQyhlvUjkMd15UQgpJAqwI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qUwMbCn0SNFMLKV9yL0N6+FLoeKeNO+SHyL1BO/SbQbDfvzNZhJcSE1B0seWepqmn
         9YWfAilBj/KAyz1zsJM67oIUIISvFIo92z3DlytDZwqlTXO0evUXXjkYx6wuHhsEB9
         B0ShqYbUUkjoXklrcuDIMPdIdSUOc+O2nGs1Hu2U=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Dave Chinner <david@fromorbit.com>,
        Kent Overstreet <kent.overstreet@linux.dev>,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-bcachefs@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [GIT PULL] bcachefs
Message-ID: <e5df59c7-eadd-4c1a-9499-5a98ef719216@t-8ch.de>
References: <20230626214656.hcp4puionmtoloat@moria.home.lan>
 <aeb2690c-4f0a-003d-ba8b-fe06cd4142d1@kernel.dk>
 <20230627000635.43azxbkd2uf3tu6b@moria.home.lan>
 <91e9064b-84e3-1712-0395-b017c7c4a964@kernel.dk>
 <20230627020525.2vqnt2pxhtgiddyv@moria.home.lan>
 <b92ea170-d531-00f3-ca7a-613c05dcbf5f@kernel.dk>
 <23922545-917a-06bd-ec92-ff6aa66118e2@kernel.dk>
 <20230627201524.ool73bps2lre2tsz@moria.home.lan>
 <ZJtdEgbt+Wa8UHij@dread.disaster.area>
 <3337524d-347c-900a-a1c7-5774cd731af0@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3337524d-347c-900a-a1c7-5774cd731af0@kernel.dk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2023-06-28 08:40:27-0600, Jens Axboe wrote:
> On 6/27/23 4:05?PM, Dave Chinner wrote:
> [..]

> > There should be no reason to need to specify the filesystem type for
> > filesystems that blkid recognises. from common/config:
> > 
> >         # Autodetect fs type based on what's on $TEST_DEV unless it's been set
> >         # externally
> >         if [ -z "$FSTYP" ] && [ ! -z "$TEST_DEV" ]; then
> >                 FSTYP=`blkid -c /dev/null -s TYPE -o value $TEST_DEV`
> >         fi
> >         FSTYP=${FSTYP:=xfs}
> >         export FSTYP
> 
> Gotcha, yep it's because blkid fails to figure it out.

This needs blkid/util-linux version 2.39 which is fairly new.
If it doesn't work with that, it's a bug.

Thomas
