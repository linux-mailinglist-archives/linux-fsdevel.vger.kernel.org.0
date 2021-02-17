Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70C5931DCEA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Feb 2021 17:09:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233983AbhBQQJD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Feb 2021 11:09:03 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:38719 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S233894AbhBQQJC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Feb 2021 11:09:02 -0500
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 11HG86UW020779
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Feb 2021 11:08:06 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 0CF1F15C39E1; Wed, 17 Feb 2021 11:08:06 -0500 (EST)
Date:   Wed, 17 Feb 2021 11:08:06 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Daniel Rosenberg <drosen@google.com>
Cc:     Andreas Dilger <adilger@dilger.ca>,
        Eric Biggers <ebiggers@kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel-team@android.com, Paul Lawrence <paullawrence@google.com>
Subject: Re: [PATCH 1/2] ext4: Handle casefolding with encryption
Message-ID: <YC0/ZsQbKntSpl97@mit.edu>
References: <20210203090745.4103054-2-drosen@google.com>
 <56BC7E2D-A303-45AE-93B6-D8921189F604@dilger.ca>
 <YBrP4NXAsvveIpwA@mit.edu>
 <YCMZSjgUDtxaVem3@mit.edu>
 <42511E9D-3786-4E70-B6BE-D7CB8F524912@dilger.ca>
 <YCNbIdCsAsNcPuAL@mit.edu>
 <CA+PiJmT2hfdRLztCdp3-tYBqAo+-ibmuyqLvq5nb+asFj4vL7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+PiJmT2hfdRLztCdp3-tYBqAo+-ibmuyqLvq5nb+asFj4vL7A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 16, 2021 at 08:01:11PM -0800, Daniel Rosenberg wrote:
> I'm not sure what the conflict is, at least format-wise. Naturally,
> there would need to be some work to reconcile the two patches, but my
> patch only alters the format for directories which are encrypted and
> casefolded, which always must have the additional hash field. In the
> case of dirdata along with encryption and casefolding, couldn't we
> have the dirdata simply follow after the existing data? Since we
> always already know the length, it'd be unambiguous where that would
> start. Casefolding can only be altered on an empty directory, and you
> can only enable encryption for an empty directory, so I'm not too
> concerned there. I feel like having it swapping between the different
> methods makes it more prone to bugs, although it would be doable. I've
> started rebasing the dirdata patch on my end to see how easy it is to
> mix the two. At a glance, they touch a lot of the same areas in
> similar ways, so it shouldn't be too hard. It's more of a question of
> which way we want to resolve that, and which patch goes first.
> 
> I've been trying to figure out how many devices in the field are using
> casefolded encryption, but haven't found out yet. The code is
> definitely available though, so I would not be surprised if it's being
> used, or is about to be.

The problem is in how the space after the filename in a directory is
encoded.  The dirdata format is (mildly) expandable, supporting up to
4 different metadata chunks after the filename, using a very
compatctly encoded TLV (or moral equivalent) scheme.  For directory
inodes that have both the encyption and compression flags set, we have
a single blob which gets used as the IV for the crypto.

So it's the difference between a simple blob that is only used for one
thing in this particular case, and something which is the moral
equivalent of simple ASN.1 or protobuf encoding.

Currently, datadata has defined uses for 2 of the 4 "chunks", which is
used in Lustre servers.  The proposal which Andreas has suggested is
if the dirdata feature is supported, then the 3rd dirdata chunk would
be used for the case where we currently used by the
encrypted-casefolded extension, and the 4th would get reserved for a
to-be-defined extension mechanism.

If there ext4 encrypted/casefold is not yet in use, and we can get the
changes out to all potential users before they release products out
into the field, then one approach would be to only support
encrypted/casefold when dirdata is also enabled.

If ext4 encrypted/casefold is in use, my suggestion is that we support
both encrypted/casefold && !dirdata as you have currently implemented
it, and encrypted/casefold && dirdata as Andreas has proposed.

IIRC, supporting that Andreas's scheme essentially means that we use
the top four bits in the rec_len field to indicate which chunks are
present, and then for each chunk which is present, there is a 1 byte
length followed by payload.  So that means in the case where it's
encrypted/casefold && dirdata, the required storage of the directory
entry would take one additional byte, plus setting a bit indicating
that the encrypted/casefold dirdata chunk was present.

So, no, they aren't incompatible ultimatly, but it might require a
tiny bit more work to integrate the combined support for dirdata plus
encrypted/casefold.  One way we can do this, if we have to support the
current encrypted/casefold format because it's out there in deployed
implementations already, is to integrate encrypted/casefold &&
!dirdata first upstream, and then when we integrate dirdata into
upstream, we'll have to add support for the encrypted/casefold &&
dirdata case.  This means that we'll have two variants of the on-disk
format to test and support, but I don't think it's the going to be
that difficult.

Andreas, anything you'd like to correct or add in this summary?

	 	  	     		- Ted
