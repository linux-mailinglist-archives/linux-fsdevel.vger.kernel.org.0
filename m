Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C838624617
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Nov 2022 16:38:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbiKJPit (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Nov 2022 10:38:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbiKJPis (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Nov 2022 10:38:48 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC58D7669;
        Thu, 10 Nov 2022 07:38:46 -0800 (PST)
Received: from letrec.thunk.org ([12.139.153.3])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 2AAFccQA016649
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Nov 2022 10:38:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1668094721; bh=wUJSGl619gPmorbLlIEb7nTood/eoKaRGCcIqALdWs0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=A2yajZ6YCWkXUOOs2EAoqNS/mX+zuFXFrRpM50gtbgv+Gy9fEfhJQih4UjfHUZkr0
         htWU3g6mtQBBl2ek1LwPh9sAYusMHZS+dCMCMbClppDeGt2jyYhG/rialwnoCvjGm/
         S6d5fVttIOUtEivxIqOjvY01qjXbCAYHIHo+KyWmkkxhoN1I2DGTuJrtR9I/O4NlGg
         d18pxAxQiP3+HfuQLWI4Wl/CcndxiA8uSyNEq4Mr6RbNLyeOVeKo2UiVVZDRV5egdU
         ssx1t05Z4cUkfjpL6S3cP5AFgmF7CSYomuSTwo9htbd0gwTJJRYaqiu/TsTxDe7SkR
         IMmILw8+py6cg==
Received: by letrec.thunk.org (Postfix, from userid 15806)
        id 791BA8C022E; Thu, 10 Nov 2022 10:38:37 -0500 (EST)
Date:   Thu, 10 Nov 2022 10:38:37 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Niels de Vos <ndevos@redhat.com>
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xiubo Li <xiubli@redhat.com>,
        Marcel Lauhoff <marcel.lauhoff@suse.com>
Subject: Re: [RFC 0/4] fs: provide per-filesystem options to disable fscrypt
Message-ID: <Y20a/akbY8Wcy3qg@mit.edu>
References: <20221110141225.2308856-1-ndevos@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221110141225.2308856-1-ndevos@redhat.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 10, 2022 at 03:12:21PM +0100, Niels de Vos wrote:
> While more filesystems are getting support for fscrypt, it is useful to
> be able to disable fscrypt for a selection of filesystems, while
> enabling it for others.

Could you say why you find it useful?  Is it because you are concerned
about the increased binary size of a particular file system if fscrypt
is enabled?  That hasn't been my experience, the hooks to call into
fscrypt are small and don't add too much to any one particular file
system; the bulk of the code is in fs/crypto.

Is it because people are pushing buggy code that doesn't compile if
you enable, say, CONFIG_FS_XXX and CONFIG_FSCRYPT at the same time?

Is it because a particular distribution doesn't want to support
fscrypt with a particular file system?  If so, there have been plenty
of file system features for say, ext4, xfs, and btrfs, which aren't
supported by a distro, but there isn't a CONFIG_FS_XXX_YYY to disable
that feature, nor have any distros requested such a thing --- which is
good because it would be an explosion of new CONFIG parameters.

Or is it something else?

Note that nearly all of the file systems will only enable fscrypt if
some file system feature flag enabls it.  So I'm not sure what's the
motivation behind adding this configuration option.  If memory serves,
early in the fscrypt development we did have per-file system CONFIG's
for fscrypt, but we consciously removed it, just as we no longer have
per-file system CONFIG's to enable or disable Posix ACL's or extended
attributes, in the name of simplifying the kernel config.

Cheers,

						- Ted
