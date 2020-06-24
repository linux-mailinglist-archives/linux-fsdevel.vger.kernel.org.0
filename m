Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91B62206BE4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jun 2020 07:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388878AbgFXFn2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Jun 2020 01:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbgFXFn2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Jun 2020 01:43:28 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6886C061573;
        Tue, 23 Jun 2020 22:43:27 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 640412A4015
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Daniel Rosenberg <drosen@google.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        Eric Biggers <ebiggers@kernel.org>,
        linux-fscrypt@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH v9 4/4] ext4: Use generic casefolding support
Organization: Collabora
References: <20200624043341.33364-1-drosen@google.com>
        <20200624043341.33364-5-drosen@google.com>
Date:   Wed, 24 Jun 2020 01:43:22 -0400
In-Reply-To: <20200624043341.33364-5-drosen@google.com> (Daniel Rosenberg's
        message of "Tue, 23 Jun 2020 21:33:41 -0700")
Message-ID: <877dvxggsl.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Daniel Rosenberg <drosen@google.com> writes:

> -
>  const struct dentry_operations ext4_dentry_ops = {
> -	.d_hash = ext4_d_hash,
> -	.d_compare = ext4_d_compare,
> +	.d_hash = generic_ci_d_hash,
> +	.d_compare = generic_ci_d_compare,
>  };
>  #endif

Can you make the structure generic since it is the same for f2fs and
ext4, which let you drop the code guards?  Unless that becomes a problem for
d_revalidate with fscrypt, it is fine like this.

>  #ifdef CONFIG_UNICODE
> -	sbi = EXT4_SB(sb);
> -	if (ext4_has_strict_mode(sbi) && IS_CASEFOLDED(dir) &&
> -	    sbi->s_encoding && utf8_validate(sbi->s_encoding, &dentry->d_name))
> +	if (sb_has_enc_strict_mode(sb) && IS_CASEFOLDED(dir) &&

I keep reading the 'enc' in sb_has_enc_strict_mode() as 'encryption'.  What do
you think about renaming it to sb_has_strict_encoding()?

These comments apply equally to patches 3 and 4.  Other than that,

Reviewed-by: Gabriel Krisman Bertazi <krisman@collabora.com>

-- 
Gabriel Krisman Bertazi
