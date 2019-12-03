Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D103B11055D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2019 20:42:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbfLCTmQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Dec 2019 14:42:16 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:36132 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbfLCTmQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Dec 2019 14:42:16 -0500
Received: from localhost (unknown [IPv6:2610:98:8005::647])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: krisman)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 6C9562909E7;
        Tue,  3 Dec 2019 19:42:14 +0000 (GMT)
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Gao Xiang <gaoxiang25@huawei.com>
Cc:     Daniel Rosenberg <drosen@google.com>,
        Theodore Ts'o <tytso@mit.edu>, <linux-ext4@vger.kernel.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        Eric Biggers <ebiggers@kernel.org>,
        <linux-fscrypt@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jonathan Corbet <corbet@lwn.net>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <kernel-team@android.com>
Subject: Re: [PATCH 4/8] vfs: Fold casefolding into vfs
Organization: Collabora
References: <20191203051049.44573-1-drosen@google.com>
        <20191203051049.44573-5-drosen@google.com>
        <20191203074154.GA216261@architecture4>
Date:   Tue, 03 Dec 2019 14:42:10 -0500
In-Reply-To: <20191203074154.GA216261@architecture4> (Gao Xiang's message of
        "Tue, 3 Dec 2019 15:41:54 +0800")
Message-ID: <85wobdb3hp.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Gao Xiang <gaoxiang25@huawei.com> writes:

> On Mon, Dec 02, 2019 at 09:10:45PM -0800, Daniel Rosenberg wrote:
>> Ext4 and F2fs are both using casefolding, and they, along with any other
>> filesystem that adds the feature, will be using identical dentry_ops.
>> Additionally, those dentry ops interfere with the dentry_ops required
>> for fscrypt once we add support for casefolding and encryption.
>> Moving this into the vfs removes code duplication as well as the
>> complication with encryption.
>> 
>> Currently this is pretty close to just moving the existing f2fs/ext4
>> code up a level into the vfs, although there is a lot of room for
>> improvement now.
>> 
>> Signed-off-by: Daniel Rosenberg <drosen@google.com>
>
> I'm afraid that such vfs modification is unneeded.
>
> Just a quick glance it seems just can be replaced by introducing some
> .d_cmp, .d_hash helpers (or with little modification) and most non-Android
> emulated storage files are not casefolded (even in Android).
>
> "those dentry ops interfere with the dentry_ops required for fscrypt",
> I don't think it's a real diffculty and it could be done with some
> better approach instead.

It would be good to avoid dentry_ops in general for these cases.  It
doesn't just interfere with fscrypt, but also overlayfs and others.

The difficulty is that it is not trivial to change dentry_ops after
dentries are already installed in the dcache.  Which means that it is
hard to use different dentry_ops for different parts of the filesystem,
for instance when converting a directory to case-insensitive or back
to case-sensitive.

In fact, currently and for case-insensitive at least, we install generic
hooks for the entire case-insensitive filesystem and use it even for
!IS_CASEFOLDED() directories. This breaks overlayfs even if we don't
have a single IS_CASEFOLDED() directory at all, just by having the
superblock flag, we *must* set the dentry_ops, which already breaks
overlayfs.

I think Daniel's approach of moving this into VFS is the simplest way to
actually solve the issue, instead of extending and duplicating a lot of
functionality into filesystem hooks to support the possible mixes of
case-insensitive, overlayfs and fscrypt.

-- 
Gabriel Krisman Bertazi
