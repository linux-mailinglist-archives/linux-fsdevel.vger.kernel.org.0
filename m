Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B868D347C90
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Mar 2021 16:29:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236528AbhCXP2s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Mar 2021 11:28:48 -0400
Received: from zeniv-ca.linux.org.uk ([142.44.231.140]:47098 "EHLO
        zeniv-ca.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236525AbhCXP2e (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Mar 2021 11:28:34 -0400
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lP5Qt-008rct-WE; Wed, 24 Mar 2021 15:28:32 +0000
Date:   Wed, 24 Mar 2021 15:28:31 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Steve French <smfrench@gmail.com>
Cc:     CIFS <linux-cifs@vger.kernel.org>,
        Steve French <sfrench@samba.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC][PATCHSET] hopefully saner handling of pathnames in cifs
Message-ID: <YFtan50FfxSCGRkZ@zeniv-ca.linux.org.uk>
References: <YFV6iexd6YQTybPr@zeniv-ca.linux.org.uk>
 <CAH2r5mvA0WeeV1ZSW4HPvksvs+=GmkiV5nDHqCRddfxkgPNfXA@mail.gmail.com>
 <CAH2r5msWJn5a7JCUdoyJ7nfyeafRS8TvtgF+mZCY08LBf=9LAQ@mail.gmail.com>
 <YFgDH6wzFZ6FIs3R@zeniv-ca.linux.org.uk>
 <CAH2r5mucWfotrdXvVvvUG-GEOhB=zGAhuPXSzAyw7X=EZDDzYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH2r5mucWfotrdXvVvvUG-GEOhB=zGAhuPXSzAyw7X=EZDDzYg@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 23, 2021 at 12:04:34AM -0500, Steve French wrote:
> reran with the updated patch 7 and it failed (although I didn't have
> time to dig much into it today) - see
> 
> http://smb3-test-rhel-75.southcentralus.cloudapp.azure.com/#/builders/2/builds/534
> 
> but it seems to run ok without patch 7 (just the first six patches)
> 
> http://smb3-test-rhel-75.southcentralus.cloudapp.azure.com/#/builders/2/builds/535

Hmm...  Another bug, AFAICS, is that for root we end up with "/", not "".
No idea if that's all there is, though ;-/  How does one set the things up
for those tests?  Anyway, incremental would be
diff --git a/fs/cifs/dir.c b/fs/cifs/dir.c
index ed16f75ac0fa..03afad8b24af 100644
--- a/fs/cifs/dir.c
+++ b/fs/cifs/dir.c
@@ -114,6 +114,8 @@ build_path_from_dentry_optional_prefix(struct dentry *direntry, void *page,
 	s = dentry_path_raw(direntry, page, PAGE_SIZE);
 	if (IS_ERR(s))
 		return s;
+	if (!s[1])	// for root we want "", not "/"
+		s++;
 	if (s < (char *)page + pplen + dfsplen)
 		return ERR_PTR(-ENAMETOOLONG);
 	if (pplen) {

Folded and force-pushed.  Could you throw the updated branch into testing?
