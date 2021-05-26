Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2D633918A9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 May 2021 15:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233236AbhEZNXH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 May 2021 09:23:07 -0400
Received: from first.geanix.com ([116.203.34.67]:57262 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233424AbhEZNWi (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 May 2021 09:22:38 -0400
Received: from [192.168.64.199] (unknown [185.17.218.86])
        by first.geanix.com (Postfix) with ESMTPSA id 565E446662F;
        Wed, 26 May 2021 13:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1622035261; bh=TJey1MvuTbWiLP/QBgHq+uFXk5+SBvtpN6iiXWFTXl0=;
        h=To:Cc:From:Subject:Date;
        b=I6h3yiLm9bTpBvSUaim/DL1WWOexZCYhO+BYzdlZcoynjS4hSeEVR2rPnx2BIw5Ed
         DqOdM2q4eYvE/UQrQkyJ5XGgLuJF5nQiF+s5faQmbPDFZcLlZU8IWFnyletSuf1lJ+
         3cLIpVerspUGujuVuXcKFWwdkeKYi9bN9Fwd0Hp4r2qwuSkUVcKe5LfdWjJuTvRNxm
         OQPsVezZy5G5FT5sbO6DxoYDzZqDFKy/a/ay6w6CM38FZ+cmcPb6AyNEtYpv6PIhTC
         doPUI/9/gcfZaRgZ/1MMp1Ok6BqBOjV6pUrG0/WzWmP3LZcn2RioX2TtyXMk9Od54Y
         Ab4+mRCOanzDA==
To:     dhowells@redhat.com, viro@zeniv.linux.org.uk
Cc:     phillip@squashfs.org.uk, squashfs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Sean Nyekjaer <sean@geanix.com>
Subject: Squashfs on ubi blockdev
Message-ID: <2d27c68c-4ac8-c0ae-3f95-9b6234a4d31d@geanix.com>
Date:   Wed, 26 May 2021 15:21:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=4.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,URIBL_BLOCKED
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on 93bd6fdb21b5
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

After: 5a2be1288b514 ("vfs: Convert squashfs to use the new mount API")

We see this; when mounting a squashfs from a ubiblockdev:
root@iwg26-v2:/data/root# mount /dev/ubiblock0_6 /mnt

[   39.884295] /dev/ubiblock0_6: Can't open blockdev

But the filesystem is mounted anyway...

I have tried checking the returned error code get_tree_bdev() -> blkdev_get_by_path() returns -EROFS.

I have also tried to see what happens in squashfs_get_tree() it will be re-run with the ro option set.
Which explains why the filesystem ends up mouted.
[   39.889461] ####Custom debug: squashfs_get_tree -30


[   39.906309] ####Custom debug: squashfs_get_tree 0


Fair enough it's after all a squashfs :)

But could the error message be better? Or just filter out the print when getting a EROFS?

Br,
/Sean
