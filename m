Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D46343436B8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Mar 2021 03:41:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbhCVCkm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 21 Mar 2021 22:40:42 -0400
Received: from zeniv-ca.linux.org.uk ([142.44.231.140]:45676 "EHLO
        zeniv-ca.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbhCVCkg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 21 Mar 2021 22:40:36 -0400
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lOASV-0081uq-N3; Mon, 22 Mar 2021 02:38:23 +0000
Date:   Mon, 22 Mar 2021 02:38:23 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Steve French <smfrench@gmail.com>
Cc:     CIFS <linux-cifs@vger.kernel.org>,
        Steve French <sfrench@samba.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC][PATCHSET] hopefully saner handling of pathnames in cifs
Message-ID: <YFgDH6wzFZ6FIs3R@zeniv-ca.linux.org.uk>
References: <YFV6iexd6YQTybPr@zeniv-ca.linux.org.uk>
 <CAH2r5mvA0WeeV1ZSW4HPvksvs+=GmkiV5nDHqCRddfxkgPNfXA@mail.gmail.com>
 <CAH2r5msWJn5a7JCUdoyJ7nfyeafRS8TvtgF+mZCY08LBf=9LAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH2r5msWJn5a7JCUdoyJ7nfyeafRS8TvtgF+mZCY08LBf=9LAQ@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Mar 21, 2021 at 09:19:53PM -0500, Steve French wrote:
> automated tests failed so will need to dig in a little more and see
> what is going on
> 
> http://smb3-test-rhel-75.southcentralus.cloudapp.azure.com/#/builders/2/builds/533

<looks>

Oh, bugger...  I think I see a braino that might be responsible for that;
whether it's all that's going on or not, that's an obvious bug.  Incremental
for that one would be

diff --git a/fs/cifs/dir.c b/fs/cifs/dir.c
index 3febf667d119..ed16f75ac0fa 100644
--- a/fs/cifs/dir.c
+++ b/fs/cifs/dir.c
@@ -132,7 +132,7 @@ build_path_from_dentry_optional_prefix(struct dentry *direntry, void *page,
 	}
 	if (dfsplen) {
 		s -= dfsplen;
-		memcpy(page, tcon->treeName, dfsplen);
+		memcpy(s, tcon->treeName, dfsplen);
 		if (cifs_sb->mnt_cifs_flags & CIFS_MOUNT_POSIX_PATHS) {
 			int i;
 			for (i = 0; i < dfsplen; i++) {


Folded and force-pushed (same branch).  My apologies...
