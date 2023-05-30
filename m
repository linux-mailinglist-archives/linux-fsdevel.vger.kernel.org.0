Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEAD8715A88
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 May 2023 11:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbjE3Jp3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 May 2023 05:45:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbjE3JpI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 May 2023 05:45:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D479C7;
        Tue, 30 May 2023 02:45:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ED837625E7;
        Tue, 30 May 2023 09:45:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB5E4C433EF;
        Tue, 30 May 2023 09:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685439905;
        bh=ugspOrChK8NXygGAKcQBF1VB7q0atxugNPeJOSVS+Yw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SaEgYuIqkCM+uVTFRtng4syEx2MFC9Hcu7CCYyoFQJdK3TcQ4VfZqbZDkjgluc5ue
         1vrPIANLTFt3dBfBqzHiwcJkKXUh9nosD4gD0CZ+FsQ+bwwuA3OcuX8qD3ohayxW2q
         p2p1npBxgICBJEYN3MdHN1DZjIrf3r5Ke5cTebMBGiSeuBWxgcoXp+NoKk6CN2w6nU
         G9hxC/wMaeRWfOF07zGWiqPrLwpDmuZciaVbzD6P1B31B4B2bWnmXAdtBRP7EmZes/
         pYHSdMEhGVFCj9Zyj/rgYJyJ4Gyf1ABmpNUksP5a+nXfYnhFqVY9wizmr/FNCHskFe
         +bGeHk8Sph/sA==
Date:   Tue, 30 May 2023 11:45:00 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Loic Poulain <loic.poulain@linaro.org>
Cc:     corbet@lwn.net, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] init: Add support for rootwait timeout parameter
Message-ID: <20230530-polytechnisch-besten-258f74577eff@brauner>
References: <20230526130716.2932507-1-loic.poulain@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230526130716.2932507-1-loic.poulain@linaro.org>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 26, 2023 at 03:07:16PM +0200, Loic Poulain wrote:
> Add an optional timeout arg to 'rootwait' as the maximum time in
> seconds to wait for the root device to show up before attempting
> forced mount of the root filesystem.
> 
> This can be helpful to force boot failure and restart in case the
> root device does not show up in time, allowing the bootloader to
> take any appropriate measures (e.g. recovery, A/B switch, retry...).
> 
> In success case, mounting happens as soon as the root device is ready,
> contrary to the existing 'rootdelay' parameter (unconditional delay).
> 
> Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
> ---

Not terribly opposed and not terribly convinced yet.
So, we have rootdelay= with a timeout parameter that allows to specify a
delay before attempting to mount the root device. And we have rootwait
currently as an indefinite wait. Adding a timeout for rootwait doesn't
seem crazy and is backwards compatible. But there's no mention of any
concrete users or use-case for this which is usually preferable. If this
is just "could be useful for someone eventually" it's way less desirable
to merge this than when it's "here's a/multiple user/users"... So I
would love to see a use-case described here.

And this is only useful if there isn't an early userspace init that
parses and manages root=. So we need to hit prepare_namespaces() as a
rootwait timeout isn't meaningful if this is done by and early init in
the initramfs for example.
