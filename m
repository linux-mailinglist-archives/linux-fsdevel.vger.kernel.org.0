Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 817966C6FF5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Mar 2023 19:07:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbjCWSHo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Mar 2023 14:07:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbjCWSHm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Mar 2023 14:07:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 348A41C307
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Mar 2023 11:07:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DA250B821F7
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Mar 2023 18:07:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66DC2C433D2;
        Thu, 23 Mar 2023 18:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679594858;
        bh=oc36L9DihkP06ZEpUiHojWwKvkiSb9SLviWKHIqcMGY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n6jT3swINPJI7tV0q6QZGo8rRzTvM1sd9hd7nkxZTDCacMbR3qAnqKzHQsBsw+eQK
         ZmuAKi404zsyXMQAEwXs+F0DIdaglS3txcvnKeGxgPy7tAlUk/JINfzy1cHyqv2AgB
         zrD3h+Oxsdg+aIE7JTVU8t730BkVIy0jOOALUYVtH0fj00ZtegtO35jn0cZtkJwYW+
         +PrRVgMfManFNo2hjFeeFzbqDVkUByMs8tl8Y/dwXbGDraXBUhS3kmrSNWnAKdK/4u
         jUcX4kq+XMiEd+FKyw7MDQpbuL6YU3LZoQV3KRZgKIDHugY/mXLnH+O/fqoaCPVxV2
         SysveOeAPNmuw==
Date:   Thu, 23 Mar 2023 13:07:37 -0500
From:   Seth Forshee <sforshee@kernel.org>
To:     Anh Tuan Phan <tuananhlfc@gmail.com>
Cc:     brauner@kernel.org, shuah@kernel.org,
        linux-fsdevel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH v1] selftests mount: Fix mount_setattr_test builds failed
Message-ID: <ZByVac3GsD7RFuaj@do-x1extreme>
References: <20230323172859.89085-1-tuananhlfc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230323172859.89085-1-tuananhlfc@gmail.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 24, 2023 at 12:28:59AM +0700, Anh Tuan Phan wrote:
> When compiling selftests with target mount_setattr I encountered some errors with the below messages:
> mount_setattr_test.c: In function ‘mount_setattr_thread’:
> mount_setattr_test.c:343:16: error: variable ‘attr’ has initializer but incomplete type
>   343 |         struct mount_attr attr = {
>       |                ^~~~~~~~~~
> 
> These errors are might be because of linux/mount.h is not included. This patch resolves that issue.
> 
> Signed-off-by: Anh Tuan Phan <tuananhlfc@gmail.com>
> ---
>  tools/testing/selftests/mount_setattr/mount_setattr_test.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/mount_setattr/mount_setattr_test.c b/tools/testing/selftests/mount_setattr/mount_setattr_test.c
> index 582669ca38e9..7ca13a924e34 100644
> --- a/tools/testing/selftests/mount_setattr/mount_setattr_test.c
> +++ b/tools/testing/selftests/mount_setattr/mount_setattr_test.c
> @@ -18,6 +18,7 @@
>  #include <grp.h>
>  #include <stdbool.h>
>  #include <stdarg.h>
> +#include "linux/mount.h"
>  
>  #include "../kselftest_harness.h"

Oops, I had meant to send this fix before and forgot.

One minor nit. I'd prefer to see angle brackets used for this include,
since the kernel header path is passed using -isystem and angle brackets
are more conventional for system includes. It's also how most other
selftests include kernel headers. But either way:

Acked-by: Seth Forshee (DigitalOcean) <sforshee@kernel.org>
