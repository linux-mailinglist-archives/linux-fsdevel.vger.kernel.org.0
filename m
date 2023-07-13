Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A26DD752352
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jul 2023 15:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234736AbjGMNUL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jul 2023 09:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234147AbjGMNT5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jul 2023 09:19:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D06943A92;
        Thu, 13 Jul 2023 06:19:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 75B12612FC;
        Thu, 13 Jul 2023 13:19:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30BDBC433C9;
        Thu, 13 Jul 2023 13:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689254345;
        bh=u+5xkBeFRP9d+V4EON2W5LWepmKPQK26vIycq1UicY8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=SSucd0pvRsFGNDCth1I7okGhuxvslol13Ph+SYHwpCQPigK2ghsxDQZKN9exJOkCA
         ZHunCUppQcELNUs7VCTOJXtSBUvDYB6SzSZDlT1ab1gsvTHCfizcYr9kYIJ7z79pIw
         F+De+4y/7GmH4N9egMGBM98x4ndWJ+rWbLbHTCeHgnI3B/vQmlyaKu5a9JSXfh37z+
         LStZelGsKSLvDgjiTpxwbUkgc+bJNsF4LNkcJr7r/K/56wgFuG55mt/sDiaDnlKLmv
         0EmBFVBXZiEIQ1YMFE1NWEq7vlowL8BVdvA2azLbxtbqf5MfaKj9ZouX9tP2UVSZSi
         JLITbtARJV1Hg==
Message-ID: <6097b2118e820af8d9ffee6b663c4e260158d62a.camel@kernel.org>
Subject: Re: [PATCH] ext4: fix decoding of raw_inode timestamps
From:   Jeff Layton <jlayton@kernel.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     brauner@kernel.org, Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 13 Jul 2023 09:19:03 -0400
In-Reply-To: <20230713130434.GA3724752@mit.edu>
References: <20230712150251.163790-1-jlayton@kernel.org>
         <20230712175258.GB3677745@mit.edu>
         <4c29c4e8f88509b2f8e8c08197dba8cfeb07c045.camel@kernel.org>
         <20230712212557.GE3432379@mit.edu>
         <11bef51bf7fed6082f41a9ecde341b46c0c3e0ec.camel@kernel.org>
         <20230713130434.GA3724752@mit.edu>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
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

On Thu, 2023-07-13 at 09:04 -0400, Theodore Ts'o wrote:
> On Thu, Jul 13, 2023 at 06:48:04AM -0400, Jeff Layton wrote:
> >=20
> > The above output is what I get with the fix in place. Without this
> > patch, I get: ...
>=20
> Thanks!!  It's good to know the _one_ kunit test we have is capable of
> detecting this.  We have a patch series lined up to add our *second*
> unit test (for the block allocator) for the next merge window, and
> while our unit test coverage is still quite small, it's nice to know
> that it can detect problems --- and much faster than running xfstests.  :=
-}
>=20

Yeah, it's pretty quick! I need to consider adding some tests for some
other areas that are difficult to view outside the kernel (the errseq_t
infrastructure comes to mind).
--=20
Jeff Layton <jlayton@kernel.org>
