Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7065455EB87
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jun 2022 19:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233556AbiF1R5g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jun 2022 13:57:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233538AbiF1R5d (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jun 2022 13:57:33 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B18BD6449;
        Tue, 28 Jun 2022 10:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Vjg9D6mYYFJGeU1AQjii4m5nzMNHpeZUnrBbDeaKDr4=; b=HA6Z1Qt57wuYGUSB9XJkb+MXDk
        QrX0xxYw7itX6Ii6Q0EXoAKY+2SThF/RndC3vzQ1xu2cF24+vsRNEGzQJNEelYhR+IEz9HozaNcX6
        IJ3UUOCvurJJu7+M629WgZWW/5opgNM8j2oxBnQuWxggrstkNVeli9uRjfdocutzhGbRM9bgsh1Fe
        Ef2TySNknnxpMP41cKM7R+y3cpbUlD/1WkrXXEijlD5nah2BcZI3oeWlzjmpNz6jyubXW0pFHH5YF
        Qj4muANOfx3YbKJ+oHQjbtP66u09ckRTh1pGmj7QKRyOD3TQZiPZ7ZIWTKbFZG1bImSYmdCdxVadQ
        Rrw4V5Zg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1o6FSl-005hVo-OV;
        Tue, 28 Jun 2022 17:57:23 +0000
Date:   Tue, 28 Jun 2022 18:57:23 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Ian Kent <raven@themaw.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Siddhesh Poyarekar <siddhesh@gotplt.org>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Carlos Maiolino <cmaiolino@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] vfs: escape hash as well
Message-ID: <YrtBA8fiE+if1r5i@ZenIV>
References: <165637619182.37717.17755020386697900473.stgit@donald.themaw.net>
 <165637625806.37717.2027157232247047949.stgit@donald.themaw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <165637625806.37717.2027157232247047949.stgit@donald.themaw.net>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 28, 2022 at 08:30:58AM +0800, Ian Kent wrote:
> From: Siddhesh Poyarekar <siddhesh@gotplt.org>
> 
> When a filesystem is mounted with a name that starts with a #:
> 
>  # mount '#name' /mnt/bad -t tmpfs
> 
> this will cause the entry to look like this (leading space added so
> that git does not strip it out):
> 
>  #name /mnt/bad tmpfs rw,seclabel,relatime,inode64 0 0
> 
> This breaks getmntent and any code that aims to parse fstab as well as
> /proc/mounts with the same logic since they need to strip leading spaces
> or skip over comment lines, due to which they report incorrect output or
> skip over the line respectively.
> 
> Solve this by translating the hash character into its octal encoding
> equivalent so that applications can decode the name correctly.
> 
> Signed-off-by: Siddhesh Poyarekar <siddhesh@gotplt.org>
> Signed-off-by: Ian Kent <raven@themaw.net>

ACK; I'll grab that one (in #work.misc - I don't believe it's #fixes
fodder).
