Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4133955E401
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jun 2022 15:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346092AbiF1NEK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jun 2022 09:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346136AbiF1NEB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jun 2022 09:04:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97D402D1C0;
        Tue, 28 Jun 2022 06:04:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 53271B81E13;
        Tue, 28 Jun 2022 13:03:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A7B9C3411D;
        Tue, 28 Jun 2022 13:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656421438;
        bh=5pardjsiDdJktGGm98STKcBBEYKP97n1jhNpRuphr6g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XUXQhFh4RlJm1/vVB1gDTIiEhLPWNzNNMgfshOcUyerksndkpoLCrMJQQiRfO+BGU
         LGxuGzv78GmxibVk+5/y/DgHBGeOZ+q2QiQLC5FIYozi7Rtmqk/t0HOSDNzqNzoQBr
         sLAAdAIeXzupqDfgauOQfaKAwurzoqNDNCGXaGQHND6XyX91+R0gx0wptmKq7x6G/e
         CiZbmocpAAX6FLmHGZS5X2p2HtzePSlrZY8laUEzYlv8zV8nPRoYdItLLBFMpJNDXC
         zrfYXSPf85JrGWOMHK+9HjS6eoDYl23nZ1EOSq9l2boFCqyfrP7XWMbJotUMbpaq57
         BgtEiPkz8eqNA==
Date:   Tue, 28 Jun 2022 15:03:48 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Ian Kent <raven@themaw.net>
Cc:     Al Viro <viro@ZenIV.linux.org.uk>,
        Siddhesh Poyarekar <siddhesh@gotplt.org>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Carlos Maiolino <cmaiolino@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] vfs: parse: deal with zero length string value
Message-ID: <20220628130348.i5ckfdnyzjtoqgb3@wittgenstein>
References: <165544249242.247784.13096425754908440867.stgit@donald.themaw.net>
 <165544254397.247784.17488951418549565189.stgit@donald.themaw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <165544254397.247784.17488951418549565189.stgit@donald.themaw.net>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 17, 2022 at 01:09:03PM +0800, Ian Kent wrote:
> Parsing an fs string that has zero length should result in the parameter
> being set to NULL so that downstream processing handles it correctly.
> For example, the proc mount table processing should print "(none)" in
> this case to preserve mount record field count, but if the value points
> to the NULL string this doesn't happen.
> 
> Signed-off-by: Ian Kent <raven@themaw.net>
> ---

Makes sense. Though I feel this is might be one of those instances where
we detect that some code isn't prepared for param.string to be NULL at
some point...
Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>
