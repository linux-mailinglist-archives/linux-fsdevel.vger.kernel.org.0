Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9DC3F22A3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Aug 2021 00:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233383AbhHSWEx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Aug 2021 18:04:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:43380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229605AbhHSWEw (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Aug 2021 18:04:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ADFEF6108F;
        Thu, 19 Aug 2021 22:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629410655;
        bh=aUhzsHm+fJwhMTC1YGSa8jGlBGg6DmC3CFu7zMxr+VE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TGeMjKTr1FVwA7pQUArJRW8E2BtTQ4aNAs+1OXpfMatsVwerUR/jDq723KcxJp78v
         1/YHKbhkhVekIBOmBFpZC/YdUAyc1XUbsx+3VlKF9EXx1kLpt+JZESe09e045PuUFS
         U8UcsRiQdKyWmrybcNP14Rra09zGYSsBdWBhXi6PHOXyd6xGHMLG2xwNkfGSQqqFHN
         zp7rg/cdnhEIseJprZ8V8SxTr1MEKgUFJ0HEpYpR6Ijb4Q80mBUPYVhtEVtO1aAe84
         9NUYX1G9N0anTevfQtT/zyLLTkPUZNiQ+76QH+D9dDEAFE00/eerI7VtPKEfs3fPZq
         B6WgpO3azmYyQ==
Received: by pali.im (Postfix)
        id 632537EA; Fri, 20 Aug 2021 00:04:12 +0200 (CEST)
Date:   Fri, 20 Aug 2021 00:04:12 +0200
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
Message-ID: <20210819220412.jicwnrevzi6s25ee@pali>
References: <20210808162453.1653-1-pali@kernel.org>
 <20210808162453.1653-6-pali@kernel.org>
 <20210819012108.3isqi4t6rmd5fd5x@kari-VirtualBox>
 <20210819081222.vnvxfrtqctfev6xu@pali>
 <20210819102342.6ps7lowpuomyqcdk@kari-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210819102342.6ps7lowpuomyqcdk@kari-VirtualBox>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thursday 19 August 2021 13:23:42 Kari Argillander wrote:
> On Thu, Aug 19, 2021 at 10:12:22AM +0200, Pali Rohár wrote:
> > On Thursday 19 August 2021 04:21:08 Kari Argillander wrote:
> > > On Sun, Aug 08, 2021 at 06:24:38PM +0200, Pali Rohár wrote:
> > > > Other fs drivers are using iocharset= mount option for specifying charset.
> > > > So mark iocharset= mount option as preferred and deprecate nls= mount
> > > > option.
> > >  
> > > One idea is also make this change to fs/fc_parser.c and then when we
> > > want we can drop support from all filesystem same time. This way we
> > > can get more deprecated code off the fs drivers. Draw back is that
> > > then every filesstem has this deprecated nls= option if it support
> > > iocharsets option. But that should imo be ok.
> > 
> > Beware that iocharset= is required only for fs which store filenames in
> > some specific encoding (in this case extension to UTF-16). For fs which
> > store filenames in raw bytes this option should not be parsed at all.
> 
> Yeah of course. I was thinking that what we do is that if key is nls=
> we change key to iocharset, print deprecated and then send it to driver
> parser as usual. This way driver parser will never know that user
> specifie nls= because it just get iocharset. But this is probebly too
> fancy way to think simple problem. Just idea. 

This has an issue that when you use nls= option for e.g. ext4 fs then
kernel starts reporting that nls= for ext4 is deprecated. But there is
no nls= option and neither iocharset= option for ext4. So kernel should
not start reporting such warnings for ext4.

> > Therefore I'm not sure if this parsing should be in global
> > fs/fc_parser.c file...
> 
