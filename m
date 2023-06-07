Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86F1C726A05
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jun 2023 21:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbjFGTol (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jun 2023 15:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjFGTol (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jun 2023 15:44:41 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE36C1FE0;
        Wed,  7 Jun 2023 12:44:39 -0700 (PDT)
Date:   Wed, 7 Jun 2023 21:44:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1686167076; bh=DHQuMlD6tuImvscO3wkh4mwa16D27WZo2cWB+OFKZfk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L1XqR3DytaNGIKKsOZQJRNxbUQYt9DIOlmIft3RqxBCPH5rwk4xKu39CNTZNM6G82
         AludZr5yuij/sjLthOcA1tAnwMyRaeX8chijmaNKdVkhDy8cnyFuI5bS/ksdJqjaVv
         /+NqyPpaOatDI68pY+Hj/5dRvI4RveUEKmtUPDKU=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Karel Zak <kzag@redhat.com>, stable@vger.kernel.org
Subject: Re: [PATCH] fs: avoid empty option when generating legacy mount
 string
Message-ID: <d5377e0b-b02e-40dd-945b-368a3b8c05ce@t-8ch.de>
References: <20230607-fs-empty-option-v1-1-20c8dbf4671b@weissschuh.net>
 <20230607-rennpferd-stechen-2f645ac78fcc@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230607-rennpferd-stechen-2f645ac78fcc@brauner>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2023-06-07 21:39:01+0200, Christian Brauner wrote:
> On Wed, Jun 07, 2023 at 07:28:48PM +0200, Thomas Weißschuh wrote:
> > As each option string fragment is always prepended with a comma it would
> > happen that the whole string always starts with a comma.
> > This could be interpreted by filesystem drivers as an empty option and
> > may produce errors.
> > 
> > For example the NTFS driver from ntfs.ko behaves like this and fails when
> > mounted via the new API.
> > 
> > Link: https://github.com/util-linux/util-linux/issues/2298
> 
> Yeah, the old ntfs driver implements its own option parser. It
> overwrites/splits at ',' returning '\0' and then trips over this.
> 
> Contrast with e.g., ovl_next_op() which does the same thing but skips
> over '\0' in ovl_parse_opt().
> 
> So arguably also a bug in ntfs parsing. But there's no reason we should
> prepend ',' for legacy mount option strings.
> 
> And yeah, I can easily verify this...
> 
> Using my custom move-mount tool I originally wrote for another patchset
> but which is handy to pass mount options via the new mount api _system_
> calls and not via mount():
> https://github.com/brauner/move-mount-beneath
> 
> I can do:
> 
>         sudo ./move-mount -f overlay -olowerdir=/mnt/a:/mnt/b,upperdir=/mnt/upper,workdir=/mnt/work /mnt/merged
> 
> and clearly see:
> 
>         > sudo bpftrace -e 'kfunc:legacy_get_tree { @m = args->fc; printf("%s\n", str(((struct legacy_fs_context *)@m->fs_private)->legacy_data)); }'
>         Attaching 1 probe...
>         ,lowerdir=/mnt/a:/mnt/b,upperdir=/mnt/upper,workdir=/mnt/work
> 
> > Fixes: 3e1aeb00e6d1 ("vfs: Implement a filesystem superblock creation/configuration context")
> 
> Should be:
> 
> Fixes: commit 3e1aeb00e6d1 ("vfs: Implement a filesystem superblock creation/configuration context")

AFAIK the Fixes: tag does not use the "commit" keyword. Only inline
commit references.

This is how it's currently documented in
Documentation/process/submitting-patches.rst.

> and misses a:
> 
> Cc: stable@vger.kernel.org

This was fixed in v2.

> I'll fix this up for you though.

Thanks!


Thomas
