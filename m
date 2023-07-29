Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC53E767C0E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Jul 2023 06:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbjG2ESP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 29 Jul 2023 00:18:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjG2ESN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 29 Jul 2023 00:18:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E6CA420C;
        Fri, 28 Jul 2023 21:18:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D59AF608C4;
        Sat, 29 Jul 2023 04:18:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7580C433C7;
        Sat, 29 Jul 2023 04:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690604291;
        bh=KQBZTd1S0knxsGiSweS0mSJsa3IrgD8+KiGKrRwjDpM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HzTepYHLCqjPnb04DG+lQ/wa+C7QCxmCzeepM4xWu7HFaFHnXwaqMArNTKsLWVTDf
         clYhanByTkW5HO+MBCicjRqObbYeuiIDjXz8nOWyUKhHhrUcEk0vmDjU3T/8QIpJAx
         FyFhIzFZzkaIpE1BKfAxqTOlzvdy3duJSmOf0DfIftTBjp6uMCBn1g28waTGOR0ffz
         X439aHHgq0bDLUjyA4+8Y/+cmbZzdZ/U4KUoDvz00xMswfnK64x16BHt+hVtjeg3uK
         y08JiKTf+0ZH2gfo/tLny4Wl41AU8Y5O5qiofOu0sY4U9tJ32b/F9+3oXNKHoj4Fdu
         7zqOMC5HzOIjw==
Date:   Fri, 28 Jul 2023 21:18:09 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Gabriel Krisman Bertazi <krisman@suse.de>
Cc:     Christian Brauner <brauner@kernel.org>, viro@zeniv.linux.org.uk,
        tytso@mit.edu, jaegeuk@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: Re: [PATCH v4 3/7] libfs: Validate negative dentries in
 case-insensitive directories
Message-ID: <20230729041809.GA4171@sol.localdomain>
References: <20230727172843.20542-1-krisman@suse.de>
 <20230727172843.20542-4-krisman@suse.de>
 <20230728-beckenrand-wahrlich-62d6b0505d68@brauner>
 <87r0os139h.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r0os139h.fsf@suse.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 28, 2023 at 11:09:46AM -0400, Gabriel Krisman Bertazi wrote:
> Christian Brauner <brauner@kernel.org> writes:
> 
> > On Thu, Jul 27, 2023 at 01:28:39PM -0400, Gabriel Krisman Bertazi wrote:
> 
> >
> > Wouldn't it make sense to get rid of all this indentation?
> 
> I'm ok with making this change. I'll wait for more reviews and Eric
> before sending a new version with this done.
> 
> Thanks!
> 

Well, the issue is that with patch 4, all the 'return 1;' would need to change
to 'return fscrypt_d_revalidate(dentry, flags);'.

A helper function could be used, though, if you prefer:

static int generic_ci_d_revalidate(struct dentry *dentry,
				   const struct qstr *name, unsigned int flags)
{
	if (!ci_d_revalidate(dentry, name, flags))
		return 0;
	return fscrypt_d_revalidate(dentry, flags);
}

- Eric
