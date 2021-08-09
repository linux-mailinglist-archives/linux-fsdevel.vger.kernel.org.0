Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B65D33E4AFA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Aug 2021 19:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234373AbhHIRi5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Aug 2021 13:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233847AbhHIRi4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Aug 2021 13:38:56 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4726EC0613D3;
        Mon,  9 Aug 2021 10:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=AGI41sjFzMutTv3hjWzSTBtY0u1tWmakhxlNUg5NRCE=; b=E7HBuh79SM8Flkqi/dqI8z/Xb6
        nKIFJKiUc8n7cMA7O8n2JcrZD86CEzD6uOkQMf/AKLgYzozznepDVpnTYt4ZKBjt3IEFmSKQCDQ+e
        3btGjUstbUzPvN7MunENt7Ex5u35MoG9APjFnTQ7/0FN4BHSFqloJ30XK5Rn+z++YT068wLWxAc0O
        dremkAECkRCaFj6liQ6X0ijX0kJi+2v8MD/DL/K1Sa6HSFDgiAXbBEK+0QXpgTBcMAzZVoVf5YNx1
        mbPZkXYU/+qdpNa3mEKnVTHwEGhmWqG/lIhcLutccjW1Fcy3OBPgczKb4rw7OcJcVdRtT+0JqtRLh
        4MBFPtig==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mD9DD-00BEsG-9z; Mon, 09 Aug 2021 17:37:25 +0000
Date:   Mon, 9 Aug 2021 18:37:19 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Viacheslav Dubeyko <slava@dubeyko.com>
Cc:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
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
        Marek =?iso-8859-1?Q?Beh=FAn?= <marek.behun@nic.cz>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [RFC PATCH 11/20] hfs: Explicitly set hsb->nls_disk when
 hsb->nls_io is set
Message-ID: <YRFnz6kn1UbSCN/S@casper.infradead.org>
References: <20210808162453.1653-1-pali@kernel.org>
 <20210808162453.1653-12-pali@kernel.org>
 <D0302F93-BAE5-48F0-87D0-B68B10D7757B@dubeyko.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D0302F93-BAE5-48F0-87D0-B68B10D7757B@dubeyko.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 09, 2021 at 10:31:55AM -0700, Viacheslav Dubeyko wrote:
> > On Aug 8, 2021, at 9:24 AM, Pali Rohár <pali@kernel.org> wrote:
> > 
> > It does not make any sense to set hsb->nls_io (NLS iocharset used between
> > VFS and hfs driver) when hsb->nls_disk (NLS codepage used between hfs
> > driver and disk) is not set.
> > 
> > Reverse engineering driver code shown what is doing in this special case:
> > 
> >    When codepage was not defined but iocharset was then
> >    hfs driver copied 8bit character from disk directly to
> >    16bit unicode wchar_t type. Which means it did conversion
> >    from Latin1 (ISO-8859-1) to Unicode because first 256
> >    Unicode code points matches 8bit ISO-8859-1 codepage table.
> >    So when iocharset was specified and codepage not, then
> >    codepage used implicit value "iso8859-1".
> > 
> > So when hsb->nls_disk is not set and hsb->nls_io is then explicitly set
> > hsb->nls_disk to "iso8859-1".
> > 
> > Such setup is obviously incompatible with Mac OS systems as they do not
> > support iso8859-1 encoding for hfs. So print warning into dmesg about this
> > fact.
> > 
> > After this change hsb->nls_disk is always set, so remove code paths for
> > case when hsb->nls_disk was not set as they are not needed anymore.
> 
> 
> Sounds reasonable. But it will be great to know that the change has been tested reasonably well.

I don't think it's reasonable to ask Pali to test every single filesystem.
That's something the maintainer should do, as you're more likely to have
the infrastructure already set up to do testing of your filesystem and
be aware of fun corner cases and use cases than someone who's working
across all filesystems.
