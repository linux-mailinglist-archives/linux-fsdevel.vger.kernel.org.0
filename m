Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B520A396526
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 May 2021 18:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232683AbhEaQZC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 May 2021 12:25:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:51030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233728AbhEaQWo (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 May 2021 12:22:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 99A6160232;
        Mon, 31 May 2021 16:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622478063;
        bh=dxosx0uiZE6vTh8Ya6hRhelnWIICwcihOzUewBbWULA=;
        h=Date:From:To:Cc:Subject:From;
        b=vAjF7s/qxzQs1X4a56XkumN/elIMkS1TeigSa6Ud0WctaFk7VEVDhdqbspEYVP5Dp
         akuO1r1bXcTdGO8Ued/Czb1gYkcIK8DkpbEAmLGPV9hgw+MIIwNpPDDgnXdYz+tRNE
         f0uMOWsCWQmG+ziORxqls/ekrEJSuDRJxp6EZa4ifJxxKfgbTLkKvo2Qa67m8EQCKI
         3AJ5emzlSZFYnvLkx9PBP8PXh8TIwXNMBOXxdcgT+KV2JxfrJ3azU91xvpu5XTPFsW
         BBq6dkjI+jJ2gY8Ipwn6Jjp/zgmWOydW9e2APGQxv9Go5mLad8He8thVYQdQQZEBZc
         cEDtHxoxO+Zag==
Date:   Tue, 1 Jun 2021 00:20:56 +0800
From:   Gao Xiang <xiang@kernel.org>
To:     linux-erofs@lists.ozlabs.org
Cc:     linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Chao Yu <yuchao0@huawei.com>,
        Li Guifu <bluce.liguifu@huawei.com>,
        Miao Xie <miaoxie@huawei.com>, Fang Wei <fangwei1@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel-team@android.com
Subject: [ANNOUNCE] erofs-utils: release 1.3
Message-ID: <20210531162055.GA18956@hsiangkao-HP-ZHAN-66-Pro-G1>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi folks,

A new version erofs-utils 1.3 is available at:
git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git tags/v1.3

It mainly includes the following changes:
   - support new big pcluster feature together with Linux 5.13+;
   - optimize buffer allocation logic (Hu Weiwen);
   - optimize build performance for large directories (Hu Weiwen);
   - add support to override uid / gid (Hu Weiwen);
   - add support to adjust lz4 history window size (Huang Jianan);
   - add a manual for erofsfuse;
   - add support to limit max decompressed extent size;
   - various bugfixes and cleanups;

One notable update is that it now supports EROFS big pcluster [1][2],
which allows compressing variable-sized data into more than 1 fs block
by using fixed-sized output compression [3]. It can be used for some
(sub)-files with specific data access patterns (such as oneshot data
segments which need better compression ratio and thus better sequential
performance.)

Note that users can write their own per-(sub)files big pcluster
strategies to adjust pclustersize in time according to file type static
analysis or historical tracing data in z_erofs_get_max_pclusterblks().
And default strategies will be developed and built-in laterly in the
future.

btw, I've heard more in-market products shipped with EROFS, for example
OPPO [4] and Coolpad [5] with some public news plus more in-person
contacts from time to time. It's always worth trying and feedback or
contribution is welcomed.

[1] https://www.kernel.org/doc/html/latest/filesystems/erofs.html
[2] https://lore.kernel.org/r/20210407043927.10623-1-xiang@kernel.org 
[3] https://www.usenix.org/system/files/atc19-gao.pdf
[4] https://new.qq.com/omn/20210312/20210312A0D9HT00.html
[5] https://hunchmag.com/helio-g80-erofs-48-mp-arcsoft-and-cool-os-coolpad-cool-2-smartphone-announced/

Thanks,
Gao Xiang
