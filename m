Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E057A3E4B1C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Aug 2021 19:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234437AbhHIRsK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Aug 2021 13:48:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:43446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234667AbhHIRsF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Aug 2021 13:48:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 494F960F25;
        Mon,  9 Aug 2021 17:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628531264;
        bh=/FzF4AX925VDrkN29pMet/SxwvAOYr7kHqZbB1ZleVs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o9ciE2Yankh6D9q5DwKQ3DzDVkkVquO3EdP/FHdqRHOd1fkIm3A+ST2OwIrrfulfy
         3wC8MIN2AEvGiz8h1lXpYuw7XJVCS55Dr/EC9VvmuxURex858mhjJetQBp/Y6uVgFv
         dKCuLAG1WlNvfsRzwR1wWREwjzcDJHQuxRSiDexp01/24scKD500LJWlAyU0qh0WZ8
         Qj1+NQtTiLSWB5tKCdrgD23W6lMhiEcUxUSHKnVNzJZlu+3gApUdPOdkgwMFERJ8+q
         Se++ZoKZg/xE3wIVbMTEc1fdpnWXII0aGLnAhn8+LCudGPWhxk6EiXOZbOM07sck1T
         PZPlv55ROfwLw==
Received: by pali.im (Postfix)
        id E4EC4C7C; Mon,  9 Aug 2021 19:47:41 +0200 (CEST)
Date:   Mon, 9 Aug 2021 19:47:41 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Viacheslav Dubeyko <slava@dubeyko.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-ntfs-dev@lists.sourceforge.net, linux-cifs@vger.kernel.org,
        jfs-discussion@lists.sourceforge.net,
        LKML <linux-kernel@vger.kernel.org>,
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
Subject: Re: [RFC PATCH 11/20] hfs: Explicitly set hsb->nls_disk when
 hsb->nls_io is set
Message-ID: <20210809174741.4wont2drya3rvpsr@pali>
References: <20210808162453.1653-1-pali@kernel.org>
 <20210808162453.1653-12-pali@kernel.org>
 <D0302F93-BAE5-48F0-87D0-B68B10D7757B@dubeyko.com>
 <YRFnz6kn1UbSCN/S@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YRFnz6kn1UbSCN/S@casper.infradead.org>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Monday 09 August 2021 18:37:19 Matthew Wilcox wrote:
> On Mon, Aug 09, 2021 at 10:31:55AM -0700, Viacheslav Dubeyko wrote:
> > > On Aug 8, 2021, at 9:24 AM, Pali Rohár <pali@kernel.org> wrote:
> > > 
> > > It does not make any sense to set hsb->nls_io (NLS iocharset used between
> > > VFS and hfs driver) when hsb->nls_disk (NLS codepage used between hfs
> > > driver and disk) is not set.
> > > 
> > > Reverse engineering driver code shown what is doing in this special case:
> > > 
> > >    When codepage was not defined but iocharset was then
> > >    hfs driver copied 8bit character from disk directly to
> > >    16bit unicode wchar_t type. Which means it did conversion
> > >    from Latin1 (ISO-8859-1) to Unicode because first 256
> > >    Unicode code points matches 8bit ISO-8859-1 codepage table.
> > >    So when iocharset was specified and codepage not, then
> > >    codepage used implicit value "iso8859-1".
> > > 
> > > So when hsb->nls_disk is not set and hsb->nls_io is then explicitly set
> > > hsb->nls_disk to "iso8859-1".
> > > 
> > > Such setup is obviously incompatible with Mac OS systems as they do not
> > > support iso8859-1 encoding for hfs. So print warning into dmesg about this
> > > fact.
> > > 
> > > After this change hsb->nls_disk is always set, so remove code paths for
> > > case when hsb->nls_disk was not set as they are not needed anymore.
> > 
> > 
> > Sounds reasonable. But it will be great to know that the change has been tested reasonably well.
> 
> I don't think it's reasonable to ask Pali to test every single filesystem.
> That's something the maintainer should do, as you're more likely to have
> the infrastructure already set up to do testing of your filesystem and
> be aware of fun corner cases and use cases than someone who's working
> across all filesystems.

This patch series is currently in RFC form, as stated in cover letter
mostly untested. So they are not in form for merging or detailed
reviewing. I just would like to know if this is the right direction with
filesystems and if I should continue with this my effort or not.
And I thought that sending RFC "incomplete" patches is better way than
just describing what to do and how...
