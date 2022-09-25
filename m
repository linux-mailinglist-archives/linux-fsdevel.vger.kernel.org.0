Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 285515E92F0
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Sep 2022 14:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbiIYMGx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 25 Sep 2022 08:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbiIYMGw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 25 Sep 2022 08:06:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1664D2F3A1;
        Sun, 25 Sep 2022 05:06:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A52F4614FE;
        Sun, 25 Sep 2022 12:06:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F033C433C1;
        Sun, 25 Sep 2022 12:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664107610;
        bh=BCVRBXCetpvd2YGmBGtkM+UvNAeY+VGeEDAT0/lc8fs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PU4HPuu6PfX16bgcSLQO2UdKyKi6k7hidu67KPybnHdBqUDMS2nEB0bskWnITbEI1
         NiISQOj9XmDLK220C1XUdj2ECXol9pSIXpNbkClHluegVM1oYYycVNx99kVXgLukx9
         EPU/1LXeHiI6+8eZAFXHudHaHWa288mSa9ZlipLUF0IJHUFEeaqsCrVF5rJI2V2ePq
         k6UEXIz3RPnZLYdgnY9JssVFw+sQY5d4XVdYVey6CXQowDvO4T3RG/rpTDiF6CW6C/
         ppMcYGtCVWe5d50KxhotzIEYWi4VS/pvfEz2ckZhNP6lcyEirgox4/ytck47LAc95A
         OEvoEnYdqANEA==
Received: by pali.im (Postfix)
        id 6D0D1EE2; Sun, 25 Sep 2022 14:06:46 +0200 (CEST)
Date:   Sun, 25 Sep 2022 14:06:46 +0200
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
Subject: Re: [RFC PATCH 12/20] hfs: Do not use broken utf8 NLS table for
 iocharset=utf8 mount option
Message-ID: <20220925120646.dfkofrka74blwrwb@pali>
References: <20210808162453.1653-1-pali@kernel.org>
 <20210808162453.1653-13-pali@kernel.org>
 <4B1987C7-F6D9-4493-ACD0-846B92F86037@dubeyko.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4B1987C7-F6D9-4493-ACD0-846B92F86037@dubeyko.com>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello! Sorry for a longer delay. Below are comments.

On Monday 09 August 2021 10:49:34 Viacheslav Dubeyko wrote:
> > On Aug 8, 2021, at 9:24 AM, Pali Rohár <pali@kernel.org> wrote:
> > 
> > NLS table for utf8 is broken and cannot be fixed.
> > 
> > So instead of broken utf8 nls functions char2uni() and uni2char() use
> > functions utf8_to_utf32() and utf32_to_utf8() which implements correct
> > encoding and decoding between Unicode code points and UTF-8 sequence.
> > 
> > When iochatset=utf8 is used then set hsb->nls_io to NULL and use it for
> > distinguish between the fact if NLS table or native UTF-8 functions should
> > be used.
> > 
> > Signed-off-by: Pali Rohár <pali@kernel.org>
> > ---
> > fs/hfs/super.c | 33 ++++++++++++++++++++++-----------
> > fs/hfs/trans.c | 24 ++++++++++++++++++++----
> > 2 files changed, 42 insertions(+), 15 deletions(-)
> > 
> > diff --git a/fs/hfs/super.c b/fs/hfs/super.c
> > index 86bc46746c7f..076308df41cf 100644
> > --- a/fs/hfs/super.c
> > +++ b/fs/hfs/super.c
> > @@ -149,10 +149,13 @@ static int hfs_show_options(struct seq_file *seq, struct dentry *root)
> > 		seq_printf(seq, ",part=%u", sbi->part);
> > 	if (sbi->session >= 0)
> > 		seq_printf(seq, ",session=%u", sbi->session);
> > -	if (sbi->nls_disk)
> > +	if (sbi->nls_disk) {
> > 		seq_printf(seq, ",codepage=%s", sbi->nls_disk->charset);
> 
> Maybe, I am missing something. But where is the closing “}”?

See below...

> 
> > -	if (sbi->nls_io)
> > -		seq_printf(seq, ",iocharset=%s", sbi->nls_io->charset);
> > +		if (sbi->nls_io)
> > +			seq_printf(seq, ",iocharset=%s", sbi->nls_io->charset);
> > +		else
> > +			seq_puts(seq, ",iocharset=utf8");
> > +	}

        ^
... Closing "}" is marked above.

> > 	if (sbi->s_quiet)
> > 		seq_printf(seq, ",quiet");
> > 	return 0;
> > @@ -225,6 +228,7 @@ static int parse_options(char *options, struct hfs_sb_info *hsb)
> > 	char *p;
> > 	substring_t args[MAX_OPT_ARGS];
> > 	int tmp, token;
> > +	int have_iocharset;
> 
> What’s about boolean type?

Ok! No problem, I can use "bool" type. Just I was in impression that
code style of this driver is to use "int" type also for booleans.
Same for "false" and "true" as you mentioned below.

> > 
> > 	/* initialize the sb with defaults */
> > 	hsb->s_uid = current_uid();
> > @@ -239,6 +243,8 @@ static int parse_options(char *options, struct hfs_sb_info *hsb)
> > 	if (!options)
> > 		return 1;
> > 
> > +	have_iocharset = 0;
> 
> What’s about false here?
> 
> > +
> > 	while ((p = strsep(&options, ",")) != NULL) {
> > 		if (!*p)
> > 			continue;
> > @@ -332,18 +338,22 @@ static int parse_options(char *options, struct hfs_sb_info *hsb)
> > 			kfree(p);
> > 			break;
> > 		case opt_iocharset:
> > -			if (hsb->nls_io) {
> > +			if (have_iocharset) {
> > 				pr_err("unable to change iocharset\n");
> > 				return 0;
> > 			}
> > 			p = match_strdup(&args[0]);
> > -			if (p)
> > -				hsb->nls_io = load_nls(p);
> > -			if (!hsb->nls_io) {
> > -				pr_err("unable to load iocharset \"%s\"\n", p);
> > -				kfree(p);
> > +			if (!p)
> > 				return 0;
> > +			if (strcmp(p, "utf8") != 0) {
> > +				hsb->nls_io = load_nls(p);
> > +				if (!hsb->nls_io) {
> > +					pr_err("unable to load iocharset \"%s\"\n", p);
> > +					kfree(p);
> > +					return 0;
> > +				}
> > 			}
> > +			have_iocharset = 1;
> 
> What’s about true here?
> 
> > 			kfree(p);
> > 			break;
> > 		default:
> > @@ -351,7 +361,7 @@ static int parse_options(char *options, struct hfs_sb_info *hsb)
> > 		}
> > 	}
> > 
> > -	if (hsb->nls_io && !hsb->nls_disk) {
> > +	if (have_iocharset && !hsb->nls_disk) {
> > 		/*
> > 		 * Previous version of hfs driver did something unexpected:
> > 		 * When codepage was not defined but iocharset was then
> > @@ -382,7 +392,8 @@ static int parse_options(char *options, struct hfs_sb_info *hsb)
> > 			return 0;
> > 		}
> > 	}
> > -	if (hsb->nls_disk && !hsb->nls_io) {
> > +	if (hsb->nls_disk &&
> > +	    !have_iocharset && strcmp(CONFIG_NLS_DEFAULT, "utf8") != 0) {
> 
> Maybe, introduce the variable to calculate the boolean value here? Then if statement will look much cleaner.

I'm not sure how to do it to make code look cleaner.

Currently there is:

if (hsb->nls_disk &&
    !have_iocharset && strcmp(CONFIG_NLS_DEFAULT, "utf8") != 0) {
    hsb->nls_io = load_nls_default();
    ...
}

I can replace it e.g. by:

bool need_to_load_nls;
...
if (hsb->nls_disk &&
    !have_iocharset && strcmp(CONFIG_NLS_DEFAULT, "utf8") != 0)
    need_to_load_nls = true;
else
    need_to_load_nls = false;

if (need_to_load_nls) {
    hsb->nls_io = load_nls_default();
    ...
}

But it is just longer, condition is still there and it requires one
additional variable which more me is less readable because it is longer.

> > 		hsb->nls_io = load_nls_default();
> > 		if (!hsb->nls_io) {
> > 			pr_err("unable to load default iocharset\n");
> > diff --git a/fs/hfs/trans.c b/fs/hfs/trans.c
> > index c75682c61b06..bff8e54003ab 100644
> > --- a/fs/hfs/trans.c
> > +++ b/fs/hfs/trans.c
> > @@ -44,7 +44,7 @@ int hfs_mac2asc(struct super_block *sb, char *out, const struct hfs_name *in)
> > 		srclen = HFS_NAMELEN;
> > 	dst = out;
> > 	dstlen = HFS_MAX_NAMELEN;
> > -	if (nls_io) {
> > +	if (nls_disk) {
> > 		wchar_t ch;
> > 
> 
> I could miss something here. But what’s about the closing “}”?

Closing "}" is there on the same location as it was. Before my change on
"if" line was opening "{" and also with my change there is opening "{".
So opening "{" and closing "}" are there and matches.

> Thanks,
> Slava.
> 
> > 		while (srclen > 0) {
> > @@ -57,7 +57,12 @@ int hfs_mac2asc(struct super_block *sb, char *out, const struct hfs_name *in)
> > 			srclen -= size;
> > 			if (ch == '/')
> > 				ch = ':';
> > -			size = nls_io->uni2char(ch, dst, dstlen);
> > +			if (nls_io)
> > +				size = nls_io->uni2char(ch, dst, dstlen);
> > +			else if (dstlen > 0)
> > +				size = utf32_to_utf8(ch, dst, dstlen);
> > +			else
> > +				size = -ENAMETOOLONG;
> > 			if (size < 0) {
> > 				if (size == -ENAMETOOLONG)
> > 					goto out;
> > @@ -101,11 +106,22 @@ void hfs_asc2mac(struct super_block *sb, struct hfs_name *out, const struct qstr
> > 	srclen = in->len;
> > 	dst = out->name;
> > 	dstlen = HFS_NAMELEN;
> > -	if (nls_io) {
> > +	if (nls_disk) {
> > 		wchar_t ch;
> > +		unicode_t u;
> > 
> > 		while (srclen > 0) {
> > -			size = nls_io->char2uni(src, srclen, &ch);
> > +			if (nls_io)
> > +				size = nls_io->char2uni(src, srclen, &ch);
> > +			else {
> > +				size = utf8_to_utf32(str, strlen, &u);
> > +				if (size >= 0) {
> > +					if (u <= MAX_WCHAR_T)
> > +						ch = u;
> > +					else
> > +						size = -EINVAL;
> > +				}
> > +			}
> > 			if (size < 0) {
> > 				ch = '?';
> > 				size = 1;
> > -- 
> > 2.20.1
> > 
> 
