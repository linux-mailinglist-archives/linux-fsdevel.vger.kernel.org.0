Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3665B6E70AE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Apr 2023 03:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231166AbjDSBPm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Apr 2023 21:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbjDSBPl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Apr 2023 21:15:41 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF6BE19B5
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Apr 2023 18:15:35 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id d8-20020a05600c3ac800b003ee6e324b19so670155wms.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Apr 2023 18:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ixsystems.com; s=google; t=1681866934; x=1684458934;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/CR1IHc9HYlrEY3U89v5t/OX9dshkbM7G0EYz0O4fCI=;
        b=DrQpXoa2vwYv5KgKUocv5hzJ7n0BoWaqg2iruABRxMov33aWAqj4qiPvOpss7HZR6Y
         eyhIIAvceuyg0ifTvZI9Cnjr9QhSmbFFlN/3wGztQxQNtOJXXg+UDScf7cszt/Z4gG/8
         8VrBJobMhaHoDO15M4c6DyBgLQEPPJ/FFkqH5cILQS0bDRRYYDDLrPUToOl7fvKCTc31
         n30oW0IbuLxNMSx+pt1G042pQtt0qZ/C6hzA+axA6jk/GuLAvkMW+II58uvrZLMA9bWR
         JqjZobprhwD2ArHbL08QY90pWDqrTPn6wy6+nyAJ7Fzu9gPSCvgG92Pjz/yoAOITQeqq
         B/HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681866934; x=1684458934;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/CR1IHc9HYlrEY3U89v5t/OX9dshkbM7G0EYz0O4fCI=;
        b=MxIFNd5AKvIrtZuJ+23uyFawB1dYbCvaMUEzH9jthON4WlDAeAGyMdG13MRS0ui6L+
         ZNATdbvNqdKrmZjPGwue5dGXUfNq77+eImUbVHyz+u4Hh6CRVujCMJj9PBa7I5tD4Dnh
         v4JSsbTowI8RtncsnNL1IwXW/UKd8x1neLU+n85jxkaKR4M7X0F8Z/55/h7Sj9XI3z0Y
         nxiq3VG50cJz12j6f3iR/IR8nfuA7L9gTjJdlAy5fBCV9Ufi2+5y/ZLy83B8dpvGUcvz
         QL+KHRdSXyG1q7he2g1yuNSjA4qseJTWXnc76G6F2CaS/zMrWZ+KUUCo8PC83qBG9eiE
         VJ9Q==
X-Gm-Message-State: AAQBX9cZ6w9jAFJkrzXVA5IgeXsX+3DToOf0yfd3T2iLLSCsevsDLaS7
        p1jhvqAm3vrPVgHmHU21N3eyeA==
X-Google-Smtp-Source: AKy350ZZSF1q/Toh4q2I8/pCwearcYtGy2vLmaJlZhVGcoLdCGT35UiwGZj6mJP4LqHxbBkciQlPeQ==
X-Received: by 2002:a1c:f315:0:b0:3f1:6757:6245 with SMTP id q21-20020a1cf315000000b003f167576245mr10165291wmq.7.1681866934353;
        Tue, 18 Apr 2023 18:15:34 -0700 (PDT)
Received: from hamza-pc ([2400:adc1:158:c700:9f4d:2f2e:ebe7:1578])
        by smtp.gmail.com with ESMTPSA id o2-20020a05600c4fc200b003f1738e64c0sm514527wmq.20.2023.04.18.18.15.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 18:15:33 -0700 (PDT)
Date:   Wed, 19 Apr 2023 06:15:29 +0500
From:   Ameer Hamza <ahamza@ixsystems.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     viro@zeniv.linux.org.uk, jlayton@kernel.org,
        chuck.lever@oracle.com, arnd@arndb.de, guoren@kernel.org,
        palmer@rivosinc.com, f.fainelli@gmail.com, slark_xiao@163.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, awalker@ixsystems.com
Subject: Re: [PATCH] Add new open(2) flag - O_EMPTY_PATH
Message-ID: <ZD9AsWMnNKJ4dpjm@hamza-pc>
References: <20221228160249.428399-1-ahamza@ixsystems.com>
 <20230106130651.vxz7pjtu5gvchdgt@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230106130651.vxz7pjtu5gvchdgt@wittgenstein>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 06, 2023 at 02:06:51PM +0100, Christian Brauner wrote:
> On Wed, Dec 28, 2022 at 09:02:49PM +0500, Ameer Hamza wrote:
> > This patch adds a new flag O_EMPTY_PATH that allows openat and open
> > system calls to open a file referenced by fd if the path is empty,
> > and it is very similar to the FreeBSD O_EMPTY_PATH flag. This can be
> > beneficial in some cases since it would avoid having to grant /proc
> > access to things like samba containers for reopening files to change
> > flags in a race-free way.
> > 
> > Signed-off-by: Ameer Hamza <ahamza@ixsystems.com>
> > ---
> 
> In general this isn't a bad idea and Aleksa and I proposed this as part
> of the openat2() patchset (see [1]).
> 
> However, the reason we didn't do this right away was that we concluded
> that it shouldn't be simply adding a flag. Reopening file descriptors
> through procfs is indeed very useful and is often required. But it's
> also been an endless source of subtle bugs and security holes as it
> allows reopening file descriptors with more permissions than the
> original file descriptor had.
> 
> The same lax behavior should not be encoded into O_EMPTYPATH. Ideally we
> would teach O_EMPTYPATH to adhere to magic link modes by default. This
> would be tied to the idea of upgrade mask in openat2() (cf. [2]). They
> allow a caller to specify the permissions that a file descriptor may be
> reopened with at the time the fd is opened.
> 
> [1]: https://lore.kernel.org/lkml/20190930183316.10190-4-cyphar@cyphar.com/
> [2]: https://lore.kernel.org/all/20220526130355.fo6gzbst455fxywy@senku/Kk

Thank you for the detailed explanation and sorry for getting back late
at it. It seems like a pre-requisite for O_EMPTYPATH is to make it safe
and that depends on a patchset that Aleksa was working on. It would be
helpful to know the current status of that effort and if we could expect
it in the near future.

The repo[1] that was mentioned here[2] seems to be private. I am wondering
if there's a way to look at the patch somehow.

[1]: https://github.com/cyphar/linux/tree/magiclink/main
[2]: https://lore.kernel.org/all/20220526130952.z5efngrnh7xtli32@senku/
