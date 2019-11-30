Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1480210DF5C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Nov 2019 22:19:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727296AbfK3VT3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 30 Nov 2019 16:19:29 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:56146 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727025AbfK3VT3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 30 Nov 2019 16:19:29 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 495778EE0DF;
        Sat, 30 Nov 2019 13:19:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1575148768;
        bh=LYlzsBKHcEkSgISeQyo1vENVFVBARpPnE+P3GArbEH8=;
        h=Subject:From:To:Cc:Date:From;
        b=u6FSfSxV/Z+S0re3zsna4KTvPYaszzPkt/Zs5y7kuwMAhInaQDqatDyEygv4T4ztZ
         eRrQNvoT63o3sUxjj4e8L3u+0871nHeA76Ft+DJD30GstK0guDYet/1BnggpB3wIQd
         /mvAthHFN8pH3hG1xdQkObhfSpkTWZ7he5/aVsDo=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 1XZTeD5vmecV; Sat, 30 Nov 2019 13:19:26 -0800 (PST)
Received: from jarvis.lan (unknown [50.35.76.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 5E1AE8EE07B;
        Sat, 30 Nov 2019 13:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1575148766;
        bh=LYlzsBKHcEkSgISeQyo1vENVFVBARpPnE+P3GArbEH8=;
        h=Subject:From:To:Cc:Date:From;
        b=pV+mtsDD3S+nGAS0XQffWAzxsnuKdttfo6tGvf+2TNYZ9rjU2rpz0Ps5LDp9U6ZyG
         wHjHt3AdO5Df9pNepAEfe5tLVNeEVL4WEFpcfntv8jsFcC965CBKiq81hfwapZZWGT
         cC4nrbyRQV9qBRN3PNjcMpl40VByEs66hKAv1jnM=
Message-ID: <1575148763.5563.28.camel@HansenPartnership.com>
Subject: [PATCH 0/1] preparatory patch for a uid/gid shifting bind mount
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     dhowells@redhat.com, Al Viro <viro@ZenIV.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-unionfs@vger.kernel.org,
        Seth Forshee <seth.forshee@canonical.com>
Date:   Sat, 30 Nov 2019 13:19:23 -0800
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I had another look at what it would take to reimplement shiftfs as a
true bind mount.  It turns out we do have struct path threaded in
almost enough places to make it work.  There really is only one API
that needs updating and that's notify_change(), so the following patch
fixes that and pulls do_truncate() along as well.  The updates are
mostly smooth and pretty obvious because the path was actually already
present, except for in overlayfs where trying to sort out what the path
should be is somewhat of a nightmare.  If the overlayfs people could
take a look and make sure I got it right, I'd be grateful.

I think this is the only needed change, but I've only just got a
functional implementation of a uid/gid shifting bind mount, so there
might be other places that need rethreading as I find deficiencies in
the current implementation.  I'll send them along as additional patches
if I find them

James

