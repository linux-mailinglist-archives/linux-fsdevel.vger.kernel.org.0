Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D560597A74
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Aug 2022 02:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242278AbiHRABa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Aug 2022 20:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242275AbiHRAB1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Aug 2022 20:01:27 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39D78979F0;
        Wed, 17 Aug 2022 17:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=weSEynBDXhIM0E6Muk7SHAMx0Zr8QIPwnPSVCXZYwi0=; b=bZsk9YlO1Dkeoq/LDchmPuISqE
        dJs6h4PAbG8MZfGQQtD1+jLfB31ZCP0Ktzj92Kr/NiazuKpLWw9BgANGz2wERj2/jmYhxsn1vjSe/
        AHcIfehiKeONSIupgUdvczekJxVoCgUjq6hMQhWVV2SlSX10dClE8gHkaMxWFp0UmUthV55AhA3UO
        6wzccH7H6277HGUhncZCdN/aePq/1P03eGkd6x5nM0sqgcBu2gh8c/Q4pb1lgPCDRWxCr5pF2xkd4
        vK29bSkHKfNmP3Szt4cNj9JOmM0DzLI0gB5ZKsVye5lxPm4m+eYiAqhOyAQoHALfkHE37keBuKUsq
        0SEyHLbg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oOSyS-005XAV-Pv;
        Thu, 18 Aug 2022 00:01:25 +0000
Date:   Thu, 18 Aug 2022 01:01:24 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Olga Kornievskaia <aglo@umich.edu>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>,
        Olga Kornievskaia <kolga@netapp.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC] problems with alloc_file_pseudo() use in __nfs42_ssc_open()
Message-ID: <Yv2BVKuzZdMDY2Td@ZenIV>
References: <Yv1jwsHVWI+lguAT@ZenIV>
 <CAN-5tyFvV7QOxyAQXu3UM5swQVB2roDpQ5CBRVc64Epp1gj9hg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAN-5tyFvV7QOxyAQXu3UM5swQVB2roDpQ5CBRVc64Epp1gj9hg@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 17, 2022 at 06:32:15PM -0400, Olga Kornievskaia wrote:
> On Wed, Aug 17, 2022 at 6:18 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> >         My apologies for having missed that back when the SSC
> > patchset had been done (and missing the problems after it got
> > merged, actually).
> >
> > 1) if this
> >         r_ino = nfs_fhget(ss_mnt->mnt_sb, src_fh, fattr);
> > in __nfs42_ssc_open() yields a directory inode, we are screwed
> > as soon as it's passed to alloc_file_pseudo() - a *lot* of places
> > in dcache handling would break if we do that.  It's not too
> > nice for a regular file from non-cooperating filesystem, but for
> > directory ones it's deadly.
> 
> This inode is created to make an appearance of an opened file to do
> (an NFS) read, it's never a directory.

Er...  Where does the fhandle come from?  From my reading it's a client-sent
data; I don't know what trust model do you assume, but the price of
getting multiple dentries over the same directory inode is high.
Bogus or compromised client should not be able to cause severe corruption
of kernel data structures...
