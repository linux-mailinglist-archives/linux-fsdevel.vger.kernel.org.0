Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B11A9751048
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jul 2023 20:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233002AbjGLSKI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jul 2023 14:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjGLSKD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jul 2023 14:10:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E897A11B;
        Wed, 12 Jul 2023 11:10:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7F181618BB;
        Wed, 12 Jul 2023 18:10:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BDC7C433CA;
        Wed, 12 Jul 2023 18:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689185401;
        bh=sdyW3dQUYfcOOwn72IgmGceZwhcx/rq4v6X3m3VdThY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=pC+UrgNB7r/lke03yqUS07ZCD8LKdbBW/h0Yx1Buoy5DFdxRBYrrNfwdz6qHNEVXL
         8eyYrFO1CBbwTnjp88hFM1hgOYUyCgEcCXnP4Fln9MMmBTck+cLZ/Gfd6EQZpvx+sP
         iyy49W9HjyfeLFR8/Sk9f2gQ8j5bkXBK7VT2GaOWZaLKMHdhf11crnOT08UCWbREtW
         dVBoBEJDIlG/CRDvYQ13jAYxVUroyrIj3yCo0eZcJSZRTHZ3ifHdNvTjBV9l/iJjY9
         hkbXTDImfYrb95rq3nw7PcOWGMu9NDYwS/6kyLaFD9CilXA6TWPqTX/qg3ltau6EFS
         q2uiER4XFftfw==
Message-ID: <4c29c4e8f88509b2f8e8c08197dba8cfeb07c045.camel@kernel.org>
Subject: Re: [PATCH] ext4: fix decoding of raw_inode timestamps
From:   Jeff Layton <jlayton@kernel.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     brauner@kernel.org, Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 12 Jul 2023 14:09:59 -0400
In-Reply-To: <20230712175258.GB3677745@mit.edu>
References: <20230712150251.163790-1-jlayton@kernel.org>
         <20230712175258.GB3677745@mit.edu>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2023-07-12 at 13:52 -0400, Theodore Ts'o wrote:
> On Wed, Jul 12, 2023 at 11:02:49AM -0400, Jeff Layton wrote:
> > When we covert a timestamp from raw disk format, we need to consider it
> > to be signed, as the value may represent a date earlier than 1970. This
> > fixes generic/258 on ext4.
> >=20
> > Cc: Jan Kara <jack@suse.cz>
> > Fixes: f2ddb05870fb ("ext4: convert to ctime accessor functions")
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
>=20
> Acked-by: Theodore Ts'o <tytso@mit.edu>
>=20
> Thanks for the fix!
>=20
> It had been on my list to checking to see if the ext4 kunit tests
> would pass, since Jan had mentioned that he had done the work to make
> sure the ext4 kunit test would compile, but he hadn't gotten around to
> try run the kunit test.  Unfortunately, I hadn't gotten to it.
>=20
> I *think* the ext4 kunit tests should have caught this as well; out of
> curiosity, have you tried running the ext4 kunit tests either before
> or after this patch?  If so, what were your findings?
>=20
> Cheers,
>=20
> 					- Ted

No, I haven't. I'm running fstests on it now. Is there a quickstart for
running those tests?
--=20
Jeff Layton <jlayton@kernel.org>
