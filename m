Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60CF95BF2AA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Sep 2022 03:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbiIUBVL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Sep 2022 21:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbiIUBVK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Sep 2022 21:21:10 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D644C6557B;
        Tue, 20 Sep 2022 18:21:08 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 28L1KuLH028389
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Sep 2022 21:20:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1663723259; bh=NrGo1J/yaUQZV0M6HG36XVcFnHjaPNu8ns6pV8ouas8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=HpAMjrjgMZhY28HgKz3urMhG4/AK9qRJBWqcYWhn8zRGlO7h3YWSYyZgZqFt7Aku8
         Dze7spACka9BbtL84rUycuF0dfyoqkbJDBWLF+jMnoMqqMiPHuiKELiR1koFLrpMFe
         ZBM9JrsuIgsHQjqkbGVaxKCUWtbzNOm43L+lor1e2myfVCmIJ5MpfqBYTWAz3trEs6
         fcrMj3GsaS2pvOfjNx8tRvoKDI7D1DNa1igTL6Z2h5yRXDmm4F7sMKKbP/pD8eF/uy
         XPZ8gNL16fMFi9k5PMr7fLp0L7a+J4nc8uDkOTAKt7OH4HE39ViZc2Sfx7hso7vByc
         p6RvdH0tpqgig==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id CA62715C526C; Tue, 20 Sep 2022 21:20:56 -0400 (EDT)
Date:   Tue, 20 Sep 2022 21:20:56 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ian Kent <raven@themaw.net>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Siddhesh Poyarekar <siddhesh@gotplt.org>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Carlos Maiolino <cmaiolino@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [REPOST PATCH v3 0/2] vfs: fix a mount table handling problem
Message-ID: <Yypm+GO6eMdV0QQ0@mit.edu>
References: <166365872189.39016.10771273319597352356.stgit@donald.themaw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <166365872189.39016.10771273319597352356.stgit@donald.themaw.net>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 20, 2022 at 03:26:17PM +0800, Ian Kent wrote:
> Whenever a mount has an empty "source" (aka mnt_fsname), the glibc
> function getmntent incorrectly parses its input, resulting in reporting
> incorrect data to the caller.
> 
> The problem is that the get_mnt_entry() function in glibc's
> misc/mntent_r.c assumes that leading whitespace on a line can always
> be discarded because it will always be followed by a # for the case
> of a comment or a non-whitespace character that's part of the value
> of the first field. However, this assumption is violated when the
> value of the first field is an empty string.
> 
> This is fixed in the mount API code by simply checking for a pointer
> that contains a NULL and treating it as a NULL pointer.

Why not simply have the mount API code disallow a zero-length "source"
/ mnt_fsname?

					- Ted
