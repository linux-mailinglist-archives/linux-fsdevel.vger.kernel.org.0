Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97C2A7B3FA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2019 22:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727744AbfG3UDp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Jul 2019 16:03:45 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:35627 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbfG3UDp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Jul 2019 16:03:45 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.145]) with ESMTPA (Nemesis) id
 1Mzhax-1iEm9m42rJ-00vdzz; Tue, 30 Jul 2019 22:03:44 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v5 28/29] compat_ioctl: remove last RAID handling code
Date:   Tue, 30 Jul 2019 22:01:33 +0200
Message-Id: <20190730200145.1081541-9-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190730200145.1081541-1-arnd@arndb.de>
References: <20190730192552.4014288-1-arnd@arndb.de>
 <20190730200145.1081541-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:L6ghPT0z7Y64xcTrCXUwnubCk3tmV8ywCSmxsndG9GsSB7RCFPl
 lckirD4eRCqbNpeLeNl2vKkQTOZatiw1ZlX8Xm9sz3/HBZA/9BThKF5aDKVVeKe0NyheuJJ
 Eg4rk9FdVe3NWiv0wBYqp+kBjGJyE4suFOiFPfur3St6zEPnBaDdTKBj0wOCmv48JMv3y02
 JYWkL98cEij07OHO1QqFw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:/J/7zPuSG+c=:VrZh1nk9oIzE1LsTcZlAj9
 Ag6fmxC/BGicuB7U0DdL7Dlf+OGipXMinKQ4khSlAXJCDZyLhmw66VmIwnwPSqda+ARRUjS5J
 fpbXjJpv+rDImwQIojhyw0T5GF+zdsBkEC3KByCFPPOtuKanyErT95It4ufnKVt7GRHur1UJD
 0XGZzVK/TuYHs7zGWTlJ9SjckN/VAhFUtmjYEGPag1NdVpDYvH9llsRgiuLGXslJP1XYzuQy4
 GTjKpJio97eE405TeIYoIGcAfkhjLCW84+t4C/8Ti1t3YjIq5x0rVANbuL91uPII+fGVZhKcV
 J4qly6jCQPjSjeCXm9Yq0d9pYd+WJH/A+1rKXrUL2vX+JKrtWPK/hoNo5BIS95qw7BTX12WAy
 2i0ATVUMrgor5Yf0iOaliZo0xiH+IBB3jgAtmaG3M3LY7O6LXk7E5Wp3TsbhqeNkRA0Gp/51o
 WN5tAYSYW5Cx9HQm6kgcrsAef0AFVY7UciNfxEqbsblvPqQkM66jkWEHoG7XkImoIkypGfXlI
 4ZfKM8lGxUYSRLj8Z2XGcS7ltgExzYIUPX2GZ6NZDe9HkfrI749sSfd+lpYF6zvIKxFlPn4dd
 SQ8wBdTXTcGwJY7ezY2jiAlSWaSa3IW7q8kXYB8JoObxiBSp4IN2rE1Jb0mqWd6YkqYdjRyQo
 kqui+ZwJwYY3y6R3wZEMD/t4XFj6oDZnNeKLg1RPiLJcTR+w+/xaZezOutSxoUU43Qx7lTl08
 3LYiLKYmdAdPnY7nxfloMBQGiGDhGe1kh+DN9w==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Commit aa98aa31987a ("md: move compat_ioctl handling into md.c")
already removed the COMPATIBLE_IOCTL() table entries and added
a complete implementation, but a few lines got left behind and
should also be removed here.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/compat_ioctl.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/fs/compat_ioctl.c b/fs/compat_ioctl.c
index 6070481f2b6a..1ed32cca2176 100644
--- a/fs/compat_ioctl.c
+++ b/fs/compat_ioctl.c
@@ -462,19 +462,6 @@ static long do_ioctl_trans(unsigned int cmd,
 #endif
 	}
 
-	/*
-	 * These take an integer instead of a pointer as 'arg',
-	 * so we must not do a compat_ptr() translation.
-	 */
-	switch (cmd) {
-	/* RAID */
-	case HOT_REMOVE_DISK:
-	case HOT_ADD_DISK:
-	case SET_DISK_FAULTY:
-	case SET_BITMAP_FILE:
-		return vfs_ioctl(file, cmd, arg);
-	}
-
 	return -ENOIOCTLCMD;
 }
 
-- 
2.20.0

