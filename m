Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B18D5960D1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Aug 2022 19:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235380AbiHPRIA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Aug 2022 13:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231587AbiHPRH7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Aug 2022 13:07:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F87679A7C
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Aug 2022 10:07:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2E565B8164B
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Aug 2022 17:07:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B793C433C1;
        Tue, 16 Aug 2022 17:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660669674;
        bh=1hxk9E+q3BEDepcIieCIk+2tlsBOGgDUO4curw8B7W4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qj9IaEfeL88Zo4nIX+N3f5FGIIxN1ls87LVnvI5G/9MXOYPxZIfAQXPZDp4GTqdIl
         BksxUZ+xyO92oipbn2rxJBpScKFQK4Uu8fEOFX1ZdNFcPZXDt9CtzrOQQWdT3WUC+i
         hRoNty6kNwG8DwVlopOnR0YK3cH2E32QmfU2dO4SBICZmcdHERme39lvh8f5JJhpJm
         XPircrwUH/CmgtWm7ZlCDzzC66eA/WjejAUxViZGaf86trDk7Hr+bczDI/9fSB0r3v
         bqQzWgXqcW0vZkzFH9nnU2lCZAcasppkNlwZTl+B1Z64WXLRQqjDTWOUEZTcxIeN5R
         wuEguKM3+96dw==
Date:   Tue, 16 Aug 2022 19:07:51 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Seth Forshee <sforshee@digitalocean.com>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: require CAP_SYS_ADMIN in target namespace for
 idmapped mounts
Message-ID: <20220816170751.wdpzqff345voonyq@wittgenstein>
References: <20220816164752.2595240-1-sforshee@digitalocean.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220816164752.2595240-1-sforshee@digitalocean.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 16, 2022 at 11:47:52AM -0500, Seth Forshee wrote:
> Idmapped mounts should not allow a user to map file ownsership into a
> range of ids which is not under the control of that user. However, we
> currently don't check whether the mounter is privileged wrt to the
> target user namespace.
> 
> Currently no FS_USERNS_MOUNT filesystems support idmapped mounts, thus
> this is not a problem as only CAP_SYS_ADMIN in init_user_ns is allowed
> to set up idmapped mounts. But this could change in the future, so add a
> check to refuse to create idmapped mounts when the mounter does not have
> CAP_SYS_ADMIN in the target user namespace.
> 
> Fixes: bd303368b776 ("fs: support mapped mounts of mapped filesystems")
> Signed-off-by: Seth Forshee <sforshee@digitalocean.com>
> ---

Fwiw, I think we can probably move the check into build_mount_idmapped()
right before we setup kattr->mnt_userns so we don't end up calling this
multiple times for each mount. But no need to resend for this. I can
move this. In general that seems like a good idea and good future
proofing,
Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>
