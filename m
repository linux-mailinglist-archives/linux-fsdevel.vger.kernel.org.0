Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E31654ED934
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Mar 2022 14:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235444AbiCaMEl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Mar 2022 08:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234319AbiCaMEl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Mar 2022 08:04:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF58F6574;
        Thu, 31 Mar 2022 05:02:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 531E3B81BE2;
        Thu, 31 Mar 2022 12:02:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77D00C340EE;
        Thu, 31 Mar 2022 12:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648728169;
        bh=FW7RWG0KIO5WoHlOSSmY54guGEp+RDwYjDBHMFA2PX4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eNVTGHsvDWmBWz9cXIvmGQ//p0hDPxpTieFNwQwN5C1jjhKJQHUd2kFzV+D9PWd3J
         +MQrsxbtFYsGDMfVdsB5rPCs/IjrFXdUbICx72rop0OgnrmW3/zc+WcQNeGpklykXt
         tK/w3p/lNswWAP+AJWJmVY5B71r0Z6rCovQp29xgau7AtzOOV3j6DD4gxIbb13sFqf
         NiYHmXdE1e3Da+DWVBjF07r3kXas18N81phllhxwuZn4eH3Ph/S4Y9amdW7xtDaHLk
         EkjrTJ8NCaQhFs8DHk8obU1zVxYBTpu39kHci38t7elUnz/CSFq+IN0eP7DGWtjNjU
         cxcmq8965fQ2A==
Date:   Thu, 31 Mar 2022 14:02:39 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Yang Xu <xuyang2018.jy@fujitsu.com>
Cc:     david@fromorbit.com, djwong@kernel.org,
        linux-fsdevel@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH v1 2/2] idmapped-mounts: Add umask before test
 setgid_create
Message-ID: <20220331120239.uzliits77lfmn5m2@wittgenstein>
References: <1648718902-2319-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1648718902-2319-2-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1648718902-2319-2-git-send-email-xuyang2018.jy@fujitsu.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 31, 2022 at 05:28:22PM +0800, Yang Xu wrote:
> Since stipping S_SIGID should check S_IXGRP, so umask it to check whether
> works well.
> 
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---

(Sidenote: I really need to rename the test binary to something other
than idmapped-mounts.c as this tests a lot of generic vfs stuff that has
nothing to do with them.)

Tested-by: Christian Brauner (Microsoft) <brauner@kernel.org>
Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>

> If we enable acl on parent directory, then umask is useless, maybe we
> also add setfacl on parent directory because we may change the order
> about strip S_ISGID and posix_acl setup. Any idea?

If acls figure into this then this should probably be a new test or
subtest.
