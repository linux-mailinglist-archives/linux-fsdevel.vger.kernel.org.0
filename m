Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 566E4166407
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2020 18:09:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728506AbgBTRJ6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Feb 2020 12:09:58 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:41228 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728173AbgBTRJ5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Feb 2020 12:09:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Z5evHnyRyXOCbcZF533zb10Dy1PCcLpiWvdEXqQf2Rw=; b=GsDcOSs+fxjgzm1n8eT9tSajrR
        gHDFxhUdt0YA7MRWhW/IDERkWNTvNIBpoftja/F4p9WHvuXYQCKMcA8HE7tQ/R0Xe4ciCl6rjHgPZ
        VTdJ5qya7FlldhQ5nN1RDElvkAPoLvVANGhpb3rVSWct9wywWPAvudjdgR0lZlxJ/Oea8uUvuF3Ui
        9nDOdTi27q+i1SUL/cxFuqlXny6fm3Fb+yN+xtmFG4mFIzt5OWWZhEhlLjvMQ0RANsMd8fi92PNf/
        S2aWrJkDu8M4IMj26v48alpS22yFW9mXsSMQ8Oku5vxP2rZNCtCzjByOVRtl8he6iC+fdqDlwVzPM
        I2IaJGzA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j4pKj-0003TN-72; Thu, 20 Feb 2020 17:09:53 +0000
Date:   Thu, 20 Feb 2020 09:09:53 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     Jan Kara <jack@suse.cz>,
        "Darrick J. Wong" <darrick.wong@oracle.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, hch@infradead.org,
        cmaiolino@redhat.com
Subject: Re: [RFCv2 0/4] ext4: bmap & fiemap conversion to use iomap
Message-ID: <20200220170953.GA11221@infradead.org>
References: <cover.1580121790.git.riteshh@linux.ibm.com>
 <20200130160018.GC3445353@magnolia>
 <20200205124750.AE9DDA404D@d06av23.portsmouth.uk.ibm.com>
 <20200205155733.GH6874@magnolia>
 <20200206052619.D4BBCA405F@b06wcsmtp001.portsmouth.uk.ibm.com>
 <20200206102254.GK14001@quack2.suse.cz>
 <20200220170304.80C3E52051@d06av21.portsmouth.uk.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200220170304.80C3E52051@d06av21.portsmouth.uk.ibm.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 20, 2020 at 10:33:03PM +0530, Ritesh Harjani wrote:
> So I was making some changes along the above lines and I think we can take
> below approach for filesystem which could determine the
> _EXTENT_LAST relatively easily and for cases if it cannot
> as Jan also mentioned we could keep the current behavior as is and let
> iomap core decide the last disk extent.

Well, given that _EXTENT_LAST never worked properly on any file system
since it was added this actually changes behavior and could break
existing users.  I'd rather update the documentation to match reality
rather than writing a lot of code for a feature no one obviously cared
about for years.
