Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B203A68A98C
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Feb 2023 11:57:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232822AbjBDK5K (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 4 Feb 2023 05:57:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbjBDK5J (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 4 Feb 2023 05:57:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1557CA0B;
        Sat,  4 Feb 2023 02:57:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 80EF16068F;
        Sat,  4 Feb 2023 10:57:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83787C433D2;
        Sat,  4 Feb 2023 10:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675508226;
        bh=kMAzJD4jato0wOMCl0gOK8URH/g9P1F1yx8fLEcqu0M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TIJDT+KTE+1f1XIgi0D0hor8jwY2nRuIV6FphVBYHrI/A+Pdbv6lVS7SH0Gn5I/wa
         v9gza/eegV5E3ESm3GEymToXDZ56i43ihjAqoJf4Ncx9ZqqPn3R09ZUMbgPseVFdNB
         /kdreIycg5WXiL0rd71I5R8njA6iiwlmz/3J6t+MraPdnpHbtskpoFLJMHnSFNezm/
         QR5pWaAKEBAkMrGQjwegsNDhwKVrRUOyHCnfg52Ps3yDCjEviweJC8BlkxUmLv7b/L
         KUPS4QpKJsvQcQHEY7x9Rh1pcvx00I0ElnHNA5Sad3eq70I3JkR0EvmMybCnugBBFi
         kZ1XOyrRht9wQ==
Received: by pali.im (Postfix)
        id 5045F976; Sat,  4 Feb 2023 11:57:03 +0100 (CET)
Date:   Sat, 4 Feb 2023 11:57:03 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc:     linux-fsdevel@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net, linux-cifs@vger.kernel.org,
        jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.cz>, "Theodore Y . Ts'o" <tytso@mit.edu>,
        Anton Altaparmakov <anton@tuxera.com>,
        Luis de Bethencourt <luisbg@kernel.org>,
        Salah Triki <salah.triki@gmail.com>,
        Steve French <sfrench@samba.org>, Paulo Alcantara <pc@cjr.nz>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Tom Talpey <tom@talpey.com>, Dave Kleikamp <shaggy@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pavel Machek <pavel@ucw.cz>,
        Christoph Hellwig <hch@infradead.org>,
        Kari Argillander <kari.argillander@gmail.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>
Subject: Re: [RFC PATCH v2 01/18] fat: Fix iocharset=utf8 mount option
Message-ID: <20230204105703.pnc6vcy4hvmvvm3b@pali>
References: <20221226142150.13324-1-pali@kernel.org>
 <20221226142150.13324-2-pali@kernel.org>
 <874jsyvje6.fsf@mail.parknet.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <874jsyvje6.fsf@mail.parknet.co.jp>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tuesday 10 January 2023 18:17:05 OGAWA Hirofumi wrote:
> Pali Rohár <pali@kernel.org> writes:
> 
> > Currently iocharset=utf8 mount option is broken and error is printed to
> > dmesg when it is used. To use UTF-8 as iocharset, it is required to use
> > utf8=1 mount option.
> >
> > Fix iocharset=utf8 mount option to use be equivalent to the utf8=1 mount
> > option and remove printing error from dmesg.
> 
> [...]
> 
> > -
> > -	There is also an option of doing UTF-8 translations
> > -	with the utf8 option.
> > -
> > -.. note:: ``iocharset=utf8`` is not recommended. If unsure, you should consider
> > -	  the utf8 option instead.
> > +	**utf8** is supported too and recommended to use.
> >  
> >  **utf8=<bool>**
> > -	UTF-8 is the filesystem safe version of Unicode that
> > -	is used by the console. It can be enabled or disabled
> > -	for the filesystem with this option.
> > -	If 'uni_xlate' gets set, UTF-8 gets disabled.
> > -	By default, FAT_DEFAULT_UTF8 setting is used.
> > +	Alias for ``iocharset=utf8`` mount option.
> >  
> >  **uni_xlate=<bool>**
> >  	Translate unhandled Unicode characters to special
> > diff --git a/fs/fat/Kconfig b/fs/fat/Kconfig
> > index 238cc55f84c4..e98aaa3bb55b 100644
> > --- a/fs/fat/Kconfig
> > +++ b/fs/fat/Kconfig
> > @@ -93,29 +93,12 @@ config FAT_DEFAULT_IOCHARSET
> >  	  like FAT to use. It should probably match the character set
> >  	  that most of your FAT filesystems use, and can be overridden
> >  	  with the "iocharset" mount option for FAT filesystems.
> > -	  Note that "utf8" is not recommended for FAT filesystems.
> > -	  If unsure, you shouldn't set "utf8" here - select the next option
> > -	  instead if you would like to use UTF-8 encoded file names by default.
> > +	  "utf8" is supported too and recommended to use.
> 
> This patch fixes the issue of utf-8 partially only. I think we can't
> still recommend only partially working one.

With this patch FAT_DEFAULT_IOCHARSET=utf8 is same what was
FAT_DEFAULT_UTF8=y without this patch. And option FAT_DEFAULT_UTF8 was
recommended in description before "select the next option instead if you
would like to use UTF-8 encoded file names by default."

> [...]
> 
> > -	opts->utf8 = IS_ENABLED(CONFIG_FAT_DEFAULT_UTF8) && is_vfat;
> > -
> >  	if (!options)
> >  		goto out;
> >  
> > @@ -1318,10 +1316,14 @@ static int parse_options(struct super_block *sb, char *options, int is_vfat,
> >  					| VFAT_SFN_CREATE_WIN95;
> >  			break;
> >  		case Opt_utf8_no:		/* 0 or no or false */
> > -			opts->utf8 = 0;
> > +			fat_reset_iocharset(opts);
> 
> This changes the behavior of "iocharset=iso8859-1,utf8=no" for
> example. Do we need this user visible change here?

Ok, I agree, we do not want to change iocharset when
"iocharset=iso8859-1,utf8=no" was specified. It should stay on
iso8859-1.

> >  			break;
> >  		case Opt_utf8_yes:		/* empty or 1 or yes or true */
> > -			opts->utf8 = 1;
> > +			fat_reset_iocharset(opts);
> > +			iocharset = kstrdup("utf8", GFP_KERNEL);
> > +			if (!iocharset)
> > +				return -ENOMEM;
> > +			opts->iocharset = iocharset;
> >  			break;
> >  		case Opt_uni_xl_no:		/* 0 or no or false */
> >  			opts->unicode_xlate = 0;
> > @@ -1359,18 +1361,11 @@ static int parse_options(struct super_block *sb, char *options, int is_vfat,
> >  	}
> >  
> >  out:
> > -	/* UTF-8 doesn't provide FAT semantics */
> > -	if (!strcmp(opts->iocharset, "utf8")) {
> > -		fat_msg(sb, KERN_WARNING, "utf8 is not a recommended IO charset"
> > -		       " for FAT filesystems, filesystem will be "
> > -		       "case sensitive!");
> > -	}
> > +	opts->utf8 = !strcmp(opts->iocharset, "utf8") && is_vfat;
> 
> Still broken, so I think we still need the warning here (would be
> tweaked warning).

There was no warning before for utf8=1. And with this patch
iocharset=utf8 should have same behavior as what was utf8=1 before this
patch.

So if we should show some warning for utf8=1 then it is somehow not
related to this patch and it should be done separately, possible also to
the current codebase and before this patch.

> >  	/* If user doesn't specify allow_utime, it's initialized from dmask. */
> >  	if (opts->allow_utime == (unsigned short)-1)
> >  		opts->allow_utime = ~opts->fs_dmask & (S_IWGRP | S_IWOTH);
> > -	if (opts->unicode_xlate)
> > -		opts->utf8 = 0;
> 
> unicode_xlate option is exclusive with utf8, need to adjust
> somewhere. (with this patch, unicode_xlate and utf8 will shows by
> show_options())

Ok, seems that there is more work to handle unicode_xlate option
correctly.

> > +	else if (utf8)
> > +		return fat_utf8_strnicmp(name->name, str, alen);
> > +	else
> > +		return nls_strnicmp(t, name->name, str, alen);
> >  }
> 
> Not strong opinion though, maybe we better to consolidate this to a
> (inline) function? (FWIW, it may be better to refactor to provide some
> filename functions to hide the detail of handling nls/utf8)

This looks like an another cleanup / improvement which can be done. I'm
not sure if it is a good idea to put into this patch series (it is
already big).
