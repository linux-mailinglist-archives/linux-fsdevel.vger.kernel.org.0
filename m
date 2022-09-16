Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BAC95BA6F9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Sep 2022 08:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbiIPGtr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Sep 2022 02:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbiIPGtp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Sep 2022 02:49:45 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D5F1167DA
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Sep 2022 23:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HBkv3q9W3SB4nWDoE98s2+htLZxl8iPB1/3iiGGUWmQ=; b=TJ9AVCYKBmeZsKHXwKWZcSIWQ2
        Ayf55N86gu/AYYn324Qmwrg9HB6sS6yzYEg/9LqKhXCFsRzFCyvEmV8Gry54dQ85U2J2Q7hsu6/oy
        yqaQO8avZ7ZTGc9rrAEEGEhrwkSU6euBmzTWuKsoc0u9uLDGyR39mY4vB931AXv52mLkbbtrF5iKR
        l5sveMyCrXF6AJ3ttPjmM1N6XHOiqielK2nUxo9nu9fDRzUcgGz/Nv9KakwW7l2pXteMDlcEC/wix
        9cU4vgMAPCOFcfZJ9py0DOwXF/xeR66yHBTM+CI1j+vxio2K4h2lbhVsTfPLeJq9Sm5+Z4aoVIyL/
        FDyI1bMA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1oZ5AQ-00GzQr-2R;
        Fri, 16 Sep 2022 06:49:38 +0000
Date:   Fri, 16 Sep 2022 07:49:38 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     NeilBrown <neilb@suse.de>, Miklos Szeredi <mszeredi@redhat.com>,
        Xavier Roche <xavier.roche@algolia.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC] VFS: lock source directory for link to avoid rename
 race.
Message-ID: <YyQcgqVUT89LL7M8@ZenIV>
References: <20220221082002.508392-1-mszeredi@redhat.com>
 <166304411168.30452.12018495245762529070@noble.neil.brown.name>
 <YyATCgxi9Ovi8mYv@ZenIV>
 <166311315747.20483.5039023553379547679@noble.neil.brown.name>
 <YyEcqxthoso9SGI2@ZenIV>
 <166330881189.15759.13499931397891560275@noble.neil.brown.name>
 <CAJfpeguwtADz8D1eUp4JVY-7-WKcf8giiiyvvdv4jccGtxcJKw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpeguwtADz8D1eUp4JVY-7-WKcf8giiiyvvdv4jccGtxcJKw@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 16, 2022 at 08:28:06AM +0200, Miklos Szeredi wrote:

> This will break AT_SYMLINK_FOLLOW.

Right you are.

> And yes, we can add all the lookup logic to do_linkat() at which point
> it will about 10x more complex than it was.

Especially since you can't reject an apparent cross-fs link until you'v
looked the fucker up, since it just might be a symlink to be followed.
Which means it would have to be something like
	find parents
again:
	if on different mounts
		if !follow
			fuck off
		lock old parent
		look the last component up
		if not an existing symlink
			fuck off
		unlock the parent and try to follow that symlink
		goto again
	lock parents
	look the last components up
	if symlink to be followed
		unlock parents
		try to follow symlink
		goto again
	proceed

Not exactly fatal, but...
