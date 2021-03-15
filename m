Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0299733C5E5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Mar 2021 19:40:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbhCOSkZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Mar 2021 14:40:25 -0400
Received: from zeniv-ca.linux.org.uk ([142.44.231.140]:47458 "EHLO
        zeniv-ca.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbhCOSj7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Mar 2021 14:39:59 -0400
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lLs1e-006J21-Od; Mon, 15 Mar 2021 18:33:10 +0000
Date:   Mon, 15 Mar 2021 18:33:10 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Lee Duncan <lduncan@suse.com>, Chris Leech <cleech@redhat.com>,
        Adam Nichols <adam@grimm-co.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] seq_file: Unconditionally use vmalloc for buffer
Message-ID: <YE+oZkSVNyaONMd9@zeniv-ca.linux.org.uk>
References: <20210315174851.622228-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210315174851.622228-1-keescook@chromium.org>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 15, 2021 at 10:48:51AM -0700, Kees Cook wrote:
> The sysfs interface to seq_file continues to be rather fragile, as seen
> with some recent exploits[1]. Move the seq_file buffer to the vmap area
> (while retaining the accounting flag), since it has guard pages that
> will catch and stop linear overflows. This seems justified given that
> seq_file already uses kvmalloc(), is almost always using a PAGE_SIZE or
> larger allocation, has allocations are normally short lived, and is not
> normally on a performance critical path.

You are attacking the wrong part of it.  Is there any reason for having
seq_get_buf() public in the first place?

For example, the use in blkcg_print_stat() is entirely due to the bogus
->pd_stat_fn() calling conventions.  Fuck scnprintf() games, just pass
seq_file to ->pd_stat_fn() and use seq_printf() instead.  Voila - no
seq_get_buf()/seq_commit()/scnprintf() garbage.

tegra use is no better, AFAICS.  inifinibarf one...  allow me to quote
that gem in full:
static int _driver_stats_seq_show(struct seq_file *s, void *v)
{
        loff_t *spos = v;
        char *buffer;
        u64 *stats = (u64 *)&hfi1_stats;
        size_t sz = seq_get_buf(s, &buffer);

        if (sz < sizeof(u64))
                return SEQ_SKIP;
        /* special case for interrupts */
        if (*spos == 0)
                *(u64 *)buffer = hfi1_sps_ints();
        else
                *(u64 *)buffer = stats[*spos];
        seq_commit(s,  sizeof(u64));
        return 0;
}
Yes, really.  Not to mention that there's seq_write(), what the _hell_
is it using seq_file for in the first place?  Oh, and hfi_stats is
actually this:
struct hfi1_ib_stats {
        __u64 sps_ints; /* number of interrupts handled */
        __u64 sps_errints; /* number of error interrupts */
        __u64 sps_txerrs; /* tx-related packet errors */
        __u64 sps_rcverrs; /* non-crc rcv packet errors */
        __u64 sps_hwerrs; /* hardware errors reported (parity, etc.) */
        __u64 sps_nopiobufs; /* no pio bufs avail from kernel */
        __u64 sps_ctxts; /* number of contexts currently open */
        __u64 sps_lenerrs; /* number of kernel packets where RHF != LRH len */
        __u64 sps_buffull;
        __u64 sps_hdrfull;
};
I won't go into further details - CDA might be dead and buried, but there
should be some limit to public obscenity ;-/

procfs use is borderline - it looks like there might be a good cause
for seq_escape_str().

And sysfs_kf_seq_show()...  Do we want to go through seq_file there at
all?
