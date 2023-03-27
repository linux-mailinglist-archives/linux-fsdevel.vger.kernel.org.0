Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 968786CA512
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Mar 2023 15:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232501AbjC0NCd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Mar 2023 09:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232463AbjC0NCc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Mar 2023 09:02:32 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF32C18F
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Mar 2023 06:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dVLZf+2qY3B1uICtLK+cTDWDUwXZBRLD5NfzpvzIhLo=; b=ofcIEaJ3dgUa+mvGEVmuEwYu1R
        iN6MOSMtYX+SXj0Na2S4PXl2zb6EciyAPyDc7SXs0AU0lsKLgOZGSiqIrySciuqaR+P+X0qRk+h6z
        NCELEL+Urv9k3TlA9JH4JvM2dDlKxy35mMiwWPG/WEQrutuTUFT6LdnPSqjH/AE8bg+hJ50AczSf5
        QdHbTZPjae4AbCUR4rq9y9EM7EfCL8xF2xYb3xq4OcBRp8OMxrI7gXWC0WIopN54XSF1n/ZMmQw4e
        NX5u9V/OMz6Mh+FsDFrUVZJBtC/Rie5gtRFMBl33802ZfzPburHmBzz8vA8q0GA2CAgFITkPSNeEu
        ytn+bOrA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pgmU9-002ROc-1Q;
        Mon, 27 Mar 2023 13:02:05 +0000
Date:   Mon, 27 Mar 2023 14:02:05 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Christoph Hellwig <hch@lst.de>,
        syzbot <syzbot+69b40dc5fd40f32c199f@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com,
        Andrew Morton <akpm@linux-foundation.org>, hch@infradead.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Chen Zhongjin <chenzhongjin@huawei.com>,
        Dave Chinner <dchinner@redhat.com>,
        Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH] sysv: convert pointers_lock from rw_lock to rw_sem
Message-ID: <20230327130205.GG3390869@ZenIV>
References: <0000000000000ccf9a05ee84f5b0@google.com>
 <6fcbdc89-6aff-064b-a040-0966152856e0@I-love.SAKURA.ne.jp>
 <20230327000440.GF3390869@ZenIV>
 <6bfca9e9-d4d8-37ec-d53c-0c77e7c70e85@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6bfca9e9-d4d8-37ec-d53c-0c77e7c70e85@I-love.SAKURA.ne.jp>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 27, 2023 at 07:19:47PM +0900, Tetsuo Handa wrote:

> I feel worried about
> 
> 	/*
> 	 * Indirect block might be removed by truncate while we were
> 	 * reading it. Handling of that case (forget what we've got and
> 	 * reread) is taken out of the main path.
> 	 */
> 	if (err == -EAGAIN)
> 		goto changed;
> 
> in get_block()...

Look at the caller of find_shared(); there won't be other truncate messing
up with the indirect blocks.  sysv_truncate() is called by sysv_write_failed()
(from ->write_begin()), sysv_setattr() (->setattr(), with ATTR_SIZE) and
sysv_evict_inode() (if there's no links left to on-disk inode; it's an
->evict_inode() instance, so we are dropping the last reference to in-core one).

The first two have i_mutex held by callers, serializing them against each
other, and both have the in-core inode pinned, which gives exclusion with
the third one...

IOW, sysv_truncate() (as well as its minixfs counterpart) relies upon having
serialization wrt other callers of sysv_truncate().
