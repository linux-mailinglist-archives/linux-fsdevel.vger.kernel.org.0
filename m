Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0325150054
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2020 02:46:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbgBCBqI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 2 Feb 2020 20:46:08 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:46746 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726971AbgBCBqI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 2 Feb 2020 20:46:08 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 085A328BEFA
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
Subject: Re: [PATCH v6 1/5] unicode: Add standard casefolded d_ops
Organization: Collabora
References: <20200128230328.183524-1-drosen@google.com>
        <20200128230328.183524-2-drosen@google.com>
Date:   Sun, 02 Feb 2020 20:45:59 -0500
In-Reply-To: <20200128230328.183524-2-drosen@google.com> (Daniel Rosenberg's
        message of "Tue, 28 Jan 2020 15:03:24 -0800")
Message-ID: <85sgjsxx2g.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Daniel Rosenberg <drosen@google.com> writes:

> diff --git a/include/linux/unicode.h b/include/linux/unicode.h
> index 990aa97d80496..5de313abeaf98 100644
> --- a/include/linux/unicode.h
> +++ b/include/linux/unicode.h
> @@ -4,6 +4,8 @@
>  
>  #include <linux/init.h>
>  #include <linux/dcache.h>
> +#include <linux/fscrypt.h>
> +#include <linux/fs.h>
>  
>  struct unicode_map {
>  	const char *charset;
> @@ -30,4 +32,19 @@ int utf8_casefold(const struct unicode_map *um, const struct qstr *str,
>  struct unicode_map *utf8_load(const char *version);
>  void utf8_unload(struct unicode_map *um);
>  
> +int utf8_ci_d_hash(const struct dentry *dentry, struct qstr *str);
> +int utf8_ci_d_compare(const struct dentry *dentry, unsigned int len,
> +			  const char *str, const struct qstr *name);


I don't think fs/unicode is the right place for these very specific
filesystem functions, just because they happen to use unicode.  It is an
encoding library, it doesn't care about dentries, nor should know how to
handle them.  It exposes a simple api to manipulate and convert utf8 strings.

I saw change was after the desire to not have these functions polluting
the VFS hot path, but that has nothing to do with placing them here.

Would libfs be better?  or a casefolding library in fs/casefold.c?


-- 
Gabriel Krisman Bertazi
