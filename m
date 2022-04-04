Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39F5B4F1B16
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Apr 2022 23:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379445AbiDDVTj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Apr 2022 17:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380149AbiDDTEi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Apr 2022 15:04:38 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D1D033E02
        for <linux-fsdevel@vger.kernel.org>; Mon,  4 Apr 2022 12:02:41 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 110771F43E62
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1649098959;
        bh=pugn5S7VdO0wPmpW5A+fiykzDKMwMJaojdp9rrctdjg=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=V2Mtng0FH8rgFWWh2tF4JhSoJ82sMvzu+bm6UN+TTwa8/krDm95V/KDoX/sqEkfft
         QCMMAT1Q4yX5U2de/zN7a1yvJIHiuhLFU2tmHhmyLaAdfQnEfo1aaWAvFRyNP91DEN
         WRohmDSKIJJlDbImVQuLO+ON8QHV/4Q043N2dKqvIPHrcUYpLGGCew20XIoUaKRGpr
         hXhRZfxH22JPIpPom7UKwwc/4nMe59mEwp1yqPsktf8HKLHEo8WvW9bvpvRCy9FmCO
         4urdTe/uKl/M/Szhsr4C3BspCP2djA4H5zxlma7rjlKK5Y44p8BWfWVwvGh3+AjCYu
         4A/OXHS8m9UeQ==
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Amir Goldstein <amir73il@gmail.com>, kernel@collabora.com,
        Khazhismel Kumykov <khazhy@google.com>,
        Linux MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH RESEND 2/3] shmem: Introduce /sys/fs/tmpfs support
Organization: Collabora
References: <20220404134137.26284-1-krisman@collabora.com>
        <20220404134137.26284-3-krisman@collabora.com>
        <Ykr6fmRjMwEhIjtk@zeniv-ca.linux.org.uk>
Date:   Mon, 04 Apr 2022 15:02:35 -0400
In-Reply-To: <Ykr6fmRjMwEhIjtk@zeniv-ca.linux.org.uk> (Al Viro's message of
        "Mon, 4 Apr 2022 14:02:38 +0000")
Message-ID: <87zgl0y8ms.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Al Viro <viro@zeniv.linux.org.uk> writes:

> On Mon, Apr 04, 2022 at 09:41:36AM -0400, Gabriel Krisman Bertazi wrote:
>> In order to expose tmpfs statistics on sysfs, add the boilerplate code
>> to create the /sys/fs/tmpfs structure.  As suggested on a previous
>> review, this uses the minor as the volume directory in /sys/fs/.
>> 
>> This takes care of not exposing SB_NOUSER mounts.  I don't think we have
>> a usecase for showing them and, since they don't appear elsewhere, they
>> might be confusing to users.
>> 
>> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
>
>> +static void shmem_unregister_sysfs(struct super_block *sb)
>> +{
>> +	struct shmem_sb_info *sbinfo = SHMEM_SB(sb);
>> +
>> +	kobject_del(&sbinfo->s_kobj);
>> +	kobject_put(&sbinfo->s_kobj);
>> +	wait_for_completion(&sbinfo->s_kobj_unregister);
>> +}
>
> If you embed kobject into something, you basically commit to
> having the lifetime rules maintained by that kobject...

Hi Viro,

The way I'm doing it seems to be a pattern used by at least Ext4, f2fs
and Btrfs. Is there a problem with embedding it in the superblock,
holding a reference and then waiting for completion when umounting the
fs?

-- 
Gabriel Krisman Bertazi
