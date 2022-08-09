Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6819B58D8C2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Aug 2022 14:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241902AbiHIMaX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Aug 2022 08:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241730AbiHIMaV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Aug 2022 08:30:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA2E3DC6;
        Tue,  9 Aug 2022 05:30:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E05CAB80B7F;
        Tue,  9 Aug 2022 12:30:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2F39C433D6;
        Tue,  9 Aug 2022 12:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660048216;
        bh=/SnO4BJYRWuajWBkA7JCZ80eUfTk9NyFhp9hieh+2hI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UM44pjqSiczAg922y/efQWAh6UKxnSay/joUxzpOfG+Ly1GuCOFjcjV0bUwNf8ZpI
         4SyQOMYTRIcK9G3J7/pVpxqPKZw1AgCO40dHVFwhnAxbD4qg4vvF1N8SrVb4+qVycX
         Mq93iFx4Fx2nC41lMRprROsx3sPGq/khYy2r/bd3nUX/iSqwBDfqfIoILwc0PCNjfO
         d6+GHAOGlcNRXr6YL5eIH8p46p1NDu8ovVgLWnMvsJsVzTNahEcaaBo8TgAVZmvXDS
         H5hIjh3JW0asw55kLXU4RfLJKSZB9rzXwRX270Q7N6RGEEyoM7DueDoECL+yVRRAKy
         DN9PfbqTdDn1Q==
Date:   Tue, 9 Aug 2022 14:30:11 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     David Howells <dhowells@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, Ian Kent <raven@themaw.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] uapi: Remove the inclusion of linux/mount.h from
 uapi/linux/fs.h
Message-ID: <20220809123011.7lqq27ms7zmcgaia@wittgenstein>
References: <163410.1659964655@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <163410.1659964655@warthog.procyon.org.uk>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 08, 2022 at 02:17:35PM +0100, David Howells wrote:
> Hi,
> 
> We're seeing issues in autofs and xfstests whereby linux/mount.h (the UAPI
> version) as included indirectly by linux/fs.h is conflicting with
> sys/mount.h (there's a struct and an enum).

(The linux/mount.h and sys/mount.h is painful for userspace too btw.)

> 
> Would it be possible to just remove the #include from linux/fs.h (as patch
> below) and rely on those hopefully few things that need mount flags that don't
> use the glibc header for them working around it by configuration?
> 
> David
> ---
> uapi: Remove the inclusion of linux/mount.h from uapi/linux/fs.h
>     
> Remove the inclusion of <linux/mount.h> from uapi/linux/fs.h as it
> interferes with definitions in sys/mount.h - but linux/fs.h is needed by
> various things where mount flags and structs are not.
> 
> Note that this will likely have the side effect of causing some build
> failures.
> 
> Reported-by: Ian Kent <raven@themaw.net>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Alexander Viro <viro@zeniv.linux.org.uk>
> cc: Christian Brauner <christian@brauner.io>
> cc: linux-fsdevel@vger.kernel.org
> cc: linux-api@vger.kernel.org
> ---

Yeah, I think this is ok.
Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>
