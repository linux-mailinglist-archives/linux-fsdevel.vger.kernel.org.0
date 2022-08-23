Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB06859E52B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Aug 2022 16:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240573AbiHWOfy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Aug 2022 10:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243058AbiHWOfi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Aug 2022 10:35:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B8451571C;
        Tue, 23 Aug 2022 04:52:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 76DE6B81CD9;
        Tue, 23 Aug 2022 11:51:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29384C433D6;
        Tue, 23 Aug 2022 11:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661255479;
        bh=CvA/C1GOxg3OMPQs+x/12zSbfpSbGgDdGEtoLNQ/5Ho=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=jK/VbkuSLJLv4yFEfP5UCoSf8zhBypyjLt8Y4KKwQTwZKSayR/ygClZaMxdViPrt2
         9KhW+a0CGkPpFPj3omjieYzoObypsE3leGzE/ONP96z5qohhm7xfUsc9PmZOw2Yvwm
         Ehum7+Et2qT5nkirirVTysyJBuJKjbt35gmrApeuwEKHd/bEze6b/NF3opd5r0emSL
         ICqvcGosOH4E6Gc6i0B4UT8NmsqHg96IX2ea82l8SLzh8bi1uq6UHVPQqjA2Vjlrx3
         DEajdTzsK299sXiHudI0SqtTUFy0t+TduWRWXPftCJFRK0M8u8qUtgzsAUDIgpV0yc
         wmrkzKmAshQCQ==
Message-ID: <df469d936b2e1c1a8c9c947896fa8a160f33b0e8.camel@kernel.org>
Subject: Re: [PATCH] iversion: update comments with info about atime updates
From:   Jeff Layton <jlayton@kernel.org>
To:     NeilBrown <neilb@suse.de>
Cc:     Dave Chinner <david@fromorbit.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        Trond Myklebust <trondmy@hammerspace.com>
Date:   Tue, 23 Aug 2022 07:51:16 -0400
In-Reply-To: <166125468756.23264.2859374883806269821@noble.neil.brown.name>
References: <20220822133309.86005-1-jlayton@kernel.org>
        , <ceb8f09a4cb2de67f40604d03ee0c475feb3130a.camel@linux.ibm.com>
        , <f17b9d627703bee2a7b531a051461671648a9dbd.camel@kernel.org>
        , <18827b350fbf6719733fda814255ec20d6dcf00f.camel@linux.ibm.com>
        , <4cc84440d954c022d0235bf407a60da66a6ccc39.camel@kernel.org>
        , <20220822233231.GJ3600936@dread.disaster.area>
        , <6cbcb33d33613f50dd5e485ecbf6ce7e305f3d6f.camel@kernel.org>
         <166125468756.23264.2859374883806269821@noble.neil.brown.name>
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

On Tue, 2022-08-23 at 21:38 +1000, NeilBrown wrote:
> On Tue, 23 Aug 2022, Jeff Layton wrote:
> > So, we can refer to that and simply say:
> >=20
> > "If the function updates the mtime or ctime on the inode, then the
> > i_version should be incremented. If only the atime is being updated,
> > then the i_version should not be incremented. The exception to this rul=
e
> > is explicit atime updates via utimes() or similar mechanism, which
> > should result in the i_version being incremented."
>=20
> Is that exception needed?  utimes() updates ctime.
>=20
> https://man7.org/linux/man-pages/man2/utimes.2.html
>=20
> doesn't say that, but
>=20
> https://pubs.opengroup.org/onlinepubs/007904875/functions/utimes.html
>=20
> does, as does the code.
>=20

Oh, good point! I think we can leave that out. Even better!
--=20
Jeff Layton <jlayton@kernel.org>
