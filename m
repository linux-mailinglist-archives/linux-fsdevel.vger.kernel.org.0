Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 810143B694B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jun 2021 21:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236190AbhF1Tvh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Jun 2021 15:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233996AbhF1Tvg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Jun 2021 15:51:36 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37FAEC061574;
        Mon, 28 Jun 2021 12:49:09 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 6C430478E; Mon, 28 Jun 2021 15:49:08 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 6C430478E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1624909748;
        bh=KcfAkSKsZA83wExNAdCpkp41/vEwBLTBCNj5A2LFKsQ=;
        h=Date:To:Cc:Subject:From:From;
        b=He6BHTl7MlbXhhFdUZKvW7enb+/75f23/B+8QdDBeLJzeAwX+pAtOsUWNWCqJR9S3
         TTDnnbWInOyQu+fCCQUydNGp3az46KoZ8FctTvUS1GmoWhmfWJc3pTYDcQNPa0pCV9
         jOU6TNLi/+A0lI2ecc9EbuQZ1cmmKXxwxAqp70RY=
Date:   Mon, 28 Jun 2021 15:49:08 -0400
To:     linux-fsdevel@vger.kernel.org
Cc:     dai.ngo@oracle.com, linux-nfs@vger.kernel.org
Subject: automatic freeing of space on ENOSPC
Message-ID: <20210628194908.GB6776@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Is there anything analogous to a "shrinker", but for disk space?  So,
some hook that a filesystem could call to say "I'm running out of space,
could you please free something?", before giving up and returning
ENOSPC?

The NFS server currently revokes a client's state if the client fails to
contact it within a lease period (90 seconds by default).  That's
harsher than necessary--if a network partition lasts longer than a lease
period, but if nobody else needs that client's resources, it'd be nice
to be able to hang on to them so that the client could resume normal
operation after the network comes back.  So we'd delay revoking the
client's state until there's an actual conflict.  But that means we need
a way to clean up the client as soon as there is a conflict, to avoid
unnecessarily failing operations that conflict with resources held by an
expired client.

At first I thought we only needed to worry about file locks, but then I
realized clients can also hold references to files, which might be
unlinked.  I don't want a long-expired client to result in ENOSPC to
other filesystem users.

Any ideas?

I searched around and found this discussion of volatile ranges
https://lwn.net/Articles/522135/, which seems close, but I don't know if
anything came of that in the end.

--b.
