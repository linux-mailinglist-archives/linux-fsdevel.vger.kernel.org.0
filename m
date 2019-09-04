Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A808A831C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2019 14:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729656AbfIDMjn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Sep 2019 08:39:43 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45700 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbfIDMjn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Sep 2019 08:39:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=46rtVsP+q58WyAZYY2K+ydWmL8S5cK07U6g6MAPCNAg=; b=RAmgutrtgnLTFmU9yGZ/SUWkB
        LuClrQ2GLdcUPAHrPlGQc8x5ax11QVMddy8SGnoirlP2/dpb0qD9ZkpXkptm1pnHRHPMOaSoXP90u
        h5JXbbIwtzrOEP60fS6+Q8qVTA/FiZ7XS9pKho16aRex4HUTyjfAXN3BoBBhgCoQ3IMA81ycOEzSQ
        XF0SKVPlJvythOeYc2y9uPZYcN2evBnZFUVjEFZhKTLFkJSA7nRLXMdxnX6vYJkHC3hEsKrljiHc1
        s6iN+3ehLT6ZSew4A5dohw1lhtPN4+vpCcXPHGYj4d6LWsKAXMYc9eBvqF4+XS32Dh3LJheT6rAn1
        E+uQQ0dzg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i5UZZ-0007Rw-1x; Wed, 04 Sep 2019 12:39:41 +0000
Date:   Wed, 4 Sep 2019 05:39:41 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christoph Hellwig <hch@infradead.org>, Qian Cai <cai@lca.pw>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: "fs/namei.c: keep track of nd->root refcount status" causes boot
 panic
Message-ID: <20190904123940.GA24520@infradead.org>
References: <7C6CCE98-1E22-433C-BF70-A3CBCDED4635@lca.pw>
 <20190903123719.GF1131@ZenIV.linux.org.uk>
 <20190903130456.GA9567@infradead.org>
 <20190903134832.GH1131@ZenIV.linux.org.uk>
 <20190903135024.GA8274@infradead.org>
 <20190903135354.GI1131@ZenIV.linux.org.uk>
 <20190903153930.GA2791@infradead.org>
 <20190903175610.GM1131@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190903175610.GM1131@ZenIV.linux.org.uk>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 03, 2019 at 06:56:10PM +0100, Al Viro wrote:
> On Tue, Sep 03, 2019 at 08:39:30AM -0700, Christoph Hellwig wrote:
> 
> > > There's much nastier situation than "new upstream kernel released,
> > > need to rebuild" - it's bisect in mainline trying to locate something...
> > 
> > I really don't get the point.  And it's not like we've card about
> > this anywhere else.  And jumping wildly around with the numeric values
> > for constants will lead to bugs like the one you added and fixed again
> > and again.
> 
> The thing is, there are several groups - it's not as if all additions
> were guaranteed to be at the end.  So either we play with renumbering
> again and again, or we are back to the square one...
> 
> Is there any common trick that would allow to verify the lack of duplicates
> at the build time?
> 
> Or we can reorder the list by constant value, with no grouping visible
> anywhere...

Here is what I'd do.  No validation of duplicates, but the 1 << bit
notation makes them very easy to spot:

diff --git a/include/linux/namei.h b/include/linux/namei.h
index 397a08ade6a2..a9536f90936c 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -16,28 +16,47 @@ enum { MAX_NESTED_LINKS = 8 };
  */
 enum {LAST_NORM, LAST_ROOT, LAST_DOT, LAST_DOTDOT, LAST_BIND};
 
-/* pathwalk mode */
-#define LOOKUP_FOLLOW		0x0001	/* follow links at the end */
-#define LOOKUP_DIRECTORY	0x0002	/* require a directory */
-#define LOOKUP_AUTOMOUNT	0x0004  /* force terminal automount */
-#define LOOKUP_EMPTY		0x4000	/* accept empty path [user_... only] */
-#define LOOKUP_DOWN		0x8000	/* follow mounts in the starting point */
-
-#define LOOKUP_REVAL		0x0020	/* tell ->d_revalidate() to trust no cache */
-#define LOOKUP_RCU		0x0040	/* RCU pathwalk mode; semi-internal */
-
-/* These tell filesystem methods that we are dealing with the final component... */
-#define LOOKUP_OPEN		0x0100	/* ... in open */
-#define LOOKUP_CREATE		0x0200	/* ... in object creation */
-#define LOOKUP_EXCL		0x0400	/* ... in exclusive creation */
-#define LOOKUP_RENAME_TARGET	0x0800	/* ... in destination of rename() */
-
-/* internal use only */
-#define LOOKUP_PARENT		0x0010
-#define LOOKUP_NO_REVAL		0x0080
-#define LOOKUP_JUMPED		0x1000
-#define LOOKUP_ROOT		0x2000
-#define LOOKUP_ROOT_GRABBED	0x0008
+/*
+ * Pathwalk mode:
+ */
+
+/* follow links at the end */
+#define LOOKUP_FOLLOW		(1 << 0)
+/* require a directory */
+#define LOOKUP_DIRECTORY	(1 << 1)
+/* force terminal automount */
+#define LOOKUP_AUTOMOUNT	(1 << 2)
+/* accept empty path [user_... only] */
+#define LOOKUP_EMPTY		(1 << 3)
+/* follow mounts in the starting point */
+#define LOOKUP_DOWN		(1 << 4)
+/* tell ->d_revalidate() to trust no cache */
+#define LOOKUP_REVAL		(1 << 5)
+/* RCU pathwalk mode; semi-internal */
+#define LOOKUP_RCU		(1 << 6)
+
+
+/*
+ * These tell filesystem methods that we are dealing with the final component:
+ */
+
+/* ... in open */
+#define LOOKUP_OPEN		(1 << 10)
+/* ... in object creation */
+#define LOOKUP_CREATE		(1 << 11)
+/* ... in exclusive creation */
+#define LOOKUP_EXCL		(1 << 12)
+/* ... in destination of rename() */
+#define LOOKUP_RENAME_TARGET	(1 << 13)
+
+/*
+ * Internal use only:
+ */
+#define LOOKUP_PARENT		(1 << 20)
+#define LOOKUP_NO_REVAL		(1 << 21)
+#define LOOKUP_JUMPED		(1 << 22)
+#define LOOKUP_ROOT		(1 << 23)
+#define LOOKUP_ROOT_GRABBED	(1 << 24)
 
 extern int path_pts(struct path *path);
 
