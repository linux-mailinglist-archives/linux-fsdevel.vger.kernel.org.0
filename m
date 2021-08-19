Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 523FC3F14EC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Aug 2021 10:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237252AbhHSINI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Aug 2021 04:13:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:44120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236854AbhHSINA (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Aug 2021 04:13:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D0D1A61131;
        Thu, 19 Aug 2021 08:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629360745;
        bh=GOCGkI4khodlS6ZkJJHgdEHRUQUkLqQWLt51fbZhqag=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ImP54DbDs6Ze/pjeJpxZIXIxsHwZxhPCVYEj1FQ58Pk8MQu0YgBPPHVt2QyUrWWOo
         F+7xVtg+xAy7FRjbe1EDJHizPC/0f/+6YwEFfR5N4NeTc9Emy2+fr9qITRH7x6la1+
         hCoKeGQqcKtWUd31f3zvr+9Afmvbea3bQHeAPiMQbPMWP2TOn6PTse/9stQ5OEP3SZ
         JTYkH0+aLr1DP5o6LkC0JuhqRDq62f+H5i2uiAFs3/pjZM9v7Hz9dS2sVFhpuvLxJE
         HuqJuEhjdyzIEfkvibVqGVld2ul4ViExKk1iPge2+38neIx/AdSziIQW7tMIsNbDhk
         G+ZkXmRCjJf3Q==
Received: by pali.im (Postfix)
        id 571FC7EA; Thu, 19 Aug 2021 10:12:22 +0200 (CEST)
Date:   Thu, 19 Aug 2021 10:12:22 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Kari Argillander <kari.argillander@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org,
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
Subject: Re: [RFC PATCH 05/20] ntfs: Undeprecate iocharset= mount option
Message-ID: <20210819081222.vnvxfrtqctfev6xu@pali>
References: <20210808162453.1653-1-pali@kernel.org>
 <20210808162453.1653-6-pali@kernel.org>
 <20210819012108.3isqi4t6rmd5fd5x@kari-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210819012108.3isqi4t6rmd5fd5x@kari-VirtualBox>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thursday 19 August 2021 04:21:08 Kari Argillander wrote:
> On Sun, Aug 08, 2021 at 06:24:38PM +0200, Pali Rohár wrote:
> > Other fs drivers are using iocharset= mount option for specifying charset.
> > So mark iocharset= mount option as preferred and deprecate nls= mount
> > option.
>  
> One idea is also make this change to fs/fc_parser.c and then when we
> want we can drop support from all filesystem same time. This way we
> can get more deprecated code off the fs drivers. Draw back is that
> then every filesstem has this deprecated nls= option if it support
> iocharsets option. But that should imo be ok.

Beware that iocharset= is required only for fs which store filenames in
some specific encoding (in this case extension to UTF-16). For fs which
store filenames in raw bytes this option should not be parsed at all.

Therefore I'm not sure if this parsing should be in global
fs/fc_parser.c file...
