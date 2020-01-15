Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F052613B9EA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2020 07:49:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729187AbgAOGsb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jan 2020 01:48:31 -0500
Received: from verein.lst.de ([213.95.11.211]:49190 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729103AbgAOGsb (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jan 2020 01:48:31 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7952D68AFE; Wed, 15 Jan 2020 07:48:27 +0100 (CET)
Date:   Wed, 15 Jan 2020 07:48:27 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Christoph Hellwig <hch@lst.de>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-ext4@vger.kernel.org, cluster-devel@redhat.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 08/12] ext4: hold i_rwsem until AIO completes
Message-ID: <20200115064827.GA21176@lst.de>
References: <20200114161225.309792-1-hch@lst.de> <20200114161225.309792-9-hch@lst.de> <20200114215023.GH140865@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200114215023.GH140865@mit.edu>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 14, 2020 at 04:50:23PM -0500, Theodore Y. Ts'o wrote:
> I note that you've dropped the inode_dio_wait() in ext4's ZERO_RANGE,
> COLLAPSE_RANGE, INSERT_RANGE, etc.  We had added these to avoid
> problems when various fallocate operations which modify the inode's
> logical->physical block mapping racing with direct I/O (both reads or
> writes).
> 
> I don't see a replacement protection in this patch series.  How does
> are file systems supported to protect against such races?

By holding i_rwsem until the direct I/O operations are finished, and
not just until they are sumbitted.
