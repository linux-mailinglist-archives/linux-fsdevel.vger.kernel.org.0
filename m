Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37D073D490F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jul 2021 20:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbhGXR2d (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 24 Jul 2021 13:28:33 -0400
Received: from bedivere.hansenpartnership.com ([96.44.175.130]:52744 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229655AbhGXR2c (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 24 Jul 2021 13:28:32 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 182A21280193;
        Sat, 24 Jul 2021 11:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1627150144;
        bh=OBdIbbICnlhWCgpUXqhBHIcAkWO2KhMxkOjYPmxy+rk=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=gcFzw40+mFqkGB0zVGYDDIcydpsBgO0E3sNonwKK7u/oLqfO4PUUERLX3/snLZRfC
         bf12atERrZw+QVmbt1qyzee4CXDJjDfr6HRI2l2dt1orUKzbF4dbwPWIlVP8QThiC+
         6Lr6Rnuel7fjYRMJF2S7+/zTFE7wNzXZ1SXUZzxE=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id lxd24d0VwAYk; Sat, 24 Jul 2021 11:09:04 -0700 (PDT)
Received: from jarvis.int.hansenpartnership.com (unknown [IPv6:2601:600:8280:66d1::527])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 761EC12800A0;
        Sat, 24 Jul 2021 11:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1627150143;
        bh=OBdIbbICnlhWCgpUXqhBHIcAkWO2KhMxkOjYPmxy+rk=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=ptJWvvM7GD/9XKXB8DiWs9YTDWM/KfwqNNXZECbrVE7knJVp39uLW4ZXTii3+UJFj
         fgibyWkQGzmxVQHYKmIP/KUmRzICDL7hz7v4AaYmmx+GomDg84HgijyWKk/tSUB2f7
         gmb8GXwr+qmtFhkOAp9JPshrsvV1IR3cuJGJV02M=
Message-ID: <1e48f7edcb6d9a67e8b78823660939007e14bae1.camel@HansenPartnership.com>
Subject: Re: Folios give an 80% performance win
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Andres Freund <andres@anarazel.de>,
        Michael Larabel <Michael@michaellarabel.com>
Date:   Sat, 24 Jul 2021 11:09:02 -0700
In-Reply-To: <YPxNkRYMuWmuRnA5@casper.infradead.org>
References: <20210715033704.692967-1-willy@infradead.org>
         <YPxNkRYMuWmuRnA5@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, 2021-07-24 at 18:27 +0100, Matthew Wilcox wrote:
> What blows me away is the 80% performance improvement for PostgreSQL.
> I know they use the page cache extensively, so it's plausibly real.
> I'm a bit surprised that it has such good locality, and the size of
> the win far exceeds my expectations.  We should probably dive into it
> and figure out exactly what's going on.

Since none of the other tested databases showed more than a 3%
improvement, this looks like an anomalous result specific to something
in postgres ... although the next biggest db: mariadb wasn't part of
the tests so I'm not sure that's definitive.  Perhaps the next step
should be to test mariadb?  Since they're fairly similar in domain
(both full SQL) if mariadb shows this type of improvement, you can
safely assume it's something in the way SQL databases handle paging and
if it doesn't, it's likely fixing a postgres inefficiency.

James


