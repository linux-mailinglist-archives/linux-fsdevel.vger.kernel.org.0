Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBB15749781
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jul 2023 10:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbjGFIaV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jul 2023 04:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231315AbjGFIaT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jul 2023 04:30:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06BD91BC2;
        Thu,  6 Jul 2023 01:30:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9558C618C7;
        Thu,  6 Jul 2023 08:30:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 432EFC433C8;
        Thu,  6 Jul 2023 08:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688632216;
        bh=WHBpAo0uBocGZWMTcYEiDtdYOSVrcOFnyDnjE2bMwqc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V0rkyP831wal4VV/DWPMEigKMDYuZrCYZCe5ub55EnkQ44OZDoyXx3rhl5E4yEUEm
         8mGPprr69u74dsxCcFhQUizflSw7z/vzT8BZ81bVbsw2+aQpjr4BngigvvJqT4JwIo
         AdczluF5r7asS7onOTQbuLx12bcWj65xZdicl5VW3dXHqa6NvtDKl9B/ZwM7aJkbhg
         29xGTThQ1QuQPOdQmkIgAOcxs5wmI7XaFFi2Soz86sLTpYUatwWjTY1xqEsn8BoaJ6
         Im8HLdR04g6xj1PicLOt+5p18vYCDutsJOrIOmyW5BU7NcYQ3hzxK32lotrNHcdX6x
         aha53qRM8Ls/A==
Date:   Thu, 6 Jul 2023 10:30:10 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Luca Vizzarro <Luca.Vizzarro@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Kevin Brodsky <Kevin.Brodsky@arm.com>,
        Vincenzo Frascino <Vincenzo.Frascino@arm.com>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
        Theodore Ts'o <tytso@mit.edu>,
        David Laight <David.Laight@ACULAB.com>,
        Mark Rutland <Mark.Rutland@arm.com>,
        linux-fsdevel@vger.kernel.org, linux-morello@op-lists.linaro.org
Subject: Re: [PATCH v2 0/5] Alter fcntl to handle int arguments correctly
Message-ID: <20230706-truthahn-knecht-c0902bf61ae5@brauner>
References: <20230414152459.816046-1-Luca.Vizzarro@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230414152459.816046-1-Luca.Vizzarro@arm.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 14, 2023 at 04:24:54PM +0100, Luca Vizzarro wrote:
> According to the documentation of fcntl, some commands take an int as
> argument. In practice not all of them enforce this behaviour, as they
> instead accept a more permissive long and in most cases not even a
> range check is performed.
> 
> An issue could possibly arise from a combination of the handling of the
> varargs in user space and the ABI rules of the target, which may result
> in the top bits of an int argument being non-zero.
> 
> This issue was originally raised and detailed in the following thread:
>   https://lore.kernel.org/linux-api/Y1%2FDS6uoWP7OSkmd@arm.com/
> And was discovered during the porting of Linux to Morello [1].
> 
> This series modifies the interested commands so that they explicitly
> take an int argument. It also propagates this change down to helper and
> related functions as necessary.
> 
> This series is also available on my fork at:
>   https://git.morello-project.org/Sevenarth/linux/-/commits/fcntl-int-handling-v2
> 
> Best regards,
> Luca Vizzarro
> 
> [1] https://git.morello-project.org/morello/kernel/linux
> 
> Luca Vizzarro (5):
>   fcntl: Cast commands with int args explicitly
>   fs: Pass argument to fcntl_setlease as int
>   pipe: Pass argument of pipe_fcntl as int
>   memfd: Pass argument of memfd_fcntl as int
>   dnotify: Pass argument of fcntl_dirnotify as int

Applied, minus the already upstreamed memfd patch.
