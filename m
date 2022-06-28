Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21FCC55E403
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jun 2022 15:38:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345481AbiF1NEy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jun 2022 09:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343643AbiF1NEy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jun 2022 09:04:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFD2F101C8;
        Tue, 28 Jun 2022 06:04:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 51F30616CF;
        Tue, 28 Jun 2022 13:04:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2409C3411D;
        Tue, 28 Jun 2022 13:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656421491;
        bh=+4f+37unIZp3kHl9ZcJ8PuPB0LKqbGPEdmLrarjW6Vw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OLpIiYYty8zR4j31cY/CoSAga9EByAxuxNclLnJ6msLaCPDbGXlitQ7MAVByKWYsw
         YxM/minBU+LvMubWx8hk6b2Fni69BUIzSs+8GCiSqBA/7PHbcDkWQgJpSrLXDRLfL1
         e47ChxaXA0xpIOkUY6v9FVXKivKzpL22oFJDcH2FGGFQ/yz0Ux8RjSYN2Zky5xrZYl
         pdMnZtxXHy7m+LG4qq2qe2hICocr1ytoG/TFGslK028N2SBQLEKxd2zJIfi8bdHYky
         ZImQVI/Qiq7mORt5HR7tT4x3jFM8u8BUh50aeMTykgVk422TPF6v0092X1UiUEs0PM
         NaZMaVEfYxFTg==
Date:   Tue, 28 Jun 2022 15:04:46 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Ian Kent <raven@themaw.net>
Cc:     Al Viro <viro@ZenIV.linux.org.uk>,
        Siddhesh Poyarekar <siddhesh@gotplt.org>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Carlos Maiolino <cmaiolino@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] vfs: escape hash as well
Message-ID: <20220628130446.epdl7ao7zqypsxgi@wittgenstein>
References: <165544249242.247784.13096425754908440867.stgit@donald.themaw.net>
 <165544254964.247784.15840426718395834690.stgit@donald.themaw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <165544254964.247784.15840426718395834690.stgit@donald.themaw.net>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 17, 2022 at 01:09:09PM +0800, Ian Kent wrote:
> From: Siddhesh Poyarekar <siddhesh@gotplt.org>
> 
> When a filesystem is mounted with a name that starts with a #:
> 
>  # mount '#name' /mnt/bad -t tmpfs
> 
> this will cause the entry to look like this (leading space added so
> that git does not strip it out):
> 
>  #name /mnt/bad tmpfs rw,seclabel,relatime,inode64 0 0
> 
> This breaks getmntent and any code that aims to parse fstab as well as
> /proc/mounts with the same logic since they need to strip leading spaces
> or skip over comment lines, due to which they report incorrect output or
> skip over the line respectively.
> 
> Solve this by translating the hash character into its octal encoding
> equivalent so that applications can decode the name correctly.
> 
> Signed-off-by: Siddhesh Poyarekar <siddhesh@gotplt.org>
> Signed-off-by: Ian Kent <raven@themaw.net>
> ---

Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>
