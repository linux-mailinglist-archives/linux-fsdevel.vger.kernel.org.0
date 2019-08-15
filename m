Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F8248E901
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2019 12:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731409AbfHOK0y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Aug 2019 06:26:54 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42776 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728500AbfHOK0y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Aug 2019 06:26:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=SPb1h48FNAYXtQhPr8WgDuecOEsebGwX4zEaF0h93Fk=; b=TW6PsAgBy/lCvux5s2IVzF6Jb
        xU+tmrf8+s2QcwZwk9VQukrj4nETxZvLlqo6r+9pW4u4sSRYVDXCNfdtXTiP9AEfdnPLWrCujbwhB
        iuGhhyMX+JYk/KTVRx6T89fGQ8s1GXtzWeDB7tRPAzf8k9nFaP/H2ReEmV3hHzteoWhsHz2MwvpSH
        h94Tv3l3zzlBSym9fJk2tlFKr8H8OsXiwbJhnuTSc5YZPhZGB9wH8lS4EdqTM0kTGDBg4wwKoZ1CP
        RSoYqBoTXe5QcrmStLKK8QvDED7DUpRwiLFQKJEPklWu3egs/c6HJbiEd+SeavCzdl4fpx1+kHlpS
        bDMzEkw5Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hyCy1-00044Q-QV; Thu, 15 Aug 2019 10:26:49 +0000
Date:   Thu, 15 Aug 2019 03:26:49 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Brian Foster <bfoster@redhat.com>,
        Allison Collins <allison.henderson@oracle.com>,
        Nick Bowler <nbowler@draconx.ca>,
        Eric Sandeen <sandeen@sandeen.net>,
        Dave Chinner <dchinner@redhat.com>
Subject: Re: [PATCH v5 01/18] xfs: compat_ioctl: use compat_ptr()
Message-ID: <20190815102649.GA10821@infradead.org>
References: <20190814204259.120942-1-arnd@arndb.de>
 <20190814204259.120942-2-arnd@arndb.de>
 <20190814213753.GP6129@dread.disaster.area>
 <20190815071314.GA6960@infradead.org>
 <CAK8P3a2Hjfd49XY18cDr04ZpvC5ZBGudzxqpCesbSsDf1ydmSA@mail.gmail.com>
 <20190815080211.GA17055@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190815080211.GA17055@infradead.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 15, 2019 at 01:02:11AM -0700, Christoph Hellwig wrote:
> In many ways I'd actually much rather have a table driven approach.
> Let me try something..

Ok, it seems like we don't even need a table containing native and
compat as we can just fall back.  The tables still seem nicer to read,
though.

Let me know what you think of this:

http://git.infradead.org/users/hch/xfs.git/shortlog/refs/heads/xfs-ioctl-table

I also wonder if we should life the ioctl handler tables to the
VFS..
