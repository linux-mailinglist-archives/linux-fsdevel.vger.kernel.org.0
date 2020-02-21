Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 758CC168552
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2020 18:44:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728071AbgBURox (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Feb 2020 12:44:53 -0500
Received: from verein.lst.de ([213.95.11.211]:56731 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725947AbgBURow (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Feb 2020 12:44:52 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id BAE0A68BFE; Fri, 21 Feb 2020 18:44:49 +0100 (CET)
Date:   Fri, 21 Feb 2020 18:44:49 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     ira.weiny@intel.com
Cc:     linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH V4 07/13] fs: Add locking for a dynamic address space
 operations state
Message-ID: <20200221174449.GB11378@lst.de>
References: <20200221004134.30599-1-ira.weiny@intel.com> <20200221004134.30599-8-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200221004134.30599-8-ira.weiny@intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 20, 2020 at 04:41:28PM -0800, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> DAX requires special address space operations (aops).  Changing DAX
> state therefore requires changing those aops.
> 
> However, many functions require aops to remain consistent through a deep
> call stack.
> 
> Define a vfs level inode rwsem to protect aops throughout call stacks
> which require them.
> 
> Finally, define calls to be used in subsequent patches when aops usage
> needs to be quiesced by the file system.

I am very much against this.  There is a reason why we don't support
changes of ops vectors at runtime anywhere else, because it is
horribly complicated and impossible to get right.  IFF we ever want
to change the DAX vs non-DAX mode (which I'm still not sold on) the
right way is to just add a few simple conditionals and merge the
aops, which is much easier to reason about, and less costly in overall
overhead.
