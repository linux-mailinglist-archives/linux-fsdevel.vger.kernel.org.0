Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 005BA10F8EC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2019 08:37:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727598AbfLCHgk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Dec 2019 02:36:40 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:2525 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727444AbfLCHgj (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Dec 2019 02:36:39 -0500
Received: from DGGEMM406-HUB.china.huawei.com (unknown [172.30.72.56])
        by Forcepoint Email with ESMTP id 7819FD447DA005F45EFD;
        Tue,  3 Dec 2019 15:36:36 +0800 (CST)
Received: from dggeme762-chm.china.huawei.com (10.3.19.108) by
 DGGEMM406-HUB.china.huawei.com (10.3.20.214) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 3 Dec 2019 15:36:36 +0800
Received: from architecture4 (10.160.196.180) by
 dggeme762-chm.china.huawei.com (10.3.19.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Tue, 3 Dec 2019 15:36:35 +0800
Date:   Tue, 3 Dec 2019 15:41:54 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Daniel Rosenberg <drosen@google.com>
CC:     Theodore Ts'o <tytso@mit.edu>, <linux-ext4@vger.kernel.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        Eric Biggers <ebiggers@kernel.org>,
        <linux-fscrypt@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jonathan Corbet <corbet@lwn.net>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        <kernel-team@android.com>
Subject: Re: [PATCH 4/8] vfs: Fold casefolding into vfs
Message-ID: <20191203074154.GA216261@architecture4>
References: <20191203051049.44573-1-drosen@google.com>
 <20191203051049.44573-5-drosen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20191203051049.44573-5-drosen@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.160.196.180]
X-ClientProxiedBy: dggeme719-chm.china.huawei.com (10.1.199.115) To
 dggeme762-chm.china.huawei.com (10.3.19.108)
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 02, 2019 at 09:10:45PM -0800, Daniel Rosenberg wrote:
> Ext4 and F2fs are both using casefolding, and they, along with any other
> filesystem that adds the feature, will be using identical dentry_ops.
> Additionally, those dentry ops interfere with the dentry_ops required
> for fscrypt once we add support for casefolding and encryption.
> Moving this into the vfs removes code duplication as well as the
> complication with encryption.
> 
> Currently this is pretty close to just moving the existing f2fs/ext4
> code up a level into the vfs, although there is a lot of room for
> improvement now.
> 
> Signed-off-by: Daniel Rosenberg <drosen@google.com>

I'm afraid that such vfs modification is unneeded.

Just a quick glance it seems just can be replaced by introducing some
.d_cmp, .d_hash helpers (or with little modification) and most non-Android
emulated storage files are not casefolded (even in Android).

"those dentry ops interfere with the dentry_ops required for fscrypt",
I don't think it's a real diffculty and it could be done with some
better approach instead.

Thanks,
Gao Xiang

