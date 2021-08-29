Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABA6C3FAEAF
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Aug 2021 23:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233212AbhH2VY0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 29 Aug 2021 17:24:26 -0400
Received: from zeniv-ca.linux.org.uk ([142.44.231.140]:54770 "EHLO
        zeniv-ca.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231800AbhH2VYZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 29 Aug 2021 17:24:25 -0400
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mKSH3-00H8Og-O6; Sun, 29 Aug 2021 21:23:29 +0000
Date:   Sun, 29 Aug 2021 21:23:29 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     "Caleb D.S. Brzezinski" <calebdsb@protonmail.com>
Cc:     hirofumi@mail.parknet.co.jp, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/3] fat: add the msdos_format_name() filename cache
Message-ID: <YSv60c2/PM4zfl0u@zeniv-ca.linux.org.uk>
References: <20210829142459.56081-1-calebdsb@protonmail.com>
 <20210829142459.56081-3-calebdsb@protonmail.com>
 <YSujmt9vman41ecj@zeniv-ca.linux.org.uk>
 <87o89gw4yy.fsf@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o89gw4yy.fsf@protonmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Aug 29, 2021 at 05:11:56PM +0000, Caleb D.S. Brzezinski wrote:

> My understanding was that the maximum length of the name considered when
> passed to msdos_format_name() was eight characters; see:
> 
> 		while (walk - res < 8)
> 
> and
> 
> 		for (walk = res; len && walk - res < 8; walk++) {

Err...  You have noticed that the function does not end on that loop,
haven't you?  Exercise: figure out what that function does.  I.e.
what inputs are allowed and what outputs are produced.  You might
find some description of FAT directory layout to be useful...

> > 	* your find_fname_in_cache() assumes that hash collisions
> > are impossible, which is... unlikely, considering the nature of
> > that hash function
> 
> If the names are 8 character limited, then logically any name with the
> exact same set of characters would "collide" into the same formatted
> name.

Huh?  Collision is when two *different* values of argument yield the
same result.  What makes you assume that yours won't have any such
pairs shorter than 8 bytes?
