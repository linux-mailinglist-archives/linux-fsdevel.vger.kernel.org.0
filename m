Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6285321488C
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Jul 2020 22:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbgGDUMV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 4 Jul 2020 16:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726909AbgGDUMV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 4 Jul 2020 16:12:21 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EF3DC061794;
        Sat,  4 Jul 2020 13:12:21 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jroW6-005OXK-Sw; Sat, 04 Jul 2020 20:12:07 +0000
Date:   Sat, 4 Jul 2020 21:12:06 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>, shuah@kernel.org,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-man <linux-man@vger.kernel.org>,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 1/3] readfile: implement readfile syscall
Message-ID: <20200704201206.GD2786714@ZenIV.linux.org.uk>
References: <20200704140250.423345-1-gregkh@linuxfoundation.org>
 <20200704140250.423345-2-gregkh@linuxfoundation.org>
 <CAJfpegusi8BjWFzEi05926d4RsEQvPnRW-w7My=ibBHQ8NgCuw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegusi8BjWFzEi05926d4RsEQvPnRW-w7My=ibBHQ8NgCuw@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jul 04, 2020 at 09:41:09PM +0200, Miklos Szeredi wrote:
> And "If the size of file is smaller than the value provided in count
> then the whole file will be copied into buf", which is simply a lie;
> for example seq_file will happily return a smaller-than-PAGE_SIZE
> chunk if at least one record fits in there.  You'll have a very hard
> time explaining that in the man page.  So I think there are two
> possible ways forward:
> 
>  1) just leave the first explanation (it's an open + read + close
> equivalent) and leave out the rest
> 
>  2) add a loop around the vfs_read() in the code.

3) don't bother with the entire thing, until somebody manages to demonstrate
a setup where it does make a real difference (compared to than the obvious
sequence of syscalls, that is).  At which point we'll need to figure out
what's going on and deal with the underlying problem of that setup.
