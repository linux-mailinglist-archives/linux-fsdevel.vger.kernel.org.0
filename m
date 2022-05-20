Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE49752EB12
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 May 2022 13:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348644AbiETLnl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 May 2022 07:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348659AbiETLnk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 May 2022 07:43:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D647315A75F
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 May 2022 04:43:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 872FDB82AC2
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 May 2022 11:43:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 792FBC34113;
        Fri, 20 May 2022 11:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653047016;
        bh=kB+j93edEqZtaYBlYctAjzs6Gu2CXGzK5btziFxt3wY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F7iNR/t3ZaokeJPGA5EdL8cShPAP9DQceUETzac6MjxHDkqMpE2VsT0iUM52PSukq
         B6K1opObpYXgk87Rz4HZyjZyUXw4LNUEkxywF9idC9Y+7nmzvfQsWt+BY238nF4u39
         aExi24mJCRKkxZheHdfVhbaa9N50iP26JPC8DbsPb5c6Q4jAHciKs5Es1oj7hm4yNC
         KRhnwz/TgOj9xTMzN6bHKxBEnON44dxxvi76vfjgGnTicli3v0m1FksWGwo4EDN8X+
         QfRpa/sOuGVWRZxU0FhR1PkVIEnmGcx/Xhv/SB8Ao6dYH/ORUdYSHUSH6fHEsWyEiR
         BoGW9k57yCKGQ==
Date:   Fri, 20 May 2022 13:43:32 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] get rid of dead code in legitimize_root()
Message-ID: <20220520114332.ukmg6xefpamq75e3@wittgenstein>
References: <YocIMkS1qcPGrik0@zeniv-ca.linux.org.uk>
 <YocIiPQjR7tuYdkP@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YocIiPQjR7tuYdkP@zeniv-ca.linux.org.uk>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 20, 2022 at 03:18:32AM +0000, Al Viro wrote:
> Combination of LOOKUP_IS_SCOPED and NULL nd->root.mnt is impossible
> after successful path_init().  All places where ->root.mnt might
> become NULL do that only if LOOKUP_IS_SCOPED is not there and
> path_init() itself can return success without setting nd->root
> only if ND_ROOT_PRESET had been set (in which case nd->root
> had been set by caller and never changed) or if the name had
> been a relative one *and* none of the bits in LOOKUP_IS_SCOPED
> had been present.
> 
> Since all calls of legitimize_root() must be downstream of successful
> path_init(), the check for !nd->root.mnt && (nd->flags & LOOKUP_IS_SCOPED)
> is pure paranoia.
> 
> FWIW, it had been discussed (and agreed upon) with Aleksa back when
> scoped lookups had been merged; looks like that had fallen through the
> cracks back then.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Looks good to me,
Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>
