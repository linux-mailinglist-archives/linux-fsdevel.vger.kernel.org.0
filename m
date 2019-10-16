Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2D2BD996B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2019 20:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390769AbfJPSpv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Oct 2019 14:45:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:34416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728538AbfJPSpv (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Oct 2019 14:45:51 -0400
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 76D222067D;
        Wed, 16 Oct 2019 18:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571251550;
        bh=IvfyPyxVdLeBwVn55Hud/B3dJIpR2u20GQW/Nuhq+RE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hdhW3ZSbet1D0JpybK4l5EuTGq3hKWbaHlBQtY+Q2Bf15JwCdjoUBnBl1ycLEhiW4
         hqAPiLNMoYv+FO3ddE5BeJ9AIwHkUZVEjRF1Je8L4HcdPsr5eGGlMVBb+5Tk+tjzq9
         xNaLhr9jS1BLTJykQ0I6zYaqRD/oS9kbMll/v0Gk=
Date:   Wed, 16 Oct 2019 11:45:49 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Bob Peterson <rpeterso@redhat.com>
Subject: Re: [PATCH v3] splice: only read in as much information as there is
 pipe buffer space
Message-ID: <20191016184549.GB720@sol.localdomain>
Mail-Followup-To: "Darrick J. Wong" <darrick.wong@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Bob Peterson <rpeterso@redhat.com>
References: <20191014220940.GF13098@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191014220940.GF13098@magnolia>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 14, 2019 at 03:09:40PM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <darrick.wong@oracle.com>
> 
> Andreas Grünbacher reports that on the two filesystems that support
> iomap directio, it's possible for splice() to return -EAGAIN (instead of
> a short splice) if the pipe being written to has less space available in
> its pipe buffers than the length supplied by the calling process.
> 
> Months ago we fixed splice_direct_to_actor to clamp the length of the
> read request to the size of the splice pipe.  Do the same to do_splice.
> 
> Fixes: 17614445576b6 ("splice: don't read more than available pipe space")
> Reported-by: syzbot+3c01db6025f26530cf8d@syzkaller.appspotmail.com

I already invalidated this syzbot report when the previous version of this patch
was dropped, as that was what the report appeared to be for.  So you don't need
this Reported-by line.  It's not a big deal, but including it could mislead
people into thinking that syzbot found a problem with the commit in the Fixes:
line, rather than a prior version of this patch.

- Eric
