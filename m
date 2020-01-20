Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6162514224B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2020 05:04:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729159AbgATEEr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Jan 2020 23:04:47 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:52422 "EHLO
        mail.parknet.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729043AbgATEEr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Jan 2020 23:04:47 -0500
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
        by mail.parknet.co.jp (Postfix) with ESMTPSA id 1A51C15CBE2;
        Mon, 20 Jan 2020 13:04:46 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
        by ibmpc.myhome.or.jp (8.15.2/8.15.2/Debian-16) with ESMTPS id 00K44iO0024750
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Mon, 20 Jan 2020 13:04:45 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
        by devron.myhome.or.jp (8.15.2/8.15.2/Debian-16) with ESMTPS id 00K44iPi116585
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Mon, 20 Jan 2020 13:04:44 +0900
Received: (from hirofumi@localhost)
        by devron.myhome.or.jp (8.15.2/8.15.2/Submit) id 00K44gCT116584;
        Mon, 20 Jan 2020 13:04:42 +0900
From:   OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Namjae Jeon <linkinjeon@gmail.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: Re: vfat: Broken case-insensitive support for UTF-8
References: <20200119221455.bac7dc55g56q2l4r@pali>
Date:   Mon, 20 Jan 2020 13:04:42 +0900
In-Reply-To: <20200119221455.bac7dc55g56q2l4r@pali> ("Pali
 =?iso-8859-1?Q?Roh=E1r=22's?= message of
        "Sun, 19 Jan 2020 23:14:55 +0100")
Message-ID: <87sgkan57p.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Pali Rohár <pali.rohar@gmail.com> writes:

> Which means that fat_name_match(), vfat_hashi() and vfat_cmpi() are
> broken for vfat in UTF-8 mode.

Right. It is a known issue.

> I was thinking how to fix it, and the only possible way is to write a
> uni_tolower() function which takes one Unicode code point and returns
> lowercase of input's Unicode code point. We cannot do any Unicode
> normalization as VFAT specification does not say anything about it and
> MS reference fastfat.sys implementation does not do it neither.
>
> So, what would be the best option for implementing that function?
>
>   unicode_t uni_tolower(unicode_t u);
>
> Could a new fs/unicode code help with it? Or it is too tied with NFD
> normalization and therefore cannot be easily used or extended?

To be perfect, the table would have to emulate what Windows use. It can
be unicode standard, or something other. And other fs can use different
what Windows use.

So the table would have to be switchable in perfect world (if there is
no consensus to use 1 table).  If we use switchable table, I think it
would be better to put in userspace, and loadable like firmware data.

Well, so then it would not be simple work (especially, to be perfect).


Also, not directly same issue though. There is related issue for
case-insensitive. Even if we use some sort of internal wide char
(e.g. in nls, 16bits), dcache is holding name in user's encode
(e.g. utf8). So inefficient to convert cached name to wide char for each
access.

Relatively recent EXT4 case-insensitive may tackled this though, I'm not
checking it yet.

> New exfat code which is under review and hopefully would be merged,
> contains own unicode upcase table (as defined by exfat specification) so
> as exfat is similar to FAT32, maybe reusing it would be a better option?

exfat just put a case conversion table in fs. So I don't think it helps
fatfs.

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
