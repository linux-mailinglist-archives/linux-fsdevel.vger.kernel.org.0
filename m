Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EEE0813B1A1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2020 19:06:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728688AbgANSGU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jan 2020 13:06:20 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44908 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728650AbgANSGT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jan 2020 13:06:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579025179;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G/WdIxHJtjkP+9AN++jWhKySJMpGHzaJ1b/ah446BtA=;
        b=IYGsRr7O/vQhAM9fzBWzuXHb7nzf2s6XbsoeTvkLvTJOXZvIDL4efKxdGRA+vY5EbfKvav
        Jva2OHdntxMlWoE4KjW0EiwrccGA6TZOIO0rocOj0qpwqtFcjtRvnpEvk27YFPJ+H8ZfKp
        bb1rCznE5gomPdG1PtCNbhE3an62rqE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-152-zJ2FEVbQOmqKGV5XN1HWHQ-1; Tue, 14 Jan 2020 13:06:16 -0500
X-MC-Unique: zJ2FEVbQOmqKGV5XN1HWHQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2933B8045DA;
        Tue, 14 Jan 2020 18:06:14 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-52.rdu2.redhat.com [10.10.120.52])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ABAD580F62;
        Tue, 14 Jan 2020 18:06:11 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20200114170250.GA8904@ZenIV.linux.org.uk>
References: <20200114170250.GA8904@ZenIV.linux.org.uk> <3326.1579019665@warthog.procyon.org.uk>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     dhowells@redhat.com, linux-fsdevel@vger.kernel.org, hch@lst.de,
        tytso@mit.edu, adilger.kernel@dilger.ca, darrick.wong@oracle.com,
        clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Making linkat() able to overwrite the target
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9350.1579025170.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Tue, 14 Jan 2020 18:06:10 +0000
Message-ID: <9351.1579025170@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Al Viro <viro@zeniv.linux.org.uk> wrote:

> > Would it be possible to make linkat() take a flag, say AT_LINK_REPLACE=
,
> > that causes the target to be replaced and not give EEXIST?  Or make it=
 so
> > that rename() can take a tmpfile as the source and replace the target =
with
> > that.  I presume that, either way, this would require journal changes =
on
> > ext4, xfs and btrfs.
>
> Umm...  I don't like the idea of linkat() doing that - you suddenly get =
new
> fun cases to think about (what should happen when the target is a mountp=
oint,
> for starters?

Don't allow it onto directories, S_AUTOMOUNT-marked inodes or anything tha=
t's
got something mounted on it.

> ) _and_ you would have to add a magical flag to vfs_link() so
> that it would know which tests to do.

Yes, I suggested AT_LINK_REPLACE as said magical flag.

> As for rename...

Yeah - with further thought, rename() doesn't really work as an interface,
particularly if a link has already been made.

Do you have an alternative suggestion?  There are two things I want to avo=
id:

 (1) Doing unlink-link or unlink-create as that leaves a window where the
     cache file is absent.

 (2) Creating replacement files in a temporary directory and renaming from
     there over the top of the target file as the temp dir would then be a
     bottleneck that spends a lot of time locked for creations and renames=
.

David

