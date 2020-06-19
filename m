Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB0812009C7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jun 2020 15:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732501AbgFSNR1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Jun 2020 09:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731600AbgFSNRY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Jun 2020 09:17:24 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 826D2C06174E;
        Fri, 19 Jun 2020 06:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nk4pUac2lDNTajxLog7MnFC0ty5sPArKeQyTpTonniE=; b=PVOkZfJT6ytrDRAE5mCX88ZpvZ
        lvRgDfWk79jZWlHsEmjQNISZHl3un1MJcmB+Kz61yO/K+lqo7z1trEgNZWXNLKsjTAsT8rQCO+dn4
        VUqBaEOanAS62dXjFbFhFdf5NTqmKxIEwgF0ijPIlr+J3C/msE/dCN1SS8tPY9yJORCObWJvAC97E
        KcE45JBuPsDUhb3UenlVYRf5l01v23mVHwIfByBnS1j/TRMY/ffxsEp0jbyTKD7BVrhau5YmUubfP
        pmbStFswGLHO919sNEDLG0Yi3prfJm0I27WOLN+TO7FKTH7DdwbEXeFGlRDFrqO+YAPu0aNXv3KGf
        hQPWCnvw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jmGtN-0006oh-4P; Fri, 19 Jun 2020 13:17:13 +0000
Date:   Fri, 19 Jun 2020 06:17:13 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Masayoshi Mizuma <msys.mizuma@gmail.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Eric Sandeen <sandeen@sandeen.net>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs <linux-xfs@vger.kernel.org>
Subject: Re: [PATCH] fs: i_version mntopt gets visible through /proc/mounts
Message-ID: <20200619131713.GA15982@infradead.org>
References: <24692989-2ee0-3dcc-16d8-aa436114f5fb@sandeen.net>
 <20200617172456.GP11245@magnolia>
 <8f0df756-4f71-9d96-7a52-45bf51482556@sandeen.net>
 <20200617181816.GA18315@fieldses.org>
 <4cbb5cbe-feb4-2166-0634-29041a41a8dc@sandeen.net>
 <20200617184507.GB18315@fieldses.org>
 <20200618013026.ewnhvf64nb62k2yx@gabell>
 <20200618030539.GH2005@dread.disaster.area>
 <20200618034535.h5ho7pd4eilpbj3f@gabell>
 <20200618223948.GI2005@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200618223948.GI2005@dread.disaster.area>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 19, 2020 at 08:39:48AM +1000, Dave Chinner wrote:
> This will prevent SB_I_VERSION from being turned off at all. That
> will break existing filesystems that allow SB_I_VERSION to be turned
> off on remount, such as ext4.
> 
> The manipulations here need to be in the filesystem specific code;
> we screwed this one up so badly there is no "one size fits all"
> behaviour that we can implement in the generic code...

Yes.  SB_I_VERSION should never be set by common code.
