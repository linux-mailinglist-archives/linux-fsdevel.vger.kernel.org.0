Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FAEB73A640
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jun 2023 18:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbjFVQlD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Jun 2023 12:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbjFVQlC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Jun 2023 12:41:02 -0400
Received: from forward500c.mail.yandex.net (forward500c.mail.yandex.net [178.154.239.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5C4B1BDF;
        Thu, 22 Jun 2023 09:40:59 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-91.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-91.sas.yp-c.yandex.net [IPv6:2a02:6b8:c14:2991:0:640:bb47:0])
        by forward500c.mail.yandex.net (Yandex) with ESMTP id 8927E5ED93;
        Thu, 22 Jun 2023 19:40:57 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-91.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id reJYePLDd8c0-cwfrBZLp;
        Thu, 22 Jun 2023 19:40:56 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1687452056;
        bh=LJlONBowRbEQkaAjE/9HnNNbTEAVVilEOjQDFjjRaRY=;
        h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
        b=amcOrZR3/vGgEJBesBzTT0+7DVzpJ/1YvucHPxbxSXLPjsoXBvO5S3q803uycIm+C
         lX2FuDwmlnibR/tCYAbopZi3MB+LSwIY7FHBfdfK+mnXF+3XzjKQXO71FcZnAhwrl/
         FQh5tarSoU9KAumLcNloPD1Kfg/5NxCpUsQEWVOI=
Authentication-Results: mail-nwsmtp-smtp-production-main-91.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <7bbb29d2-4cae-48bd-1b97-9f4dbf6ffb19@yandex.ru>
Date:   Thu, 22 Jun 2023 21:40:52 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/2] selftests: add OFD lock tests
Content-Language: en-US
To:     Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-api@vger.kernel.org
References: <20230621152214.2720319-1-stsp2@yandex.ru>
 <20230621152214.2720319-3-stsp2@yandex.ru>
 <4db7c65bee0739fe7983059296cfc95f20647fa3.camel@kernel.org>
From:   stsp <stsp2@yandex.ru>
In-Reply-To: <4db7c65bee0739fe7983059296cfc95f20647fa3.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,SCC_BODY_URI_ONLY,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


22.06.2023 16:48, Jeff Layton пишет:
> I'm not opposed to adding a selftest here, but most filesystem testing
> is done via xfstests:
>
>      https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/
>
> It would be better to add this test to the existing generic/478 test
> that tests OFD locks. Can you patch that to add a test for the new
> functionality?
I don't actually think its possible.
It seems like their script creates 2
t_ofd_locks processes, one for creating
the lock, one for testing it.
This is not our case.
To make it work our way, we'd probably
need to hack that test directly into
t_ofd_locks.c, so that it can set and test
from the same fd. And I don't know how
to even run these tests. :)
So I am really inclined to limit myself
with a kernel selftest.
