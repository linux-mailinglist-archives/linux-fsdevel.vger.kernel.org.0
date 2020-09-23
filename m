Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65B53275710
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Sep 2020 13:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbgIWLTE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Sep 2020 07:19:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:42072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726669AbgIWLTD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Sep 2020 07:19:03 -0400
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F29D8205F4;
        Wed, 23 Sep 2020 11:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600859943;
        bh=s7KZlKW570YDukapLdA9Wt51ipQNLRtgJmRlNjzRr80=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=S+bgCkwx13YIxJWEFMXiSyWmhfWKdJC1CPdvGdhKDixRF4orYecNrobhqHF0XAxs9
         qAoxwCvTkuDjtgr0FIpF5dNacigxkE/5fY05jpDpel1z0hhCIUMSdK27Wy5/pSvudK
         p5DARIQ7kziOXE+l8wqWDTJtivGRuF36WueEbJB4=
Message-ID: <6a630729889a962746a28d33e92bc7320ebfd02b.camel@kernel.org>
Subject: Re: [RFC PATCH v3 01/16] vfs: export new_inode_pseudo
From:   Jeff Layton <jlayton@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     ceph-devel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Date:   Wed, 23 Sep 2020 07:19:01 -0400
In-Reply-To: <20200923034134.GE3421308@ZenIV.linux.org.uk>
References: <20200914191707.380444-1-jlayton@kernel.org>
         <20200914191707.380444-2-jlayton@kernel.org>
         <20200923034134.GE3421308@ZenIV.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2020-09-23 at 04:41 +0100, Al Viro wrote:
> On Mon, Sep 14, 2020 at 03:16:52PM -0400, Jeff Layton wrote:
> > Ceph needs to be able to allocate inodes ahead of a create that might
> > involve a fscrypt-encrypted inode. new_inode() almost fits the bill,
> > but it puts the inode on the sb->s_inodes list and when we go to hash
> > it, that might be done again.
> > 
> > We could work around that by setting I_CREATING on the new inode, but
> > that causes ilookup5 to return -ESTALE if something tries to find it
> > before I_NEW is cleared. To work around all of this, just use
> > new_inode_pseudo which doesn't add it to the list.
> 
> Er...  Why would you _not_ want -ESTALE in that situation?

I'm hashing the new inode just before sending the create request to the
MDS. When the reply comes in, the client then searches for that inode in
the hash. If I_NEW has been cleared in the meantime -- no problem. If
not, then we want the task handling the reply to wait until it is (and
not get back an -ESTALE).
-- 
Jeff Layton <jlayton@kernel.org>

