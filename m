Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6838A31FBE5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Feb 2021 16:23:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbhBSPWj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Feb 2021 10:22:39 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:54553 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229527AbhBSPWh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Feb 2021 10:22:37 -0500
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 11JFLdRM016190
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Feb 2021 10:21:40 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id A22D415C39E2; Fri, 19 Feb 2021 10:21:39 -0500 (EST)
Date:   Fri, 19 Feb 2021 10:21:39 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     Daniel Rosenberg <drosen@google.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel-team@android.com, Paul Lawrence <paullawrence@google.com>
Subject: Re: [PATCH 1/2] ext4: Handle casefolding with encryption
Message-ID: <YC/Xg4I+2ppIQ2gW@mit.edu>
References: <20210203090745.4103054-2-drosen@google.com>
 <56BC7E2D-A303-45AE-93B6-D8921189F604@dilger.ca>
 <YBrP4NXAsvveIpwA@mit.edu>
 <YCMZSjgUDtxaVem3@mit.edu>
 <42511E9D-3786-4E70-B6BE-D7CB8F524912@dilger.ca>
 <YCNbIdCsAsNcPuAL@mit.edu>
 <CA+PiJmT2hfdRLztCdp3-tYBqAo+-ibmuyqLvq5nb+asFj4vL7A@mail.gmail.com>
 <YC0/ZsQbKntSpl97@mit.edu>
 <01918C7B-9D9B-4BD8-8ED1-BA1CBF53CA95@dilger.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01918C7B-9D9B-4BD8-8ED1-BA1CBF53CA95@dilger.ca>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 17, 2021 at 03:48:39PM -0700, Andreas Dilger wrote:
> It would be possible to detect if the encrypted/casefold+dirdata
> variant is in use, because the dirdata variant would have the 0x40
> bit set in the file_type byte.  It isn't possible to positively
> identify the "raw" non-dirdata variant, but the assumption would be
> if (rec_len >= round_up(name_len, 4) + 8) in an encrypted+casefold
> directory that the "raw" hash must be present in the dirent.

Consider a 4k directory directory block which has only three entries,
".", "..", and "a".  The directory entry for "a" will have a rec_len
substantially larger than name_len.

Fortunatelly, the "raw" non-dirdata variant case easily can be
detected.  If the directory has the encryption and casefold set, and
the 0x40 bit is not set, then raw must be present, assuming that the
directory block has not been corrupted (but if it's corrupted, all
bets are off).

	       	       		      	       - Ted
					       
