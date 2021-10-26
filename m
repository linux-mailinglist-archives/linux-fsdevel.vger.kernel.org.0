Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9565143B6FA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Oct 2021 18:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237510AbhJZQVc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Oct 2021 12:21:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:40791 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237456AbhJZQUm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Oct 2021 12:20:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635265098;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=X8EbW1rPnHxSX+56xXyqE1LJCwOGvkQavcL9P2gnKnc=;
        b=U3lmegHTSMny720yJwK3Xkt4FjsTgvg4o+tleDceoJovSc6wFo7fX3UQqD1zsijzT8kbtc
        hoIODbcnwRmucrNjiir+wgMqK+LO+CDVipj0lLPLVoJkZtAhGHQrkFtUDZmbwPd0pSbpjO
        3mmmH6oHLDKXPJYDbQoZDxUOqmqhXkk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-155-wtd6Btx7P2yewIDxBqm2Qg-1; Tue, 26 Oct 2021 12:18:15 -0400
X-MC-Unique: wtd6Btx7P2yewIDxBqm2Qg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2892E80A5C0;
        Tue, 26 Oct 2021 16:18:14 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.17.178])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0A5AF1981F;
        Tue, 26 Oct 2021 16:18:14 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 999502204A5; Tue, 26 Oct 2021 12:18:13 -0400 (EDT)
Date:   Tue, 26 Oct 2021 12:18:13 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Ioannis Angelakopoulos <iangelak@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        virtio-fs-list <virtio-fs@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Steve French <sfrench@samba.org>
Subject: Re: [RFC PATCH 0/7] Inotify support in FUSE and virtiofs
Message-ID: <YXgqRb21hvYyI69D@redhat.com>
References: <20211025204634.2517-1-iangelak@redhat.com>
 <CAOQ4uxieK3KpY7pf0YTKcrNHW7rnTATTDZdK9L4Mqy32cDwV8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxieK3KpY7pf0YTKcrNHW7rnTATTDZdK9L4Mqy32cDwV8w@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 26, 2021 at 06:23:50PM +0300, Amir Goldstein wrote:

[..]
> > 3) The lifetime of the local watch in the guest kernel is very
> > important. Specifically, there is a possibility that the guest does not
> > receive remote events on time, if it removes its local watch on the
> > target or deletes the inode (and thus the guest kernel removes the watch).
> > In these cases the guest kernel removes the local watch before the
> > remote events arrive from the host (virtiofsd) and as such the guest
> > kernel drops all the remote events for the target inode (since the
> > corresponding local watch does not exist anymore).

So this is one of the issues which has been haunting us in virtiofs. If
a file is removed, for local events, event is generated first and
then watch is removed. But in case of remote filesystems, it is racy.
It is possible that by the time event arrives, watch is already gone
and application never sees the delete event.

Not sure how to address this issue.

Vivek

