Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A89B46182EC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Nov 2022 16:31:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231382AbiKCPbb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Nov 2022 11:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232254AbiKCPav (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Nov 2022 11:30:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26DB21C12F;
        Thu,  3 Nov 2022 08:30:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8A885B828EB;
        Thu,  3 Nov 2022 15:30:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BD4EC433D6;
        Thu,  3 Nov 2022 15:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667489435;
        bh=mgyY0R29mGntIOfFVnfmgFP7RctremcB5vzLO4Yx5X0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Uz4RgduU8VABIxZ+tLEpWtmE5xF7WA468KZf1RKzsHa7bo44FeXFGClazxNq/6pba
         IzEhb2TeVZQ9V5PCjLCl0sVdx7WzYoyzbBIz1kn8lAgPvh3tEiSNpgqfY7hoBR5BsS
         rSDxUVVWkXxhz4uDaZSfepO3Wt2IiOajTB87+35VPCHEBe7SB0vuWPDlJH46d+B6LW
         ZDc8duntrmAalwuRUBVfEYl54d+qWrk/FxAid3QI8UFJf3Zo2f/uirz07t25ZIn/U3
         UibZs7ViYNB5vkFS7ejmRRjaVEZW3H+q6PDrKzbudrMYx+QYWQDja+e1Sj0ZgkxDDb
         om9VcqDqdDqFA==
Date:   Thu, 3 Nov 2022 16:30:30 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, Martin Pitt <mpitt@redhat.com>
Subject: Re: [PATCH v2] fs: don't audit the capability check in
 simple_xattr_list()
Message-ID: <20221103153030.ep5rqq2uetpclm3z@wittgenstein>
References: <20221103151205.702826-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221103151205.702826-1-omosnace@redhat.com>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 03, 2022 at 04:12:05PM +0100, Ondrej Mosnacek wrote:
> The check being unconditional may lead to unwanted denials reported by
> LSMs when a process has the capability granted by DAC, but denied by an
> LSM. In the case of SELinux such denials are a problem, since they can't
> be effectively filtered out via the policy and when not silenced, they
> produce noise that may hide a true problem or an attack.
> 
> Checking for the capability only if any trusted xattr is actually
> present wouldn't really address the issue, since calling listxattr(2) on
> such node on its own doesn't indicate an explicit attempt to see the
> trusted xattrs. Additionally, it could potentially leak the presence of
> trusted xattrs to an unprivileged user if they can check for the denials
> (e.g. through dmesg).
> 
> Therefore, it's best (and simplest) to keep the check unconditional and
> instead use ns_capable_noaudit() that will silence any associated LSM
> denials.
> 
> Fixes: 38f38657444d ("xattr: extract simple_xattr code from tmpfs")
> Reported-by: Martin Pitt <mpitt@redhat.com>
> Suggested-by: Christian Brauner (Microsoft) <brauner@kernel.org>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---

Looks good,
Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>
