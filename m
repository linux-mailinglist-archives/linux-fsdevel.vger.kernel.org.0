Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C37533BA102
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Jul 2021 15:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232502AbhGBNQV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Jul 2021 09:16:21 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:40717 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231743AbhGBNQU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Jul 2021 09:16:20 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 162DDKDI002165
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 2 Jul 2021 09:13:21 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id AE97615C3CE4; Fri,  2 Jul 2021 09:13:20 -0400 (EDT)
Date:   Fri, 2 Jul 2021 09:13:20 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Guoqing Jiang <guoqing.jiang@linux.dev>
Cc:     Sachin Sant <sachinp@linux.vnet.ibm.com>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, yi.zhang@huawei.com, jack@suse.cz
Subject: Re: [powerpc][5.13.0-next-20210701] Kernel crash while running
 ltp(chdir01) tests
Message-ID: <YN8Q8O3W5u8iYSQr@mit.edu>
References: <26ACA75D-E13D-405B-9BFC-691B5FB64243@linux.vnet.ibm.com>
 <bf1c5b38-92f1-65db-e210-a97a199718ba@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bf1c5b38-92f1-65db-e210-a97a199718ba@linux.dev>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 02, 2021 at 05:38:10PM +0800, Guoqing Jiang wrote:
> 
> 
> I guess the problem is j_jh_shrink_count was destroyed in ext4_put_super _> 
> jbd2_journal_unregister_shrinker
> which is before the path ext4_put_super -> jbd2_journal_destroy ->
> jbd2_log_do_checkpoint to call
> percpu_counter_dec(&journal->j_jh_shrink_count).
> 
> And since jbd2_journal_unregister_shrinker is already called inside
> jbd2_journal_destroy, does it make sense
> to do this?
> 
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -1176,7 +1176,6 @@ static void ext4_put_super(struct super_block *sb)
>         ext4_unregister_sysfs(sb);
> 
>         if (sbi->s_journal) {
> -               jbd2_journal_unregister_shrinker(sbi->s_journal);
>                 aborted = is_journal_aborted(sbi->s_journal);
>                 err = jbd2_journal_destroy(sbi->s_journal);
>                 sbi->s_journal = NULL;

Good catch.  There's another place where we call
jbd2_journal_unregister_shrinker(), in the failure path for
ext4_fill_super().

					- Ted

P.S.  Whatever outgoing mailer you are using, it's not preserving TAB
characters correctly.  You might want to look into that before trying
to submit a patch.
