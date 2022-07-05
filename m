Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6741D56701A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Jul 2022 15:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231816AbiGEN6Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Jul 2022 09:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233383AbiGEN5l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Jul 2022 09:57:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66E7A1CFEF;
        Tue,  5 Jul 2022 06:41:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0CC0B61722;
        Tue,  5 Jul 2022 13:41:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ACE6C341C7;
        Tue,  5 Jul 2022 13:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657028489;
        bh=aHlxnEAEQM5r6al9d8XqU+n34AltTALTHE2pF/9B8lI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=J7JvST/3EoYyCBzmIrNNK8lBxeod3pxrE04YCmrnKfGau5/Ywkzei/+R8GHabJptP
         NqUvnOpPczK7lwWhu7xAw7H9azruDWObVf6DifUGWpHhDv/kKhHe449hzAZWXK/ZSn
         tbBh6hruWOVPYmS2Z/VB5M1iUmhevDHzxPQyeJNGvmigszYPlx3S/M1UvaImncqlN8
         WBtcYQxBQSmwTUEXT7JE/fLUKjTlQoLjREBMZcUiTU4dF/0xul8NJjMB4WbCdDfg4w
         dUzdKzGNWn4S4KghttEf267tG2MoiTBMaTIWCRuEY+CvlZ4utP1Z7itlE2WVkIF0Uk
         ks2SsSTBr7+ZQ==
Message-ID: <459eec8a5cd41316aedbff6287900cd92ff92b52.camel@kernel.org>
Subject: Re: [PATCH 1/2] netfs: release the folio lock and put the folio
 before retrying
From:   Jeff Layton <jlayton@kernel.org>
To:     David Howells <dhowells@redhat.com>
Cc:     xiubli@redhat.com, idryomov@gmail.com, vshankar@redhat.com,
        linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org,
        willy@infradead.org, keescook@chromium.org,
        linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com
Date:   Tue, 05 Jul 2022 09:41:25 -0400
In-Reply-To: <2187946.1657027284@warthog.procyon.org.uk>
References: <30a4bd0e19626f5fb30f19f0ae70fba2debb361a.camel@kernel.org>
         <20220701022947.10716-1-xiubli@redhat.com>
         <20220701022947.10716-2-xiubli@redhat.com>
         <2187946.1657027284@warthog.procyon.org.uk>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.2 (3.44.2-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2022-07-05 at 14:21 +0100, David Howells wrote:
> Jeff Layton <jlayton@kernel.org> wrote:
>=20
> > I don't know here... I think it might be better to just expect that whe=
n
> > this function returns an error that the folio has already been unlocked=
.
> > Doing it this way will mean that you will lock and unlock the folio a
> > second time for no reason.
>=20
> I seem to remember there was some reason you wanted the folio unlocking a=
nd
> putting.  I guess you need to drop the ref to flush it.
>=20
> Would it make sense for ->check_write_begin() to be passed a "struct foli=
o
> **folio" rather than "struct folio *folio" and then the filesystem can cl=
ear
> *folio if it disposes of the page?
>=20

I'd be OK with that too.
--=20
Jeff Layton <jlayton@kernel.org>
