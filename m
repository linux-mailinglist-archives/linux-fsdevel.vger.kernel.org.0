Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3589C5E92FC
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Sep 2022 14:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbiIYMMM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 25 Sep 2022 08:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232004AbiIYMML (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 25 Sep 2022 08:12:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E23AD303D7;
        Sun, 25 Sep 2022 05:12:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6951161223;
        Sun, 25 Sep 2022 12:12:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AEDCC433C1;
        Sun, 25 Sep 2022 12:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664107929;
        bh=3QpOnBvdxL0+AZ41OUJ8Z8CAtbcfHcNF9j/3kuh7UJk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lz9HACjWXnyFes4+TEG3Arf2V68bAcMUyphkg4Llv+pb+zp36wX9Rz5y7xi5jtDZz
         Qv9rYHiYGWufdfv65edKRBRMnsHuPrpBUIwalal9lh9I5n9ybpKOtQ1Q8IK8Fxwei/
         N952N2z2tVxyr5EMlW24Qw7wBYvWhXJsfSAgj9IXe6Zqd4J8MIhWoQeFAKo/jTnlE9
         Da9uhOaJaV0NU3ZM8S0974OyiRFq6/ZCqQwlF+j9tED7MSsYzhGAuPvWAjBsD1dn3k
         Xy136JBposGdTKPbBeyGC4Mj43/VJftoEKb2VlqnFUKp0XRcoJi7hNo9go+w78z4Pc
         KS9xTt0Voa8vQ==
Received: by pali.im (Postfix)
        id C06F2EE2; Sun, 25 Sep 2022 14:12:06 +0200 (CEST)
Date:   Sun, 25 Sep 2022 14:12:06 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Viacheslav Dubeyko <slava@dubeyko.com>
Cc:     Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-ntfs-dev@lists.sourceforge.net, linux-cifs@vger.kernel.org,
        jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.cz>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Luis de Bethencourt <luisbg@kernel.org>,
        Salah Triki <salah.triki@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Kleikamp <shaggy@kernel.org>,
        Anton Altaparmakov <anton@tuxera.com>,
        Pavel Machek <pavel@ucw.cz>,
        Marek =?utf-8?B?QmVow7pu?= <marek.behun@nic.cz>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [RFC PATCH 13/20] hfsplus: Do not use broken utf8 NLS table for
 iocharset=utf8 mount option
Message-ID: <20220925121206.glqeuptele746qsp@pali>
References: <20210808162453.1653-1-pali@kernel.org>
 <20210808162453.1653-14-pali@kernel.org>
 <4D2445C9-7D4D-438A-964C-5B8F46BC15B5@dubeyko.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4D2445C9-7D4D-438A-964C-5B8F46BC15B5@dubeyko.com>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello!

On Monday 09 August 2021 10:42:02 Viacheslav Dubeyko wrote:
> > On Aug 8, 2021, at 9:24 AM, Pali Rohár <pali@kernel.org> wrote:
> > 
> > NLS table for utf8 is broken and cannot be fixed.
> > 
> > So instead of broken utf8 nls functions char2uni() and uni2char() use
> > functions utf8_to_utf32() and utf32_to_utf8() which implements correct
> > encoding and decoding between Unicode code points and UTF-8 sequence.
> > 
> > Note that this fs driver does not support full Unicode range, specially
> > UTF-16 surrogate pairs are unsupported. This patch does not change this
> > limitation and support for UTF-16 surrogate pairs stay unimplemented.
> > 
> > When iochatset=utf8 is used then set sbi->nls to NULL and use it for
> > distinguish between the fact if NLS table or native UTF-8 functions should
> > be used.
> > 
> > Signed-off-by: Pali Rohár <pali@kernel.org>
> > ---
> > fs/hfsplus/dir.c            |  6 ++++--
> > fs/hfsplus/options.c        | 32 ++++++++++++++++++--------------
> > fs/hfsplus/super.c          |  7 +------
> > fs/hfsplus/unicode.c        | 31 ++++++++++++++++++++++++++++---
> > fs/hfsplus/xattr.c          | 14 +++++++++-----
> > fs/hfsplus/xattr_security.c |  3 ++-
> > 6 files changed, 62 insertions(+), 31 deletions(-)
> > 
> > diff --git a/fs/hfsplus/dir.c b/fs/hfsplus/dir.c
> > index 84714bbccc12..2caf0cd82221 100644
> > --- a/fs/hfsplus/dir.c
> > +++ b/fs/hfsplus/dir.c
> > @@ -144,7 +144,8 @@ static int hfsplus_readdir(struct file *file, struct dir_context *ctx)
> > 	err = hfs_find_init(HFSPLUS_SB(sb)->cat_tree, &fd);
> > 	if (err)
> > 		return err;
> > -	strbuf = kmalloc(NLS_MAX_CHARSET_SIZE * HFSPLUS_MAX_STRLEN + 1, GFP_KERNEL);
> > +	strbuf = kmalloc((HFSPLUS_SB(sb)->nls ? NLS_MAX_CHARSET_SIZE : 4) *
> > +			HFSPLUS_MAX_STRLEN + 1, GFP_KERNEL);
> 
> Maybe, introduce some variable that will contain the length calculation?

Ok! I can introduce variable with calculated length into all places.

> > 	if (!strbuf) {
> > 		err = -ENOMEM;
> > 		goto out;
> > @@ -203,7 +204,8 @@ static int hfsplus_readdir(struct file *file, struct dir_context *ctx)
> > 		hfs_bnode_read(fd.bnode, &entry, fd.entryoffset,
> > 			fd.entrylength);
> > 		type = be16_to_cpu(entry.type);
> > -		len = NLS_MAX_CHARSET_SIZE * HFSPLUS_MAX_STRLEN;
> > +		len = (HFSPLUS_SB(sb)->nls ? NLS_MAX_CHARSET_SIZE : 4) *
> > +		      HFSPLUS_MAX_STRLEN;
> > 		err = hfsplus_uni2asc(sb, &fd.key->cat.name, strbuf, &len);
> > 		if (err)
> > 			goto out;
> > diff --git a/fs/hfsplus/options.c b/fs/hfsplus/options.c
> > index a975548f6b91..16c08cb5c4f8 100644
> > --- a/fs/hfsplus/options.c
> > +++ b/fs/hfsplus/options.c
> > @@ -104,6 +104,9 @@ int hfsplus_parse_options(char *input, struct hfsplus_sb_info *sbi)
> > 	char *p;
> > 	substring_t args[MAX_OPT_ARGS];
> > 	int tmp, token;
> > +	int have_iocharset;
> > +
> > +	have_iocharset = 0;
> 
> What’s about boolean type and to use true/false?

Ok. I can change type to "bool" and use "true"/"false" values.

> > 
> > 	if (!input)
> > 		goto done;
> > @@ -171,20 +174,24 @@ int hfsplus_parse_options(char *input, struct hfsplus_sb_info *sbi)
> > 			pr_warn("option nls= is deprecated, use iocharset=\n");
> > 			/* fallthrough */
> > 		case opt_iocharset:
> > -			if (sbi->nls) {
> > +			if (have_iocharset) {
> > 				pr_err("unable to change nls mapping\n");
> > 				return 0;
> > 			}
> > 			p = match_strdup(&args[0]);
> > -			if (p)
> > -				sbi->nls = load_nls(p);
> > -			if (!sbi->nls) {
> > -				pr_err("unable to load nls mapping \"%s\"\n",
> > -				       p);
> > -				kfree(p);
> > +			if (!p)
> > 				return 0;
> > +			if (strcmp(p, "utf8") != 0) {
> > +				sbi->nls = load_nls(p);
> > +				if (!sbi->nls) {
> > +					pr_err("unable to load nls mapping "
> > +						"\"%s\"\n", p);
> > +					kfree(p);
> > +					return 0;
> > +				}
> > 			}
> > 			kfree(p);
> > +			have_iocharset = 1;
> 
> Ditto. What’s about true here?
> 
> > 			break;
> > 		case opt_decompose:
> > 			clear_bit(HFSPLUS_SB_NODECOMPOSE, &sbi->flags);
...
> > @@ -256,7 +266,22 @@ int hfsplus_uni2asc(struct super_block *sb,
> > static inline int asc2unichar(struct super_block *sb, const char *astr, int len,
> > 			      wchar_t *uc)
> > {
> > -	int size = HFSPLUS_SB(sb)->nls->char2uni(astr, len, uc);
> > +	struct nls_table *nls = HFSPLUS_SB(sb)->nls;
> > +	unicode_t u;
> > +	int size;
> > +
> > +	if (nls)
> > +		size = nls->char2uni(astr, len, uc);
> > +	else {
> > +		size = utf8_to_utf32(astr, len, &u);
> > +		if (size >= 0) {
> > +			/* TODO: Add support for UTF-16 surrogate pairs */
> 
> Have you forgot to delete this string? Or do you plan to implement this?

No. I have not forgot. In current version there is missing support for
UTF-16 surrogate pairs and this my patch still does not implement it.

So this is kind a issue / bug in the driver and at least it should be
documented. So reader of this code would know it and maybe somebody in
future will implement it.

> > +			if (u <= MAX_WCHAR_T)
> > +				*uc = u;
> > +			else
> > +				size = -EINVAL;
> > +		}
> > +	}
