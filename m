Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1204C1E70B6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 May 2020 01:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437688AbgE1Xsg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 May 2020 19:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437647AbgE1Xse (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 May 2020 19:48:34 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FC8BC014D07;
        Thu, 28 May 2020 16:48:34 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.93 #3 (Red Hat Linux))
        id 1jeSGG-00HDkJ-MD; Thu, 28 May 2020 23:48:32 +0000
Date:   Fri, 29 May 2020 00:48:32 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCHES] uaccess readdir
Message-ID: <20200528234832.GA4103769@ZenIV.linux.org.uk>
References: <20200528234025.GT23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528234025.GT23230@ZenIV.linux.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

 	readdir.c uaccess stuff.  Lives in #uaccess.readdir, based at
#uaccess.base, gets the rest of fs/readdir.c in sync with
getdents()/getdents64().

Al Viro (3):
      switch readdir(2) to unsafe_copy_dirent_name()
      readdir.c: get compat_filldir() more or less in sync with filldir()
      readdir.c: get rid of the last __put_user(), drop now-useless access_ok()

 fs/readdir.c | 92 +++++++++++++++++++++++++++++-------------------------------
 1 file changed, 44 insertions(+), 48 deletions(-)
