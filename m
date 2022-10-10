Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5969A5F9A5E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Oct 2022 09:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232533AbiJJHr6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Oct 2022 03:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232552AbiJJHrj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Oct 2022 03:47:39 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6E81193C8;
        Mon, 10 Oct 2022 00:44:47 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 481C968AFE; Mon, 10 Oct 2022 09:44:09 +0200 (CEST)
Date:   Mon, 10 Oct 2022 09:44:09 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>, Xiaoming Ni <nixiaoming@huawei.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Andi Kleen <ak@linux.intel.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Christoph Hellwig <hch@lst.de>,
        Eric Dumazet <edumazet@google.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] fs/select: mark do_select noinline_for_stack for 32b
Message-ID: <20221010074409.GA20998@lst.de>
References: <CAKwvOdkEied8hf6Oid0sGf0ybF2WqrzOvtRiXa=j7Ms-Rc6uBA@mail.gmail.com> <20221007201140.1744961-1-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221007201140.1744961-1-ndesaulniers@google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 07, 2022 at 01:11:40PM -0700, Nick Desaulniers wrote:
> Effectively a revert of
> commit ad312f95d41c ("fs/select: avoid clang stack usage warning")
> 
> Various configs can still push the stack useage of core_sys_select()
> over the CONFIG_FRAME_WARN threshold (1024B on 32b targets).
> 
>   fs/select.c:619:5: error: stack frame size of 1048 bytes in function
>   'core_sys_select' [-Werror,-Wframe-larger-than=]

Btw, I also see a warning here with all my KASAN x86_64 gcc builds.
