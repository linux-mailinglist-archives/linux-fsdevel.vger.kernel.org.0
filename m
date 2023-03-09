Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92BBF6B2F6E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Mar 2023 22:16:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231304AbjCIVQ4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Mar 2023 16:16:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231181AbjCIVQw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Mar 2023 16:16:52 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03C10FEF0D;
        Thu,  9 Mar 2023 13:16:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 62B2DB820C3;
        Thu,  9 Mar 2023 21:16:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75853C433D2;
        Thu,  9 Mar 2023 21:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678396601;
        bh=voUmVW2ZU+0OsqV39UOnPjd4AYSNunMqfKt4AnsA7g0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gFqgvOT6kjtjuSL/XJ652HnSaUoT0wz0hHvn1ZR6kZTLn4i36xgSYWNF3pLFgUUFe
         v2S4EiP4f8wbeZ/QDHSNaT4wI84aU+dCPHoOKTZ3u+/1SPAxPy/8fNclNGQSVtALZN
         rUydQF7tcYXduSNclrYg8/LATTlnQdR3VAUKYXujy3t7WWMOi9KXb8zO4/RO42UInJ
         rxifN/3yCLbelZ1UHisiaR7VRselyplAB1q/nilEkHkvodSeNU6wRDC6rAPzJSzilF
         2zJO+YbSKTrPsROXMTwIAawuaOeGIz/VWP5ErAz7YShozzZngz5Blw1OZM8+raXAl3
         sgyx8WimNdBeg==
Date:   Thu, 9 Mar 2023 22:16:35 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     "Seth Forshee (DigitalOcean)" <sforshee@kernel.org>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] filelocks: use mount idmapping for setlease permission
 check
Message-ID: <20230309211635.wgdacgzx5s7yyqhd@wittgenstein>
References: <20230309-generic_setlease-use-idmapping-v1-1-6c970395ac4d@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230309-generic_setlease-use-idmapping-v1-1-6c970395ac4d@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 09, 2023 at 02:39:09PM -0600, Seth Forshee (DigitalOcean) wrote:
> A user should be allowed to take out a lease via an idmapped mount if
> the fsuid matches the mapped uid of the inode. generic_setlease() is
> checking the unmapped inode uid, causing these operations to be denied.
> 
> Fix this by comparing against the mapped inode uid instead of the
> unmapped uid.
> 
> Fixes: 9caccd41541a ("fs: introduce MOUNT_ATTR_IDMAP")
> Signed-off-by: Seth Forshee (DigitalOcean) <sforshee@kernel.org>
> ---

Thanks for catching this! This is pretty straightforward so I'll pick
this up in a bit,
Reviewed-by: Christian Brauner <brauner@kernel.org>
