Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0BDC2F6482
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Jan 2021 16:28:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727407AbhANP10 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Jan 2021 10:27:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:31061 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726810AbhANP1Z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Jan 2021 10:27:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610637959;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to;
        bh=+jOB4Fu7fKncqGSyJ+NR1n6barLftBxA3FNSl4jUPIc=;
        b=CTytdlJ/Y0HKvyOCg3azAdquFFOivvtf0CaywiTQRTcl8D7gl/XgISKBjLV9ci+wzjHuhn
        olyTpBJFZOKqjhqofHuvV4OK+8flpKyxw7aQJ1tYej7TunR8AMRWG+NqlrjS2wvT7s5d5E
        r3xoCKZ5I1xV3TlDrh4WE6kJXolqYYQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-158-n1LttnR8MGqAibK7y6ABoQ-1; Thu, 14 Jan 2021 10:25:57 -0500
X-MC-Unique: n1LttnR8MGqAibK7y6ABoQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 87C0A107ACFB;
        Thu, 14 Jan 2021 15:25:56 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 801B95D6AD;
        Thu, 14 Jan 2021 15:25:56 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 783FF4BB40;
        Thu, 14 Jan 2021 15:25:56 +0000 (UTC)
Date:   Thu, 14 Jan 2021 10:25:56 -0500 (EST)
From:   Bob Peterson <rpeterso@redhat.com>
To:     linux-fsdevel <linux-fsdevel@vger.kernel.org>, tj <tj@kernel.org>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>
Message-ID: <1403463545.44592876.1610637956402.JavaMail.zimbra@redhat.com>
In-Reply-To: <330231792.44586135.1610635888053.JavaMail.zimbra@redhat.com>
Subject: locking (or LOCKDEP) problem with mark_buffer_dirty()
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.3.112.189, 10.4.195.13]
Thread-Topic: locking (or LOCKDEP) problem with mark_buffer_dirty()
Thread-Index: ZL4TGelaTfxpOHHuHpm458fsxklU0A==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Tejun and linux-fsdevel,

I have a question about function mark_buffer_dirty and LOCKDEP.

Background: Func mark_buffer_dirty() has a calling sequence that looks kind
of like this (simplified):

mark_buffer_dirty()
   __set_page_dirty()
      account_page_dirtied()
         inode_to_wb() which contains:
#ifdef CONFIG_LOCKDEP
	WARN_ON_ONCE(debug_locks &&
		     (!lockdep_is_held(&inode->i_lock) &&
		      !lockdep_is_held(&inode->i_mapping->i_pages.xa_lock) &&
		      !lockdep_is_held(&inode->i_wb->list_lock)));
#endif
   ...
   __mark_inode_dirty()
      spin_lock(&inode->i_lock);
      ...
      spin_unlock(&inode->i_lock);
   ...      

The LOCKDEP checks were added with Tejun Heo's 2015 patch, aaa2cacf8184e2a92accb8e443b1608d65f9a13f.

Since mark_buffer_dirty()'s call to __mark_inode_dirty() locks the inode->i_lock,
functions must not call mark_buffer_dirty() with inode->i_lock locked: or deadlock.

If they're not doing anything with the xarrays or the i_wb list (i.e. holding the
other two locks), they get these LOCKDEP warnings.

So either:
(a) the LOCKDEP warnings are not valid in all cases -or-
(b) mark_buffer_dirty() should be grabbing inode->i_lock at some point like __mark_inode_dirty() does.

My question is: which is it, a or b? TIA.

(My situation is that the gfs2 file system gets these LOCKDEP warnings
when it calls mark_buffer_dirty() [obviously only if LOCKDEP is set], and it's
not appropriate to lock xa_lock or i_wb->list_lock, and we cannot lock i_lock
for the reasons stated above).

Regards,

Bob Peterson
GFS2 File System

