Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3839130F719
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Feb 2021 17:04:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237527AbhBDQBZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Feb 2021 11:01:25 -0500
Received: from mx2.suse.de ([195.135.220.15]:55876 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237277AbhBDPvQ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Feb 2021 10:51:16 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A3389ABD5;
        Thu,  4 Feb 2021 15:50:32 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 6FA4BDA849; Thu,  4 Feb 2021 16:48:41 +0100 (CET)
Date:   Thu, 4 Feb 2021 16:48:41 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     "fdmanana@gmail.com" <fdmanana@gmail.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>,
        "hare@suse.com" <hare@suse.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v15 41/42] btrfs: zoned: reorder log node allocation on
 zoned filesystem
Message-ID: <20210204154841.GG1993@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "fdmanana@gmail.com" <fdmanana@gmail.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>, "hare@suse.com" <hare@suse.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>
References: <492da9326ecb5f888e76117983603bb502b7b589.1612434091.git.naohiro.aota@wdc.com>
 <CAL3q7H7mzAngA8SF13+FOgVserhF3iyA2a8tggYuO+qi+woLOw@mail.gmail.com>
 <SN4PR0401MB3598B6C1AAF3CEA92E167AE89BB39@SN4PR0401MB3598.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN4PR0401MB3598B6C1AAF3CEA92E167AE89BB39@SN4PR0401MB3598.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 04, 2021 at 02:54:25PM +0000, Johannes Thumshirn wrote:
> On 04/02/2021 12:57, Filipe Manana wrote:
> > On Thu, Feb 4, 2021 at 10:23 AM Naohiro Aota <naohiro.aota@wdc.com> wrote:
> >> --- a/fs/btrfs/tree-log.c
> >> +++ b/fs/btrfs/tree-log.c
> >> @@ -3159,6 +3159,19 @@ int btrfs_sync_log(struct btrfs_trans_handle *trans,
> >>         list_add_tail(&root_log_ctx.list, &log_root_tree->log_ctxs[index2]);
> >>         root_log_ctx.log_transid = log_root_tree->log_transid;
> >>
> >> +       if (btrfs_is_zoned(fs_info)) {
> >> +               mutex_lock(&fs_info->tree_log_mutex);
> >> +               if (!log_root_tree->node) {
> > 
> > As commented in v14, the log root tree is not protected by
> > fs_info->tree_log_mutex anymore.
> > It is fs_info->tree_root->log_mutex as of 5.10.
> > 
> > Everything else was addressed and looks good.
> > Thanks.
> 
> David, can you add this or should we send an incremental patch?
> This survived fstests -g quick run with lockdep enabled.
> 
> diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
> index 7ba044bfa9b1..36c4a60d20dc 100644
> --- a/fs/btrfs/tree-log.c
> +++ b/fs/btrfs/tree-log.c
> @@ -3160,7 +3160,7 @@ int btrfs_sync_log(struct btrfs_trans_handle *trans,
>         root_log_ctx.log_transid = log_root_tree->log_transid;
>         if (btrfs_is_zoned(fs_info)) {
> -               mutex_lock(&fs_info->tree_log_mutex);
> +               mutex_lock(&fs_info->tree_root->log_mutex);
>                 if (!log_root_tree->node) {
>                         ret = btrfs_alloc_log_tree_node(trans, log_root_tree);
>                         if (ret) {
> @@ -3169,7 +3169,7 @@ int btrfs_sync_log(struct btrfs_trans_handle *trans,
>                                 goto out;
>                         }
>                 }
> -               mutex_unlock(&fs_info->tree_log_mutex);
> +               mutex_unlock(&fs_info->tree_root->log_mutex);

Folded to the patch, thanks.
