Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39B086A8A7C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Mar 2023 21:35:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbjCBUfS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Mar 2023 15:35:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbjCBUfS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Mar 2023 15:35:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C95C35251;
        Thu,  2 Mar 2023 12:35:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E287061648;
        Thu,  2 Mar 2023 20:35:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82927C433EF;
        Thu,  2 Mar 2023 20:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677789316;
        bh=fTZvuiW0Rd6sMCWDRcX+StRjMlaH7z4JH4w6v5EGfc4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=jNAELZ/uD7JUizVNoTcWeV7dn6UT+YYfGaLCfUs8w/1S3HuY6995/RhVKyyd4nxqK
         HyZBsZOxwvfq1E4ftb0mUB71LSj+IBe6Yi/fgaZlmV4GpzvTrdO2geTZ7v+qx7P4lt
         opw64htvB+MvSGGaQafv/natnJ3Nd7RSTcFvsGyN/YD8OsAt9XZqyN93cirMvsx768
         ihtzNZK8ZhIC+Vrm99dq6aLYgzGxiA/ifP3wYLb8ooJ9V+xMYuliGtEiVB0rc9bu3c
         /EkoIvt9fT/n2MSfm+veHFIqciFGKjhi+x1a2tuvYoscrB4jRrrN1uEDlAyx1E/ktC
         hUSrHhNd+uHmg==
Message-ID: <900d20230c8a1ad006a24248d973e260f3e7d6f4.camel@kernel.org>
Subject: Re: [PATCH] locks: avoid usage of list iterator after loop in
 generic_delete_lease()
From:   Jeff Layton <jlayton@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Jakob Koschel <jkl820.git@gmail.com>
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pietro Borrello <borrello@diag.uniroma1.it>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>
Date:   Thu, 02 Mar 2023 15:35:14 -0500
In-Reply-To: <ZADno9G+y32cCl73@ZenIV>
References: <20230301-locks-avoid-iter-after-loop-v1-1-4d0529b03dc7@gmail.com>
         <ZADno9G+y32cCl73@ZenIV>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2023-03-02 at 18:14 +0000, Al Viro wrote:
> On Wed, Mar 01, 2023 at 06:20:18PM +0100, Jakob Koschel wrote:
> > 'victim' and 'fl' are ensured to be equal at this point. For consistenc=
y
> > both should use the same variable.
> >=20
> > Additionally, Linus proposed to avoid any use of the list iterator
> > variable after the loop, in the attempt to move the list iterator
> > variable declaration into the marcro to avoid any potential misuse afte=
r
> > the loop [1].
> >=20
> > Link: https://lore.kernel.org/all/CAHk-=3DwgRr_D8CB-D9Kg-c=3DEHreAsk5Sq=
XPwr9Y7k9sA6cWXJ6w@mail.gmail.com/ [1]
> > Signed-off-by: Jakob Koschel <jkl820.git@gmail.com>
>=20
> Looks sane.  Jeff, which tree do you want that to go through?

Looks good to me too. I'm fine if you want to pick up that one, but
otherwise I can take it. You can also add:

Reviewed-by: Jeff Layton <jlayton@kernel.org>

Thanks!
