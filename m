Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D02457B1F2F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Sep 2023 16:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232342AbjI1OFP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Sep 2023 10:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231576AbjI1OFO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Sep 2023 10:05:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76C0E136;
        Thu, 28 Sep 2023 07:05:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAF12C433C7;
        Thu, 28 Sep 2023 14:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695909913;
        bh=6Dg6G5NYkGLr0eWe04c4RUxjLhdkFIrJohD7fivs7+I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eecH+hYNl1FzuaL1MIwHBXZB+0Mq+StxV0YlfEPwkHSesdnDkVhUnqueXXgDXND34
         Vid4AiYpP2OEH2Kou6VCBofuWqZZVaDzjPayS9ZW+QuznbLqxQmqi9fvkKUW0I2TJu
         htWysiynk9Al4HngkWulPoPWj1cEBduQ0g8fLoya4veWhesMEbRxFMhXwZMkIjIkBc
         3tNy2OkYlBN5o+gSX97eaGkqBmbYMK9iHqum7M2dmni3Crkf68NWEdhJbRbNpMutS7
         EVI2GNRrjrFggn2ZxUSpAmaOx2YLoia23tVyjMdH+nZRMM9b7A8zckQ/vpK+9oy4Ny
         PMPduQjnfhKdA==
Date:   Thu, 28 Sep 2023 16:05:08 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jann Horn <jannh@google.com>
Cc:     Mateusz Guzik <mjguzik@gmail.com>, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] vfs: shave work on failed file open
Message-ID: <20230928-themen-dilettanten-16bf329ab370@brauner>
References: <20230926162228.68666-1-mjguzik@gmail.com>
 <CAHk-=wjUCLfuKks-VGTG9hrFAORb5cuzqyC0gRXptYGGgL=YYg@mail.gmail.com>
 <CAGudoHGej+gmmv0OOoep2ENkf7hMBib-KL44Fu=Ym46j=r6VEA@mail.gmail.com>
 <20230927-kosmetik-babypuppen-75bee530b9f0@brauner>
 <CAHk-=whLadznjNKZPYUjxVzAyCH-rRhb24_KaGegKT9E6A86Kg@mail.gmail.com>
 <CAGudoHH2mvfjfKt+nOCEOfvOrQ+o1pqX63tN2r_1+bLZ4OqHNA@mail.gmail.com>
 <CAHk-=wjmgord99A-Gwy3dsiG1YNeXTCbt+z6=3RH_je5PP41Zw@mail.gmail.com>
 <ZRR1Kc/dvhya7ME4@f>
 <CAHk-=wibs_xBP2BGG4UHKhiP2B=7KJnx_LL18O0bGK8QkULLHg@mail.gmail.com>
 <20230928-kulleraugen-restaurant-dd14e2a9c0b0@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230928-kulleraugen-restaurant-dd14e2a9c0b0@brauner>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> So I spent a good chunk of time going through this patch.

The main thing that makes me go "we shouldn't do this" is that KASAN
isn't able to detect UAF issues as Jann pointed out so I'm getting
really nervous about this.

And Jann also pointed out some potential issues with
__fget_files_rcu() as well...
