Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D90D23082E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jul 2020 12:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728940AbgG1KzQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jul 2020 06:55:16 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:43386 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728801AbgG1KzQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jul 2020 06:55:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595933714;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=+IOlI7psZ+ZKyfa5KLTmjqmr8VdFZPqQBMXCO0Tdr+E=;
        b=LUzo+D0bXPMKlO2NCEUU/1HrVngjAKAWid1ciGswVLDmy6XEizzUtDn7Xd1cAvqMaafVYT
        VfATAlU57u3esQgV3QhH/1txyWtASiNH/u5uytoF30dhKoVHQlyjAqL4EH1NxMQ7Z/fb6c
        6GHVkj5/zgXVjuKM+kjtCyMmrXsUoFc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-491-vkATyfRuO0yrL38-0VB9-Q-1; Tue, 28 Jul 2020 06:55:12 -0400
X-MC-Unique: vkATyfRuO0yrL38-0VB9-Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7BE0679EC0;
        Tue, 28 Jul 2020 10:55:11 +0000 (UTC)
Received: from work-vm (ovpn-114-178.ams2.redhat.com [10.36.114.178])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 25F7C726BA;
        Tue, 28 Jul 2020 10:55:05 +0000 (UTC)
Date:   Tue, 28 Jul 2020 11:55:03 +0100
From:   "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     stefanha@redhat.com, groug@kaod.org, mszeredi@redhat.com,
        vgoyal@redhat.com, gscrivan@redhat.com, dwalsh@redhat.com,
        chirantan@chromium.org
Subject: xattr names for unprivileged stacking?
Message-ID: <20200728105503.GE2699@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.14.5 (2020-06-23)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,
  Are there any standards for mapping xattr names/classes when
a restricted view of the filesystem needs to think it's root?

e.g. VMs that mount host filesystems, remote filesystems etc and the
client kernel tries to set a trusted. or security. xattr and you want
to store that on an underlying normal filesystem, but your
VM system doesn't want to have CAP_SYS_ADMIN and/or doesn't want to
interfere with the real hosts security.

I can see some existing examples:

  9p in qemu
     maps system.posix_acl_* to user.virtfs.system.posix_acl_*
          stops the guest accessing any user.virtfs.*

   overlayfs
      uses trusted.overlay.* on upper layer and blocks that from 
           clients

   fuse-overlayfs
      uses trusted.overlay.* for compatibiltiy if it has perms,
      otherwise falls back to user.fuseoverlayfs.*

   crosvm's virtiofs
      maps "security.sehash" to "user.virtiofs.security.sehash"
      and blocks the guest from accessing user.virtiofs.*

Does anyone know of any others?

It all seems quite adhoc;  these all fall to bits when you
stack them or when you write a filesystem using one of these
schemes and then mount it with another.

(I'm about to do a similar mapping for virtiofs's C daemon)

Thanks in advance,

Dave 

--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

