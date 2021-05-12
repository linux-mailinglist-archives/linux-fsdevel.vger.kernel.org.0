Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5845437BE75
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 May 2021 15:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbhELNq4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 May 2021 09:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbhELNqz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 May 2021 09:46:55 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF17BC061574
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 May 2021 06:45:47 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lgpAz-00DvCC-NQ; Wed, 12 May 2021 13:45:25 +0000
Date:   Wed, 12 May 2021 13:45:25 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     David Howells <dhowells@redhat.com>
Cc:     Dominique Martinet <asmadeus@codewreck.org>,
        Luis Henriques <lhenriques@suse.de>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        linux-fsdevel@vger.kernel.org, v9fs-developer@lists.sourceforge.net
Subject: Re: What sort of inode state does ->evict_inode() expect to see?
 [was Re: 9p: fscache duplicate cookie]
Message-ID: <YJvb9S8uxV2X45Cu@zeniv-ca.linux.org.uk>
References: <YJvJWj/CEyEUWeIu@codewreck.org>
 <87tun8z2nd.fsf@suse.de>
 <87czu45gcs.fsf@suse.de>
 <2507722.1620736734@warthog.procyon.org.uk>
 <2882181.1620817453@warthog.procyon.org.uk>
 <87fsysyxh9.fsf@suse.de>
 <2891612.1620824231@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2891612.1620824231@warthog.procyon.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 12, 2021 at 01:57:11PM +0100, David Howells wrote:
> Hi Al,
> 
> We're seeing cases where fscache is reporting cookie collisions that appears
> to be due to ->evict_inode() running parallel with a new inode for the same
> filesystem object getting set up.

Huh?  Details, please.  What we are guaranteed is that iget{,5}_locked() et.al.
on the same object will either prevent the call of ->evict_inode() (if they
manage to grab the sucker before I_FREEING is set) or will wait until after
->evict_inode() returns.
