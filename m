Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C792A1327B5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2020 14:32:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728063AbgAGNch (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jan 2020 08:32:37 -0500
Received: from mx2.suse.de ([195.135.220.15]:49894 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727658AbgAGNcg (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jan 2020 08:32:36 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 83530AF05;
        Tue,  7 Jan 2020 13:32:34 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 7E02D1E0B47; Tue,  7 Jan 2020 14:32:33 +0100 (CET)
Date:   Tue, 7 Jan 2020 14:32:33 +0100
From:   Jan Kara <jack@suse.cz>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net, linux-cifs@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Luis de Bethencourt <luisbg@kernel.org>,
        Salah Triki <salah.triki@gmail.com>,
        Steve French <sfrench@samba.org>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        David Sterba <dsterba@suse.com>,
        Dave Kleikamp <shaggy@kernel.org>,
        Anton Altaparmakov <anton@tuxera.com>,
        Jan Kara <jack@suse.com>, "Theodore Y. Ts'o" <tytso@mit.edu>,
        Eric Sandeen <sandeen@redhat.com>,
        Namjae Jeon <linkinjeon@gmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: Unification of filesystem encoding options
Message-ID: <20200107133233.GC25547@quack2.suse.cz>
References: <20200102211855.gg62r7jshp742d6i@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200102211855.gg62r7jshp742d6i@pali>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 02-01-20 22:18:55, Pali Rohár wrote:
> 1) Unify mount options for specifying charset.
> 
> Currently all filesystems except msdos and hfsplus have mount option
> iocharset=<charset>. hfsplus has nls=<charset> and msdos does not
> implement re-encoding support. Plus vfat, udf and isofs have broken
> iocharset=utf8 option (but working utf8 option) And ntfs has deprecated
> iocharset=<charset> option.
> 
> I would suggest following changes for unification:
> 
> * Add a new alias iocharset= for hfsplus which would do same as nls=
> * Make iocharset=utf8 option for vfat, udf and isofs to do same as utf8
> * Un-deprecate iocharset=<charset> option for ntfs
> 
> This would cause that all filesystems would have iocharset=<charset>
> option which would work for any charset, including iocharset=utf8.
> And it would fix also broken iocharset=utf8 for vfat, udf and isofs.

Makes sense to me.

> 2) Add support for Unicode code points above U+FFFF for filesystems
> befs, hfs, hfsplus, jfs and ntfs, so iocharset=utf8 option would work
> also with filenames in userspace which would be 4 bytes long UTF-8.

Also looks good but when doing this, I'd suggest we extend NLS to support
full UTF-8 rather than implementing it by hand like e.g. we did for UDF.
 
> 3) Add support for iocharset= and codepage= options for msdos
> filesystem. It shares lot of pars of code with vfat driver.

I guess this is for msdos filesystem maintainers to decide.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
