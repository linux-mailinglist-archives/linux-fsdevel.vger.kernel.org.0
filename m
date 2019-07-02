Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1B395D8BB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2019 02:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbfGCA1m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Jul 2019 20:27:42 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:32964 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726150AbfGCA1l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Jul 2019 20:27:41 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-109.corp.google.com [104.133.0.109] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x62KdcNs032445
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 2 Jul 2019 16:39:39 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 0057042002E; Tue,  2 Jul 2019 16:39:37 -0400 (EDT)
Date:   Tue, 2 Jul 2019 16:39:37 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Parisc List <linux-parisc@vger.kernel.org>
Subject: Re: [BUG] mke2fs produces corrupt filesystem if badblock list
 contains a block under 251
Message-ID: <20190702203937.GG3032@mit.edu>
References: <1562021070.2762.36.camel@HansenPartnership.com>
 <20190702002355.GB3315@mit.edu>
 <1562028814.2762.50.camel@HansenPartnership.com>
 <20190702173301.GA3032@mit.edu>
 <1562095894.3321.52.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1562095894.3321.52.camel@HansenPartnership.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 02, 2019 at 12:31:34PM -0700, James Bottomley wrote:
> Actually, this is giving me:
> 
> mke2fs: Operation not supported for inodes containing extents while
> creating huge files
> 
> Is that because it's an ext4 only feature?

That'll teach me not to send out a sequence like that without testing
it myself first.  :-)

Yeah, because one of the requirements was to make the file contiguous,
without any intervening indirect block or extent tree blocks, the
creation of the file is done manually, and at the time, I only
implemented it for extents, since the original goal of the goal was to
create really big files (hence the name of the feature "mk_hugefile"),
and using indirect blocks would be a huge waste of disk space.

It wouldn't be that hard for me to add support for indirect block
maps, or if you were going to convert things over so that the pa_risc
2nd stage boot loader can understand how to read from extents, that'll
allow this to work as well.

					- Ted
