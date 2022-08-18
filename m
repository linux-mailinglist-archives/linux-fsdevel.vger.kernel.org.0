Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF03A597A8B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Aug 2022 02:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238746AbiHRAUF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Aug 2022 20:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231510AbiHRAUE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Aug 2022 20:20:04 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABC589C8EE;
        Wed, 17 Aug 2022 17:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2MkofC8d460Q9BOo8AHOV9Xfax9fU/PqKTvvaPWF3sE=; b=hedjIECppsjGyE2T/AXucHvO4S
        pW93gpK0/OREYpGiwjBA/egtvp0QvDl3qwpIuBU++PDWncuxeh0Q4vROEbFtH5VTo4IfaRbo3xcrP
        r5ZIfMqnlT8Hl3VFsQ77OrEuIFG2THQFfEEhvsUqytvKEMccw7nUZjlphrZQkQ9sMQoROStJOJmcS
        KEWfWSVAi8iOk0HW9BZDXE/rEOhLSvvqirNW2WngJVbSKB79Eju06qu1iFxCdcOOOvIYjpoxejObZ
        AFB23Rg+a4fzLl5QZvGr9XdF4LAAm2g36T7v+vucS7ZYSrCBfnO82aJ+Rm0w0TVipVrrslrQv75j4
        jUwnfrmA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oOTGS-005XLQ-Kz;
        Thu, 18 Aug 2022 00:20:00 +0000
Date:   Thu, 18 Aug 2022 01:20:00 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Olga Kornievskaia <aglo@umich.edu>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>,
        Olga Kornievskaia <kolga@netapp.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC] problems with alloc_file_pseudo() use in __nfs42_ssc_open()
Message-ID: <Yv2FsIu8LEO0dh2B@ZenIV>
References: <Yv1jwsHVWI+lguAT@ZenIV>
 <CAN-5tyFvV7QOxyAQXu3UM5swQVB2roDpQ5CBRVc64Epp1gj9hg@mail.gmail.com>
 <Yv2BVKuzZdMDY2Td@ZenIV>
 <CAN-5tyF0ZMX8a6M6Qbbco3EmOzwVnnGZmqak8=t4Cvtzc45g7Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAN-5tyF0ZMX8a6M6Qbbco3EmOzwVnnGZmqak8=t4Cvtzc45g7Q@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 17, 2022 at 08:12:27PM -0400, Olga Kornievskaia wrote:
> On Wed, Aug 17, 2022 at 8:01 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > On Wed, Aug 17, 2022 at 06:32:15PM -0400, Olga Kornievskaia wrote:
> > > On Wed, Aug 17, 2022 at 6:18 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> > > >
> > > >         My apologies for having missed that back when the SSC
> > > > patchset had been done (and missing the problems after it got
> > > > merged, actually).
> > > >
> > > > 1) if this
> > > >         r_ino = nfs_fhget(ss_mnt->mnt_sb, src_fh, fattr);
> > > > in __nfs42_ssc_open() yields a directory inode, we are screwed
> > > > as soon as it's passed to alloc_file_pseudo() - a *lot* of places
> > > > in dcache handling would break if we do that.  It's not too
> > > > nice for a regular file from non-cooperating filesystem, but for
> > > > directory ones it's deadly.
> > >
> > > This inode is created to make an appearance of an opened file to do
> > > (an NFS) read, it's never a directory.
> >
> > Er...  Where does the fhandle come from?  From my reading it's a client-sent
> > data; I don't know what trust model do you assume, but the price of
> > getting multiple dentries over the same directory inode is high.
> > Bogus or compromised client should not be able to cause severe corruption
> > of kernel data structures...
> 
> This is an NFS spec specified operation. The (source file's)
> filehandle comes from the COPY operation compound that the destination
> server gets and then uses -- creates an inode from using the code you
> are looking at now -- to access from the source server. Security is
> all described in the spec. The uniqueness of the filehandle is
> provided by the source server that created it.

Do we assume that compromise of source server is escalatable at least
to kernel panics on the destination server anyway?  Confused...
