Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A45C968EC6E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Feb 2023 11:11:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbjBHKLN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Feb 2023 05:11:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230443AbjBHKLL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Feb 2023 05:11:11 -0500
Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A3B842CFFB;
        Wed,  8 Feb 2023 02:11:03 -0800 (PST)
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
        by mail.parknet.co.jp (Postfix) with ESMTPSA id AA2422055F9C;
        Wed,  8 Feb 2023 19:11:02 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
        by ibmpc.myhome.or.jp (8.17.1.9/8.17.1.9/Debian-2) with ESMTPS id 318AB0tG072967
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Wed, 8 Feb 2023 19:11:01 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
        by devron.myhome.or.jp (8.17.1.9/8.17.1.9/Debian-2) with ESMTPS id 318AB0ol317789
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Wed, 8 Feb 2023 19:11:00 +0900
Received: (from hirofumi@localhost)
        by devron.myhome.or.jp (8.17.1.9/8.17.1.9/Submit) id 318AAvG8317788;
        Wed, 8 Feb 2023 19:10:57 +0900
From:   OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net, linux-cifs@vger.kernel.org,
        jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.cz>, "Theodore Y . Ts'o" <tytso@mit.edu>,
        Anton Altaparmakov <anton@tuxera.com>,
        Luis de Bethencourt <luisbg@kernel.org>,
        Salah Triki <salah.triki@gmail.com>,
        Steve French <sfrench@samba.org>, Paulo Alcantara <pc@cjr.nz>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Tom Talpey <tom@talpey.com>, Dave Kleikamp <shaggy@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pavel Machek <pavel@ucw.cz>,
        Christoph Hellwig <hch@infradead.org>,
        Kari Argillander <kari.argillander@gmail.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>
Subject: Re: [RFC PATCH v2 01/18] fat: Fix iocharset=utf8 mount option
In-Reply-To: <20230204105703.pnc6vcy4hvmvvm3b@pali> ("Pali
 =?iso-8859-1?Q?Roh=E1r=22's?= message of
        "Sat, 4 Feb 2023 11:57:03 +0100")
References: <20221226142150.13324-1-pali@kernel.org>
        <20221226142150.13324-2-pali@kernel.org>
        <874jsyvje6.fsf@mail.parknet.co.jp>
        <20230204105703.pnc6vcy4hvmvvm3b@pali>
Date:   Wed, 08 Feb 2023 19:10:57 +0900
Message-ID: <874jrwfowe.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Pali Rohár <pali@kernel.org> writes:

>> This patch fixes the issue of utf-8 partially only. I think we can't
>> still recommend only partially working one.
>
> With this patch FAT_DEFAULT_IOCHARSET=utf8 is same what was
> FAT_DEFAULT_UTF8=y without this patch. And option FAT_DEFAULT_UTF8 was
> recommended in description before "select the next option instead if you
> would like to use UTF-8 encoded file names by default."

It is not recommending to use UTF-8 as default, right? I wanted to say
no warning and recommend has big difference, and I can't recommend the
incompatible behavior that creates the case sensitive filename.

>> Still broken, so I think we still need the warning here (would be
>> tweaked warning).
>
> There was no warning before for utf8=1. And with this patch
> iocharset=utf8 should have same behavior as what was utf8=1 before this
> patch.
>
> So if we should show some warning for utf8=1 then it is somehow not
> related to this patch and it should be done separately, possible also to
> the current codebase and before this patch.

Sure, you are right.

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
