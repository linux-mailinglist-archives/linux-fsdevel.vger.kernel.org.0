Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A72A970DD18
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 May 2023 14:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236977AbjEWM5d (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 May 2023 08:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236962AbjEWM5d (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 May 2023 08:57:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22384DD;
        Tue, 23 May 2023 05:57:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6D14F63219;
        Tue, 23 May 2023 12:57:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF164C433EF;
        Tue, 23 May 2023 12:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684846650;
        bh=n411DVHyioIkCVft5gGG/OIDKoHJt9AXVUgNraiDZ88=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nla2SeLqG5sGFZSdEg1ZsqLwzJ3kL5dDAhmeCm0N4oy2qt/uxWBf/UdCiEvOTbjeY
         bJwCoQhl+h/fGorVrpjwVJGY7uRf5DOGgGa2uJZuOmKwtKOW5RuZCvmawcB247EHQF
         X16za2tfjNKOLOXEMYv9kf2vnfO4hVJQQdv1UO/EN1ZHuXrR6zkmQJw9szlOdDLS+H
         aWwLh9U6wA+Up6uNelbIp2d6TpQOZIzoMnTBzewrd345nEDAtRgZfSok2wdO8VC0CT
         oCtQ5EbZdD9O8zI44sPBs7V6HLMKrmqlKZkrw+Wn25/H+avfKYbzN0jXWNn3uYT5gu
         koJ9NrMmj8xxQ==
Date:   Tue, 23 May 2023 14:57:25 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Joel Granados <j.granados@samsung.com>
Cc:     mcgrof@kernel.org, Kees Cook <keescook@chromium.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Iurii Zaikin <yzaikin@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: Re: [PATCH v4 8/8] sysctl: Remove register_sysctl_table
Message-ID: <20230523-bieten-beisammen-719746923703@brauner>
References: <20230523122220.1610825-1-j.granados@samsung.com>
 <CGME20230523122239eucas1p19c23501df7732d16422ab0489503c764@eucas1p1.samsung.com>
 <20230523122220.1610825-9-j.granados@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230523122220.1610825-9-j.granados@samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 23, 2023 at 02:22:20PM +0200, Joel Granados wrote:
> This is part of the general push to deprecate register_sysctl_paths and
> register_sysctl_table. After removing all the calling functions, we
> remove both the register_sysctl_table function and the documentation
> check that appeared in check-sysctl-docs awk script.
> 
> We save 595 bytes with this change:
> 
> ./scripts/bloat-o-meter vmlinux.1.refactor-base-paths vmlinux.2.remove-sysctl-table
> add/remove: 2/8 grow/shrink: 1/0 up/down: 1154/-1749 (-595)
> Function                                     old     new   delta
> count_subheaders                               -     983    +983
> unregister_sysctl_table                       29     184    +155
> __pfx_count_subheaders                         -      16     +16
> __pfx_unregister_sysctl_table.part            16       -     -16
> __pfx_register_leaf_sysctl_tables.constprop   16       -     -16
> __pfx_count_subheaders.part                   16       -     -16
> __pfx___register_sysctl_base                  16       -     -16
> unregister_sysctl_table.part                 136       -    -136
> __register_sysctl_base                       478       -    -478
> register_leaf_sysctl_tables.constprop        524       -    -524
> count_subheaders.part                        547       -    -547
> Total: Before=21257652, After=21257057, chg -0.00%
> 
> Signed-off-by: Joel Granados <j.granados@samsung.com>
> [mcgrof: remove register_leaf_sysctl_tables and append_path too and
>  add bloat-o-meter stats]
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---

Acked-by: Christian Brauner <brauner@kernel.org>
