Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B497D59E434
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Aug 2022 15:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234222AbiHWNSU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Aug 2022 09:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232558AbiHWNSC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Aug 2022 09:18:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E8113D8CD;
        Tue, 23 Aug 2022 03:17:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7E854B81C95;
        Tue, 23 Aug 2022 10:16:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A2DBC433D6;
        Tue, 23 Aug 2022 10:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661249797;
        bh=G7sByELU5UHY6YZV5lNrSDGBRnM/7iWz91ExRGn4zQE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=G+KYOYG5A0GeVsEoatnBZapQOTFJUL/LFIOTL5tD5Vcfhwl4KroBchzQ0AHeOqXdR
         cEvwIIPq4AUr/zaNze2UjJp39ta8U0XQWUibuQKS80eSO9569M6+8mNSdn15oRWhqv
         NCpmdtgufBIEUx/V2iitKaI2xlB0VNo5s/fwtTmR8dEi+yo1EOCs+s9oBKlrh5PiP7
         G8lgtrwyKcsCeQuDyl5LUlOpK2JW5lxfKbS7TT722UtNx64QTeoFBQ+8usEWy3f5Fi
         ZVNzY7elDIWCYddt4au608EI66lRl2RxwD7oV5zJfmvvlXMUulM4KqdgN3Ugb6aCre
         wc14RkmqM0OwA==
Message-ID: <857b150cbd9c99134141475eafdc1e2b4e0ebe91.camel@kernel.org>
Subject: Re: [PATCH] vfs: report an inode version in statx for IS_I_VERSION
 inodes
From:   Jeff Layton <jlayton@kernel.org>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     viro@zeniv.linux.org.uk, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Frank Filz <ffilzlnx@mindspring.com>
Date:   Tue, 23 Aug 2022 06:16:35 -0400
In-Reply-To: <87o7wb2s9d.fsf@oldenburg.str.redhat.com>
References: <20220819115641.14744-1-jlayton@kernel.org>
         <87o7wb2s9d.fsf@oldenburg.str.redhat.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2022-08-23 at 12:01 +0200, Florian Weimer wrote:
> * Jeff Layton:
>=20
> > From: Jeff Layton <jlayton@redhat.com>
> >=20
> > The NFS server and IMA both rely heavily on the i_version counter, but
> > it's largely invisible to userland, which makes it difficult to test it=
s
> > behavior. This value would also be of use to userland NFS servers, and
> > other applications that want a reliable way to know if there was an
> > explicit change to an inode since they last checked.
> >=20
> > Claim one of the spare fields in struct statx to hold a 64-bit inode
> > version attribute. This value must change with any explicit, observeabl=
e
> > metadata or data change. Note that atime updates are excluded from this=
,
> > unless it is due to an explicit change via utimes or similar mechanism.
> >=20
> > When statx requests this attribute on an IS_I_VERSION inode, do an
> > inode_query_iversion and fill the result in the field. Also, update the
> > test-statx.c program to display the inode version and the mountid.
>=20
> Will the version survive reboots?  Is it stored on disks?  Can backup
> tools (and others) use this to check if the file has changed since the
> last time the version has been observed?
>=20


The answer to all of those question is "yes".
--=20
Jeff Layton <jlayton@kernel.org>
