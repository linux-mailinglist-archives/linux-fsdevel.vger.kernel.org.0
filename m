Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38DC2133043
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2020 21:04:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728585AbgAGUEu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jan 2020 15:04:50 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:54363 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728358AbgAGUEt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jan 2020 15:04:49 -0500
Received: from callcc.thunk.org (guestnat-104-133-0-111.corp.google.com [104.133.0.111] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 007K31WJ002663
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 7 Jan 2020 15:03:02 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id B2F684207DF; Tue,  7 Jan 2020 15:03:01 -0500 (EST)
Date:   Tue, 7 Jan 2020 15:03:01 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
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
        Jan Kara <jack@suse.com>, Eric Sandeen <sandeen@redhat.com>,
        Namjae Jeon <linkinjeon@gmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: Unification of filesystem encoding options
Message-ID: <20200107200301.GE3619@mit.edu>
References: <20200102211855.gg62r7jshp742d6i@pali>
 <20200107133233.GC25547@quack2.suse.cz>
 <20200107173842.ciskn4ahuhiklycm@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200107173842.ciskn4ahuhiklycm@pali>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 07, 2020 at 06:38:42PM +0100, Pali Rohár wrote:
> Adding support for case-insensitivity into UTF-8 NLS encoding would mean
> to create completely new kernel NLS API (which would support variable
> length encodings) and rewrite all NLS filesystems to use this new API.
> Also all existing NLS encodings would be needed to port into this new
> API.
> 
> It is really something which have a value? Just because of UTF-8?
> 
> For me it looks like better option would be to remove UTF-8 NLS encoding
> as it is broken. Some filesystems already do not use NLS API for their
> UTF-8 support (e.g. vfat, udf or newly prepared exfat). And others could
> be modified/extended/fixed in similar way.

You didn't mention ext4 and f2fs, which is using the Unicode code in
fs/unicode for its case-folding and normalization support.  Ext4 and
f2fs only supports utf-8, so using the NLS API would have added no
value --- and it as you pointed out, the NLS API doesn't support
variable length encoding anyway.  In contrast the fs/unicode functions
have support for full Unicode case folding and normalization, and
currently has the latest Unicode 12.1 tables (released May 2019).

What I'd suggest is to create a new API, enhancing the functions in
fs/unicode, to support those file systems that need to deal with
UTF-16 and UTF-32 for their on-disk directory format, and that we
assume that for the most part, userspace *will* be using a UTF-8
encoding for the user<->kernel interface.  We can keep the existing
NLS interface and mount options for legacy support, but in my opinion
it's not worth the effort to try to do anything else.

					- Ted
