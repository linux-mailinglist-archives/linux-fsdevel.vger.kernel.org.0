Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D418F13B20A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2020 19:25:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728801AbgANSZR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jan 2020 13:25:17 -0500
Received: from verein.lst.de ([213.95.11.211]:47259 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728779AbgANSZR (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jan 2020 13:25:17 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2D94A68AFE; Tue, 14 Jan 2020 19:25:14 +0100 (CET)
Date:   Tue, 14 Jan 2020 19:25:14 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Waiman Long <longman@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-ext4@vger.kernel.org, cluster-devel@redhat.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 02/12] locking/rwsem: Exit early when held by an
 anonymous owner
Message-ID: <20200114182514.GA9949@lst.de>
References: <20200114161225.309792-1-hch@lst.de> <20200114161225.309792-3-hch@lst.de> <925d1343-670e-8f92-0e73-6e9cee0d3ffb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <925d1343-670e-8f92-0e73-6e9cee0d3ffb@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 14, 2020 at 01:17:45PM -0500, Waiman Long wrote:
> The owner field is just a pointer to the task structure with the lower 3
> bits served as flag bits. Setting owner to RWSEM_OWNER_UNKNOWN (-2) will
> stop optimistic spinning. So under what condition did the crash happen?

When running xfstests with all patches in this series except for this
one, IIRC in generic/114.

> Anyway, PeterZ is working on revising the percpu-rwsem implementation to
> more gracefully handle the frozen case. At the end, there will not be a
> need for the RWSEM_OWNER_UNKNOWN magic and it can be removed.

Well, this series relies on that value.  And I think it fundamentally
is the right thing to do for AIO, and potentially other I/O related
locking where we take a lock to synchronize access to data, then
do I/O and then eventually get an I/O completion from an interrupt.
Even thinking from the PREEMP_RT context we want to boost the
initial thread as long as we can, then do nothing when it is off
to I/O hardware (except maybe providing good diagnostics that the cause
for the latency is I/O), and then boost the thread that is handling
the completion.  Things like the i_dio_count hack can't provide that.
